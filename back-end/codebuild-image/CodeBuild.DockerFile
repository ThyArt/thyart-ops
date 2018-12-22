FROM php:7.2

ENV DEBIAN_FRONTEND noninteractive

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer\
  && php -r "unlink('composer-setup.php');"

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y mysql-server mysql-client git zip unzip zlib1g-dev --no-install-recommends \
  && docker-php-ext-install pdo pdo_mysql zip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN service mysql start \
  && mysql -u root -e "use mysql; update user set plugin='' where User='root'; flush privileges;"