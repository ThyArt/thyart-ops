resource "aws_codebuild_project" "dev-codebuild-project" {
  "artifacts" {
    type = "CODEPIPELINE"
  }

  "environment" {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "${var.codebuild_image_name}"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "API_ENDPOINT"
      value = "${local.backend-connection-variables["api-endpoint"]}"
    }

    environment_variable {
      name  = "CLIENT_ID"
      value = "${local.backend-connection-variables["client-id"]}"
    }

    environment_variable {
      name  = "CLIENT_SECRET"
      value = "${local.backend-connection-variables["client-secret"]}"
    }
  }

  name         = "${var.application_name}-dev"
  service_role = "${aws_iam_role.dev-codebuild-role.arn}"

  "source" {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${data.aws_s3_bucket.codebuild-bucket.bucket}"
  }
}
