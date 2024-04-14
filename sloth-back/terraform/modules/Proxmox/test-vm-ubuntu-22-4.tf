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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDizQaj0sy9O+dQMZ+tK+rr4mT2gg+DyRp0N0Po20J36uJzzVtZhFY0kMT+pO10ZYod3Jx6SgTykkPG8OA1L3zyOSdEfQi59dkjF2SBWuvw4wKApyz2Ov3E4bF1XJwRpt+wjckQSh0aq/3tyVV9Mydc+HnDiSKrbpgCvEAh67/amJ4B+rTn0slgyLqA+dvaNNne25l+63K6u3SHKzDH6eiR/4UblqpXScmb9xZNvxhsPQvbS2Clo/Ney895FRoE/sjrN6YSgYNIr/hHUNfwLZzC3DzeRkLkgXQscrBQ8xoGWqMA7QXP3j4Fy2gQRdoZN9LMJIxhS6DamKggOzGyh7ZEYpcThVxNzAjqk1OS3pO++Bcow1lmMHmrgxHimEvPxBWnb4LmEKKrM5bShRkkeCx9j8ov8yY3ALf4utGEeZ7BkGHI0wG5IAPi4Bgki+xPHImGqa2gESwXW5LIWEnCN42rSjpDZz3l6iZG6LPBymmpU7YSeCyrAvAqtZRzfQJ3Zv6w7Nomlo+bkPeAh9YxBMgv6XOoaA3QiguMKgWPuy4tK4hawI6vK6VKfz4mGPEL43fD5QTYvGwRmqBeW+AnMIpiu2rmywjcv18rZAvK2qwr1TtVuttVtp18JGZA/xFlF7Gl+taWC3Vaak+jUXFj25BT071SjR28E3zogg3Og98gsw== guillaume@Laptop-Guillaume

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