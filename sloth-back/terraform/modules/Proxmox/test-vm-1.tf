resource "proxmox_virtual_environment_file" "test-vm-1-cloud-config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name    = "infra"

  source_raw {
    data = <<EOF
#cloud-config
hostname: test-vm-1
local-hostname: test-vm-1
fqdn: test-vm-1.sloth.co
manage_etc_hosts: true
package_upgrade: true
users:
  - default
  - name: guillaume
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCq6fvAORh4uevz8AkCXkkTDZPb10JBDqRRZsnJq2AJJJlXe6A0yJENcmUeysL1MjfKLjP24rkB1BKV2rsoVz//uRt7jO2VPw2YbNa+h2RPqKEdXE2b8k2AdDFafzZjJMdAXpJHszEP3gGJR2EIEdVsgvkn/QjAV0XunqFwm1PuvT8T3rERnBxzvPD7JDEE1iFq7a4j38eQKktFct9opv9NOy/OmVNycUZQAmS/HdQXGE8G7HOE5mHMX9uDZVM6t/z7jjZIQYxNwt9c+QjWI1pF1idIaf4ZeXwxoGzIHKxp4ZvkQrw3rBmHdHGHOQqIfBvL9zyig9lfMda1Jy33sZIH9762bYZIEQzjoLt4ZGyn5+aW8+XhDjZlOxb7hlm44IMI5mJxaJJUrGCa2E6nPhrDGJ4lbelINZTFXKnO+pJ9JF1wUE3VIpWKXotAlRMXJNozNa1nhh/8Sho971h7I5Y9UJQabnonLRzC/2gxze3n8sdybK1wbAzDPd1Hyuy7hl7EViZ9ZQ0xim/srQOMq5q33JGQZH7ABTXTh/7xM6kVqh9JvQ2GbYU93pVa2cAM/W8OLqXj4ZYmTBQsWHMruXi78wUOMpz81GlInvfTxUjMOhCI3U0LFqW+8JviCSvn1vVX6i/K/olVEL8bPq35Lbpy7wLJLcyGc4imtZCu/NlPAQ== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: Tru
EOF

    file_name = "test-vm-1-cloud-config.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "test-vm-1" {
  name      = "test-vm-1"
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

    user_data_file_id = proxmox_virtual_environment_file.test-vm-1-cloud-config.id
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