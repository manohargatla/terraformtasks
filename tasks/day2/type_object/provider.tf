terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.35"
    }
  }
}

## configure the aws provider

provider "aws" {
    region = var.region
  
}
