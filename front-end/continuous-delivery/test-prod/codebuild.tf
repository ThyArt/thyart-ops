resource "aws_codebuild_project" "test-codebuild-project" {
  "artifacts" {
    type = "CODEPIPELINE"
  }

  "environment" {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "${var.application_image}"
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

  name         = "${var.application_name}-test"
  service_role = "${aws_iam_role.test-codebuild-role.arn}"

  "source" {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${data.aws_s3_bucket.codebuild-bucket.bucket}"
  }
}

resource "aws_codebuild_project" "prod-codebuild-project" {
  "artifacts" {
    type = "CODEPIPELINE"
  }

  "environment" {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "${var.application_image}"
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

  name         = "${var.application_name}-prod"
  service_role = "${aws_iam_role.prod-codebuild-role.arn}"

  "source" {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${data.aws_s3_bucket.codebuild-bucket.bucket}"
  }
}
