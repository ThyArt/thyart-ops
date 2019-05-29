resource "aws_lb_listener_rule" "redirect_http_to_https" {
  count        = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  listener_arn = "${data.aws_lb_listener.http_listener.0.arn}"
  priority     = 1

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}
