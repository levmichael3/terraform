
//AWS VPC Variables

variable "cidr_block" {
  description = "CIDR Block for VPC"
}

variable "cidr_subnets_private" {
  description = "CIDR Blocks for private subnets in Availability Zones"
  type = "list"
}

variable "cidr_subnets_public" {
  description = "CIDR Blocks for public subnets in Availability Zones"
  type = "list"
}

variable "pub_az" {
  description = "Public zones for VPC subnets"
  type = "list"
}

variable "pri_az" {
  description = "Private zones for VPC subnets"
  type = "list"
}


variable "namespace" {
  type        = "string"
  description = "Namespace (e.g. eg)"
}

variable "stage" {
  type        = "string"
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "name" {
  type        = "string"
  description = "Application or solution name (e.g. `app`)"
}

variable "region" {
  type        = "string"
  description = "Region for VPC"
}

# variable "availability_zones" {
#   type        = "list"
#   description = "Availability zones to use within region"
# }
