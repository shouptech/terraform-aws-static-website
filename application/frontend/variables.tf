variable "zone_name" {
  description = "Name of route53 zone that has already been created."
  type        = string
}

variable "site_fqdn" {
  description = "FQDN to access site. Must be a part of the route53 zone specified in `zone_name`."
  type        = string
}

variable "alarm_topic_name" {
  description = "Name of alarm topic to create"
  type        = string
}

variable "alarm_emails" {
  description = "List of emails that alarm notifications should be sent to."
  type        = list(string)
}

variable "environment" {
  description = "Value of Environment tag for resources."
  type        = string
}

variable "acl_name" {
  description = "Name of WAF ACL to create"
  type        = string
}
