# Terraform Static Website Example

This project contains example code for building a static website using Cloudfront and Terraform.

## Layout

```text
.
├── application # These are the modules you run terraform apply
│   ├── frontend # Creates a static website, run _after_ route53
│   └── route53 # Creates a route53 zone, run _before_ frontend
└── modules
    ├── route53-zone # A module to create a route 53 hosted zone
    ├── s3-bucket # A module for creating S3 buckets
    └── website # A module to create a static website
```

## Requirements

* Terraform v1.3.8 installed. Optionally, use a tool like tfenv to manage the version of Terraform used.
* AWS CLI configured with an access key pair that has administrator privileges.
* An S3 bucket to store the terraform state.

## Usage

In the `application` folder there are two modules that can be used to create the resources in this example.

* `route53` - This creates a simple route53 hosted zone. The output of the module includes a list of name servers.
   *IMPORTANT* You must create NS records in this hosted zone in your DNS provider.
* `frontend` - This creates a static website using the modules in this project. You must have a valid route53 hosted
   zone. The `route53` module can be used to create one, and must be applied before the `frontend` module.

To apply each module:

1. Copy `example.tfvars` to a new file ending in `.auto.tfvars`. Update the values in this file to match the environment.
2. Copy `example.s3.tfbackend` to a new file. Update the values to match your desired S3 backend configuration.
3. Run `terraform init -backend-config=./my.s3.backend` where `my.s3.tfbackend` is the file created in step 2.
4. Run `terraform apply` and watch your resources get created.

## Potential Improvements

* Use a terraform wrapper, such as [Terragrunt](https://terragrunt.gruntwork.io/) to assist with module dependencies,
   sharing variables between modules, and to help keep the configurations DRY and maintainable.
* Use a tool such as [Terrascan](https://runterrascan.io/) to identify problematic and potentially insecure
   configurations in the created modules.
* The route53 could be updated to create the NS records as well. This greatly depends on what is currently hosting DNS
   for the zone. For example, if the domain is on Cloudflare, the Cloudflare provider could be used to create the
   appropriate NS records.
