resource "aws_codepipeline" "test-codepipeline" {
  name     = "${var.application_name}-test"
  role_arn = "${aws_iam_role.test-codepipeline-role.arn}"

  artifact_store {
    location = "${data.aws_s3_bucket.codepipeline-bucket.bucket}"
    type     = "S3"

    encryption_key {
      id   = "${aws_kms_key.test-codepipeline-key.arn}"
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      category         = "Source"
      name             = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration {
        RepositoryName = "${data.aws_codecommit_repository.codecommit-repository.repository_name}"
        BranchName     = "master"
      }
    }
  }

  stage {
    name = "Build"

    action {
      category         = "Build"
      name             = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration {
        ProjectName = "${aws_codebuild_project.test-codebuild-project.name}"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      category        = "Deploy"
      name            = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration {
        ApplicationName = "${var.application_name}"
        EnvironmentName = "${var.application_name}-test"
      }
    }
  }
}
