module "waf_acl" {
  source = "../../modules/wafv2_acl"

  name                            = var.acl_name
  scope                           = "CLOUDFRONT"
  cloudwatch_metrics_rules_prefix = var.acl_name
}

module "website" {
  source = "../../modules/website"

  zone_name = var.zone_name

  # This sets the bucket_name to be the same as site_fqdn. This can be changed if needed.
  bucket_name = var.site_fqdn
  site_fqdn   = var.site_fqdn

  alarm_topic_name = var.alarm_topic_name
  alarm_emails     = var.alarm_emails

  web_acl_id = module.waf_acl.arn
}
