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

  vpc_config {
    security_group_ids = ["${data.aws_security_groups.codebuild-security-groups.ids}"]
    vpc_id             = "${data.aws_vpc.codebuild-vpc.id}"

    subnets =
    ["${data.aws_subnet.codebuild-subnet-public-1.id}",
      "${data.aws_subnet.codebuild-subnet-public-2.id}",
      "${data.aws_subnet.codebuild-subnet-public-3.id}",
      "${data.aws_subnet.codebuild-subnet-private-1.id}",
      "${data.aws_subnet.codebuild-subnet-private-2.id}",
      "${data.aws_subnet.codebuild-subnet-private-3.id}",
    ]
  }

  name         = "${var.application_name}-dev"
  service_role = "${aws_iam_role.dev-codebuild-role.arn}"

  source {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${data.aws_s3_bucket.codebuild-bucket.bucket}"
  }
}
