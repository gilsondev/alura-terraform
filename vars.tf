variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-083654bd07b5da81d"
    "us-east-2" = "ami-0629230e074c580f2"
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "terraform-aws"
}

variable "cdirs_remote_access" {
  type    = list(string)
  default = ["177.235.215.88/32"]
}
