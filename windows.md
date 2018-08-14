#Windows

##注册为 Windows 服务

###命令创建
	sc create Nginx binPath= "D:\EasyPHP\eds-binaries\httpserver\nginx-1.6.3\start_nginx.bat" type= share start= auto displayname= "Nginx"

###命令删除
	sc delete Nginx

###相关软件
	Windows Service Wrapper