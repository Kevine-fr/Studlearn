#!/bin/bash

# Exécuter les migrations Laravel
echo "Running migrations..."
php /var/www/html/artisan migrate --force

# Démarrer le serveur Laravel
echo "Starting Laravel application..."
php /var/www/html/artisan serve --host=0.0.0.0 --port=8000
