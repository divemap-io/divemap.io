locals {
  mime_types = {
    "html"        = "text/html"
    "css"         = "text/css"
    "js"          = "application/javascript"
    "mjs"         = "application/javascript"
    "json"        = "application/json"
    "svg"         = "image/svg+xml"
    "png"         = "image/png"
    "jpg"         = "image/jpeg"
    "jpeg"        = "image/jpeg"
    "gif"         = "image/gif"
    "ico"         = "image/x-icon"
    "webp"        = "image/webp"
    "woff"        = "font/woff"
    "woff2"       = "font/woff2"
    "ttf"         = "font/ttf"
    "txt"         = "text/plain"
    "xml"         = "application/xml"
    "pdf"         = "application/pdf"
    "webmanifest" = "application/manifest+json"
  }

  website_files = fileset(var.relative_files_path, "*")

  s3_files = {
    for file_name in local.website_files : file_name => {
      content_type = lookup(local.mime_types, lower(reverse(split(".", file_name))[0]), "application/octet-stream")
      etag         = filemd5("${var.relative_files_path}/${file_name}")
    }
  }
}

################################################################################
# S3
################################################################################

resource "aws_s3_bucket" "main" {
  bucket = var.domain_name
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.public_read.json

  depends_on = [aws_s3_bucket_public_access_block.main]
}

resource "aws_s3_bucket_website_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_object" "main" {
  for_each = local.s3_files

  bucket       = aws_s3_bucket.main.id
  key          = each.key
  source       = "${var.relative_files_path}/${each.key}"
  etag         = each.value.etag
  content_type = each.value.content_type
}

################################################################################
# IAM
################################################################################

data "aws_iam_policy_document" "public_read" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.main.arn}/*"]
  }
}
