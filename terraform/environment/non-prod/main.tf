provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-sfc"
    key    = "state/terraform.tfstate"
    region = "eu-west-1"
    access_key = "<access-key>"
    secret_key = "<secret-key>"
  }
}
# module "frontend" {
#   source = "../../modules/frontend"

#   environment = var.environment
# }

# module "backend" {
#   source = "../../modules/backend"

#   environment = var.environment
#   app_runner_cpu = var.app_runner_cpu
#   app_runner_memory = var.app_runner_memory
#   private_subnet_ids = module.networking.private_subnets
#   security_group_ids = module.networking.security_group_id
#   }

# module "networking" {
#   source = "../../modules/networking"
# }

module "pipeline" {
  source = "../../modules/pipeline"

  environment = var.environment
}