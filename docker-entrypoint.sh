#!/bin/sh

# Ajouter node_modules/.bin au PATH
export PATH=/var/www/html/node_modules/.bin:$PATH

# Installer les dépendances Node.js (au cas où elles n'auraient pas été installées)
npm install

# Lancer le serveur PHP en arrière-plan
php artisan serve --host=0.0.0.0 --port=8000 &

# Lancer les tâches npm
npm run dev &

# Garder le conteneur en cours d'exécution
wait
