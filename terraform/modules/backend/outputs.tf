output "database_password" {
  value = aws_ssm_parameter.database_password.value
}

output "database_username" {
  value = aws_ssm_parameter.database_username.value
}

output "database_port" {
  value = aws_ssm_parameter.database_port.value
}

output "database_name" {
  value = aws_ssm_parameter.database_name.value
}

output "database_host" {
  value = aws_ssm_parameter.database_host.value
}
