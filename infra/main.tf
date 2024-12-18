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

locals {
  dns_records = {
    divemapio = {
      name    = "divemap.io",
      content = module.static_website_landing_page.static_website_endpoint
    },
    app = {
      name    = "app",
      content = module.static_website_app_service.static_website_endpoint
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

resource "cloudflare_dns_record" "main" {
  for_each = local.dns_records
  zone_id  = data.cloudflare_zone.main.id
  name     = each.value.name
  content  = each.value.content
  type     = "CNAME"
  ttl      = 1
  proxied  = true
}

################################################################################
# divemap.io website
################################################################################
module "static_website_landing_page" {
  source = "./static-s3-website"

  domain_name            = var.landing_page_website_domain_name
  static_page_files_path = var.landing_page_files_path
}


################################################################################
# app.divemap.io website
################################################################################
module "static_website_app_service" {
  source = "./static-s3-website"

  domain_name            = var.app_website_domain_name
  static_page_files_path = var.app_page_files_path
}