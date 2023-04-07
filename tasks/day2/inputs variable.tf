# creating variable for vpc range
variable "aws_vpc_range" {
  type    = string
  default = "192.168.0.0/16"

}

#creating variable for region

variable "region" {
  type    = string
  default = "us-east-1"

}

## creating variable for subnets cidr

variable "aws_subnet_cidr" {
  type    = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24"]
}


## creatng variables for subnet names

variable "aws-subnet-names" {
  type    = list(string)
  default = ["tf1","tf2","tf3","ap1","ap2","ap3"]

}


variable "aws_subnet_azs" {
  type    = list(string)
  default = ["a","b","c","d","e","f"]

}