resource "aws_vpc" "codebuild-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "codebuild"
  }
}

resource "aws_internet_gateway" "codebuild-gateway" {
  vpc_id = "${aws_vpc.codebuild-vpc.id}"

  tags = {
    Name = "codebuild"
  }
}

resource "aws_route_table" "codebuild-route-table-public" {
  vpc_id = "${aws_vpc.codebuild-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.codebuild-gateway.id}"
  }

  tags = {
    Name = "codebuild-public-1"
  }
}

resource "aws_subnet" "codebuild-subnet-public-1" {
  vpc_id                  = "${aws_vpc.codebuild-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "codebuild-public-1"
  }
}

resource "aws_subnet" "codebuild-subnet-public-2" {
  vpc_id                  = "${aws_vpc.codebuild-vpc.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}b"

  tags = {
    Name = "codebuild-public-2"
  }
}

resource "aws_subnet" "codebuild-subnet-public-3" {
  vpc_id                  = "${aws_vpc.codebuild-vpc.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}c"

  tags = {
    Name = "codebuild-public-3"
  }
}

resource "aws_subnet" "codebuild-subnet-private-1" {
  vpc_id                  = "${aws_vpc.codebuild-vpc.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "codebuild-private-1"
  }
}

resource "aws_subnet" "codebuild-subnet-private-2" {
  vpc_id                  = "${aws_vpc.codebuild-vpc.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}b"

  tags = {
    Name = "codebuild-private-2"
  }
}

resource "aws_subnet" "codebuild-subnet-private-3" {
  vpc_id                  = "${aws_vpc.codebuild-vpc.id}"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}c"

  tags = {
    Name = "codebuild-private-3"
  }
}

resource "aws_route_table_association" "codebuild-route-table-association-public-1" {
  subnet_id      = "${aws_subnet.codebuild-subnet-public-1.id}"
  route_table_id = "${aws_route_table.codebuild-route-table-public.id}"
}

resource "aws_route_table_association" "codebuild-route-table-association-public-2" {
  subnet_id      = "${aws_subnet.codebuild-subnet-public-2.id}"
  route_table_id = "${aws_route_table.codebuild-route-table-public.id}"
}

resource "aws_route_table_association" "codebuild-route-table-association-public-3" {
  subnet_id      = "${aws_subnet.codebuild-subnet-public-3.id}"
  route_table_id = "${aws_route_table.codebuild-route-table-public.id}"
}

resource "aws_route_table" "codebuild-route-table-private" {
  vpc_id = "${aws_vpc.codebuild-vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.codebuild-nat-gateway.id}"
  }

  tags = {
    Name = "codebuild-private-1"
  }
}

resource "aws_route_table_association" "codebuild-route-table-association-private-1" {
  subnet_id      = "${aws_subnet.codebuild-subnet-private-1.id}"
  route_table_id = "${aws_route_table.codebuild-route-table-private.id}"
}

resource "aws_route_table_association" "codebuild-route-table-association-private-2" {
  subnet_id      = "${aws_subnet.codebuild-subnet-private-2.id}"
  route_table_id = "${aws_route_table.codebuild-route-table-private.id}"
}

resource "aws_route_table_association" "codebuild-route-table-association-private-3" {
  subnet_id      = "${aws_subnet.codebuild-subnet-private-3.id}"
  route_table_id = "${aws_route_table.codebuild-route-table-private.id}"
}
