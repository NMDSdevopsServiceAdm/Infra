resource "aws_lambda_function" "lambda_analysis_file_job" {
  image_uri     = "636146736465.dkr.ecr.eu-west-1.amazonaws.com/generate-analysis-files:latest"
  function_name = "lambda_analysis_file"
  role          = aws_iam_role.lambda_role.arn
  architectures = ["x86_64"]
  timeout       = 900
  memory_size   = 256
  package_type  = "Image"

  environment {
    variables = {
      DATABASE_URL  = aws_ssm_parameter.lambda_database_url.value
      REPORTS_ACCESS_KEY = aws_ssm_parameter.lambda_reports_access_key.value
      REPORTS_SECRET_KEY = aws_ssm_parameter.lambda_reports_secret_key.value
      NODE_ENV      = aws_ssm_parameter.lambda_node_env.value
      REPORTS_S3_BUCKET =  aws_ssm_parameter.lambda_reports_s3_bucket.value
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