FROM fedora:29

LABEL Damian Malikiah McCarthy

RUN echo "zchunk=false" >> /etc/dnf/dnf.conf

RUN dnf -y clean all && dnf -y update --releasever=29

RUN dnf -y install nginx git

#RUN dnf -y install policycoreutils-python-utils policycoreutils-python

RUN git clone https://github.com/Malikiah/kubernetes-resources.git

## SElinux Configuration
#RUN nginx
#RUN checkmodule -M -m kubernetes-resources/nginx/selinux_module/nginx.te -o nginx.mod

#RUN sestatus
#RUN setenforce 0
#RUN semodule_package -o nginx.pp -m nginx.mod
#RUN ls
#RUN semodule -i nginx.pp

## Nginx Configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN mv kubernetes-resources/nginx/conf.d/* /etc/nginx/conf.d

RUN rm -rf kubernetes-resources

RUN mkdir -p /var/www/html/cloud.malikiah.io/nextcloud && chown -R nginx:nginx /var/www/html/cloud.malikiah.io

RUN sed -i 's/types_hash_max_size 2048;/types_hash_max_size 4096;/' /etc/nginx/nginx.conf

RUN chown -R nginx:nginx /var/www/html

EXPOSE 80
CMD ["nginx"]