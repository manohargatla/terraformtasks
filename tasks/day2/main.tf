## creating vpc 

resource "aws_vpc" "ntier" {
  cidr_block = var.aws_vpc_range
  tags = {
    Name = "ntier"
  }
}

## creating subnets

resource "aws_subnet" "aws-subnet-names" {
  count             = 6
  vpc_id            = aws_vpc.ntier.id
  cidr_block        = var.aws_subnet_cidr[count.index]
  availability_zone = "${var.region}${var.aws_subnet_azs[count.index]}"
   tags = {
     Name = var.aws-subnet-names[count.index]
   }
  }
