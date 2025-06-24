FROM nginx:alpine

# Copie de la configuration personnalisée du reverse proxy
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]