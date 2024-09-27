resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = false
  enable_dns_support = false

  tags = {
    Name = "${var.env}-main"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  tags = {
    Name = "${var.env}-private-subnet-main"
  }
}