terraform {
  required_version = ">= 1.14.9"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.12"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # backend "s3" {}
  # Uncomment and configure when remote state is ready (e.g. Terraform Cloud, S3, etc.)
}
