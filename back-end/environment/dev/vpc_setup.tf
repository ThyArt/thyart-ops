# Internet VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "${var.application_name}-dev"
  }
}

# Internet GW
resource "aws_internet_gateway" "dev-gateway" {
  vpc_id = "${aws_vpc.dev-vpc.id}"

  tags {
    Name = "${var.application_name}-dev"
  }
}

# route tables
resource "aws_route_table" "dev-route-table-public" {
  vpc_id = "${aws_vpc.dev-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev-gateway.id}"
  }

  tags {
    Name = "${var.application_name}-dev-public-1"
  }
}

# Subnets
resource "aws_subnet" "dev-subnet-public-1" {
  vpc_id                  = "${aws_vpc.dev-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}a"

  tags {
    Name = "${var.application_name}-dev-public-1"
  }
}

resource "aws_subnet" "dev-subnet-public-2" {
  vpc_id                  = "${aws_vpc.dev-vpc.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}b"

  tags {
    Name = "${var.application_name}-dev-public-2"
  }
}

resource "aws_subnet" "dev-subnet-public-3" {
  vpc_id                  = "${aws_vpc.dev-vpc.id}"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}c"

  tags {
    Name = "${var.application_name}-dev-public-3"
  }
}

resource "aws_subnet" "dev-subnet-private-1" {
  vpc_id                  = "${aws_vpc.dev-vpc.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}a"

  tags {
    Name = "${var.application_name}-dev-private-1"
  }
}

resource "aws_subnet" "dev-subnet-private-2" {
  vpc_id                  = "${aws_vpc.dev-vpc.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}b"

  tags {
    Name = "${var.application_name}-dev-private-2"
  }
}

resource "aws_subnet" "dev-subnet-private-3" {
  vpc_id                  = "${aws_vpc.dev-vpc.id}"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.aws_region}c"

  tags {
    Name = "${var.application_name}-dev-private-3"
  }
}

# route associations public
resource "aws_route_table_association" "dev-route-table-association-public-1" {
  subnet_id      = "${aws_subnet.dev-subnet-public-1.id}"
  route_table_id = "${aws_route_table.dev-route-table-public.id}"
}

resource "aws_route_table_association" "dev-route-table-association-public-2" {
  subnet_id      = "${aws_subnet.dev-subnet-public-2.id}"
  route_table_id = "${aws_route_table.dev-route-table-public.id}"
}

resource "aws_route_table_association" "dev-route-table-association-public-3" {
  subnet_id      = "${aws_subnet.dev-subnet-public-3.id}"
  route_table_id = "${aws_route_table.dev-route-table-public.id}"
}
