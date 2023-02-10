terraform {
  required_version = "= 1.3.8"

  backend "s3" {
    # Configure by providing a backend config as a file, or as a CLI argument during `terraform init`.
    # See https://developer.hashicorp.com/terraform/language/settings/backends/configuration#partial-configuration
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
