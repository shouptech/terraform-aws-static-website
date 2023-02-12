output "arn" {
  description = "ARN of the WAF WebACL"
  value       = aws_wafv2_web_acl.acl.arn
}

output "capacity" {
  description = "Web ACL capacity units (WCUs) currently being used by this web ACL."
  value       = aws_wafv2_web_acl.acl.capacity
}

output "id" {
  description = "The ID of the WAF WebACL."
  value       = aws_wafv2_web_acl.acl.id
}
