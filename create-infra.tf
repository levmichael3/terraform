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
  region = "eu-west-1"
}

# Configure the Spotinst provider
provider "spotinst" {
  token         = "${var.spotinst_token}"
  account       = "${var.spotinst_account}"
}

data "aws_availability_zones" "available" {}


module "vpc" {
  source      = "modules/terraform-aws-vpc-master"
  namespace   = "${var.namespace}"
  name        = "${var.name}"
  stage       = "${var.stage}"
  cidr_block  = "${var.cidr_block}"
}

module "web_server_sg" {
  source = "modules/terraform-aws-security-group-master/modules/http-80"

  name                = "web-server"
  description         = "Security group for web-server with HTTP ports open within VPC"
  vpc_id              = "${module.vpc.vpc_id}"
  # namespace           = "${var.namespace}"
  # stage               = "${var.stage}"
  # name                = "${var.name}"
  ingress_cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
}

module "ssh_sg" {
  source = "modules/terraform-aws-security-group-master/modules/ssh"

  name                = "ssh"
  description         = "Security group for SSH ports open within VPC"
  vpc_id              = "${module.vpc.vpc_id}"
  # namespace           = "${var.namespace}"
  # stage               = "${var.stage}"
  # name                = "${var.name}"
  ingress_cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
}


locals {
  public_cidr_block  = "${cidrsubnet(module.vpc.vpc_cidr_block, 1, 0)}"
  private_cidr_block = "${cidrsubnet(module.vpc.vpc_cidr_block, 1, 1)}"
}

module "public_subnets" {
  source              = "modules/terraform-aws-multi-az-subnets-master"
  namespace           = "${var.namespace}"
  stage               = "${var.stage}"
  name                = "${var.name}"
  availability_zones  = "${var.pub_az}"
  vpc_id              = "${module.vpc.vpc_id}"
  cidr_block          = "${local.public_cidr_block}"
  type                = "public"
  igw_id              = "${module.vpc.igw_id}"
  nat_gateway_enabled = "true"
}


module "private_subnets" {
  source              = "modules/terraform-aws-multi-az-subnets-master"
  namespace           = "${var.namespace}"
  stage               = "${var.stage}"
  name                = "${var.name}"
  availability_zones  = "${var.pri_az}"
  vpc_id              = "${module.vpc.vpc_id}"
  cidr_block          = "${local.private_cidr_block}"
  type                = "private"

  # Map of AZ names to NAT Gateway IDs that was created in "public_subnets" module
  az_ngw_ids          = "${module.public_subnets.az_ngw_ids}"

  # Need to explicitly provide the count since Terraform currently can't use dynamic count on computed resources from different modules
  # https://github.com/hashicorp/terraform/issues/10857
  # https://github.com/hashicorp/terraform/issues/12125
  # https://github.com/hashicorp/terraform/issues/4149
  # az_ngw_count = "${length(var.pri_az)}"
  az_ngw_count = 1
}



#
# module "sns_topic" {
#   source            = "modules/terraform-aws-sns-master"
#   name              = "${var.name}"
#   namespace         = "${var.namespace}"
#   stage             = "${var.stage}"
#
# }

module "notify_slack" {
  source                = "modules/terraform-aws-notify-slack-master"
  slack_webhook_url     = "https://hooks.slack.com/services/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"
  slack_channel         = "michael-tests"
  slack_username        = "reporter"
  sns_topic_name        = "${var.name}"
  namespace             = "${var.namespace}"
  stage                 = "${var.stage}"
  name                  = "${var.name}"
}


module "ssh_key_pair" {
  source                = "modules/terraform-aws-key-pair-master"
  namespace             = "${var.namespace}"
  stage                 = "${var.stage}"
  name                  = "${var.name}"
  ssh_public_key_path   = "./secrets"
  generate_ssh_key      = "true"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
  chmod_command         = "chmod 600 %v"
}

locals {
  userdata = <<USERDATA
    #!/bin/bash
    cat <<"__EOF__" > /home/ec2-user/.ssh/config
    Host *
      StrictHostKeyChecking no
    __EOF__
    chmod 600 /home/ec2-user/.ssh/config
    chown ec2-user:ec2-user /home/ec2-user/.ssh/config
USERDATA
}

#
#
#
#
#
# resource "aws_launch_configuration" "centos_lc" {
#   # name          = "${var.name}"
#   image_id      = "${data.aws_ami.centos.id}"
#   instance_type = "t2.micro"
#
#   lifecycle {
#     create_before_destroy = true
#   }
# }



# data "template_file" "az_subnet_ids" {
#   count    = "${length(var.pub_az)}"
#   template = "${lookup(var.pub_az[count.index], "az_subnet_ids")}"
# }


module "spotinst_elastigroup_aws"  {
  source              = "modules/terraform-aws-spotinst-master/modules/spotinst_elastigroup"
  name                = "${var.name}"
  stage               = "${var.stage}"
  namespace           = "${var.namespace}"
  region              = "${var.region}"

  # Run a fixed number of instances in the ASG
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"

  desired_capacity           = "${var.desired_capacity}"
  capacity_unit              = "${var.capacity_unit}"
  orientation                = "${var.orientation}"

  security_groups            = ["${module.ssh_sg.this_security_group_id}"]
  subnet_ids                 = ["${values(module.public_subnets.az_subnet_ids)}"]

  fallback_to_ondemand       = "${var.fallback_to_ondemand}"
  spot_percentage            = "${var.spot_percentage}"
  revert_to_spot             = "${var.revert_to_spot}"

  instance_types_ondemand    = "${var.instance_types_ondemand}"
  instance_types_spot        = "${var.instance_types_spot}"


}


module "ec2_service_alarms" {
  source         = "modules/terraform-aws-ec2-cloudwatch-sns-alarms-master"
  namespace      = "${var.namespace}"
  stage          = "${var.stage}"
  name           = "${var.name}"

  cpu_utilization_high_threshold  = "${var.cpu_utilization_high_threshold_percent}"
  cpu_utilization_high_ok_actions = ["${module.notify_slack.this_slack_topic_arn}"]

  cpu_utilization_low_threshold       = "${var.cpu_utilization_high_threshold_percent}"
  cpu_utilization_low_alarm_actions   = ["${module.notify_slack.this_slack_topic_arn}"]

  # cpu_utilization_high_alarm_actions  = "${module.notify_slack.this_slack_topic_arn}"

  memory_utilization_high_threshold   = "${var.memory_utilization_high_threshold}"
  memory_utilization_low_threshold    = "${var.memory_utilization_low_threshold}"


}
