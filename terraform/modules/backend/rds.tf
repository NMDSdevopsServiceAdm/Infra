resource "aws_db_instance" "sfc_rds_db" {
  identifier          = "sfc-db-${var.environment}"
  instance_class      = var.rds_instance_class
  allocated_storage   = var.rds_allocated_storage
  engine              = "postgres"
  engine_version      = "14.7"
  db_name             = "sfcdb_${random_string.sfc_rds_db_name_id.result}"
  username            = random_string.sfc_rds_db_username.result
  password            = random_password.sfc_rds_password.result
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.sfc_rds_db_subnet_group.name
  multi_az             = var.multi_az
  vpc_security_group_ids = var.security_group_ids
  backup_retention_period = var.rds_db_backup_retention_period
  apply_immediately = true
}

resource "aws_db_subnet_group" "sfc_rds_db_subnet_group" {
  name       = "sfc-vpc"
  subnet_ids = var.private_subnet_ids
}

resource "random_password" "sfc_rds_password" {
  length           = 20
  special          = false
}

resource "random_string" "sfc_rds_db_name_id" {
  length           = 20
  special          = false
}

resource "random_string" "sfc_rds_db_username" {
  length           = 20
  special          = false
}

data "aws_rds_reserved_instance_offering" "sfc_rds_db_reserved_instance" {
  db_instance_class   = "db.t3.2xlarge"
  duration            = 31536000
  multi_az            = true
  offering_type       = "No Upfront"
  product_description = "postgresql"
}

resource "aws_rds_reserved_instance" "sfc_rds_db_reserved_instance" {
  offering_id    = data.aws_rds_reserved_instance_offering.sfc_rds_db_reserved_instance.offering_id
  reservation_id = "optionalCustomReservationID"
  instance_count = 1
}