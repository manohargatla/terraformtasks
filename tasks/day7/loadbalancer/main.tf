## creating vpc
resource "aws_vpc" "lb_vpc" {
  cidr_block = var.lb_vpc_info.lb_vpc_cidr
  tags = {
    Name = "lb_vpc"
  }
}
## creating subnet
resource "aws_subnet" "lb_subnet" {
  count             = length(var.lb_vpc_info.lb_subnet_names)
  vpc_id            = aws_vpc.lb_vpc.id
  cidr_block        = cidrsubnet(var.lb_vpc_info.lb_vpc_cidr, 8, count.index)
  availability_zone = "${var.region}${var.lb_vpc_info.lb_subnets_names_azs[count.index]}"
  tags = {
    Name = var.lb_vpc_info.lb_subnet_names[count.index]
  }
  depends_on = [
    aws_vpc.lb_vpc
  ]

}
## creating internetgate_way
resource "aws_internet_gateway" "igw_lb" {
  vpc_id = aws_vpc.lb_vpc.id
  tags = {
    Name = "igw_lb"
  }
  depends_on = [
    aws_vpc.lb_vpc
  ]
}
## creating route_table
resource "aws_route_table" "route_table_lb" {
  vpc_id = aws_vpc.lb_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_lb.id
  }
  tags = {
    Name = "igw_lb"
  }
  depends_on = [
    aws_internet_gateway.igw_lb
  ]
}
## creating route_table association
resource "aws_route_table_association" "lb_main_rt_association" {
  count          = 1
  subnet_id      = aws_subnet.lb_subnet[0].id
  route_table_id = aws_route_table.route_table_lb.id
  depends_on = [
    aws_route_table.route_table_lb
  ]

}
resource "aws_route_table_association" "lb_main_rt_association1" {
  count          = 1
  subnet_id      = aws_subnet.lb_subnet[1].id
  route_table_id = aws_route_table.route_table_lb.id
  depends_on = [
    aws_route_table.route_table_lb
  ]

}
## create security group
resource "aws_security_group" "terraformlb" {
  name        = "terraformlb"
  vpc_id      = aws_vpc.lb_vpc.id
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
    aws_subnet.lb_subnet
  ]
}
## create keypair
resource "aws_key_pair" "deployer" {
  key_name   = "terraform3"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyNRL9nyxUnjeqSr92yVqV4ImkfwR6qYQrBBR5+eaxrCDQhIoHUtgiG0YXjrhXl6E6ErKiZBgwGjjFsMqjdzsfS9kHiawTMxTr4ilwCfOChgDfR5t5e3L/X4F/ZjCZiK1qNha+/DC5r/dGwhB579yxXSUxVWfGOP4buGWkWBWpmrN94EMmtFdyBSjnjMardSV2mXXPjPDNDudDUMEsQr4P8aAbiOj9VCf2tpQswElkjA4IZ8DfIfeIwKYsR11uDAqZrSf96TxFXN6OCKOnqu4DSWxFbKywffS5XG+nTC1+oee/ftdL6rlJpg/VaTN4Bqfsk9px/redvXlNFUsaZqrm5UiLCS7QGO/HfPa57JQBsS+jv2fURQfYMg35otxtbE3+IIHLzmdNnQOVU/scTyuO73kHrU2w0zTqfbMbqm7CqpnBfrdyzI4+AnV/4HtYojxGTZR6S3oV0azc7eKAGyeUjMttTuVbDYlQInkvZvS4SrFSfRTk+v1CFX0IJvSlVFE= dell@DESKTOP-G8OJBDS"
}

## create EC2 instance
resource "aws_instance" "apache" {
  count                       = 1
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  ami                         = "ami-007855ac798b5175e"
  subnet_id                   = aws_subnet.lb_subnet[0].id
  vpc_security_group_ids      = [aws_security_group.terraformlb.id]
  key_name                    = "terraform3"
  user_data                   = file("apache.sh")
  tags = {
    Name = "apache"
  }
  depends_on = [
    aws_security_group.terraformlb
  ]
}
resource "aws_instance" "nginx" {
  count                       = 1
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  ami                         = "ami-007855ac798b5175e"
  subnet_id                   = aws_subnet.lb_subnet[1].id
  vpc_security_group_ids      = [aws_security_group.terraformlb.id]
  key_name                    = "terraform3"
  user_data                   = file("nginx.sh")
  tags = {
    Name = "nginx"
  }
  depends_on = [
    aws_security_group.terraformlb
  ]
}

## create target group
resource "aws_lb_target_group" "tg" {
  name     = "tf-lb-tg"
  port     = 80
  protocol = "HTTP" 
  vpc_id   = aws_vpc.lb_vpc.id
}
## create target group attachement
resource "aws_lb_target_group_attachment" "tg-attach" {
  count            = 1
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.apache[count.index].id
  port             = 80
}
resource "aws_lb_target_group_attachment" "tg-attach-nginx" {
  count            = 1
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.nginx[count.index].id
  port             = 80
}
## create load balancer
resource "aws_lb" "lb1" {
  name               = "lb1-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terraformlb.id]
  subnets            = [aws_subnet.lb_subnet[0].id,aws_subnet.lb_subnet[1].id]

  enable_deletion_protection = false
  tags = {
    Environment = "production"
  }
}
## create load balancer listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb1.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}