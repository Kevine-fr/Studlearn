FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \ 
    libpng-dev \ 
    libjpeg-dev \ 
    libfreetype6-dev \ 
    libzip-dev \ 
    libpq-dev \ 
    libonig-dev \ 
    git \ 
    unzip \ 
    libxml2-dev && \ 
    docker-php-ext-configure gd --with-freetype --with-jpeg && \ 
    docker-php-ext-install gd pdo pdo_mysql zip 

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html 

EXPOSE 8000 

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"] 
