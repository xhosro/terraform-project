resource "aws_subnet" "private" {
  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_block = var.private_subnet_cidr
  tags = {
    Name = "${var.env}-private-subnet-main"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}



# output "terraform_state" {
#     value = data.terraform_remote_state.vpc
# }

