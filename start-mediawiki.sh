#!/bin/bash

mkdir -p /data /data/images /var/www/html /var/www/data

chown www-data:www-data /data /var/www/data
chmod g+w /data/images /var/www/data

if [[ -f "/data/LocalSettings.php" ]]; then
  rm -rf /var/www/w/mw-config
fi

exec apache2 -DFOREGROUND "$@"
