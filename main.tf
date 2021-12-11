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
  ami                    = var.amis["us-east-1"] # Ubuntu Server 20.04 LTS
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.access_ssh_devs.id}"]
  tags = {
    Name = "terraform-dev-${count.index}"
  }
}


resource "aws_instance" "dev4" {
  ami                    = var.amis["us-east-1"] # Ubuntu Server 20.04 LTS
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.access_ssh_devs.id}"]
  depends_on = [
    aws_s3_bucket.dev4
  ]
  tags = {
    Name = "dev4"
  }
}

resource "aws_instance" "dev5" {
  ami                    = var.amis["us-east-1"] # Ubuntu Server 20.04 LTS
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.access_ssh_devs.id}"]
  tags = {
    Name = "dev5"
  }
}

resource "aws_instance" "dev6" {
  provider               = aws.us-east-2
  ami                    = var.amis["us-east-2"] # Ubuntu Server 20.04 LTS
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${aws_security_group.access_ssh_devs-us-east-2.id}"]
  depends_on             = [aws_dynamodb_table.dynamodb-homologacao]
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

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider     = aws.us-east-2
  name         = ""
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}
