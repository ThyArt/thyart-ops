resource "aws_kms_key" "dev-codepipeline-key" {
  enable_key_rotation = true
}

resource "aws_kms_alias" "dev-codepipeline-key-alias" {
  name          = "alias/${var.application_name}-dev-codepipeline-alias"
  target_key_id = "${aws_kms_key.dev-codepipeline-key.id}"
}
