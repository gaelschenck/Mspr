
# Utilisation de Python avec FastAPI
FROM python:3.12.7

# Définition du répertoire de travail
WORKDIR /app

# Copie des fichiers de l'application
COPY . .

# Installation des dépendances
RUN pip install -r requirements.txt

# Exposition du port
EXPOSE 8084

# Commande de lancement du backend
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0","--port", "8084"]