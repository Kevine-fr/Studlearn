#!/bin/bash

# Attendre que MySQL soit prêt
echo "Waiting for MySQL to be ready..."
/usr/local/bin/wait-for-it.sh mysql:3306 --timeout=60 --strict -- echo "MySQL is up"

# Exécuter les migrations avec force
echo "Running migrations..."
php artisan migrate --force

# Démarrer le serveur Laravel
echo "Starting Laravel server..."
exec php artisan serve --host=0.0.0.0 --port=8000
