resource "proxmox_vm_qemu" "test-vm" {
    name = "terraform-vm"
    desc = "VM created by Terraform"
    target_node = "infra"
    clone = "ubuntu-22-10-template"
    full_clone = "true"
    agent = 1
    os_type = "cloud-init"
    cores = 2
    sockets = 1
    cpu = "host"
    memory = 2048
    
    disk {
        type = "scsi"
        size = "10G"
        storage = "sloth-vms"
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
        tag = "18"
    }


}