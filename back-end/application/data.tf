data "archive_file" "dev-sample-app" {
  source_dir  = "${path.module}/../php-sample-app"
  output_path = "${path.module}/archive/dev-sample-app.zip"
  type        = "zip"
}
