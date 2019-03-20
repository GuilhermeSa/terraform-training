/*====
The VPC
======*/
locals {
  vpc_name = "vpc-${var.identifier}-${var.environment}"
  igw_name = "igw-${var.identifier}-${var.environment}"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name                    = "${local.vpc_name}"
    Environment             = "${var.environment}"
    "Provisioning::Tool"    = "terraform"
    "Provisioning::Version" = "${var.provisioning_version}"
    "Provisioning::Source"  = "${var.provisioning_source}"
    "Provisioning::Time"    = "${timestamp()}"
  }

  lifecycle {
    ignore_changes = ["tags.Provisioning::Time"]
  }
}

# /*====
# Subnets
# ======*/
/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name                    = "${local.igw_name}"
    Environment             = "${var.environment}"
    "Provisioning::Tool"    = "terraform"
    "Provisioning::Version" = "${var.provisioning_version}"
    "Provisioning::Source"  = "${var.provisioning_source}"
    "Provisioning::Time"    = "${timestamp()}"
  }

  lifecycle {
    ignore_changes = ["tags.Provisioning::Time"]
  }
}

# /* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = ["aws_internet_gateway.ig"]
}

# /* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, 0)}"
  depends_on    = ["aws_internet_gateway.ig"]

  tags {
    Name                    = "nat-${var.identifier}-${element(var.availability_zones, count.index)}-${var.environment}"
    Environment             = "${var.environment}"
    "Provisioning::Tool"    = "terraform"
    "Provisioning::Version" = "${var.provisioning_version}"
    "Provisioning::Source"  = "${var.provisioning_source}"
    "Provisioning::Time"    = "${timestamp()}"
  }

  lifecycle {
    ignore_changes = ["tags.Provisioning::Time"]
  }
}

# /* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  count                   = "${length(var.public_subnets_cidr)}"
  cidr_block              = "${element(var.public_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name                    = "public-subnet-${var.identifier}-${var.environment}-${element(var.availability_zones, count.index)}"
    Environment             = "${var.environment}"
    "Provisioning::Tool"    = "terraform"
    "Provisioning::Version" = "${var.provisioning_version}"
    "Provisioning::Source"  = "${var.provisioning_source}"
    "Provisioning::Time"    = "${timestamp()}"
  }

  lifecycle {
    ignore_changes = ["tags.Provisioning::Time"]
  }
}

# /* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  count                   = "${length(var.private_subnets_cidr)}"
  cidr_block              = "${element(var.private_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name                    = "private-subnet-${var.identifier}-${var.environment}-${element(var.availability_zones, count.index)}"
    Environment             = "${var.environment}"
    "Provisioning::Tool"    = "terraform"
    "Provisioning::Version" = "${var.provisioning_version}"
    "Provisioning::Source"  = "${var.provisioning_source}"
    "Provisioning::Time"    = "${timestamp()}"
  }

  lifecycle {
    ignore_changes = ["tags.Provisioning::Time"]
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name                    = "private-route-table-${var.identifier}-${var.environment}"
    Environment             = "${var.environment}"
    "Provisioning::Tool"    = "terraform"
    "Provisioning::Version" = "${var.provisioning_version}"
    "Provisioning::Source"  = "${var.provisioning_source}"
    "Provisioning::Time"    = "${timestamp()}"
  }

  lifecycle {
    ignore_changes = ["tags.Provisioning::Time"]
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name                    = "public-route-table-${var.identifier}-${var.environment}"
    Environment             = "${var.environment}"
    "Provisioning::Tool"    = "terraform"
    "Provisioning::Version" = "${var.provisioning_version}"
    "Provisioning::Source"  = "${var.provisioning_source}"
    "Provisioning::Time"    = "${timestamp()}"
  }

  lifecycle {
    ignore_changes = ["tags.Provisioning::Time"]
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

/* Route table associations */
resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

module "security_group" {
  source               = "../sg"
  app_name             = "default-${var.identifier}-${var.environment}"
  environment          = "${var.environment}"
  description          = "Default security group to allow inbound/outbound from the VPC"
  vpc_id               = "${aws_vpc.vpc.id}"
  ingress_cidr_blocks  = ["0.0.0.0/0"]
  provisioning_version = "${var.provisioning_version}"
  provisioning_source  = "${var.provisioning_source}"

  ingress_rules = [
    {
      from_port = "0"
      to_port   = "0"
      protocol  = "-1"
    },
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = [
    {
      from_port = "0"
      to_port   = "0"
      protocol  = "-1"
    },
  ]
}
