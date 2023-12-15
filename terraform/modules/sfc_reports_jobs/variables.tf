variable "environment" {
  description = "Name of environment we're deploying to"
  type        = string
}

variable "private_subnet_ids" {
  description = "The ID's of the private subnet used by the App Runner VPC connector"
}

variable "public_subnet_ids" {
  description = "The ID's of the public subnet used by the App Runner VPC connector"
}

variable "sfc_reports_instance_type" {
  description = "The instance type for the sfc reports EC2 instance"
}

variable "security_group_ids" {
  description = "The ID's of the security groups used by the App Runner VPC connector"
}

variable "vpc_id" {
  description = "The ID of the vpc"
}