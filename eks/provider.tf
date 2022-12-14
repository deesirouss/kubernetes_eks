terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
    }
    onepassword = {
      source = "1Password/onepassword"
      version = "1.1.4"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "nvirginia"
}

provider "aws" {
  region = "us-west-1"
  alias  = "california"
}
