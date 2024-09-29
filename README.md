# Terraform Structure 

 ## all in one file main.tf with one big state file

First approach issues: 
  - there are two majore issues for this approach, if you have more than 100 resources in terraform state files,
    it becomes very slow ti refresh the state when you run terraform plan which can be annoying

  - everything is hosted in a single state file, if you accidentally delete it, it will be a big problem

  create a single point of failure to avoid these issues in large project, this helps sprit terraform project
  and terraform state in multiple components.

we delete all : terraform destroy --auto-approve


# splitting project to multiple components

for second approach we add vpc folder and subnet folder to dev env
and agian terraform init && apply - for subnet folder too

so we have terraform state separated
but we have on error :

        │ Error: Reference to undeclared resource
│ 
│   on main.tf line 2, in resource "aws_subnet" "private":
│    2:   vpc_id     = aws_vpc.main.id
│ 
│ A managed resource "aws_vpc" "main" has not been declared in the root module.


first sloution is to use data blocks specefic to the components we need to reference

variable "vpc_id" {}

data "aws_vpc" "selected" {
    id = var.vpc_id
}

but it isn't work very well, so we need to make two diffrent 
so we add to the subnet folder: 

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

output "terraform_state" {
    value = data.terraform_remote_state.vpc
}

and we add vpc_id output to the vpc folder 
and we add vpi_id data to the subnet resource  for resolving the error message

so you only need to refresh a subset of infrastructure each time you run plan

we dont have a dependency graph, so we need to create & destroy infta in the same order

we you split terraform in multiple components, you need to create some kind of obstruction layer
or you use terragrant
or simple bash script that applies one component at the time or integrate to CI/CD pipeline
for example you could have github action step for vpc component followed by step to apply subnet

so we can add tf.sh for automation of process
and then : chmod +x tf.sh

let's run ./tf.sh apply
then ./tf.sh destroy



# Mono repo approach

first we create a vpc module
we never initialize terraform provider inside the module
change the provider folder to versions
add main.tf with source of module vpc into env-live/dev/vpc
in this method we can update the modules and environments in the same place
It's good method for one person devops team
then initialize the terraform in vpc folder
then create a subnet module
we dont nedd data.tf and add vpc_id variable
then create a subnet dev/env