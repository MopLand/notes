# Nodejs

## yum 安装

### 安装命令
	yum install epel-release
	curl -sL https://rpm.nodesource.com/setup_9.x | sudo -E bash -
	yum install nodejs
	
### 卸载命令
	yum remove nodejs npm -y

## 编译安装

### 安装依赖包
	yum install gcc-c++ openssl-devel

### 安装最新版本Node.js
	cd /usr/local/src
	wget https://nodejs.org/dist/node-latest.tar.gz
	tar -zxvf node-latest.tar.gz

### 对当前版本进行编译
	cd node-[version]
	./configure
	make && make install

### 官网地址
	https://nodejs.org/

### 安装地址
	D:\Nodejs

### 更改环境变量，CMD 命令行中输入
	set NODE_PATH="C:\Users\Administrator\AppData\Roaming\npm\node_modules"
	set PATH=%PATH%;"D:\Nodejs;C:\Users\Administrator\AppData\Roaming\npm"
	
### Mac 环境变量 ~/.profile 文件
	export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules

### Linux 环境变量 /root/.bashrc 文件
	export LANG=en_US.UTF-8
	export NODE_PATH=/usr/local/lib/node_modules

### 更改为国内服务器，可以提高更快的下载速度
	npm set registry=http://r.cnpmjs.org/

## 常用命令

### 查看版本
	node -v
	npm -v

### npm 命令

	# 安装nodejs的依赖包
	npm install <name>

	# 安装指定版本
	npm install express@3.0.6
	
	# 将包安装到全局环境中
	npm install <name> -g
	
	# 安装的同时，将信息写入package.json中
	npm install <name> --save
	
	# 会引导你创建一个package.json文件，包括名称、版本、作者这些信息等
	npm init
	
	# 移除依赖包
	npm remove <name>
	
	# 更新依赖包
	npm update <name>更新
	
	# 列出当前安装的了所有包
	npm ls
	
	# 查看当前包的安装路径
	npm root
	
	# 查看全局的包的安装路径
	npm root -g
	
	# 查看帮助
	npm help <command>

## 常用模块
	
	npm install -g jade
	npm install -g pm2
	npm install -g connect
	npm install -g express
	npm install -g socket.io
	npm install -g mysql
	npm install -g request
	npm install -g node-schedule
	npm install -g body-parser
	npm install -g express-generator
	npm install -g express -gd

## 运行方式
	
### 直接运行
	node /disk/www/example.com/app.js

### .bat 脚本
	
	@echo off
	cd %~dp0
	
	set dir=%~dp0
	set app=app.js
	set run=%dir%%app%
	
	@node %run%
	@exit

### Shell 脚本

> **文件名**

	cron.sh

> **脚本内容**

	#!/bin/sh
	export PATH=/usr/bin
	export NODE_PATH=/usr/lib/node_modules/

	node /disk/www/example.com/app.js -start > /dev/null 2>&1
   
> **执行权限**

	chmod 0777 cron.sh
   
> **文件编码**

	vi cron.sh
	set fileformat=unix

> **计划任务**

	00 23 * * * /disk/www/cron.sh > /dev/null 2>&1

### PM2 管理

	# 直接运行
	pm2 start /disk/www/example.com/app.js

	# 指定别名
	pm2 start /disk/www/example.com/app.js -n example

	# 监控变化
	pm2 start /disk/www/example.com/app.js -watch

	# 限制内存，超过时自动重启
	pm2 start /disk/www/example.com/app.js --max-memory-restart 1024M

	# 指定别名，使用最大进程数
	pm2 start /disk/www/example.com/app.js -n UrlShort --max-memory-restart 1024M -i 0 --watch
	
	# 保存任务
	pm2 save

	# 随机启动 systemd
	pm2 startup systemd

	# 随机启动 CentOS
	pm2 startup centos
	
	# 应用 pm2-root
	systemctl enable pm2-root

	# 删除启动脚本
	pm2 unstartup centos

	# 监视界面
	pm2 monit

	# 参考链接
	https://segmentfault.com/a/1190000002539204
	http://pm2.keymetrics.io/docs/usage/cluster-mode/
	http://blog.csdn.net/billfeller/article/details/40711309
	https://doesnotscale.com/deploying-node-js-with-pm2-and-nginx/
	https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-centos-7

### PM2 升级

	# 保存当前进程
	pm2 save

	# 安装最新 PM2
	npm install pm2 -g

	# 更新内存中的进程
	pm2 update

### puppeteer 安装

#### 国内Chromium源
	PUPPETEER_DOWNLOAD_HOST=https://storage.googleapis.com.cnpmjs.org
	npm i puppeteer

#### 用 cnpm 安装，自动切换
	npm install -g cnpm --registry=https://registry.npm.taobao.org
	cnpm i puppeteer
	
#### CentOS 依赖
	# 依赖库
	yum install pango libXcomposite libXcursor libXdamage libXext libXi libXtst cups-libs libXScrnSaver libXrandr GConf2 alsa-lib atk gtk3 -y

	# 字体
	yum install ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc -y

### Bash脚本

> **文件名**

	jingdong

> **脚本内容**

	#!/bin/bash
	### BEGIN INIT INFO
	# Provides:          node
	# Required-Start:    $all
	# Required-Stop:     $all
	# Default-Start:     2 3 4 5
	# Default-Stop:      0 1 6
	### END INIT INFO
	
	# chkconfig: 345 200 09  
	# description: Forever for Node.js 
	
	DEAMON="/var/www/www.deyi.la/jd/jd.js -start"
	LOG=/var/www/www.deyi.la/jd/log/cron.txt
	PID=/root/.forever/pids/forever.pid
	
	export PATH=$PATH:/usr/bin
	export NODE_PATH=$NODE_PATH:/usr/lib/node_modules
	
	node=node
	forever=forever
	
	case "$1" in
	    start)
	        $forever start --minUptime 10000 --spinSleepTime 10000 -l $LOG --pidFile $PID -a $DEAMON
	        ;;
	    stop)
	        $forever stop --pidFile $PID $DEAMON
	        ;;
	    stopall)
	        $forever stopall --pidFile $PID
	        ;;
	    restartall)
	        $forever restartall --pidFile $PID
	        ;;
	    reload|restart)
	        $forever restart -l $LOG --pidFile $PID -a $DEAMON
	        ;;
	    list)
	        $forever list
	        ;;
	    *)
	        echo "Usage: /etc.init.d/node {start|stop|restart|reload|stopall|restartall|list}"
	        exit 1
	        ;;
	esac

   
> **执行权限**

	chmod 755 /etc/init.d/jingdong

> **安装 chkconfig**

	sudo apt-get install chkconfig

> **添加服务**

	chkconfig --add jingdong
	chkconfig jingdong on
   
> **文件编码**

	vi jingdong
	set fileformat=unix

> **启动服务**

	service jingdong start