FROM base/archlinux:2015.06.01
MAINTAINER sawanoboriyu@higanworks.com

RUN pacman -S openssl wget git make ruby hiredis libcap bison \
 autoconf gcc \
 pcre2 geoip curl markdown libmariadbclient \
 -yy --noconfirm \
&& rm -rf /var/lib/pacman/local/* /var/cache/pacman /tmp/* /var/tmp/*

WORKDIR /usr/local/src
RUN git clone -b using https://github.com/higanworks/ngx_mruby.git --depth 1
RUN wget http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz \
&& tar xvzf ngx_cache_purge-2.3.tar.gz

ENV NGINX_SRC_VER=nginx-1.9.10
ENV NGINX_CONFIG_OPT_ENV --with-debug --with-http_geoip_module --with-http_v2_module --with-http_stub_status_module --with-http_ssl_module --prefix=/usr/local/nginx --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --add-module=/usr/local/src/ngx_cache_purge-2.3

RUN mkdir -p /usr/local/share/GeoIP
WORKDIR /usr/local/share/GeoIP
RUN wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && gunzip GeoLiteCity.dat.gz
RUN wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz && gunzip GeoIP.dat.gz

WORKDIR /usr/local/src/ngx_mruby
RUN bash -x build.sh && make install \
&& make clean && rm -rf /usr/local/src/*

EXPOSE 8080
CMD ["/bin/bash"]
