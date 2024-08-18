# Utiliser une image de base PHP avec les extensions requises pour Laravel
FROM php:8.1-fpm

# Installer les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libzip-dev \
    netcat \
    && docker-php-ext-install pdo_mysql zip

# Installer Composer globalement
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN mkdir /home/studlearn
# Créer et définir le répertoire de travail
WORKDIR /home/studlearn

# Copier le contenu du projet dans le conteneur
COPY . .

# Copier le fichier .env.example en .env
RUN cp .env.example .env

# Générer la clé d'application Laravel
RUN php artisan key:generate

# Copier le script wait-for-it.sh
COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh

# Changer les permissions des dossiers storage et bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Effacer les caches Laravel
RUN php artisan config:clear
RUN php artisan route:clear
RUN php artisan view:clear

# Exposer le port 8000 pour le serveur web
EXPOSE 8000

# Commande par défaut pour démarrer le serveur PHP de Laravel
CMD ["sh", "-c", "/usr/local/bin/wait-for-it.sh db:3306 -- php artisan migrate && php artisan serve --host=0.0.0.0 --port=8000"]
