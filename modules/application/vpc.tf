resource "aws_vpc" "vpc" {
  count                = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "${var.application_name}"
  }
}

resource "aws_eip" "nat" {
  count = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  vpc   = true
}

resource "aws_nat_gateway" "nat_gateway" {
  count = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"

  allocation_id = "${aws_eip.nat.0.id}"
  subnet_id     = "${aws_subnet.subnets_public.0.id}"
  depends_on    = ["aws_internet_gateway.gateway"]
}

resource "aws_internet_gateway" "gateway" {
  count  = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  vpc_id = "${aws_vpc.vpc.0.id}"

  tags = {
    Name = "${var.application_name}"
  }
}

resource "aws_route_table" "route_table_public" {
  count  = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  vpc_id = "${aws_vpc.vpc.0.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway.0.id}"
  }

  tags = {
    Name = "${var.application_name}-public"
  }
}


resource "aws_route_table" "route_table_private" {
  count  = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  vpc_id = "${aws_vpc.vpc.0.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway.0.id}"
  }

  tags = {
    Name = "${var.application_name}-private"
  }
}


resource "aws_subnet" "subnets_public" {
  count                   = "${length(data.aws_availability_zone.availability_zones) * tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  vpc_id                  = "${aws_vpc.vpc.0.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.vpc.0.cidr_block, 4, count.index + 1)}"
  map_public_ip_on_launch = "true"
  availability_zone       = "${element(data.aws_availability_zone.availability_zones, count.index).name}"

  tags = {
    Name = "${var.application_name}-public-${count.index}"
  }
}

resource "aws_subnet" "subnets_private" {
  count                   = "${length(data.aws_availability_zone.availability_zones) * tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  vpc_id                  = "${aws_vpc.vpc.0.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.vpc.0.cidr_block, 4, count.index + 1 + length(data.aws_availability_zone.availability_zones))}"
  map_public_ip_on_launch = "false"
  availability_zone       = "${element(data.aws_availability_zone.availability_zones, count.index).name}"

  tags = {
    Name = "${var.application_name}-private-${count.index}"
  }
}

resource "aws_route_table_association" "route_table_associations_public" {
  count          = "${length(data.aws_availability_zone.availability_zones) * tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  subnet_id      = "${aws_subnet.subnets_public[count.index].id}"
  route_table_id = "${aws_route_table.route_table_public.0.id}"
}

resource "aws_route_table_association" "route_table_associations_private" {
  count          = "${length(data.aws_availability_zone.availability_zones) * tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  subnet_id      = "${aws_subnet.subnets_private[count.index].id}"
  route_table_id = "${aws_route_table.route_table_private.0.id}"
}