# Novo modo de preparação do provider
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#example-usage
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

# Resource tem um tipo e um nome
resource "aws_instance" "dev" {
  count                  = 3
  ami                    = "ami-083654bd07b5da81d" # Ubuntu Server 20.04 LTS
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-08223c4aa02776d7f"]
  tags = {
    Name = "terraform-dev-${count.index}"
  }
}

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
