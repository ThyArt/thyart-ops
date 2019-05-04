resource "aws_iam_role" "dev-codebuild-role" {
  name = "${var.application_name}-dev-codebuild-service-role"

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

resource "aws_iam_role" "dev-codepipeline-role" {
  name = "${var.application_name}-dev-codepipeline-service-role"

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

resource "aws_iam_role_policy" "dev-codebuild-role-policy" {
  role = "${aws_iam_role.dev-codebuild-role.id}"
  name = "${var.application_name}-dev-codebuild-service-role-policy"

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Resource":[
            "arn:aws:logs:eu-west-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.application_name}-dev",
            "arn:aws:logs:eu-west-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.application_name}-dev:*"
         ],
         "Action":[
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "ec2:CreateNetworkInterface",
            "ec2:DescribeDhcpOptions",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DeleteNetworkInterface",
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeVpcs"
         ],
         "Resource":"*"
      },
      {
         "Effect":"Allow",
         "Action":[
            "ec2:CreateNetworkInterfacePermission"
         ],
         "Resource":"arn:aws:ec2:eu-west-1:${data.aws_caller_identity.current.account_id}:network-interface/*",
         "Condition":{
            "StringEquals":{
               "ec2:Subnet":[
                  "${data.aws_subnet.codebuild-subnet-public-1.arn}",
                  "${data.aws_subnet.codebuild-subnet-public-2.arn}",
                  "${data.aws_subnet.codebuild-subnet-public-3.arn}",
                  "${data.aws_subnet.codebuild-subnet-private-1.arn}",
                  "${data.aws_subnet.codebuild-subnet-private-2.arn}",
                  "${data.aws_subnet.codebuild-subnet-private-3.arn}"
               ],
               "ec2:AuthorizedService":"codebuild.amazonaws.com"
            }
         }
      },
      {
         "Action":[
            "kms:DescribeKey",
            "kms:GenerateDataKey*",
            "kms:Encrypt",
            "kms:ReEncrypt*",
            "kms:Decrypt"
         ],
         "Resource":"${aws_kms_key.dev-codepipeline-key.arn}",
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

resource "aws_iam_role_policy" "dev-codepipeline-role-policy" {
  role = "${aws_iam_role.dev-codepipeline-role.id}"
  name = "${var.application_name}-dev-codepipeline-service-role-policy"

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
           "kms:DescribeKey",
           "kms:GenerateDataKey*",
           "kms:Encrypt",
           "kms:ReEncrypt*",
           "kms:Decrypt"         ],
         "Resource":"${aws_kms_key.dev-codepipeline-key.arn}",
         "Effect":"Allow"
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
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:RegisterTargets",
                "rds:DescribeDBInstances",
                "rds:DescribeOrderableDBInstanceOptions",
                "sns:ListSubscriptionsByTopic"
         ],
         "Resource":"*",
         "Effect":"Allow"
      },
      {
         "Effect":"Allow",
         "Action":[
            "codebuild:BatchGetBuilds",
            "codebuild:StartBuild"
         ],
         "Resource":"${aws_codebuild_project.dev-codebuild-project.arn}"
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
         "Resource":"${data.aws_codecommit_repository.codecommit-repository.arn}"
      }
   ]
}
EOF
}
