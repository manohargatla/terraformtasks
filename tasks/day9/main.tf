provider "aws" {
  region = "us-east-1"

}

module "aws_ec2" {
  source = "./modules/aws_ec2"
  region = "us-east-1"
  lb_vpc_info = {
    lb_subnet_names      = ["db1", "db2"]
    lb_subnets_names_azs = ["a", "b"]
    lb_vpc_cidr          = "10.100.0.0/16"
  }

}
output "apacheurl" {
  value = module.aws_ec2.apacheurl

}
output "nginxurl" {
  value = module.aws_ec2.nginxurl

}

