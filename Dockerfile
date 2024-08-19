FROM php:8.2-fpm

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers du projet dans le conteneur
COPY . /var/www/html

# Installer les dépendances du système et les extensions PHP nécessaires
RUN apt-get update && \
    apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        git \
        unzip && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql && \
    rm -rf /var/lib/apt/lists/*

# Copier Composer depuis l'image officielle Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copier le script wait-for-it.sh
COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh

# Installer les dépendances PHP
RUN composer install --prefer-dist --no-dev --optimize-autoloader

# Copier le fichier .env.example en .env
RUN cp .env.example .env

# Ajouter ou modifier les lignes DB_PASSWORD et DB_DATABASE dans le fichier .env
RUN sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=password/" .env && \
    sed -i "s/^DB_DATABASE=.*/DB_DATABASE=studlearn/" .env

# Générer la clé d'application
RUN php artisan key:generate

# Attendre que MySQL soit disponible avant d'exécuter les migrations et démarrer le serveur
CMD ["sh", "-c", "wait-for-it.sh mysql:3306 -- php artisan migrate --force && php artisan serve --host=0.0.0.0"]
