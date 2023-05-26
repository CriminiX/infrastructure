variable "amis" {
    type = map(string)

    default = {
        "us-east-1" = "ami-0bef6cc322bfff646"
    }
}

variable "type-ec2" {
    type = map(string)
    default = {
        "data-engineering" = "t2.large"
        "application"      = "t2.medium"
    }
}

variable "key_name" {
    default = "terraform-key"
}

variable "default_name_buckets" {
    default = "criminix-dl-prod"
}

variable "region" {
    default =  "us-east-1"
}

variable "zone" {
    default =  "us-east-1a"
}

variable "key" {
    default = "terraform-key"
}