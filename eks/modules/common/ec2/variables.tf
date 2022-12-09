variable "ec2_security_group_name" {
  type = string
}

variable "ec2_security_group_description" {
  type    = string
  default = "EC2 Security Group Managed By Terraform"
}

variable "vpc_id" {
  type = string
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
}


variable "ec2_cidr_blocks" {
  type = list(string)
  default = [
    "27.34.104.46/32"
  ]
}

variable "image_filter_values" {
  type    = list(string)
  default = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
}

variable "virtualization_filter_values" {
  type    = list(string)
  default = ["hvm"]
}

variable "image_owners" {
  type    = list(string)
  default = ["099720109477"]
}

variable "tags" {
  type = map(string)
}

variable "ec2_instance_name" {
  type = string
}

variable "ec2_volume_size" {
  type    = string
  default = 20
}

variable "ami_id" {
  type    = string
  default = "ami-064a0193585662d74"
}

variable "key_name" {
  type = string
}

variable "is_bastion" {
  type    = bool
  default = false
}

variable "userdata" {
  type    = string
  default = ""
}

variable "ebs_optimized" {
  type    = bool
  default = false
}

variable "enable_elastic_ip" {
  type    = bool
  default = false
}
