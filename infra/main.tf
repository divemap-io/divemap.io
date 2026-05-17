################################################################################
# divemap.io website
################################################################################

module "static_website_landing_page" {
  source = "./static-s3-website"

  domain_name         = var.landing_page_website_domain_name
  relative_files_path = var.landing_page_files_path
}

################################################################################
# app.divemap.io website
################################################################################

module "static_website_app_service" {
  source = "./static-s3-website"

  domain_name         = var.app_website_domain_name
  relative_files_path = var.app_page_files_path
}
