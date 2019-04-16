
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



variable "wait_for_capacity_timeout" {
  type        = "string"
  default     = "5m"
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
}

variable "max_size" {
  default     = 0
  description = "The maximum size of the autoscale group"
}

variable "min_size" {
  default     = 0
  description = "The minimum size of the autoscale group"
}

variable "cpu_utilization_high_threshold_percent" {
  type        = "string"
  default     = "80"
  description = "CPU utilization high threshold"
}

variable "cpu_utilization_low_threshold_percent" {
  type        = "string"
  default     = "20"
  description = "CPU utilization loq threshold"
}

variable "health_check_type" {
  default = "EC2"
  description = "Controls how health checking is done. Valid values are EC2 or ELB"
}

variable "amazon_linux_instance_type" {
  description = "The size of instance to launch"
  default     = ""
}
