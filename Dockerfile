FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["uvicorn", "services.data_loader.main:app", "--host", "0.0.0.0", "--port", "8000"]