## create vpc
resource "aws_vpc" "ntier_vpc" {
  cidr_block           = var.EC2_info.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "ntier_vpc"
  }
}
## create subnet
resource "aws_subnet" "subnet1" {
  cidr_block = cidrsubnet(var.EC2_info.vpc_cidr, 8, 1)
  vpc_id     = aws_vpc.ntier_vpc.id
  tags = {
    Name = "subnet_tf"
  }
}
## creating internetgate way
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.ntier_vpc.id
  tags = {
    Name = "IGW"
  }
}
## create route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ntier_vpc.id
  tags = {
    Name = "public_rt"
  }
}
## create route
resource "aws_route" "route_pub" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw.id
  depends_on = [
    aws_route_table.public_rt
  ]
}
## create route table associate
resource "aws_route_table_association" "rtmain" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_rt.id
}
## create security group
resource "aws_security_group" "ec2sg" {
  name        = "ec2sg"
  vpc_id      = aws_vpc.ntier_vpc.id
  description = "allow all ports"
  ingress {
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "Tcp"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "Tcp"
  }
}
## create keypair
resource "aws_key_pair" "newone" {
  key_name   = "terraform3"
  public_key = file("~/.ssh/id_rsa.pub")
}
## create EC2 instance
resource "aws_instance" "terraform" {
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  ami                         = "ami-007855ac798b5175e"
  vpc_security_group_ids      = [aws_security_group.ec2sg.id]
  subnet_id                   = aws_subnet.subnet1.id
  key_name                    = "terraform3"
  user_data                   = file("ansible.sh")
  tags = {
    Name = "terraform"
  }
  depends_on = [
    aws_security_group.ec2sg
  ]
}
## create null resource
resource "null_resource" "ansible" {
  triggers = {
    rollout_version = var.rollout_version
  }
  connection {
    type        = "ssh"
    host        = aws_instance.terraform.public_ip
    user        = "ubuntu"
    private_key = ("~/.ssh/id_rsa")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y ansible",
      "sudo mkdir /etc/ansible",
      "sudo chmod 777 /etc/ansible",
      "sudo echo '[web]' >> /etc/ansible/hosts",
      "sudo echo '${aws_instance.terraform.public_ip}' >> /etc/ansible/hosts",
      # "sudo chmod 644 /etc/ansible/hosts",
      # "sudo yum install -y git",
      # "sudo git clone https://github.com/your-github-repo/your-ansible-playbook.git",
      # "sudo ansible-playbook your-ansible-playbook/playbook.yml"
    ]

  }

}

## creating template file 
data "template_file" "inventory" {
  template = <<EOF
    echo ${aws_instance.terraform.public_ip} ansible user = manu
    EOF
}



