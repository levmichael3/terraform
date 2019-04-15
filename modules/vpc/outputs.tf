output "aws_vpc_id" {
    value = "${aws_vpc.infra-vpc.id}"
}

# output "aws_subnet_ids_private" {
#     value = ["${aws_subnet.infra-vpc-subnets-private.*.id}"]
# }
#
# output "aws_subnet_ids_public" {
#     value = ["${aws_subnet.infra-vpc-subnets-public.*.id}"]
# }


output "default_tags" {
    value = "${var.default_tags}"
}
