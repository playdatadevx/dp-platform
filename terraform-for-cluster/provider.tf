terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21"
    }
  }
  backend "s3" {
    bucket = "kr.devx.terraform.state"
    key = "devx/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
    dynamodb_table = "tfstateLock"
  }
}

provider "aws" {
  region = local.region
}

