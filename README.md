# Terraform Structure 

 ## all in one file main.tf with one big state file

First approach issues: 
  - there are two majore issues for this approach, if you have more than 100 resources in terraform state files,
    it becomes very slow ti refresh the state when you run terraform plan which can be annoying

  - everythin is hosted in a single state file, if you accidentally delete it, it will be a big problem

  create a single point of failure to avoid these issues in large project, this helps sprit terraform project
  and terraform state in multiple components.

we delete all : terraform destroy --auto-approve

for second approch we add vpc folder to dev env
