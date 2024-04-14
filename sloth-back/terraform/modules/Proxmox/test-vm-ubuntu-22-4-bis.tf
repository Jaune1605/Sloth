resource "proxmox_virtual_environment_file" "test-vm-ubuntu-22-4-bis-cloud-config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name    = "infra"

  source_raw {
    data = <<EOF
#cloud-config
hostname: test-vm-ubuntu-22-4-bis
local-hostname: test-vm-ubuntu-22-4-bis
fqdn: test-vm-ubuntu-22-4-bis.sloth.co
manage_etc_hosts: true
package_upgrade: true
users:
  - default
  - name: guillaume
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFQ35hGnkpmXiHfD+n/q00RDe/hmkWUrHrKOzUwDnPmC4vOsFgT9HwfZx0O9cuecFRHECVu+YxSC6vPj/XRjUb8JOXXoZ2Vh6FJEV6YXtD9D7SF1iBIEG806lHK0KNAGAgKogw9YBEJH66Cqn09C1X325hGjVirxZvihLzbxUyV+1tfH3dJCotYsIhhpudQrw51bcctIQecY2L5YxUZq93879aJ1TzIlvHkwLWD6HDT7IvhYW0j0gEPp9w30m2xAuRlIP8OIrnJPMoRy9AqgtM+i/H2RrCPmcsfzXDUJASMsxs7L3cMz7UKEZXScSkZJV/3mvyUB4ZzrmLn5z3Vo3JjctLCG6MWrgnOFNeHuRYh8ytWIaG2zHgPjLFNKft/tYrd1u/lMTjzCBxvgPpbWXp9Okp0C2eZiEKTcO5ubajHxXK2SgVCVjQ3SIb/nfJo9ZRTywpJdyw8fsqxqyQ9bfhoEKmaGCM0NXZ6QtwGphOYhq8F/45pxUfawlK0qjtiCRbMOKwh5/0spa29iri9ceDDwiCk95hdRhaJ2PuOSoIJnUxNLzF9NlnfrL0s7+3cFTLR+B6EEL/0tbV5s6YnY9evh2ouuKuXMBZnkoZq23PqJFi0ZMCtuZKG+h2EfXQnXkjt44Ub/6hqMj+03MCR8UpslXF6Q6ab6THOojlaWyipw== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: true
runcmd:
  - [ echo, "This server is automatically provisioned by Sloth", >, /etc/motd ]
EOF

    file_name = "test-vm-ubuntu-22-4-bis-cloud-config.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "test-vm-ubuntu-22-4-bis" {
  name      = "test-vm-ubuntu-22-4-bis"
  node_name = "infra"

  cpu {
    cores = "2"
  }

  memory {
    dedicated = "2048"
  }

  initialization {
    user_account {
      username = "guillaume"
      password = "password"
    }

    ip_config {
      ipv4 {
        address = "10.18.0.212/16"
        gateway = "10.18.0.254"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.test-vm-ubuntu-22-4-bis-cloud-config.id
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/ubuntu-22.04-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = "30"
  }

  network_device {
    bridge = "vmbr018"
  }
}