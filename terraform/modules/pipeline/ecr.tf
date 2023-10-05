resource "aws_ecr_repository" "sfc_backend_ecr_repository" {
  name = "sfc-backend-build-images"
}
data "aws_iam_policy_document" "cross_account_ecr_access_policy" {
  statement {
    sid    = "cross account ecr access policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["101248264786"]
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
}

resource "aws_ecr_repository_policy" "cross_account_ecr_access_policy" {
  repository = aws_ecr_repository.sfc_backend_ecr_repository.name
  policy     = data.aws_iam_policy_document.cross_account_ecr_access_policy.json
}