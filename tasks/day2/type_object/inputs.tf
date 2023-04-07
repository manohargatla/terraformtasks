## variable for region
variable "region" {
    type = string
    default = "us-east-1"
}

## varible for vpcs

variable "two_vpcs" {
    type = list(
        Name = string
        default= ["ntier1" , "ntier2"]
    )
}

## varible for subnets

variable "subnet_names" {
    type = list(
        Name = string
        default= ["app1" , "app2" , "app3" , "db1" , "db2" , "db3"]
    )
}