output "id" {
  description = "ID of created bucket"
  value       = aws_s3_bucket.this.id
}

output "arn" {
  description = "ARN of created bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_regional_domain_name" {
  description = "Regional domain for the bucket."
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
