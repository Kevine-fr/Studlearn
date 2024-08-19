FROM php:8.2-fpm

WORKDIR /var/www/html

COPY . /var/www/html

RUN composer install ----prefer-dist

RUN cp .env.example .env
RUN php artisan key:generate
RUN php artisan migrate
RUN php artisan config:cache
RUN php artisan route:cache
RUN php artisan view:cache

EXPOSE 8000

# Démarrer le serveur PHP intégré de Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
