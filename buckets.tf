resource "aws_s3_bucket" "criminix-dl-prod-data-engineering-raw" {
    bucket = "${var.default_name_buckets}-data-engineering-raw"

    tags = {
        Name        = "${var.default_name_buckets}-data-engineering-raw"
        Terraform   = "true"
        Environment = "prod"
    }
}

resource "aws_s3_bucket" "criminix-dl-prod-data-engineering-clean" {
    bucket = "${var.default_name_buckets}-data-engineering-clean"

    tags = {
        Name        = "${var.default_name_buckets}-data-engineering-clean"
        Terraform   = "true"
        Environment = "prod"
    }
}
