from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware


from api.controllers import router as controllers
import uvicorn

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,  # Autoriser les cookies cross-origin
    allow_methods=["*"],  # Autoriser toutes les méthodes
    allow_headers=["*"],  # Autoriser tous les headers
)

# Inclusion des routers de chaque sous-module
app.include_router(controllers, prefix="/sloth")