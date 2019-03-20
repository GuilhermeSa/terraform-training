output "arn" {
  value       = "${aws_security_group.sg.arn}"
  description = "The security group ARN."
}

output "id" {
  value       = "${aws_security_group.sg.id}"
  description = "The security group ID."
}

output "name" {
  value       = "${aws_security_group.sg.name}"
  description = "The security group name."
}