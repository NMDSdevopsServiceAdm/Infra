resource "aws_codestarconnections_connection" "codestar_github" {
  name          = "GitHub"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "codepipeline" {
  name     = "tf-test-pipeline"
  role_arn = aws_iam_role.codebuild_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

    # encryption_key {
    #   id   = data.aws_kms_alias.s3kmskey.arn
    #   type = "KMS"
    # }
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
        BranchName       = "feat/terraform-pipeline"
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
        ProjectName = "test"
      }
      role_arn = aws_iam_role.codebuild_role.arn
    }
  }

  # stage {
  #   name = "Deploy"

  #   action {
  #     name            = "Deploy"
  #     category        = "Deploy"
  #     owner           = "AWS"
  #     provider        = "CloudFormation"
  #     input_artifacts = ["build_output"]
  #     version         = "1"

  #     configuration = {
  #       ActionMode     = "REPLACE_ON_FAILURE"
  #       Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
  #       OutputFileName = "CreateStackOutput.json"
  #       StackName      = "MyStack"
  #       TemplatePath   = "build_output::sam-templated.yaml"
  #     }
  #   }
  # }
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "sfc-mig-test-bucket"
}

# resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
#   bucket = aws_s3_bucket.codepipeline_bucket.id
# //  acl    = "private"
# }

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com","codepipeline.amazonaws.com"]
    }

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::914197850242:role/CodeBuildServiceRole"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "test-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role" "codebuild_role" {
  name               = "CodeBuildServiceRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["codestar-connections:UseConnection", "codestar-connections:GetConnection"]
    resources = [aws_codestarconnections_connection.codestar_github.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:GetRole",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "codebuildservicerole_policy" {

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObjectVersion",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:*",
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "codestar-connections:*",
      "codepipeline:*",
      "codecommit:GitPull",
      "codebuild:*"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:*",
    ]

    resources = [aws_iam_role.codepipeline_role.arn, aws_iam_role.codebuild_role.arn]
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline_policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

resource "aws_iam_role_policy" "codebuildservicerole_policy" {
  name   = "codebuildservicerole_policy"
  role   = aws_iam_role.codebuild_role.id
  policy = data.aws_iam_policy_document.codebuildservicerole_policy.json
}

# data "aws_kms_alias" "s3kmskey" {
#   name = "alias/myKmsKey"
# }
