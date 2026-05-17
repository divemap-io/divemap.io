output "landing_page_website_endpoint" {
  description = "S3 website endpoint for the landing page (divemap.io)."
  value       = module.static_website_landing_page.static_website_endpoint
}

output "app_website_endpoint" {
  description = "S3 website endpoint for the app service (app.divemap.io)."
  value       = module.static_website_app_service.static_website_endpoint
}
