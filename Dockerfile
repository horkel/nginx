## horkel/nginx
FROM horkel/archlinux:2019.09.26
MAINTAINER AlphaTr <alphatr@alphatr.com>

ADD build/nginx /usr/local/sbin/

EXPOSE 80 443

CMD ["nginx"]
