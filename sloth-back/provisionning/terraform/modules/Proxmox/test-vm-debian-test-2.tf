resource "proxmox_virtual_environment_file" "test-vm-debian-test-2-cloud-config" {
  content_type = "snippets"
  datastore_id = "snippets"
  node_name    = "infra"

  source_raw {
    data = <<EOF
#cloud-config
hostname: test-vm-debian-test-2
users:
  - default
  - name: guillaume
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDzPLJ9vqmHBb2FcE7NPPNpr4lpB2p3Vq0BCsW7q5KRJVyGy+/Ap6q2ovdXLwXxsvNlzxN2YRTuhLrIC0bImbMc4ZxW8GJFdEmY/1mUWh6qbcskxRbbFUy7KsUcWp1vEcV0nSMkOsjNUpSeOmy0fTtUShuFYKaAI49FG3tjwrG9MzJDDOPu0aZa+Aq4AI5Vjd3AuB98ANx99C9lnQcDZCieNuaBMBfaCnJfKfLoxXUDWEzmKPZdICYBGfx77e5zqgcXig+w1Uyv/disl2YvLU+Ry5/ReQADrePY+Ae3cpMzEFJ4uwmnHIe0Z5JShHpZy5CzNx2veTniYDEbJKHn9PSlqqWV/oRJYBc8umf+6S77HrzSpw1Aes3HILcAMVWQ2DSoUKc6S7BMkMNY3rwSUYCdLQ9OwTsv/IqBIVmW4AKxlt+AizoNb//JANr0oR0rGiRb3GeCM+MFMSgusFq5YxLAexHV/b0SW9CoFHtntjGvQfr84L9h1PkWvOBuM4s3VXhq5UXUXVwGvVI1BBZeuEu43/w1eZnEJ9Uk3jOHYXh5GS+eXk531uYS5HxrkvS3YhZSHQjRUe8ZlsG1XoGQCpEVihOHtcKfVX/MkfzCScFoMQxWPc62Rfo8LKqBOpAz9mu0WH0XgRKmc64yysVHlCf90hdTh2B+3KV14OGnGcr0vQ== guillaume@Laptop-Guillaume

chpasswd:
  list: |
    guillaume:password
    root:password
  expire: False
ssh_pwauth: true
runcmd:
  - echo "This server is automatically provisioned by Sloth" > /etc/motd
EOF

    file_name = "test-vm-debian-test-2-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "test-vm-debian-test-2" {
  name      = "test-vm-debian-test-2"
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
        address = "10.18.0.12/16"
        gateway = "10.18.0.254"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.test-vm-debian-test-2-cloud-config.id
  }

  disk {
    datastore_id = "sloth-vms"
    file_id      = "local:iso/debian-12-genericcloud-amd64.img"
    interface    = "virtio0"
    iothread     = "true"
    discard      = "on"
    size         = "20"
  }

  network_device {
    bridge = "vmbr018"
  }
}