#!/bin/sh

# baixe o terraform
wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip

# caso não tenha o unzip instalado execute
sudo apt-get install unzip

# extraia usando o unzip
unzip terraform_0.11.13_linux_amd64.zip

# copie o executavel para o diretório bin
sudo cp terraform /usr/local/bin/

# verifique a versão
terraform --version

# remova os arquivos temporários
rm terraform terraform_0.11.13_linux_amd64.zip