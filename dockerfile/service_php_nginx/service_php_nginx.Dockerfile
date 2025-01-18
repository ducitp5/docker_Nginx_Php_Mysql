FROM php:8.2-fpm

# Install Nginx, Supervisor, and required PHP extensions
RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
    zip \
    unzip \
    curl \
    git \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 777 /var/www/html

WORKDIR /var/www/html

# Expose the Nginx port
EXPOSE 80

RUN mkdir -p /var/log/supervisor /etc/supervisor/conf.d

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Start Supervisor to manage both Nginx and PHP-FPM
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
