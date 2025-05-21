.PHONY: start

start:
	docker compose up -d postgres redis
	@echo "Waiting Postgres | Waiting Redis..."
	@powershell -Command "Start-Sleep -Seconds 10"
	docker compose up -d n8n worker pgadmin
