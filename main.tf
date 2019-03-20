provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region = "us-east-1"
}

// Por padrão o terraform infere as dependências de acordo com as expressões utilizadas
data "aws_ami" "amz_ec2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-*"]
  }

  owners = ["591542846629"] # AWS
}

resource "aws_instance" "instance_a" {
  ami           = "${data.aws_ami.amz_ec2.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-A"
  }
}

// Nem sempre é possível inferir, nesses casos o “depends_on” pode ser utilizado
resource "aws_instance" "instance_b" {
  ami           = "${data.aws_ami.amz_ec2.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-B"
  }

  depends_on = ["aws_instance.instance_a"]
}

// Recursos sem depêndencias são criados em paralelo
resource "aws_instance" "instance_c" {
  ami = "ami-0de53d8956e8dcf80"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-C"
  }
}
resource "aws_instance" "instance_d" {
  ami = "ami-0de53d8956e8dcf80"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-D"
  }
}