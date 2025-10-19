# Use a slim Python base image
FROM python:3.11-slim

# Prevents Python from writing .pyc files and buffers
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set workdir
WORKDIR /app

# Install system deps
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY app /app/app

# Expose port (default 5000) and run with dynamic port
ENV PORT=5000
EXPOSE ${PORT}
CMD ["/bin/sh", "-c", "gunicorn -w 2 -b 0.0.0.0:${PORT} app.app:app"]
