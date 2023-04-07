resource "aws_vpc" "myvpc_dev" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "myvpc_dev-${terraform.workspace}"
    Env  = terraform.workspace
  }
}

resource "aws_subnet" "web_dev" {
    count = terraform.workspace == "qa" ? 1 : 0
  cidr_block = cidrsubnet(var.vpc-cidr, 8, 0)
  depends_on = [
    aws_vpc.myvpc_dev
  ]
  vpc_id = aws_vpc.myvpc_dev.id
  tags = {
    Name = "web_dev"
  }

}