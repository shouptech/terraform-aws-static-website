# Website

A module to create a static website hosted on S3 and served via Cloudfront. This module is not to be applied directly.
See the examples in the `application` folder.

## Resources Created

This module will create resources for the following:

* S3 Buckets for the static assets, as well as access logs (uses the
  [s3-bucket](../s3-bucket/) module). The buckets are created with policies that block
  public access.
* An ACM certificate used for providing SSL to the CDN.
* A CloudFront distribution (CDN) to serve the assets. Policies and identities are
  created that allow this distribution access to the static assets bucket. Logs are sent
  to the access logging bucket. Furthermore, an optional WAF ACL can be applied.
* An example index.html file is copied to the CDN as an example that it works. Changes
  on this file are ignored, allowing end users to update the static assets in the S3
  bucket without a Terraform apply clobbering the changes.
* A Route 53 record pointing to the newly created CDN.
* CloudWatch Metrics for high 4xx and 5xx error rates.
* An SNS topic with optional email subscriptions that the CloudWatch metrics send use
  for alarming.

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
