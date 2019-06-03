output "name" {
  value = aws_elastic_beanstalk_application.application.name
}

output "vpc" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.subnets_public.*.id
}

output "private_subnets" {
  value = aws_subnet.subnets_private.*.id
}