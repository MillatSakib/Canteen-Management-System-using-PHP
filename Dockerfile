FROM php:8.2-apache

# Install mysqli and pdo_mysql
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache mod_rewrite (optional but recommended)
RUN a2enmod rewrite

# Restart Apache inside container
CMD ["apache2-foreground"]
