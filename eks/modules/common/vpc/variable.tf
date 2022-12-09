variable "vpc_cidr" {
  description = "VPC default CIDR"
  default     = "10.0.0.0/16"
}

variable "stage" {
  type = string
}

variable "instance_tenancy" {
  description = "VPC default instance_tenancy"
  default     = "default"
}

variable "environment" {
  description = "default environment"
  default     = "demo"
}

variable "tags" {
  type = map(string)
}

variable "availability_zones_names" {
  type = list(string)
}

