## horkel/nginx
FROM horkel/archlinux:2017.11.22
MAINTAINER AlphaTr <alphatr@alphatr.com>

ADD build/nginx /usr/local/sbin/

EXPOSE 80 443

CMD ["nginx"]
