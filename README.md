`# Predição de Churn de Clientes da Telco

## Visão Geral

Este projeto se concentra em prever o churn (cancelamento) de clientes para uma empresa de telecomunicações ("Telco"). Ele usa aprendizado de máquina, especificamente regressão logística, para identificar clientes que provavelmente cancelarão seus serviços (churn). O projeto percorre todo o processo de ciência de dados, desde o carregamento e limpeza dos dados até o treinamento, avaliação e considerações de implementação do modelo, incluindo a implantação como um serviço web usando Flask e Docker.

## Estrutura do Projeto

O projeto consiste nos seguintes arquivos principais:

*   `churn_prediction.py`: Contém o script principal do Python para o processo de ciência de dados (carregamento de dados, EDA, engenharia de recursos, treinamento do modelo, avaliação).
*   `churn_serving.py`:  Um script Python que usa Flask para criar um serviço web simples para prever o churn.  Este arquivo usa o modelo treinado salvo (`churn_prediction.bin`).
*   `churn_prediction.bin`:  O arquivo binário contendo o modelo de regressão logística treinado e o objeto `DictVectorizer`, salvos usando `pickle`.
*   `Dockerfile`:  Define a configuração do contêiner Docker para implantar o serviço de previsão de churn.
*   `Pipfile` e `Pipfile.lock`: Arquivos de configuração para `Pipenv`, gerenciando as dependências do projeto.

## Conjunto de Dados (Dataset)

O conjunto de dados usado é o "Telco Customer Churn", que está disponível publicamente. Ele contém informações sobre dados demográficos do cliente, serviços, informações da conta e se o cliente cancelou o serviço (churn).

## Requisitos

Para executar este projeto localmente (sem Docker), você precisará das seguintes bibliotecas Python:

*   `numpy`
*   `pandas`
*   `matplotlib`
*   `seaborn`
*   `scikit-learn`
*   `requests`
*   `flask`
*   `waitress` (para o servidor de produção WSGI)

Você pode instalá-los usando `pip`:

```bash
pip install numpy pandas matplotlib seaborn scikit-learn requests flask waitress`

Ou, utilizando pipenv (recomendado para gerenciar ambientes virtuais):

      `pipenv install`

## Executando o Projeto

### 1. Treinamento do Modelo

Primeiro, execute o script churn_prediction.py para treinar o modelo e salvar o modelo treinado e o vetorizador:

      `python churn_prediction.py`

Isso irá:

- Carregar e preparar os dados.
- Realizar a Análise Exploratória de Dados (EDA).
- Fazer a engenharia de recursos.
- Treinar o modelo de regressão logística.
- Avaliar o modelo.
- Salvar o modelo treinado e o DictVectorizer em um arquivo chamado churn_prediction.bin.

### 2. Implantação do Modelo

Você tem duas opções para implantar o modelo: usando Flask diretamente ou usando Docker.

### a) Usando Flask (sem Docker)

1. **Execute o script de serviço:**
    
          `python churn_serving.py`
    
    Isso iniciará o servidor Flask na porta 9696.  O script churn_serving.py carrega o modelo pré-treinado (churn_prediction.bin) e expõe um endpoint /predict para receber solicitações de previsão.
    
2. **Envie solicitações de previsão:**
    
    Você pode enviar solicitações POST para o endpoint /predict com dados do cliente no formato JSON.  Você pode usar requests (ou ferramentas como curl ou Postman) para isso.  Por exemplo, usando Python:
    
          `import requests
    
    url = 'http://localhost:9696/predict'  # Ou use o endereço do servidor, se não for local
    customer = {
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
        "tenure": 1,  # meses
        "monthlycharges": 29.85,
        "totalcharges": 29.85
    }
    
    response = requests.post(url, json=customer)
    result = response.json()
    print(result)
    # Exemplo de output: {'churn_probability': 0.636, 'churn': True}`
    

### b) Usando Docker

1. **Construa a imagem Docker:**
    
    No mesmo diretório onde o Dockerfile está localizado, execute:
    
          `docker build -t churn-prediction-service .`
    
    IGNORE_WHEN_COPYING_START
    
    content_copy  download  Use code [with caution](https://support.google.com/legal/answer/13505487).Bash
    
    IGNORE_WHEN_COPYING_END
    
    Isso criará uma imagem Docker chamada churn-prediction-service.  O Dockerfile configura o ambiente Python, instala as dependências usando Pipenv e copia os arquivos necessários para o contêiner.
    
2. **Execute o contêiner Docker:**
    
          `docker run -p 9696:9696 churn-prediction-service`
    
    Isso iniciará o contêiner e mapeará a porta 9696 do contêiner para a porta 9696 na sua máquina host.  O serviço Flask estará acessível da mesma forma que na execução local (usando localhost:9696).
    
3. **Envie solicitações de previsão (mesmo que no passo 2 da opção Flask):**
    
    Use o mesmo código Python (com requests) ou ferramenta (como curl) para enviar solicitações POST para o endpoint /predict no http://localhost:9696.  O contêiner Docker está executando o mesmo serviço Flask.
    

### Conteúdo dos Arquivos

- **churn_serving.py:**

      `import pickle
import numpy as np
from flask import Flask, request, jsonify

def predict_single(customer, dv, model):
    x = dv.transform([customer])
    y_pred = model.predict_proba(x)[:, 1]
    return y_pred[0]

with open('churn_prediction.bin', 'rb') as f_in:
    dv, model = pickle.load(f_in)

app = Flask('churn')

@app.route('/predict', methods=['POST'])
def predict():
    customer = request.get_json()
    prediction = predict_single(customer, dv, model)
    churn = prediction >= 0.5
    result = {
        'churn_probability': float(prediction),
        'churn': bool(churn),
    }
    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9696)`

- **Dockerfile:**

      `FROM python:3.13
ENV PYTHONUNBUFFERED=TRUE
RUN pip --no-cache-dir install pipenv
WORKDIR /app
COPY ["Pipfile", "Pipfile.lock", "./"]
RUN pipenv install --deploy --system && \
    rm -rf /root/.cache
COPY ["*.py", "churn_prediction.bin", "./"]
EXPOSE 9696
ENTRYPOINT ["python", "churn_serving.py"]`

- **Pipfile:**

      `[[source]]
url = "https://pypi.org/simple"
verify_ssl = true
name = "pypi"

[packages]
numpy = "*"
scikit-learn = "*"
flask = "*"
waitress = "*"
pandas = "*"
requests = "*"
seaborn = "*"
matplotlib="*"

[dev-packages]

[requires]
python_version = "3.13"`
