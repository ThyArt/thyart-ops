data "aws_elastic_beanstalk_solution_stack" "dev-solution-stack" {
  name_regex  = "^64bit Amazon Linux 2018.03 (.*) running PHP 7.2$"
  most_recent = true
}

data "aws_s3_bucket" "codebuild-bucket" {
  bucket = "${var.application_name}-codebuild"
}

data "aws_s3_bucket" "codepipeline-bucket" {
  bucket = "${var.application_name}-codebuild"
}
