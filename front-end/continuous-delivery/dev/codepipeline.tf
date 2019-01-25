resource aws_codepipeline "dev-codepipeline" {
  name     = "${var.application_name}-dev"
  role_arn = "${aws_iam_role.dev-codepipeline-role.arn}"

  artifact_store {
    location = "${aws_s3_bucket.dev-codepipeline-bucket.bucket}"
    type     = "S3"

    encryption_key {
      id   = "${aws_kms_key.dev-codepipeline-key.arn}"
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
        BranchName     = "dev"
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
        ProjectName = "${aws_codebuild_project.dev-codebuild-project.name}"
      }
    }
  }

  stage {
    name = "Deploy"

    "action" {
      category         = "Invoke"
      name             = "Deploy"
      owner            = "AWS"
      provider         = "Lambda"
      input_artifacts  = ["BuildArtifact"]
      output_artifacts = ["Thyart-Web-Dev"]
      version          = "1"

      configuration {
        FunctionName   = "${aws_lambda_function.statics3deploy.function_name}"
        UserParameters = "{\"artifact\":\"BuildArtifact\", \"s3StaticSiteBucket\":\"thyart-web-dev\", \"s3StaticSiteBucketRegion\":\"eu-west-1\", \"sourceDirectory\":\"./build\"}"
      }
    }
  }
}
