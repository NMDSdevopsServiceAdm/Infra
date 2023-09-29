resource "aws_ecr_repository" "sfc_backend_ecr_repository" {
  name = "ecr-sfc-backend-${var.environment}"
}