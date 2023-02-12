# WAFv2 ACL

A module to create a new AWS WAFv2 Web ACL. This ACL can then be used in resources,
such as CloudFront.

This module creates a WAFv2 ACL that implements the standard WSManagedRulesCommonRuleSet.

## Variables

See `variables.tf` for a description of all input variables.

## Outputs

See `outputs.tf` for a description of all output variables.

## Example

```hcl
module "waf" {
  source    = "../../modules/wafv2_acl"

  name                            = "my_acl"
  scope                           = "CLOUDFRONT"
  cloudwatch_metrics_rules_prefix = "my_acl_metrics
}
```
