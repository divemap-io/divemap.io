output "landing_page_endpoint" {
  value = aws_s3_bucket_website_configuration.landing_page.website_endpoint
}