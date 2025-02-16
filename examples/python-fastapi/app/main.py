from fastapi import FastAPI
from mangum import Mangum
from aws_lambda_powertools import Logger

logger = Logger(service="fast-api-greeter")

app = FastAPI()

@app.get("/")
async def root() -> str:
    logger.info("Hello, world!")
    return "Hello, world!"

@app.post("/events")
async def events() -> str:
    logger.info("Event received!")
    return "Event received!"

handler = Mangum(app)
