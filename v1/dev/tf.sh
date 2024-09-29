#!/bin/bash

apply () {
    cd vpc || { echo "Failed to change directory to vpc"; exit 1; }
    terraform init || { echo "Terraform init failed in vpc"; exit 1; }
    terraform apply -auto-approve || { echo "Terraform apply failed in vpc"; exit 1; }
    
    cd ../subnet || { echo "Failed to change directory to subnet"; exit 1; }
    terraform init || { echo "Terraform init failed in subnet"; exit 1; }
    terraform apply -auto-approve || { echo "Terraform apply failed in subnet"; exit 1; }
}

destroy () {
    cd subnet || { echo "Failed to change directory to subnet"; exit 1; }
    terraform destroy -auto-approve || { echo "Terraform destroy failed in subnet"; exit 1; }
    
    cd ../vpc || { echo "Failed to change directory to vpc"; exit 1; }
    terraform destroy -auto-approve || { echo "Terraform destroy failed in vpc"; exit 1; }
}

plan () {
    cd vpc || { echo "Failed to change directory to vpc"; exit 1; }
    terraform init || { echo "Terraform init failed in vpc"; exit 1; }
    terraform plan || { echo "Terraform plan failed in vpc"; exit 1; }

    cd ../subnet || { echo "Failed to change directory to subnet"; exit 1; }
    terraform init || { echo "Terraform init failed in subnet"; exit 1; }
    terraform plan || { echo "Terraform plan failed in subnet"; exit 1; }
}

case "$1" in
    "apply") apply
    ;;
    "destroy") destroy
    ;;
    "plan") plan
    ;;
    *) echo "Usage: $0 {apply|destroy|plan}"
    exit 1
    ;;
esac
