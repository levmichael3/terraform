
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

variable "availability_zones" {
  type        = "list"
  default     = []
  description = "Availability zones to use within region"
}


#
# variable "wait_for_capacity_timeout" {
#   type        = "string"
#   default     = "5m"
#   description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
# }
#
# variable "max_size" {
#   default     = 0
#   type        = "string"
#   description = "The maximum size of the autoscale group"
# }
#
# variable "min_size" {
#   default     = 0
#   type        = "string"
#   description = "The minimum size of the autoscale group"
# }
#
#
#
variable "memory_utilization_high_threshold" {
  type        = "string"
  description = "The maximum percentage of Memory utilization average."
  default     = "80"
}

variable "memory_utilization_low_threshold" {
  type        = "string"
  description = "The minimum percentage of Memory utilization average."
  default     = "20"
}
#
#

variable "amazon_linux_instance_type" {
  description = "The size of instance to launch"
  default     = ""
  type        = "string"
}



### ---- spotinst

variable "spotinst_token" {
  description = "The token used when accessing your Spotinst account"
}

variable "spotinst_account" {
  description = "Your Spotinst account"
}


variable "desired_capacity" {
  default     = "0"
  type        = "string"
  description = "The desired number of instances the group should have at any time"
}

variable "product" {
  default     = "Linux/UNIX"
  type        = "string"
  description = "Operation system type. Supported Arguments: Linux/UNIX, SUSE Linux, Windows. If you are using VPC in EC2 Classic regions: Linux/UNIX (Amazon VPC), SUSE Linux (Amazon VPC), Windows (Amazon VPC)."
}

variable "min_size" {
  default     = "0"
  type        = "string"
  description = "The minimum number of instances the group should have at any time."
}

variable "max_size" {
  default     = "0"
  type        = "string"
  description = "The maximum number of instances the group should have at any time."
}


variable "security_groups" {
  type        = "list"
  default     = []
  description = "A list of associated security group IDS."
}

variable "instance_types_ondemand" {
  type        = "string"
  description = "The type of instance determines your instance's CPU capacity, memory and storage (e.g., m1.small, c1.xlarge)."
}

variable "instance_types_spot" {
  type        = "list"
  description = "One or more instance types"
}

variable "orientation" {
  type        = "string"
  default     = "balanced"
  description = "Select a prediction strategy. Valid values: 'balanced, 'costOriented', 'equalAzDistribution', 'availabilityOriented'."

}

variable "capacity_unit" {
  type        = "string"
  default     = "instance"
  description = "The capacity unit to launch instances by. If not specified, when choosing the weight unit, each instance will weight as the number of its vCPUs."
}


variable "cpu_utilization_high_threshold_percent" {
  type        = "string"
  default     = "90"
  description = "The value against which the specified statistic is compared"
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  default     = []
  type        = "list"
}

variable "fallback_to_ondemand" {
  type        = "string"
  default     = true
  description = "In a case of no Spot instances available, Elastigroup will launch on-demand instances instead."
}

variable "spot_percentage" {
  type        = "string"
  default     = "0"
  description = "The percentage of Spot instances that would spin up from the desired_capacity number."
}

variable "revert_to_spot" {
  type        = "list"
  default = [{
    perform_at = "never"
  }]
  description = "Hold settings for strategy correction, replacing On-Demand for Spot instances, Supported Arguments: never / always /timeWindow"
}
