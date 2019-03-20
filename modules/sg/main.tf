locals {
  sg_name = "secg-${var.app_ecosystem}-${var.app_name}-${var.environment}"
}

resource "aws_security_group" "sg" {
  name        = "${local.sg_name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name                           = "${local.sg_name}"
    "App::Name"             = "${var.app_name}"
    "App::Source"           = "${var.app_source}"
    "App::Ecosystem"        = "${var.app_ecosystem}"
    "Environment"           = "${var.environment}"
    "Provisioning::Tool"    = "terraform"
    "Provisioning::Version" = "${var.provisioning_version}"
    "Provisioning::Source"  = "${var.provisioning_source}"
    "Provisioning::Time"    = "${timestamp()}"
  }

  lifecycle {
    ignore_changes = ["tags.Catho::Provisioning::Time"]
  }
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = "${aws_security_group.sg.id}"
  type              = "ingress"
  cidr_blocks       = ["${var.ingress_cidr_blocks}"]

  count = "${length(var.ingress_rules)}"

  from_port = "${lookup(var.ingress_rules[count.index], "from_port", "_")}"
  to_port   = "${lookup(var.ingress_rules[count.index], "to_port", "_")}"
  protocol  = "${lookup(var.ingress_rules[count.index], "protocol", "_")}"
}

resource "aws_security_group_rule" "egress" {
  security_group_id = "${aws_security_group.sg.id}"
  type              = "egress"
  cidr_blocks       = ["${var.egress_cidr_blocks}"]

  count = "${length(var.egress_rules)}"

  from_port = "${lookup(var.egress_rules[count.index], "from_port", "_")}"
  to_port   = "${lookup(var.egress_rules[count.index], "to_port", "_")}"
  protocol  = "${lookup(var.egress_rules[count.index], "protocol", "_")}"
}