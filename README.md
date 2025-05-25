# AI-Enhanced n8n Orchestration

> Автоматизация с использованием n8n и локальных языковых моделей через Ollama + DeepSeek.

---

## 📦 Требования

- Docker + Docker Compose
- Git
- Windows (PowerShell) или Linux/macOS
- Минимум 16 GB RAM
- Доступный GPU (опционально, ускоряет модели)
- 50 GB места на диске

---

## 🚀 Запуск проекта

```bash
git clone https://github.com/kruchinin-artem/n8n.git
# или по SSH
# git clone git@github.com:kruchinin-artem/n8n.git
cd n8n
make start
```

Это выполнит:
1. Запуск баз данных: PostgreSQL, Redis, MongoDB
2. Запуск core-сервисов n8n + pgAdmin + Mongo Express
3. Поднятие Ollama и DeepSeek моделей:
   - Ollama:
     - llama3
     - mistral
     - gemma
     - codellama
     - phi
     - orca-mini
     - dolphin-mixtral
   - DeepSeek (через HuggingFace):
     - deepseek-ai/deepseek-llm-7b-chat
4. Загрузка моделей при первом запуске
5. Доступ к сервисам:

| Сервис        | URL                      |
|---------------|---------------------------|
| n8n           | http://localhost:5678     |
| DeepSeek API  | http://localhost:5000     |
| pgAdmin       | http://localhost:8080     |
| Mongo Express | http://localhost:8081     |

---

## 📁 Структура проекта

```text
.
├── docs/                  # Документация
├── models/                # Скачанные модели Ollama
├── pgadmin/               # Настройки pgAdmin
├── data/                  # Выходные файлы от n8n
├── docker-compose.yml     # Основные сервисы
├── docker-compose-ai.yml  # AI модели (Ollama, DeepSeek)
├── Makefile               # Скрипт запуска
├── .env                   # Переменные окружения
└── README.md              # Текущая документация
```

---

## 🧠 n8n Workflows

Workflow-редактор доступен по адресу: [http://localhost:5678](http://localhost:5678)

### Примеры:
- Одновременный запрос к нескольким LLM
- Сравнение и выбор лучшего ответа
- Сохранение результата в `.txt` файл (`/data/output.txt`)
- Сохранение истории чатов в MongoDB

---

## ✨ Поддерживаемые модели

Через [Ollama](https://ollama.com/library):

- `llama3`
- `mistral:7b-instruct`
- `codellama`
- `gemma`
- `phi`
- `orca-mini`
- `dolphin-mixtral`

Через HuggingFace:

- `deepseek-ai/deepseek-llm-7b-chat`

---

## 🗃️ Базы данных

### PostgreSQL (служебная и пользовательская)

- Основная БД используется n8n
- Вторая БД — для пользователей, логов и статистики (например, таблицы users, activity_logs)

Доступ через **pgAdmin**:
- URL: [http://localhost:8080](http://localhost:8080)
- Email: `admin@example.com`
- Пароль: `admin123`

### MongoDB (чаты и истории)

- Хранение истории запросов/ответов по пользователю
- Использует коллекции: `chats`, `messages` и т.д.

Доступ через **Mongo Express**:
- URL: [http://localhost:8081](http://localhost:8081)
- Логин: `admin`
- Пароль: `admin`

---

## 📄 Лицензия

MIT — свободно для личного и коммерческого использования.

---

_Обновлено: 2025-05-25_
