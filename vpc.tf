/*
  VPC
*/
resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "VPC-01"
    }
}

/*
  Internet Gateway
*/
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

/*
  Public Subnets
*/
resource "aws_subnet" "public" {
    count = "${length(var.aws_subnet_cidrs_public)}"

    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.aws_subnet_cidrs_public[count.index]}"
    availability_zone = "${var.aws_availability_zones[count.index]}"
}

/*
  Private Subnets
*/
resource "aws_subnet" "private" {
    count = "${length(var.aws_subnet_cidrs_private)}"

    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.aws_subnet_cidrs_private[count.index]}"
    availability_zone = "${var.aws_availability_zones[count.index]}"
}

/*
  NAT Gateway
*/
resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_nat_gateway" "gw" {
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = "${element(aws_subnet.public.*.id, 1)}"
}

/*
  Public Route Table
*/
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Public Subnet"
    }
}

/*
  Public Route Table Associations
*/
resource "aws_route_table_association" "public" {
    count = "${length(var.aws_subnet_cidrs_public)}"

    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = "${aws_route_table.public.id}"
}

/*
  Private Route Table
*/
resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags {
        Name = "Private Subnet"
    }
}

/*
  Private Route Table Associations
*/
resource "aws_route_table_association" "private" {
    count = "${length(var.aws_subnet_cidrs_private)}"

    subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
    route_table_id = "${aws_route_table.private.id}"
}