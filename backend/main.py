from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import openai
import os
from dotenv import load_dotenv

load_dotenv()

openai.api_key = os.getenv("OPENAI_API_KEY")

app = FastAPI()

# Allow requests from Flutter frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Or restrict to Flutter IP
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class ChatRequest(BaseModel):
    message: str
    language: str

@app.post("/chat")
async def chat(request: ChatRequest):
    prompt = f"[{request.language.upper()} USER]: {request.message}\n[AI]:"
    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": f"You are a multilingual airport assistant."},
            {"role": "user", "content": prompt}
        ]
    )
    reply = response.choices[0].message.content.strip()
    return {"reply": reply}
