resource "proxmox_virtual_environment_file" "test-vm-ubuntu-22-4-cloud-config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name    = "infra"

  source_raw {
    data = <<EOF
#cloud-config
hostname: test-vm-ubuntu-22-4
local-hostname: test-vm-ubuntu-22-4
fqdn: test-vm-ubuntu-22-4.sloth.co
manage_etc_hosts: true
package_upgrade: true
users:
  - default
  - name: guillaume
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBY2Al0BciQTCI7PTgxZNXhraQBEdAE8dcR123MI6T+uoL9u63qngjgBIJ0UuX7IHcpcG7SGqbt8QkihIM+rFn/x2M8DQ/VhE60QzoF6onCdtobJCf7r4zoDbZwXtDmexvlpuezAoonW7JNoLGbzwbkBp4FQVxSp1Ao9RsmkUAXdy4ExIL4pGqF9J5mlmlivnXfxlTeQN92So/P/avmNR6bNTdReGF/bkO2uZxMQEh4nBEFE4H8//s5Ch3jsMQXjl7ACPGgliuQYr8hhEq+1QVQKa2mmOwJvzXmEo26wMG61cEcPsfDZ+qy7uQsQ454kNggpVpZ2szDB4dm78e6LhbI1dLgiUppPEbXYQcg6uD/Stba607mN3gbVTeYxrU10gLGZIoliSvJ/ehNFOcJNAhdKhgCKu+ZGLEBfRh8Injzg1v+r0v94J5So5gBHh8Ajv3eRuXFfwWkZA+JxA7XX0fAUenPtiDWG0/uztn/QArQB5mNnoVywYtdezgmMda1uO02r02q1b01oXxIu0WENzJUMnEyffkc8hR3ccPy0dZ6t2yrh5XG0NvONzCxHW9WIpEDgoNb9F1r1fAhzJLAQa69q6LwVeu0DeOrMH9r54yDsO6UZdDq3gp2E8vLboaZK8ubsrAdzJ6Ije7mNbqHBKH9ntkBGHzn5huR+nXO7dliQ== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: true
runcmd:
  - [ echo, "This server is automatically provisioned by Sloth", >, /etc/motd ]
EOF

    file_name = "test-vm-ubuntu-22-4-cloud-config.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "test-vm-ubuntu-22-4" {
  name      = "test-vm-ubuntu-22-4"
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

    user_data_file_id = proxmox_virtual_environment_file.test-vm-ubuntu-22-4-cloud-config.id
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