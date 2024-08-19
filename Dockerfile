# Étape 1 : Construire l'image de base
FROM php:8.2-fpm

# Installer les dépendances
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurer le répertoire de travail
WORKDIR /var/www/html

# Copier les fichiers de l'application
COPY . /var/www/html

# Copier le script d'initialisation
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Rendre le script exécutable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Définir le point d'entrée
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Exposer le port sur lequel l'application écoute
EXPOSE 8000
