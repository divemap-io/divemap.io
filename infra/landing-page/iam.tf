data "aws_iam_policy_document" "landing_page_s3_bucket" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.landing_page.arn}/*"]
  }
}