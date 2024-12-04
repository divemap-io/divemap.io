resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "landing_page" {
  bucket = "app.divemap.io"
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
  bucket = aws_s3_bucket.landing_page.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.landing_page.arn}/*"
      }
    ]
  })
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
  source       = "../../src/dm-landingpage/index.html"
  etag         = filemd5("../../src/dm-landingpage/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "favicon_svg" {
  bucket       = aws_s3_bucket.landing_page.id
  key          = "favicon.svg"
  source       = "../../src/dm-landingpage/favicon.svg"
  etag         = filemd5("../../src/dm-landingpage/favicon.svg")
  content_type = "image/x-icon"
}

resource "aws_s3_object" "logo_rec_jpg" {
  bucket       = aws_s3_bucket.landing_page.id
  key          = "logo_rec.jpg"
  source       = "../../src/dm-landingpage/logo_rec.jpg"
  etag         = filemd5("../../src/dm-landingpage/logo_rec.jpg")
  content_type = "image/jpeg"
}