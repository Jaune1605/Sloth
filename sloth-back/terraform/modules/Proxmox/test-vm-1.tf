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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWqUlPmkwzC4SoC8szqmiYOKEyVWwZ8EBfADqGT71LUtPLy7Eo6o6Tmi46rYJmRFPVG3VTl80gpsKLp7bRMsIahUfnEt06nuFubwZqmPkZfurSo2DvhTYotwgAqE1t6ZwtnnVTCYoe7xSn4dDRaMAwaiRDGXenXId2efNzh3ETaSCyaGxONEOiPzco7Ejz0zgeXIPwdqZBRQBi6b2Kixcvd4ut0b5vewWBiDc7kUqNpSqgX86Yqr1BeoJWfEFLWnQi7G6Egqg5ysTHSHnQp5o39ev18YUJoVebYWyedB0MCJEbs594UOAjbhJ0RXNCtrRy/pQ7Fko57f1AuwrOqZLIxGWSpQxcvSYKQ+0/hKcRvDIKFGXVB3Mg+oqOalxY5YZk+qdw7YmSCGzGYo4qtM/H7rVE8GyZTSldoj4WHMxW2OVEiWF+eTaXAcVhxsaCF/849INAIEDWiD7OCGgrmnJxs4/4nbfeTFq1++3DpperEg5fllbCsf+J3xFylem2tK7KFM4VUzc2g+PWmsjI8KCdlgdkGWvFkqarps56S3YiZzwi+orotc/sGzmo+shEm1HVPUJg/HLVGM/FS2V2PBMCW9ThBlHbYixuvABS8oIvA0r1EVhbK9NvRK+geN37Mn/vnx5H2AsWOa08zruBSMUQ4Dn7fKWNZOv9glrAr+eARQ== guillaume@Laptop-Guillaume

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