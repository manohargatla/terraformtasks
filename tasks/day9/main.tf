provider "aws" {
  region = "us-east-1"

}
module "aws_ec2" {
  source = "./modules/aws_ec2"
  region = "us-east-1"
  lb_vpc_info = {
    lb_subnet_names      = ["web", "app"]
    lb_subnets_names_azs = ["a", "b"]
    lb_vpc_cidr          = "192.168.0.0/16"
    rollout_versions     = "0.0.0.1"
  }
}
output "redurl" {
  value = module.aws_ec2.red
}
output "green" {
  value = module.aws_ec2.green

}