# FROM python:3.12-slim-bookworm

# WORKDIR /app

# # Copy only requirements.txt first to leverage Docker cache on dependencies
# COPY requirements.txt .

# # Install dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy your Flask app source code
# COPY hello_world.py .

# # Expose port 8080 (the port Flask app runs on)
# EXPOSE 8080

# # Run the Flask app with the correct command
# CMD ["python", "hello_world.py"]
# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY hello_world.py .
# Install Flask
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8080 for the Flask app
EXPOSE 8080

# Run the application
CMD ["python", "hello_world.py"]
