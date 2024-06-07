locals {
  project_common_name = "Snowflake-Glue-Jobs"
}

data "aws_caller_identity" "current" {}

terraform {
  required_version = "~> 1.3"

  backend "local" {
    path = "./terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Component   = var.component
      Environment = var.aws_account
      Owner       = var.owner
    }
  }
}