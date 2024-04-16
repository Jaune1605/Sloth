resource "proxmox_virtual_environment_file" "test-vm-centos-test-cloud-config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name    = "infra"

  source_raw {
    data = <<EOF
#cloud-config
hostname: test-vm-centos-test
users:
  - default
  - name: guillaume
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCAMSfWMRSeLtatBr3St1hcqzVt8lEi5Fxu7EApP05TnjbWB7oFnEQ5rtTfAtQsk0LmKyfqFsZi6uC8kFINMYOVwtM7H1l4G53HUWVywhjDi2FMsO2oM0yKTdWUkvrmlwODh4l1BP3cwuPS4yruNzYfniehhXwLwMizLwunQDEoyuvRd4SjJACBSk3f3oYqQ0iHSuCMA6pjcgpo7qnDhkkaZShxuq+96yJiS7bh+4ztS+g/CBcv9zxmm7uNtkgPUS1kaAdlokX87s9R3BZcae8RYKDMcJ1m5Nb1W8ddI04xPrwlSMYLpjxp6d3AunM9GoqTUCEjumukyvmw8sjLR5u/aG9TvA+WHyONC1dxT0Ma4sUXeA892kwMjvALM0DyfgANVjITrrYsm15emtnp75WPVocodsJ+MEdYMxw6sypmCjJJOqYrcgNmEqnStnW01meQDr8xoqrzHkGP3d8u1muUvgT8UPmb13W9KBKt0OxzQ73UVt/IQ5rwYZZUn8NbCmZ+4vb10Thg0niyvYZJmmFEBNyR9wkNIiQ0Lt1+Zwl/OYRy4NpIsCPrHNXm+iBlQWh9uZ4o3FbDFN+Cf8e/LogMp4zzA51sn2CQEBhJQqbMmEPeOVtEc3o06OQxj0TifOUf8Z0w+j2AtG8W713rvYeiNcefogy4EOIJNskJCmACw== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: true
runcmd:
  - echo "This server is automatically provisioned by Sloth" > /etc/motd
EOF

    file_name = "test-vm-centos-test-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "test-vm-centos-test" {
  name      = "test-vm-centos-test"
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
        address = "10.18.0.67/16"
        gateway = "10.18.0.254"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.test-vm-centos-test-cloud-config.id
  }

  disk {
    datastore_id = "sloth-vms"
    file_id      = "local:iso/CentOS-7-x86_64-GenericCloud.img"
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = "20"
  }

  network_device {
    bridge = "vmbr018"
  }
}