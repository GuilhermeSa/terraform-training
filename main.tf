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

variable "name" {}

resource "aws_instance" "output_example" {
  ami           = "${data.aws_ami.amz_ec2.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "tf-training-${var.name}"
  }
}

# Outputs da EC2 criada  
output "ec2_public_ip" {
  value = "${aws_instance.output_example.public_ip}"
}

output "ec2_id" {
  value = "${aws_instance.output_example.id}"
}

output "ec2_private_ip" {
  value = "${aws_instance.output_example.private_ip}"
}

output "ec2_public_dns" {
  value = "${aws_instance.output_example.public_dns}"
}
