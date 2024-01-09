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

resource "aws_ssm_parameter" "token_iss" {
  name        = "/${var.environment}/app_runner/token_iss"
  description = "The JWT issuer"
  type        = "String"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "token_secret" {
  name        = "/${var.environment}/app_runner/token_secret"
  description = "The JWT signing secret"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "slack_url" {
  name        = "/${var.environment}/app_runner/slack_url"
  description = "slack_url"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "notify_key" {
  name        = "/${var.environment}/app_runner/notify_key"
  description = "NOTIFY_KEY"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "admin_url" {
  name        = "/${var.environment}/app_runner/admin_url"
  description = "ADMIN_URL"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "get_address" {
  name        = "/${var.environment}/app_runner/get_address"
  description = "GET_ADDRESS"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "send_in_blue_key" {
  name        = "/${var.environment}/app_runner/send_in_blue_key"
  description = "SEND_IN_BLUE_KEY"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "send_in_blue_whitelist" {
  name        = "/${var.environment}/app_runner/send_in_blue_whitelist"
  description = "SEND_IN_BLUE_WHITELIST"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

# resource "aws_ssm_parameter" "encryption_private_key" {
#   name        = "/${var.environment}/app_runner/encryption_private_key"
#   description = "ENCRYPTION_PRIVATE_KEY"
#   type        = "SecureString"
#   value       = "changeme"
#   tier        = "Advanced"
#   lifecycle {
#     ignore_changes = [
#       value,
#     ]
#   }
# }

# resource "aws_ssm_parameter" "encryption_public_key" {
#   name        = "/${var.environment}/app_runner/encryption_public_key"
#   description = "ENCRYPTION_PUBLIC_KEY"
#   type        = "SecureString"
#   value       = "changeme"
#   tier        = "Advanced"
#   lifecycle {
#     ignore_changes = [
#       value,
#     ]
#   }
# }

resource "aws_ssm_parameter" "encryption_passphrase" {
  name        = "/${var.environment}/app_runner/encryption_passphrase"
  description = "ENCRYPTION_PASSPHRASE"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "encryption_revokecert" {
  name        = "/${var.environment}/app_runner/encryption_revokecert"
  description = "ENCRYPTION_REVOKECERT"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "send_emails_sqs_queue" {
  name        = "/${var.environment}/app_runner/send_emails_sqs_queue"
  description = "SEND_EMAILS_SQS_QUEUE"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "aws_access_key_id" {
  name        = "/${var.environment}/app_runner/aws_access_key_id"
  description = "AWS_ACCESS_KEY_ID"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_ssm_parameter" "aws_secret_access_key" {
  name        = "/${var.environment}/app_runner/aws_secret_access_key"
  description = "AWS_SECRET_ACCESS_KEY"
  type        = "SecureString"
  value       = "changeme"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}