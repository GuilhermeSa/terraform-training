variable "app_name" {
  description = "(Required, Forces new resource) Unique identifier for the security group. Preferably the application name."
}

variable "app_source" {
  description = "(Optional) The application repository url."
  default     = ""
}

variable "environment" {
  description = "(Required) The environment."
}

variable "provisioning_version" {
  description = "(Required) Infrastructure code version."
}

variable "provisioning_source" {
  description = "(Required) Infrastructure code github repository."
}

variable "app_ecosystem" {
  description = "(Optional) The app ecosystem."
  default     = ""
}

variable "description" {
  description = "(Optional, Forces new resource) Security group description."
  default     = ""
}

variable "vpc_id" {
  description = "(Forces new resource) VPC ID where the security group will be created."
}

variable "ingress_cidr_blocks" {
  description = "(Optional) List of IPv4 CIDR ranges to use on all ingress rules"
  default     = []
}

variable "ingress_rules" {
  description = "(Optional) List of ingress rules"
  default     = []
}

variable "egress_cidr_blocks" {
  description = "(Optional) List of IPv4 CIDR ranges to use on all ingress rules"
  default     = []
}

variable "egress_rules" {
  description = "(Optional) List of ingress rules"
  default     = []
}