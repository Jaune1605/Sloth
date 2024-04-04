terraform {
    required_providers {

        aws = {
            source = "hashicorp/aws"
        }

        proxmox = {
            source = "Telmate/proxmox"
            version = "3.0.1-rc1"
        }
    }
}

provider "aws" {
    region = "eu-west-3"
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url      = "https://10.19.4.4:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "slothPAJO123!"
}
