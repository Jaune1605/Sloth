terraform {
  required_providers {
    proxmox = {
        source = "bpg/proxmox"
        version = "0.50.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://10.19.4.4:8006/"
  # TODO: use terraform variable or remove the line, and use PROXMOX_VE_USERNAME environment variable
  username = "root@pam"
  # TODO: use terraform variable or remove the line, and use PROXMOX_VE_PASSWORD environment variable
  password = "slothPAJO123!"
  # because self-signed TLS certificate is in use
  insecure = true
  # uncomment (unless on Windows...)
  # tmp_dir  = "/var/tmp"

  ssh {
    agent = false
    # TODO: uncomment and configure if using api_token instead of password
    # username = "root"
  }
}