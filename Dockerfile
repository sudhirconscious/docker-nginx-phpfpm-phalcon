#Set base image to Ubuntu
FROM ubuntu

#File Author
MAINTAINER Sudhir Bastakoti

#Install Nginx

#Update Repository
RUN apt-get update

# Install necessary tools
RUN apt-get install -y nano wget dialog net-tools

# Download and Install Nginx
RUN apt-get install -y git nginx nginx-extras php5-dev php5-fpm libpcre3-dev gcc make php5-mysql php5-curl

#Create root directory
RUN mkdir /var/www

#Clone Phalcon from Git and install 
RUN git clone --depth=1 http://github.com/phalcon/cphalcon.git
RUN cd cphalcon/build && ./install;

#Add Phalcon extension to ini
RUN echo 'extension=phalcon.so' >> /etc/php5/fpm/conf.d/30-phalcon.ini
RUN echo 'extension=phalcon.so' >> /etc/php5/cli/conf.d/30-phalcon.ini

#Remove default Nginx Configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

#Add site-available
ADD default /etc/nginx/sites-available/default
ADD default-ssl /etc/nginx/sites-enabled/default-ssl

#Add Server keys
ADD server.crt /etc/nginx/ssl/
ADD server.key /etc/nginx/ssl/

#Expose Ports
EXPOSE 80

# Set the default command to execute when creating a new container
CMD service php5-fpm start && nginx