variable "environment" {
  description = "Name of environment we're deploying to"
  type        = string
}

variable "target_bucket" {
  description = "Name of target bucket we're deploying to"
  type        = string
}

variable "source_bucket" {
  description = "Name of source bucket we're deploying from"
  type        = string
}