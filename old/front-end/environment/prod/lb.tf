resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = "${data.aws_lb_listener.http-listener.arn}"
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
