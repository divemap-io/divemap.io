variable "aws_region" {
  description = "AWS region. Use with caution."
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

################################################################################
# S3 & Cloudflare
################################################################################

variable "landing_page_website_domain_name" {
  description = "The domain associated with the landing page."
  type        = string
}

variable "app_website_domain_name" {
  description = "The domain associated with the app service."
  type        = string
}

variable "landing_page_files_path" {
  description = "The path to directory containing all landing page files"
  type        = string
}

variable "app_page_files_path" {
  description = "The path to directory containing all app service files"
  type        = string
}