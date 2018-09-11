# ShadowSocks

## 安装

### 安装 pip
	yum install python-pip

### 安装 shadowsocks
	pip install --upgrade pip
	pip install shadowsocks

### 配置 shadowsocks

	# vi /etc/shadowsocks.json

	{
		"server": "0.0.0.0",
		"server_port": 8388,
		"password": "_PassWord_",
		"method": "aes-256-cfb"
	}

## 使用 systemd 管理

### 新建启动脚本

	# vi /etc/systemd/system/shadowsocks.service

	[Unit]
	Description=Shadowsocks

	[Service]
	TimeoutStartSec=0
	ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json

	[Install]
	WantedBy=multi-user.target

### 启动 shadowsocks 服务

	systemctl enable shadowsocks
	systemctl start shadowsocks

### 查看 shadowsocks 服务状态

	systemctl status shadowsocks -l

## 使用 supervisor 管理

### 安装 supervisor

	yum install supervisor

### 配置程序

	# vi /etc/supervisord.d/shadowsocks.ini

	[program:shadowsocks]
	command=ssserver -c /etc/shadowsocks.json
	autorestart=true
	user=nobody
	autostart=true
	autorestart=true

### 常用命令

	supervisorctl status                # 查看状态
	supervisorctl stop shadowsocks      # 停止 shadowsocks
	supervisorctl start shadowsocks     # 打开 
	supervisorctl restart shadowsocks   # 重启

## 参考资料

- [在 CentOS 7 下安装配置 shadowsocks](https://morning.work/page/2015-12/install-shadowsocks-on-centos-7.html)
- [安装 supervisor 守护进程](https://www.jianshu.com/p/d259911ca361)