#Apache

###必要模块
	mod_expires.so			有效期设置
	mod_headers.so			文件头控制
	mod_rewrite.so			URL 重写
	mod_vhost_alias.so		虚拟主机

### 配置Apache

	# 访问权限
	<Directory />
		AllowOverride All
		Require All granted
	</Directory>
	
	# 配置文件
	Include conf/extra/httpd-vhosts.conf

### 目录配置
	DocumentRoot "D:/Works/"
	<Directory "D:/Works/">
		# 允许目录索引、允许软连接，允许执行 CGI
		Options Indexes FollowSymLinks ExecCGI

		# 当其他网站在此子目录时，必需允许其访问
		AllowOverride All
		Require all granted
	</Directory>

### 主机配置
	
	# 配置语法
	<VirtualHost www.example.dev:80>
		DocumentRoot "D:/Works/Example"
		ServerName www.example.dev
	</VirtualHost>
	
	# 配置别名
	<VirtualHost *>
		ServerName server.domain.com
		ServerAlias server server2.domain.com server2
	</VirtualHost>
	
### 虚拟主机

	# 禁止证书文件输出
	<FilesMatch .(?i:p12|pem|key|crt)$>
		Order allow,deny
		Deny from all
	</FilesMatch>

	# 跨域与静态文件缓存
	<FilesMatch "\.(js|css|webp|jpg|jpeg|png|gif|swf|ttf|otf|eot|svg|woff|woff2)$">

		# 将静态文件缓存7天
		<ifmodule mod_expires.c>
			ExpiresActive on
			ExpiresDefault "access plus 7 days"
		</ifmodule>

		# 允许静态文件跨域
		<ifmodule mod_headers.c>
			Header set Access-Control-Allow-Origin "*"
		</ifmodule>

	</FilesMatch>
	
	# 常规路由配置
	<IfModule mod_rewrite.c>

		RewriteEngine on
		Options Indexes FollowSymLinks

		# 禁止任务脚本输出
		RewriteCond %{REQUEST_FILENAME} -f
		RewriteRule ^cron\/(.+)\.(js|json|sql|sh|md)$ - [R=403,L]

		# 图片缩略图生成服务
		RewriteCond %{REQUEST_FILENAME} !-f
		RewriteRule ^attach\/(.+)\!(.+)\.(gif|jpg|jpeg|png)$ /fn/resized?file=$1&size=$2&mime=$3 [L]

		# 将路由交由 index.php 处理
		RewriteCond %{REQUEST_FILENAME} !-f
		RewriteRule ^(.*)$ index.php/$1 [L]

	</IfModule>

### 非 WWW 转向到 WWW 的域名下
	Options +FollowSymLinks 
	RewriteEngine on 
	RewriteCond %{HTTP_HOST} ^jb51.net [NC] 
	RewriteRule ^(.*)$ http://www.jb51.net/$1 [L,R=301]

### 重定向到新域名
	Options +FollowSymLinks 
	RewriteEngine on 
	RewriteRule ^(.*)$ http://www.baidu.com/$1 [L,R=301] 

### 使用正则进行 301 重定向，实现伪静态
	Options +FollowSymLinks 
	RewriteEngine on 
	RewriteRule ^news-(.+)\.html$ news.php?id=$1
	
## 常见错误

###403
	通常为 AllowOverride 或 Require All 配置有误，应当于
	AllowOverride All
	Require All granted

###404
	通常为 DocumentRoot 配置有误
	

## AB 测试

### 转向 Apahce/bin 目录
	cd /d D:\EasyPHP\eds-binaries\httpserver\apache\bin

### 使用命令
	
	ab -n 800 -c 800 http://192.168.0.10/ 
	#（-n发出800个请求，-c模拟800并发，相当800人同时访问，后面是测试url）
	
	ab -t 60 -c 100 http://192.168.0.10/ 
	# 在60秒内发请求，一次100个请求。 
	  
	# 如果需要在url中带参数，这样做 
	ab -t 60 -c 100 -T "text/plain" -p p.txt http://192.168.0.10/hello.html 
	p.txt 是和ab.exe在一个目录 
	p.txt 中可以写参数，如  p=wdp&fq=78

### AB 测试相关文章
	http://www.cnblogs.com/zengxiangzhan/archive/2012/12/07/2807141.html