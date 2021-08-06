
FROM centos:latest

MAINTAINER admin@veryide.com
ENV TIME_ZOME Asia/Shanghai

# 安装必要软件
RUN yum install nginx -y
RUN yum install php php-fpm php-xml php-curl -y
RUN yum install git -y

# 复制配置文件
COPY fastcgi_params /etc/nginx/
COPY phpcgi.conf /etc/nginx/default.d/phpcgi.conf

# 更新配置文件
RUN mkdir -p /run/php-fpm
RUN sed -i 's@;date.timezone =@date.timezone = Asia/Shanghai@g' /etc/php.ini

# 从仓库拉代码
ARG CACHEBUST=1
RUN mkdir /www && cd /www && git clone https://github.com/TouloMin/abc.git --depth 1 "./"
RUN mv /www/* /usr/share/nginx/html

EXPOSE 80
CMD php-fpm && nginx -g "daemon off;"