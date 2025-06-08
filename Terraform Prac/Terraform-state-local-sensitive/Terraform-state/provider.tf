terraform {
  
  backend "local" {
    path = "D:\\01 C.O.D.E\\playbook\\Terraform\\Terraform-state\\terraform-state-path-change\\terraform.tfstate"
  }
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.3"
    }
  }
}