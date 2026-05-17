provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Project   = "divemap.io"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
