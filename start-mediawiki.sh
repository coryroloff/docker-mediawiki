#!/bin/bash

mkdir -p /var/www/mediawiki/images/lockdir
mkdir -p /var/www/mediawiki/images/deleted

if [[ ! -f "/var/www/mediawiki/skins" ]]; then
  mv /var/www/w/skins /var/www/mediawiki
  ln -s /var/www/mediawiki/skins /var/www/w/skins
fi

if [[ ! -f "/var/www/mediawiki/extensions" ]]; then
  mv /var/www/w/extensions /var/www/mediawiki
  ln -s /var/www/mediawiki/extensions /var/www/w/extensions
fi

chown -R www-data:www-data /var/www/mediawiki
chown -R www-data:www-data /var/www/html
chown -R www-data:www-data /var/www/data
chmod -R g+w /var/www/mediawiki/images
chmod -R g+w /var/www/data

if [[ -f "/var/www/mediawiki/LocalSettings.php" ]]; then
  rm -rf /var/www/w/mw-config
fi

exec apache2 -DFOREGROUND "$@"
