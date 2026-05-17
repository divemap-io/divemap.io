variable "aws_region" {
  description = "AWS region to deploy resources into."
  type        = string

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-\\d$", var.aws_region))
    error_message = "aws_region must look like a valid AWS region code (e.g. eu-north-1)."
  }
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token used to manage DNS records in the divemap.io zone."
  type        = string
  sensitive   = true
}

################################################################################
# S3 & Cloudflare
################################################################################

variable "landing_page_website_domain_name" {
  description = "Apex domain (and S3 bucket name) for the landing page website."
  type        = string
}

variable "app_website_domain_name" {
  description = "Subdomain (and S3 bucket name) for the app service website."
  type        = string
}

variable "landing_page_files_path" {
  description = "Path to the directory containing landing page files, relative to the root module."
  type        = string
}

variable "app_page_files_path" {
  description = "Path to the directory containing app service files, relative to the root module."
  type        = string
}
