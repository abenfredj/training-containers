#!/bin/bash
echo "####  Prepare volumes for containers"
mkdir -p ~/data/db ~/data/wp

echo "------< HRapp pod creation > -----"
podman pod create --label tier=prod --name hrapp --publish 8092:80

echo '---------< Database mariadb 10.5 container provisioning -->'
echo 'Provisioning In progress'
podman run -d --pod hrapp --name db -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wpuserpass -e MYSQL_DATABASE=wpdb -v ~/data/db:/var/lib/mysql:Z mariadb:10.5
echo "Database it's up "
echo "------ < Wordpress Container Creation"
echo "--- please wait creation done"
podman run -d --pod hrapp  --name wpress -e WORDPRESS_DB_HOST=db -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=wpuserpass -e WORDPRESS_DB_NAME=wpdb -v ~/data/wp:/var/www/html:Z wordpress
echo "Your app it's up"

echo " published port:  8092"
