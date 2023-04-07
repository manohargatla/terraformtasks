resource "aws_vpc" "come" {
  cidr_block       = var.myvpc-info.vpc-cidr
  
  tags = {
    Name = "come"
  }
}
resource "aws_subnet" "subnets" {
  count = 6
  
  cidr_block = cidrsubnet(var.myvpc-info.vpc-cidr[count.index])
  availability_zone = "${var.region}${var.myvpc-info.availability-zones[count.index]}"
  vpc_id     = local.vpc.id #For minimizing the expression of vpc_id
  depends_on = [
    aws_vpc.myvpc-info
  ]
  tags = {
    Name = var.myvpc-info.subnet-names[count.index]
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id     = local.vpc_id #For minimizing the expression of vpc_id
  depends_on = [
    aws_subnet.subnets
  ]
  tags = {
    Name = var.myvpc-info.route-Name
  }
}
## CREATION OF TWO ROUTE TABLES 1.PUBLIC 2 PRIVATE
resource "aws_route_table" "private" {
  vpc_id = local.vpc_id #For minimizing the expression of vpc_id
  depends_on = [
    aws_subnet.subnets
  ]
  tags = {
    Name = "private"
  }
}
resource "aws_route_table" "public" {
  vpc_id = local.vpc_id #For minimizing the expression of vpc_id
  depends_on = [
    aws_subnet.subnets
  ]
  tags = {
    Name = "public"
  }
  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.gw.id
  }
  
}
##CREATION DATA SOURCES FOR SUBNETS## (FOR QUERY VARIOUS INFORMATION FOR PROVIDER)
data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = var.myvpc-info.public-subnet ## WE ARE PASSING PUBLIC SUBNET VALUES
  
}
filter {
  name = "vpc-id"
  values =[local.vpc_id] 
}
depends_on = [
  aws_subnet.subnets
]
}
data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = var.myvpc-info.private-subnet ## WE ARE PASSING private SUBNET VALUES
  
}
filter {
  name = "vpc-id"
  values =[local.vpc_id] 
}
depends_on = [
  aws_subnet.subnets
]
}
##ASOCIATION OF ROUTE TABLES WITH SUBNETS##
resource "aws_route_table_association" "public-association" {
  count = 2
  subnet_id      = data.aws_subnet.public.ids[count.index]
  route_table_id = "aws_route_table.public.id"
  
}
resource "aws_route_table_association" "private-association" {
  count = 4
  subnet_id      = data.aws_subnet.private.ids[count.index]
  route_table_id = "aws_route_table.private.id"
  
}