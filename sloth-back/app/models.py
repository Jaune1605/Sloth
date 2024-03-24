from pydantic import BaseModel

class AWSInstance(BaseModel):
    """
    Modèle (MINIMAL) pour créer une instance AWS
    """
    name: str = "example-aws-instance"
    type: str = "t2.micro"
    ami: str = "ami-00c71bd4d220aa22a"
    region: str = "eu-west-3"

class ProxmoxInstance(BaseModel):
    name : str = "example-proxmox-vm"
    node_name : str = "infra"
    username : str = "user"
    password : str = "password"
    datastore_id : str = "local-lvm"
    file_id : str = "local:iso/ubuntu-22.10-server-cloudimg-amd64.img"
    interface : str = "virtio0"
    iothread : str = "true"
    discard : str = "on"
    size : str = "20"

class Instance(BaseModel):
    provider: str
    details: dict


