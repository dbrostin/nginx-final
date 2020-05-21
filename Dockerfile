FROM alpine:3.11
MAINTAINER Jordan Clark mail@jordanclark.us

# Install the need packages
RUN apk update && \
    apk add nginx && \
    adduser -D -g 'www' www && \
    mkdir /www && \
    mkdir /run/nginx && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /var/log/nginx && \
    chown -R www:www /www && \
    chown www:www /run/nginx && \
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

# Copy the index.html file to the web root in the container
COPY configs/nginx.conf /etc/nginx/nginx.conf

# Copy the index.html file to the web root in the container
COPY html/index.html /www/index.html

# Tell Docker that the service will be listening on port 8000
EXPOSE 8000

# Set the executing username to www
USER www

# /usr/sbin/nginx -g "daemon off;"
# Starts the web server
CMD ["/usr/sbin/nginx","-g","daemon off;"]
