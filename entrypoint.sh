#!/bin/sh
sudo php-fpm7
sudo nginx

sudo /usr/bin/supervisord -c /etc/supervisord.conf
exec "$@"
