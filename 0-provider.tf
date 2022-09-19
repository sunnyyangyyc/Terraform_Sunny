terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
 
}

  backend "s3" {
    key            = "${var.statefilepath}"     #"uat/frontend/terraform.tfstate"
    region         = "ap-southeast-2"
    bucket         = "cc-terraform-state-file"
    dynamodb_table = "terraform-state-locking"
    #encrypt = true # Optional, S3 Bucket Server Side Encryption
  }
}
