resource "proxmox_virtual_environment_file" "test-vm-fedora-4-cloud-config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name    = "infra"

  source_raw {
    data = <<EOF
#cloud-config
hostname: test-vm-fedora-4
users:
  - default
  - name: guillaume
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDC9U/1zUb2qHgfhz7qtz3OTWkkohpt3R7BQ/+YVjA49adRQ1LL61Qxd8d/l39qRYyYx9CFLyBefDBn4AXmpLGstlkxW9e1Xe0YS4QqNdaz1pR+FwqmVu05whu/VthCzjLQeFUM/hlc0Zi0ZQpb+WIjj3rlpzJ9Q+Yhoc3mPHqGj6mCLMVz/PdVHLmgxTHmLdp46I+62b5SHgaZ7aPaBC+piou3Nw5nCQ62r/2+wVepnhBK22yo9JM9CuUcihvHjiKjzZmYZsB35dwEPc+0aBo20WYtVABxLs0DMw9Y2lUw+rWJe+/SEoTVP7d788okpFJ/7xy/cjAZcsegej879YFlak2TlYijxfSHHEsu+gosNxVDhJPEOjnNUZ5u52KnzLIPhpPqi9O67Z0HbGLsGJuFCKssg8rEm5wt2CKQiLlPSeEkiaS26jiaX+/YMyTjs5vEBRqw0dQBRTlct3kISp2IwkJQASQHgMp5Nez/kWyC4knWqmM9HO/hIdCUhgthFGJ6AnYPC/dr39pihUL8eBZL/crH9OKfaOTa+NrUL8XWxQgRhS882JI7bxcsy+Af2Q7B04zgDEN9QSaCNAH3nfvep6z7MDRI5lpMdHYdUlxnAmr1ufElVMfxm09vDtlxloDHCT8tJR+Na9Aq2RywprVhg6bnzp/yv80Gm3gAOpJ/EQ== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: true
runcmd:
  - echo "This server is automatically provisioned by Sloth" > /etc/motd
EOF

    file_name = "test-vm-fedora-4-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "test-vm-fedora-4" {
  name      = "test-vm-fedora-4"
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
        address = "10.18.0.132/16"
        gateway = "10.18.0.254"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.test-vm-fedora-4-cloud-config.id
  }

  disk {
    datastore_id = "sloth-vms"
    file_id      = "local:iso/Fedora-Cloud-Base-39-1.5.x86_64.img"
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = "20"
  }

  network_device {
    bridge = "vmbr018"
  }
}