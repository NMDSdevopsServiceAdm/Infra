resource "aws_codebuild_project" "codebuild_terraform_validate" {
  name          = "asc-wds-infra-terraform-validation"
  description   = "terraform fmt and validate on branches"
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
      group_name  = "/aws/codebuild/terraform-validation"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/Infra.git" 
    git_clone_depth = 1
    buildspec = "buildspec/terraform-validation.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_terraform_apply_build_and_deploy" {
  name          = "asc-wds-infra-terraform-apply-build-and-deploy"
  description   = "terraform apply the main branch to AWS build and deploy account"
  build_timeout = "20"
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
      group_name  = "/aws/codebuild/terraform-apply/build-and-deploy"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/Infra.git" 
    git_clone_depth = 1
    buildspec = "buildspec/terraform-apply-build-and-deploy.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_terraform_apply_staging" {
  name          = "asc-wds-infra-terraform-apply-staging"
  description   = "terraform apply the main branch to the AWS staging account"
  build_timeout = "20"
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
      group_name  = "/aws/codebuild/terraform-apply/staging"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/Infra.git" 
    git_clone_depth = 1
    buildspec = "buildspec/terraform-apply-staging.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_terraform_apply_pre_production" {
  name          = "asc-wds-infra-terraform-apply-pre-production"
  description   = "terraform apply the main branch to the AWS pre production account"
  build_timeout = "20"
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
      group_name  = "/aws/codebuild/terraform-apply/pre-production"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/Infra.git" 
    git_clone_depth = 1
    buildspec = "buildspec/terraform-apply-pre-prod.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_terraform_apply_production" {
  name          = "asc-wds-infra-terraform-apply-production"
  description   = "terraform apply the main branch to the AWS production account"
  build_timeout = "20"
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
      group_name  = "/aws/codebuild/terraform-apply/production"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/Infra.git" 
    git_clone_depth = 1
    buildspec = "buildspec/terraform-apply-prod.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_terraform_apply_benchmark" {
  name          = "asc-wds-infra-terraform-apply-benchmark"
  description   = "terraform apply the main branch to the AWS benchmark account"
  build_timeout = "20"
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
      group_name  = "/aws/codebuild/terraform-apply/benchmark"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/Infra.git" 
    git_clone_depth = 1
    buildspec = "buildspec/terraform-apply-benchmark.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_build" {
  name          = "asc-wds-build"
  description   = "build the asc-wds application"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/build"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/build.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_build_test_frontend" {
  name          = "asc-wds-build-test-frontend"
  description   = "test the asc-wds application frontend"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/test-frontend"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/test-frontend.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_build_test_backend" {
  name          = "asc-wds-build-test-backend"
  description   = "test the asc-wds application backend"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/test-backend"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/test-backend.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}


resource "aws_codebuild_project" "codebuild_asc_wds_build_test_performance" {
  name          = "asc-wds-build-test-performance"
  description   = "test the asc-wds application performance"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/test-performance"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/test-performance.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_build_frontend_preprod" {
  name          = "asc-wds-build-frontend-preprod"
  description   = "build the asc-wds application frontend for the preprod environment"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/build-frontend-preprod"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/build-frontend-preprod.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_build_frontend_prod" {
  name          = "asc-wds-build-frontend-prod"
  description   = "build the asc-wds application frontend for the prod environment"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/build-frontend-prod"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/build-frontend-prod.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}
resource "aws_codebuild_project" "codebuild_asc_wds_build_deploy_frontend_staging" {
  name          = "asc-wds-build-deploy-frontend-staging"
  description   = "deploy the asc-wds application frontend in staging"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/deploy-frontend-staging"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/deploy-frontend-staging.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_build_deploy_frontend_preprod" {
  name          = "asc-wds-build-deploy-frontend-preprod"
  description   = "deploy the asc-wds application frontend in preprod"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/deploy-frontend-preprod"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/deploy-frontend-preprod.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_build_deploy_frontend_prod" {
  name          = "asc-wds-build-deploy-frontend-prod"
  description   = "deploy the asc-wds application frontend in prod"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/deploy-frontend-prod"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/deploy-frontend-prod.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_build_deploy_backend" {
  name          = "asc-wds-build-deploy-backend"
  description   = "deploy the asc-wds application backend"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

   cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE"]
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-build/deploy-backend"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/deploy-backend.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_deploy_staging" {
  name          = "asc-wds-deploy-staging"
  description   = "deploy the asc-wds application to the staging environment"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-deploy/staging"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/deploy-staging.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_deploy_pre_prod" {
  name          = "asc-wds-deploy-pre-prod"
  description   = "deploy the asc-wds application to the pre prod environment"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-deploy/preprod"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/deploy-preprod.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_deploy_prod" {
  name          = "asc-wds-deploy-prod"
  description   = "deploy the asc-wds application to the prod environment"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-deploy/prod"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/deploy-prod.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}

resource "aws_codebuild_project" "codebuild_asc_wds_deploy_benchmark" {
  name          = "asc-wds-deploy-benchmark"
  description   = "deploy the asc-wds application to the benchmark environment"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/asc-wds-deploy/benchmark"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/NMDSdevopsServiceAdm/SFC-Migration-Test.git" 
    git_clone_depth = 1
    buildspec = "buildspec/deploy-benchmark.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }
}