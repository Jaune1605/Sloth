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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnoTD0oNHJ+LWa10JUgcnEmvC97ypRgWJVxzLss6jqGbPS0Dqk3MlyUDe6devum5p/KWJlmZoc58vczP1OJZisTqESg0lukXTEtH7p3JdnpouGAlR/AgcQpfWi1xLZ+/sb0F+l/e4ov19FDLwndW7guDNV1c8rEPbqN6we4O6O3YhjrpNHIysTYsiLvJ1PKskC/ETxmunqoEX4NlLU7EN+8j+QE3kuQWj9IjWpWjAlk8ZVwMel2kESpkLP6ssmmtxtrW0m2V2nn2h4lHCauVaSHGVX7ACNy82UPi4wbvbEbx2UZRgBpo4uvdmr0v59OrCPVgaOSgAlbs97HXku66sf9D5DJf3j1aB51TpLWt3jgQIZqerzarroVNKDC/0TskK/H0IlNyHp9KhAZ3OoWzIVbGW//HWY0ssaZ5tJraQa/v4Dc37I63HY0Z/TozMEFY+7rTrPFn6s5zcMqBD6OonwFLy0lTa/7u+JsCuSGZHeYGN5Knbb50TnZaAU3z6kxYSrYLne+lIMO7PWUKtXMvurZMnvkdPIJnFzgU/Gg9OdeDjcowKGJoCIE2abr16vjzxOvec5J12dyjd6TN8VkgOVOFhajRZjTIKQXbzXWTics8FRMhXbwd3eQv0m3MykEQqUjEU5LFsGrUt8sij7UZjX7LgLAdMJg8uUXkGnS/WKzw== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: true
run:
  - echo "" > /etc/apt/sources.list
apt:
  primary:
    - arches: [default]
      uri: http://archive.ubuntu.com/ubuntu/
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