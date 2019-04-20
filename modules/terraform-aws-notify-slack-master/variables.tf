variable "create" {
  description = "Whether to create all resources"
  default     = true
}

variable "create_sns_topic" {
  description = "Whether to create new SNS topic"
  default     = true
}

variable "create_with_kms_key" {
  description = "Whether to create resources with KMS encryption"
  default     = false
}

variable "lambda_function_name" {
  description = "The name of the Lambda function to create"
  default     = "notify_slack"
}

variable "sns_topic_name" {
  description = "The name of the SNS topic to create"
}

variable "slack_webhook_url" {
  description = "The URL of Slack webhook"
}

variable "slack_channel" {
  description = "The name of the channel in Slack for notifications"
}

variable "slack_username" {
  description = "The username that will appear on Slack messages"
}

variable "slack_emoji" {
  description = "A custom emoji that will appear on Slack messages"
  default     = ":aws:"
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used for decrypting slack webhook url"
  default     = ""
}


variable "namespace" {
  description = "Namespace (e.g. `cp` or `cloudposse`)"
  type        = "string"
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = "string"
}

variable "name" {
  type        = "string"
  description = "Application or solution name"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}
