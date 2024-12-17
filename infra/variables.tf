variable "aws_region" {
  description = "AWS region. Use with caution."
  type        = string
}

variable "landing_page_website_domain_name" {
  description = "The domain associated with the landing page."
  type        = string
}

variable "app_website_domain_name" {
  description = "The domain associated with the app service."
  type        = string
}

variable "landing_page_files_path" {
  type = string
}

variable "app_page_files_path" {
  type = string
}