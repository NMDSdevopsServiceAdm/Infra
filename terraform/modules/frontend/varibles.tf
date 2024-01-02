variable "environment" {
  description = "Name of environment we're deploying to"
  type        = string
}

variable "domain_name" {
  description = "Domain name of environment"
  type        = string
}

variable "app_runner_url" {
  description = "App Runner url"
  type        = string
}