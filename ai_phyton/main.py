import os
import torch
from fastapi import FastAPI
from pydantic import BaseModel
from transformers import AutoTokenizer, AutoModelForCausalLM, pipeline

app = FastAPI()

# Загрузка модели при старте
model_name = os.getenv("DEEPSEEK_MODEL_NAME", "deepseek-ai/deepseek-llm-7b-chat")
load_in_4bit = os.getenv("DEEPSEEK_USE_4BIT", "True") == "True"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(
    model_name,
    device_map="auto",
    load_in_4bit=True,
    offload_folder="offload",  # Выгрузка части модели на CPU
    torch_dtype=torch.float16  # Использование float16 вместо bfloat16
)

class Request(BaseModel):
    text: str
    max_tokens: int = 100

@app.post("/generate")
async def generate(request: Request):
    generator = pipeline(
        "text-generation",
        model=model,
        tokenizer=tokenizer,
    )
    
    result = generator(
        request.text,
        max_new_tokens=request.max_tokens,
        temperature=0.7
    )
    
    return {"response": result[0]["generated_text"]}

@app.get("/health")
async def health():
    return {"status": "ready"}
