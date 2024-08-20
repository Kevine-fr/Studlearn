#!/bin/sh

# Lance le serveur PHP en arrière-plan
php artisan serve --host=0.0.0.0 --port=8000 &

# Lance les tâches npm
npm run dev &

# Attend que tous les processus en arrière-plan se terminent pour garder le conteneur en cours d'exécution
wait
