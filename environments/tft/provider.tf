provider "aws" {
  region = "${local.default_region}"
}

locals {
  default_region      = "us-east-1"
  environment         = "lab"
  app_ecosystem       = "terraform-training"
  provisioning_source = "github.com/GuilhermeSa/terraform-training"
}
