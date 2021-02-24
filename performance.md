# performance

## 修改机器名称
	vi /etc/sysconfig/network
	vi /etc/hosts

## 文件句柄上限
	ulimit -n 100001

	vi /etc/security/limits.conf
	* hard nofile 100001
	* soft nofile 100002

	vi /etc/sysctl.conf
	fs.file-max = 200001
	fs.nr_open  = 200001
	
## limit 资源查询

	# 查看系统用户所有限制值
	ulimit -a
	
	# 查看当前系统打开的文件数量
	lsof | wc -l
	
	# 查看当前进程的打开文件数量（pid 进程PID）
	lsof -p pid | wc -l
	
	# 查看系统总限制打开文件的最大数量
	cat /proc/sys/fs/file-max

----------

## 分析工具

	# 资源监控工具 glances
	yum install glances

	# IP 流量分析 iftop
	yum install iftop

	# Nginx 分析工具 ngxtop
	yum install python-pip
	pip install ngxtop

	# Nginx 日志分析 GoAccess
	yum install goaccess
	goaccess -f /var/log/nginx/access.log

	# 磁盘活动统计 iostat
	yum install sysstat
	iostat -x

## 进程统计

	# CPU最高的进程的id
	top -c

	# 统计 80 端口的连接数
	netstat -antlp | grep 80 | grep ESTABLISHED | wc -l

	# 统计服务器所有url被请求的数量
	netstat -pnt | grep :80 | wc -l

	# 统计PHP-FPM 进程数
	netstat -anpo | grep "php-fpm" | wc -l

	# 统计等待中的进程
	netstat -an|grep WAIT

	# 定时执行查询
	watch -d 'netstat -antlp | grep 80 | grep ESTABLISHED | wc -l'

## 进程分析

	# 查看当前php-fpm总进程数，RSS就是占用的内存情况
	ps -ylC php-fpm --sort:rss

	# 查看当前php-fpm进程的内存占用情况及启动时间
	ps -e -o 'pid,comm,args,pcpu,rsz,vsz,stime,user,uid'|grep www|sort -nrk5

	# 查看当前php-fpm进程平均占用内存情况
	ps --no-headers -o "rss,cmd" -C php-fpm | awk '{ sum+=$1 } END { printf ("%d%s\n", sum/NR/1024,"M") }'

	# 通过进程名查看进程信息
	ps -ef | grep memcached

	# 通过端口号查找进程 PID
	netstat -nap | grep 8080

	# 查看被占用端口的 PID
	lsof -i:443

	# 根据进程PID查看进程信息
	ps -ef | grep 13049

	# 查看进程完整信息
	ll /proc/13049

	# 特定进程运行状况
	top -H -p <pid>

	# 杀掉某一个进程
	pkill node

## nload 实时网速查看

### 安装
	yum install nload -y

### 使用
	# 左右键可以在多个网卡之间切换
	nload -h

## wrk 压力测试

### 安装
	git clone https://github.com/wg/wrk.git	
	cd wrk	
	make

### 使用方法

	./wrk -t10 -c500 -d30s --latency http://www.baidu.com

### 可选择项

	-c, --connections <N>  跟服务器建立并保持的TCP连接数量  
	-d, --duration    <T>  压测时间           
	-t, --threads     <N>  使用多少个线程进行压测   
	                                              
	-s, --script      <S>  指定Lua脚本路径       
	-H, --header      <H>  为每一个HTTP请求添加HTTP头      
		--latency          在压测结束后，打印延迟统计信息   
		--timeout     <T>  超时时间     
	-v, --version          打印正在使用的wrk的详细版本信息
	                                              
	<N>代表数字参数，支持国际单位 (1k, 1M, 1G)
	<T>代表时间参数，支持时间单位 (2s, 2m, 2h)

---

## PHP-FPM 优化

### 配置文件
	/etc/php-fpm.d/www.conf

### 参数说明

	# 如何控制子进程?
	# 动态适合小内存机器，灵活分配进程，省内存。静态适用于大内存机器，动态创建回收进程对服务器资源也是一种消耗
	pm = dynamic | static
	
	# 静态方式下开启的 php-fpm 进程数量
	pm.max_children
	
	# 动态方式下的起始 php-fpm 进程数量
	pm.start_servers
	
	# 动态方式下的最小 php-fpm 进程数
	pm.min_spare_servers
	
	# 动态方式下的最大 php-fpm 进程数量
	pm.max_spare_servers

	# 设置每个子进程能处理的最大请求数，达到数量后自动重启该进程
	# 对于可能存在内存泄漏的第三方模块来说是非常有用的. 如果设置为 '0′ 则一直接受请求. 等同于 PHP_FCGI_MAX_REQUESTS 环境变量. 默认值: 0
	pm.max_requests
	
	# 如果 pm 设置为 static，那么其实只有 pm.max_children 这个参数生效。
	# 系统会开启设置数量的 php-fpm 进程。
	# 如果pm设置为 dynamic，那么 pm.max_children 参数失效，后面3个参数生效。
	# 系统会在 php-fpm 运行开始 的时候启动 pm.start_servers 个 php-fpm 进程，
	# 然后根据系统的需求动态在 pm.min_spare_servers 和 pm.max_spare_servers 之间调整 php-fpm 进程数
	
### 8G内存参考
	pm = dynamic
	pm.max_children = 1024
	pm.start_servers = 32
	pm.min_spare_servers = 32
	pm.max_spare_servers = 1024
	pm.max_requests = 10240
	rlimit_files = 65535

### 大文件上传
	
	# php-fpm.ini
	post_max_size = 20M
	upload_max_filesize = 20M

	# nginx.conf
	client_max_body_size 32M;

### 定位慢请求
	
	# www.conf
	request_slowlog_timeout = 5s
	slowlog = /var/log/php-fpm/www-slow.log	

---

## Nginx

### timeout 和 buffers 配置，常引起 504 错误，位于 nginx.conf

	http {    
		fastcgi_connect_timeout 10s;
		fastcgi_send_timeout 60s;
		fastcgi_read_timeout 60s;
		fastcgi_buffers 8 128k;
		fastcgi_buffer_size 256k;	
	}

### 超时设置

	location ~ \.php$ {
		fastcgi_read_timeout 150;
    }

### 配置 50x 错误

	error_page 500 502 503 504 /public/template/server_error.html;

### Nginx 状态

	# 配置
	location  /nginx_status {
		stub_status on;
		access_log off;
	}

	# 数据
	Active connections: 10 
	server accepts handled requests
	6559 6559 39693 
	Reading: 0 Writing: 1 Waiting: 9

	# 解析

	//当前 Nginx 正处理的活动连接数
	Active connections    

	//总共处理了 6559 个连接 , 成功创建 6559 次握手,总共处理了 39693 个请求
	server accepts handledrequests
	
	//nginx 读取到客户端的 Header 信息数
	Reading
	
	//nginx 返回给客户端的 Header 信息数。
	Writing
	
	//开启 keep-alive 的情况下，这个值等于 active – (reading + writing)，意思就是 Nginx 已经处理完正在等候下一次请求指令的驻留连接
	Waiting

### PHP-FPM 状态

	# 配置
	location /phpfpm_status {
		fastcgi_pass  127.0.0.1:9000;
		include fastcgi_params;
	}

	# 数据
	pool:                 www
	process manager:      dynamic
	start time:           04/Apr/2018:04:00:49 +0800
	start since:          38751
	accepted conn:        26758
	listen queue:         0
	max listen queue:     0
	listen queue len:     128
	idle processes:       34
	active processes:     1
	total processes:      35
	max active processes: 4
	max children reached: 0
	slow requests:        0

	# 解析
	pool	php-fpm pool的名称，大多数情况下为www
	process manager	进程管理方式，现今大多都为dynamic，不要使用static
	start time	php-fpm上次启动的时间
	start since	php-fpm已运行了多少秒
	accepted conn	pool接收到的请求数
	listen queue	处于等待状态中的连接数，如果不为0，需要增加php-fpm进程数
	max listen queue	从php-fpm启动到现在处于等待连接的最大数量
	listen queue len	处于等待连接队列的套接字大小
	idle processes	处于空闲状态的进程数
	active processes	处于活动状态的进程数
	total processess	进程总数
	max active process	从php-fpm启动到现在最多有几个进程处于活动状态
	max children reached	当pm试图启动更多的children进程时，却达到了进程数的限制，达到一次记录一次，如果不为0，需要增加php-fpm pool进程的最大数
	slow requests	当启用了php-fpm slow-log功能时，如果出现php-fpm慢请求这个计数器会增加，一般不当的Mysql查询会触发这个值

## 高性能 Web

### DNS

	# 针对较多域名解析至同一 IP 时，可以先创建一个解析，其他域名 CNAME 此域名即可
	# 当需要更新 IP 时，只需要修改第一个解析，其他 DNS 记录会陆续同步

	;; A Records
	app.example.com.	1	IN	A	114.114.114.114

	;; CNAME Records
	da1.aliqin.com.	300	IN	CNAME	app.example.com.
	da2.aliqin.com.	300	IN	CNAME	app.example.com.

### 静态资源

	# 尽量使用不同的域名部署静态资源，尽可能使用 CDN 加速
	# 不同的域名可以突破连接数限制，也可以减少不必要的 Cookie 传输

	;; Web 服务
	www.example.com

	;; 静态资源
	assets.amzdns.com

### 网络访问

	# 能使用内网访问的服务，优先使用内网 IP，可以指定 Host 主机头来指定域名

	curl -H 'Host: gateway.example.com' http://192.168.1.123/
	
### 网络架构

#### 基础架构

![](notes/image/server_arch.png)

#### 带 CDN 附件架构

![](notes/image/server_arch_files.png)


## 相关链接

- [基于php-fpm的配置详解](https://www.jb51.net/article/37749.htm)
- [Linux的php-fpm优化心得-php-fpm进程占用内存大和不释放内存问题](https://wzfou.com/php-fpm/)
- [Linux iostat 命令详解](https://www.cnblogs.com/ftl1012/p/iostat.html)
- [资源监控工具 glances](https://www.jianshu.com/p/639581a96512)
- [PHP -fpm 服务器内存占用陡坡式上涨，请问如何彻底解决？](https://www.v2ex.com/t/727028)
