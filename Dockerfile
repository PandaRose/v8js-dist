FROM stesie/libv8-8.4 AS builder

ENV PHP_VERSION="7.4"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq --no-install-recommends install \
    php${PHP_VERSION} \
    php${PHP_VERSION}-dev \
    git ca-certificates g++ make && \
    update-alternatives --set phpize /usr/bin/phpize7.4 && \
    update-alternatives --set php /usr/bin/php7.4 && \
    update-alternatives --set php-config /usr/bin/php-config7.4

RUN git clone https://github.com/phpv8/v8js.git /usr/local/src/v8js
WORKDIR /usr/local/src/v8js

RUN phpize
RUN ./configure --with-v8js=/opt/libv8-8.4 LDFLAGS="-lstdc++" CPPFLAGS="-DV8_COMPRESS_POINTERS"
RUN make all -j4

RUN mkdir /root/dist && \
    cp /usr/local/src/v8js/modules/v8js.so /root/dist && \
    cp -r /opt/libv8-8.4 /root/dist && \
    cd /root && \
    tar -zcvf dist.tar.gz dist;

WORKDIR /root
