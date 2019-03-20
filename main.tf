provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region = "us-east-1"
}

# Por padrão o terraform infere as dependências de acordo com as expressões utilizadas
data "aws_ami" "amz_ec2" {
  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "instance_a" {
  ami           = "${data.aws_ami.amz_ec2.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-A"
  }
}

# Nem sempre é possível inferir, nesses casos o “depends_on” pode ser utilizado
resource "aws_instance" "instance_b" {
  ami           = "${data.aws_ami.amz_ec2.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-B"
  }

  depends_on = ["aws_instance.instance_a"]
}

# Recursos sem dependências são criados em paralelo
resource "aws_instance" "instance_c" {
  ami           = "ami-0080e4c5bc078760e"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-C"
  }
}

resource "aws_instance" "instance_d" {
  ami           = "ami-0080e4c5bc078760e"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-D"
  }
}
