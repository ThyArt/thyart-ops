resource "aws_lambda_function" "staticS3Deploy" {
  filename         = "front-end/deployment-lambda/staticS3Deploy.zip"
  function_name    = "staticS3Deploy"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "exports.test"
  source_code_hash = "${base64sha256(file("staticS3Deploy.zip"))}"
  runtime          = "nodejs8.10"
}
