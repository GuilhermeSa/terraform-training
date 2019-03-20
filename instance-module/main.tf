# Módulo é uma forma de encapsular código Terraform
data "aws_ami" "amz_ec2" {
  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "instance" {
  ami           = "${data.aws_ami.amz_ec2.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "${var.name}"
  }
}

variable "name" {}
variable "type" {}

output "id" {
  value = "${aws_instance.instance.id}"
}
