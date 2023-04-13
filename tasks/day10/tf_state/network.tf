## creating vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_info.vpc_cidr
  tags = {
    Name = "vpc"
  }
}
## creating subnet
resource "aws_subnet" "one" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_info.vpc_cidr, 8, 0)
  availability_zone = "${var.region}a"
  tags = {
    Name = "one"
  }
}
resource "aws_subnet" "two" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_info.vpc_cidr, 8, 1)
  availability_zone = "${var.region}b"
  tags = {
    Name = "two"
  }
}
resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_info.vpc_cidr, 8, 2)
  availability_zone = "${var.region}c"
  tags = {
    Name = "db"
  }
}
## creating internetgate_way
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw_lb"
  }
  depends_on = [
    aws_vpc.vpc
  ]
}
## creating route_table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "igw_lb"
  }
  depends_on = [
    aws_internet_gateway.igw
  ]
}
## creating route_table association
resource "aws_route_table_association" "main_rt_association" {
  subnet_id      = aws_subnet.one.id
  route_table_id = aws_route_table.route_table.id
  depends_on = [
    aws_route_table.route_table
  ]

}
resource "aws_route_table_association" "lb_main_rt_association1" {
  subnet_id      = aws_subnet.two.id
  route_table_id = aws_route_table.route_table.id
  depends_on = [
    aws_route_table.route_table
  ]

}
resource "aws_route_table_association" "main_rt_association1" {
  subnet_id      = aws_subnet.db.id
  route_table_id = aws_route_table.route_table.id
  depends_on = [
    aws_route_table.route_table
  ]

}
## create security group
resource "aws_security_group" "terraformlb" {
  name        = "terraformlb"
  vpc_id      = aws_vpc.vpc.id
  description = "allow all ports"
  ingress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
  }

  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
  }

  depends_on = [
    aws_vpc.vpc
  ]
}