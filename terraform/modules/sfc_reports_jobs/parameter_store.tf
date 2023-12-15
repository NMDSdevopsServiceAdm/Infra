resource "aws_ssm_parameter" "lambda_database_url" {
  name        = "/${var.environment}/lambda/database_url"
  description = "The database url for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "postgres://${var.database_username}:${var.database_password}@${var.database_host}:${var.database_port}/${var.database_name}"
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
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "lambda_reports_access_key" {
  name        = "/${var.environment}/lambda/reports_access_key"
  description = "The access key for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "change_me"
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "lambda_reports_data_engineering_access_key" {
  name        = "/${var.environment}/lambda/reports_data_engineering_access_key"
  description = "The data enginnering access key for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "change_me"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "lambda_reports_data_engineering_secret_key" {
  name        = "/${var.environment}/lambda/reports_data_engineering_secret_key"
  description = "The data enginnering secret key for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "change_me"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "lambda_reports_s3_bucket" {
  name        = "/${var.environment}/lambda/reports_s3_bucket"
  description = "The s3 bucket for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "test-sfc-gen-analysis-file"
}

resource "aws_ssm_parameter" "lambda_reports_data_engineering_s3_bucket" {
  name        = "/${var.environment}/lambda/reports_data_engineering_s3_bucket"
  description = "The data engineering s3 bucket for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "test-data-engineering-sfc-analysis-file"
}

resource "aws_ssm_parameter" "sfc_reports_ssh_public_key" {
  name        = "/${var.environment}/ec2/sfc_reports_ssh_public_key"
  description = "The ssh_public_key for the sfc analysis file jobs"
  type        = "String"
  value       = "change-me"
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}