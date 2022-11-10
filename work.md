# 工作规范

## 常用服务

- 服务器（阿里云/腾讯云）
- 数据库（阿里云/腾讯云/本地）
- 附件（本地/异步至七牛云）
- CDN（七牛云/腾讯云/CloudFlare）
- 域名购买（GoDaddy/腾讯云/国内备案推荐腾讯云）
- 域名解析（DNSPOD）

## 生产环境

### 基本配置

	1.8核 CPU
	2.8GB 内存
	3.50GB 系统盘
	4.5MB 以上带宽，独立数据库
	5.数据盘（100 GB以上），挂载至 /disk

### 目录结构

	disk
		backup								# 备份目录
			example.com.sql
			example.com.zip
			...			
		certs								# 证书目录
			dnspod_token					# DNSPOD API Token
			example.com.key
			example.com.crt
			...			
		cache								# 公共缓存
			ipdata.dat						# IP 位置库
			...			
		rules								# Nginx 规则
			blocked.conf					
			mirror.conf
			...			
		sites								# 站点配置
			default.conf					# 默认站点
			...
		shell								# 自动化脚本
			gitpull.sh						# Git 同步脚本
			memcached.sh					# Memcached 重启
			backup.sh						# 数据库备份
			fdisk.sh						# 数据盘初始化
			autoclean.sh					# 缓存目录清理
			backup.sh						# 数据库备份
			blockip.sh						# 访问频率过高IP自动Ban
			certbot-deploy.sh				# CertBot SSL 证书更新和部署
			certbot-auth-file.sh			# CertBot 域名验证，以文件形式
			certbot-auth-dnspod.sh			# CertBot DNSPOD 解析验证脚本
			compress.sh						# 图片批量压缩
			...
		www									# 站点目录
			default							# 默认站点
			upgrade							# 升级站点
			...
		log									# 日志目录
			access.log						# Nginx 访问日志
			error.log						# Nginx 错误日志
			...
		
### 服务器

	1.合理配置 PHP-FPM
	2.仅开放必要端口（80 / 88 / 3636 / 22 / 2121）
	3.针对静态文件类型做缓存（gif jpg png css js）
	4.针对特殊文件类型做访问限制（sql / md / log）
	5.header 中增加服务器标识
	6.服务器目录结构统一规范 (disk / sites / rules / www / log)
	7.针对大流量请求，分离或关闭日志
	8.多台服务器尽量在一个内网，方便互通
	9.自动拉取项目，失败时邮件提醒

### 数据库

	1.查询时尽可能列出字段
	2.合理使用索引，优先使用联合索引
	3.耗时运算尽量安排在凌晨以后
	4.尽量使用触发器、事件来实现复杂运算
	5.大表提前预留 extra_num 和 extra_str 冗余字段

### 应用程序

	1.优先使用缓存
	2.延迟连接数据库
	3.尽可能不依赖数据库
	4.不同业务模块拆分，分散压力
	5.尽量使用单一入口处理数据（AJAX / JSONP）
	6.数据请求必要来路、token 验证
	7.输出友好错误信息，显示排错标识信息
	8.后端自动记录程序错误
	9.渲染用户输入内容时要转 HTML 实体

### 前端开发

	1.对 JS 和 CSS 文件进行压缩合并
	2.对公共 JS 使用 CDN 加速，以及分别管理
	3.CSS中用到的图片，尽量使用 Sprite 技术
	4.尽量对图片进行延迟加载
	5.前端自动记录异常错误
	6.尽可能让 Ajax / JSONP 可缓存

### 开发环境

	1.使用 GIT 协同开发
	2.本地开发屏蔽配置文件

### 经验心得

	1. 不要在临近假期进行大版本提交
	
## 七牛镜像

### MySQL 备份

- shell 脚本，每天备份至 /disk/backup
- qrshell 工具，定时同步至七牛 backup
- 参考 backup.sh

### 上传附件存储

- 附件上传汇总至 /disk/www/attach.zhfile.com/
- 给上传目录绑定域名：attach.src.zhfile.com
- 七牛资源绑定 CNAME：attach.zhfile.com
- 七牛资源设置镜像源：attach.src.zhfile.com
- attach 为任何可用标识，如：s1 ~ s9

### 公用静态资源

- 资源上传汇总至 /disk/www/public.zhfile.com/
- 给上传目录绑定域名：public.src.zhfile.com
- 七牛资源绑定 CNAME：public.zhfile.com
- 七牛资源设置镜像源：public.src.zhfile.com

### 建立软链接
	ln -s /disk/www/shihuizhu.com/attach/goods /disk/www/s3.zhfile.com/goods
	
## Nginx

### 基础配置
	
	user  nginx;
	worker_processes  auto;

	error_log  /var/log/nginx/error.log warn;
	pid        /var/run/nginx.pid;

	events {
		worker_connections  1024;
	}

	http {
		include       /etc/nginx/mime.types;
		default_type  application/octet-stream;

		# main 日志格式增加主机信息
		log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
						  '$status $body_bytes_sent "$http_referer" '
						  '"$http_user_agent" "$http_x_forwarded_for" "$http_host"';

		# mirror 镜像服务，增加 APPID 标识
		log_format  mirror  '$remote_addr - $remote_user [$time_local] "$request" '
						  '$status $body_bytes_sent "$http_referer" '
						  '"$http_user_agent" "$http_x_forwarded_for" "$http_APPID"';

		# iponly 仅 IP 格式日志
		log_format  iponly  '$remote_addr';

		access_log  /var/log/nginx/access.log  main;
		
		# 服务器标识，内网 IP 后两段
		add_header Node "0.3" "always";
		
		# CVE-2017-7529
		max_ranges 1;

		sendfile        on;
		#tcp_nopush     on;

		keepalive_timeout  65;

		#gzip  on;

		include /disk/sites/*.conf;
	}


### 默认站点

	# /disk/sites/default.conf
	server {
		listen       88 default_server;
		listen       [::]:88 default_server;
		server_name  _;
		root         /disk/www/default;
		include phpcgi.conf;
	
		location / {

		}
	
	   	add_header "Access-Control-Allow-Origin" "*" "always";
	
	   	location  /nginx_status {
	   		 stub_status on;
		}
	
	   	location /phpfpm_status {
			fastcgi_pass  127.0.0.1:9000;
			include fastcgi_params;
		}
	
		error_page 404 /404.html;
			location = /40x.html {
		}
	
		error_page 500 502 503 504 /50x.html;
			location = /50x.html {
		}
	}

## PHP-FPM

### 配置文件

	/etc/php-fpm.d/www.conf

### 更改用户和组

	user = nginx 				#修改用户为 nginx
	group = nginx 				#修改用户组为 nginx


### 启用 PHP-FPM 状态

	pm.status_path = /phpfpm_status

## Git 常用命令

### 重置单个文件状态

	git checkout -- config/version.php

### 丢掉工作区的修改

	git reset --hard
	
## 运维经验

### 使用 cname 同步多个 IP 指向（在多负载均衡、多域名时尤为有用）

![](notes/image/cname_address_sync.png)
