# O provider é responsável por entender as interações da API e expôr recursos.
# Providers geralmente são IaaS (ex: AWS, GCP, Azure), SaaS (ex: Heroku) ou PaaS (ex: Cloudflare)
# Mais info em: https://www.terraform.io/docs/providers/index.html
provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region = "us-east-1"
}

# Recursos são os elementos mais importantes do Terraform.
# Cada bloco de recurso descreve um ou mais objetos de infraestrutura, como
# redes, instâncias, etc
resource "aws_instance" "sample_instance" {
  ami = "ami-0de53d8956e8dcf80"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
    Key  = "Value"
  }
}
