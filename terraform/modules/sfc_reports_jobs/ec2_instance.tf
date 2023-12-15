resource "aws_instance" "sfc_reports" {
  ami           = "ami-0694d931cee176e7d"
  instance_type = var.sfc_reports_instance_type
  key_name  = aws_key_pair.sfc_reports_ssh_key.key_name
  subnet_id =  var.public_subnet_ids[0]
  vpc_security_group_ids  = [var.security_group_ids[0], aws_security_group.ssh_access.id]

 tags = {
    Name = "sfc-reports"
  }
}

resource "aws_key_pair" "sfc_reports_ssh_key" {
  key_name   = "sfc-reports-ssh-key"
  public_key = aws_ssm_parameter.sfc_reports_ssh_public_key.value
}

resource "aws_security_group" "ssh_access" {
  vpc_id      = var.vpc_id
  # Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = []
  }
}