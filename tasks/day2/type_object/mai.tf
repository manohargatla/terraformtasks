## creating a vpcs
resource "aws_vpc" "two_vpcs" {
    count = 2
    cidr_block = "150.120.0.0/16"
  tags ={
    Name = "two_vpcs"
  }
}
## creating a subnets

resource "aws_subnet" "subnet_names" {
  count = 6
  vpc_id     = aws_vpc.two_vpcs.id
  cidr_block = "150.120.0.0/24"
  tags ={
    Name = "subnet_names"
  }
}