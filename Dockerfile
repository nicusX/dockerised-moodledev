# Dockerfile for Moodle development on OS X
# Based on docker pull jauer/moodle by Jon Auer <jda@coldshore.com>
FROM ubuntu:15.04
MAINTAINER Lorenzo Nicora <lorenzo.nicoras@nicus.it>

VOLUME ["/var/moodledata", "/var/www/html"]
EXPOSE 80 443

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# This should be overridden on running moodle container
ENV MOODLE_URL http://192.168.99.100:8080

ADD ./foreground_apache2.sh /etc/apache2/foreground.sh

RUN apt-get update && \ 
	apt-get -u upgrade && \
	apt-get -y install mysql-client pwgen python-setuptools curl git unzip apache2 php5 \
		php5-gd libapache2-mod-php5 postfix wget supervisor php5-pgsql curl libcurl3 \
		libcurl3-dev php5-curl php5-xmlrpc php5-intl php5-mysql && \	
	chown -R www-data:www-data /var/www/html && \
	chmod +x /etc/apache2/foreground.sh

# Enable SSL, moodle requires it
RUN a2enmod ssl && a2ensite default-ssl # if using proxy, don't need actually secure connection

CMD ["/etc/apache2/foreground.sh"]	
