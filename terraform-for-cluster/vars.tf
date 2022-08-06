variable "region" {
  default = ""
}

variable "cluster_name" {
  default = ""
}

variable "vpc_id" {
  default = ""
    sensitive = true
}

variable "public_sn_a" {
  default = ""
  sensitive = true
}
variable "public_sn_b" {
  default = ""
  sensitive = true
}
variable "public_sn_c" {
  default = ""
  sensitive = true
}
variable "private_sn_a" {
  default = ""
  sensitive = true
}
variable "private_sn_b" {
  default = ""
  sensitive = true
}
variable "private_sn_c" {
  default = ""
  sensitive = true
}
