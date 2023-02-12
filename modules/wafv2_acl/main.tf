resource "aws_wafv2_web_acl" "acl" {
  name        = var.name
  description = var.description
  scope       = var.scope

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
    metric_name                = "${var.cloudwatch_metrics_rules_prefix}_Default"
    sampled_requests_enabled   = var.sampled_requests_enabled
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
      metric_name                = "${var.cloudwatch_metrics_rules_prefix}_Rule_1"
      sampled_requests_enabled   = var.sampled_requests_enabled
    }
  }
}
