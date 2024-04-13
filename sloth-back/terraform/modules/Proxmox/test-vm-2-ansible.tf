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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDI3cjsInOZENiDOPHsySO1uL/dTj1ambLNh67S7zp2jfettP80VLxMcc1iHDELgaGvuvAy0ZIDl0f+eZjnQRQGL0dnTtzUPCTMYF9GL6ONQIC7YWEe/paL2qR5BKKNEcIyOFcdKdJkC2jrKG5frslM2JpkaL/s64LBhJyL33JYG//ilZ2cTMVeN99DUqZNpJ+WB7tpiHOJyOGJx+ZgiijiPK0uicKcOwJ7UBBVbiKZ8QVll7JqonrrNraUJSTnhQyg89NhHoBz7aLd74cU7qogKE700biIWGCdHao76kRw+N94AsJAGAQnmts4GBTJOYb7W+BCCr627FaeQekk9msSz72BVnWPpNVpr/tNvS5EphUoDSa4HTXTFIhaJbwL88AeN68FOCdw+WhTh3H/MEk7sIG/BPPTsU476uCvVLWUbDJNcUpapiz5U0evMHhvXQi7dlGJoKYxjMlnjfcrW5Y5EvQ3a4sgA3Byu6Iiow9NB5tQoPF8bUGr/CObtLuOhd/VTpcv7xwq0+jKJo7HQKNZj3C4diZPlDiu4gzP1QzvwGmDJHv9muvmIEkR7NXxCKNVK9s5HX2kAPXI21PEHlS5ZzbrxdE3Q9kabxpE/JuFx+jUJ9n5hpRUQERCQR8DYjy1QAzTKipLHWbcCGIXp4Sre8osQESapg7YNRMtF6xK+w== guillaume@Laptop-Guillaume

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
        address = "10.18.0.252/16"
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