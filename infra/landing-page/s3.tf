locals {
  landing_page_files_path = "../../src/dm-landingpage"
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

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.landing_page.id
  key          = "index.html"
  source       = "${local.landing_page_files_path}/index.html"
  etag         = filemd5("${local.landing_page_files_path}/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "favicon_svg" {
  bucket       = aws_s3_bucket.landing_page.id
  key          = "favicon.svg"
  source       = "${local.landing_page_files_path}/favicon.svg"
  etag         = filemd5("${local.landing_page_files_path}/favicon.svg")
  content_type = "image/x-icon"
}

resource "aws_s3_object" "logo_rec_jpg" {
  bucket       = aws_s3_bucket.landing_page.id
  key          = "logo_rec.jpg"
  source       = "${local.landing_page_files_path}/logo_rec.jpg"
  etag         = filemd5("${local.landing_page_files_path}/logo_rec.jpg")
  content_type = "image/jpeg"
}