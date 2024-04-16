resource "proxmox_virtual_environment_file" "test-vm-2-ansible-cloud-config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name    = "infra"

  source_raw {
    data = <<EOF
#cloud-config
hostname: test-vm-2-ansible
local-hostname: test-vm-2-ansible
fqdn: test-vm-2-ansible.sloth.co
manage_etc_hosts: true
package_upgrade: true
users:
  - default
  - name: guillaume
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC61WNxADmdJdaZ0JKrPQ7Caykojx6Z2u04/pufzwAzrA0jMEhrNx8z/ME14d4dtaxQ83DIxnqTa9QFWlFOyY/IpvRsLvfThAwXQtWo2mLNiEZDcEFWn3qu2LYbp2RJFUP30ua2BsH4ZZ53NbldNsyfGocbkdFdb1HJvpu8K1mmy3UbHj4KmpZV2nR5Gzd5W7efv9bsFeBZcpwM3IYr/RZSwp9ARlL+La+AYz7mIHGFyTICNODVUpzvQag1XB92WzMTlj00mW3zWwouc3FEwKs/Hkdi9Mul7jOgzvejl0kXFgKzaSjEycbrCrNdm9QXoOCY0nKwPF/z9GhLaV8pNFYEyEiEmdrWdgIo57Yz/3NjAdQxRbqy5FJAXpBJ3uby+UTLycruP+nx6ISvW7dSe8FrDl6UDjW4Zx/WsK+refXgU85fu6uVaceDaBmcz5PgI5rbU3XnLkzmYdy068tEvQxnzqjifFch9h5zFVXTH/nbZljUACnUMde8XFKCmAgn5KbCzOl2hc+wsgBaC9NNCfPbQWA16rMsCJAZlMqPJir7nFfEMDHg1QkdVMTd3Z+cjR3kUMXwVRrnh3+DUhtxESewQXonsZiXHn38d2XsbvA6VU5w2g99AzPZQpLiBazJJKTU2uK1cwNqMoFU6u7lqSEXJUCWn5KWwTEpZBWi0rxlbQ== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: true
apt:
  primary:
    - arches: [default]
      uri: http://archive.ubuntu.com/ubuntu/
runcmd:
  - [ sed, -i, -e, 's/kinetic/jammy/g', /etc/apt/sources.list ]
EOF

    file_name = "test-vm-2-ansible-cloud-config.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "test-vm-2-ansible" {
  name      = "test-vm-2-ansible"
  node_name = "infra"

  cpu {
    cores = "1"
  }

  memory {
    dedicated = "1024"
  }

  initialization {
    user_account {
      username = "guillaume"
      password = "password"
    }

    ip_config {
      ipv4 {
        address = "10.18.0.232/16"
        gateway = "10.18.0.254"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.test-vm-2-ansible-cloud-config.id
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/ubuntu-22.10-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = "20"
  }

  network_device {
    bridge = "vmbr018"
  }
}