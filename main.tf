provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amz_ec2" {
  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

# Variável vazia
# Nesse caso, consideramos que a ‘name’ é obrigatório
variable "name" {}

# Variável com valor padrão, se não for definida, o 'tf' vai ser utilizado
# Nesse caso, consideramos que a `prefix` é opcional
variable "prefix" {
  default = "tf"
}

# Cria uma t2.micro com o nome usando as variáveis prefix e name
resource "aws_instance" "variable_example" {
  ami           = "${data.aws_ami.amz_ec2.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "${var.prefix}-training-${var.name}"
  }
}

# Tipos de variáveis
# string
variable "v_string" {
  type    = "string"
  default = "value"
}

# string multiline
variable "v_long_string" {
  type = "string"

  default = <<EOF
This is a long key.
Running over several lines.
EOF
}

# number
variable "v_number" {
  default = 1
}

# map
variable "v_map" {
  type = "map"

  default = {
    "key1" = "value1"
    "key2" = "value2"
  }
}

# list
variable "v_list" {
  type    = "list"
  default = ["item1", "item2"]
}
