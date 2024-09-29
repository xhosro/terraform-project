variable "region" {
  default = "eu-west-1"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "env" {
  default = "dev"
}

variable "private_subnet_cidr" {
    default = "10.0.0.0/19"
}

variable "vpc_id" {}