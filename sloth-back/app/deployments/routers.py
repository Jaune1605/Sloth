from fastapi import APIRouter
from deployments.manage_servers import *

router = APIRouter()

#TO DO : Sanitize server_spec and server_type
@router.post("/plan/{server_type}")
async def preview_server_deployment(server_type: str, server_spec: dict) -> dict:

    plan_message = plan_deployments(server_type, server_spec)

    return {"plan_message": plan_message}

@router.post("/deploy/{server_type}")
async def create_server(server_type: str, server_spec: dict) -> dict:

    deploy_message = deploy_server()

    return {"build_message": deploy_message}

@router.delete("/destroy/{server_name}")
async def destroy_server(server_name: str) -> dict:

    destroy_server(server_name)

    return {"destroy_message": "Server destroyed successfully"}

@router.get("/all")
async def get_all_state() -> dict :
    state_infra = get_infra_state()
    return state_infra
