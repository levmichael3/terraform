#Global Vars
name      = "michael-terraform"
namespace = "michael"
stage     = "dev"
region    = "eu-west-1"


#VPC Vars
cidr_block = "10.250.192.0/18"
cidr_subnets_private = ["10.250.192.0/20","10.250.208.0/20"]
cidr_subnets_public = ["10.250.224.0/20","10.250.240.0/20"]
pub_az = ["eu-west-1a","eu-west-1b"]
pri_az = ["eu-west-1c","eu-west-1d"]

# ASG stuff
cpu_utilization_low_threshold_percent = 10
cpu_utilization_high_threshold_percent = 75
wait_for_capacity_timeout = "5m"
max_size =  2
min_size = 1


amazon_linux_instance_type = "t2.small"
