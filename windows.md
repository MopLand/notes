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

## 注册为 Windows 服务

### 命令创建
	sc create Nginx binPath= "D:\EasyPHP\eds-binaries\httpserver\nginx-1.6.3\start_nginx.bat" type= share start= auto displayname= "Nginx"

### 命令删除
	sc delete Nginx

### 相关软件
	Windows Service Wrapper
	
## 相关链接

- [bat命令入门与高级技巧详解](https://www.jb51.net/article/97204.htm)
