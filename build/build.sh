#!/bin/bash

cd /build/

pacman -Sy --noconfirm
pacman -S tar wget grep git --noconfirm

# OpenSSL 支持
wget https://www.openssl.org/source/openssl-1.1.1c.tar.gz
tar -zxvf openssl-1.1.1c.tar.gz

# BROTLI 支持
git clone https://github.com/google/ngx_brotli.git nginx-brotli
cd nginx-brotli/
git submodule update --init
cd ..

# Nginx Echo 模块
wget https://github.com/openresty/echo-nginx-module/archive/v0.61.tar.gz -o echo-nginx-module-0.61.tar.gz
tar -zxvf echo-nginx-module-0.61.tar.gz

# Nginx
wget http://nginx.org/download/nginx-1.17.1.tar.gz
tar -zxvf nginx-1.17.1.tar.gz
cd nginx-1.17.1/

pacman -S gcc make --noconfirm
./configure \
    --prefix=/usr/local \
    --sbin-path=/usr/local/sbin/nginx \
    --conf-path=/docker/config/nginx/nginx.conf \
    --error-log-path=/docker/logs/nginx-error.log \
    --http-log-path=/docker/logs/nginx-access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/lock/nginx.lock \
    --http-client-body-temp-path=/var/tmp/nginx-client/ \
    --http-proxy-temp-path=/var/tmp/nginx-proxy/ \
    --http-fastcgi-temp-path=/var/tmp/nginx-fcgi/ \
    --http-scgi-temp-path=/var/tmp/nginx-scgi/ \
    --http-uwsgi-temp-path=/var/tmp/nginx-uwsgi/ \
    --with-threads \
    --with-file-aio \
    --with-pcre-jit \
    --with-http_realip_module \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_gzip_static_module \
    --with-http_v2_module \
    --with-openssl=../openssl-1.1.1c \
    --with-openssl-opt='enable-tls1_3 enable-weak-ssl-ciphers' \
    --add-module=../echo-nginx-module-0.61 \
    --add-module=../nginx-brotli

make
mv objs/nginx /build/
