
resource "proxmox_virtual_environment_vm" "example-proxmox-vm" {
  name      = "example-proxmox-vm"
  node_name = "infra"

  initialization {
    user_account {
      username = "user"
      password = "password"
    }
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/ubuntu-22.10-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = "20"
  }
}