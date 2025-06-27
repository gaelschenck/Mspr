# Utilisation de Node.js pour un projet React/Vue.js (modifie selon ta stack)
FROM node:18 AS build

# Définition du répertoire de travail
WORKDIR /app

# Copie d'abord les fichiers de dépendances
COPY package*.json ./

# Installation des dépendances
RUN npm install
# RUN npm install vue-i18n
# RUN npm install pinia
# RUN npm install chart.js
# RUN npm install axios
# RUN npm install vue-router@next
# RUN npm install chart.js

# Copie des fichiers du projet
COPY . .

# Construction du projet (modifie selon ta stack)
RUN npm run build

# ---- Étape de production avec un serveur léger ----
FROM nginx:alpine

# Copie le build dans le dossier public de nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copie la configuration nginx pour SPA
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposition du port 80 (standard web)
EXPOSE 80

# Lancement de nginx (par défaut)
CMD ["nginx", "-g", "daemon off;"]