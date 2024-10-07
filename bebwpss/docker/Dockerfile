# Menggunakan image PHP dengan Apache
FROM php:8.2-apache

# Install dependencies yang dibutuhkan
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    locales \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy semua file Laravel ke container
COPY . /var/www

# Set permissions untuk direktori storage dan bootstrap/cache
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www \
    && chmod -R 777 /var/www/storage \
    && chmod -R 777 /var/www/bootstrap/cache

# Enable mod_rewrite untuk Laravel
RUN a2enmod rewrite

# Jalankan Composer install
RUN composer install --ignore-platform-reqs

# Copy konfigurasi Apache untuk Laravel
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Expose port 80
EXPOSE 80

# Jalankan perintah Artisan migrate dan seeder
CMD php artisan migrate --seed && apache2-foreground
