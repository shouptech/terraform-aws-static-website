# Website

A module to create a static website hosted on S3 and served via Cloudfront. This module is not to be applied directly.
See the examples in the `application` folder.

## Variables

See `variables.tf` for a description of all input variables.

## Outputs

See `outputs.tf` for a description of all output variables.

## Example

```hcl
module "website" {
  source = "../../modules/website"

  zone_name   = "website.example.com"
  bucket_name = "website-bucket"
  site_fqdn   = "prod.website.example.com"
}
```
