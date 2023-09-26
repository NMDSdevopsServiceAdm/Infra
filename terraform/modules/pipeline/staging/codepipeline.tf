resource "aws_codepipeline" "codepipeline_asc_wds_deploy" {
  name     = "asc-wds-deploy-pipeline"
  role_arn = aws_iam_role.codebuild_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline-staging-bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        S3Bucket    = var.source_bucket
        S3ObjectKey = "assets"
        PollForSourceChanges = false
      }
    }
  }

  stage {
    name = "Deploy"
    
    action {
      name             = "deploy-frontend"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "S3"
      input_artifacts  = ["source_output"]
      version          = "1"
      role_arn = aws_iam_role.codebuild_role.arn
      configuration = {
        BucketName = var.target_bucket
        Extract = "true"
      }
    }
  }
}


