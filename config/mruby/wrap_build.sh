#!/bin/sh

set -xe

/bin/cp -f /config/mruby/build_config.rb ./
./configure --with-ngx-src-root=../nginx-$NGINX_VER

make build_mruby
make generate_gems_config

