data "aws_elastic_beanstalk_solution_stack" "solution_stack" {
  name_regex  = "^64bit Amazon Linux 2018.03 (.*) running Node.js$"
  most_recent = true
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_ids)
  id    = var.public_subnet_ids[count.index]
}

data "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_ids)
  id    = var.private_subnet_ids[count.index]
}

data "aws_route53_zone" "route53_zone" {
  name         = var.route53_zone_name
  private_zone = false
}

data "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_elastic_beanstalk_environment.environment.load_balancers[0]
  port              = 80
}
