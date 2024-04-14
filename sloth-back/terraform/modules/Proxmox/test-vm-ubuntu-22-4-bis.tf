resource "proxmox_virtual_environment_file" "test-vm-ubuntu-22-4-bis-cloud-config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name    = "infra"

  source_raw {
    data = <<EOF
#cloud-config
hostname: test-vm-ubuntu-22-4-bis
users:
  - default
  - name: guillaume
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQClszNe2qBkO8/8/5Dyl9iJTarqt55qZiYhfEzXv62DtYAYCA/B+3+i8Dc0oGE/EOskOhk0REvaky78ZEnsDkmGc9Hh+k348o/cSVLNMB4YS6x2ZNNE7hydZsufDPCq2W1m27c6AGCsw9UwKmEjMj56YGWUpXZqRxlK904c3NW7OavLDqpHy2pZqey1FL1BnDu8/YQA+95ferWiVB4NVKnauz0cOfV4QnK1ef7nHvcDcLkDEtBq9Ci14H7q71X8PufrxgtJpR+tSRh11qOIOo3cK5m/0YxidouPgaK+sWf3qAxJq9/YXm0iZSQeUMKCJWTqk4As87Qt7zuvkBI31oCxKtJSDTrTNeAgUrS60GQcwjcNAF7eZyuTJvRnpP/tmHl+Y48PbJHE+AROWIae/T6dW2/XHjqRjqn9wdM2DPnjsBPdu7ryUmImi/6GHOH71xCS9It83Bk7s2kVdC23Bfj6NKUjbXc+lqovVa96IhuhMwZwW5A4BP9GCM2VRtpnP2kVc3I3MnlB7E0ooQnl1hs7seHo6BT7gmFxnkwU3tYotnnuFN3xHVRGfZol0rR4X1FJdCSiG0qtX+lvT2v3aSHoddNIuym7IF1mEmQLPeXqD4MRC90G9KymQ1HpzHgAvDR817AxwQ8Hl2xC9eGCm3ljZk6LCTASfYqDqMrPqOTi5w== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: true
runcmd:
  - echo "This server is automatically provisioned by Sloth" > /etc/motd
EOF

    file_name = "test-vm-ubuntu-22-4-bis-cloud-config.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "test-vm-ubuntu-22-4-bis" {
  name      = "test-vm-ubuntu-22-4-bis"
  node_name = "infra"

  cpu {
    cores = "2"
  }

  memory {
    dedicated = "2048"
  }

  initialization {
    user_account {
      username = "guillaume"
      password = "password"
    }

    ip_config {
      ipv4 {
        address = "10.18.0.212/16"
        gateway = "10.18.0.254"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.test-vm-ubuntu-22-4-bis-cloud-config.id
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/ubuntu-22.04-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = "30"
  }

  network_device {
    bridge = "vmbr018"
  }
}