provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region = "us-east-1"
}

// Locals são variáveis locais
locals {
  instance_type = "t2.micro"
}


module "instance_a" {
  source = "./instance-module"

  names = ["Instance-A", "Instance-B"]
  type  = "${local.instance_type}"
}

resource "aws_instance" "multiple_instances" {
  ami           = "ami-0de53d8956e8dcf80"
  instance_type = "${local.instance_type}"
  # Count pode ser usado para criar mais de uma cópia de um recurso
  count         = 3

  tags = {
    Name = "Instance-C"
  }
}
resource "aws_instance" "no_instance" {
  ami           = "ami-0de53d8956e8dcf80"
  instance_type = "${local.instance_type}"
  # Count com valor 0 não cria nenhum recurso
  count         = 0

  tags = {
    Name = "Instance-D"
  }
}
