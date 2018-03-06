#!/bin/sh
sudo php-fpm7
sudo nginx
# 更新mysql配置
mysql_install_db --user=mysql --datadir=${DB_DATA_PATH} 
mysqld
mysqladmin -u root password "${DB_ROOT_PASS}" \
&& echo "GRANT ALL ON *.* TO ${DB_USER}@'127.0.0.1' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;" > /tmp/sql \
&& echo "GRANT ALL ON *.* TO ${DB_USER}@'localhost' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;" >> /tmp/sql \
&& echo "GRANT ALL ON *.* TO ${DB_USER}@'::1' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;" >> /tmp/sql \
&& echo "DELETE FROM mysql.user WHERE User='';" >> /tmp/sql \
&& echo "DROP DATABASE test;" >> /tmp/sql \
&& echo "FLUSH PRIVILEGES;" >> /tmp/sql \
&& cat /tmp/sql | mysql -u root --password="${DB_ROOT_PASS}"
sudo /usr/bin/supervisord -c /etc/supervisord.conf
exec "$@"
