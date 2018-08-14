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
	scp -i /root/.ssh/id_rsa root@127.0.0.1	

### 指定端口
	ssh -p 12333 192.168.0.11 
	ssh -l root -p 12333 216.230.230.114
	ssh -p 12333 root@216.230.230.114

----------

## Windows 免密码登录

### 配置 vi /etc/ssh/sshd_config
	RSAAuthentication yes
	PubkeyAuthentication yes
	AuthorizedKeysFile	.ssh/authorized_keys
	
	#禁止root登录（如果需要）
	PermitRootLogin no

### 上传 id_rsa.pub 到 /root/
	scp .ssh/id_rsa.pub root@192.168.1.181:/root/id_rsa.pub

### 复制 id_rsa.pub 到 .ssh/authorzied_keys
	cat id_rsa.pub >> .ssh/authorized_keys
	chmod 600 .ssh/authorized_keys

### 删除 id_rsa.pub
	rm ~/id_rsa.pub

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

	ssh-agent
	ssh-add ~/.ssh/id_key

----------

	ssh-agent; ssh-add ~/.ssh/id_rsa.pem;