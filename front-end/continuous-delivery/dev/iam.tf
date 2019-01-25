resource aws_iam_role "dev-codebuild-role" {
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

resource "aws_iam_role" "dev-lambda-role" {
  name = "${var.application_name}-dev-lambda-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
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
         "Action":[
            "kms:*"
         ],
         "Resource":"${aws_kms_key.dev-codepipeline-key.arn}",
         "Effect":"Allow"
      },
      {
         "Effect":"Allow",
         "Resource":[
            "${aws_s3_bucket.dev-codepipeline-bucket.arn}",
            "${aws_s3_bucket.dev-codepipeline-bucket.arn}/*"
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
            "${aws_s3_bucket.dev-codepipeline-bucket.arn}",
            "${aws_s3_bucket.dev-codepipeline-bucket.arn}/*"
         ]
      },
      {
         "Action":[
            "kms:*"
         ],
         "Resource":"${aws_kms_key.dev-codepipeline-key.arn}",
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
      }
   ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  role = "${aws_iam_role.dev-lambda-role.id}"
  name = "${var.application_name}-dev-lambda-service-role-policy"

  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Action": [
        "logs:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Action": [
        "codepipeline:PutJobSuccessResult",
        "codepipeline:PutJobFailureResult"
        ],
        "Effect": "Allow",
        "Resource": "*"
     },
  {
      "Effect" : "Allow",
      "Action" : [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource" : "arn:aws:logs:*:*:*"
    }, {
      "Effect" : "Allow",
            "Action": [
                "codepipeline:*",
                "iam:ListRoles",
                "iam:PassRole",
                "s3:CreateBucket",
                "s3:GetBucketPolicy",
                "s3:GetObject",
                "s3:ListAllMyBuckets",
                "s3:ListBucket",
                "s3:PutBucketPolicy",
                "codecommit:ListBranches",
                "codecommit:ListRepositories",
                "codedeploy:GetApplication",
                "codedeploy:GetDeploymentGroup",
                "codedeploy:ListApplications",
                "codedeploy:ListDeploymentGroups",
                "elasticbeanstalk:DescribeApplications",
                "elasticbeanstalk:DescribeEnvironments",
                "lambda:GetFunctionConfiguration",
                "lambda:ListFunctions",
                "opsworks:DescribeApps",
                "opsworks:DescribeLayers",
                "opsworks:DescribeStacks",
                "cloudformation:DescribeStacks",
                "cloudformation:ListChangeSets"
            ],
      "Resource" : "*"
    }, {
            "Effect": "Allow",
            "Action": [
                "cloudformation:DescribeChangeSet",
                "cloudformation:DescribeStackResources",
                "cloudformation:DescribeStacks",
                "cloudformation:GetTemplate",
                "cloudformation:ListStackResources",
                "cloudwatch:*",
                "cognito-identity:ListIdentityPools",
                "cognito-sync:GetCognitoEvents",
                "cognito-sync:SetCognitoEvents",
                "dynamodb:*",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcs",
                "events:*",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "iam:ListAttachedRolePolicies",
                "iam:ListRolePolicies",
                "iam:ListRoles",
                "iam:PassRole",
                "iot:AttachPrincipalPolicy",
                "iot:AttachThingPrincipal",
                "iot:CreateKeysAndCertificate",
                "iot:CreatePolicy",
                "iot:CreateThing",
                "iot:CreateTopicRule",
                "iot:DescribeEndpoint",
                "iot:GetTopicRule",
                "iot:ListPolicies",
                "iot:ListThings",
                "iot:ListTopicRules",
                "iot:ReplaceTopicRule",
                "kinesis:DescribeStream",
                "kinesis:ListStreams",
                "kinesis:PutRecord",
                "kms:ListAliases",
                "lambda:*",
                "logs:*",
                "s3:*",
                "sns:ListSubscriptions",
                "sns:ListSubscriptionsByTopic",
                "sns:ListTopics",
                "sns:Publish",
                "sns:Subscribe",
                "sns:Unsubscribe",
                "sqs:ListQueues",
                "sqs:SendMessage",
                "tag:GetResources",
                "xray:PutTelemetryRecords",
                "xray:PutTraceSegments"
            ],
            "Resource": "*"
        }
  ]
}
EOF
}
