resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "sfc-codepipeline"
}
resource "aws_s3_bucket" "codepipeline_asc_wds_build_bucket" {
  bucket = "sfc-asc-wds-build-pipeline"
}
resource "aws_s3_bucket" "codepipeline_asc_wds_deploy_frontend_bucket" {
  bucket = "sfc-asc-wds-deploy-frontend"
}
