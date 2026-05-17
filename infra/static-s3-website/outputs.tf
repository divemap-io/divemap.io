output "static_website_endpoint" {
  description = "Public URL of the published S3 static website."
  value       = aws_s3_bucket_website_configuration.main.website_endpoint
}
