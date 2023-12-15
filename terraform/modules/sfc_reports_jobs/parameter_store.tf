resource "aws_ssm_parameter" "sfc_reports_ssh_public_key" {
  name        = "/${var.environment}/ec2/sfc_reports_ssh_public_key"
  description = "The ssh_public_key for the sfc analysis file jobs"
  type        = "String"
  value       = "change-me"
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}