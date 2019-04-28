resource "aws_kms_key" "test-codepipeline-key" {
  enable_key_rotation = true
}

resource "aws_kms_alias" "test-codepipeline-key-alias" {
  name          = "alias/${var.application_name}-test-codepipeline-alias"
  target_key_id = "${aws_kms_key.test-codepipeline-key.id}"
}
