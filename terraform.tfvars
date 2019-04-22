#Global Vars
name      = "terraform"
namespace = "michael"
stage     = "dev"
region    = "eu-west-1"


#VPC Vars
cidr_block = "10.250.192.0/18"
cidr_subnets_private = ["10.250.192.0/20"]
cidr_subnets_public = ["10.250.224.0/20"]
pub_az = ["eu-west-1c","eu-west-1a"]
pri_az = ["eu-west-1a","eu-west-1c"]

# cidr_subnets_public = ["10.250.224.0/20","10.250.240.0/20"]
# cidr_subnets_private = ["10.250.192.0/20","10.250.208.0/20"]

# pub_az = ["eu-west-1a","eu-west-1b"]
# pri_az = ["eu-west-1c","eu-west-1d"]

# ASG stuff
cpu_utilization_low_threshold_percent = 10
cpu_utilization_high_threshold_percent = 75

memory_utilization_low_threshold = 10
memory_utilization_high_threshold = 90

wait_for_capacity_timeout = "5m"
max_size =  "3"
min_size = "2"
desired_capacity = "3"

spot_percentage = "75"
revert_to_spot  = [
  {
    perform_at = "always"
  }
]


amazon_linux_instance_type = "t3.nano"
instance_types_ondemand    = "t3.nano"
instance_types_spot        = ["t3.nano"]

fallback_to_ondemand       = false
