provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "inst" {
  ami = "${random_pet.inst_name.keepers.ami_id}"
  instance_type = "t2.micro"

  key_name = "${aws_key_pair.key.key_name}"

  tags = {
      Name = "tft-${random_pet.inst_name.id}"
      User = "guilherme.sa"
      Provider = "terraform"
  }
}

resource "random_pet" "inst_name" {
  keepers = {
      ami_id = "ami-0de53d8956e8dcf80"
  }
}

resource "aws_key_pair" "key" {
    key_name = "tft-gsa"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeok71d5P1jygqwaxx4NL3sPsIWMc6bKSAbdGij31s68a5ulHHCTfwvB0cJXkA8DhxxQbRk4wRRVutGfuCu2DLP9ZVb7vnyMT/ZLLmhj9WfiRqxK0gsVpScurXDjPnlwDwNnPlGGB8eeIf2z4wGZyZBjfqSLMZz8qXxrqhB7JmgzAqWygBu13kfphuO5V2aoBjEoulJi9hciUYFUAlnWXIwNvffcwxmhXGGqAiI3cTBdx/6ZYo37xhg2P+ERv1AP0er8DwB1zgaSsZk5+2lylMjVvAlvwLBPr/iKcA0pNzyIDBQi7nChtkak2Y8grzhRQ0IkAiXWcK9/SSDDTp8I/N guilherme@N-CATHO-013927"    
}


