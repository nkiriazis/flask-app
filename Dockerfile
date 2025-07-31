FROM python:3.12-slim-bookworm

WORKDIR /app

# Copy only requirements.txt first to leverage Docker cache on dependencies
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy your Flask app source code
COPY hello_world.py .

# Expose port 8080 (the port Flask app runs on)
EXPOSE 8080

# Run the Flask app with the correct command
CMD ["python", "hello_world.py"]
