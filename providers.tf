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
        access_key = "ASIAWUJAKGXYJT2KTDHP"
        secret_key = "bKiZBmIfjzvLWchtdn4bkyE6LSvZ1ngWwSQ5BaGL"
        token      = "FwoGZXIvYXdzEA0aDO9d1caYUkNJmbOgKCK+ATJmv5cJQGp/p0+BR6l+aSk/BcZYLA7glDSjLqL9HpBAWDQAwLtuw/f/vSJQ7E2X7HAiSoHp5RqZtIxKO0raWiaBA+HXoDlG1VVojGuMeX8pzST9ky0J0EERMTUqIOfBsr8G/wmBrlAYPMO2wVxTKizBnCUQs8iINR9hnuEHR+VNLB/eH8sxAjeyd9fA0pieLkM2ZJvzOeocv1QSmvEqGGouwLm4lLvdbPbA17aHsYXxveKxI98BO2TXqAeM99Mo74nEowYyLZNKT1JGLj371SNp6Dp0K9YFGfVvcqaBa733pw3pvc2CdRVrhRZx1g2KuH2KAw=="
    }
}


