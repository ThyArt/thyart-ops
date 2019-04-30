resource "aws_codepipeline" "test-prod-codepipeline" {
  name     = "${var.application_name}-test-prod"
  role_arn = "${aws_iam_role.test-prod-codepipeline-role.arn}"

  artifact_store {
    location = "${data.aws_s3_bucket.codepipeline-bucket.bucket}"
    type     = "S3"

    encryption_key {
      id   = "${aws_kms_key.test-prod-codepipeline-key.arn}"
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
    name = "Build-Test"

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
    name = "Deploy-Test"

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

  stage {
    name = "Approval"

    "action" {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }

  stage {
    name = "Build-Prod"

    action {
      category         = "Build"
      name             = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration {
        ProjectName = "${aws_codebuild_project.prod-codebuild-project.name}"
      }
    }
  }

  stage {
    name = "Deploy-Prod"

    action {
      category        = "Deploy"
      name            = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration {
        ApplicationName = "${var.application_name}"
        EnvironmentName = "${var.application_name}-prod"
      }
    }
  }
}
