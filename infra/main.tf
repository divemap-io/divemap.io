provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

################################################################################
# divemap.io website
################################################################################
module "static_website_divemap_io" {
  source = "./static-s3-website"

  domain_name = var.landing_page_website_domain_name
  static_page_files_path = var.landing_page_files_path
}


################################################################################
# app.divemap.io website
################################################################################
module "static_website_app_divemap_io" {
  source = "./static-s3-website"

  domain_name = var.app_website_domain_name
  static_page_files_path = var.landing_page_files_path
}