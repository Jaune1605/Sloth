from fastapi import FastAPI, HTTPException

from app.controllers import router as controllers
import uvicorn


if __name__ == "__main__":
    app = FastAPI()
    # Inclusion des routers de chaque sous-module
    app.include_router(controllers, prefix="/sloth")

    uvicorn.run(app, host="localhost", port=8000)