# Mac

## 使用 Brew 安装 PHP 开发环境

### 1. 安装 Homebrew

` Homebrew是一个包管理器，用于安装软件和工具。如果您的Mac上还没有安装Homebrew，请按照以下步骤进行安装：`

	# 使用 gitee 脚本安装（推荐）
	/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"

	# 使用官方脚本安装
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### 2. 关闭自带的 appche
	sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist

### 3. 安装 PHP
	brew install php

### 4. 安装 Apache
	brew install httpd

### 5. 安装 Redis
	# 使用Homebrew 安装Redis，安装完成后，Redis将默认运行在6379端口：
	brew install redis

### 6. 安装PECL
	# PECL是PHP扩展和工具的集合。如果您的Mac上还没有安装PECL，请按照以下步骤进行安装：
	brew install pecl

### 7. 安装 composer 扩展

	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
	sudo mv composer.phar /usr/local/bin/composer

### 8. 安装 phpredis 扩展
	pecl install redis

### 9. 配置PHP

`创建 /opt/homebrew/etc/httpd/extra/httpd-php.conf 文件，并添加以下内容：`

	LoadModule php_module /opt/homebrew/opt/php/lib/httpd/modules/libphp.so

	<FilesMatch \.php$>
		SetHandler application/x-httpd-php
	</FilesMatch>

## 5. 安装 MySQL

	# 安装MySQL
	brew install mysql

	# 启动MySQL服务：
	brew services start mysql

	# 更新 MySQL 密码
	ALTER USER 'root'@'localhost' IDENTIFIED BY 'your_password';

### PHP 测试页面
	<?php
	$redis = new Redis();
	$redis->connect('127.0.0.1', 6379);
	echo "Redis server is running";
	phpinfo();

### 常用命令
	brew services start php
	brew services stop php
	brew services restart php

	brew services start httpd
	brew services stop httpd
	brew services restart httpd

	brew services start redis
	brew services stop redis
	brew services restart redis

	brew services start mysql
	brew services stop mysql
	brew services restart mysql

	# 如果你不想要 / 不需要后台服务，你可以直接运行
	/opt/homebrew/opt/php/sbin/php-fpm --nodaemonize

### 常用目录
	/opt/homebrew/etc/apache/
	/opt/homebrew/etc/php/8.4/
	/opt/homebrew/opt/mysql/

### 安装常用工具
	xcode-select --install
	brew install wget
	brew install autoconf automake libtool

------------------------------
	
## 更新 Git
	
### 查看 Git 版本
	git --version

### 安装 Git
	brew install git
	
### 更改 Git 指向
	brew link git --overwrite
	
### 查看 Git 版本
	git --version

------------------------------

## XAMPP - PHP集成开发环境

### 安装 XAMPP
	https://www.apachefriends.org/download.html

### 安装 PHP Redis 扩展
	cd /Applications/XAMPP/bin
	sudo ./pecl install redis
	php.ini: extension="redis.so"

### 安装 Redis 服务
	brew install redis
	brew services start redis

------------------------------
	
## Mac 调优

### 安装非 App Store 应用

1. 系统偏好设置 > 安全性与隐私
	
2. 『点击锁按钮以进行更改』
	
3. 允许从以下位置下载的应用：任何来源

### NTFS 格式支持

	# Tuxera NTFS	
[Tuxera NTFS 安装包下载](https://share.weiyun.com/5QqqT4V)

	# Mounty for NTFS
[Mounty for NTFS](https://mounty.app/)

### 外接显示亮度调节

	# Shades For Mac
	# 下载地址：http://dl.pconline.com.cn/download/420090-1.html

	# Brightness menu bar
	# 下载地址：https://itunes.apple.com/cn/app/id451140932?mt=12
	
	# NightOwl
	https://nightowl.kramser.xyz/


### 外接 USB 键盘
	
	# 系统偏好设置 > 键盘 > 修饰键
	
	# 选择键盘：[USB-KeyBoard]
	
	# 修改修饰键
		
	Control => Command
	Command => Control

------------------------------

## 快捷键

### 切换输入法
	command + space

### 显示/隐藏文件（.example）
	command + shift + .

### 实现 Chrome F5 刷新
	系统偏好设置 > 键盘 > 快捷键 > 应用快捷键 > Add > Google Chrome / 重新加载此页 / F5

## 相关链接

- [mac os 安装 redis](https://www.jianshu.com/p/3bdfda703552)
- [mac下~/.bashrc不起作用](https://www.mobibrw.com/2017/6029)
- [Apple 开发者中心下载工具](https://developer.apple.com/download/more/)
- [Mac 键盘快捷键](https://support.apple.com/zh-cn/HT201236)
- [将 Mac 设置为在启动期间自动登录](https://support.apple.com/zh-cn/HT201476)
- [mac开机登录后自动运行shell脚本](https://blog.csdn.net/enjoyinwind/article/details/86470674)
- [让Mac OS X系统启动时执行脚本的方法](https://www.jb51.net/os/MAC/387487.html)
- [Mac中的定时任务利器：launchctl](https://www.jianshu.com/p/4addd9b455f2)
- [mac设置shell脚本开机自启动](https://www.cnblogs.com/dongfangzan/p/5976791.html)
- [简单的Mac设置ChromeF5刷新F12打开控制台](https://www.jianshu.com/p/1d7545bb585e)
- [XAMPP - Macos 上的 PHP 集成开发环境](https://www.apachefriends.org/)
- [https://getcomposer.org/download/](https://getcomposer.org/download/)
- [程序员 Homebrew 使用指北](https://sspai.com/post/56009#!#)
- [MAC 安装 Homebrew (使用国内镜像源)](https://www.cnblogs.com/Nestar/p/18074872)
- [mac 13 系统下安装配置 apache php (更新20230511)](https://blog.csdn.net/qq_28993251/article/details/116160956)
- [Mac环境下轻松配置Redis PHP扩展：一步到位的安装指南](https://www.oryoy.com/news/mac-huan-jing-xia-qing-song-pei-zhi-redis-php-kuo-zhan-yi-bu-dao-wei-de-an-zhuang-zhi-nan.html)