# Route53

An example module for building a route53 zone using the modules contained in the repository.

This must be created _before_ the frontend application is created.

## Requirements

* Terraform v1.3.8 installed. Optionally, use a tool like tfenv to manage the version of Terraform used.
* AWS CLI configured with an access key pair that has administrator privileges.
* An S3 bucket to store the terraform state.

## Usage

1. Copy `example.tfvars` to a new file ending in `.auto.tfvars`. Update the values in this file to match the environment.
2. Copy `example.s3.tfbackend` to a new file. Update the values to match your desired S3 backend configuration.
3. Run `terraform init -backend-config=./my.s3.backend` where `my.s3.tfbackend` is the file created in step 2.
4. Run `terraform apply` and watch your resources get created.
