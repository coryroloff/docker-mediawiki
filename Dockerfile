FROM php:5.4-apache

RUN apt-get update && apt-get install -y libicu-dev g++ imagemagick git

RUN pecl update-channels && pecl install apc intl

RUN docker-php-ext-install mysql mysqli

RUN a2enmod rewrite

COPY php.ini /usr/local/etc/php/

# php:5.4-apache loads mods-enabled, not sites-enabled
# https://github.com/docker-library/php/blob/master/5.4/apache/apache2.conf
COPY mediawiki.conf /etc/apache2/mods-available/
RUN ln -s /etc/apache2/mods-available/mediawiki.conf /etc/apache2/mods-enabled/mediawiki.conf

RUN mkdir -p /var/www/w

WORKDIR /var/www/w

ENV MEDIAWIKI_VERSION 1.24.0

RUN DIR=$(echo $MEDIAWIKI_VERSION | awk -F \. {'print $1"."$2'}) && \
    curl -sSL http://releases.wikimedia.org/mediawiki/$DIR/mediawiki-$MEDIAWIKI_VERSION.tar.gz | \
    tar --strip-components=1 -xz && \
    rm -rf /var/www/w/images && \
    mkdir /var/www/mediawiki /var/www/data && \
    chown -R www-data:www-data /var/www && \
    ln -s /var/www/mediawiki/LocalSettings.php /var/www/w/LocalSettings.php && \
    ln -s /var/www/mediawiki/images /var/www/w/images

VOLUME ["/var/www/mediawiki", "/var/www/html", "/var/www/data"]

COPY start-mediawiki.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/start-mediawiki.sh

CMD ["start-mediawiki.sh"]
