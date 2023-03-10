variable "bucket_name" {
  description = "Name of bucket to create"
  type        = string
}

variable "force_destroy" {
  description = "whether or not to force destroy this bucket."
  type        = bool
  default     = false
}

variable "block_public_acls" {
  description = "whether or not to block public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "whether or not to block public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "whether or not to ignore public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "whether or not to public buckets should be restricted."
  type        = bool
  default     = true
}
