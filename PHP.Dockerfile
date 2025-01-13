FROM php:fpm

RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install mysqli

RUN pecl install xdebug && docker-php-ext-enable xdebug

# Install dependencies required for Composer
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    && apt-get clean

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /app/app_laravel

RUN mkdir -p /app/app_laravel/storage /app/app_laravel/bootstrap/cache /app/app_laravel/database
RUN chown -R www-data:www-data /app/app_laravel/storage /app/app_laravel/bootstrap/cache
RUN chmod -R 777 /app/app_laravel/storage /app/app_laravel/bootstrap/cache \
                 /app/app_laravel/database

