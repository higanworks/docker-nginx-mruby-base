#!/bin/sh

set -xe

/bin/cp -f /config/mruby/build_config.rb ./
./configure --with-ngx-src-root=../nginx-$NGINX_VER

make build_mruby -j 2
make generate_gems_config -j 2
