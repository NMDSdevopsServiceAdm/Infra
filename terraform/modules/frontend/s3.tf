resource "aws_s3_bucket" "sfc_frontend_bucket" {
  bucket = "sfc-frontend-${var.environment}"

  tags = {
    Name = "S3 bucket for frontend"
  }
}

resource "aws_s3_bucket_ownership_controls" "sfc_frontend_bucket_ownership_controls" {
  bucket = aws_s3_bucket.sfc_frontend_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "sfc_frontend_public_access_block" {
  bucket = aws_s3_bucket.sfc_frontend_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "sfc_frontend_bucket_website_configuration" {
  bucket = aws_s3_bucket.sfc_frontend_bucket.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}


resource "aws_s3_bucket_website_configuration" "sfc_public_bucket_website_configuration" {
  bucket ="sfc-public-${var.environment}"

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_bucket_policy" "sfc_frontend_bucket_policy" {
  bucket = aws_s3_bucket.sfc_frontend_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid"      : "PublicReadGetObject",
        "Effect"    : "Allow",
        "Principal" : "*",
        "Action"    : "s3:GetObject",
        "Resource" : [
          "${aws_s3_bucket.sfc_frontend_bucket.arn}/*",
        ]
      },
      {
        "Sid"      : "FrontendAssetDeployListObject",
        "Effect"    : "Allow",
        "Action"    : [
              "s3:ListBucket",
          ],
        "Principal" : {
           "AWS": "arn:aws:iam::636146736465:role/CodeBuildServiceRole"
           
         },
        "Resource" : ["${aws_s3_bucket.sfc_frontend_bucket.arn}"]
      },
      {
        "Sid"      : "FrontendAssetDeployPutObject",
        "Effect"    : "Allow",
        "Action"    : [
              "s3:PutObject",
              "s3:PutObjectAcl"
          ],
        "Principal" : {
           "AWS": "arn:aws:iam::636146736465:role/CodeBuildServiceRole"
           
         },
        "Resource" :  ["${aws_s3_bucket.sfc_frontend_bucket.arn}/*"]
      },
    ]
  })
}

resource "aws_s3_bucket_cors_configuration" "sfc_frontend_bucket_cors_configuration" {
  bucket = aws_s3_bucket.sfc_frontend_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
  }
}