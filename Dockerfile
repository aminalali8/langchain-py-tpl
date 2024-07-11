# Combined Dockerfile for Langchain, OpenAI, and Anthropic (Python)
FROM python:3.9-slim as base

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

FROM base as dev-sdk

# Add an argument for the SDK to be installed
ARG CLOUD_SDK

# Use a conditional to install the specified CLOUD_SDK
RUN if [ "$CLOUD_SDK" = "aws" ]; then pip install --no-cache-dir boto3; \
    elif [ "$CLOUD_SDK" = "gcp" ]; then pip install --no-cache-dir google-cloud; \
    elif [ "$CLOUD_SDK" = "azure" ]; then pip install --no-cache-dir azure; \
    elif [ "$CLOUD_SDK" = "vertex" ]; then pip install --no-cache-dir google-cloud-aiplatform; \
    else echo "No valid CLOUD_SDK specified, skipping CLOUD_SDK installation"; fi

# OpenAI Stage
FROM dev-sdk as dev-openai

# Copy the application code
COPY ./llm_chain/ .

# Set environment variables based on the selected SDK
ARG API_KEY
ENV OPENAI_API_KEY=$API_KEY
RUN pip install --no-cache-dir langchain-openai; 

# Install Python dependencies
COPY llm_chain/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["python", "server/serve.py"]

# Anthropic Stage
FROM dev-sdk as dev-anthropic

# Copy the application code
COPY ./llm_chain/ .

# Set environment variables based on the selected SDK
ARG API_KEY
ENV ANTHROPIC_API_KEY=$API_KEY
RUN pip install --no-cache-dir langchain-anthropic; 

# Install Python dependencies
COPY llm_chain/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["python", "server/serve.py"]