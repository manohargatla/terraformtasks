variable "region" {
  type        = string
  default     = "us-east-1"
  description = "variable for to change required region"
}
## variable for vpc cidr
variable "vpc_info" {
  type = object({
    vpc_cidr          = string
    subnet_names      = list(string)
    subnets_names_azs = list(string)
  })
  default = {
    subnet_names      = ["one", "two"]
    subnets_names_azs = ["a", "b"]
    vpc_cidr          = "192.168.0.0/16"
  }
}