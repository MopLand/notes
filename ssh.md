#SSH

## 文件格式

### authorized_keys

	rsa 格式公钥（部署在 ~/.ssh 中）
	-------------------------------
	ssh-rsa AAAAB3NzaC1yc2EAAA... Lay-RSA-Key

### known_hosts

	记录远程服务器对应的公钥信息
	-------------------------------
	git.oschina.net,120.55.239.11 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzd...

### id_rsa.pub

	rsa 格式公钥
	-------------------------------
	ssh-rsa AAAAB3NzaC1yc2EAAA... Lay-RSA-Key

### id_rsa 或 id_rsa.pem

	rsa 格式私钥（Git 通信使用）
	-------------------------------
	-----BEGIN RSA PRIVATE KEY-----
	MIIEogIBAAKCAQEA6KHsAAKCAQEA6KHstsAl9e3...
	-----END RSA PRIVATE KEY-----

### id_rsa.ppk

	PuTTY 独有的私钥（可以使用 TortoiseGit\bin\puttygen 生成）
	-------------------------------
	PuTTY-User-Key-File-2: ssh-rsa
	Encryption: aes256-cbc
	Comment: Lay-RSA-Key
	Public-Lines: 4
	AAAAB3NzaC1yc2EAAAABJQAAAI...
	Private-Lines: 8
	QoV02upH2Id7kEyVZuBxaxX+OO...
	Private-MAC: 40757644f8b14a8707b01f44314d6d8ac2386dd9	
	
### 权限定义
	chmod 0400 /root/.ssh/id_rsa
	chmod 0400 /root/.ssh/id_rsa.pub
	chmod 0644 /root/.ssh/known_hosts
	chmod 0644 /root/.ssh/authorized_keys

## 常用命令

### 生成SSH证书并复制到远端服务器

	ssh-keygen -y -f ~/.ssh/id_rsa &&　cat ~/.ssh/id_rsa.pub | ssh root@host "cat - >> ~/.ssh/authorized_keys"

### 通过SSH快速备份文件到另一服务器
	tar zcvf - /disk/www/ | ssh root@www.jb51.net tar xzf - -C /backup/www/

## 登录命令

### 指定账户
	ssh root@192.168.0.11

### 密钥登录
	ssh -i /root/.ssh/id_rsa root@127.0.0.1

### 指定端口
	ssh -p 12333 192.168.0.11 
	ssh -l root -p 12333 216.230.230.114
	ssh -p 12333 root@216.230.230.114

----------
	
## Git 配置多个 SSH-Key

### 创建配置文件
	# vi ~/.ssh/config

### 文件内容如下

	# Lay
	Host gitee.com
		HostName gitee.com
		PreferredAuthentications publickey
		IdentityFile ~/.ssh/id_rsa
		User git

	# XiaoWang
	Host gitee
		HostName gitee.com
		PreferredAuthentications publickey
		IdentityFile ~/.ssh/id_rsa_xw
		User git

### 配置文件参数

	# Host : Host可以看作是一个你要识别的模式，对识别的模式，进行配置对应的的主机名和ssh文件
	# HostName : 要登录主机的主机名
	# User : 登录名
	# IdentityFile : 指明上面User对应的identityFile路径

----------

## SCP 远程拷贝

### 命令格式
	scp [参数] [原路径] [目标路径]

### 命令参数
	-1  强制scp命令使用协议ssh1
	-2  强制scp命令使用协议ssh2
	-4  强制scp命令只使用IPv4寻址  
	-6  强制scp命令只使用IPv6寻址  
	-B  使用批处理模式（传输过程中不询问传输口令或短语）  
	-C  允许压缩。（将-C标志传递给ssh，从而打开压缩功能）  
	-p 保留原文件的修改时间，访问时间和访问权限。  
	-q  不显示传输进度条。  
	-r  递归复制整个目录。  
	-v 详细方式显示输出。scp和ssh(1)会显示出整个过程的调试信息。这些信息用于调试连接，验证和配置问题。  
	-c cipher  以cipher将数据传输进行加密，这个选项将直接传递给ssh。   
	-F ssh_config  指定一个替代的ssh配置文件，此参数直接传递给ssh。  
	-i identity_file  从指定文件中读取传输时使用的密钥文件，此参数直接传递给ssh。    
	-l limit  限定用户所能使用的带宽，以Kbit/s为单位。    
	-o ssh_option  如果习惯于使用ssh_config(5)中的参数传递方式，   
	-P port  注意是大写的P, port是指定数据传输用到的端口号   
	-S program  指定加密传输时所使用的程序。此程序必须能够理解ssh(1)的选项。

### 指定传输时使用的密钥文件
	scp -i /root/.ssh/id_rsa root@127.0.0.1

### 从远处复制文件到本地目录
	scp root@192.168.120.204:/opt/soft/nginx-0.5.38.tar.gz /opt/soft/

### 从远处复制到本地
	scp -r root@192.168.120.204:/opt/soft/mongodb /opt/soft/

### 上传本地文件到远程机器指定目录
	scp /opt/soft/nginx-0.5.38.tar.gz root@192.168.120.204:/opt/soft/scptest

### 上传本地目录到远程机器指定目录
	scp -r /opt/soft/mongodb root@192.168.120.204:/opt/soft/scptest

----------

## Windows 免密码登录

### 配置 vi /etc/ssh/sshd_config
	RSAAuthentication yes
	PubkeyAuthentication yes
	AuthorizedKeysFile	.ssh/authorized_keys
	
	#禁止root登录（如果需要）
	PermitRootLogin no

### 上传 id_rsa.pub 到 /root/
	scp .ssh/id_rsa.pub root@192.168.1.181:/root/.ssh/id_rsa.pub

### 复制 id_rsa.pub 到 .ssh/authorzied_keys
	cat .ssh/id_rsa.pub >> .ssh/authorized_keys
	chmod 600 .ssh/authorized_keys

### 删除 id_rsa.pub
	rm ~/.ssh/id_rsa.pub

### Putty 配置
	/Connection/SSH/Auth	加载私钥文件（Private key）
	/Connection/Data		Auto-login 用户名（username）

### 重启 ssh
	service sshd restart

----------

## CentOS 7

### Step 1

	# 修改/etc/ssh/sshd_config
	vi /etc/ssh/sshd_config

	#Port 22         //这行去掉#号
	Port 20000      //下面添加这一行

### Step 2

	# 允许 ssh-agent 转发
	vim ~/.ssh/config
	
	Host *
	ForwardAgent yes

### Step 3

	使用以下命令查看当前SElinux 允许的ssh端口：
	semanage port -l | grep ssh
	
	添加20000端口到 SELinux
	semanage port -a -t ssh_port_t -p tcp 20000
	
	然后确认一下是否添加进去
	semanage port -l | grep ssh

	如果成功会输出
	ssh_port_t		tcp		20000, 22

### Step 3
	systemctl restart sshd.service
	service sshd restart

----------

## Mac

### 默认终端

	ssh-agent
	ssh-add ~/.ssh/id_key

----------

### iTerm2，Default > Command > Send text at start

	ssh-agent; ssh-add ~/.ssh/id_rsa.pem;