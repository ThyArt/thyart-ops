resource "aws_elastic_beanstalk_application" "application" {
  count = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  name  = "${var.application_name}"
}