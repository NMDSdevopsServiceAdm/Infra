# data "aws_rds_reserved_instance_offering" "sfc_rds_db_reserved_instance" {
#   db_instance_class   = "db.t3.2xlarge"
#   duration            = 31536000
#   multi_az            = true
#   offering_type       = "No Upfront"
#   product_description = "postgresql"
# }

# resource "aws_rds_reserved_instance" "sfc_rds_db_reserved_instance" {
#   offering_id    = data.aws_rds_reserved_instance_offering.sfc_rds_db_reserved_instance.offering_id
#   instance_count = 1
# }