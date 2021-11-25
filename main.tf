# Novo modo de preparação do provider
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#example-usage
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0" 
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

# Resource tem um tipo e um nome
resource "aws_instance" "dev" {
  count = 3
  ami = "ami-083654bd07b5da81d"   # Ubuntu Server 20.04 LTS
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "terraform-dev-${count.index}"
  }
}