FROM python:3.9-slim

WORKDIR /app/backend

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        default-libmysqlclient-dev \
        pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first for better layer caching
COPY requirements.txt .

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
