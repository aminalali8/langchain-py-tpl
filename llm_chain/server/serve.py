import os

from fastapi import FastAPI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_openai import ChatOpenAI
from langserve import add_routes

# Accessing the OPENAI_API_KEY environment variable
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

if not OPENAI_API_KEY:
    raise ValueError("OPENAI_API_KEY environment variable is not set")
else :
    print("OPENAI_API_KEY: ", OPENAI_API_KEY)

# Define the chain
system_template = "Translate the following into {language}:"
prompt_template = ChatPromptTemplate.from_messages([('system', system_template), ('user', '{text}')])
model = ChatOpenAI()
parser = StrOutputParser()
chain = prompt_template | model | parser

# Define the app
app = FastAPI(title="LangChain Server", version="1.0", description="A simple API server using LangChain's Runnable interfaces")
add_routes(app, chain, path="/chain")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
