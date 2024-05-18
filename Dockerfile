# FROM php:8.2-apache
FROM apache-php-composer:1.0

WORKDIR /var/www/html

# RUN chmod -R 755 /usr/local/

# needed to install composer deps
ENV COMPOSER_ALLOW_SUPERUSER=1

# copy project files
COPY . .
# RUN rm -f composer.lock 

# run commands to set up

# change permissions for /usr/local/bin
RUN apt-get update 
# zipper needed
RUN apt-get install -y zip unzip 
# install composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# load dependencies
RUN composer install --prefer-dist

# enable mysql_pdo
RUN docker-php-ext-install mysqli pdo_mysql

# set permissions on public folder
RUN chmod -R 755 /var/www/html/public

RUN a2enmod rewrite

# run migrations LAST
# RUN php bin/console doctrine:database:create
# RUN php bin/console make:migration
# RUN php bin/console doctrine:migrations:migrate
# RUN php bin/console cache:clear


# Listen on http port
EXPOSE 80

# make it point to public/ dir
WORKDIR /var/www/html/