################################################################################
# Data sources
################################################################################

data "aws_route53_zone" "website" {
  name = var.zone_name
}

################################################################################
# Create ACM Certificate
################################################################################
resource "aws_acm_certificate" "website" {
  domain_name       = var.site_fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.website.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.website.zone_id
}

resource "aws_acm_certificate_validation" "website" {
  certificate_arn         = aws_acm_certificate.website.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}

################################################################################
# Create S3 Buckets and Bucket Policies
################################################################################

locals {
  log_bucket_name = var.access_logs_bucket_name != null ? var.access_logs_bucket_name : "${var.bucket_name}-access-logs"
}

module "website_bucket" {
  source = "../s3-bucket"

  bucket_name   = var.bucket_name
  force_destroy = var.force_destroy
}

module "logging_bucket" {
  source = "../s3-bucket"

  bucket_name   = local.log_bucket_name
  force_destroy = var.force_destroy
}

resource "aws_s3_object" "example_index" {
  count = var.copy_example_index ? 1 : 0

  lifecycle {
    # Ignore changes to this resource as it's only an example file.
    ignore_changes = all
  }

  key          = "index.html"
  content_type = "text/html"
  bucket       = module.website_bucket.id
  source       = "${path.module}/external/index.html"
}

################################################################################
# Create CloudFront Distribution and Route53 Records
################################################################################
locals {
  s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_origin_access_identity" "website" {}

# Create policy to allow cloudfront access to S3 bucket
data "aws_iam_policy_document" "website" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.website_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.website.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = module.website_bucket.id
  policy = data.aws_iam_policy_document.website.json
}

resource "aws_cloudfront_distribution" "website" {
  # Creation may fail if the certificate has not yet been validated.
  depends_on = [
    aws_acm_certificate_validation.website
  ]

  enabled             = true
  is_ipv6_enabled     = var.is_ipv6_enabled
  default_root_object = var.default_root_object

  web_acl_id = var.web_acl_id

  logging_config {
    include_cookies = var.logging_include_cookies
    bucket          = module.logging_bucket.bucket_regional_domain_name
    prefix          = var.site_fqdn
  }

  aliases = [var.site_fqdn]

  price_class = var.price_class

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.cache_min_ttl
    default_ttl            = var.cache_default_ttl
    max_ttl                = var.cache_max_ttl
  }

  origin {
    domain_name = module.website_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.website.cloudfront_access_identity_path
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.website.arn
    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_route53_record" "website" {
  zone_id = data.aws_route53_zone.website.id
  name    = var.site_fqdn
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = true
  }
}

################################################################################
# Create CloudWatch Alarms and associated SNS topic
################################################################################
resource "aws_sns_topic" "alarms" {
  count = var.alarm_topic_name != null ? 1 : 0

  name = var.alarm_topic_name
}

resource "aws_sns_topic_subscription" "alarm_subscription" {
  count = var.alarm_topic_name != null ? length(var.alarm_emails) : 0

  topic_arn = aws_sns_topic.alarms[0].arn
  protocol  = "email"
  endpoint  = var.alarm_emails[count.index]
}

resource "aws_cloudwatch_metric_alarm" "error_rate_4xx" {
  alarm_name          = "${var.site_fqdn}-High-4xx-Error-Rate"
  namespace           = "AWS/CloudFront"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = var.alarm_datapoints_to_alarm
  evaluation_periods  = var.alarm_4xx_evaluation_periods
  metric_name         = "4xxErrorRate"
  period              = var.alarm_4xx_period
  statistic           = var.alarm_4xx_statistic
  threshold           = 5
  treat_missing_data  = "notBreaching"
  actions_enabled     = var.alarm_topic_name != null ? true : false
  alarm_actions       = var.alarm_topic_name != null ? [aws_sns_topic.alarms[0].arn] : []
  ok_actions          = var.alarm_topic_name != null ? [aws_sns_topic.alarms[0].arn] : []

  dimensions = {
    DistributionId = aws_cloudfront_distribution.website.id
    Region         = "Global"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_rate_5xx" {
  alarm_name          = "${var.site_fqdn}-High-5xx-Error-Rate"
  namespace           = "AWS/CloudFront"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = var.alarm_datapoints_to_alarm
  evaluation_periods  = var.alarm_5xx_evaluation_periods
  metric_name         = "5xxErrorRate"
  period              = var.alarm_5xx_period
  statistic           = var.alarm_5xx_statistic
  threshold           = 5
  treat_missing_data  = "notBreaching"
  actions_enabled     = var.alarm_topic_name != null ? true : false
  alarm_actions       = var.alarm_topic_name != null ? [aws_sns_topic.alarms[0].arn] : []
  ok_actions          = var.alarm_topic_name != null ? [aws_sns_topic.alarms[0].arn] : []

  dimensions = {
    DistributionId = aws_cloudfront_distribution.website.id
    Region         = "Global"
  }
}
