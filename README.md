## Previsão de Churn de Clientes da Telco

## Visão Geral

Este projeto se concentra em prever o churn (cancelamento) de clientes para uma empresa de telecomunicações ("Telco"). Ele usa aprendizado de máquina, especificamente regressão logística, para identificar clientes que provavelmente cancelarão seus serviços (churn). O projeto percorre todo o processo de ciência de dados, desde o carregamento e limpeza dos dados até o treinamento, avaliação e considerações de implementação do modelo, incluindo a implantação como um serviço web usando Flask e Docker.

## Estrutura do Projeto

O projeto consiste nos seguintes arquivos principais:

* `churn_prediction.ipynb`: Contém o notebook principal em Python para o processo de ciência de dados (carregamento de dados, EDA, engenharia de recursos, treinamento do modelo, avaliação).
* `churn_serving.py`:  Um script Python que usa Flask para criar um serviço web simples para prever o churn.  Este arquivo usa o modelo treinado salvo (`churn_prediction.bin`).
* `churn_prediction.bin`:  O arquivo binário contendo o modelo de regressão logística treinado e o objeto `DictVectorizer`, salvos usando `pickle`.
* `Dockerfile`:  Define a configuração do contêiner Docker para implantar o serviço de previsão de churn.
* `Pipfile` e `Pipfile.lock`: Arquivos de configuração para `Pipenv`, gerenciando as dependências do projeto.

## Conjunto de Dados (Dataset)

O conjunto de dados usado é o "Telco Customer Churn", que está disponível publicamente. Ele contém informações sobre dados demográficos do cliente, serviços, informações da conta e se o cliente cancelou o serviço (churn).

## Requisitos

Para executar este projeto localmente (sem Docker), você precisará das seguintes bibliotecas Python:

* `numpy`
* `pandas`
* `matplotlib`
* `seaborn`
* `scikit-learn`
* `requests`
* `flask`
* `waitress` (para o servidor de produção WSGI)

Você pode instalá-los usando `pip`:

```bash
pip install numpy pandas matplotlib seaborn scikit-learn requests flask waitress
```

Ou, utilizando pipenv (recomendado para gerenciar ambientes virtuais):

```bash
pipenv install
```

## Executando o Projeto

1.  **Treinamento do Modelo**

    Primeiro, execute o notebook `churn_prediction.ipynb` para treinar o modelo e salvar o modelo treinado e o vetorizador:

    ```bash
    jupyter notebook churn_prediction.ipynb
    ```

    Ou, se estiver utilizando o VS Code ou outra IDE que suporte notebooks Jupyter, abra o arquivo e execute as células sequencialmente.

    Isso irá:

    * Carregar e preparar os dados.
    * Realizar a Análise Exploratória de Dados (EDA).
    * Fazer a engenharia de recursos.
    * Treinar o modelo de regressão logística.
    * Avaliar o modelo.
    * Salvar o modelo treinado e o `DictVectorizer` em um arquivo chamado `churn_prediction.bin`.

2.  **Implantação do Modelo**

    Você tem duas opções para implantar o modelo: usando Flask diretamente ou usando Docker.

    a)  **Usando Flask (sem Docker)**

    * Execute o script de serviço:

        ```bash
        python churn_serving.py
        ```

        Isso iniciará o servidor Flask na porta 9696. O script `churn_serving.py` carrega o modelo pré-treinado (`churn_prediction.bin`) e expõe um endpoint `/predict` para receber solicitações de previsão.

    * Envie solicitações de previsão:

        Você pode enviar solicitações POST para o endpoint `/predict` com dados do cliente no formato JSON. Você pode usar `requests` (ou ferramentas como `curl` ou Postman) para isso. Por exemplo, usando Python:

        ```python
        import requests

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
        print(result)  # Exemplo de output: {'churn_probability': 0.636, 'churn': True}
        ```

    b)  **Usando Docker**

    * Construa a imagem Docker:

        No mesmo diretório onde o `Dockerfile` está localizado, execute:

        ```bash
        docker build -t churn-prediction-service .
        ```

        Isso criará uma imagem Docker chamada `churn-prediction-service`. O `Dockerfile` configura o ambiente Python, instala as dependências usando Pipenv e copia os arquivos necessários para o contêiner.

    * Execute o contêiner Docker:

        ```bash
        docker run -p 9696:9696 churn-prediction-service
        ```

        Isso iniciará o contêiner e mapeará a porta 9696 do contêiner para a porta 9696 na sua máquina host. O serviço Flask estará acessível da mesma forma que na execução local (usando `localhost:9696`).

    * Envie solicitações de previsão (mesmo que no passo 2 da opção Flask):

        Use o mesmo código Python (com `requests`) ou ferramenta (como `curl`) para enviar solicitações POST para o endpoint `/predict` no `http://localhost:9696`. O contêiner Docker está executando o mesmo serviço Flask.
