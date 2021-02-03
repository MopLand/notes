# Security

## 安全更新

	# RHSA-2017:1372: kernel security and bug fix update (Moderate)
	yum update kernel
	yum update kernel-firmware
	yum update kernel-devel
	yum update kernel-headers
	yum update kernel-tools
	yum update kernel-tools-libs
	
	# RHSA-2016:2674: libgcrypt security update (Moderate)
	yum update libgcrypt
	yum update python-perf
	
	# RHSA-2015:2550: libxml2 security update (Moderate)
	yum update libxml2
	
	# RHSA-2016:2587: wget security and bug fix update (Moderate)
	yum update wget
	
	# CVE-2021-3156: Heap-Based Buffer Overflow in Sudo (Baron Samedit)
	yum update sudo
	
	# glibc security update (Important)
	yum update glibc
	yum update glibc-common
	yum update glibc-devel
	yum update glibc-headers
	
	# RHSA-2017:0641: openssh security and bug fix update (Moderate)
	yum update openssh
	yum update openssh-clients
	yum update openssh-server
	
	# RHSA-2017:0286: openssl security update (Moderate)
	yum update openssl
	yum update openssl-devel
	
	# RHSA-2016:2972: vim security update (Moderate)
	yum update vim-filesystem
	yum update vim-minimal
	
	# RHSA-2017:1100: nss and nss-util security update (Critical)
	yum update nss-util
	yum update nss
	yum update nss-sysinit
	yum update nss-tools

## 独立用户

### Web 用户
	useradd -d /disk/www -s /sbin/nologin www

### Nginx
	vi /etc/nginx/nginx.conf
	
	# 指定用户
	user nginx;

	# 隐藏版本号
	server_tokens off;

	# CVE-2017-7529
	max_ranges 1;

### PHP-FPM
	vi /etc/php-fpm.d/www.conf
	
	user = nginx
	group = nginx

### 只读权限
	chmod -R 544 /disk/www
	chgrp -R nginx /disk/www
	chown -R nginx /disk/www

### 可写权限
	chmod -R 744 /disk/www/example

## 安全选项
	vi /etc/sysctl.conf
	```
	net.ipv4.tcp_syncookies = 0    #洪水攻击防范
	net.ipv4.tcp_wmem = 4096 87380 4161536   #tcp发送缓存区
	net.ipv4.tcp_rmem = 4096 87380 4161536   #tcp读取缓冲区
	net.ipv4.tcp_mem = 786432 2097152 2145728   #tcp内存大小  low,pressure,high   (tcp不考虑释放,tcp试图稳定内存值,最高值超过拒绝分配内存)
	net.ipv4.ip_local_port_range = 1024 65534  #随机端口范围
	net.ipv4.tcp_tw_recycle = 1  #tcp回收
	net.ipv4.tcp_tw_reuse   = 1  #tcp复用
	net.core.somaxconn   = 65535 #每一个端口最大的监听队列的长度

## PHP
	# 将用户可操作的文件限制在某目录下（使用后性能会下降）
	open_basedir = /disk/www/

----------

## iptables

### 限制每次Nginx连接数
	iptables -A INPUT -p tcp –dport 80 -i eth0 -m state –state NEW -m recent –set
	iptables -A INPUT -p tcp –dport 80 -i eth0 -m state –state NEW -m recent –update –seconds 60  –hitcount 15 -j DROP

## 图片策略

### 图片防盗链

	# Stop deep linking or hot linking
	location /images/ {
		valid_referers none blocked www.example.com example.com;
		if ($invalid_referer) {
			return   403;
		}
	}

### 重定向并显示指定图片
	valid_referers blocked www.example.com example.com;
	if ($invalid_referer) {
		rewrite ^/images/uploads.*\.(gif|jpg|jpeg|png)$ http://www.examples.com/banned.jpg last
	}

## Nginx

### 指定每个给定键值的最大同时连接数，当超过这个数字时被返回503
	limit_conn_zone $binary_remote_addr zone=addr:10m;
	server {
	    location /www.ttlsa.com/ {
	        limit_conn addr 1;
	    }
	}

### 限制单一IP来源的连接数，同时也会限制单一虚拟服务器的总连接数
	limit_conn_zone $binary_remote_addr zone=perip:10m;
	limit_conn_zone $server_name zone=perserver:10m;
	server {
	    limit_conn perip 10;
	    limit_conn perserver 100;
	}

### 限制平均每秒不超过一个请求，同时允许超过频率限制的请求数不多于5个
	limit_req_zone $binary_remote_addr zone=ttlsa_com:10m rate=1r/s;
	server {
	    location /www.ttlsa.com/ {
	        limit_req zone=ttlsa_com burst=5;
	    }
	}

### 如果不希望超过的请求被延迟，可以用nodelay参数
	limit_req zone=ttlsa_com burst=5 nodelay;

### 限速白名单配置
	http {
		geo $whiteiplist  {
			default 1;
			127.0.0.1 0;
			10.0.0.0/8 0;
			121.207.242.0/24 0;
		}
		
		map $whiteiplist  $limit {
			1 $binary_remote_addr;
			0 "";
		}
		
		limit_conn_zone $limit zone=limit:10m;
		
		server {
		    listen       8080;
		    server_name  test.ttlsa.com;
		
		    location ^~ /ttlsa.com/ {
		            limit_conn limit 4;
		            limit_rate 200k;
		            alias /data/www.ttlsa.com/data/download/;
		    }
		}
	}

	1. geo指令定义一个白名单$whiteiplist, 默认值为1, 所有都受限制。 如果客户端IP与白名单列出的IP相匹配，则$whiteiplist值为0也就是不受限制。
	2. map指令是将$whiteiplist值为1的，也就是受限制的IP，映射为客户端IP。将$whiteiplist值为0的，也就是白名单IP，映射为空的字符串。
	3. limit_conn_zone和limit_req_zone指令对于键为空值的将会被忽略，从而实现对于列出来的IP不做限制。

	测试方法
	ab -c 100 -n 300 http://test.ttlsa.com:8080/ttlsa.com/docs/pdf/nginx_guide.pdf

### 禁止IP的访问
	deny 10.0.0.0/24;

### 禁用访问某一目录
	location ^~ /path {
		deny all; 
	}

### 禁止php文件的访问及执行

#### 示例：去掉单个目录的PHP执行权限
	location ~ /attachments/.*\.(php|php5)?$ {
		deny all; 
	}

#### 示例：去掉多个目录的PHP执行权限	
	location ~ /(attachments|upload)/.*\.(php|php5)?$ {
		deny all; 
	}

### 在配置文件中设置自定义缓存以限制缓冲区溢出攻击的可能性
	client_body_buffer_size 1K;
	client_header_buffer_size 1k;
	client_max_body_size 1k;
	large_client_header_buffers 2 1k;

### 将timeout设低来防止DOS攻击
	client_body_timeout 10;
	client_header_timeout 10;
	keepalive_timeout 5 5;
	send_timeout 10;

### 限制用户连接数来预防DOS攻击
	limit_zone slimits $binary_remote_addr 5m;
	limit_conn slimits 5;

----------

## DNS

### 对 IP 源无要求（优先考虑）

	使用 百度云 加速等 CDN 产品来隐藏真实 IP

### 对 IP 源有要求

	使用 负载均衡 来隐藏真实 IP，负载均衡可以比较快的部署

### 第三方域名绑定

	提供 CNAME 域名来完成接入