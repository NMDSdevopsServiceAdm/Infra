provider "aws" {
  region = "us-east-1"
  alias = "us_east_1"
}


resource "aws_acm_certificate" "certificate" {
  provider = aws.us_east_1
  domain_name       = "${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}