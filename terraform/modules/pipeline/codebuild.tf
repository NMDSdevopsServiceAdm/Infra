resource "aws_codebuild_project" "codebuild_feature" {
  name          = "feature"
  description   = "terraform validation and dry run plan on the feature branch"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn 

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/feature"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/Infra.git" 
    git_clone_depth = 1
    buildspec = "buildspec/feature.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_main" {
  name          = "main"
  description   = "terraform pipeline main branch"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/main"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/Infra.git" 
    git_clone_depth = 1
    buildspec = "buildspec/main.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}
