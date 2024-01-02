resource "aws_ssm_parameter" "database_password" {
  name        = "/${var.environment}/database/password"
  description = "The password for the database"
  type        = "SecureString"
  value       = aws_db_instance.sfc_rds_db.password
}

resource "aws_ssm_parameter" "database_port" {
  name        = "/${var.environment}/database/port"
  description = "The port for the database"
  type        = "String"
  value       = aws_db_instance.sfc_rds_db.port
}

resource "aws_ssm_parameter" "database_username" {
  name        = "/${var.environment}/database/user"
  description = "The username for the database"
  type        = "String"
  value       = aws_db_instance.sfc_rds_db.username
}

resource "aws_ssm_parameter" "database_name" {
  name        = "/${var.environment}/database/name"
  description = "The name of the database"
  type        = "String"
  value       = aws_db_instance.sfc_rds_db.db_name
}
resource "aws_ssm_parameter" "database_host" {
  name        = "/${var.environment}/database/host"
  description = "The database host connection string"
  type        = "String"
  value       = aws_db_instance.sfc_rds_db.address
}

resource "aws_ssm_parameter" "redis_endpoint" {
  name        = "/${var.environment}/redis/endpoint"
  description = "The endpoint for Elasticache"
  type        = "String"
  value       = "redis://${aws_elasticache_replication_group.sfc_redis_replication_group.primary_endpoint_address}:6379"
}

resource "aws_ssm_parameter" "node_env" {
  name        = "/${var.environment}/app_runner/node_env"
  description = "The Node Environment Varible to use the correct config"
  type        = "String"
  value       = var.node_env
}

resource "aws_ssm_parameter" "honeycomb_write_key" {
  name        = "/${var.environment}/app_runner/honeycomb_write_key"
  description = "The honeycomb write key"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}