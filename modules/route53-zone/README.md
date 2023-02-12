# Route53 Zone

A module to create a new route 53 zone. This module is not to be applied directly. See the examples in the
`application` folder.

## Variables

See `variables.tf` for a description of all input variables.

## Outputs

See `outputs.tf` for a description of all output variables.

## Example

```hcl
module "route53" {
  source    = "../../modules/route53-zone"
  zone_name = "website.example.com"
}
```
