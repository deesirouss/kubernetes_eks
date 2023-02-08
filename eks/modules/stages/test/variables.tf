variable "vpc_cidr" {
  type    = string
  default = "172.11.0.0/16"
}
variable "environment" {
  type    = string
  default = "Vyaguta"
}
variable "private_key_pem" {
  type = string
  }

variable "key_name" {
  type = string
  description = "the name of the key pair"
}