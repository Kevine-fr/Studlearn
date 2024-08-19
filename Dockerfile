# Utiliser l'image PHP 8.2 avec FPM
FROM php:8.2-fpm

# Définir le répertoire de travail
WORKDIR /var/www/html

# Installer les dépendances système requises
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install gd pdo pdo_mysql

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copier les fichiers de l'application dans le conteneur
COPY . /var/www/html

# Installer les dépendances PHP via Composer
RUN composer install --prefer-dist --no-dev --optimize-autoloader

# Copier le fichier .env.example en .env
RUN cp .env.example .env

# Générer la clé d'application Laravel
RUN php artisan key:generate

# Exécuter les migrations (cette étape dépend de la disponibilité de la base de données)
RUN php artisan migrate --force

# Mettre en cache les configurations, les routes et les vues
RUN php artisan config:cache
RUN php artisan route:cache
RUN php artisan view:cache

# Exposer le port 8000
EXPOSE 8000

# Démarrer le serveur PHP intégré de Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
