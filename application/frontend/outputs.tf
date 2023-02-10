output "site_address" {
  description = "URL of the freshly created website"
  value       = "https://${var.site_fqdn}"
}

output "cloudfront_distribution_id" {
  description = "ID of the cloudfront distribution"
  value       = module.website.cloudfront_distribution_arn
}

output "logging_bucket_id" {
  description = "ID of S3 Bucket for cloudfront logs"
  value       = module.website.logging_bucket_id
}

output "website_bucket_id" {
  description = "ID of S3 Bucket for the website"
  value       = module.website.website_bucket_id
}
