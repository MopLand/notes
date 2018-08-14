# Memcache

## Windows

### 安装
	memcached -d install

### 启动
	memcached –m  1024  -d start

### 参数
- -p 监听的端口
- -l 连接的IP地址, 默认是本机
- -d start 启动memcached服务
- -d restart 重起memcached服务
- -d stop|shutdown 关闭正在运行的memcached服务
- -d install 安装memcached服务
- -d uninstall 卸载memcached服
- -u 以的身份运行 (仅在以root运行的时候有效
- -m 最大内存使用，单位MB。默认64M
- -M 内存耗尽时返回错误，而不是删除
- -c 最大同时连接数，默认是102
- -f 块大小增长因子，默认是1.2
- -n 最小分配空间，key+value+flags默认是4
- -h 显示帮助

### 扩展
	php_memcache-3.0.8-5.4-ts-vc9-x86

### 配置
- php.ini
- extension=php_memcache.dll

## Linux

### 安装 
	yum install memcached -y

### 启用，加入随机启动
	systemctl enable memcached

### 运行
	systemctl start memcached

### 状态
	systemctl status memcached

### 配置文件
	/etc/sysconfig/memcached

### 扩展工具
	memcached-tool

### 配置参数

	# 端口
	PORT="11211"

	# 用户身份
	USER="memcached"

	# 最大连接数
	MAXCONN="1024"

	# 缓存大小（MB）
	CACHESIZE="64"

	# 启动参数（日志输出）
	OPTIONS="-vv >> /var/log/memcached.log 2>&1"

	# 禁用 UDP 协议
	# http://bbs.qcloud.com/thread-49051-1-1.html
	OPTIONS="-U 0"

## 测试
telnet 127.0.0.1 11211

