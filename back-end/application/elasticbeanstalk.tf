resource "aws_elastic_beanstalk_application" "application" {
  name = "${var.application_name}"
}

resource "aws_elastic_beanstalk_application_version" "sample-applucation-version" {
  application = "${aws_elastic_beanstalk_application.application.name}"
  bucket      = "${aws_s3_bucket.sample-source-bucket.id}"
  key         = "${aws_s3_bucket_object.sample-source-zip.key}"
  name        = "${var.sample_app_name}"
}
