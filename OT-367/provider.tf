terraform {
  backend "s3" {
    bucket  = "amohammadpour-terraform-tfstate"
    key     = "OT-367/terraform/terraform.tfstate"
    region  = "eu-west-2"
    profile = "Domotz"
    encrypt = true
    # dynamodb_table = "amohammadpour-tfstate-lock"  # optional
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.90.1"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  profile                  = var.aws_profile
  shared_credentials_files = [var.shared_credentials_files]
}
