# CentOS

> CentOS 常用配置与优化

## 基础配置

### DNS
	vi /etc/resolv.conf
	nameserver 8.8.8.8
	nameserver 180.76.76.76
	nameserver 114.114.114.114

### 时钟同步
	yum install ntp	
	ntpdate time.nist.gov

### 系统更新
	# 更新时不升级内核
	# 在 /etc/yum.conf 的 [main]后面添加
	exclude=kernel*
	exclude=centos-release*

### 内核管理

	# 查看当前内核版本
	uname -r
	 
	# 查询所有内核版本
	rpm -q kernel
	 
	# 删除某个内核版本
	rpm -e example

### epel 安装
	yum install epel-release
	yum install nload

## Rename 批量重命名

### CentOS Rename 不支持正则，需要使用 perl 版替换
	yum install perl-CPAN

### 安装 Rename.pl
	cpan
	cpan1> install File::Rename
	cpna2> exit

### 查看原版 Rename 位置
	whereis rename

### 软链文件
	ln -s /usr/local/bin/rename /usr/bin/rename.pl

### 测试修改文件
	shopt -s globstar; rename.pl -n 's/-/\!/g' **/*;

### 使用正则限制
	shopt -s globstar; rename.pl -n 's/-([a-z]+)/\!$1/g' **/*;

### 带尺寸的图片
	shopt -s globstar; rename.pl -n 's/-(\d+)-(\d+)/\!$1x$2/g' **/*;

### 确定修改文件，移除 -n
	shopt -s globstar; rename.pl 's/-/\!/g' **/*;
	
## NFS 网络文件系统

### 安装 NFS-Utils
	yum install -y nfs-utils
	
### Linux下挂载
	
	NFS 4.0 挂载根目录：sudo mount -t nfs -o vers=4 172.16.16.16:/ /localfolder

	NFS 4.0 挂载子目录：sudo mount -t nfs -o vers=4 172.16.16.16:/subfolder /localfolder 

	NFS 3.0 挂载子目录：sudo mount -t nfs -o vers=3,nolock,proto=tcp 172.16.16.16:/v7qikvgu /localfolder

	注，"localfolder" 指用户本地自己创建的目录； "subfolder" 指用户在 CFS 文件系统里创建的子目录
	
### Windows下挂载

	使用 FSID 挂载： mount 172.16.16.16:/v7qikvgu x: 

	注，"x：" 指用户需要挂载的盘符
	
### 生产环境实例

	# 临时挂载
	sudo mount -t nfs -o vers=4 172.16.16.16:/ /disk/www/assets.baohe.com
	
	# 批定权限
	chgrp -R nginx /disk/www/assets.baohe.com/
	chown -R nginx /disk/www/assets.baohe.com/

	# 自动挂载
	# 多服务器挂载，需要考虑读、写用户一致的属主属组（可参考 command.md 修改 nginx 用户和组ID）
	# 配置文件 /etc/php-fpm.d/www.conf 中的 user 和 group 参数建议与 nginx 保持一致
	echo '172.16.16.16:/ /disk/www/assets.baohe.com nfs  vers=4 0 0' >> /etc/fstab
	
### 文档说明
	https://cloud.tencent.com/document/product/582/11523

## CentOS 的 systemctl 服务

	systemctl enable [service] 					#开机运行服务
	systemctl disable [service] 				#取消开机运行
	systemctl start [service] 					#启动服务
	systemctl stop [service] 					#停止服务
	systemctl restart [service]					#重启服务
	systemctl reload [service] 					#重新加载服务配置文件
	systemctl status [service] 					#查询服务运行状态
	systemctl is-enabled [service] 				#查询是否开机启动
	systemctl --failed 							#显示启动失败的服务

## CentOS 格式化数据盘

### 输入命令 fdisk -l 查看您的数据盘信息

![](https://mc.qcloudimg.com/static/img/f26b5a092e1521556410afdc75a95474/image.png)

### 对数据盘进行分区。按照界面的提示，依次操作

1. 输入 **fdisk /dev/vdb** (对数据盘进行分区)，回车；
2. 输入 **n** (新建分区)，回车；
3. 输入 **p** (新建扩展分区)，回车；
4. 输入 **1** (使用第 1 个主分区)，回车；
5. 输入 **回车**(使用默认配置)；
6. 再次输入 **回车**(使用默认配置)；
7. 输入 **wq** (保存分区表)，回车开始分区

![](https://mc.qcloudimg.com/static/img/8a9c8ff4db5a7e4622bf2968d0309129/image.png)

### 使用fdisk -l命令，即可查看到，新的分区 vdb1 已经创建完成

![](https://mc.qcloudimg.com/static/img/304ccd9491f2a25b8d3b33b5213faa0e/image.png)

### 格式化数据盘

	# 新分区格式化
	mkfs.ext3 /dev/vdb1

	# 挂载分区
	mkdir /disk
	mount /dev/vdb1 /disk

	# 设置启动自动挂载
	echo '/dev/vdb1 /disk ext3 defaults 0 0' >> /etc/fstab

	# 将默认目录移动到数据盘
	mv /disk_/* /disk

## CentOS 安装 wget

	yum install wget

## CentOS 安装 Nginx

### 安装源

	wget http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

	rpm -ivh nginx*.rpm

### 安装命令

	yum remove httpd* php* 	#删除系统自带的软件包
	yum install nginx 		#安装nginx 根据提示输入y进行安装
	chkconfig nginx on 		#设置nginx开机启动
	service nginx start 	#启动nginx

## CentOS 安装 MySQL

### 1、安装 MySQL

	yum install mysql mysql-server 					#输入Y即可自动安装，直到安装完成
	/etc/init.d/mysqld start 						#启动MySQL
	chkconfig mysqld on 							#设为开机启动
	cp /usr/share/mysql/my-medium.cnf /etc/my.cnf 	#拷贝配置文件
	
### 2、为root账户设置密码

	mysql_secure_installation		#回车，根据提示输入Y，输入2次密码，回车，根据提示一路输入Y，最后出现：Thanks for using MySQL!	

## CentOS 安装 PHP5

### 1、安装PHP5和组件

	yum install -y php php-fpm php-mysql php-gd libjpeg* php-xml php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash php-opcache libmcrypt

	chkconfig php-fpm on 			#设置php-fpm开机启动

	/etc/init.d/php-fpm start		#启动php-fpm

### 2、配置 nginx 支持 php

	vi /etc/nginx/nginx.conf 				#编辑
	user nginx nginx; 						#修改nginx运行账号为：nginx组的nginx用户

	vi /etc/nginx/conf.d/default.conf 		#编辑

	index index.php index.html index.htm; 	#增加index.php
	# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
	location ~ \.php$ {
		root html;
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		include fastcgi_params;
	}

	# 取消 FastCGI server 部分 location 的注释,并要注意 fastcgi_param 行的参数，改为 $document_root$fastcgi_script_name，或者使用绝对路径

### 常用命令
	chown nginx.nginx /usr/share/nginx/html -R 	#设置权限
	service nginx restart 						#重启nginx
	service php-fpm restart 					#重启php-fpm

	/etc/init.d/mysqld restart 					#重启mysql
	/etc/init.d/mysqld stop 					#停止mysql
	/etc/init.d/mysqld start 					#启动mysql

### 邮件发送
	vi /etc/postfix/main.cf
	#inet_protocols = all
	inet_protocols = ipv4
	service postfix restart

## MariaDB 安装

1. 安装 MariaDB

	yum -y install mariadb mariadb-server

2. 开始运行 MariaDB

	systemctl start mariadb

3. 设置自动启动	
	
	systemctl enable mariadb

4. 进行 MariaDB 引导设置	
	
	mysql_secure_installation

## CentOS 7 安装 Mysql

1. 下载 mysql 的 repo 源

		wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

2. 安装 mysql-community-release-el7-5.noarch.rpm 包

		rpm -ivh mysql-community-release-el7-5.noarch.rpm

3. 安装 mysql

		yum install mysql-server


## CentOS 7 安装 Memcahce

1. yum 安装
	
		yum -y install memcached

2. Memcached 运行

		memcached -h
		memcached-tool  127.0.0.1:11211 stats

3. 扩展一下，安装PHP-memcache扩展，防火墙放开11211端口
	
		yum -y install php-pecl-memcache
	
		如果是PHP56版本的应该运行
		yum -y install php56w-pecl-memcache
	
		防火墙放开11211
		firewall-cmd --permanent --zone=public --add-port=11211/tcp
	
		检查端口是否开放
		echo stats | nc memcache_host_name_or_ip 11211
	
4. 配置安全的 Memcached

		vi /etc/sysconfig/memcached
		
		PORT="11211"
		USER="memcached"
		MAXCONN="1024"
		CACHESIZE="64"
		OPTIONS="-U 0"

## CentOS 7 安装 ImageMagick

1. 在 http://www.imagemagick.org/download/ 上找到合适的版本

    	wget http://www.imagemagick.org/download/ImageMagick-6.9.10-8.tar.gz

2. 解压刚才下载的文件

		tar xvf ImageMagick-6.9.10-8.tar.gz

3. 进入解压目录

		cd ImageMagick-6.9.10-8

4. 检查配置

		./configure
		# 如果发现没有安装jpeg（如下图），则必须先安装jpeg

5. 安装jpeg

		yum install libjpeg* libpng* freetype* gd*

6. 完成安装

		make install

## AWS EC2 配置 root 登录

一、在控制台的左边面板选择“实例”，再点击“启动实例”，在“选择一个Amazon系统镜像”步骤中，点击“AWS Marketplace”，再搜索centos，选择需要的版本，接下来一直continue即可，其中有一个步骤会生成一个密钥文件，这个很重要，保存好，直到完全启动一个实例。
二、在控制台左边面板中选择“弹性IP”，分配一个新地址，再在ip地址上右键“关联地址”，此时即可通过该IP访问实例。

### 先使用默认账户和密钥登录
	ssh centos@ip
	
### 设置root密码
	passwd root
	
### 切换到 root
	sudo root
	
### 配置 ssh
	vi /etc/ssh/sshd_config
	PermitRootLogin yes
	PasswordAuthentication yes
	
### 重启 ssh
	service sshd restart

## 参考链接

- [systemd.service 中文手册](http://www.jinbuguo.com/systemd/systemd.service.html)
- [AWS EC2启动Centos实例以及设置root密码登录](https://blog.csdn.net/hhhzua/article/details/79452875)
