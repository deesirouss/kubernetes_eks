terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
      #      configuration_aliases = [aws.ohio, aws.california, aws.oregon]
    }
  }
}
provider "aws" {
  region = "us-east-1"
  alias  = "nvirginia"
}
