# firewall

## 配置firewalld

	# 查看版本
	firewall-cmd --version

	# 查看帮助
	firewall-cmd --help

## 查看设置

	# 显示状态
	firewall-cmd --state

	# 查看区域信息
	firewall-cmd --get-active-zones

	# 查看指定接口所属区域
	firewall-cmd --get-zone-of-interface=eth0

	# 拒绝所有包
	firewall-cmd --panic-on

	# 取消拒绝状态
	firewall-cmd --panic-off

	# 查看是否拒绝
	firewall-cmd --query-panic
	 
	# 更新防火墙规则
	# 两者的区别就是第一个无需断开连接，就是firewalld特性之一动态添加规则，第二个需要断开连接，类似重启服务
	firewall-cmd --reload
	firewall-cmd --complete-reload

## 开放指定端口

	firewall-cmd --zone=public --add-port=22/tcp --permanent
	firewall-cmd --zone=public --add-port=80/tcp --permanent
	
	# 作用域
	--zone

	# 添加端口，格式为：端口/通讯协议
	--add-port=80/tcp

	# 永久生效，没有此参数重启后失效
	--permanent   

## 开放指定服务
	firewall-cmd --permanent --add-service http
	firewall-cmd --permanent --add-service ftp
	 
## 规则更新

	# 将接口添加到区域，默认接口都在 public
	# 永久生效再加上 --permanent 然后 reload 防火墙
	firewall-cmd --zone=public --add-interface=eth0
	 
	# 设置默认接口区域，立即生效无需重启
	firewall-cmd --set-default-zone=public
	
	# 查看所有打开的端口
	# firewall-cmd --zone=dmz --list-ports

	# 加入一个端口到区域，若要永久生效方法同上
	firewall-cmd --zone=dmz --add-port=8080/tcp
	 
	# 打开一个服务，类似于将端口可视化，服务需要在配置文件中添加，/etc/firewalld 目录下有services文件夹，这个不详细说了，详情参考文档
	firewall-cmd --zone=work --add-service=smtp
	 
	# 移除服务
	firewall-cmd --zone=work --remove-service=smtp

## 常用命令
	
	# 重启防火墙
	systemctl restart firewalld

	# 启动服务
	systemctl start  firewalld

	# 服务状态
	systemctl status firewalld
	firewall-cmd --state

	# 停止服务
	systemctl disable firewalld

	# 禁用服务
	systemctl stop firewalld

	# 重载，使配置生效
	firewall-cmd --reload

