terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "thyart-ops"
    region = "eu-west-1"
  }
}
