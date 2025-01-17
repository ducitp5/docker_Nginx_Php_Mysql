#!/bin/bash
mkdir -p /app/app_laravel/storage /app/app_laravel/bootstrap/cache /app/app_laravel/database
chown -R www-data:www-data /app/app_laravel/storage /app/app_laravel/bootstrap/cache /app/app_laravel/database
chmod -R 777 /app/app_laravel/storage /app/app_laravel/bootstrap/cache /app/app_laravel/database

php-fpm