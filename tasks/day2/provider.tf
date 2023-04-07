terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.34.0"
    }
  }
}

#configufre the provider

provider "aws" {
  region = var.region
}