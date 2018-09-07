# iptables

## 安装
	yum install iptables-services

## 查看配置
	iptables -nv -L

## 编辑配置
	vi /etc/sysconfig/iptables

## 常用指令

### 必需指令（不这样配置，自己都上不去）

	# 以下规则表示默认策略是ACCEPT
	:INPUT ACCEPT [0:0]
	:FORWARD ACCEPT [0:0]
	:OUTPUT ACCEPT [0:0]
	
	# 允许进入的数据包只能是刚刚我发出去的数据包的回应
	# ESTABLISHED：已建立的链接状态。RELATED：该数据包与本机发出的数据包有关。
	-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
	-A INPUT -p icmp -j ACCEPT
	
	# 允许本地环回接口在INPUT表的所有数据通信
	-A INPUT -i lo -j ACCEPT	

### 开放端口

	# 21 FTP, 22 SSH, 80 HTTP, 80 HTTPS, 3500 Nodejs, 3306 MySQL, 11211 Memcache
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 88 -j ACCEPT
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 2121 -j ACCEPT
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 3636 -j ACCEPT

### 允许指定端口段
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 40000:41000 -j ACCEPT

### 禁用指定端口
	-A PREROUTING -p tcp --dport 88 -j DROP

### 禁用某一IP的某一端口
	-A PREROUTING -p tcp --dport 21 -d 211.101.46.253 -j DROP

### 禁止单个IP
	-I INPUT -s 120.24.171.115 -j DROP
	-I INPUT -s 124.115.0.199 -j DROP
	-I INPUT -s 183.159.0.29 -j DROP
	-I INPUT -s 183.159.0.111 -j DROP
	-I INPUT -s 111.76.248.28 -j DROP
	-I INPUT -s 122.5.135.189 -j DROP
	-I INPUT -s 171.15.107.145 -j DROP
	-I INPUT -s 124.133.216.73 -j DROP
	-I INPUT -s 182.254.137.112 -j DROP
	-I INPUT -s 115.192.111.64 -j DROP
	-I INPUT -s 222.186.34.41 -j DROP

### 禁止整个IP段（123.0.0.1到123.255.255.254）
	-I INPUT -s 123.0.0.0/8 -j DROP

### 禁止后两位IP段（123.45.0.1到123.45.255.254）
	-I INPUT -s 123.45.0.0/16 -j DROP

### 禁止第4位IP段（123.45.6.1到123.45.6.254）
	-I INPUT -s 123.45.6.0/24 -j DROP

### 拒绝所有其他不符合上述任何一条规则的数据包
	-A INPUT -j REJECT --reject-with icmp-host-prohibited
	-A FORWARD -j REJECT --reject-with icmp-host-prohibited

## 常用命令

	# 临时关闭 SELinux
	setenforce 0

	# 永久关闭 SELinux
	vi /etc/selinux/config
	SELINUX=enforcing		#开启
	SELINUX=disabled		#关闭

	# 禁用 firewalld
	systemctl stop firewalld
	systemctl mask firewalld

	# 重启防火墙
	systemctl restart iptables

	# 开机启动防火墙
	systemctl enable iptables

	# 关闭防火墙
	systemctl stop iptables

## CentOS 6.x

	# 创建规则
	iptables -P OUTPUT ACCEPT

	# 存储规则
	service iptables save

	# 重启命令
	service iptables restart

## 高级实例

### 端口转发给内网其他机器

	vi /etc/sysctl.conf

	# 允许 IPv4 转发
	net.ipv4.ip_forward = 1

	# 加载内核参数设置
	/sbin/sysctl -p

	*filter
	# 允许 FORWARD 链
	-A FORWARD -p tcp --dport 9101 -j ACCEPT
	-A FORWARD -p tcp --sport 9101 -j ACCEPT
	...
	COMMIT

	*nat
	# 将 9101 端口转发至内网其他机器
	-A PREROUTING -p tcp -m tcp --dport 9101 -j DNAT --to-destination 10.66.195.15:9101
	-A POSTROUTING -d 10.66.195.15 -p tcp -m tcp --dport 9101 -j MASQUERADE
	...
	COMMIT