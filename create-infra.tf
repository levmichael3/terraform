terraform {
  # required_version = ">= 0.10.3" # introduction of Local Values configuration language feature

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

provider "aws" {
  profile = "automat"
  shared_credentials_file = "~/.aws/credentials"
  version = "~> 2.6.0"
}

data "aws_availability_zones" "available" {}


module "aws-vpc" {
  source = "modules/vpc"

  aws_infra_name      = "${var.aws_infra_name}"
  aws_vpc_cidr_block  = "${var.aws_vpc_cidr_block}"
  aws_avail_zones     = "${slice(data.aws_availability_zones.available.names,0,2)}"
  aws_cidr_subnets_private  = "${var.aws_cidr_subnets_private}"
  aws_cidr_subnets_public   = "${var.aws_cidr_subnets_public}"
  default_tags              = "${var.default_tags}"


}
