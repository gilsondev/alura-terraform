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

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

# Resource tem um tipo e um nome
resource "aws_instance" "dev" {
  count                  = 3
  ami                    = "ami-083654bd07b5da81d" # Ubuntu Server 20.04 LTS
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["${aws_security_group.access_ssh_devs.id}"]
  tags = {
    Name = "terraform-dev-${count.index}"
  }
}


resource "aws_instance" "dev4" {
  ami                    = "ami-083654bd07b5da81d" # Ubuntu Server 20.04 LTS
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["${aws_security_group.access_ssh_devs.id}"]
  depends_on = [
    aws_s3_bucket.dev4
  ]
  tags = {
    Name = "dev4"
  }
}

resource "aws_instance" "dev5" {
  ami                    = "ami-083654bd07b5da81d" # Ubuntu Server 20.04 LTS
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["${aws_security_group.access_ssh_devs.id}"]
  tags = {
    Name = "dev5"
  }
}

resource "aws_instance" "dev6" {
  provider               = aws.us-east-2
  ami                    = "ami-0629230e074c580f2" # Ubuntu Server 20.04 LTS
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["${aws_security_group.access_ssh_devs-us-east-2.id}"]
  tags = {
    Name = "dev6"
  }
}

# Criando novo bucket
resource "aws_s3_bucket" "dev4" {
  bucket = "gilsonlabs-dev4"
  acl    = "private"

  tags = {
    Name = "gilsonlabs-dev4"
  }
}
