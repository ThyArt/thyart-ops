terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/codebuild-image"
    region = "eu-west-1"
  }
}
