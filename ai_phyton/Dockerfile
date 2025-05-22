# Используем официальный образ PyTorch с поддержкой CUDA
FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Копируем requirements.txt
COPY requirements.txt /app/
COPY main.py /app/
WORKDIR /app

# Устанавливаем Python-зависимости
RUN pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -r requirements.txt

# Создаем директорию для кэша моделей
RUN mkdir -p /root/.cache/huggingface/hub