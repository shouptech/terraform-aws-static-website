terraform {
  required_version = "~> 1.3.0"

  backend "s3" {
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  # Region is hard-coded to us-east-1, as Cloudfront is managed through this region.
  # Furthermore, some resources, such as ACM certificates, must be created in us-east-1
  # in order to interact with Cloudfront.
  region = "us-east-1"

  default_tags {
    tags = {
      Provisioner = "Terraform"
      Environment = var.environment
    }
  }
}
