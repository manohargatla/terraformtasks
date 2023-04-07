## creating vpcs 
resource "aws_vpc" "vpcs_info" {
  count      = length(var.vpcs_info.vpc_names)
  cidr_block = var.vpcs_info.cidr_range[count.index]
  tags = {
    Name = var.vpcs_info.vpc_names[count.index]
  }
}
## creating subnets
resource "aws_subnet" "subnets_info" {
  count             = length(var.subnets_info.subnet_names)
  cidr_block        = cidrsubnet(var.vpcs_info.cidr_range[0], 8, count.index)
  availability_zone = "${var.region}${var.subnets_info.subnets_azs[count.index]}"
  vpc_id            = aws_vpc.vpcs_info[0].id
  depends_on = [
    aws_vpc.vpcs_info
  ]
  tags = {
    Name = var.subnets_info.subnet_names[count.index]
  }
}
## creating subnets
resource "aws_subnet" "subnets_info1" {
  count             = length(var.subnets_info.subnet_names)
  cidr_block        = cidrsubnet(var.vpcs_info.cidr_range[1], 8, count.index)
  availability_zone = "${var.region}${var.subnets_info.subnets_azs[count.index]}"
  vpc_id            = aws_vpc.vpcs_info[1].id
  depends_on = [
    aws_vpc.vpcs_info
  ]
  tags = {
    Name = var.subnets_info.subnet_names[count.index]
  }
}