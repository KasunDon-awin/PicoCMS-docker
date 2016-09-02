FROM php:5.6-apache

# Install Dependencies
RUN apt-get update && apt-get install -y git-core zlib1g-dev && \
    docker-php-ext-install zip

# Install S6
RUN curl -sL "https://github.com/just-containers/s6-overlay/releases/download/v1.16.0.0/s6-overlay-amd64.tar.gz" \
    | tar xz -C /

#Copy php.ini
COPY docker/config/php.ini /usr/local/etc/php/

#Services
COPY docker/s6/services.d /etc/services.d
COPY docker/s6/init.sh /etc/cont-init.d/init.sh

# Configure Apache
COPY docker/config/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite && \
a2enmod setenvif

# Permission
RUN usermod -aG root www-data

#Setting up composer
RUN mkdir -p /root/.composer/ && \
   curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN git clone https://github.com/picocms/Pico.git  /home/sites/picocms/

WORKDIR /home/sites/picocms/

RUN composer install

COPY  . /home/sites/picocms/

# Setup plugins
RUN bash docker/plugins/setup.sh

EXPOSE 80

CMD ["/init"]