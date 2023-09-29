resource "aws_db_instance" "sfc_rds_db" {
  identifier          = "sfc-db-${var.environment}"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  engine              = "postgres"
  engine_version      = "14.7"
  db_name             = "sfctest"
  username            = "administrator" # TODO: We may want this as a random string
  password            = random_password.sfc_rds_password.result
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.sfc_rds_db_subnet_group.name
}

resource "aws_db_subnet_group" "sfc_rds_db_subnet_group" {
  name       = "sfc-vpc"
  subnet_ids = var.private_subnet_ids
}

resource "random_password" "sfc_rds_password" {
  length           = 20
  special          = false
}