variable "region" {
  type        = string
  default     = "us-east-1"
  description = "default region for vpc"
}

variable "vpc-cidr" {
  type    = string
  default = "10.100.0.0/16"

}