FROM nginx:latest
# Install certbot
RUN echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list
RUN apt update
RUN apt -y upgrade
RUN apt install -y python-certbot-nginx
# Copy scripts
COPY app.conf /etc/nginx/conf.d/
COPY init.sh /
EXPOSE 80
EXPOSE 443
CMD ["/init.sh"]