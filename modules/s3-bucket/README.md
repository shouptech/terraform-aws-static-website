# S3 Bucket

A module to create a new S3 bucket. This module is not to be applied directly. See the examples in the `application` folder.

## Variables

See `variables.tf` for a description of all input variables.

## Outputs

See `outputs.tf` for a description of all output variables.

## Example

```hcl
module "bucket" {
  source = "../../modules/s3-bucket"

  bucket_name = "my-awesome-bucket
}
```
