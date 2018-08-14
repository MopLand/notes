
# MongoDB

## 服务进程

### 安装程序

	vi /etc/yum.repos.d/mongodb-org-3.4.repo

	[mongodb-org-3.4]
	name=MongoDB Repository
	baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
	gpgcheck=1
	enabled=1
	gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc

	yum install -y mongodb-org

### 启动服务
	
	systemctl enable mongod

	systemctl start mongod

### 配置文件

	# /etc/mongod.conf

	# where to write logging data.
	systemLog:
	  destination: file
	  logAppend: true
	  path: /var/log/mongodb/mongod.log
	
	# Where and how to store data.
	storage:	  
	  dbPath: /disk/mongodb # 注意读写权限
	  journal:
	    enabled: true
	
	# how the process runs
	processManagement:
	  fork: true  # fork and run in background
	  pidFilePath: /var/run/mongodb/mongod.pid  # location of pidfile
	
	# network interfaces
	net:
	  port: 27027
	  bindIp: 0.0.0.0  # Listen to local interface only, comment to listen on all interfaces.
	
	#security:
	security:
	  authorization: enabled

## PHP-FPM

### 编译扩展

	yum install openssl openssl-devel
	
	yum install php-devel
	
	pecl install mongodb 

### 配置文件

	vi php.ini
	extension=mongodb.so

### 重启服务
	
	systemctl restart php-fpm


## 服务优化

### 日志清理

	# /var/log/mongodb/mongod.log

	mongo --port 27027
	use admin
	db.runCommand({logRotate:1})