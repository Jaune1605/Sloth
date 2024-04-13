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
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFJnrgvLssBA81tqwvdOZmimnYz4nyumwDAFVLL3GeFAl9uyIrQqbH5DHNsqeywVuwYYN1S82k7ZRgUTglyd55oKAJy5xt4J4FbibEDJO9KHPmMJQ27o48yRUk9sOScO4ovQNHevGholnAypLemFedjJN2dwWlgShOPSWn6dFsy7DiFyTo1KU6oyzog2qeSmvWb9sOeQug+fpa3R1Mvh3qc4tvfU7F/SSOeCqANhiTwMhoVr5b9EtGEb7F6pFFTpKri3pJb9k58l5jsbDr8+X66n7BqPjcJzulbkubAf5vh7gE1kIT20WwV7fOOevdOCYH4P7I4qQELKR2a16snw92tWrzVje4EO3eWUmOTZRVvpBmAatTDBf3Zl84x4fejJG/uvjGfG1HgnC0/7OfdgtYDMBxlBuZjCV0HGTPnW/tYth+cCMY11PaD1jSQk+6Yh4SP9GOYf4ySyNZ7nlZQdRSH8/zq8cwbxXYBh3yKjwXXCSHtMzoBPwhJcJIPnc8CNa0KPIfrceMGvE0igqauiE84NaN9udHvslIWhhaUwDmZ001DoiWQLhBkPlq5yN5JCxi07YEZ8n4odoapFo+VRR5JQNvFRC4Ec6N7G5DSg1sZdUr/no5beZZSH17y3W1oS4xvEmg76L4Co1hc511g9v0sSoJJZQK7bsV8hskwQ36qw== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: Tru
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