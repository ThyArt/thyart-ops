terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "key-pair"
    region = "eu-west-1"
  }
}
