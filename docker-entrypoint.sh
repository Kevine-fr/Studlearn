#!/bin/sh
# Exécute les migrations
php artisan migrate --force

# Lance le serveur PHP
php artisan serve --host=0.0.0.0 --port=8000 &

# Lance les tâches npm en parallèle
npm run dev

# Pour garder le conteneur en cours d'exécution
wait
