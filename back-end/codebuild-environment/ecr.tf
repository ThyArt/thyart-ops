resource "aws_ecr_repository" "codebuild-repository" {
  name = "${var.codebuild_image_name}"

  tags = {
    Project = "${var.application_name}"
    Team    = "${var.team_name}"
    Version = "${var.version}"
  }
}

resource "aws_ecr_repository_policy" "policy-allow-codebuild" {
  repository = "${aws_ecr_repository.codebuild-repository.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CodeBuildAccess",
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer"
      ]
    }
  ]
}
EOF
}

resource "null_resource" "build-image" {
  depends_on = ["aws_ecr_repository.codebuild-repository"]

  provisioner "local-exec" {
    command = "docker build -t ${aws_ecr_repository.codebuild-repository.repository_url} --build-arg \"db_endpoint=${aws_db_instance.codebuild-rds-database.endpoint}\" --build-arg \"db_username=${aws_db_instance.codebuild-rds-database.username}\" --build-arg \"db_password=${aws_db_instance.codebuild-rds-database.password}\" --build-arg \"db_name=${aws_db_instance.codebuild-rds-database.name}\" --build-arg \"db_port=${aws_db_instance.codebuild-rds-database.port}\" ."
  }
}

resource "null_resource" "login-to-ecr" {
  depends_on = ["null_resource.build-image"]

  provisioner "local-exec" {
    command = "`aws ecr get-login --region ${var.aws_region} --no-include-email`"
  }
}

resource "null_resource" "push-image" {
  depends_on = ["null_resource.login-to-ecr"]

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.codebuild-repository.repository_url}"
  }
}
