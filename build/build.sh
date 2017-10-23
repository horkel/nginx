#!/bin/bash

cd /build/

pacman -Syy --noconfirm
pacman -S patch tar unzip grep --noconfirm

# OpenSSL 支持，打补丁
tar -zxvf openssl-1.1.0f.tar.gz
unzip sslconfig.zip
cd openssl-1.1.0f
patch -p1 < ../sslconfig-master/patches/openssl__1.1.0_chacha20_poly1305.patch

# Nginx Certificate Transparency 支持，echo 模块
cd ..
tar -zxvf nginx-ct-1.3.2.tar.gz
tar -zxvf echo-nginx-module-0.61.tar.gz

tar -zxvf nginx-1.12.2.tar.gz
cd nginx-1.12.2/

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
    --with-openssl=../openssl-1.1.0f \
    --add-module=../echo-nginx-module-0.61 \
    --add-module=../nginx-ct-1.3.2

make
mv objs/nginx /build/
