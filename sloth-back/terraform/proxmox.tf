resource "proxmox_vm_qemu" "test" {
    name = "test"
    target_node = "infra"
    iso = "ubuntu-22.04.4-live-server-amd64.iso"
    agent = 1
    memory = 512
    cores = 1
    sockets = 1
    os_type = "cloud-init"
    cpu = "host"
    scsihw = "virtio-scsi-pci"
    bootdisk = "scsi0"
    
    network {
        model = "virtio"
        bridge = "vmbr0"
    }
    
    disk {
        slot = 0
        storage = "local-zfs"
        size = "8G"
        type = "scsi"
        iothread = 1
    }
}