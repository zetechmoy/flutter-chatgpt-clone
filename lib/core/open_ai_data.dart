const String OPEN_AI_KEY = String.fromEnvironment('OPEN_AI_KEY',
    defaultValue:
        "YOU NEED TO SET YOUR OPEN AI KEY IN THE ENVIRONMENT VARIABLE");
const String authMethod = "Basic"; //Basic or Bearer

const String baseURL = String.fromEnvironment('BASE_URL',
    defaultValue: "https://api.openai.com/v1");

const String kOpenAIModel = "ggml-gpt4all-j-v1.3-groovy";

const String kInitModelSystemMessage =
    "You are ChatGPT, a large language model trained by OpenAI. The user will ask you a question or give you a topic, and you will respond in a human-like way. Respond using complete sentences and try to stay on topic using Markdown.";
