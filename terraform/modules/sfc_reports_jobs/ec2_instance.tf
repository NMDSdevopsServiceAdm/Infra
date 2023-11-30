resource "aws_instance" "sfc_reports" {
  ami           = "ami-0694d931cee176e7d"
  instance_type = "t2.micro"
  key_name  = aws_key_pair.sfc_reports_ssh_key.key_name
  subnet_id =  var.private_subnet_ids[0]
  security_groups  = var.security_group_ids

 tags = {
    Name = "sfc-reports"
  }
}

resource "aws_key_pair" "sfc_reports_ssh_key" {
  key_name   = "sfc-reports-ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtuyQQeQi/qFnkPDGmE9yQsthj/urYtRH/I8R8Gu7uMsew0vUZM9sMPtt7TdTwoZs3T7BIe+AmBrMTm/smJttldnVj8Q5ajZdOxL15v6qcbkLhYKyfCWltGMMPKKwnyQP/IQPReUke4EirE5oJDE3dGv3tbVKhcHfcEqoxpnsEHVB5Lvu6qLnhdhInzoSEo1rPt54KGh00jFhULdHWSxJCEinIzqfgAqJ8Z4HpL6bO9LZTG4NvkP1NiPwykU+fnJqg/mYE7VbeEqswGkk7KpRGPdmsGCawflyfa32+8dEvEetDoKlmTLr+1fsq+g7H2IXlZag20aJe9+a8qpc+mwubgDaLUu9uXykpa8lwZuPVQtl0a4Ya0QIWIQDEROeXkoZHj8NUqTudCuFQj3Og0GjHoPPw5FUdVCDw6r5yRsO6nF9m5Ngk6uJLZdEMHdRBtLROpkGQiKrSCKFS9fALJEBtRSh0J/L9JxMDEKwz33WJnDl/QQLrey9kQXCeJEpzpxc= zayob@Administrators-MacBook-Pro-2.local"

}