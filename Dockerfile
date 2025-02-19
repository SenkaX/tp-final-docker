FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    zip \
    nodejs \
    npm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . /var/www/html

RUN docker-php-ext-install pdo_mysql zip

RUN composer install
RUN npm install && npm run build

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]