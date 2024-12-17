################################################################################
# S3
################################################################################

output "static_website_endpoint" {
  description = "The public url to the published static website"
  value       = aws_s3_bucket_website_configuration.main.website_endpoint
}