# Étape 1 : Construire l'image de base avec les dépendances PHP
FROM php:8.1-fpm as base

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libjpeg-dev \
    libfreetype6-dev \
    libpq-dev \
    libsqlite3-dev

# Installer les extensions PHP requises
RUN docker-php-ext-install pdo_mysql pdo mbstring exif pcntl bcmath gd

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Étape 2 : Cloner le projet Laravel et installer les dépendances
WORKDIR /var/www/html

# Copier les fichiers du projet
COPY . .

# Installer les dépendances PHP avec Composer
RUN composer install --no-dev --optimize-autoloader

# Copier le fichier .env.example et générer la clé d'application
RUN cp .env.example .env
RUN php artisan key:generate

# Préparer l'application pour le déploiement
COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh

# Créer les répertoires manquants si nécessaire et définir les permissions
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Exposer le port 8000 et démarrer le serveur Laravel
EXPOSE 8000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
