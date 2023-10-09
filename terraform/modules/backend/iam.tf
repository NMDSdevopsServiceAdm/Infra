resource "aws_iam_role" "app_runner_instance_role" {
  name = "SFCAppRunnerInstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "tasks.apprunner.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_role_policy_attachment" {
  role       = aws_iam_role.app_runner_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

resource "aws_iam_role" "app_runner_erc_access_role" {
  name = "SFCAppRunnerECRAccessRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "build.apprunner.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_erc_access_role_policy_attachment" {
  role       = aws_iam_role.app_runner_erc_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_iam_role" "codebuild_apprunner_cross_account_access_role" {
  name = "CodebuildApprunnerCrossAccountAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::636146736465:root"
        }
      },
    ]
  })
}

data "aws_iam_policy_document" "codebuild_apprunner_cross_account_access_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::636146736465:role/CodeBuildServiceRole"]
  }
}

resource "aws_iam_policy" "codebuild_apprunner_cross_account_access_policy" {
  name        = "CodebuildApprunnerCrossAccountAccessPolicy"
  description = "To provide cross account access for codebuild in build and deploy"
  policy      = data.aws_iam_policy_document.codebuild_apprunner_cross_account_access_policy.json
}


resource "aws_iam_role_policy_attachment" "attach_codebuild_apprunner_cross_account_access_policy" {
  role       = aws_iam_role.codebuild_apprunner_cross_account_access_role.name
  policy_arn = aws_iam_policy.codebuild_apprunner_cross_account_access_policy.arn
}

data "aws_iam_policy_document" "codebuild_apprunner_start_deployment_policy" {
  statement {
    effect    = "Allow"
    actions   = ["apprunner:StartDeployment"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "codebuild_apprunner_start_deployment_policy" {
  name        = "CodebuildApprunnerStartDeploymentPolicy"
  description = "To provide codebuild permission to start an app runner deployment"
  policy      = data.aws_iam_policy_document.codebuild_apprunner_start_deployment_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_codebuild_apprunner_start_deployment_policy" {
  role       = aws_iam_role.codebuild_apprunner_cross_account_access_role.name
  policy_arn = aws_iam_policy.codebuild_apprunner_start_deployment_policy.arn
}