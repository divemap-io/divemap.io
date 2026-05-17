variable "domain_name" {
  description = "Domain associated with the static website. Used as the S3 bucket name."
  type        = string
}

variable "relative_files_path" {
  description = "Path to the directory containing the website's files, relative to the root module."
  type        = string
}
