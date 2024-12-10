locals {
  landing_page_files = fileset(var.landing_page_files_path, "*")

  s3_files = { for file_name in local.landing_page_files : file_name =>
    {
      content_type = endswith(file_name, ".svg") ? "image/x-icon" : endswith(file_name, ".jpg") ? "image/jpeg" : "text/html"
      etag         = filemd5("${var.landing_page_files_path}/${file_name}")
    }
  }
}

resource "aws_s3_bucket" "landing_page" {
  bucket = var.landing_page_domain_name
}

resource "aws_s3_bucket_public_access_block" "landing_page" {
  bucket                  = aws_s3_bucket.landing_page.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  depends_on              = [aws_s3_bucket.landing_page]
}

resource "aws_s3_bucket_policy" "landing_page_public_read" {
  bucket     = aws_s3_bucket.landing_page.id
  policy     = data.aws_iam_policy_document.landing_page_s3_bucket.json
  depends_on = [aws_s3_bucket.landing_page]
}

resource "aws_s3_bucket_website_configuration" "landing_page" {
  bucket = aws_s3_bucket.landing_page.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_object" "landing_page_files" {
  for_each     = local.s3_files
  bucket       = aws_s3_bucket.landing_page.id
  key          = each.key
  source       = "${var.landing_page_files_path}/${each.key}"
  etag         = each.value.etag
  content_type = each.value.content_type
}