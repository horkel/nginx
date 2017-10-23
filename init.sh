wget http://nginx.org/download/nginx-1.12.2.tar.gz -O build/nginx-1.12.2.tar.gz
wget https://github.com/grahamedgecombe/nginx-ct/archive/v1.3.2.tar.gz -O build/nginx-ct-1.3.2.tar.gz
wget https://www.openssl.org/source/openssl-1.1.0f.tar.gz -O build/openssl-1.1.0f.tar.gz
wget https://github.com/openresty/echo-nginx-module/archive/v0.61.tar.gz -O build/echo-nginx-module-0.61.tar.gz
wget https://github.com/cloudflare/sslconfig/archive/master.zip -O build/sslconfig.zip

docker run -i -t -v ~/develop/projects/horkel/nginx/build:/build --name=build-nginx horkel/archlinux /bin/bash --login