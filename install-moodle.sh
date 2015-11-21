#!/bin/bash
# Set up Moodle in container

LANG=en
ADMINUSR=admin
ADMINPWD=Abcd1234$
SITENAME=Moodle26
SITESHORT=moodle26

docker exec -it -u www-data moodle /usr/bin/php  /var/www/html/admin/cli/install_database.php --agree-license --adminuser=${ADMINUSR} --adminpass=${ADMINPWD} --fullname=${SITENAME} --shortname=${SITESHORT} --lang=${LANG}
echo "Admin account: ${ADMINUSR}/${ADMINPWD}"
