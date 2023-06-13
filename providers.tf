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
        access_key = "ASIAWUJAKGXYOIC3F5VG"
        secret_key = "22Moqxc2aKfSTUC2ORvOmh9TqnWRIFf57/jnw77k"
        token      = "FwoGZXIvYXdzEPD//////////wEaDDYIKpeYfR8LWr/TDyK+AR9fL5cSbNIO/Q8uw4PdmZ4gW6VkWMV2y6x3d+5dAVLtddmAOx26D1CSS/RdJjRNrYQJDCbgNcNJUxG7r3pZXLNkYG7HYZgcGHlvbRPjFqYOg0/ifRP8fWO1dNfAmYQxVbCTLjRFl3padZD7RxrhXIXhVxJHYvWAxoonz5WE4Sv3nB/jVvDOzmu8AiGnv53nydYUwyTyuKIX4zTlbo5gUef7XzM1AeueK48sozIdfVFiu0V3pzs+/R4N8U16Iw8osvv1owYyLfirkPNiGncj9ehClKIXG1qGWWuHwtmppa2eOzU5uVkrGWCM2fhmdxCPCfqm2A=="
    }
}


