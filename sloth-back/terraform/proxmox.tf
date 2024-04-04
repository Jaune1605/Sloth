resource "proxmox_vm_qemu" "test-debian-11" {
  count = 1
  name = "test-debian-22"
  target_node = "infra"
  clone = "debian11-temp"

  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

    ssh_user = "user"
    cipassword = "password"

  disk {
    slot = 0
    size = "2G"
    type = "scsi"
    storage = "sloth-vms"
    iothread = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }
}