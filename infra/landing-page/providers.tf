terraform {
  required_version = ">= 1.10.0, <2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "terraform-divemapio-remote-backend"
    key    = "landing-page/state.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      ManagedBy = "Terraform"
    }
  }
}