resource "random_string" "dev-passport-client-secret" {
  length  = 40
  special = false
}

resource "aws_elastic_beanstalk_environment" "dev-environment" {
  name                = "${var.application_name}-dev"
  application         = "${var.application_name}"
  solution_stack_name = "${data.aws_elastic_beanstalk_solution_stack.dev-solution-stack.name}"
  cname_prefix        = "${var.application_name}-dev"

  depends_on = ["aws_acm_certificate_validation.acm_certificate_validation"]

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${data.aws_vpc.backend-vpc.id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${data.aws_subnet.backend-subnet-private-1.id},${data.aws_subnet.backend-subnet-private-2.id},${data.aws_subnet.backend-subnet-private-3.id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_instance_profile.dev-ec2-instance-profile.name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "${aws_security_group.dev-environment-security-group.id}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "${var.application_name}-dev"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "${aws_iam_role.dev-elasticbeanstalk-service-role.name}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "public"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${data.aws_subnet.backend-subnet-public-1.id},${data.aws_subnet.backend-subnet-public-2.id},${data.aws_subnet.backend-subnet-public-3.id}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "30"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Percentage"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_USERNAME"
    value     = "${aws_db_instance.dev-rds-database.username}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PASSWORD"
    value     = "${aws_db_instance.dev-rds-database.password}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_DB_NAME"
    value     = "${aws_db_instance.dev-rds-database.name}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_HOSTNAME"
    value     = "${aws_db_instance.dev-rds-database.address}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PORT"
    value     = "${aws_db_instance.dev-rds-database.port}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PASSPORT_CLIENT_SECRET"
    value     = "${random_string.dev-passport-client-secret.result}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_ACCESS_KEY_ID"
    value     = "${aws_iam_access_key.dev-user-access-key.id}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_SECRET_ACCESS_KEY"
    value     = "${aws_iam_access_key.dev-user-access-key.secret}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_DEFAULT_REGION"
    value     = "${var.aws_region}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_BUCKET"
    value     = "${aws_s3_bucket.dev-image-bucket.bucket}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PASSPORT_CLIENT_SECRET"
    value     = "${random_string.dev-passport-client-secret.result}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:container:php:phpini"
    name      = "document_root"
    value     = "/public"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = "Any 2"
  }

  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "Protocol"
    value     = "HTTPS"
  }

  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    value     = "${aws_acm_certificate.acm_certificate.arn}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
}
