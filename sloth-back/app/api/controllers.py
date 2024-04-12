from fastapi import APIRouter, HTTPException

from api.models import AWSInstance, ProxmoxInstance, Instance
from api.terraform_utils import *

router = APIRouter()

@router.get("/")
async def root():
    return {"message": "Welcome on Sloth Infrastructure API that allows you to create and manage instances for your business !"}

@router.post("/instances/aws/")
async def createAWSInstance(instance: AWSInstance):
    provider_name = 'aws'
    print("Provider : " + provider_name + "\n")
    aws_instance = instance.dict()
    print("\tDétails de l'instance : \n" + aws_instance.__str__() + "\n")
    try:
        return createInfrastructure(provider=provider_name,instance_details=aws_instance)
    except Exception as e:
        return HTTPException(status_code=400, detail="Failed to create AWS instance : " + e.__str__() + "\n")

@router.post("/instances/proxmox")
async def createProxmoxInstance(instance: ProxmoxInstance):
    provider_name = 'Proxmox'
    print("Provider : " + provider_name + "\n")
    proxmox_instance = instance.dict()
    print("\tDétails de l'instance : \n" + proxmox_instance.__str__() + "\n")

    try:
        return createInfrastructure(provider=provider_name, instance_details=proxmox_instance)
    except Exception as e:
        print(e)
        return HTTPException(status_code=400, detail="Failed to create Proxmox instance : " + e.__str__() + "\n")

@router.get("/instances/")
async def getInstances():
    try:
        return getInfrastructure()
    except Exception as e:
        return HTTPException(status_code=400, detail="Failed to get instances : " + e.__str__())

@router.delete("/instances/{instance_type}/{resource_name}")
async def deleteInstance(instance_type: str, resource_name: str):
    try:
        return destroyInfrastructure(provider=instance_type, resource_name=resource_name)
    except Exception as e:
        return HTTPException(status_code=400, detail="Failed to delete instance : " + e.__str__() )

