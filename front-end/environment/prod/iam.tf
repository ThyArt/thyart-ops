resource "aws_iam_role" "frontend-prod-ec2-role" {
  name = "${var.application_name}-prod-ec2-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "frontend-prod-ec2-instance-profile" {
  name = "${var.application_name}-prod-ec2-instance-profile"
  role = "${aws_iam_role.frontend-prod-ec2-role.name}"
}

resource "aws_iam_role" "frontend-prod-elasticbeanstalk-service-role" {
  name = "frontend-prod-elasticbeanstalk-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "frontend-aws-elasticbeanstalk-ec2-role" {
  name = "frontend-aws-elasticbeanstalk-ec2-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "frontend-prod-policy-attachment-1" {
  name       = "frontend-${var.application_name}-policy-attachment-1"
  roles      = ["${aws_iam_role.frontend-prod-ec2-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_policy_attachment" "frontend-prod-policy-attachment-2" {
  name       = "frontend-${var.application_name}-policy-attachment-2"
  roles      = ["${aws_iam_role.frontend-prod-ec2-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_policy_attachment" "frontend-prod-policy-attachment-3" {
  name       = "frontend-${var.application_name}-policy-attachment-3"
  roles      = ["${aws_iam_role.frontend-prod-ec2-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_policy_attachment" "frontend-prod-policy-attachment-4" {
  name       = "frontend-${var.application_name}-policy-attachment-4"
  roles      = ["${aws_iam_role.frontend-prod-elasticbeanstalk-service-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}
