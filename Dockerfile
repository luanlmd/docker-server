FROM ubuntu:16.04

#Basics
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install nano -y

#Apache and PHP
RUN apt-get install libapache2-mod-php7.0 -y
RUN a2enmod rewrite
RUN rm -Rf /var/www/html/
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/public/' /etc/apache2/sites-enabled/000-default.conf
EXPOSE 80

#Postgres
RUN apt-get install postgresql php7.0-pgsql -y
RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/9.5/main/postgresql.conf
RUN echo "host    all             all             0.0.0.0/0               trust" >> /etc/postgresql/9.5/main/pg_hba.conf
EXPOSE 5432

CMD /etc/init.d/postgresql start && apache2ctl start && /bin/bash
