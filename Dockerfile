FROM php:8.3-alpine

RUN apk add --no-cache linux-headers openssl-dev libevent-dev libzip-dev libbz2 pcre-dev postgresql-dev ${PHPIZE_DEPS} \
  && docker-php-ext-configure pcntl --enable-pcntl \
#  && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pcntl zip bz2 sockets pgsql pdo_pgsql \
  && pecl install event ds inotify \
  && docker-php-ext-enable ds \
  && docker-php-ext-enable inotify \
  && docker-php-ext-enable --ini-name zz-event.ini event \
  && apk del pcre-dev ${PHPIZE_DEPS} \
  && mkdir /app
#COPY . /app
WORKDIR /app

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
#RUN composer install --no-interaction --no-plugins --no-scripts --no-dev --prefer-dist
#RUN php artisan package:discover --ansi
EXPOSE 3380
CMD [ "php", "./start.php" ]

# mount your php application into /app folder with start.php entry point
