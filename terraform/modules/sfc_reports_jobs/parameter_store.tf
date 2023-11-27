resource "aws_ssm_parameter" "lambda_database_url" {
  name        = "/${var.environment}/lambda/database_url"
  description = "The database url for the lambda sfc analysis file jobs"
  type        = "String"
  value = "postgres://${var.database_username}:${var.database_password}@${var.database_host}:${var.database_port}/${var.database_name}"
}

resource "aws_ssm_parameter" "lambda_node_env" {
  name        = "/${var.environment}/lambda/node_env"
  description = "The node environment for the lambda sfc analysis file jobs"
  type        = "String"
  value       = var.environment
}

resource "aws_ssm_parameter" "lambda_reports_secret_key" {
  name        = "/${var.environment}/lambda/reports_secret_key"
  description = "The secret key for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "change_me"
}

resource "aws_ssm_parameter" "lambda_reports_access_key" {
  name        = "/${var.environment}/lambda/reports_access_key"
  description = "The access key for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "change_me"
}

resource "aws_ssm_parameter" "lambda_reports_s3_bucket" {
  name        = "/${var.environment}/lambda/reports_s3_bucket"
  description = "The s3 bucket for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "test-sfc-gen-analysis-file"
}