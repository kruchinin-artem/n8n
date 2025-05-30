
# AI Models Integration Guide

## 🚀 Запуск моделей

```bash
# Запуск всех сервисов (n8n + AI)
make start
```

---

## 🤖 Модели и API-эндпоинты

### 🧠 Ollama (Mistral)

- **Порт**: `11434`  
- **Модель**: `mistral:7b-instruct-q4_0`

#### 🔹 Пример запроса (PowerShell)

```powershell
# 1. Сформировать JSON и закодировать в UTF-8
$body = @{
  model = "llama3"
  prompt = "О чем шумят деревья? ответь на русском"
  stream = $false
} | ConvertTo-Json -Depth 3 -Compress

# 2. Отправить запрос с правильной кодировкой
$response = Invoke-RestMethod -Uri "http://localhost:11434/api/generate" `
  -Method Post `
  -Body ([System.Text.Encoding]::UTF8.GetBytes($body)) `
  -ContentType "application/json"

# 3. Вывести результат
$response.response

```

---

### 🧠 DeepSeek (HuggingFace)

- **Порт**: `5000`  
- **Модель**: `deepseek-ai/deepseek-llm-7b-chat`

#### 🔹 Пример запроса (PowerShell)

```powershell
# 1. Сформировать JSON и закодировать в UTF-8
$body = @{
  text = "Объясни квантовую запутанность простыми словами"
  max_tokens = 150
} | ConvertTo-Json -Depth 3 -Compress

# 2. Отправить запрос на DeepSeek
$response = Invoke-RestMethod -Uri "http://localhost:5000/generate" `
  -Method Post `
  -Body ([System.Text.Encoding]::UTF8.GetBytes($body)) `
  -ContentType "application/json"

# 3. Показать результат
$response.response
```

#### 🔸 Интеграция с n8n
**Ollama (Mistral)**

- **Метод**: `POST`  
- **URL**: `http://ollama:11434/api/generate`  
- **Headers**: `Content-Type: application/json`  
- **Пример тела запроса**:

```json
{
  "model": "mistral:7b-instruct-q4_0",
  "prompt": "Translate this text into French"
}
```

**DeepSeek (HuggingFace)**

- **Метод**: `POST`  
- **URL**: `http://deepseek-api:5000/generate`  
- **Headers**: `Content-Type: application/json`  
- **Пример тела запроса**:

```json
{
  "text": "Что такое машинное обучение?",
  "max_tokens": 100
}
```


---

## 🧩 Пример workflow в n8n

1. Получить вопрос через Webhook  
2. Отправить запрос в Ollama  
3. (Опционально) Обработать альтернативно через другую модель (например, LocalAI)  
4. Записать результат в Google Sheets или отправить пользователю

__Для тестовго примера, выполнить импорт файла__
```
test_workflow.json
```
