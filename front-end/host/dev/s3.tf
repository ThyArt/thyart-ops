resource "aws_s3_bucket" "hosting-bucket" {
  bucket = "${var.application_name}-dev"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "hosting-bucket-policy" {
  bucket = "${aws_s3_bucket.hosting-bucket.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.application_name}-dev/*"
        }
    ]
}
EOF
}
