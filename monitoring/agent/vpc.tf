resource "aws_vpc" "monitoring-agent-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = false

  tags = {
    Name = "monitoring-agent"
  }
}

resource "aws_internet_gateway" "monitoring-agent-gateway" {
  vpc_id = "${aws_vpc.monitoring-agent-vpc.id}"

  tags = {
    Name = "monitoring-agent"
  }
}

resource "aws_route_table" "monitoring-agent-route-table-public" {
  vpc_id = "${aws_vpc.monitoring-agent-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.monitoring-agent-gateway.id}"
  }

  tags = {
    Name = "monitoring-agent-public-1"
  }
}

resource "aws_subnet" "monitoring-agent-subnet-public-1" {
  vpc_id                  = "${aws_vpc.monitoring-agent-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "monitoring-agent-public-1"
  }
}

resource "aws_route_table_association" "monitoring-agent-route-table-association-public-1" {
  subnet_id      = "${aws_subnet.monitoring-agent-subnet-public-1.id}"
  route_table_id = "${aws_route_table.monitoring-agent-route-table-public.id}"
}
