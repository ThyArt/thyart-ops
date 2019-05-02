data "aws_elastic_beanstalk_solution_stack" "dev-solution-stack" {
  name_regex  = "^64bit Amazon Linux 2018.03 (.*) running PHP 7.2$"
  most_recent = true
}

data "aws_vpc" "backend-vpc" {
  tags {
    Name = "${var.application_name}"
  }
}

data "aws_subnet" "backend-subnet-public-1" {
  vpc_id = "${data.aws_vpc.backend-vpc.id}"

  tags {
    Name = "${var.application_name}-public-1"
  }
}

data "aws_subnet" "backend-subnet-public-2" {
  vpc_id = "${data.aws_vpc.backend-vpc.id}"

  tags {
    Name = "${var.application_name}-public-2"
  }
}

data "aws_subnet" "backend-subnet-public-3" {
  vpc_id = "${data.aws_vpc.backend-vpc.id}"

  tags {
    Name = "${var.application_name}-public-3"
  }
}

data "aws_subnet" "backend-subnet-private-1" {
  vpc_id = "${data.aws_vpc.backend-vpc.id}"

  tags {
    Name = "${var.application_name}-private-1"
  }
}

data "aws_subnet" "backend-subnet-private-2" {
  vpc_id = "${data.aws_vpc.backend-vpc.id}"

  tags {
    Name = "${var.application_name}-private-2"
  }
}

data "aws_subnet" "backend-subnet-private-3" {
  vpc_id = "${data.aws_vpc.backend-vpc.id}"

  tags {
    Name = "${var.application_name}-private-3"
  }
}

data "aws_secretsmanager_secret" "dev-secret-manager" {
  name = "${var.application_name}-dev-front-end-cfg"
}

data "aws_route53_zone" "route53_zone" {
  name         = "${var.route53_zone_name}"
  private_zone = false
}
