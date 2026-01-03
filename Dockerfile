FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Инсталираме зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копираме проекта
COPY . .

# Jupyter
EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]