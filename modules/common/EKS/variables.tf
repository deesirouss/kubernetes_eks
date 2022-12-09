variable "stage" {
  type = string
}

variable "eks_cluster_name" {
  type    = string
  default = "EKS-cluster"
}

variable "tags" {
  type = map(string)
}

variable "cluster_subnet_ids" {
  type = list(string)
}

variable "eks_version" {
  type        = string
  default     = "1.24"
  description = "e.g. 1.23, 1.22, 1.21, 1.20"
}

variable "cluster_endpoint_private_access" {
  type    = bool
  default = false
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
}

variable "cluster_public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "cluster_service_ipv4_cidr" {
  type    = string
  default = "172.20.0.0/16"
}

