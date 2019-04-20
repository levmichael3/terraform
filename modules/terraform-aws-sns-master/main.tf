module "sns_label" {
  source     = "../../modules/terraform-null-label-master"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  name       = "sns_topic"
  attributes = "${var.attributes}"
  delimiter  = "${var.delimiter}"
  tags       = "${var.tags}"
}

resource "aws_sns_topic" "sns_topic" {
  count               = "${var.create_sns_topic}"
  name                = "${module.sns_label.id}"
}
