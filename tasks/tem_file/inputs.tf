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

variable "rollout_version" {
  default = "0.0.0.0"
}