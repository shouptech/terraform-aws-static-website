variable "aws_region" {
  description = "Region for your AWS resources"
  type        = string

  # Default to us-east-1 as route53 is a global service
  default = "us-east-1"
}

variable "zone_name" {
  description = "Name of route53 zone to create"
  type        = string
}

