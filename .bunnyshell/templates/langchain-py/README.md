# Langchain Stack with OpenAI/Anthropic and Cloud provider SDK

This template integrates Langchain with OpenAI/Anthropic and various cloud provider SDKs, such as AWS, GCP, Azure, and Vertex. It is designed to streamline the development process for applications requiring natural language processing and cloud services.

## Key Features

- **Langchain Integration**: Utilize Langchain to build sophisticated language models.
- **Multi-Provider SDK Support**: Install and configure one of several cloud provider SDKs (AWS, GCP, Azure, Vertex) to leverage cloud services.
- **AI API Flexibility**: Support for both OpenAI and Anthropic APIs, allowing you to choose the AI provider that best suits your needs.

## Setup Instructions

1. **Select Cloud Provider SDK**:
   - Choose the cloud provider SDK you need (AWS, GCP, Azure, Vertex).
   - Update the environment variables for the selected provider. Remove the variables for other providers if not required to keep the configuration clean and manageable.

2. **Environment Variables**:
   - Set the environment variables specific to the chosen cloud provider. This typically includes credentials and configuration settings necessary for the SDK to function.
   - Define the `AI_API` template variable to indicate whether you are using OpenAI or Anthropic.
   - Set the `API_KEY` environment variable to your API key for the chosen AI provider.

3. **AI Provider Configuration**:
   - The template supports two stages, one for OpenAI and one for Anthropic.
   - Define which stage to target by setting the `AI_API` variable appropriately.
   - Provide the necessary `API_KEY` for either OpenAI or Anthropic based on your selection.

## Example Configuration

Here’s an outline of the environment variables you might need to set:

### For AWS:
- `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.
- `AWS_SESSION_TOKEN` (optional): Your AWS session token if using temporary security credentials.
- `AWS_DEFAULT_REGION`: Your default AWS region.
- `AWS_PROFILE` (optional): The name of a profile in your AWS credentials file.

### For GCP:
- `GOOGLE_APPLICATION_CREDENTIALS`: The file path to your Google Cloud service account key file.
- `GOOGLE_CLOUD_PROJECT`: Your Google Cloud project ID.

### For Azure:
- `AZURE_SUBSCRIPTION_ID`: Your Azure subscription ID.
- `AZURE_CLIENT_ID`: The client (application) ID of your Azure service principal.
- `AZURE_CLIENT_SECRET`: The client secret of your Azure service principal.
- `AZURE_TENANT_ID`: The tenant ID of your Azure Active Directory.

### For Vertex AI Platform:
- `GOOGLE_APPLICATION_CREDENTIALS`: The file path to your Google Cloud service account key file.
- `GOOGLE_CLOUD_PROJECT`: Your Google Cloud project ID.

### For OpenAI:
- `OPENAI_API_KEY`: Your OpenAI API key.

### For Anthropic:
- `ANTHROPIC_API_KEY`: Your Anthropic API key.

## Usage Instructions

1. **Update Environment Variables**:
   - Ensure that you have updated the environment variables in your configuration files or environment management tool.
   - Remove any environment variables that are not relevant to your chosen cloud provider SDK.

2. **Define AI_API and API_KEY**:
   - Set the `AI_API` template variable to either `openai` or `anthropic` depending on which AI provider you are targeting.
   - Set the `API_KEY` environment variable to your API key for the selected AI provider.

This template is designed to be flexible and easy to configure, allowing you to integrate Langchain with various cloud provider SDKs and AI APIs efficiently. By following the setup and usage instructions, you can quickly get your application up and running.
