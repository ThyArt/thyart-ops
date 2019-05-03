terraform {
  backend "s3" {
    bucket = "thyart-ops"
    key    = "back-end/monitoring/aws-integration"
    region = "eu-west-1"
  }
}
