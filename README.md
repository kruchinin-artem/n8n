# AI-Enhanced n8n Orchestration

> Автоматизация с использованием n8n и локальных языковых моделей через Ollama.

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
# git clone по SSH
# git clone git@github.com:kruchinin-artem/n8n.git
cd n8n
make start
```

Это выполнит:
1. Запуск базы данных PostgreSQL и Redis
2. Запуск core-сервисов n8n + pgAdmin
3. Поднятие Ollama с моделями:
   - llama3
   - mistral
   - gemma
   - codellama
   - phi
   - orca-mini
   - dolphin-mixtral
4. Загрузка моделей при первом запуске
5. n8n будет доступен по адресу: [http://localhost:5678](http://localhost:5678)

---

## 📁 Структура проекта

```text
.
├── docs/               # Документация
├── models/             # Скачанные модели Ollama
├── pgadmin/            # Настройки pgAdmin
├── data/               # Выходные файлы от n8n
├── docker-compose.yml  # Основные сервисы
├── docker-compose-ai.yml  # AI модели (Ollama)
├── Makefile            # Скрипт запуска
├── .env                # Переменные окружения
└── README.md           # Текущая документация
```

---

## 🧠 n8n Workflows

Workflow-редактор доступен по адресу: [http://localhost:5678](http://localhost:5678)

### Примеры:
- Одновременный запрос к 3+ LLM
- Выбор лучшего ответа с помощью LLM
- Сохранение результата в `.txt` файл (`/data/output.txt`)

---

## ✨ Поддерживаемые модели

Используется [Ollama](https://ollama.com/library):

- `llama3`
- `mistral:7b-instruct`
- `codellama`
- `gemma`
- `phi`
- `orca-mini`
- `dolphin-mixtral`

---

## 📄 Лицензия

MIT — свободно для личного и коммерческого использования.

---

_Обновлено: 2025-05-21_