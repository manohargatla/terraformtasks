provider "aws" {
  region = "us-east-1"

}

module "aws_ec2" {
  source = "git::github.com/manohargatla/terraformtasks.git"
}