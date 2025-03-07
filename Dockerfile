FROM python:3.13  
ENV PYTHONUNBUFFERED=TRUE
RUN pip --no-cache-dir install pipenv
WORKDIR /app
COPY ["Pipfile", "Pipfile.lock", "./"]
RUN pipenv install --deploy --system && \
    rm -rf /root/.cache
COPY ["*.py", "churn_prediction.bin", "./"] 
EXPOSE 9696
ENTRYPOINT ["python", "churn_serving.py"] 