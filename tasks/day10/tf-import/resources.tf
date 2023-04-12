resource "aws_vpc" "vpc_imp" {
    cidr_block = "-"
}

resource "aws_subnet" "sub_imp_1" {
    cidr_block = "-"
    vpc_id = aws_vpc.vpc_imp.id
}

resource "aws_subnet" "sub_imp_2" {
    cidr_block = "-"
    vpc_id = aws_vpc.vpc_imp.id
}

resource "aws_subnet" "sub_imp_3" {
    cidr_block = "-"
    vpc_id = aws_vpc.vpc_imp.id
}

resource "aws_subnet" "sub_imp_4" {
    cidr_block = "-"
    vpc_id = aws_vpc.vpc_imp.id
}

resource "aws_security_group" "all_tcp" {
 ingress = [ {
   cidr_blocks = [ "-" ]
   description = "value"
   from_port = 1
   ipv6_cidr_blocks = [ "value" ]
   prefix_list_ids = [ "value" ]
   protocol = "value"
   security_groups = [ "value" ]
   self = false
   to_port = 1
 } ]
    
}

resource "aws_instance" "ec2_imp1" {
    instance_type = "-"
    
}
resource "aws_instance" "ec2_imp2" {
    instance_type = "-"
    
}

resource "aws_lb" "lb" {
    name = "-"
    
}

resource "aws_lb_target_group" "tgimp" {
    name = "-"
    port = "-"
    
}

