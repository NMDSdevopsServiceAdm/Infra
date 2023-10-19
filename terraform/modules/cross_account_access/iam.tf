resource "aws_iam_role" "codebuild_cross_account_access_service_role" {
  name = "CodebuildCrossAccountAccessServiceRole"

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

data "aws_iam_policy_document" "codebuild_cross_account_access_service_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::636146736465:role/CodeBuildServiceRole"]
  }
}

resource "aws_iam_policy" "codebuild_cross_account_access_service_policy" {
  name        = "CodebuildCrossAccountAccessServicePolicy"
  description = "To provide cross account access for codebuild in build and deploy to perform terraform apply on ${var.environment}"
  policy      = data.aws_iam_policy_document.codebuild_cross_account_access_service_policy.json
}


resource "aws_iam_role_policy_attachment" "codebuild_cross_account_access_service_policy" {
  role       = aws_iam_role.codebuild_cross_account_access_service_role.name
  policy_arn = aws_iam_policy.codebuild_cross_account_access_service_policy.arn
}


data "aws_iam_policy_document" "codebuild_terraform_state_bucket_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::terraform-state-sfc-${var.environment}"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["arn:aws:s3:::terraform-state-sfc-${var.environment}/state/terraform.tfstate"]
  }
}

resource "aws_iam_policy" "codebuild_terraform_state_bucket_policy" {
  name        = "CodebuildTerraformStateBucketPolicy"
  description = "To provide s3 terraform ${var.environment} bucket permission to codebuild build and deploy"
  policy      = data.aws_iam_policy_document.codebuild_terraform_state_bucket_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_codebuild_terraform_state_bucket_policy" {
  role       = aws_iam_role.codebuild_cross_account_access_service_role.name
  policy_arn = aws_iam_policy.codebuild_terraform_state_bucket_policy.arn
}

data "aws_iam_policy_document" "codebuild_grouped_aws_managed_policy" {
  statement {
    sid    = "AmazonEC2FullAccess"
    effect = "Allow"
    actions = [
      "ec2:*",
      "elasticloadbalancing:*",
      "cloudwatch:*",
      "autoscaling:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AmazonElastiCacheFullAccess"
    effect = "Allow"
    actions = [
      "elasticache:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AmazonRDSFullAccess"
    effect = "Allow"
    actions = [
      "rds:*",
      "application-autoscaling:DeleteScalingPolicy",
      "application-autoscaling:DeregisterScalableTarget",
      "application-autoscaling:DescribeScalableTargets",
      "application-autoscaling:DescribeScalingActivities",
      "application-autoscaling:DescribeScalingPolicies",
      "application-autoscaling:PutScalingPolicy",
      "application-autoscaling:RegisterScalableTarget",
      "sns:ListSubscriptions",
      "sns:ListTopics",
      "sns:Publish",
      "outposts:GetOutpostInstanceTypes",
      "devops-guru:GetResourceCollection"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "AmazonRDSFullAccess1"
    effect  = "Allow"
    actions = ["pi:*"]
    resources = [
      "arn:aws:pi:*:*:metrics/rds/*",
      "arn:aws:pi:*:*:perf-reports/rds/*"
    ]
  }

  statement {
    sid    = "AmazonS3FullAccess"
    effect = "Allow"
    actions = [
      "s3:*",
      "s3-object-lambda:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AmazonSSMFullAccess"
    effect = "Allow"
    actions = [
      "ds:CreateComputer",
      "ds:DescribeDirectories",
      "logs:*",
      "ssm:*",
      "ec2messages:*",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }

  statement {
    sid       = "AWSAppRunnerFullAccess"
    effect    = "Allow"
    actions   = ["apprunner:*"]
    resources = ["*"]
  }

  statement {
    sid    = "IAMFullAccess"
    effect = "Allow"
    actions = [
      "iam:*",
      "organizations:DescribeAccount",
      "organizations:DescribeOrganization",
      "organizations:DescribeOrganizationalUnit",
      "organizations:DescribePolicy",
      "organizations:ListChildren",
      "organizations:ListParents",
      "organizations:ListPoliciesForTarget",
      "organizations:ListRoots",
      "organizations:ListPolicies",
      "organizations:ListTargetsForPolicy"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "CloudFrontFullAccess"
    effect = "Allow"
    actions = [
      "acm:ListCertificates",
      "cloudfront:*",
      "waf:ListWebACLs",
      "waf:GetWebACL",
      "wafv2:ListWebACLs",
      "wafv2:GetWebACL",
      "kinesis:ListStreams",
      "kinesis:DescribeStream"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "codebuild_grouped_aws_managed_policy" {
  name        = "CodebuildGroupedAWSManagedPolicy"
  description = "Contains all the polices that the Cross Account Role needs to deploy Terraform Infrastructure"
  policy      = data.aws_iam_policy_document.codebuild_grouped_aws_managed_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_codebuild_grouped_aws_managed_policy" {
  role       = aws_iam_role.codebuild_cross_account_access_service_role.name
  policy_arn = aws_iam_policy.codebuild_grouped_aws_managed_policy.arn
}
