provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region = "us-east-1"
}

# Ao comentar, use "#" seguido de espaço
# Nomes de recursos, variáveis e parâmetros devem seguir o formato snake_case.
resource "aws_iam_role" "iam_role" {
  # As únicas exceções ao formato snake_case são os nomes de recursos dentro da própria AWS.
  # Nomes de recursos AWS devem seguir o formato kebab-case.
  name = "${var.resource_name}-role"
  # Parâmetros dentro da definição de um recurso devem estar alinhados
  # Usar 2 espaços ao indentar recursos exceto ao definir políticas ou recursos inline
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}