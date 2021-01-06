FROM debian:jessie
MAINTAINER ina

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update; \
    apt-get -y upgrade; \
    apt-get -y install sqlite3 php5-sqlite php5-gd php5-apcu python apache2 libapache2-mod-php5 php5-curl php5-memcached git libapache2-mod-fcgid git; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

RUN adduser --uid 1000 ina
RUN echo "Asia/Tokyo" > /etc/timezone
RUN dpkg-reconfigure tzdata
RUN a2enmod rewrite
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ports.conf /etc/apache2/ports.conf

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]



