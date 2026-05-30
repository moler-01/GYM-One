
FROM php:8.2-apache

# Instalar dependencias esenciales del sistema para GYM One
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql mysqli zip \
    && a2enmod rewrite

# Instalar Composer por si la app requiere dependencias internas
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Otorgar permisos al usuario de Apache
RUN chown -R www-data:www-data /var/www/html
