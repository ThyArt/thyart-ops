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

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
