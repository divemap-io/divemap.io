locals {
  dns_records = {
    landing_page = {
      name    = "divemap.io"
      content = module.static_website_landing_page.static_website_endpoint
    }
    app = {
      name    = "app"
      content = module.static_website_app_service.static_website_endpoint
    }
  }
}
