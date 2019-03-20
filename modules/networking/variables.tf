variable "identifier" { 
  description = "(Required) An identifier for the networking foundation."
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
variable "vpc_cidr" {
  description = "(Required) The CIDR block of the VPC."
}
variable "public_subnets_cidr" {
  type        = "list"
  description = "(Optional) List of CIDR blocks for the public subnets."
  default     = []
}
variable "private_subnets_cidr" {
  type        = "list"
  description = "(Optional) List of CIDR blocks for the private subnets."
  default     = []
}
variable "availability_zones" {
  type        = "list"
  description = "(Optional) The az that the resources will be launched."
  default     = []
}