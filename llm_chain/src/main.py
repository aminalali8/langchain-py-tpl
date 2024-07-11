import os

from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_openai import ChatOpenAI

# Accessing the OPENAI_API_KEY environment variable
OPENAI_API_KEY = os.environ.get("OPENAI_API_KEY")

# Prompt template
system_template = "Translate the following into {language}:"
prompt_template = ChatPromptTemplate.from_messages([('system', system_template), ('user', '{text}')])

# Model
model = ChatOpenAI(openai_api_key=OPENAI_API_KEY )

# Output parser
parser = StrOutputParser()

# Chain components
chain = prompt_template | model | parser

# Example invocation
result = chain.invoke({"language": "italian", "text": "hi"})
print(result)
