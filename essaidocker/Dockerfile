FROM nginx:alpine

# Copie de la configuration personnalisée
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]