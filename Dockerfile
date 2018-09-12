FROM php:7.2-fpm-alpine3.8
RUN set -x \
    #instala zlib necessario para o composer o dev traz junto o codigo fonte
    && apk add zlib-dev \
    #instala a extensao zip necessario para o composer
    && docker-php-ext-install zip \
    #instala o composer
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv /var/www/html/composer.phar /usr/bin/composer

ADD ./src /app
WORKDIR /app
EXPOSE 8088
CMD ["php", "-S", "0.0.0.0:8088"]
#cria variavel de ambiente para utilizar o usuario root na instalacao do composer
ENV COMPOSER_ALLOW_SUPERUSER=1
