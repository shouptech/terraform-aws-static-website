terraform {
  # Module was tested using Terraform 1.3.8. Other versions probably still work.
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}
