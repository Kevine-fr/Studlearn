# Utilisation de l'image PHP officielle
FROM php:8.2-fpm

# Installation des extensions PHP requises
# RUN apt-get update && apt-get install -y \
#     libpng-dev \
#     libjpeg-dev \
#     libfreetype6-dev \
#     libzip-dev \
#     libpq-dev \
#     libonig-dev \
#     git \
#     unzip \
#     libxml2-dev && \
#     docker-php-ext-configure gd --with-freetype --with-jpeg && \
#     docker-php-ext-install gd pdo pdo_mysql zip

# Configuration du répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers de l'application
COPY . /var/www/html

# Installer Composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# # Installer les dépendances Composer
# RUN composer install --no-dev --optimize-autoloader

# # Définir les permissions
# RUN chown -R www-data:www-data /var/www/html

# Exposer le port de l'application
EXPOSE 8000

# Démarrer le serveur PHP intégré de Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
