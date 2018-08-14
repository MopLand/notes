#IIS 6.0


##Rewrite

###安装
	ISAPI_Rewrite3_0112[_ia64].msi

###配置
	C:/Program Files/Helicon/ISAPI_Rewrite3/httpd.conf

	RegistrationName= coldstar
	RegistrationCode= 2EAD-35GH-66NN-ZYBA

###权限
	.htaccess文件需要IIS进程用户的访问权
	一般为 iis_wpg 或 Network Serivce 可读

##FastCGI

###安装
	fcgisetup_1.5_rtw_x86.msi

###打开 C:\WINDOWS\system32\inetsrv\fcgiext.ini

	[Types]
	php=PHP
	
	[PHP]
	ExePath=D:\php\php-cgi.exe

##php.ini 配置

	cgi.fix_pathinfo = 1
	
	fastcgi.impersonate = 1
	
	extension_dir = "D:\php\ext"

##IIS 配置

###右键网站 -> 属性 -> 主目录 -> 配置 -> 添加

###可执行文件
	C:\WINDOWS\system32\inetsrv\fcgiext.dll

###扩展名
	php