from fastapi import APIRouter, HTTPException

from api.models import AWSInstance, ProxmoxInstance
from api.terraform_utils import *
from api.ansible_utils import *
from api.snmp_utils import *

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

@router.get("/instances")
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


# Configuration part
@router.post("/configure/{host}/{service}")
async def configureHost(host: str, service: str):
    try:
        print("Host : " + host + "\n")
        return run_ansible_playbook(host, service)
    except Exception as e:
        return HTTPException(status_code=400, detail="Failed to configure host : " + e.__str__())

@router.get("/configure")
async def getPlaybooks():
    try:
        return get_ansible_playbooks()
    except Exception as e:
        return HTTPException(status_code=400, detail="Failed to get playbooks : " + e.__str__())


@router.get("/server-info/{server_ip}")
async def get_server_info(server_ip: str):

    print("Hey ! I'm here !")

    server_ip_sanitazed = server_ip.replace("-", ".")

    infos = {}
    oids = {
        'uptime': '1.3.6.1.2.1.1.3.0',  # SysUpTime
        'cpu_load': '1.3.6.1.4.1.2021.10.1.3.1',  # load1
        'total_disk': '1.3.6.1.4.1.2021.9.1.6.1',  # dskTotal
        'available_disk': '1.3.6.1.4.1.2021.9.1.7.1',  # dskAvail
        'memory_total': '1.3.6.1.4.1.2021.4.5.0',  # total memory
        'memory_free': '1.3.6.1.4.1.2021.4.6.0',  # free memory
        'network_in_octets': '1.3.6.1.2.1.2.2.1.10.2',  # ifInOctets for interface index 2
        'network_out_octets': '1.3.6.1.2.1.2.2.1.16.2',  # ifOutOctets for interface index 2
        'system_description': '1.3.6.1.2.1.1.1.0'  # System description
    }

    for key, oid in oids.items():
        try:
            infos[key] = snmp_get(server_ip_sanitazed, oid)
        except HTTPException as e:
            infos[key] = f"Error retrieving {key}: {e.detail}"

    return infos