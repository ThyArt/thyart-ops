resource "aws_codebuild_project" "dev-codebuild-project" {
  "artifacts" {
    type = "CODEPIPELINE"
  }

  "environment" {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "kkarczmarczyk/node-yarn:latest"
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

    environment_variable {
      name  = "DEPLOYMENT_ENVIRONMENT"
      value = "dev"
    }
  }

  name         = "${var.application_name}-dev"
  service_role = "${aws_iam_role.dev-codebuild-role.arn}"

  "source" {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.dev-codebuild-bucket.bucket}"
  }
}
