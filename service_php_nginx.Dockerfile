FROM php:8.2-fpm

# Install Nginx and Supervisor
RUN apt-get update && apt-get install -y nginx supervisor

# Create directories for Supervisor
RUN mkdir -p /var/log/supervisor /etc/supervisor/conf.d

# Copy Nginx configuration
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Supervisor configuration
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
# Set working directory
WORKDIR /var/www/html

# Expose the Nginx port
EXPOSE 80

# Start Supervisor to manage both Nginx and PHP-FPM
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
