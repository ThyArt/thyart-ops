data "aws_elastic_beanstalk_solution_stack" "prod-solution-stack" {
  name_regex  = "^64bit Amazon Linux 2018.03 (.*) running Node.js$"
  most_recent = true
}

data "aws_vpc" "frontend-vpc" {
  tags {
    Name = "${var.application_name}"
  }
}

data "aws_subnet" "frontend-subnet-public-1" {
  vpc_id = "${data.aws_vpc.frontend-vpc.id}"

  tags {
    Name = "${var.application_name}-public-1"
  }
}

data "aws_subnet" "frontend-subnet-public-2" {
  vpc_id = "${data.aws_vpc.frontend-vpc.id}"

  tags {
    Name = "${var.application_name}-public-2"
  }
}

data "aws_subnet" "frontend-subnet-public-3" {
  vpc_id = "${data.aws_vpc.frontend-vpc.id}"

  tags {
    Name = "${var.application_name}-public-3"
  }
}

data "aws_subnet" "frontend-subnet-private-1" {
  vpc_id = "${data.aws_vpc.frontend-vpc.id}"

  tags {
    Name = "${var.application_name}-private-1"
  }
}

data "aws_subnet" "frontend-subnet-private-2" {
  vpc_id = "${data.aws_vpc.frontend-vpc.id}"

  tags {
    Name = "${var.application_name}-private-2"
  }
}

data "aws_subnet" "frontend-subnet-private-3" {
  vpc_id = "${data.aws_vpc.frontend-vpc.id}"

  tags {
    Name = "${var.application_name}-private-3"
  }
}
