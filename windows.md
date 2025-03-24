# Windows

## 常用命令

### 清屏命令
	cls
	
### 切换目录
	cd [dir]
	
### 跨磁盘切换目录
	cd /d [dir]
	
### 显示目录中的内容
	dir [dir]
	
### 显示目录结构
	tree
	
### 文件或目录重命名
	ren [old] [new]
	
### 创建目录
	md [dir]
	
### 删除目录
	rd [dir]
	
### 拷贝文件
	copy [raw] [target]
	
### 移动文件
	move [file] [target]
	
### 一行命令中执行多个命令
	echo foo & echo bar
	
### 检测DNS域名解析(TXT)配置
	nslookup -qt=txt _acme-challenge.example.com

## 注册为 Windows 服务

### 命令创建
	sc create Nginx binPath= "D:\EasyPHP\eds-binaries\httpserver\nginx-1.6.3\start_nginx.bat" type= share start= auto displayname= "Nginx"

### 命令删除
	sc delete Nginx

### 相关软件
	Windows Service Wrapper
	
## U盘格式

### FAT32
	FAT32 文件系统用4个字节（32位）空间来表示每个扇区配置文件的情形，所以叫 FAT32。分区容量最低是 512M，而上限的话不同的操作系统都不一样，WinXP 系统最大可以做到 2TB 的FAT32分区。

### NTFS

	NTFS 文件系统是 Windows NT 核心和高级服务器网络操作系统环境的文件系统。NTFS 系统比 FAT32 的可靠性更高，可以支持更大的分区和更大的文件，此外还有不少 FAT32 没有的功能，比如压缩分区、文件索引、数据保护和恢复、加密访问等。

### exFAT

	exFAT 文件系统是微软在 Windows Embeded 5.0 以上引入的一种适合于闪存的文件系统，主要是为了解决 FAT32 不支持 4G 或更大文件的问题而推出的。
	

## 注册为 Windows 服务

### 下载 winsw

[https://github.com/kohsuke/winsw/releases](https://github.com/kohsuke/winsw/releases)

### 重命名
	
	# *.exe 和 *.xml 文件名要保持一致
	rename WinSW.NET4.exe myapp.exe

### myapp.xml 格式

	<?xml version="1.0" encoding="UTF-8" ?>
	<service>
	  <id>nginx</id>
	  <name>nginx</name>
	  <description>nginx</description>
	  <executable>F:\nginx-0.9.4\nginx.exe</executable>
	  <logpath>F:\nginx-0.9.4\</logpath>
	  <logmode>roll</logmode>
	  <depend></depend>
	  <startargument>-p F:\nginx-0.9.4</startargument>
	  <stopargument>-p F:\nginx-0.9.4 -s stop</stopargument>
	</service>

### 可用命令

#### 安装服务
	CMD:\> myapp.exe install

#### 卸载服务
	CMD:\> myapp.exe uninstall

#### 启动服务
	CMD:\> myapp.exe start

#### 停止服务
	CMD:\> myapp.exe stop
	
## .bat 批处理

	CHCP 65001

	@echo off
		
		@echo 淘宝订单
		php dora /cron/tborder/fetchNewlyOrder
		@echo ----------------
		
		@echo 京东订单
		php dora /cron/jdorder/newlyOrder
		@echo ----------------
		
		@echo 苏宁订单
		php dora /cron/suning/fetchOrder
		@echo ----------------
		
		@echo 拼多多订单
		php dora /cron/pddorder/newlyOrder
		@echo ----------------

		@echo 唯品会订单
		php dora /cron/viporder/newlyOrder
		@echo ----------------

		if %1 == "exit" ( exit )
		
	@pause

## .vbs VB 脚本

	Set ws = CreateObject("Wscript.Shell")
	ws.run "cmd /c fetchOrder.bat",vbhide
	
## 实用技巧

### 来电时自动启动
	BIOS > POWER MANAGEMENT SETUP > Turn On
	
### VSCode 终端颜色乱码

	# 下载 ansicon
	https://github.com/adoxa/ansicon
	
	# 解压 ansicon
	C:\Program Files\ANSICON
	
	# 配置 vscoode
	"terminal.integrated.shell.windows": "C:\\Program Files\\ANSICON\\x64\\ansicon.exe",
	
## 相关链接

- [bat命令入门与高级技巧详解](https://www.jb51.net/article/97204.htm)
- [为nginx创建windows服务自启动](https://www.cnblogs.com/JayK/p/3429795.html)
- [更强力的Windows Service Wrapper工具 -- WinSW](https://my.oschina.net/pierrecai/blog/895336)
- [使用ANSICON修正ANSI颜色转义序列，ansicon.exe -i 安装](https://github.com/adoxa/ansicon/releases)
