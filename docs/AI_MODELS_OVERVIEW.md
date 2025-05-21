
# 📚 AI Models Overview for n8n + Ollama

Этот документ описывает модели, которые можно запускать через Ollama в Docker и использовать в автоматизации через n8n.

---

## ✅ Поддерживаемые модели и их назначение

| Модель             | Назначение                          | Команда pull            | Подходит для |
|--------------------|--------------------------------------|--------------------------|--------------|
| `mistral`          | Общие задачи, чат, анализ            | `ollama pull mistral`   | Повседневные задачи |
| `llama2`           | Инструкции, диалог                   | `ollama pull llama2`    | Продвинутый чат |
| `llama3`           | Улучшенная версия LLaMA             | `ollama pull llama3`    | Чат, творчество |
| `gemma`            | Модель от Google                    | `ollama pull gemma`     | Научный и tech контент |
| `codellama`        | Генерация и понимание кода          | `ollama pull codellama` | Программирование |
| `phi`              | Маленькая и быстрая LLM             | `ollama pull phi`       | Экономия ресурсов |
| `orca-mini`        | Лёгкая, для кратких диалогов         | `ollama pull orca-mini` | Инструкции и ответы |
| `dolphin-mixtral`  | Микс Mistral + Dolphin              | `ollama pull dolphin-mixtral` | Высокое качество, требует много RAM/VRAM |

---

## 🔄 Пример API-запроса для n8n

```json
{
  "model": "llama3",
  "prompt": "Translate the following into Spanish: Hello, how are you?",
  "stream": false
}
```

- **Метод**: POST
- **URL**: `http://ollama:11434/api/generate`
- **Headers**:
  - `Content-Type: application/json`

---

## ⚙️ Параллельное выполнение в n8n

Можно использовать **ноду "SplitInBatches" + параллельные HTTP-запросы**:
1. Запрос делится на несколько моделей (массив `["mistral", "llama3", "codellama"]`)
2. Запускается **HTTP Request Node** на каждую модель
3. Используется `Wait` + `Merge` для сбора результатов
4. Последующий `IF` или `Code` node выбирает лучший результат (например, по длине, содержанию или скорингу)

Дополнительные контейнеры не требуются — Ollama может обрабатывать несколько запросов одновременно, **но они будут в очереди**. Параллелизм зависит от числа потоков CPU и доступной RAM/VRAM.

---

## 🧠 Поддержка DeepSeek

Модель DeepSeek можно запустить **вручную**, используя:
- HuggingFace модель (например, `deepseek-ai/deepseek-llm-7b-chat`)
- Обёртки: `transformers`, `text-generation-webui`, `llama.cpp` (после конвертации в GGUF)
- Пока **Ollama не поддерживает DeepSeek** напрямую

Для запуска DeepSeek локально:
- Установи `transformers`
- Используй пример скрипта из их `README.md`
