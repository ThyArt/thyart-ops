locals {
  front-end-configuration = {
    api-endpoint  = "${aws_elastic_beanstalk_environment.dev-environment.cname}"
    client-secret = "${random_string.dev-passport-client-secret.result}"
    client-id     = 1
  }
}
