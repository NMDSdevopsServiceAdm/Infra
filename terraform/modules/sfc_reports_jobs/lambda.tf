resource "aws_lambda_function" "lambda_analysis_file_job" {
  filename      =  "${path.module}/empty.zip"
  function_name = "lambda_analysis_file"
  role          = aws_iam_role.lambda_role.arn
  handler       = "jobs/generate_analysis_files.run"
  runtime = "nodejs18.x"
}   
resource "aws_cloudwatch_log_group" "lambda_analysis_file_logs" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_analysis_file_job.function_name}"
  retention_in_days = 14
}