# Predição de Churn de Clientes da Telco

## Visão Geral

Este projeto se concentra em prever o churn (cancelamento) de clientes para uma empresa de telecomunicações ("Telco"). Ele usa aprendizado de máquina, especificamente regressão logística, para identificar clientes que provavelmente cancelarão seus serviços (churn). O projeto percorre todo o processo de ciência de dados, desde o carregamento e limpeza dos dados até o treinamento, avaliação e considerações de implementação do modelo.

## Estrutura do Projeto

O projeto está contido principalmente em um único script Python (`churn_prediction.py`), que é bem comentado e pode ser executado sequencialmente. As etapas principais incluem:

1.  **Carregamento e Preparação dos Dados:**
    *   Carrega o conjunto de dados Telco Customer Churn (fornecido como `WA_Fn-UseC_-Telco-Customer-Churn.csv`).
    *   Lida com conversões de tipo de dados (por exemplo, `TotalCharges` para numérico).
    *   Limpa nomes de colunas e valores de string (minúsculas, substitui espaços por sublinhados).
    *   Converte a coluna `churn` para uma representação inteira binária (0 e 1).
    *   Divide os dados em conjuntos de treinamento, validação e teste.

2.  **Análise Exploratória de Dados (EDA):**
    *   Calcula a taxa de churn geral.
    *   Examina a distribuição de recursos categóricos e numéricos.
    *   Calcula a importância dos recursos usando:
        *   **Taxa de Risco (Risk Ratio):** Compara as taxas de churn em diferentes grupos de recursos categóricos.
        *   **Informação Mútua (Mutual Information):** Mede a dependência entre recursos categóricos e o alvo de churn.
        *   **Correlação:** Examina a relação entre recursos numéricos e churn.

3.  **Engenharia de Recursos:**
    *   Usa `DictVectorizer` do scikit-learn para realizar a codificação one-hot em recursos categóricos, criando uma matriz de recursos numéricos.

4.  **Treinamento e Avaliação do Modelo:**
    *   Treina um modelo de regressão logística usando scikit-learn.
    *   Avalia o modelo usando:
        *   **Acurácia (Accuracy):** A porcentagem geral de previsões corretas.
        *   **Matriz de Confusão (Confusion Matrix):** Uma tabela mostrando Verdadeiros Positivos, Verdadeiros Negativos, Falsos Positivos e Falsos Negativos.
        *   **Precisão (Precision):** A proporção de previsões positivas que estavam realmente corretas.
        *   **Revocação/Recall (Recall):** A proporção de casos positivos reais que foram previstos corretamente.
        *   **Curva ROC e AUC:** Visualiza o trade-off entre a Taxa de Verdadeiros Positivos e a Taxa de Falsos Positivos em diferentes limites de probabilidade. AUC (Área Sob a Curva) fornece uma única métrica resumindo o desempenho do modelo.
    *   Realiza validação cruzada K-fold para obter uma estimativa mais robusta do desempenho do modelo e ajustar o parâmetro de regularização (C).

5.  **Implantação do Modelo (Considerações):**
    *   Demonstra como usar o modelo treinado para prever o churn para clientes individuais.
    *   Mostra como salvar e carregar o modelo usando `pickle`.
    *   Inclui instruções básicas e um trecho de código para servir o modelo usando Flask (um framework web simples).

## Conjunto de Dados (Dataset)

O conjunto de dados usado é o "Telco Customer Churn", que está disponível publicamente. Ele contém informações sobre dados demográficos do cliente, serviços, informações da conta e se o cliente cancelou o serviço (churn).

**Você deve incluir um link para o conjunto de dados ou o próprio arquivo do conjunto de dados em seu repositório.** Se o conjunto de dados for grande, você pode incluir uma amostra menor ou fornecer instruções sobre como baixar o conjunto de dados completo. Aqui está uma boa maneira de lidar com isso:

**Opção 1: Incluir o arquivo CSV diretamente (se for pequeno o suficiente, < 25 MB):**

Basta colocar o arquivo `WA_Fn-UseC_-Telco-Customer-Churn.csv` no mesmo diretório que seu `churn_prediction.py` e README.md. Nenhuma ação adicional é necessária no README.

**Opção 2: Link para o conjunto de dados (recomendado se for maior):**

1.  **Encontre uma fonte confiável:** O conjunto de dados é frequentemente encontrado no Kaggle: [https://www.kaggle.com/datasets/blastchar/telco-customer-churn](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
2.  **Adicione isso ao seu README:**

    ```markdown
    ## Conjunto de Dados (Dataset)

    O conjunto de dados usado neste projeto é o Telco Customer Churn, disponível no Kaggle:

    [Telco Customer Churn Dataset](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)

    Por favor, baixe o arquivo `WA_Fn-UseC_-Telco-Customer-Churn.csv` e coloque-o no mesmo diretório que o script `churn_prediction.py`.
    ```

## Requisitos

Para executar este projeto, você precisará das seguintes bibliotecas Python:

*   `numpy`
*   `pandas`
*   `matplotlib`
*   `seaborn`
*   `scikit-learn`
*   `requests`
*   *(Opcional, para implantação com Flask)* `flask`

Você pode instalá-los usando `pip`:

```bash
pip install numpy pandas matplotlib seaborn scikit-learn requests flask
