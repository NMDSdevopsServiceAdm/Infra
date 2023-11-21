resource "aws_ssm_parameter" "lambda_database_url" {
  name        = "/${var.environment}/lambda/database_url"
  description = "The database url for the lambda sfc analysis file jobs"
  type        = "String"
  value = "postgres://${var.database_username}:${var.database_password}@${var.database_host}:${var.database_port}/${var.database_name}"
}

resource "aws_ssm_parameter" "lambda_pgsslmode" {
  name        = "/${var.environment}/lambda/pgsslmode"
  description = "The database ssl mode for the lambda sfc analysis file jobs"
  type        = "String"
  value       = "require"
}