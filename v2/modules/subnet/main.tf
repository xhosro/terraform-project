resource "aws_subnet" "private" {
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnet_cidr
  tags = {
    Name = "${var.env}-private-subnet-main"
  }
}



