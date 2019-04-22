variable "namespace" {
  type        = "string"
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
}

variable "stage" {
  type        = "string"
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
}

variable "environment" {
  type        = "string"
  default     = ""
  description = "Environment, e.g. 'testing', 'UAT'"
}

variable "name" {
  type        = "string"
  default     = "app"
  description = "Solution name, e.g. 'app' or 'cluster'"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
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


variable "region" {
  type        = "string"
  description = "Region for ElasticGroup"
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
  description = "A list of associated security group IDS."
}

variable "instance_types_ondemand" {
  type        = "string"
  description = "The type of instance determines your instance's CPU capacity, memory and storage (e.g., m1.small, c1.xlarge)."
}

variable "instance_types_spot" {
  type        = "list"
  default     = []
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

variable "availability_zones" {
  type        = "list"
  default     = []
  description = "Availability zones to use within region"
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
