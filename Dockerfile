FROM php:8.2-fpm

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers du projet dans le conteneur
COPY . /var/www/html

# Installer les dépendances
RUN apt-get update && \
    apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev git unzip php-mysql && \
    rm -rf /var/lib/apt/lists/*

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installer les dépendances PHP
RUN composer install --prefer-dist --no-dev --optimize-autoloader

# Copier le fichier .env.example en .env
RUN cp .env.example .env

# Ajouter ou modifier la ligne DB_PASSWORD dans le fichier .env
RUN sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=password/" .env

# Générer la clé d'application
RUN php artisan key:generate

# Exécuter les migrations
RUN php artisan migrate --force

# Mettre en cache la configuration, les routes et les vues
RUN php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

# Exposer le port
EXPOSE 8000

# Démarrer le serveur PHP intégré de Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
