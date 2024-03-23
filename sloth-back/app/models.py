from pydantic import BaseModel

class AWSInstance(BaseModel):
    name: str = "example-instance"
    type: str = "t2.micro"
    ami: str = "ami-00c71bd4d220aa22a"
    region: str = "eu-west-3"

class ProxmoxInstance(BaseModel):
    name: str = "example-instance"
    type: str = "t2.micro"
    ami: str = "ami-00c71bd4d220aa22a"
    region: str = "eu-west-3"

class GCPInstance(BaseModel):
    name: str = "example-instance"
    type: str = "t2.micro"
    ami: str = "ami-00c71bd4d220aa22a"
    region: str = "eu-west-3"

