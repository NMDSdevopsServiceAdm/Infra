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
      DATA_ENGINEERING_ACCESS_KEY = aws_ssm_parameter.lambda_reports_data_engineering_access_key.value
      DATA_ENGINEERING_SECRET_KEY = aws_ssm_parameter.lambda_reports_data_engineering_secret_key.value
      DATA_ENGINEERING_S3_BUCKET =  aws_ssm_parameter.lambda_reports_data_engineering_s3_bucket.value
    }
  }

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = var.security_group_ids
  }
} 

resource "aws_cloudwatch_event_rule" "lambda_analysis_file_eventbridge" {
    name = "lambda_analysis_file_eventbridge"
    description = "Fires four times every month"
    schedule_expression = "cron(0 0 1,8,15,23 * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_analysis_file_job_every_month_four_times" {
    rule = aws_cloudwatch_event_rule.lambda_analysis_file_eventbridge.name
    target_id = "lambda_analysis_file_job"
    arn = aws_lambda_function.lambda_analysis_file_job.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_analysis_file_job" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda_analysis_file_job.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.lambda_analysis_file_eventbridge.arn
}

resource "aws_cloudwatch_log_group" "lambda_analysis_file_logs" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_analysis_file_job.function_name}"
  retention_in_days = 14
}