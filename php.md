# PHP

## 版本选择

### Thread-Safety
	TS(Thread-Safety)即线程安全，多线程访问时，采用了加锁机制，当一个线程访问该类的某个数据时进行数据加锁保护，其他线程不能同时进行访问该数据，直到该线程读取完毕，其他线程才可访问使用该数据，好处是不会出现数据不一致或者数据污染的情况，但耗费的时间要比 NTS 长。
	
	PHP以 ISAPI 方式（Apache 常用方式）加载的时候选择TS版本。

### None-Thread Safe

	NTS(None-Thread Safe)即非线程安全，不提供数据访问保护，有可能出现多个线程先后或同时操作同一数据的情况，容易造成数据错乱（即脏数据），一般操作的执行时间要比 TS 短。
	
	PHP以FAST-CGI方式加载运行的时候选择TNS版，具有更好的性能；

## CentOS 7 安装 PHP7

1. 删除 PHP 及扩展

    ```
    yum remove php* php-common
    ```

2. 安装 repo 源

	```
	rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
	```
	
3. 出现错误 epel-release = 7 is needed by remi-release-7.6-2.el7.remi.noarch

	```
    yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	```

4. 修改 yum 源

	```
	vi /etc/yum.repos.d/remi.repo

	[remi]
	enabled=1

	vi /etc/yum.repos.d/remi-php72.repo

	[remi-php72]
	enabled=1
	```  

5. yum 安装php7

	```
	yum install -y php php-fpm php-cli php-mysql php-gd php-xml php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash php-memcache php-opcache php-redis libmcrypt
	```

6. 检查版本和扩展

	```
	php -v
	php -m
	```

## 扩展管理工具 pecl

### Ubuntu/Debian

	# pear 包含 pecl，php5-dev 包含 phpize，pecl 依赖 phpize
	apt-get install php-pear php5-dev

### CentOS/Redhat
	yum install php-pear php-devel

## php.ini 优化选项

	# 禁止显示php版本的信息
	expose_php = Off
	
	# 修正 Path Info
	cgi.fix_pathinfo=1
	
	# 时区配置
	[Date]
	date.timezone = Asia/Shanghai	

## IIS
	cgi.fix_pathinfo=1
	fastcgi.impersonate = 1

## 安全选项

	# 设置表示允许访问当前目录(即PHP脚本文件所在之目录)和/tmp/目录，防止木马跨站
	open_basedir = .:/tmp/

## 开发环境

	[app]
	app.environ=develop

## 让 Windows 命令行支持 PHP

	[环境变量 > 系统变量 > Path] 中加入 PHP 执行文件目录，如：
	;D:\EasyPHP\eds-binaries\php\php713vc14

## 用 phpize 编译共享 PECL 扩展库

	# 需要先安装 php-devel
	yum install php-devel

	# 进入 PHP 扩展目录
	cd extname
	phpize
	./configure
	make && make install

## 安装 pcntl

	# 下载当前版本 PHP 源码
	wget https://www.php.net/distributions/php-7.2.30.tar.gz

	# 解压文件
	tar -zxvf php-7.2.30.tar.gz

	# 进入目录
	cd ./php-7.2.30/ext/pcntl

	# 执行编译
	/usr/bin/phpize
	./configure
	make && make install

	# 写入配置
	echo "extension=pcntl.so" > /etc/php.d/40-pcntl.ini

## 安装 Opcache

	yum install php-pecl-zendopcache

## 配置 Opcache

	[opcache]
	; dll地址
	zend_extension=php_opcache.dll
	
	; 开关打开
	opcache.enable=1
	
	; 开启CLI
	opcache.enable_cli=1
	
	; 共享内存的大小, 总共能够存储多少预编译的 PHP 代码(单位:MB)
	; 推荐 128
	opcache.memory_consumption=64
	 
	; 暂存池中字符串的占内存总量.(单位:MB)
	; 推荐 8
	opcache.interned_strings_buffer=4	 
	 
	; 最大缓存的文件数目 200  到 100000 之间
	; 推荐 4000
	opcache.max_accelerated_files=2000
	 
	; 内存“浪费”达到此值对应的百分比,就会发起一个重启调度.
	opcache.max_wasted_percentage=5
	 
	; 开启这条指令, Zend Optimizer + 会自动将当前工作目录的名字追加到脚本键上,
	; 以此消除同名文件间的键值命名冲突.关闭这条指令会提升性能,
	; 但是会对已存在的应用造成破坏.
	opcache.use_cwd=0	 
	 
	; 开启文件时间戳验证 
	opcache.validate_timestamps=1	 
	 
	; 2s检查一次文件更新 注意:0是一直检查不是关闭
	; 推荐 60
	opcache.revalidate_freq=60
	 
	; 允许或禁止在 include_path 中进行文件搜索的优化
	;opcache.revalidate_path=0	 
	 
	; 是否保存文件/函数的注释   如果apigen、Doctrine、 ZF2、 PHPUnit需要文件注释
	; 推荐 0
	opcache.save_comments=1
	 
	; 是否加载文件/函数的注释
	;opcache.load_comments=1	 
	 
	; 打开快速关闭, 打开这个在PHP Request Shutdown的时候会收内存的速度会提高
	; 推荐 1
	opcache.fast_shutdown=1
	 
	;允许覆盖文件存在（file_exists等）的优化特性。
	;opcache.enable_file_override=0	 
	 
	; 定义启动多少个优化过程
	;opcache.optimization_level=0xffffffff	 
	 
	; 启用此Hack可以暂时性的解决”can’t redeclare class”错误.
	;opcache.inherited_hack=1
	 
	; 启用此Hack可以暂时性的解决”can’t redeclare class”错误.
	;opcache.dups_fix=0
	 
	; 设置不缓存的黑名单
	; 不缓存指定目录下cache_开头的PHP文件. /png/www/example.com/public_html/cache/cache_ 
	;opcache.blacklist_filename=	 
	 
	; 通过文件大小屏除大文件的缓存.默认情况下所有的文件都会被缓存.
	;opcache.max_file_size=0
	 
	; 每 N 次请求检查一次缓存校验.默认值0表示检查被禁用了.
	; 由于计算校验值有损性能,这个指令应当紧紧在开发调试的时候开启.
	;opcache.consistency_checks=0
	 
	; 从缓存不被访问后,等待多久后(单位为秒)调度重启
	;opcache.force_restart_timeout=180
	 
	; 错误日志文件名.留空表示使用标准错误输出(stderr).
	;opcache.error_log=	 
	 
	; 将错误信息写入到服务器(Apache等)日志
	;opcache.log_verbosity_level=1
	 
	; 内存共享的首选后台.留空则是让系统选择.
	;opcache.preferred_memory_model=
	 
	; 防止共享内存在脚本执行期间被意外写入, 仅用于内部调试.
	;opcache.protect_memory=0
	
## Imagick

### 安装 pecl 依赖
[https://windows.php.net/downloads/pecl/deps/](https://windows.php.net/downloads/pecl/deps/)
	
	选择合适的版本进行安装，类似：
	ImageMagick-7.1.0-18-vc15-x64.zip
	ImageMagick-7.1.0-18-vc15-x86.zip
	
### 新增环境变量 path
	D:\ImageMagick\bin
	
### pdf 文件处理需要用到 Ghostscript
[https://ghostscript.com/releases/gsdnld.html](https://ghostscript.com/releases/gsdnld.html)
	
	选择合适的版本进行安装，类似：
	Ghostscript 9.56.1 for Windows
	Ghostscript 9.56.1 for Linux
	
### 新增环境变量 path
	C:\Program Files (x86)\gs\gs9.56.1\bin
	
### 安装 php 扩展
[https://pecl.php.net/package/imagick/](https://pecl.php.net/package/imagick/)
	
	选择合适的版本进行安装，类似：	
	8.0 Non Thread Safe (NTS) x64
	8.0 Thread Safe (TS) x64
	8.0 Non Thread Safe (NTS) x86
	8.0 Thread Safe (TS) x86
	
### 配置 php.ini
	extension=imagick
	
### 复制文件到 ext/
	php_imagick.dll
	php_imagick.pdb
	
### 复制其他文件到 /
	*.dll
	*.pdb
	
## 常见错误

### 无法保存登录状态（session 不能写入）Session expired, please login again.
	
	# 推荐 chown
	chown nginx /var/lib/php/session
	chmod 0777 /var/lib/php/session

## 参考链接

- [在CentOS 8上安装PHP、Redis和phpredis](https://blog.csdn.net/allway2/article/details/108758138)
- [PHP Session可能会引起并发问题](https://www.cnblogs.com/Alight/p/4310174.html)
- [PHP session并发操作及session读写锁](https://my.oschina.net/BearCatYN/blog/485318)