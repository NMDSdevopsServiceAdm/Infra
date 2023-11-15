resource "aws_codestarconnections_connection" "codestar_github" {
  name          = "GitHub"
  provider_type = "GitHub"
}

resource "aws_codebuild_webhook" "codepipeline_feature_branch_webhook" {
  project_name = aws_codebuild_project.codebuild_terraform_validate.name
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
    name = "DeployBuildAndDeployInfrastructure"

    action {
      name             = "DeployBuildAndDeployInfrastructure"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["terraform_bnd_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_terraform_apply_build_and_deploy.name
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }
  stage {
    name = "DeployStagingInfrastructure"

    action {
      name             = "DeployStagingInfrastructure"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["terraform_staging_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_terraform_apply_staging.name
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }
  stage {
    name = "DeployPreProductionInfrastructure"

    action {
      name             = "DeployPreProductionInfrastructure"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["terraform_pre_production_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_terraform_apply_pre_production.name
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }
  stage {
    name = "DeployProductionInfrastructure"

    action {
      name             = "DeployProductionInfrastructure"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["terraform_production_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_terraform_apply_production.name
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }

  stage {
    name = "DeployBenchmarkInfrastructure"

    action {
      name             = "DeployBenchmarkInfrastructure"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["terraform_benchmark_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_terraform_apply_benchmark.name
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


  stage {
    name = "Test"

    action {
      name             = "test-frontend"
      category         = "Test"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["build_output"]
      output_artifacts = ["test_frontend_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-build-test-frontend"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }

    action {
      name             = "test-backend"
      category         = "Test"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["build_output"]
      output_artifacts = ["test_backend_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-build-test-backend"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }

    action {
      name             = "test-performance"
      category         = "Test"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["build_output"]
      output_artifacts = ["test_performance_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-build-test-performance"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }

  stage {
    name = "BuildFrontend"

    action {
        name             = "build-frontend-preprod"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["source_output"]
        output_artifacts = ["build_output_preprod"]
        version          = "1"

        configuration = {
          ProjectName = "asc-wds-build-frontend-preprod"
        }
        role_arn = aws_iam_role.codebuild_role.arn
      }

      action {
        name             = "build-frontend-prod"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["source_output"]
        output_artifacts = ["build_output_prod"]
        version          = "1"

        configuration = {
          ProjectName = "asc-wds-build-frontend-prod"
        }
        role_arn = aws_iam_role.codebuild_role.arn
      }
  }
  stage {
    name = "Deploy"

    action {
      name             = "deploy-frontend-staging"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["build_output"]
      output_artifacts = ["deploy_frontend_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-build-deploy-frontend-staging"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }

    action {
      name             = "deploy-frontend-preprod"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["build_output_preprod"]
      output_artifacts = ["deploy_frontend_preprod_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-build-deploy-frontend-preprod"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }

    action {
      name             = "deploy-frontend-prod"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["build_output_prod"]
      output_artifacts = ["deploy_frontend_prod_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-build-deploy-frontend-prod"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }

    action {
      name             = "deploy-backend"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["build_output"]
      output_artifacts = ["deploy_backend_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-build-deploy-backend"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }
}


resource "aws_codepipeline" "codepipeline_asc_wds_deploy" {
  name     = "asc-wds-deploy-pipeline"
  role_arn = aws_iam_role.codebuild_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_asc_wds_deploy_bucket.bucket
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
    name = "ApproveStagingDeployment"

    action {
      name     = "ApproveStagingDeployment"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }

  stage {
    name = "DeployStaging"

    action {
      name             = "DeployStaging"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["deploy_staging_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-deploy-staging"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }

  stage {
    name = "ApprovePreProductionDeployment"

    action {
      name     = "ApprovePreProductionDeployment"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }

  stage {
    name = "DeployPreProduction"

    action {
      name             = "DeployPreProduction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["deploy_pre_production_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-deploy-pre-prod"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }

  stage {
    name = "ApproveProductionDeployment"
    
    action {
      name     = "ApproveProductionDeployment"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }

  stage {
    name = "DeployProduction"

    action {
      name             = "DeployProduction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["deploy_production_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-deploy-prod"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }

    action {
      name             = "DeployBenchmark"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["deploy_benchmark_output"]
      version          = "1"

      configuration = {
        ProjectName = "asc-wds-deploy-benchmark"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }
}


