data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com", "codepipeline.amazonaws.com"]
    }

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::914197850242:role/CodeBuildServiceRole"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codebuild_role" {
  name               = "CodeBuildServiceRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "codebuildservicerole_policy" {

  statement {
    effect = "Allow"

    actions = [
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
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
      "s3:PutBucketPolicy",
      "s3:GetObjectVersionTagging",
      "s3:GetStorageLensConfigurationTagging",
      "s3:GetObjectAcl",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetIntelligentTieringConfiguration",
      "s3:GetObjectVersionAcl",
      "s3:GetBucketPolicyStatus",
      "s3:GetObjectRetention",
      "s3:GetBucketWebsite",
      "s3:GetJobTagging",
      "s3:GetMultiRegionAccessPoint",
      "s3:GetObjectAttributes",
      "s3:GetObjectLegalHold",
      "s3:GetBucketNotification",
      "s3:DescribeMultiRegionAccessPointOperation",
      "s3:GetReplicationConfiguration",
      "s3:GetObject",
      "s3:DescribeJob",
      "s3:GetAnalyticsConfiguration",
      "s3:GetObjectVersionForReplication",
      "s3:GetAccessPointForObjectLambda",
      "s3:GetStorageLensDashboard",
      "s3:GetLifecycleConfiguration",
      "s3:GetAccessPoint",
      "s3:GetInventoryConfiguration",
      "s3:GetBucketTagging",
      "s3:GetAccessPointPolicyForObjectLambda",
      "s3:GetBucketLogging",
      "s3:GetAccelerateConfiguration",
      "s3:GetObjectVersionAttributes",
      "s3:GetBucketPolicy",
      "s3:GetEncryptionConfiguration",
      "s3:GetObjectVersionTorrent",
      "s3:GetBucketRequestPayment",
      "s3:GetAccessPointPolicyStatus",
      "s3:GetObjectTagging",
      "s3:GetMetricsConfiguration",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetMultiRegionAccessPointPolicyStatus",
      "s3:GetMultiRegionAccessPointPolicy",
      "s3:GetAccessPointPolicyStatusForObjectLambda",
      "s3:GetBucketVersioning",
      "s3:GetBucketAcl",
      "s3:GetAccessPointConfigurationForObjectLambda",
      "s3:GetObjectTorrent",
      "s3:GetMultiRegionAccessPointRoutes",
      "s3:GetStorageLensConfiguration",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetAccessPointPolicy",
      "s3:GetObjectVersion"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages",
      "codebuild:BatchGetBuilds",
      "codebuild:BatchGetProjects",
      "codebuild:StartBuild"
    ]
    resources = [
      aws_codebuild_project.codebuild_feature.arn, 
      aws_codebuild_project.codebuild_main.arn, 
      aws_codebuild_project.codebuild_asc_wds_build.arn,
      aws_codebuild_project.codebuild_asc_wds_build_test_frontend.arn,
      aws_codebuild_project.codebuild_asc_wds_build_test_backend.arn,
      aws_codebuild_project.codebuild_asc_wds_build_test_performance.arn,
      aws_codebuild_project.codebuild_asc_wds_build_deploy_frontend.arn
      ]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:GetRole",
      "iam:ListInstanceProfilesForRole",
      "iam:PassRole",
      "iam:ListRoleTags",
      "iam:ListAttachedRolePolicies",
      "iam:ListRoles",
      "iam:ListRolePolicies",
      "iam:GetRolePolicy",
      "iam:PutRolePolicy"
    ]

    resources = [aws_iam_role.codebuild_role.arn]
  }
}

resource "aws_iam_role_policy" "codebuildservicerole_policy" {
  name   = "codebuildservicerole_policy"
  role   = aws_iam_role.codebuild_role.id
  policy = data.aws_iam_policy_document.codebuildservicerole_policy.json
}
