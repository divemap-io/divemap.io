locals {
  website_files = fileset(var.static_page_files_path, "*")

  s3_files = { for file_name in local.website_files : file_name =>
    {
      content_type = endswith(file_name, ".svg") ? "image/x-icon" : endswith(file_name, ".jpg") ? "image/jpeg" : "text/html"
      etag         = filemd5("${var.static_page_files_path}/${file_name}")
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
  bucket                  = aws_s3_bucket.main.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  depends_on              = [aws_s3_bucket.main]
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket     = aws_s3_bucket.main.id
  policy     = data.aws_iam_policy_document.main.json
  depends_on = [aws_s3_bucket.main]
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
  for_each     = local.s3_files
  bucket       = aws_s3_bucket.main.id
  key          = each.key
  source       = "${var.static_page_files_path}/${each.key}"
  etag         = each.value.etag
  content_type = each.value.content_type
}

################################################################################
# IAM
################################################################################

data "aws_iam_policy_document" "main" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.main.arn}/*"]
  }
}