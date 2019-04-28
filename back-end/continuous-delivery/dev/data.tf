data "aws_ecr_repository" "ecr-repository" {
  name = "${var.codebuild_image_name}"
}

data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "codebuild-bucket" {
  bucket = "${var.application_name}-codebuild"
}

data "aws_s3_bucket" "codepipeline-bucket" {
  bucket = "${var.application_name}-codepipeline"
}

data "aws_codecommit_repository" "codecommit-repository" {
  repository_name = "thyart-api"
}

data "aws_vpc" "codebuild-vpc" {
  tags {
    Name = "codebuild"
  }
}

data "aws_subnet" "codebuild-subnet-public-1" {
  tags {
    Name = "codebuild-public-1"
  }
}

data "aws_subnet" "codebuild-subnet-public-2" {
  tags {
    Name = "codebuild-public-1"
  }
}

data "aws_subnet" "codebuild-subnet-public-3" {
  tags {
    Name = "codebuild-public-1"
  }
}

data "aws_subnet" "codebuild-subnet-private-1" {
  tags {
    Name = "codebuild-private-1"
  }
}

data "aws_subnet" "codebuild-subnet-private-2" {
  tags {
    Name = "codebuild-private-2"
  }
}

data "aws_subnet" "codebuild-subnet-private-3" {
  tags {
    Name = "codebuild-private-3"
  }
}

data "aws_security_groups" "codebuild-security-groups" {
  tags {
    Name = "rds-codebuild"
    Name = "default"
  }
}
