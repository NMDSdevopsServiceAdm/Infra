resource "aws_ecr_repository" "sfc_backend_ecr_repository" {
  name = "sfc-backend-build-images"
}

resource "aws_ecr_repository" "sfc_generate_analysis_files_ecr_repository" {
  name = "generate-analysis-files"
}

data "aws_iam_policy_document" "cross_account_ecr_access_policy" {
  statement {
    sid    = "cross account ecr access policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["101248264786","114055388985","008366934221","702856547275"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
  }

  statement {
    sid    = "lambda ECR image cross account retrieval policy"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]

     condition {
      test     = "StringLike"
      variable = "aws:sourceARN"

      values = [
        "arn:aws:lambda:eu-west-1:101248264786:function:*",
      ]
    }
  }
}

resource "aws_ecr_repository_policy" "cross_account_ecr_access_policy" {
  repository = aws_ecr_repository.sfc_backend_ecr_repository.name
  policy     = data.aws_iam_policy_document.cross_account_ecr_access_policy.json
}

resource "aws_ecr_repository_policy" "cross_account_generate_analysis_files_ecr_access_policy" {
  repository = aws_ecr_repository.sfc_generate_analysis_files_ecr_repository.name
  policy     = data.aws_iam_policy_document.cross_account_ecr_access_policy.json
}
