terraform {
  backend "s3" {
    bucket         = "security-compliance-tfstate"
    key            = "OT-367/OT-406/terraform/terraform.tfstate"
    region         = "eu-west-2"
    profile        = "Domotz"
    encrypt        = true
    dynamodb_table = "operations-tfstate-lock" 
  }

  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.90"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  profile                  = var.aws_profile
  shared_credentials_files = [var.shared_credentials_files]
}