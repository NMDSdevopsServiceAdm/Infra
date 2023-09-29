provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-sfc-bnd"
    key    = "state/terraform.tfstate"
    region = "eu-west-1"
  }
}

module "pipeline" {
  source = "../../modules/pipeline"

  environment   = var.environment
  target_bucket = "sfc-frontend-${var.environment}"
}