#Global Vars
aws_infra_name = "michael-terraform"

#VPC Vars
aws_vpc_cidr_block = "10.250.192.0/18"
aws_cidr_subnets_private = ["10.250.192.0/20","10.250.208.0/20"]
aws_cidr_subnets_public = ["10.250.224.0/20","10.250.240.0/20"]
aws_avail_zones = ["eu-west-1a","eu-west-1b"]

default_tags = {
  Owner = "michael"
}
