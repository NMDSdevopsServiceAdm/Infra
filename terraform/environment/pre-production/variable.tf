variable "environment" {
  description = "Name of environment we're deploying to"
  type        = string
}

variable "app_runner_cpu" {
  description = "The CPU size you wish to use on AWS App Runner"
  type        = number
}

variable "app_runner_memory" {
  description = "The memory size you wish to use on AWS App Runner"
  type        = number
}

variable "rds_instance_class" {
  description = "The instance class for AWS RDS"
  type        = string
}

variable "rds_allocated_storage" {
  description = "The amount of storage assigned to AWS RDS"
  type        = number
}