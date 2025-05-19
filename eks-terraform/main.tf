terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "demo-cluster"
  cluster_version = "1.29"

  vpc_id     = "vpc-06d0215b517ff6dca"  # Existing VPC ID
  subnet_ids = [
    "subnet-017effb392c93f8c4",           # Existing subnet in us-east-1c
    "subnet-0891da2248f9e8252"            # Existing subnet in us-east-1a
  ]

  eks_managed_node_groups = {
    demo = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t2.micro"]
    }
  }

  enable_cluster_creator_admin_permissions = true
}
