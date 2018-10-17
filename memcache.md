# Memcache

> Memcache 安装和配置说明

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

	# php.ini
	extension=php_memcache.dll

### 下载地址

- [PHP 5.3 ~ 5.6 可用扩展下载](https://windows.php.net/downloads/pecl/releases/memcache/)
- [PHP 7.x 可用扩展下载](https://github.com/nono303/PHP7-memcache-dll)
- 根据 phpinfo 中的 Architecture 和 PHP Extension Build 选择适用的版本

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

## 服务测试

### 连接服务

	telnet 127.0.0.1 11211

### 命令响应

	STORED 表示存储成功 
	NOT_STORED：表示存储失败（命令正确，但操作不对） 
	ERROR：表示命令错误
	END：完成命令
	
### 支持命令

| 命令 | 命令说明 | 示例 |
| ------ | ------ | ------ |
| get | 获取值 | get mykey |
| set | 设定一个值（key/flag/expire/bytes） | set mykey 0 60 5 |
| add | 添加一个值 | add mykey 0 60 5 |
| replace | 替换值 | replace mykey 0 60 5 |
| append | 在后面追加值 | append mykey 0 60 5 |
| prepend | 在前面追加值 | prepend mykey 0 60 5 |
| incr | 数值类的值增加给定数字值 | incr mykey 2 |
| decr | 数值类的值减少给定数字值 | decr mykey 5 |
| flush_all | 刷新items：立即刷新 或 延迟时间刷新 | flush_all /flush_all 100 |
| stats | 普通stats查询 | stats |
| | 内存块使用查询（显示各个slab的信息，包括chunk的大小，数目，使用情况等） | stats slabs |
| | 查询分配的item（显示各个slab中item的数目和最老item的年龄） | stats items |
| | stats 详细信息操作命令，有on/off/dump三个选项 | stats detail on |
| | 统计数量 | stats sizes |
| | 重置，清空统计数据 | stats reset |
| version | 查看服务端版本 | version |
| verbosity | 提升日志级别，有info/error级别可供选择 | verbosity info |
| quit | 退出 | quit |
