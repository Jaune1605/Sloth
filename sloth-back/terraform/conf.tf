terraform {
    required_providers {

        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = "eu-west-3"
    access_key = "AKIA2UC277IHXM4VBKGP"
    secret_key = "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"
}