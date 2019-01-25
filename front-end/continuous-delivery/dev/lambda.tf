resource "aws_lambda_function" "statics3deploy" {
  function_name    = "statics3deploy"
  handler          = "statics3deploy.handler"
  filename         = "../../deployment-lambda/statics3deploy.zip"
  source_code_hash = "${base64sha256(file("../../deployment-lambda/statics3deploy.zip"))}"
  runtime          = "nodejs8.10"
  timeout          = "10"
  role             = "${aws_iam_role.dev-lambda-role.arn}"
}

resource "aws_lambda_permission" "allow-dev-codebuild" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.statics3deploy.function_name}"
  principal     = "events.amazonaws.com"
}
