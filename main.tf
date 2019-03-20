provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region = "us-east-1"
}

# Módulos podem ser importados de diversas formas, tais como caminho relativo, endereço no Github ou endereço no Registry do Terraform.
# Para mais informações: https://www.terraform.io/docs/modules/sources.html
module "instance_a" {
  # Ao importar um novo módulo, o comando terraform init deve ser utilizado para que o Terraform baixe o módulo
  source = "./instance-module"

  # Variáveis definidas dentro de módulos podem ser passadas como argumentos
  names = ["Instance-A", "Instance-B"]
  type  = "t2.micro"
}

resource "aws_instance" "multiple_instances" {
  ami           = "ami-0de53d8956e8dcf80"
  instance_type = "t2.micro"
  # Count pode ser usado para criar mais de uma cópia de um recurso
  count         = 3

  tags = {
    Name = "Instance-C"
  }
}
resource "aws_instance" "no_instance" {
  ami           = "ami-0de53d8956e8dcf80"
  instance_type = "t2.micro"
  # Count com valor 0 não cria nenhum recurso
  count         = 0

  tags = {
    Name = "Instance-D"
  }
}
