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
        access_key = "ASIAWUJAKGXYBG5HJFXB"
        secret_key = "IAj1S8QLcR7mWDS9RX2BzzxsOIHVADcTE2ci7HcW"
        token      = "FwoGZXIvYXdzEDwaDIxie0OtiXP8VbEA1iK+ARgWggYU76MoBjIJDx9/aKTn5F9InWUTJ73pkcKZ67mr9sfeM8vLF9DA/Yh8Y9EPshcjvX/V4O6DdENXAea2EarnxIVD9vOZqf/pRN/cFhC7B1GvuYrQyPhwC5h1BCiizYj94OkoTKyCEuvWsD0c6p+UuWeKao9ks3CHb8X3ajkTjxfnNXPII4T+VuafPUrdJn11WecIgxrke8j2k84pHS6eWJAyK4IiSNlcd9HvlKMd4hbvvSb6RaJKwboImxYo/77OowYyLbLjjtOYmoI/o/m90lWehnNIwCizNfRGuTB6qt481iUt28yv74Bl9j5aIgIkmA=="
    }
}


