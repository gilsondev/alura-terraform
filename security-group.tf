# Criando um security group
resource "aws_security_group" "access_ssh_devs" {
  name        = "access_ssh_devs"
  description = "Grupo de seguranca dos devs para acesso SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["177.235.215.88/32"]
  }

  tags = {
    Name = "ssh"
  }
}

resource "aws_security_group" "access_ssh_devs-us-east-2" {
  provider    = aws.us-east-2
  name        = "access_ssh_devs"
  description = "Grupo de seguranca dos devs para acesso SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["177.235.215.88/32"]
  }

  tags = {
    Name = "ssh"
  }
}
