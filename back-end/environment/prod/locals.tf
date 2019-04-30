locals {
  front-end-configuration = {
    api-endpoint  = "http://${aws_elastic_beanstalk_environment.prod-environment.cname}/"
    client-secret = "${random_string.prod-passport-client-secret.result}"
    client-id     = 1
  }
}
