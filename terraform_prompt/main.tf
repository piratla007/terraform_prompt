terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"   #mention region from your respective AWS account 
}

# Call Parent module

module "parent" {
  source = "./modules/parent" # or use a GitHub URL



  resource_map = {
    for name, type in {
      (var.base_name) = var.resource_type
    } : name => type
  }
}


output "latest_base_name" {
  description = "The formatted names for all resources"
  value       = module.parent.latest_base_name
}


