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
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8zNfQIo2/whzG0LINXyKbzXvNRVDz/lwq9aS4gjPo5hHxmzJrkdaYGTJyjYWrTbG5DUPDDoJPWyCKl5pLcVDTD6fx1VwrmaqRR+geEPyUZD3bNNysVWO9mgEmePqF4MJHkBN/EBkXfUiF67K7rJBucwzc2ndVQLvDPDhC+NwCIddWTnuOmbGaapZ9wwXoyJK2tCWWXBjk/juLPDrwZPHW+60VVyHoqjejAcxbvNEdf2iE1bOStQ8hmXfvrsfcF+riUQn6tysnin8mqzv9i1q5rsUVxQrcy2bygV7hB6VvzM88zUoghId9YttYUned4K1xAOSqk2UU1bUsnpEni2uz+UwCnhaeo7Rx/M0C5oGUg8zH4oA+2AmeYywVcEJ9JrsLe4mcqPqOSnsofj/TYWQ+Vsma/IxRUlYZM7TubgLZ1yMN9QFjtvB8BtFxizRMYa7eHxG8qpcLvb2Qn8hhj7iwbD0/Ew0CYA8Fh8GkSkVYU8+bmzWNLqohOhswPYu+detUDHlKuRlSvuEtbTZn5cGABGi0JxjplJJsZDFCJkwhW/yXIfi9J1crtSHYDOWcAU8TAeQnRYRynU4abcu33vF0yI4rqTHS3y8Klrw0wne3KN8ZUDKufQaDxlCH+4Gl0aiKVgdoWQrSIgwuPJ7cGmhOdkIj2XDDJYXV1TCthvkADQ== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: Tru
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