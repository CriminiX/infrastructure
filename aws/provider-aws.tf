provider "aws" {
    region     = "us-east-1"
    access_key = var.aws_credentials["access_key"]
    secret_key = var.aws_credentials["secret_key"]
    token      = var.aws_credentials["token"]
}

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }

    backend "s3" {
        bucket = "criminix-dl-prod-terraform-state"
        key    = "terraform.tfstate"
        region = "us-east-1"
        access_key = "ASIAWUJAKGXYKMV3UD5T"
        secret_key = "DLt8k9Dv2yPbPdP1g8z2r8HlwrqU/g4Bv/zKfvhD"
        token      = "FwoGZXIvYXdzEGkaDDefWuPf64g4Quf9jiK+Abb/8ucrd3q1ZC20OIyx0hldHKnrMGNLTHBvLU1jEKSEncWDbQXkYMHbWUGTFCt+DAK1yJqntbzSaLsoeB0vtolUOyrbS/1cmyRjXQx6BVZYLINIF1jdyDDUT0D3gHmd/3rxRuGSTBg5udYEDob5sbj9mX311SdgvsBanVI1Ou5h9UajK58904SI7uwA5oBNZmt9V6PxTg8NyBGxJ8qdF1ASPZS3AWtFOOL1mswSHff/xahLkqDIFtSUFHqGtHsok/rIpAYyLcebwgpZOWaeTcVfyvKZC+3b/lkfkHs2wNNZouEwDCyLBosUL6qTLajv3olW9Q=="
    }
}


