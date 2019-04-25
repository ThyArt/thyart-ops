resource "aws_s3_bucket" "sample-source-bucket" {
  bucket        = "thyart-api-sample"
  force_destroy = true
}

resource "aws_s3_bucket_object" "sample-source-zip" {
  bucket = "${aws_s3_bucket.sample-source-bucket.id}"
  key    = "beanstalk/sample-app.zip"
  source = "${path.module}/archive/dev-sample-app.zip"
}
