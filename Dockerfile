FROM stesie/libv8-8.4 AS builder

ENV PHP_VERSION="8.0"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq --no-install-recommends install \
    php${PHP_VERSION} \
    php${PHP_VERSION}-dev \
    git ca-certificates g++ make && \
    update-alternatives --set phpize /usr/bin/phpize${PHP_VERSION} && \
    update-alternatives --set php /usr/bin/php${PHP_VERSION} && \
    update-alternatives --set php-config /usr/bin/php-config${PHP_VERSION}
