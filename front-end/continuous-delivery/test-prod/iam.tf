resource aws_iam_role "test-codebuild-role" {
  name = "${var.application_name}-test-codebuild-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource aws_iam_role "prod-codebuild-role" {
  name = "${var.application_name}-prod-codebuild-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "test-prod-codepipeline-role" {
  name = "${var.application_name}-test-codepipeline-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "test-codebuild-role-policy" {
  role = "${aws_iam_role.test-codebuild-role.id}"
  name = "${var.application_name}-test-codebuild-service-role-policy"

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Resource":[
            "arn:aws:logs:eu-west-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.application_name}-test",
            "arn:aws:logs:eu-west-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.application_name}-test:*"
         ],
         "Action":[
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
         ]
      },
      {
         "Action":[
            "kms:DescribeKey",
            "kms:GenerateDataKey*",
            "kms:Encrypt",
            "kms:ReEncrypt*",
            "kms:Decrypt"
         ],
         "Resource":"${aws_kms_key.test-prod-codepipeline-key.arn}",
         "Effect":"Allow"
      },
      {
         "Effect":"Allow",
         "Resource":[
            "${data.aws_s3_bucket.codepipeline-bucket.arn}",
            "${data.aws_s3_bucket.codepipeline-bucket.arn}/*"
         ],
         "Action":[
            "s3:PutObject",
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:PutObject",
            "s3:PutObjectAcl"
         ]
      }
   ]
}
EOF
}

resource "aws_iam_role_policy" "prod-codebuild-role-policy" {
  role = "${aws_iam_role.prod-codebuild-role.id}"
  name = "${var.application_name}-prod-codebuild-service-role-policy"

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Resource":[
            "arn:aws:logs:eu-west-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.application_name}-prod",
            "arn:aws:logs:eu-west-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.application_name}-prod:*"
         ],
         "Action":[
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
         ]
      },
      {
         "Action":[
            "kms:DescribeKey",
            "kms:GenerateDataKey*",
            "kms:Encrypt",
            "kms:ReEncrypt*",
            "kms:Decrypt"
         ],
         "Resource":"${aws_kms_key.test-prod-codepipeline-key.arn}",
         "Effect":"Allow"
      },
      {
         "Effect":"Allow",
         "Resource":[
            "${data.aws_s3_bucket.codepipeline-bucket.arn}",
            "${data.aws_s3_bucket.codepipeline-bucket.arn}/*"
         ],
         "Action":[
            "s3:PutObject",
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:PutObject",
            "s3:PutObjectAcl"
         ]
      }
   ]
}
EOF
}

resource "aws_iam_role_policy" "test-prod-codepipeline-role-policy" {
  role = "${aws_iam_role.test-prod-codepipeline-role.id}"
  name = "${var.application_name}-test-prod-codepipeline-service-role-policy"

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketVersioning",
            "s3:PutObject",
            "s3:PutObjectAcl"
         ],
         "Resource":[
            "${data.aws_s3_bucket.codepipeline-bucket.arn}",
            "${data.aws_s3_bucket.codepipeline-bucket.arn}/*"
         ]
      },
      {
         "Action":[
            "kms:DescribeKey",
            "kms:GenerateDataKey*",
            "kms:Encrypt",
            "kms:ReEncrypt*",
            "kms:Decrypt"
        ],
         "Resource":"${aws_kms_key.test-prod-codepipeline-key.arn}",
         "Effect":"Allow"
      },
      {
         "Effect":"Allow",
         "Action":[
            "codebuild:BatchGetBuilds",
            "codebuild:StartBuild"
         ],
         "Resource":"*"
      },
      {
         "Effect":"Allow",
         "Action":[
            "codecommit:GetBranch",
            "codecommit:GetCommit",
            "codecommit:GetUploadArchiveStatus",
            "codecommit:CancelUploadArchive",
            "codecommit:UploadArchive"
         ],
         "Resource":"*"
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:ListBucket",
            "s3:DeleteObject",
            "s3:GetBucketPolicy",
            "s3:CreateBucket"
         ],
         "Resource":[
            "arn:aws:s3:::elasticbeanstalk-${var.aws_region}-${data.aws_caller_identity.current.account_id}",
            "arn:aws:s3:::elasticbeanstalk-${var.aws_region}-${data.aws_caller_identity.current.account_id}/*"
         ]
      },
      {
         "Action":[
                "elasticbeanstalk:CreateApplicationVersion",
                "elasticbeanstalk:DescribeApplicationVersions",
                "elasticbeanstalk:DescribeEnvironments",
                "elasticbeanstalk:DescribeEvents",
                "elasticbeanstalk:UpdateEnvironment",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeScalingActivities",
                "autoscaling:ResumeProcesses",
                "autoscaling:SuspendProcesses",
                "cloudformation:GetTemplate",
                "cloudformation:DescribeStackResource",
                "cloudformation:DescribeStackResources",
                "cloudformation:DescribeStackEvents",
                "cloudformation:DescribeStacks",
                "cloudformation:UpdateStack",
                "ec2:DescribeInstances",
                "ec2:DescribeImages",
                "ec2:DescribeAddresses",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcs",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeKeyPairs",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "rds:DescribeDBInstances",
                "rds:DescribeOrderableDBInstanceOptions",
                "sns:ListSubscriptionsByTopic"
         ],
         "Resource":"*",
         "Effect":"Allow"
      }
   ]
}
EOF
}
