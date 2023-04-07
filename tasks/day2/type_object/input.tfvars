## variable for region
variable "region" {
    type = string
    default = "us-east-1"
}

## varible for vpcs

variable "two_vpcs" {
    type = list(string)
    var.two_vpcs = {
        type = list(
            Name = ["ntier1" , "ntier2"]
        )
    }
}