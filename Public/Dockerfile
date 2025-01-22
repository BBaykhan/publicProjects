# Use the official PHP image with Apache
FROM php:8.2-apache

# Enable Apache mod_rewrite (needed for some PHP apps)
RUN a2enmod rewrite

# Copy the current directory contents into the container's web root
COPY . /var/www/html/

# Expose port 80 to make the server accessible
EXPOSE 80
