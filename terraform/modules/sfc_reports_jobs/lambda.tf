data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "LambdaServiceRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# data "archive_file" "lambda" {
#   type        = "zip"
#   source_file = ""
#   output_path = "analysis_file_output_file.zip"
# }

resource "aws_lambda_function" "sfc_lambda_analysis_file_job" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      =  "${path.module}/2022-04-19-20-17-27_analysis_files.zip"
  function_name = "lambda_analysis_file"
  role          = aws_iam_role.lambda_role.arn
  handler       = "jobs/generate_analysis_files.run"


  runtime = "nodejs18.x"


}   


resource "aws_cloudwatch_log_group" "analysis_file_lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.sfc_lambda_analysis_file_job.function_name}"
  retention_in_days = 14
}

data "aws_iam_policy_document" "analysis_file_lambda_logging_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_policy" "analysis_file_lambda_logging_policy" {
  name        = "analysis_file_lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.analysis_file_lambda_logging_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.id
  policy_arn = aws_iam_policy.analysis_file_lambda_logging_policy.arn
}