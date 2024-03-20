from fastapi import FastAPI
from deployments.routers import router as deployment_router

app = FastAPI()

# Inclusion des routers de chaque sous-module
app.include_router(deployment_router, prefix="/deployment")
