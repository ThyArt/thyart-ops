resource "aws_kms_key" "test-prod-codepipeline-key" {
  enable_key_rotation = true
}

resource "aws_kms_alias" "test-prod-codepipeline-key-alias" {
  name          = "alias/${var.application_name}-test-prod-codepipeline-alias"
  target_key_id = "${aws_kms_key.test-prod-codepipeline-key.id}"
}
