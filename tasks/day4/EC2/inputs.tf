variable "region" {
  type        = string
  default     = "us-east-1"
  description = "default region for creating EC2"
}

variable "EC2_info" {
  type = object({
    vpc_cidr = string
  })
  default = {
    vpc_cidr = "10.100.0.0/16"

  }

}

variable "from_port" {
  type    = list(string)
  default = ["22", "80", "443"]
}

variable "to_port" {
  type    = list(string)
  default = ["22", "80", "443"]
}