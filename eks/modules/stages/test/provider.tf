terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
      configuration_aliases = [aws.nvirginia, aws.california]
    }
  }
}

