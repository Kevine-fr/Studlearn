# Utiliser l'image PHP avec FPM
FROM php:8.2-fpm

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers du projet dans le conteneur
COPY . /var/www/html

# Installer les dépendances système et PHP nécessaires
RUN apt-get update && \
    apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        git \
        unzip \
        nodejs \
        npm && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql && \
    rm -rf /var/lib/apt/lists/*

# Copier Composer depuis l'image officielle Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installer les dépendances PHP
RUN composer install --prefer-dist --no-dev --optimize-autoloader

# Copier le fichier .env.example en .env
RUN cp .env.example .env

# Configurer la base de données et générer la clé d'application
RUN sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=password/" .env && \
    sed -i "s/^DB_DATABASE=.*/DB_DATABASE=studlearn/" .env && \
    sed -i "s/^DB_DATABASE=.*/DB_HOST=db/" .env && \
    php artisan key:generate

# Installer les dépendances Node.js et compiler les assets front-end
RUN npm install
RUN npm install vite --save-dev

# Copier le script d'entrée et le rendre exécutable
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Exposer le port 8000
EXPOSE 8000

# Définir le point d'entrée du conteneur
CMD ["/usr/local/bin/docker-entrypoint.sh"]
