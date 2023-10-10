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

