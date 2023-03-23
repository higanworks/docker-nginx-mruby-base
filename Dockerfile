FROM alpine:3.17
ARG TARGETARCH=arm64
LABEL MAINTAINER=sawanoboriyu@higanworks.com

# https://github.com/cubicdaiya/nginx-build
ENV NGINX_BUILD=0.13.1
ENV NGINX_VER=1.23.3
ENV ZLIB_VERSION=1.2.13

RUN mkdir /usr/local/src /usr/local/share/GeoIP
ADD config /config

WORKDIR /usr/local/src
RUN apk add --update openssl-dev git curl geoip-dev file wget \
  && apk add --virtual build-deps build-base ruby-rake bison perl \
  && curl -L https://github.com/cubicdaiya/nginx-build/releases/download/v$NGINX_BUILD/nginx-build-linux-${TARGETARCH}-$NGINX_BUILD.tar.gz -o nginx-build.tar.gz \
  && tar xvzf nginx-build.tar.gz \
  && ./nginx-build -verbose -v $NGINX_VER -d work -pcre -zlib -zlibversion=$ZLIB_VERSION -m /config/modules3rd.json -c /config/configure.sh --clear \
  && cd work/nginx/$NGINX_VER/nginx-$NGINX_VER \
  && make install \
  && apk del build-deps \
  && mv ../ngx_mruby/mruby/bin/* /usr/local/bin/ \
  && rm -rf /var/cache/apk/* /usr/local/src/*

# RUN cd /usr/local/share/GeoIP \
#  && wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && gunzip GeoLiteCity.dat.gz \
#  && wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz && gunzip GeoIP.dat.gz

EXPOSE 8080
WORKDIR /usr/local/nginx
CMD ["/bin/sh"]
