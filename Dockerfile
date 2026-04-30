FROM python:3.11-slim

WORKDIR /app

# Εγκατάσταση συστημικών εργαλείων (χρήσιμα για compile κάποιων python libs)
RUN apt-get update && apt-get install -y \
    build-essential curl \
    && rm -rf /var/lib/apt/lists/*

# Αντιγραφή και εγκατάσταση requirements
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Αντιγραφή του κώδικα
COPY . .

# Η θύρα του Streamlit
EXPOSE 8501

# Healthcheck για να ξέρει το Coolify αν η εφαρμογή είναι υγιής
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
