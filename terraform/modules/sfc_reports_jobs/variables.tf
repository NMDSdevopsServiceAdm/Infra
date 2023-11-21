variable "environment" {
  description = "Name of environment we're deploying to"
  type        = string
}

variable "database_password" {
  description = "The password for the RDS database"
  type        = string
}

variable "database_username" {
  description = "The username for the RDS database"
  type        = string
}

variable "database_host" {
  description = "Name of the host for the RDS database"
  type        = string
}

variable "database_port" {
  description = "The post for the RDS database"
  type        = number
}

variable "database_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "private_subnet_ids" {
  description = "The ID's of the private subnet used by the App Runner VPC connector"
}

variable "security_group_ids" {
  description = "The ID's of the security groups used by the App Runner VPC connector"
}
