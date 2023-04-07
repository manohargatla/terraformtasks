variable "region" {
  type        = string
  default     = "us-east-1"
  description = " creating vpcs and subnets in this region"

}

## varible for vpc cidr

variable "vpcs_info" {
  type = object({
    cidr_range = list(string)
    vpc_names  = list(string)
  })
  default = {
    cidr_range = ["192.168.0.0/16", "10.0.0.0/16"]
    vpc_names  = ["ntier1", "ntier2"]
  }

}

## varible for subnets

variable "subnets_info" {
  type = object({
    subnet_names = list(string)
    subnets_azs  = list(string)
  })
  default = {
    subnet_names = ["app1", "app2", "app3", "db1", "db2", "db3"]
    subnets_azs  = ["a", "b", "c", "a", "b", "c"]

  }

}