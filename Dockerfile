FROM ubuntu:14.04
MAINTAINER sawanoboriyu@higanworks.com

RUN apt-get -y update
RUN apt-get -y install autoconf build-essential git curl wget \
               bison libcurl4-openssl-dev libhiredis-dev libmarkdown2-dev libcap-dev libcgroup-dev libpcre3 libpcre3-dev libmysqlclient-dev
RUN apt-get -y build-dep nginx openssl

RUN apt-get -y install rake
WORKDIR /usr/local/src
RUN git clone -b v1.14.15 https://github.com/higanworks/ngx_mruby.git --depth 1
RUN wget http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz
RUN tar xvzf ngx_cache_purge-2.3.tar.gz

ENV NGINX_SRC_VER nginx-1.9.5
ENV NGINX_CONFIG_OPT_ENV --with-debug --with-http_v2_module --with-http_stub_status_module --with-http_ssl_module --prefix=/usr/local/nginx --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --add-module=/usr/local/src/ngx_cache_purge-2.3

WORKDIR /usr/local/src/ngx_mruby
RUN bash -x build.sh && make install

EXPOSE 8080
CMD ["/bin/bash"]
