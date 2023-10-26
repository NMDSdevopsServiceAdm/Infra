resource "aws_apprunner_service" "sfc_app_runner" {
  service_name = "sfc-app-runner-${var.environment}"

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.sfc_app_runner_auto_scaling_config.arn   

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
      access_role_arn = aws_iam_role.app_runner_ecr_access_role.arn
    }
    image_repository {
      image_identifier      = "636146736465.dkr.ecr.eu-west-1.amazonaws.com/sfc-backend-build-images:${var.environment}"
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

resource "aws_apprunner_auto_scaling_configuration_version" "sfc_app_runner_auto_scaling_config" {                            
  auto_scaling_configuration_name = "sfc-app-runner-auto-scaling-config"

  min_size = var.app_runner_min_container_instances_size
  max_size = var.app_runner_max_container_instances_size 
  max_concurrency = var.app_runner_max_concurrency
}