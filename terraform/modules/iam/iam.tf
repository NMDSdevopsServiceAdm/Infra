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
  description = "To provide cross account access for codebuild in build and deploy to perform terraform apply on staging"
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
    resources = ["arn:aws:s3:::terraform-state-sfc-staging"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["arn:aws:s3:::terraform-state-sfc-staging/state/terraform.tfstate"]
  }
}

resource "aws_iam_policy" "codebuild_terraform_state_bucket_policy" {
  name        = "CodebuildTerraformStateBucketPolicy"
  description = "To provide s3 terraform staging buckek permission to codebuild build and deploy"
  policy      = data.aws_iam_policy_document.codebuild_terraform_state_bucket_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_codebuild_terraform_state_bucket_policy" {
  role       = aws_iam_role.codebuild_cross_account_access_service_role.name
  policy_arn = aws_iam_policy.codebuild_terraform_state_bucket_policy.arn
}