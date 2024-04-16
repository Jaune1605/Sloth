resource "proxmox_virtual_environment_file" "MachineOSTest-cloud-config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name    = "infra"

  source_raw {
    data = <<EOF
#cloud-config
hostname: MachineOSTest
users:
  - default
  - name: machine
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpk93wbAlhGY1e3LbMtv3SmGJWOORrUYV3rpzxwKEcSd45TOiJg2MpT7dhH93hsM7NeoocuUQ0aEPXgZOTOL8YISzMTngZO+ZdRCCkAjlh+A9715sc1cmTH4N4vRnGKGXICvv73TSLb++B20oTH4Zvr4wnUd1g8pzlJfhGnVmdpaBJaD2sMyw/il6cQVDYpL4ZWYTpbDAdlM1AlemT3Fz6IWplGREtTFlS0cUbp0yD2ql0bQSMu6KF9U7AUr4m95N8LdLZf4zjUqJpEVoRhgD+UhWvMSm9WG3hFv8LkWXtLpRTN6ACbcpWb3nnOUTEFe0pR4pXQA9fHig8tXA2Pcv/Z7G+3WNVwrq2MBkMUXK9NvbAUdX+hsTNhCpnGPuqt8oLq7h49z8N6xZ+3UvD1+XEmHLJAsSM5qsraS0FDht5ZYaVJHNhlmPhSwhw0iIcmO2sP6IryxoM6KvH8eLHlhBF78nJCztSadVefgavXxV3a0oDnxlIUNZ2/WxtGadJSBa2ZPBJTy88ZdkY8ml6ynwMNamqNSlKf086AST4/vkDvX8lG6+9kj9BIVJI8ICQg/umRBcg3oATWMV3q+44cT1H2Gaa8ofSAdMXiva+o2TVHYcZBaQTJJPg3QvdLXbjTbMClDPHc3kTJeEFXi+zmTKbXM44qOSjWoJ+KG6RrhRtew== irlando@FixeTheo

chpasswd:
  list: |
    machine:machine
    root:machine
  expire: False
ssh_pwauth: true
runcmd:
  - echo "This server is automatically provisioned by Sloth" > /etc/motd
EOF

    file_name = "MachineOSTest-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "MachineOSTest" {
  name      = "MachineOSTest"
  node_name = "infra"

  cpu {
    cores = "1"
  }

  memory {
    dedicated = "2048"
  }

  initialization {
    user_account {
      username = "machine"
      password = "machine"
    }

    ip_config {
      ipv4 {
        address = "10.18.0.32/16"
        gateway = "10.18.0.254"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.MachineOSTest-cloud-config.id
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/CentOS-7-x86_64-GenericCloud.img"
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = "10"
  }

  network_device {
    bridge = "vmbr018"
  }
}