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
  instance_type = "${var.type}"
  # Count pode ser usado para "iterar" uma lista
  count         = "${length(var.names)}"

  tags = {
    Name = "${element(var.names, count.index)}"
  }
}

variable "type" {}

variable "names" {
  type = "list"
}