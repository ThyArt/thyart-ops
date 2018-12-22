resource "aws_ecr_repository" "codebuild_repository" {
  name = "${var.codebuild_image_name}"
  tags = {
    Project = "${var.application_name}",
    Team = "${var.team_name}"
    Version = "${var.version}"
  }
}

resource "null_resource" "build_image" {
  depends_on = ["aws_ecr_repository.codebuild_repository"]

  provisioner "local-exec" {
    command = "docker build -t ${aws_ecr_repository.codebuild_repository.repository_url} -f CodeBuild.DockerFile . "
  }
}

resource "null_resource" "login_to_ecr" {
  depends_on = ["null_resource.build_image"]

  provisioner "local-exec" {
    command = "`aws ecr get-login --region ${var.aws_region} --no-include-email`"
  }
}

resource "null_resource" "push_image" {
  depends_on = ["null_resource.login_to_ecr"]

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.codebuild_repository.repository_url}"
  }
}
