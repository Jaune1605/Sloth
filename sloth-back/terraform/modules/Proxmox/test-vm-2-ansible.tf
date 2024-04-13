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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+CAzBSCdf58it+8MNtNJbg1BmTx5o8T1Yei8qpmtf0eo6+manEzZFy2jB7+FsYaljlgSlSFD80Hb8YKJ6RjcV/43ZTkIdwy1SKkSkyA4RgvIFxnpu8rpsGKjSQX7QNJ2/WyiGVvK93to6/dpXNpaepzX7Je5dunOKLBy3hPGzR0w0qv5DZrWNWnRBpzr/dphUSfxdn2lmwZcOF7G2lEl/fUDuqGadQYq2gjOBkHn4nnzar4zpoJRWKXkQbxrSW5j8Usub/U7tYlp83GZInAid5sWxXeJDpCiv/HNXnCB4+Wur/SCV+T1JqEF1vDM/OjnmfoRoUEnIRYGdctGxqdIiTiSL0ZeeKgVNS/FSPOFRl/HfW/SWO0iDk/IKBFBz+QiJN3OBk9sIZ7oEEHBN+N86f6MJJOUSzdIq/TY2XAXdv1m8V5AvQBlmgNj0nt16Kq7PQ+e5vCwThIY9/PngNZVLx29kzItJjaozT44vfTZrllb+RIFy3V+blIfY1iBcEFT4wWz69fsPtdgMePBqCt86L4ugzYH9s0TPIgUyRDc1QTkdqyLNE9H56iBY5cNXE82osVpIOVcNK5gBaz0KFQ4HG9ehRD/ainQSAE50GCMYOpcagiwwNPVbdOKVGQTYrmATRdaMW6D3UdmIa3FXDdt86fbxEx9CF+HSiUNhHHtsQQ== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: true
runcmd:
  - [ echo, "", ">" , "/etc/apt/sources.list" ]
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