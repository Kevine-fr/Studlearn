#!/bin/sh

# Attendre que la base de données soit prête
echo "Waiting for database..."
until nc -z -v -w30 db 3306
do
  echo "Waiting for database connection..."
  sleep 15
done

echo "Database is up - executing migrations"
# Exécuter les migrations
php artisan migrate --force

# Démarrer le serveur Laravel
php artisan serve --host=0.0.0.0 --port=8000
