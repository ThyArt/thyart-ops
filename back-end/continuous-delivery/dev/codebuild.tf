resource "aws_codebuild_project" "dev-codebuild-project" {
  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "${data.aws_ecr_repository.ecr-repository.repository_url}:latest"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "ACCESS_KEY_ID"
      value = "${var.codebuild_user_access_key_id}"
    }

    environment_variable {
      name  = "SECRET_ACCESS_KEY"
      value = "${var.codebuild_user_secret_access_key}"
    }
  }

  name         = "${var.application_name}-dev"
  service_role = "${aws_iam_role.dev-codebuild-role.arn}"

  source {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.dev-codebuild-bucket.bucket}"
  }
}
