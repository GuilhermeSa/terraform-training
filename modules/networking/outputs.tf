output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
  description = "The VPC ID."
}

output "public_subnets_id" {
  value = ["${aws_subnet.public_subnet.*.id}"]
  description = "A list of the public subnets IDs."
}

output "private_subnets_id" {
  value = ["${aws_subnet.private_subnet.*.id}"]
  description = "A list of the private subnets IDs."
}

output "default_sg_id" {
  value = "${module.security_group.id}"
  description = "The security group ID."
}