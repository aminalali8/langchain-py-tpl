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
ARG SDK

# Use a conditional to install the specified SDK
RUN if [ "$SDK" = "aws" ]; then pip install --no-cache-dir boto3; \
    elif [ "$SDK" = "gcp" ]; then pip install --no-cache-dir google-cloud; \
    elif [ "$SDK" = "azure" ]; then pip install --no-cache-dir azure; \
    elif [ "$SDK" = "vertex" ]; then pip install --no-cache-dir google-cloud-aiplatform; \
    else echo "No valid SDK specified, skipping SDK installation"; fi

FROM dev-sdk as dev

# Copy the application code
COPY ./llm_chain/ .

# Set environment variables based on the selected SDK
ARG AI
ARG API_KEY

RUN if [ "${AI}" = "openai" ]; then \
    echo "OPENAI_API_KEY=${API_KEY}" >> .env; \
    pip install --no-cache-dir langchain-openai; \
    elif [ "${AI}" = "anthropic" ]; then \
    echo "ANTHROPIC_API_KEY=${API_KEY}" >> .env; \
    pip install --no-cache-dir langchain-anthropic; \
    fi

# Install Python dependencies
COPY llm_chain/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["python", "server/serve.py"]