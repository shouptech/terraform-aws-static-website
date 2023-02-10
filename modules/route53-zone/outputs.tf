output "zone_id" {
  description = "ID of the created route53 zone"
  value       = aws_route53_zone.this.id
}

output "name" {
  description = "Name of the created route53 zone"
  value       = aws_route53_zone.this.name
}

output "name_servers" {
  description = "Name servers of the created route53 zone"
  value       = aws_route53_zone.this.name_servers
}
