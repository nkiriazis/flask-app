FROM python:3.12-slim-bookworm

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY hello_world.py .

EXPOSE 8080

CMD ["python", "hello_world.py"]
