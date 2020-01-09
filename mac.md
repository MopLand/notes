# Mac

## Brew

### 安装 Brew
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

### 使用 Brew
	brew install wget

### 安装常用工具
	xcode-select --install
	brew install autoconf automake libtool
	
## 更新 Git
	
### 查看 Git 版本
	git --version

### 安装 Git
	brew install git
	
### 更改 Git 指向
	brew link git --overwrite
	
### 查看 Git 版本
	git --version

## XAMPP - PHP集成开发环境

## 安装 XAMPP
	https://www.apachefriends.org/download.html

## 安装 PHP Redis 扩展
	cd /Applications/XAMPP/bin
	sudo ./pecl install redis
	php.ini: extension="redis.so"

## 安装 Redis 服务
	brew install redis
	brew services start redis
	
## Mac 调优

### 安装非 App Store 应用

1. 系统偏好设置 > 安全性与隐私
	
2. 『点击锁按钮以进行更改』
	
3. 允许从以下位置下载的应用：任何来源

### NTFS 格式支持

	# 安装 Tuxera NTFS	
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
