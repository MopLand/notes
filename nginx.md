# Nginx

## 必要配置

### 配置 PHP.ini
	cgi.fix_pathinfo=1

### 配置 Nginx
	# 将 nginx-1.6.3.zip 解压后，配置 nginx-1.6.3/conf/nginx.conf 

	# 增加多站点配置
	include /etc/nginx/sites/*;

### 虚拟主机

	# 关闭访问日志
	access_log off;

	# 禁用错误日志
	# 注意这样并不能关闭日志记录功能，它将日志文件写入一个文件名为 nginx/off 的文件中
	error_log off;

	# 关闭错误日志
	error_log /dev/null crit;

	# PHP 解析配置
	location ~ \.php$ {
		root           html;
		fastcgi_pass   127.0.0.1:9000;
		fastcgi_index  index.php;
		fastcgi_read_timeout 150;

		# 特别注意这里，SCRIPT_FILENAME 非常重要
		fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
		include        fastcgi_params;
    }

	# 禁止GIT或SVN目录输出
	location ~ /\.(git|svn) {
		deny all;
	}
	
	# 禁止任务脚本输出
	location ~* /cron/.*\.(js|json|sql|sh|md)$ {
		deny all;
	}
	
	# 禁止证书文件输出
	location ~* \.(p12|pem|key|crt|sql|md|gitignore|htaccess)$ {
		deny all;
	}

	# 直接输出静态文件
	if ( $request_uri ~ ^/static ) {
		rewrite ^/(.*)$ /$1 last;
	}

	# 域名所有权验证服务
	# 图片缩略图生成服务
	# 不存在的静态文件直接抛出 404
	# 将路由交由 index.php 处理
	if (!-e $request_filename) {
		rewrite ^/(.+).txt$ /fn/verify/$1;
		rewrite ^/attach/(.+)!(.+).(gif|jpg|jpeg|png)$ /fn/resized?file=$1&size=$2&mime=$3;
		rewrite ^/(.*\.(ico|gif|jpg|jpeg|png|swf|flv|css|js)$) 404;
		rewrite ^/(.*) /index.php/$1 last;
	}

	# 将静态文件缓存7天，并允许跨域
	location ~ \.(js|css|webp|jpg|jpeg|png|gif|swf|ttf|otf|eot|svg|woff|woff2)$ {
		expires 7d;
		add_header "Access-Control-Allow-Origin" "*";
	}

## 相关命令
	
### 启动 PHP-CGI
	php-cgi.exe -b 127.0.0.1:9000 -c D:/wnmp/www/php/php.ini

### 启动 Nginx
	nginx.exe
	
### 查看日志
	tail -f /var/log/nginx/error.log

## 虚拟主机

### nginx.conf
	
	include D:/EasyPHP/eds-binaries/httpserver/nginx-1.6.3/vhost/*.conf;
	
### vhost/*.conf

	server {
		listen 88;
		server_name www.tps.dev;
		root /Works/TPS/;
		index index.htm index.html index.php;
		
		include phpfpm.conf;

		if ($http_host != 'www.example.com') {
			rewrite (.*)  http://www.example.com$1 permanent;
			return 301;
		}
		
		location / {
	        proxy_read_timeout 150;
	    }

		location ~* /cron/.*\.(js|json|sql|sh|md)$ {
			deny all;
		}
	
		if (!-e $request_filename) {
	        rewrite ^/(.*\.(ico|gif|jpg|jpeg|png|swf|flv|css|js)$) 404;        
	  	    rewrite ^/(.*) /index.php/$1 last;
		}
	
		location ~ \.(js|css|webp|jpg|jpeg|png|gif|swf|ttf|otf|eot|svg|woff|woff2)$ {
			expires 7d;
			add_header "Access-Control-Allow-Origin" "*";
		}
	
	}

### fastcgi_params

	fastcgi_param  REQUEST_URI        $request_uri;
	fastcgi_param  DOCUMENT_URI       $document_uri;
	fastcgi_param  DOCUMENT_ROOT      $document_root;
	fastcgi_param  SERVER_PROTOCOL    $server_protocol;

	# 非常重要
	fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;
	fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;


### phpfpm.conf

	location ~ ^(.+\.php)(.*)$ {

		fastcgi_pass_request_body off;
		
		#client_body_temp_path temp/client_body_temp;
		#client_body_in_file_only clean;
		#client_max_body_size 20m;

		fastcgi_param REQUEST_BODY_FILE $request_body_file;
		
		# 非常重要，伪静态必需
		fastcgi_split_path_info ^(.+\.php)(.*)$;
		fastcgi_param PATH_INFO $fastcgi_path_info;
		
		# 监听方式，二选一
		fastcgi_pass 127.0.0.1:9000;
		#fastcgi_pass unix:/dev/shm/php-cgi.sock;

		# 读取超时
		fastcgi_read_timeout 300;
		
		fastcgi_index index.php;
		
		include fastcgi_params;
		
	}

## 正向代理

	# 代理阿里图片
	server {
		listen 80;
		server_name proxy.yqt.so;
		access_log off;
		location / {
			resolver 1.1.1.1 8.8.8.8;
			proxy_pass $scheme://img.alicdn.com$request_uri;
			proxy_buffers   32 256k;
			expires			7d;
		}
	}
	
	# 代理任意资源
	server {
		listen 80;
		server_name proxy.yqt.so proxy.zhfile.com;
		access_log off;
		location / {
			resolver 1.1.1.1 8.8.8.8;
			
			proxy_pass $scheme:/$request_uri;
			
			#if ( $request_uri ~* "qpic.cn" ) {
				proxy_set_header referer "https://mp.weixin.qq.com/";
			#}
			
			#return 200 $request_uri;
			
			proxy_buffers   32 256k;
			expires			7d;
		}		
	}
	
	# 代理任意资源
	server {
		listen 80;
		server_name proxy.yqt.so proxy.zhfile.com;
		access_log off;
		location / {
			resolver 1.1.1.1 8.8.8.8;
			
			proxy_pass $scheme:/$request_uri;
			
			#if ( $request_uri ~* "qpic.cn" ) {
				proxy_set_header referer "https://mp.weixin.qq.com/";
			#}
			
			#return 200 $request_uri;
			
			proxy_buffers   32 256k;
			expires			7d;
		}
	}
	
	# 本地缓存资源
	proxy_cache_path /disk/cache levels=1:2 keys_zone=imgcache:10m max_size=10g inactive=60m use_temp_path=off;

	server {
		listen 80;
		server_name proxy.yqt.so proxy.zhfile.com;
		access_log off;
		
		location / {
			resolver 114.114.114.114 8.8.8.8;
			
			proxy_set_header referer "https://mp.weixin.qq.com/";
			proxy_cache imgcache;
			proxy_pass $scheme:/$request_uri;
			proxy_buffers   64 256k;

			expires			7d;
		}
		
		location ~* "cnblogs" {
			resolver 114.114.114.114 8.8.8.8;
			
			proxy_set_header referer "https://www.cnblogs.com/";
			proxy_cache imgcache;
			proxy_pass https:/$request_uri;
			proxy_buffers   64 256k;

			expires			7d;
		}
		
	}

	# 参考链接
	https://www.jianshu.com/p/625c2b15dad5

## 反向代理

	# 转发 Node
	server {
		listen 80;
		server_name chat.veryide.com;
		location / {
			add_header Access-Control-Allow-Origin *;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			proxy_read_timeout 150;
	        proxy_pass http://127.0.0.1:3000;    
	    } 
	}

## 负载均衡

### 基本格式

	# 上游配置
	upstream backend {
		#ip_hash;
		server 192.168.1.251;
		server 192.168.1.247:900;
		server 192.168.1.247:900 weight=10;
	}

	# 主机配置
	server {
		listen       80;
		server_name  2;
		location / {

			#设置主机头和客户端真实地址，以便服务器获取客户端真实IP
			proxy_set_header Host $host;
			proxy_set_header X-Real-IP $remote_addr;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

			#禁用缓存
			proxy_buffering off;

			#反向代理的地址
			proxy_pass http://backend;

		}
	}

### 分配方式

#### 1. 轮询

	轮询是 upstream 的默认分配方式，即每个请求按照时间顺序轮流分配到不同的后端服务器，如果某个后端服务器down掉后，能自动剔除
	upstream backend {
		server 192.168.1.101:8888;
		server 192.168.1.102:8888;
		server 192.168.1.103:8888;
	}
	
#### 2. weight

	# 轮询的加强版，即可以指定轮询比率，weight和访问几率成正比，主要应用于后端服务器异质的场景下
	upstream backend {
		server 192.168.1.101 weight=1;
		server 192.168.1.102 weight=2;
		server 192.168.1.103 weight=3;
	}
	
#### 3. ip_hash

	# 每个请求按照访问ip（即Nginx的前置服务器或者客户端IP）的hash结果分配，这样每个访客会固定访问一个后端服务器，可以解决session一致问题
	upstream backend {
		ip_hash;
		server 192.168.1.101:7777;
		server 192.168.1.102:8888;
		server 192.168.1.103:9999;
	}
	
#### 4. fair

	# fair 顾名思义，公平地按照后端服务器的响应时间（rt）来分配请求，响应时间短即rt小的后端服务器优先分配请求
	upstream backend {
		server 192.168.1.101;
		server 192.168.1.102;
		server 192.168.1.103;
		fair;
	}
	
#### 5. url_hash

	# 与ip_hash类似，但是按照访问url的hash结果来分配请求，使得每个url定向到同一个后端服务器，主要应用于后端服务器为缓存时的场景下
	upstream backend {
		server 192.168.1.101;
		server 192.168.1.102;
		server 192.168.1.103;
		hash $request_uri;
		hash_method crc32;
	}
	# 其中，hash_method为使用的hash算法，需要注意的是：此时，server语句中不能加weight等参数
	
### upstream 设备状态值

1. down 表示单前的 server 暂时不参与负载

2. weight 默认为1，weight 越大，负载的权重就越大

3. max_fails 允许请求失败的次数默认为1。当超过最大次数时，返回 proxy_next_upstream 模块定义的错误

4. fail_timeout max_fails 次失败后，暂停的时间

5. backup 其它所有的非backup机器down或者忙的时候，请求backup机器。所以这台机器压力会最轻

## 特殊应用

### 跨域访问

	add_header "Access-Control-Allow-Origin" "*" "always";

### 忽略请求正文（可以针对静态文件开启）

	fastcgi_pass_request_body off;

### plist 文件显示

	location ~* \.plist$ {
		add_header Content-Type text/plain;
	}

### 301 重定向

	server {
	
		listen 80;
		server_name mirror.example.net mirror.example.com;
		root /disk/www/domain.example.com;
		error_page 500 502 503 504 =200 /public/errors/server_error.html;
		index index.htm index.html index.php;
	
		if ($http_host != 'mirror.example.com') {
			rewrite (.*)  http://mirror.example.com$1 permanent;
			return 301;
		}

		# 处理特殊请求
		if ($http_APPID = '1608021601467185'){
			return 204;
		}
	
	}

### 前端路由

	server {

		listen 80;
		server_name example.com www.example.com;
		root /disk/www/new.ccy.com/;
		index index.htm index.html;
		
		location / {
			try_files $uri $uri/ /index.html;
		}
	
	}

### HTTP 转向 HTTPS

	server {  
		listen 80;  
		server_name example.com;
		rewrite ^(.*)$  https://$host$1 permanent;
	}

### SSL 配置
	
	# 注意 iptables 中需要允许 443 端口
	server {
		listen 443;
		server_name example.com;
		root /disk/www/example.com;
		index index.htm index.html index.php;
		
		# 启动 ssl
		ssl on;
		ssl_certificate /disk/certs/example.com.crt;
		ssl_certificate_key /disk/certs/example.com.key;
	
		# error_page 404 = http://www.example.com/misc.php?action=404;
		include phpcgi.conf;
	
		if ($http_host != 'example.com') {
		#	rewrite (.*)  http://t.hgbang.com$1 permanent;
		#	return 301;
		}
		
		location ~ \.php$ {
			fastcgi_index index.php;
			include fastcgi_params;
			# fastcgi https 参数
			fastcgi_param HTTPS on;
			fastcgi_param HTTP_SCHEME $scheme;
		}
	
	}

### Auth_Basic 认证

	# htpasswd 文件生成

	printf "newbie:$(openssl passwd -crypt 123456)\n" >> /disk/certs/htpasswd

	printf "username:$(openssl passwd -crypt 123456):comment\n" >> /disk/certs/htpasswd

	# 站点配置
	server {

	    server 80;
	
	    auth_basic on;
		#auth_basic "nginx basic http test for example.com";
	    auth_basic_user_file /disk/certs/htpasswd;
	
	    location / {
	        proxy_pass http://127.0.0.1:3000;
	    }
	}

### 泛域名处理

	server {
	    listen       80;
	    server_name ~^(\d+)\.example\.com$;
	    root /disk/www/agent.shz.com;
	    index  index.html index.php index.htm;
	    
	    include phpcgi.conf;
	    
	    #
	    if ($host ~* (\d+)\.example\.com) {
			return 301 http://rj.example.com/trade/$1;
		}
	}

### 自定义 HTTP 变量

	server {
		listen 80 default_server;
		server_name ~^([a-z0-9]+)\.mirror\.example\.com$;
		root /disk/www/domain.shz.com;
		index index.htm index.html index.php;
		
		set $sub_domain "";
		if ($host ~* (.*)\.mirror\.example\.com) {
			set $sub_domain $1;		
		}
		
		location ~ ^(.+\.php)(.*)$ {
			
			fastcgi_param HTTP_SERVE "Nginx";
			fastcgi_param HTTP_APPID $sub_domain;
			
			fastcgi_split_path_info ^(.+\.php)(.*)$;
			fastcgi_param PATH_INFO $fastcgi_path_info;	
			fastcgi_pass 127.0.0.1:9000;
			fastcgi_read_timeout 150;
			fastcgi_index index.php;
			
			include fastcgi_params;
		}
	
		if (!-e $request_filename) {
			rewrite ^/(.*\.(ico|gif|jpg|jpeg|png|swf|flv|css|js)$) 404;
			rewrite ^/root\.txt /api/ckroot;
			rewrite ^/(.*) /index.php/$1 last;
		}
	
	}

## Windows 环境安装

### RunHiddenConsole

	将 RunHiddenConsole.exe 复制到 C:/Windows，用于 bat 处理时隐藏窗口

### 制作 BAT 文件

> start_nginx.bat

	@echo off
	REM Windows 下无效
	REM set PHP_FCGI_CHILDREN=5
	
	REM 每个进程处理的最大请求数，或设置为 Windows 环境变量
	set PHP_FCGI_MAX_REQUESTS=1000
	 
	echo Starting PHP FastCGI...
	RunHiddenConsole D:/EasyPHP/php5619vc11/php-cgi.exe -b 127.0.0.1:9000 -c D:\EasyPHP\php5619vc11\php.ini
	 
	echo Starting Nginx...
	RunHiddenConsole D:/EasyPHP/httpserver/nginx-1.6.3/nginx.exe

> stop_nginx.bat

	@echo off
	echo Stopping nginx... 
	taskkill /F /IM nginx.exe > nul
	echo Stopping PHP FastCGI...
	taskkill /F /IM php-cgi.exe > nul
	exit

## 注册为 Windows 服务

### myapp.xml 格式

	<?xml version="1.0" encoding="UTF-8" ?>
	<service>
	  <id>nginx</id>
	  <name>nginx</name>
	  <description>nginx</description>
	  <executable>F:\nginx-0.9.4\nginx.exe</executable>
	  <logpath>F:\nginx-0.9.4\</logpath>
	  <logmode>roll</logmode>
	  <depend></depend>
	  <startargument>-p F:\nginx-0.9.4</startargument>
	  <stopargument>-p F:\nginx-0.9.4 -s stop</stopargument>
	</service>

### 可用命令

#### 安装服务
	CMD:\> myapp.exe install
 
#### 卸载服务
	CMD:\> myapp.exe uninstall
 
#### 启动服务
	CMD:\> myapp.exe start
 
#### 停止服务
	CMD:\> myapp.exe stop