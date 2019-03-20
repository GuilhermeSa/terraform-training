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
  name = "Instance-A"
  type = "t2.micro"
}

# Módulos só podem conter dependências implícitas.
# O argumento depends_on não existe para módulos (Possivelmente isso será mudado a partir da versão 0.12)
module "s3-bucket" {
  source    = "cloudposse/s3-bucket/aws"
  version   = "0.3.0"
  name      = "${module.instance_a.id}-bucket"
  stage     = "lab"
  namespace = "tft"
}
