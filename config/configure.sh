#!/bin/sh

./configure --with-debug \
 --prefix=/usr/local/nginx \
 --with-pcre-jit \
 --with-http_geoip_module \
 --with-http_stub_status_module \
 --with-http_v2_module \
 --with-http_ssl_module \
 --with-http_realip_module \
 --with-http_addition_module \
 --with-http_sub_module \
 --with-http_gunzip_module \
 --with-http_gzip_static_module \
 --with-http_random_index_module \
 --with-http_secure_link_module \
 --with-stream \
 --with-stream_ssl_module \
 --without-stream_limit_conn_module \
 --without-stream_access_module \
 --add-module=../ngx_mruby/dependence/ngx_devel_kit

