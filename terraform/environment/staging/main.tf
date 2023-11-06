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
  rds_db_backup_retention_period = var.rds_db_backup_retention_period
}

module "networking" {
  source = "../../modules/networking"
}

module "cross_account_access" {
  source = "../../modules/cross_account_access"

  environment = var.environment
}
