FROM php:8.2-fpm

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers du projet dans le conteneur
COPY . /var/www/html

# Exposer le port 8000
EXPOSE 8000

# Définir le point d'entrée du conteneur
CMD ["/usr/local/bin/docker-entrypoint.sh"]
