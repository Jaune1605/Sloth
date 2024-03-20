terraform {
    required_providers {

        aws = {
            source = "hashicorp/aws"
        }

        proxmox = {
            source = "telmate/proxmox"
            version = "2.7.4"
        }

    }
}

provider "aws" {
    region = "eu-west-3"
}

provider "proxmox" {
  pm_api_url  = "https://10.19.4.4:8006/api2/json"
  pm_user     = "root@pam"
  pm_password = "slothPAJO123!"
  pm_tls_insecure = true
}
