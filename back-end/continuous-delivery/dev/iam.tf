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
         "Resource":[
            "arn:aws:s3:::codepipeline-${var.aws_region}-*"
         ],
         "Action":[
            "s3:PutObject",
            "s3:GetObject",
            "s3:GetObjectVersion"
         ]
      }
   ]
}
EOF
}
