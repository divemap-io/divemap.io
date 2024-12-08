variable "landing_page_domain_name" {
  description = "The domain associated with the landing page."
  type        = string
}

variable "app_domain_name" {
  description = "The domain associated with the app service."
  type        = string
}

variable "aws_region" {
  description = "AWS region. Use with caution."
  type        = string
}