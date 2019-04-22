module "label" {
  source     = "../../../../modules/terraform-null-label-master"
  namespace  = "${var.namespace}"
  name       = "elastigroup"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}


data "aws_ami" "centos" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


resource "spotinst_elastigroup_aws" "default" {
  name                      = "${module.label.id}"
  description               = "Created by Terraform"
  product                   = "${var.product}"
  region                    = "${var.region}"

  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"

  desired_capacity           = "${var.desired_capacity}"
  capacity_unit              = "${var.capacity_unit}"
  orientation                = "${var.orientation}"

  image_id                   = "${data.aws_ami.centos.id}"
  security_groups            = ["${var.security_groups}"]

  subnet_ids                 = ["${var.subnet_ids}"]
  # availability_zones         = ["${var.availability_zones}"]

  fallback_to_ondemand       = "${var.fallback_to_ondemand}"

  instance_types_ondemand    = "${var.instance_types_ondemand}"
  instance_types_spot        = ["${var.instance_types_spot}"]
  placement_tenancy          = "default"

}
