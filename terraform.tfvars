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
