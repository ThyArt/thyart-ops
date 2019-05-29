resource "datadog_integration_aws" "integration-aws" {
  account_id = "${data.aws_caller_identity.current.account_id}"
  role_name  = "${aws_iam_role.datadog-aws-integration.name}"
}
