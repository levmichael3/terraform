resource "aws_vpc" "infra-vpc" {
  cidr_block = "${var.aws_vpc_cidr_block}"

  #DNS Related Entries
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = "${merge(var.default_tags, map(
    "Name", "${var.aws_infra_name}-vpc"
    ))}"

  }

  resource "aws_eip" "infra-nat-eip" {
    count    = "${length(var.aws_cidr_subnets_public)}"
    vpc      = true
  }


  resource "aws_internet_gateway" "infra-vpc-internetgw" {
    vpc_id = "${aws_vpc.infra-vpc.id}"

    tags = "${merge(var.default_tags, map(
      "Name", "${var.aws_infra_name}-internetgw"
      ))}"
    }

    resource "aws_subnet" "infra-vpc-subnets-public" {
      vpc_id = "${aws_vpc.infra-vpc.id}"
      count="${length(var.aws_avail_zones)}"
      availability_zone = "${element(var.aws_avail_zones, count.index)}"
      cidr_block = "${element(var.aws_cidr_subnets_public, count.index)}"

      tags = "${merge(var.default_tags, map(
        "Name", "${var.aws_infra_name}-${element(var.aws_avail_zones, count.index)}-public"
        ))}"
      }
