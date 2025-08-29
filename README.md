# 🤖 Customer Churn Prediction Service

## 🎯 About the Project

Customer retention is one of the pillars for the success of any service company. Losing customers (churn) not only results in revenue loss but also incurs costs to acquire new ones.

This project addresses this business challenge by creating an end-to-end service that predicts the probability of a telecommunications company's customer canceling their contract. Using a **Logistic Regression** model, the service analyzes customer data and returns a churn risk score, allowing the company to take proactive actions to retain valuable customers.

The key differentiator of this project is its focus on **operationalization (MLOps)**: the model doesn't just live in a notebook; it is encapsulated in a **web service via Flask** and **containerized with Docker**, ready to be deployed in a production environment.

## ✨ Key Features

  - **Exploratory Data Analysis (EDA):** In-depth investigation of the data to identify the main factors influencing churn.
  - **Feature Engineering:** Preprocessing and transformation of categorical variables for use in the model.
  - **Model Training and Validation:** Building and evaluating a Logistic Regression model with Scikit-learn, using metrics like AUC-ROC.
  - **Model Serialization:** Saving the trained model and feature vectorizer with `pickle` for use in production.
  - **Web Service (API):** Development of a REST API with Flask that receives customer data in JSON and returns the churn probability.
  - **Containerization:** Creation of a Docker image to encapsulate the service, its dependencies, and the model, ensuring portability and reproducibility.

## 🛠️ Technologies Used

The project was built using the following technologies:

  - **Language:** Python
  - **Analysis and Modeling:**
      - NumPy
      - Pandas
      - Scikit-learn
  - **Web Service:**
      - Flask
      - Gunicorn (Production WSGI Server)
  - **Dependency Management:**
      - Pipenv
  - **Deployment:**
      - Docker

## 🚀 How to Run the Project

Follow the steps below to set up and run the project in your local environment.

### 📋 Prerequisites

Make sure you have the following tools installed:

  - Python 3.7+
  - Pipenv
  - Docker

### ⚙️ Installation

1.  Clone the repository:

    ```bash
    git clone [https://github.com/Raimundoivy/ClientChurnPrediction.git](https://github.com/Raimundoivy/ClientChurnPrediction.git)
    cd ClientChurnPrediction
    ```

2.  Install the dependencies using Pipenv:

    ```bash
    pipenv install
    ```

### 🧠 Model Training

The `churn_prediction.ipynb` notebook contains the entire analysis and training process.
Run the notebook to train the model from scratch. This will generate the `churn_prediction.bin` file, which contains the trained `DictVectorizer` and Logistic Regression model.

### 💡 Running the Prediction Service

You can run the service in two ways: locally with Flask or via Docker.

**Option 1: Running with Docker (Recommended)**

1.  **Build the Docker image:**
    ```bash
    docker build -t churn-service .
    ```
2.  **Run the container:**
    ```bash
    docker run -p 9696:9696 churn-service
    ```

The service will be available at `http://localhost:9696`.

**Option 2: Running Locally with Flask/Gunicorn**

1.  **Activate the virtual environment:**
    ```bash
    pipenv shell
    ```
2.  **Start the server:**
    ```bash
    gunicorn --bind 0.0.0.0:9696 churn_serving:app
    ```

## 🤖 API Usage Example

Once the service is running, you can send a `POST` request to the `/predict` endpoint.

### Example with `curl`

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
````

### Example with Python (`requests`)

```python
import requests

url = 'http://localhost:9696/predict'
customer = {
    "gender": "female", "seniorcitizen": 0, "partner": "yes", "dependents": "no",
    "phoneservice": "no", "multiplelines": "no_phone_service", "internetservice": "dsl",
    "onlinesecurity": "no", "onlinebackup": "yes", "deviceprotection": "no",
    "techsupport": "no", "streamingtv": "no", "streamingmovies": "no",
    "contract": "month-to-month", "paperlessbilling": "yes", "paymentmethod": "electronic_check",
    "tenure": 1, "monthlycharges": 29.85, "totalcharges": 29.85
}

response = requests.post(url, json=customer).json()

print(response)
```

**Expected Response:**

```json
{
  "churn": true,
  "churn_probability": 0.6363236333333334
}
```

## 📂 Repository Structure

```
.
├── churn_prediction.bin      # Serialized model and vectorizer
├── churn_prediction.ipynb    # Analysis and training notebook
├── churn_serving.py          # Flask application script
├── Dockerfile                # Docker container definition
├── Pipfile                   # Dependency declaration
├── Pipfile.lock              # Dependency lockfile
└── README.md                 # This file
```

## 🙏 Acknowledgments

This project was developed as part of my learning with the book **"Machine Learning Bookcamp"** by Alexey Grigorev, applying the concepts of end-to-end modeling, evaluation, and deployment.

## 👤 Contact

**Raimundo Araújo** - [LinkedIn](https://www.linkedin.com/in/raimundoivy/)
