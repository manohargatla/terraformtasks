terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.62.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias = "east"
}

provider "aws" {    
  region = "us-west-2"
  alias = "west"
}


