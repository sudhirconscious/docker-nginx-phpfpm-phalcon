# docker-nginx-phpfpm-phalcon
Dockerfile for Phalcon using PHP-FPM in Nginx

Command to run the container

`docker run -d -v /path/to/your/code:/var/www -e "WEBPUBLIC=public" -p 8888:80 nginx-phpfpm-phalcon;`
