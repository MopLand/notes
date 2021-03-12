# Nginx

## 必要配置

### 查看模块
	nginx -V

### 查看版本
	nginx -v

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
		rewrite ^/(.+)\.txt$ /fx/verify/$1;
		rewrite ^/attach/(.+)!(.+)\.(gif|jpg|jpeg|png)$ /fx/resized?file=$1&size=$2&mime=$3;
		rewrite ^/(.*\.(ico|gif|jpg|jpeg|png|swf|flv|css|js)$) 404;
		rewrite ^/(.*) /index.php/$1 last;
	}
	
	# 将静态文件缓存7天，并允许跨域
	location ~ \.(js|css|webp|jpg|jpeg|png|gif|swf|ttf|otf|eot|svg|woff|woff2)$ {
		expires 7d;
		add_header "Access-Control-Allow-Origin" "*";
	}

## 编译安装

### 安装依赖
	yum -y install openssl openssl-devel pcre-devel gd-devel
	yum -y install perl-devel perl-ExtUtils-Embed
	yum -y install GeoIP GeoIP-devel GeoIP-data
	yum install gperftools

### 下载源码
	wget http://nginx.org/download/nginx-1.18.0.tar.gz
	tar -zxvf nginx-1.18.0.tar.gz
	cd nginx-1.18.0/
	
### 下载模块
	git clone https://github.com/nginx/njs

### 重新编译模块
	./configure --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/lib/nginx/tmp/client_body --http-proxy-temp-path=/var/lib/nginx/tmp/proxy --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi --http-scgi-temp-path=/var/lib/nginx/tmp/scgi --pid-path=/run/nginx.pid --lock-path=/run/lock/subsys/nginx --user=nginx --group=nginx --with-file-aio --with-http_auth_request_module --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_image_filter_module --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-pcre --with-pcre-jit --with-stream=dynamic --with-stream_ssl_module --with-google_perftools_module --with-debug --add-module=/root/njs/nginx
	make && make install
	
## 添加模块

### 查看编译信息
	nginx -V

### 下载同版本源码
	wget http://nginx.org/download/nginx-1.18.0.tar.gz
	tar -zxvf nginx-1.18.0.tar.gz
	
### 下载模块源码
	git clone https://github.com/evanmiller/mod_zip

### 重新编译模块，千万不 install
	./configure --prefix=... --add-module=/root/mod_zip
	make
	
### 替换 nginx 文件
	mv /root/nginx-1.18.0/objs/nginx /usr/sbin

## 相关命令

### 启动 PHP-CGI
	php-cgi.exe -b 127.0.0.1:9000 -c D:/wnmp/www/php/php.ini

### 启动 Nginx
	nginx.exe

### 查看日志
	tail -f /var/log/nginx/error.log

## 配置文件

### conf/nginx.conf

	http {
	
		# Server identity
		map $host $server_node {
			default "macbook";
		}
		
		# Server Tokens
		server_tokens  off;
		
		# Server identity
		add_header Node $server_node "always";
		
		# CVE-2017-7529
		max_ranges 1;

		# Sites config
		include /disk/sites/*.conf;
	
	}

### conf/fastcgi_params

	fastcgi_param  REQUEST_URI        $request_uri;
	fastcgi_param  DOCUMENT_URI       $document_uri;
	fastcgi_param  DOCUMENT_ROOT      $document_root;
	fastcgi_param  SERVER_PROTOCOL    $server_protocol;
	
	# PATH_INFO 支持 
	fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;
	fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;

### rules/gzip.conf

	# Gzip
	location ~ .*\.(jpg|gif|png|bmp|js|webp|css)$ {
		gzip on;
		gzip_disable "msie6";
		gzip_min_length 50k;
		gzip_buffers 4 16k;
		gzip_comp_level 5;
		gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png image/webp;
	}

### rules/phpcgi.conf

	#location ~ ^(.+\.php)(.*)$ {
	
		#fastcgi_pass_request_body off;	
		#fastcgi_param REQUEST_BODY_FILE $request_body_file;
		
		# PATH_INFO 支持 
		fastcgi_split_path_info ^(.+\.php)(.*)$;
		fastcgi_param PATH_INFO $fastcgi_path_info;
		
		# FASTCGI 运行参数 
		fastcgi_param SERVER_NODE		$server_node;
		fastcgi_param SERVER_SOFTWARE	shadow/$nginx_version;
		fastcgi_param SCRIPT_FILENAME	$document_root$fastcgi_script_name;
		
		# PHP CGI 监听方式，二选一 
		fastcgi_pass 127.0.0.1:9000;
		#fastcgi_pass unix:/dev/shm/php-cgi.sock;
	
		# 超时设置 
		fastcgi_read_timeout 60;
		fastcgi_connect_timeout 10;
		fastcgi_index index.php;
		
		include fastcgi_params;
		
	#}

### rules/dora_route.conf

	# Dora 框架路由规则 
	if (!-e $request_filename) {
		rewrite ^/(.+)\.(txt|htm|html)$ /fx/verify/$1;
		rewrite ^/attach/(.+)!(.+)\.(gif|jpg|jpeg|png)$ /fx/resized?file=$1&size=$2&mime=$3;
		rewrite ^/(.*\.(ico|gif|jpg|jpeg|png|swf|flv|css|js)$) 404;
		rewrite ^/(.*) /index.php/$1 last;
	}

### rules/security.conf
	
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

	# 将静态文件缓存7天，并允许跨域 
	location ~ \.(js|css|webp|jpg|jpeg|png|gif|swf|ttf|otf|eot|svg|woff|woff2)$ {
		expires 14d;
		add_header "Access-Control-Allow-Origin" "*";
	}

### sites/*.conf

	server {
		listen 88;
		server_name www.example.test;
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
	
## GZIP压缩

	server{

		# 开启和关闭gzip模式
		gzip on;

		# gizp压缩起点，文件大于1k才进行压缩
		gzip_min_length 1k;
		
		# 设置用于处理请求压缩的缓冲区数量和大小
		gzip_buffers 32 4k | 16 8k;

		# gzip 压缩级别，1-9，数字越大压缩的越好，也越占用CPU时间
		gzip_comp_level 6;

		# 进行压缩的文件类型。
		gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/xml text/javascript application/json image/png image/gif image/jpeg;

		# nginx 对于静态文件的处理模块，开启后会寻找以.gz结尾的文件，直接返回
		gzip_static on | off;

		# 是否在http header中添加Vary: Accept-Encoding，建议开启
		gzip_vary on | off;

		# 设置压缩所需要的缓冲区大小，以4k为单位，如果文件为7k则申请2*4k的缓冲区 
		gzip_buffers 4 16k;
		
		# 配置禁用gzip条件，支持正则
		gzip_disable "MSIE [1-6]\.";

		# 设置gzip压缩针对的HTTP协议版本
		gzip_http_version 1.1;
			
	}

## 正向代理

![](notes/image/nginx_forward_proxy.png)

	# 代理阿里图片
	server {
		listen 80;
		server_name proxy.zhfile.com;
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
		server_name proxy.zhfile.com;
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
		server_name proxy.zhfile.com;
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
		server_name proxy.zhfile.com;
		access_log off;
	
		# 淘宝图片
		location ~* "imgextra" {
			resolver 114.114.114.114 8.8.8.8;

			proxy_cache imgcache;
			proxy_pass $scheme://img.alicdn.com/$request_uri;
			proxy_buffers   64 256k;

			expires         7d;
		}
		
		# 微信图片
		location ~* "(qpic|mmsns)" {
			resolver 114.114.114.114 8.8.8.8;
			
			proxy_set_header referer "https://mp.weixin.qq.com/";
			proxy_cache imgcache;
			proxy_pass $scheme:/$request_uri;
			proxy_buffers   64 256k;
	
			expires			7d;
		}
		
		# 博客园
		location ~* "cnblogs" {
			resolver 114.114.114.114 8.8.8.8;
			
			proxy_set_header referer "https://www.cnblogs.com/";
			proxy_cache imgcache;
			proxy_pass https:/$request_uri;
			proxy_buffers   64 256k;
	
			expires			7d;
		}
		
		# 其他主图
		location ~* "goods/(\d+)" {
			resolver 1.1.1.1 8.8.8.8;
			
			set $item $1;
			set $size $arg_size;
			
			proxy_set_header referer "https://proxy.rexcdn.com/";
			
			proxy_cache imgcache;
			proxy_cache_valid 301 302 24h;
			
			proxy_pass https://jellybox.mopland.com/robot/goodspic/$item/$size;
			
			proxy_buffers   64 256k;
			expires			7d;
		}
		
	}
	
	# 参考链接
	https://www.jianshu.com/p/625c2b15dad5

## 反向代理

![](notes/image/nginx_reverse_proxy.png)

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
	
	# 转发 PHP
	server {
		listen 80;
		server_name www.veryide.com;
		
		location ~ ^(.+\.php)(.*)$ {
			fastcgi_split_path_info ^(.+\.php)(.*)$;
			fastcgi_param PATH_INFO $fastcgi_path_info;			
			fastcgi_pass 127.0.0.1:9000;			
			fastcgi_read_timeout 60;
			fastcgi_connect_timeout 10;
			fastcgi_index index.php;			
			include fastcgi_params;			
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
		listen 80;
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

### 跨域访问（基本）

	add_header "Access-Control-Allow-Origin" "*" "always";

### 跨域访问（高级）

	location ~ \.php$ {

		if ($request_method = 'OPTIONS') {
			add_header 'Access-Control-Allow-Origin' '*' always;
			add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS,PUT,DELETE' always;
			add_header 'Access-Control-Allow-Headers' '*' always;
			add_header 'Access-Control-Max-Age' 1728000 always;
			add_header 'Content-Length' 0;
			add_header 'Content-Type' 'text/plain; charset=utf-8';
			return 204;
		}

		if ($request_method ~* '(GET|POST|DELETE|PUT)') {
			add_header 'Access-Control-Allow-Origin' '*' always;
		}

	}
	
### 如何设置带通配符子域名的Access-Control-Allow-Origin

	server {
		root /path/to/your/stuff;
		index index.html index.htm;
		server_name yoursweetdomain.com;
		
		set $match "";
		if ($http_origin ~* (.*\.yourdomain.com)) {
			set $match "true";
		}
		
		location / {
			if ($match = "true") {
				add_header 'Access-Control-Allow-Origin' "$http_origin”;
				add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, DELETE, PUT';
				add_header 'Access-Control-Allow-Credentials' 'true';
				add_header 'Access-Control-Allow-Headers' 'User-Agent,Keep-Alive,Content-Type';
			}
			
			if ($request_method = OPTIONS) {
				return 204;
			}
		}
	}

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
	
	server {
		listen 80;
		listen 443 ssl;
		server_name www.example.com;
		root /disk/www/example.com/run;
		
		# 仅在 / 上跳转
		location = / {
			if ($scheme = "http") {
				rewrite ^(.*)$  https://$host$1 permanent;
			}
		}	
	}

### SSL 配置

	# 注意 iptables 中需要允许 443 端口
	server {
		listen 443 ssl;
		server_name example.com;
		root /disk/www/example.com;
		index index.htm index.html index.php;
		
		#SSL 证书
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

### 80, 443 共存

	server {
		listen 80;
		listen 443 ssl;
		
		server_name example.com;
		index index.html index.htm index.php;
		root /disk/www/example.com/;
		
		#SSL 证书
		ssl_certificate /disk/certs/example.com.crt;
		ssl_certificate_key /disk/certs/example.com.key;
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
	    listen 80;
	    server_name ~^(\d+)\.example\.com$;
	    root /disk/www/agent.example.com;
	    index  index.html index.php index.htm;
	    
	    include phpcgi.conf;
	    
	    # 取子域名作为参数
	    if ($host ~* (\d+)\.example\.com) {
			return 301 http://client.example.com/trade/$1;
		}
	}

### 规则匹配域名

	server {
	    listen 80;
	    server_name weixin.example.com ~^sku\.([a-z0-9\.]+)\.(com|net|cn|so)$;
	    root /disk/www/weixin.example.com;
	    index  index.html index.php index.htm;
	    
	    location / {
			add_header Access-Control-Allow-Origin *;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			proxy_pass http://127.0.0.1:3600;
		}		
	}

### 目录规则匹配

	location ~ ^/agent\/(.*)/ {
		rewrite ^(.*)$ http://agent.example.com$1 permanent;
		return 301;
	}
	
	location ~ ^/trade\/(.*)/ {
		rewrite ^(.*)$ http://client.example.com/trade/$1 permanent;
		return 301;
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

### CNAME 转成指定域名

	server {
		listen 80 default_server;
		server_name mirror.example.com;
		root /disk/www/domain.shz.com;
		index index.htm index.html index.php;
		
		location ~ ^(.+\.php)(.*)$ {
			
			fastcgi_param HTTP_DOMAIN $host;
			fastcgi_param HTTP_HOST "sites.guodongbaohe.com";
			
			fastcgi_split_path_info ^(.+\.php)(.*)$;
			fastcgi_param PATH_INFO $fastcgi_path_info;
			fastcgi_pass 127.0.0.1:9000;
			fastcgi_read_timeout 60;
			fastcgi_connect_timeout 10;
			fastcgi_index index.php;
			
			include fastcgi_params;
		}
	
		if (!-e $request_filename) {
			rewrite ^/(.+)\.(txt|htm|html)$ /fx/verify/$1;
			rewrite ^/(.*\.(ico|gif|jpg|jpeg|png|swf|flv|css|js)$) 404;
			rewrite ^/(.*) /index.php/$1 last;
		}
	
	}
	
### 前后端共用同一域名
	
	server {
		listen 80;
		server_name proxy.example.com;
		set $doc /disk/www/example.com;
		root $doc;
		
		# 前端 VUE
		location / {
			root $doc/html;
			try_files $uri $uri/ /index.html;
		}
		
		# 后端 PHP
		location ~ /backend {			
			rewrite ^/backend/(.*) /index.php/$1 break;
			include ../rules/phpcgi.conf;
		}

	}
	
### 代理需要跨域的请求

	server {
		listen 80;
		server_name www.example.com;
		root /disk/www/example.com;
		index index.htm index.html index.php;
		
		location ~ ^(.+\.php)(.*)$ {
			include ../rules/phpcgi.conf;
		}

		location ~ \.php$ {
			fastcgi_index index.php;
			include fastcgi_params;
		}
		
		# 前端视图
		location / {
			if (!-e $request_filename) {
				rewrite ^/(.+)\.txt$ /fx/verify/$1;
				rewrite ^/attach/(.+)!(.+)\.(gif|jpg|jpeg|png)$ /fx/resized?file=$1&size=$2&mime=$3;
				rewrite ^/(.*\.(ico|gif|jpg|jpeg|png|swf|flv|css|js)$) 404;
				rewrite ^/(.*) /index.php/$1 last;
			}
		}
		
		# API 服务
		location ^~ /backend/ {
		
			valid_referers server_names;
			
			if ($invalid_referer) {
				return 406 '"{ "status" : "-406", "result" : "Invalid request source" }"';
			}
			
			if ($http_x_appid = "") {
				return 406 '"{ "status" : "-407", "result" : "Invalid application information" }"';
			}
			
			if ($http_x_agent = "") {
				return 407 '"{ "status" : "-407", "result" : "Invalid agent information" }"';
			}
		
			proxy_set_header Host proxy.example.com;
			proxy_set_header X-Mode "proxy";
			proxy_set_header X-Real-IP  $remote_addr;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			proxy_pass http://127.0.0.1:80/;
		}

	}
	
### 跨服务器文件缓存生成
	
	server {
		listen 80;
		
		server_name static.example.com;
		root /disk/www/example.com/static/;

		# 支持 PHP
		location ~ ^(.+\.php)(.*)$ {
			include ../rules/phpcgi.conf;
		}
		
		# Dora 静态缓存
		location ^~ /combine/ {
			if (!-e $request_filename) {
				rewrite ^/combine/(.+)\.(css|js)$ /fx/combine?hash=$1;
				rewrite ^/(.*) /dora.php/$1 last;
			}
		}

		include ../rules/security.conf;

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
	
### 常见问题

#### 413 Request Entity Too Large
	client_max_body_size 10m;
	
#### module "/usr/lib64/nginx/modules/ngx_http_geoip_module.so" version 1012002 instead of 1018000
	yum remove nginx-mod*
	yum install nginx-module-*

### Nginx 内置变量

	$args                    #请求中的参数值
	$query_string            #同 $args
	$arg_NAME                #GET请求中NAME的值
	$is_args                 #如果请求中有参数，值为"?"，否则为空字符串
	$uri                     #请求中的当前URI(不带请求参数，参数位于$args)，可以不同于浏览器传递的$request_uri的值，它可以通过内部重定向，或者使用index指令进行修改，$uri不包含主机名，如"/foo/bar.html"。
	$document_uri            #同 $uri
	$document_root           #当前请求的文档根目录或别名
	$host                    #优先级：HTTP请求行的主机名>"HOST"请求头字段>符合请求的服务器名.请求中的主机头字段，如果请求中的主机头不可用，则为服务器处理请求的服务器名称
	$hostname                #主机名
	$https                   #如果开启了SSL安全模式，值为"on"，否则为空字符串。
	$binary_remote_addr      #客户端地址的二进制形式，固定长度为4个字节
	$body_bytes_sent         #传输给客户端的字节数，响应头不计算在内；这个变量和Apache的mod_log_config模块中的"%B"参数保持兼容
	$bytes_sent              #传输给客户端的字节数
	$connection              #TCP连接的序列号
	$connection_requests     #TCP连接当前的请求数量
	$content_length          #"Content-Length" 请求头字段
	$content_type            #"Content-Type" 请求头字段
	$cookie_name             #cookie名称
	$limit_rate              #用于设置响应的速度限制
	$msec                    #当前的Unix时间戳
	$nginx_version           #nginx版本
	$pid                     #工作进程的PID
	$pipe                    #如果请求来自管道通信，值为"p"，否则为"."
	$proxy_protocol_addr     #获取代理访问服务器的客户端地址，如果是直接访问，该值为空字符串
	$realpath_root           #当前请求的文档根目录或别名的真实路径，会将所有符号连接转换为真实路径
	$remote_addr             #客户端地址
	$remote_port             #客户端端口
	$remote_user             #用于HTTP基础认证服务的用户名
	$request                 #代表客户端的请求地址
	$request_body            #客户端的请求主体：此变量可在location中使用，将请求主体通过proxy_pass，fastcgi_pass，uwsgi_pass和scgi_pass传递给下一级的代理服务器
	$request_body_file       #将客户端请求主体保存在临时文件中。文件处理结束后，此文件需删除。如果需要之一开启此功能，需要设置client_body_in_file_only。如果将次文件传 递给后端的代理服务器，需要禁用request body，即设置proxy_pass_request_body off，fastcgi_pass_request_body off，uwsgi_pass_request_body off，or scgi_pass_request_body off
	$request_completion      #如果请求成功，值为"OK"，如果请求未完成或者请求不是一个范围请求的最后一部分，则为空
	$request_filename        #当前连接请求的文件路径，由root或alias指令与URI请求生成
	$request_length          #请求的长度 (包括请求的地址，http请求头和请求主体)
	$request_method          #HTTP请求方法，通常为"GET"或"POST"
	$request_time            #处理客户端请求使用的时间,单位为秒，精度毫秒； 从读入客户端的第一个字节开始，直到把最后一个字符发送给客户端后进行日志写入为止。
	$request_uri             #这个变量等于包含一些客户端请求参数的原始URI，它无法修改，请查看$uri更改或重写URI，不包含主机名，例如："/cnphp/test.php?arg=freemouse"
	$scheme                  #请求使用的Web协议，"http" 或 "https"
	$server_addr             #服务器端地址，需要注意的是：为了避免访问linux系统内核，应将ip地址提前设置在配置文件中
	$server_name             #服务器名
	$server_port             #服务器端口
	$server_protocol         #服务器的HTTP版本，通常为 "HTTP/1.0" 或 "HTTP/1.1"
	$status                  #HTTP响应代码
	$time_iso8601            #服务器时间的ISO 8610格式
	$time_local              #服务器时间（LOG Format 格式）
	$cookie_NAME             #客户端请求Header头中的cookie变量，前缀"$cookie_"加上cookie名称的变量，该变量的值即为cookie名称的值
	$http_NAME               #匹配任意请求头字段；变量名中的后半部分NAME可以替换成任意请求头字段，如在配置文件中需要获取http请求头："Accept-Language"，$http_accept_language即可
	$http_cookie
	$http_host               #请求地址，即浏览器中你输入的地址（IP或域名）
	$http_referer            #url跳转来源,用来记录从那个页面链接访问过来的
	$http_user_agent         #用户终端浏览器等信息
	$http_x_forwarded_for
	$sent_http_NAME          #可以设置任意http响应头字段；变量名中的后半部分NAME可以替换成任意响应头字段，如需要设置响应头Content-length，$sent_http_content_length即可
	$sent_http_cache_control
	$sent_http_connection
	$sent_http_content_type
	$sent_http_keep_alive
	$sent_http_last_modified
	$sent_http_location
	$sent_http_transfer_encoding

## 参考内容

- [Nginx 官方文档](https://nginx.org/en/docs/)
- [Nginx 中文文档](http://www.nginx.cn/doc/)
- [Nginx Config 生成](https://nginxconfig.io/)
- [前端开发者必备的Nginx知识](https://segmentfault.com/a/1190000018454271)
- [快速上手Nginx](https://juejin.im/post/5ce68c3c5188253386140fa9)
- [彻底弄懂 Nginx location 匹配](https://juejin.im/post/5ce5e1f65188254159084141)
- [解Bug之路-Nginx 502 Bad Gateway](https://mp.weixin.qq.com/s/WM8YMJQ-1x7HDjE0d-8uTw)
- [利用Nginx第三方模块，实现附件打包下载](https://segmentfault.com/a/1190000000621313)
- [NGINX mod_zip 扩展实现边打包边下载 zip 文件，PHP 实现以及途中踩过的坑](https://www.iuxiao.com/d/28)
- [实践：Nginx的mod_zip模块安装和使用](https://www.leion.co/2018/03/03/Nginx-mod_zip/)
- [How to Install PHP 8 on CentOS 8 / RHEL 8](https://www.linuxtechi.com/install-php-8-centos-8-rhel-8/)
	