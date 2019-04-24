terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/codebuild-environment"
    region = "eu-west-1"
  }
}
