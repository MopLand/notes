# Web 环境搭建

## 安装nginx

### 删除系统自带的软件包

	yum remove httpd* php*

### 安装nginx 根据提示输入y进行安装

	yum install nginx

### 设置nginx开机启动

	chkconfig nginx on

### 启动nginx

	service nginx start

## 安装MySQL

### 1、安装MySQL

### 输入Y即可自动安装,直到安装完成

	yum install mysql mysql-server

### 启动MySQL

	/etc/init.d/mysqld start

### 设为开机启动

	chkconfig mysqld on

### 拷贝配置文件（注意：如果/etc目录下面默认有一个my.cnf，直接覆盖即可）

	cp /usr/share/mysql/my-medium.cnf /etc/my.cnf

### 2、设置密码

	mysql_secure_installation

### 3、操作命令

### 重启

	/etc/init.d/mysqld restart

### 停止

	/etc/init.d/mysqld stop

### 启动

	/etc/init.d/mysqld start

## 安装PHP5

### 1、安装PHP5

### 根据提示输入Y直到安装完成

	yum install php php-fpm

### 2、安装PHP组件，使 PHP5 支持 MySQL

### 这里选择以下安装包进行安装，根据提示输入Y回车

	yum install php-mysql php-gd libjpeg* php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash libmcrypt

### 设置php-fpm开机启动

	chkconfig php-fpm on

### 启动php-fpm
	
	/etc/init.d/php-fpm start 

## 配置nginx支持php

### 编辑

	# vi /etc/nginx/nginx.conf

	# 修改运行用户为 nginx
	user nginx nginx;

	# vi /etc/nginx/conf.d/default.conf

	index index.php index.html index.htm;

	# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
	#
	location ~ \.php$ {
		root html;
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		include fastcgi_params;
	}

### 重启nginx

	service nginx restart

## 配置php-fpm

### 编辑

	# vi /etc/php-fpm.d/www.conf
	
	# 修改用户为nginx	
	user = nginx
	
	# 修改组为nginx	
	group = nginx

##环境测试

	cd /usr/share/nginx/html

### 编辑文件

	# vi index.php
	<?php phpinfo();

### 设置权限

	chown nginx.nginx /usr/share/nginx/html -R

## 常用命令

### 重启nginx

	service nginx restart

### 重启php-fpm

	service php-fpm restart
