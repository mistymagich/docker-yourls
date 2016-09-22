FROM php:7.0-apache

# prepare
RUN apt-get update
RUN apt-get install -y unzip

# install php extend module
RUN docker-php-ext-install pdo_mysql mysqli mbstring

# enable rewrite module
RUN a2enmod rewrite

# install yourls
RUN curl -Ls -o /tmp/yourls.zip https://github.com/YOURLS/YOURLS/archive/1.7.1.zip && \
    unzip -d /tmp /tmp/yourls.zip && \
    mv /tmp/YOURLS-1.7.1/* /var/www/html && \
    rm /tmp/yourls.zip

# .htaccess
COPY .htaccess /var/www/html/.htaccess

# config
WORKDIR /var/www/html/user
RUN cp /var/www/html/user/config-sample.php config.php
RUN sed -i -e "s/'YOURLS_DB_USER', 'your db user name'/'YOURLS_DB_USER', getenv('YOURLS_DB_USER')/" config.php && \
    sed -i -e "s/'YOURLS_DB_PASS', 'your db password'/'YOURLS_DB_PASS', getenv('YOURLS_DB_PASS')/" config.php && \
    sed -i -e "s/'YOURLS_DB_NAME', 'yourls'/'YOURLS_DB_NAME', getenv('YOURLS_DB_NAME')/" config.php && \
    sed -i -e "s/'YOURLS_DB_HOST', 'localhost'/'YOURLS_DB_HOST', getenv('YOURLS_DB_HOST')/" config.php && \
    sed -i -e "s#'YOURLS_SITE', 'http://your-own-domain-here.com'#'YOURLS_SITE', getenv('YOURLS_SITE')#" config.php && \
    sed -i -e "s/'username' => 'password'/getenv('YOURLS_USERNAME') => getenv('YOURLS_PASSWORD')/" config.php

# [Username Passwords · YOURLS/YOURLS Wiki](https://github.com/YOURLS/YOURLS/wiki/Username-Passwords#i-have-an-error-message-could-not-auto-encrypt-passwords)
RUN chmod 0666 config.php

# install Random Keywords plugin
RUN curl -Ls -o /tmp/random-keywords.zip https://github.com/YOURLS/random-keywords/archive/master.zip && \
    unzip -d /tmp /tmp/random-keywords.zip && \
    mv /tmp/random-keywords-master plugins/andom-keywords

# install Hide Referrer plugin
RUN curl -Ls -o /tmp/yourls-hide-referrer.zip https://github.com/Sire/yourls-hide-referrer/archive/master.zip && \
    unzip -d /tmp /tmp/yourls-hide-referrer.zip && \
    mv /tmp/yourls-hide-referrer-master plugins/yourls-hide-referrer


# clean
RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
