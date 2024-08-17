# Utiliser l'image PHP avec Apache, car Laravel est généralement exécuté sur PHP avec un serveur web comme Apache ou Nginx
FROM php:8.1-apache

# Définir le répertoire de travail
WORKDIR /var/www/html

# Installer les extensions PHP nécessaires pour Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Installer Composer globalement
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copier les fichiers de l'application Laravel dans le conteneur
COPY . .

# Installer les dépendances de Laravel
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Changer les permissions des dossiers storage et bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Exposer le port 80 (port par défaut pour Apache)
EXPOSE 80

# Commande par défaut pour démarrer Apache
CMD ["apache2-foreground"]
