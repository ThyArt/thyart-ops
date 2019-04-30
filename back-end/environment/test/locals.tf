locals {
  front-end-configuration = {
    api-endpoint  = "http://${aws_elastic_beanstalk_environment.test-environment.cname}/"
    client-secret = "${random_string.test-passport-client-secret.result}"
    client-id     = 1
  }
}
