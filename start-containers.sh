#!/bin/bash
# Start containers

DOCKERMACHINE_IP=`docker-machine ip default`
MOODLEDEVDIR=`pwd`/moodle
PGPORT=32768
MOODLEPORT=8080

cp moodle-config.php ${MOODLEDEVDIR}/config.php


docker run -d --name moodledb -e POSTGRES_USER=moodle -e POSTGRES_PASSWORD=secret -p=${PGPORT}:5432 postgres
docker run -d -P --name moodle -p 8080:80 -v ${MOODLEDEVDIR}:/var/www/html --link moodledb:DB -e MOODLE_URL=http://${DOCKERMACHINE_IP}:${MOODLEPORT} nicus/moodle-dev

echo "To connect to PostgreSQL: host:port=${DOCKERMACHINE_IP}:${PGPORT}, dbuser=moodle, dbpwd=secret"
echo "To access Moodle: http://${DOCKERMACHINE_IP}:${MOODLEPORT}"
echo "To enter shell in moodle container shell: docker exec -it moodle bash"
echo "To install moodle: install-moodle.sh"
