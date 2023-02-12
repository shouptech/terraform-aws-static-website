variable "name" {
  description = "Name of ACL to create"
  type        = string
}

variable "description" {
  description = "Optional description of ACL"
  type        = string
  default     = null
}

variable "scope" {
  description = <<-EOT
    Specifies whether this is for an AWS CloudFront distribution or for a regional application. Must be one of
    CLOUDFRONT or REGIONAL. If CLOUDFRONT, must be created in us-east-1.
  EOT
  type        = string
  default     = "REGIONAL"
}

variable "cloudwatch_metrics_enabled" {
  description = "Whether or not to send metrics to CloudWatch."
  type        = bool
  default     = true
}

variable "cloudwatch_metrics_rules_prefix" {
  description = <<-EOT
    Prefix for friendly name of CloudWatch metric. The name can contain only alphanumeric characters (A-Z, a-z, 0-9)
    hyphen(-) and underscore (_), with length from one to 128 characters.
  EOT
  type        = string
  default     = "WAFv2_Metrics"
}

variable "sampled_requests_enabled" {
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules."
  type        = bool
  default     = true
}
