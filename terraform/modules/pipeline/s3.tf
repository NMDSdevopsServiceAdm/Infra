resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "sfc-codepipeline"
}
resource "aws_s3_bucket" "codepipeline_asc_wds_build_bucket" {
  bucket = "sfc-asc-wds-build-pipeline"
}