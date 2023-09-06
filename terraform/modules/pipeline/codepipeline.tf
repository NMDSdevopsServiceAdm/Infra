resource "aws_codestarconnections_connection" "codestar_github" {
  name          = "GitHub"
  provider_type = "GitHub"
}

resource "aws_codebuild_webhook" "codepipeline_feature_branch_webhook" {
  project_name = "feature"
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }
  }
}

resource "aws_codepipeline" "codepipeline_main_branch" {
  name     = "terraform-main-branch-pipeline"
  role_arn = aws_iam_role.codebuild_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.codestar_github.arn
        FullRepositoryId = "NMDSdevopsServiceAdm/Infra"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "main"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }
}

resource "aws_codepipeline" "codepipeline_asc_wds_build" {
  name     = "asc-wds-build-pipeline"
  role_arn = aws_iam_role.codebuild_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_asc_wds_build_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.codestar_github.arn
        FullRepositoryId = "NMDSdevopsServiceAdm/SFC-Migration-Test"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-build"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }
}

