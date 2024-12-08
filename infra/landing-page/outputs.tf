output "landing_page_endpoint" {
  description = "The public url to static landing page website"
  value       = aws_s3_bucket_website_configuration.landing_page.website_endpoint
}