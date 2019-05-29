FROM php:7.2

ARG db_endpoint
ARG db_username
ARG db_password
ARG db_name
ARG db_port

ENV DEBIAN_FRONTEND noninteractive
ENV DB_ENDPOINT $db_endpoint
ENV DB_USERNAME $db_username
ENV DB_PASSWORD $db_password
ENV DB_NAME $db_name
ENV DB_PORT $db_port

WORKDIR /scripts
COPY scripts/install_composer.sh install_composer.sh

RUN apt-get update                                                                                                  \
    && apt-get upgrade -y                                                                                           \
    && apt-get install -y git zip unzip libzip-dev zlib1g-dev libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev \
                          libfreetype6-dev python3-setuptools python3-pip wget                                      \
                          --no-install-recommends

RUN docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir   \
        --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir   \
        --enable-gd-native-ttf                                              \
    &&docker-php-ext-install pdo pdo_mysql zip exif gd

RUN chmod +x install_composer.sh    \
    && ./install_composer.sh        \
    && rm install_composer.sh

RUN wget https://phar.phpunit.de/phpunit-6.5.phar   \
    && chmod +x phpunit-6.5.phar                    \
    && mv phpunit-6.5.phar /usr/sbin/phpunit

RUN pip3 install awscli

RUN apt-get clean                                       \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*