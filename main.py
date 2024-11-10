# -------------------------------------------------------------
# Import
# -------------------------------------------------------------
import uvicorn
from fastapi import FastAPI, HTTPException, Request
from fastapi.staticfiles import StaticFiles

# -------------------------------------------------------------
# FastAPI
# -------------------------------------------------------------
app = FastAPI()

# 静的コンテンツの配置先
app.mount("/app", StaticFiles(directory="app", html=True), name="app")

@ app.get("/api")
def root():
    return {"Hello": "World"}