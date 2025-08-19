Com certeza. O README que você tem é funcional, o que é um ótimo começo. Para torná-lo "melhor", vamos transformá-lo em uma vitrine profissional para o seu projeto. Um README excelente não apenas explica como usar o código, mas também vende o projeto, demonstra seu raciocínio e destaca as habilidades que você aplicou.

A versão a seguir foi reestruturada para ser mais visualmente atraente, mais fácil de ler e mais impactante para quem visita seu repositório, como recrutadores ou outros desenvolvedores.

-----

# 🤖 Serviço de Predição de Churn de Clientes

## 🎯 Sobre o Projeto

A retenção de clientes é um dos pilares para o sucesso de qualquer empresa de serviços. Perder clientes (churn) não apenas resulta em perda de receita, mas também acarreta custos para adquirir novos.

Este projeto aborda esse desafio de negócio criando um serviço de ponta a ponta que prevê a probabilidade de um cliente de uma empresa de telecomunicações cancelar seu contrato. Utilizando um modelo de **Regressão Logística**, o serviço analisa os dados do cliente e retorna uma pontuação de risco de churn, permitindo que a empresa tome ações proativas para reter clientes valiosos.

O diferencial deste projeto é o foco na **operacionalização (MLOps)**: o modelo não vive apenas em um notebook, ele é encapsulado em um **serviço web via Flask** e **conteinerizado com Docker**, pronto para ser implantado em um ambiente de produção.

## ✨ Principais Funcionalidades

  - **Análise Exploratória de Dados (EDA):** Investigação aprofundada dos dados para identificar os principais fatores que influenciam o churn.
  - **Engenharia de Features:** Pré-processamento e transformação de variáveis categóricas para uso no modelo.
  - **Treinamento e Validação de Modelo:** Construção e avaliação de um modelo de Regressão Logística com Scikit-learn, utilizando métricas como AUC-ROC.
  - [cite\_start]**Serialização do Modelo:** Salvando o modelo treinado e o vetorizador de features com `pickle` para uso em produção[cite: 5].
  - [cite\_start]**Serviço Web (API):** Desenvolvimento de uma API REST com Flask que recebe dados do cliente em JSON e retorna a probabilidade de churn[cite: 5].
  - [cite\_start]**Conteinerização:** Criação de uma imagem Docker para encapsular o serviço, suas dependências e o modelo, garantindo portabilidade e reprodutibilidade[cite: 5].

## 🛠️ Tecnologias Utilizadas

O projeto foi construído utilizando as seguintes tecnologias:

  - **Linguagem:** Python
  - **Análise e Modelagem:**
      - NumPy
      - Pandas
      - Scikit-learn
  - **Serviço Web:**
      - Flask
      - Gunicorn (Servidor WSGI de produção)
  - **Gerenciamento de Dependências:**
      - Pipenv
  - **Implantação:**
      - Docker

## 🚀 Como Executar o Projeto

Siga os passos abaixo para configurar e executar o projeto em seu ambiente local.

### 📋 Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

  - Python 3.7+
  - Pipenv
  - Docker

### ⚙️ Instalação

1.  Clone o repositório:

<!-- end list -->

```bash
git clone https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
cd SEU_REPOSITORIO
```

2.  Instale as dependências usando Pipenv:

<!-- end list -->

```bash
pipenv install
```

### 🧠 Treinamento do Modelo

O notebook `churn_prediction.ipynb` contém todo o processo de análise e treinamento.
Execute o notebook para treinar o modelo do zero. Isso gerará o arquivo `churn_prediction.bin`, que contém o `DictVectorizer` e o modelo de Regressão Logística treinados.

### 💡 Executando o Serviço de Predição

Você pode executar o serviço de duas maneiras: localmente com Flask ou via Docker.

**Opção 1: Executando com Docker (Recomendado)**

1.  **Construa a imagem Docker:**
    ```bash
    docker build -t churn-service .
    ```
2.  **Execute o contêiner:**
    ```bash
    docker run -p 9696:9696 churn-service
    ```

O serviço estará disponível em `http://localhost:9696`.

**Opção 2: Executando Localmente com Flask/Gunicorn**

1.  **Ative o ambiente virtual:**
    ```bash
    pipenv shell
    ```
2.  **Inicie o servidor:**
    ```bash
    gunicorn --bind 0.0.0.0:9696 churn_serving:app
    ```

## 🤖 Exemplo de Uso da API

Uma vez que o serviço esteja em execução, você pode enviar uma requisição `POST` para o endpoint `/predict`.

### Exemplo com `curl`

```bash
curl -X POST \
  http://localhost:9696/predict \
  -H 'Content-Type: application/json' \
  -d '{
    "gender": "female",
    "seniorcitizen": 0,
    "partner": "yes",
    "dependents": "no",
    "phoneservice": "no",
    "multiplelines": "no_phone_service",
    "internetservice": "dsl",
    "onlinesecurity": "no",
    "onlinebackup": "yes",
    "deviceprotection": "no",
    "techsupport": "no",
    "streamingtv": "no",
    "streamingmovies": "no",
    "contract": "month-to-month",
    "paperlessbilling": "yes",
    "paymentmethod": "electronic_check",
    "tenure": 1,
    "monthlycharges": 29.85,
    "totalcharges": 29.85
  }'
```

### Exemplo com Python (`requests`)

```python
import requests

url = 'http://localhost:9696/predict'
cliente = {
    "gender": "female", "seniorcitizen": 0, "partner": "yes", "dependents": "no",
    "phoneservice": "no", "multiplelines": "no_phone_service", "internetservice": "dsl",
    "onlinesecurity": "no", "onlinebackup": "yes", "deviceprotection": "no",
    "techsupport": "no", "streamingtv": "no", "streamingmovies": "no",
    "contract": "month-to-month", "paperlessbilling": "yes", "paymentmethod": "electronic_check",
    "tenure": 1, "monthlycharges": 29.85, "totalcharges": 29.85
}

response = requests.post(url, json=cliente).json()

print(response)
```

**Resposta Esperada:**

```json
{
  "churn": true,
  "churn_probability": 0.6363236333333334
}
```

## 📂 Estrutura do Repositório

```
.
├── churn_prediction.bin      # Modelo serializado e vetorizador
├── churn_prediction.ipynb    # Notebook de análise e treinamento
├── churn_serving.py          # Script da aplicação Flask
├── Dockerfile                # Definição do contêiner Docker
├── Pipfile                   # Declaração de dependências
├── Pipfile.lock              # Lockfile de dependências
└── README.md                 # Este arquivo
```

## 🙏 Agradecimentos

Este projeto foi desenvolvido como parte do meu aprendizado com o livro **"Machine Learning Bookcamp"** de Alexey Grigorev, aplicando os conceitos de modelagem, avaliação e implantação de ponta a ponta.

## 👤 Contato

**Raimundo Araújo** - [LinkedIn](https://www.linkedin.com/in/raimundoivy/)
