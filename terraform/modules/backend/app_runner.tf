resource "aws_apprunner_service" "sfc_app_runner" {
  service_name = "sfc-app-runner-${var.environment}"



  instance_configuration {
    cpu               = var.app_runner_cpu
    memory            = var.app_runner_memory
    instance_role_arn = aws_iam_role.app_runner_instance_role.arn
  }

    network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = aws_apprunner_vpc_connector.sfc_app_runner_vpc_connector.arn
    }
  }
  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.app_runner_erc_access_role.arn
    }
    image_repository {
      image_identifier      = "${aws_ecr_repository.sfc_backend_ecr_repository.repository_url}:latest"
      image_repository_type = "ECR"
      image_configuration {
        port = 3000
        runtime_environment_secrets = {
          DB_PASS        = aws_ssm_parameter.database_password.arn
          DB_PORT        = aws_ssm_parameter.database_port.arn
          DB_USER        = aws_ssm_parameter.database_username.arn
          DB_NAME        = aws_ssm_parameter.database_name.arn
          DB_HOST        = aws_ssm_parameter.database_host.arn
          REDIS_ENDPOINT = aws_ssm_parameter.redis_endpoint.arn
        }
      }
    }
    auto_deployments_enabled = false
  }
}

resource "aws_apprunner_vpc_connector" "sfc_app_runner_vpc_connector" {
  vpc_connector_name = "sfc-app-runner-vpc-connector"
  subnets            = var.private_subnet_ids
  security_groups    = var.security_group_ids
}