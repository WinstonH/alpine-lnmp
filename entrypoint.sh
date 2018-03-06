#!/bin/sh
sudo php-fpm7
sudo nginx
sudo mariadb
sudo /usr/bin/supervisord -c /etc/supervisord.conf
exec "$@"
