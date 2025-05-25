start:
	@echo "Ensuring local folders exist with correct permissions..."
	@if not exist data mkdir data
	@if not exist models mkdir models

	@echo "Fixing permissions inside ./data..."
	@powershell -Command "icacls data /grant Everyone:F" || echo "Permission fix skipped (non-Windows)"

	@echo "Starting database services..."
	docker compose up -d postgres redis app-postgres mongo
	@powershell -Command "Start-Sleep -Seconds 10"

	@echo "Starting n8n core services..."
	docker compose up -d n8n worker pgadmin mongo-express

	@echo "Starting AI models..."
	docker compose -f docker-compose-ai.yml up -d
	@powershell -Command "Start-Sleep -Seconds 15"

	@echo "Downloading Ollama models..."
	docker exec ollama ollama pull mistral:7b-instruct-q4_0
	docker exec ollama ollama pull llama3
	docker exec ollama ollama pull codellama
	docker exec ollama ollama pull gemma
	docker exec ollama ollama pull phi
	docker exec ollama ollama pull orca-mini
	docker exec ollama ollama pull dolphin-mixtral

	@echo "All systems ready!"
	@echo "n8n: http://localhost:5678"
	@echo "pgAdmin: http://localhost:8080"
	@echo "Mongo Express: http://localhost:8081"




build:
	docker-compose -f docker-compose.yml build
	docker-compose -f docker-compose-ai.yml build
