variable "environment" {
  description = "Name of environment we're deploying to"
  type        = string
}

variable "app_runner_cpu" {
  description = "The CPU size you wish to use on AWS App Runner"
  type        = string
}

variable "app_runner_memory" {
  description = "The memory size you wish to use on AWS App Runner"
  type        = string
}

variable "rds_instance_class" {
  description = "The instance class for AWS RDS"
  type        = string
}

variable "rds_allocated_storage" {
  description = "The amount of storage assigned to AWS RDS"
  type        = number
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
}

variable "elasticache_node_type" {
  description = "The node type for AWS elasticache"
  type        = string
}

variable "app_runner_min_container_instances_size" {
  description = "The minimum number of container instance for AWS App runner"
  type        = number
}
variable "app_runner_max_container_instances_size" {
  description = "The maximum number of container instance for AWS App runner"
  type        = number
}

variable "app_runner_url" {
  description = "The app runner url"
  type        = string
}
variable "app_runner_max_concurrency" {
  description = "The maximum number of concurrency for a single AWS App runner container instance"
  type        = number
}
variable "rds_db_backup_retention_period" {
  description = "The amount of days to retain the database backup"
}

variable "domain_name" {
  description = "Domain name of environment"
  type        = string
}

variable "sfc_reports_instance_type" {
  description = "The instance type for the sfc reports EC2 instance"
}

variable "node_env" {
  description = "The Node Environment Varible to use the correct config"
  type        = string
}