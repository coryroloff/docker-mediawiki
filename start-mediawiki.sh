#!/bin/bash

mkdir -p /var/www/mediawiki /var/www/mediawiki/images/lockdir /var/www/html /var/www/data

chown -R www-data:www-data /var/www/mediawiki /var/www/data
chmod -R g+w /var/www/mediawiki/images /var/www/data

if [[ -f "/var/www/mediawiki/LocalSettings.php" ]]; then
  rm -rf /var/www/w/mw-config
fi

exec apache2 -DFOREGROUND "$@"
