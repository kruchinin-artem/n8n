start:
	@echo "Creating models directory if not exists..."
	@if not exist models mkdir models
	@if not exist data mkdir data
	
	@echo "Starting database services..."
	docker compose up -d postgres redis
	@powershell -Command "Start-Sleep -Seconds 10"
	
	@echo "Starting n8n core services..."
	docker compose up -d n8n worker pgadmin
	
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
	@echo "Ollama: http://localhost:11434"
	@echo "DeepSeek:  http://localhost:5000"



build:
	docker-compose -f docker-compose.yml build
	docker-compose -f docker-compose-ai.yml build
