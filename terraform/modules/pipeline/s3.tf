resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "sfc-${var.environment}-codepipeline"
}
resource "aws_s3_bucket" "codepipeline_asc_wds_build_bucket" {
  bucket = "sfc-asc-wds-build-${var.environment}-pipeline"
}

resource "aws_s3_bucket" "codepipeline_asc_wds_deploy_bucket" {
  bucket = "sfc-asc-wds-deploy-${var.environment}-pipeline"
}

resource "aws_s3_bucket" "sfc_frontend_build_bucket" {
  bucket = "sfc-frontend-build-artifacts"

  tags = {
    Name = "S3 build artifacts for frontend"
  }
}