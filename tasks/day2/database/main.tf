## provider
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "random" {
  # Configuration options
}



## generating random password

resource "random_password" "password" {
  length           = 8
  special          = true
  override_special = "manu@767"
}

resource "aws_db_instance" "hello" {
  instance_class    = "db.t2.micro"
  allocated_storage = 64
  engine            = "mysql"
  username          = "manohar"
  password          = random_password.password.result
}