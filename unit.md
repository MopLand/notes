# Unit

## 安装

### 配置 repo
	/etc/yum.repos.d/unit.repo

	[unit]
	name=unit repo
	baseurl=https://packages.nginx.org/unit/centos/$releasever/$basearch/
	gpgcheck=0
	enabled=1

### 安装 unit
	yum install unit

### 安装模块
	yum install unit-php unit-python unit-go unit-perl

## 使用

### 启动unit

	systemctl start unit

### 关闭unit

	systemctl stop unit

### 配置unit

	service unit loadconfig /etc/unit/config

## 应用

### 配置文件格式

	# vi /disk/units/default.json
	{
	    "listeners": {
	        "*:8080": {
	            "application": "default_site"
	        }
	    },
	
	    "applications": {
	        "default_site": {
	            "type": "php",
	            "processes": 20,
	            "root": "/disk/www/default",
	            "index": "index.php",
	            "script": "index.php"
	        }
	    }
	}

	# 配置参数说明
	type	应用的编程语言 (php).
	workers	应用的工作数量。
	root	文件的本地路径。
	index	默认的index文件路径。
	script (optional)	访问 Unit 内任意的URL均会运行，请填写相对路径。
	user (optional)		运行进程的用户，如未定义，则默认（nobody）。
	group (optional)	用户所在的用户组 。如未定义，则默认。

### 注册应用

	curl -X PUT -d @/disk/units/default.json --unix-socket /var/run/control.unit.sock http://localhost/

### 配合 Nginx

	upstream unit_backend {
		server 127.0.0.1:8888;
	}
	
	server {
		listen 80;
		server_name x.example.com;
	    
	    location / {
	        try_files $uri @index_php;
	    }
	
	    location @index_php {
	        proxy_pass       http://unit_backend;
	        proxy_set_header Host $host;
	    }
	
		location ~ \.(js|css|webp|jpg|jpeg|png|gif|swf|ttf|otf|eot|svg|woff|woff2)$ {
			expires 7d;
			add_header "Access-Control-Allow-Origin" "*";
		}
	
	}

	# 注意，使用反向代理和 try_files 方式，在 PHP 端只能使用 REQUEST_URI 来实现路由


## 参考资料
- [https://unit.nginx.org/](https://unit.nginx.org/ "https://unit.nginx.org/")
- [https://github.com/tuzimoe/unit/blob/master/README_zh-Hans.md](https://github.com/tuzimoe/unit/blob/master/README_zh-Hans.md)
- [https://laravel-china.org/articles/6170/nginx-micro-service-unit-php-first-test](https://laravel-china.org/articles/6170/nginx-micro-service-unit-php-first-test)