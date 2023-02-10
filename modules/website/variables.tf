################################################################################
# S3 Variables
################################################################################

variable "bucket_name" {
  description = "Name of S3 bucket to store website"
  type        = string
}

variable "access_logs_bucket_name" {
  description = "Optional variable. Name of bucket for cloudfront access logs."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Wether or not to delete all objects in created S3 buckets. This should be false if these resources should be protected."
  type        = bool
  default     = true
}

################################################################################
# Route53 Variables
################################################################################

variable "zone_name" {
  description = "Name of route53 zone that has already been created."
  type        = string
}

################################################################################
# Cloudfront Variables
################################################################################

variable "site_fqdn" {
  description = "FQDN to access site. Must be a part of the route53 zone specified in `zone_name`."
  type        = string
}

variable "default_root_object" {
  description = "Default root object for Cloudfront to load"
  type        = string
  default     = "index.html"
}

variable "is_ipv6_enabled" {
  description = "Wether or not IPv6 should be enabled."
  type        = bool
  default     = true
}

variable "logging_include_cookies" {
  description = "Specifies whether you want CloudFront to include cookies in access logs"
  type        = bool
  default     = false
}

variable "price_class" {
  description = "The price class for this distribution. One of `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
  type        = string
  default     = "PriceClass_100"
}

variable "allowed_methods" {
  description = "Methods allowed in cloudfront distribution"
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cached_methods" {
  description = "Methods to cache"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "viewer_protocol_policy" {
  description = "Protocol that users can use to access the files in the origin. One of allow-all, https-only, or redirect-to-https."
  type        = string
  default     = "redirect-to-https"
}

variable "cache_min_ttl" {
  description = "Minimum TTL for objects in cache."
  type        = number
  default     = 0
}

variable "cache_default_ttl" {
  description = "Default TTL for objects in cache."
  type        = number
  default     = 3600
}

variable "cache_max_ttl" {
  description = "Maximum TTL for objects in cache."
  type        = number
  default     = 86400
}

################################################################################
# Alerting Variables
################################################################################

variable "alarm_emails" {
  description = "List of email addresses to send cloudwatch alarms to. Can be an empty list."
  type        = list(string)
  default     = []
}

variable "alarm_topic_name" {
  description = "Name of SNS topic to create for alarms. If not provided, alarms will not have actions."
  type        = string
  default     = null
}

variable "alarm_4xx_evaluation_periods" {
  description = "High 4xx Error Rate - The number of periods over which data is compared to the specified threshold."
  type        = number
  default     = 1
}

variable "alarm_4xx_period" {
  description = "High 4xx Error Rate - The period in seconds over which the specified statistic is applied."
  type        = number
  default     = 60
}

variable "alarm_4xx_statistic" {
  description = "High 4xx Error Rate - The statistic to apply to the alarm's associated metric."
  type        = string
  default     = "Average"
}

variable "alarm_4xx_threshold" {
  description = "High 4xx Error Rate - The value against which the specified statistic is compared."
  type        = number
  default     = 5
}

variable "alarm_5xx_evaluation_periods" {
  description = "High 5xx Error Rate - The number of periods over which data is compared to the specified threshold."
  type        = number
  default     = 1
}

variable "alarm_5xx_period" {
  description = "High 5xx Error Rate - The period in seconds over which the specified statistic is applied."
  type        = number
  default     = 60
}

variable "alarm_5xx_statistic" {
  description = "High 5xx Error Rate - The statistic to apply to the alarm's associated metric."
  type        = string
  default     = "Average"
}

variable "alarm_5xx_threshold" {
  description = "High 5xx Error Rate - The value against which the specified statistic is compared."
  type        = number
  default     = 5
}
