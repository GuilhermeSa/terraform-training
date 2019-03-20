module "foundation" {
  source               = "../../modules/networking"
  identifier           = "${local.app_ecosystem}"
  environment          = "${local.environment}"
  provisioning_version = "${var.provisioning_version}"
  provisioning_source  = "${local.provisioning_source}"

  # VPC can have up to 65534 hosts.
  vpc_cidr = "10.101.0.0/16"

  # Each subnet can have up to 8190 hosts. Spare CIDR blocks: 10.109.64.0/18, 10.109.192.0/18
  public_subnets_cidr  = ["10.101.0.0/19", "10.101.32.0/19"]
  private_subnets_cidr = ["10.101.128.0/19", "10.101.160.0/19"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}
