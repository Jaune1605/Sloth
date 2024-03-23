from fastapi import APIRouter, HTTPException

from app.models import AWSInstance
from app.terraform_utils import *

router = APIRouter()

@router.post("/instances/")
async def create_instance(instance: AWSInstance):
    instance_details = instance.dict()
    print("Détails de l'instance : \n" + instance_details.__str__())
    try:
        return createInfrastructure(instance_details)
    except Exception as e:
        return HTTPException(status_code=400, detail="Failed to create instance : " + e.__str__())


@router.get("/instances/")
async def getInstances():
    try:
        return getInfrastructure()
    except Exception as e:
        return HTTPException(status_code=400, detail="Failed to get instances : " + e.__str__())

@router.delete("/instances/")
async def deleteInstance():
    try:
        return destroyInfrastructure()
    except Exception as e:
        return HTTPException(status_code=400, detail="Failed to delete instance : " + e.__str__() )

