terraform {
  required_version = ">= 1.10.0, <2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.0.0-alpha1"
    }
  }
}

################################################################################
# AWS provider
################################################################################

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

################################################################################
# Cloudflare provider
################################################################################

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

################################################################################
# Cloudflare DNS
################################################################################
data "cloudflare_zone" "main" {
  filter = {
    name = "divemap.io"
  }
}

resource "cloudflare_dns_record" "divemap_io" {
  zone_id = data.cloudflare_zone.main.id
  name    = "divemap.io"
  content = module.static_website_divemap_io.static_website_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "app_divemap_io" {
  zone_id = data.cloudflare_zone.main.id
  name    = "app"
  content = module.static_website_app_divemap_io.static_website_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

################################################################################
# divemap.io website
################################################################################
module "static_website_divemap_io" {
  source = "./static-s3-website"

  domain_name            = var.landing_page_website_domain_name
  static_page_files_path = var.landing_page_files_path
}


################################################################################
# app.divemap.io website
################################################################################
module "static_website_app_divemap_io" {
  source = "./static-s3-website"

  domain_name            = var.app_website_domain_name
  static_page_files_path = var.app_page_files_path
}