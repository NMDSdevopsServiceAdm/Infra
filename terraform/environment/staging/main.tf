provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-sfc-staging"
    key    = "state/terraform.tfstate"
    region = "eu-west-1"
  }
}
module "frontend" {
  source = "../../modules/frontend"

  environment = var.environment
}

module "backend" {
  source = "../../modules/backend"

  environment        = var.environment
  app_runner_cpu     = var.app_runner_cpu
  app_runner_memory  = var.app_runner_memory
  private_subnet_ids = module.networking.private_subnets
  security_group_ids = module.networking.security_group_id
  rds_instance_class =  var.rds_instance_class
  rds_allocated_storage = var.rds_allocated_storage
  multi_az = var.multi_az
  elasticache_node_type = var.elasticache_node_type
  app_runner_min_container_instances_size = var.app_runner_min_container_instances_size
  app_runner_max_container_instances_size = var.app_runner_max_container_instances_size
  app_runner_max_concurrency = var.app_runner_max_concurrency
  rds_db_backup_retention_period = var.rds_db_backup_retention_period
}

module "networking" {
  source = "../../modules/networking"
}

module "cross_account_access" {
  source = "../../modules/cross_account_access"

  environment = var.environment
}

module "sfc_reports_jobs" {
  source = "../../modules/sfc_reports_jobs"
  environment = var.environment
  database_password = module.backend.database_password
  database_username = module.backend.database_username
  database_host = module.backend.database_host
  database_port = module.backend.database_port
  database_name = module.backend.database_name
}