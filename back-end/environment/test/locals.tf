locals {
  front-end-configuration = {
    api-endpoint  = "https://${aws_route53_record.route53_cname_record.fqdn}/"
    client-secret = "${random_string.test-passport-client-secret.result}"
    client-id     = 1
  }
}
