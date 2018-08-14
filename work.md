# 工作规范

## 生产环境

### 基本配置

	1.8核 CPU
	2.8GB 内存
	3.50GB 系统盘
	4.5MB 以上带宽，独立数据库
	5.数据盘（100 GB以上），挂载至 /disk

### 目录结构

	disk									# 工作目录
		certs								# 证书目录
			example.com.key
			example.com.crt
			...
		rules								# Nginx 规则
			blocked.conf					
			mirror.conf
			...
		sites								# 站点配置
			default.conf					# 默认站点
			...
		www									# 站点目录
			default							# 默认站点
			...
		log									# 日志目录
			access.log						# Nginx 访问日志
			error.log						# Nginx 错误日志
			...
		gitpull.sh							# Git 同步脚本
		memcached.sh						# Mem 重启脚本
		backup.sh							# 数据库备份脚本
		ipdata.dat							# 公共 IP 数据库

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

	1.合理使用索引
	2.查询时尽可能列出字段
	3.尽量使用触发器、事件来实现复杂运算
	4.耗时运算尽量安排在凌晨以后

### 应用程序

	1.优先使用缓存
	2.延迟连接数据库
	3.尽可能不依赖数据库
	4.不同业务模块拆分，分散压力
	5.尽量使用单一入口处理数据（AJAX / JSONP）
	6.数据请求必要来路、token 验证
	7.输出友好错误信息，显示排错标识信息
	8.后端自动记录程序错误

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

## Nginx

### 服务器标识

	# nginx.conf
	# 123 为服务器内网 IP 最后一段数字
	http{
		add_header Node "123" "always";
	}

	# main 日志格式增加主机信息
	"$http_host"

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

	user = nginx 				#修改用户为nginx
	group = nginx 				#修改组为nginx


### 启用 PHP-FPM 状态

	pm.status_path = /phpfpm_status

## GIT 常用命令

### 重置单个文件状态

	git checkout -- config/version.php

### 丢掉工作区的修改

	git reset --hard
	