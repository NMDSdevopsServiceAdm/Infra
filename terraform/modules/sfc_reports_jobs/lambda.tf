resource "aws_lambda_function" "lambda_analysis_file_job" {
  filename      =  "${path.module}/empty.zip"
  function_name = "lambda_analysis_file"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  timeout       = 900

  environment {
    variables = {
      DATABASE_URL = aws_ssm_parameter.lambda_database_url.value
      PGSSLMODE    = aws_ssm_parameter.lambda_pgsslmode.value
    }
  }

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = var.security_group_ids
  }
}   
resource "aws_cloudwatch_log_group" "lambda_analysis_file_logs" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_analysis_file_job.function_name}"
  retention_in_days = 14
}