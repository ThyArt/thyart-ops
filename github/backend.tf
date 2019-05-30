terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "github"
    region = "eu-west-1"
  }
}
