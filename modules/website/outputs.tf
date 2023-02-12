output "acm_certificate_arn" {
  description = "ARN of the generated ACM certificate"
  value       = aws_acm_certificate.website.arn
}

output "website_bucket_id" {
  description = "ID of S3 Bucket for website"
  value       = module.website_bucket.id
}

output "website_bucket_arn" {
  description = "ARN of S3 Bucket for website"
  value       = module.website_bucket.arn
}

output "logging_bucket_id" {
  description = "ID of S3 Bucket for cloudfront logs"
  value       = module.logging_bucket.id
}

output "logging_bucket_arn" {
  description = "ARN of S3 Bucket for cloudfront logs"
  value       = module.logging_bucket.arn
}

output "cloudfront_distribution_id" {
  description = "ID of cloudfront distribution"
  value       = aws_cloudfront_distribution.website.id
}

output "cloudfront_distribution_arn" {
  description = "ARN of cloudfront distribution"
  value       = aws_cloudfront_distribution.website.arn
}

output "alarm_topic_arn" {
  description = "ARN of the created SNS topic"
  value       = var.alarm_topic_name != null ? aws_sns_topic.alarms[0].arn : null
}
