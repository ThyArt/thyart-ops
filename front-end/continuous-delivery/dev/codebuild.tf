resource "aws_codebuild_project" "dev-codebuild-project" {
  "artifacts" {
    type = "CODEPIPELINE"
  }

  "environment" {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "kkarczmarczyk/node-yarn:latest"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "ACCESS_KEY_ID"
      value = "${var.codebuild_user_access_key_id}"
    }

    environment_variable {
      name  = "SECRET_ACCESS_KEY"
      value = "${var.codebuild_user_secret_access_key}"
    }

    environment_variable {
      name  = "API_ENDPOINT"
      value = "${jsondecode(${data.aws_secretsmanager_secret_version.frontend-dev-secret-version.secret_string})["api-endpoint"]}"
    }

    environment_variable {
      name  = "CLIENT_ID"
      value = "${jsondecode(${data.aws_secretsmanager_secret_version.frontend-dev-secret-version.secret_string})["client-id"]}"
    }

    environment_variable {
      name  = "CLIENT_SECRET"
      value = "${jsondecode(${data.aws_secretsmanager_secret_version.frontend-dev-secret-version.secret_string})["client-secret"]}"
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
