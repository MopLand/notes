#FTP 服务

## 安装 vsftpd
	
	# 查看是否已经安装vsftpd
	rpm -qa | grep vsftpd

	# 如果没有，就安装
	yum -y install vsftpd
	
	# 并设置开机启动
	chkconfig vsftpd on

## 配置 vsftpd

	vi /etc/vsftpd/vsftpd.conf
	
	# 服务器独立运行
	listen=YES

	# 设定不允许匿名访问
	anonymous_enable=NO

	# 设定本地用户可以访问。注：如使用虚拟宿主用户，在该项目设定为NO的情况下所有虚拟用户将无法访问
	local_enable=YES

	# 设定上传后文件的权限掩码
	local_umask=022
	
	# 设定可以进行写操作
	write_enable=YES

	# 禁止匿名用户上传
	anon_upload_enable=NO

	# 禁止匿名用户建立目录
	anon_mkdir_write_enable=NO

	# 不允许FTP用户离开自己主目录
	chroot_list_enable=YES

	# 禁止本地用户登出自己的FTP主目录
	chroot_local_user=YES

	# 对vsftpd有用，否则，因home目录权限为root权限而无法登录
	allow_writeable_chroot=YES 

	# 对vsftpd-ext有用
	allow_writable_chroot=YES

	# 启用 chroot_list
	chroot_list_file=/etc/vsftpd/chroot_list

	# 设定支持ASCII模式的上传和下载功能
	ascii_upload_enable=YES
	ascii_download_enable=YES

	# PAM认证文件名。PAM将根据/etc/pam.d/vsftpd进行认证
	pam_service_name=vsftpd

	# 设定启用虚拟用户功能
	# guest_enable=YES

	# 指定虚拟用户的宿主用户，CentOS中已经有内置的ftp用户了
	# guest_username=ftp

	# 设定虚拟用户个人vsftp的CentOS FTP服务文件存放路径
	# 存放虚拟用户个性的CentOS FTP服务文件(配置文件名=虚拟用户名)
	user_config_dir=/etc/vsftpd/vuser_conf

	# 设定禁止上传文件更改宿主
	# chown_uploads=NO

	# 配置vsftpd日志（可选）
	xferlog_enable=YES
	xferlog_std_format=YES
	xferlog_file=/var/log/xferlog
	dual_log_enable=YES
	vsftpd_log_file=/var/log/vsftpd.log

	# 监听指定端口
	listen=YES
	listen_port=2121

## 进行认证

	# 安装Berkeley DB工具，很多人找不到db_load的问题就是没有安装这个包
	yum install db4 db4-utils
	
	# 创建用户密码文本，注意奇行是用户名，偶行是密码
	vi /etc/vsftpd/vuser_passwd.txt
	
	test
	123456
	
	# 生成虚拟用户认证的db文件
	db_load -T -t hash -f /etc/vsftpd/vuser_passwd.txt /etc/vsftpd/vuser_passwd.db
	
	# 编辑认证文件，全部注释掉原来语句，再增加以下两句
	vi /etc/pam.d/vsftpd
	
	auth required pam_userdb.so db=/etc/vsftpd/vuser_passwd
	account required pam_userdb.so db=/etc/vsftpd/vuser_passwd
	
	# 创建虚拟用户配置文件
	mkdir /etc/vsftpd/vuser_conf/

	# 文件名等于vuser_passwd.txt里面的账户名，否则下面设置无效
	vi /etc/vsftpd/vuser_conf/test
	
	# 虚拟用户根目录,根据实际情况修改
	local_root=/data/ftp
	write_enable=YES
	anon_umask=022
	anon_world_readable_only=NO
	anon_upload_enable=YES
	anon_mkdir_write_enable=YES
	anon_other_write_enable=YES


##设置FTP根目录权限

	# 最新的vsftpd要求对主目录不能有写的权限所以ftp为755，主目录下面的子目录再设置777权限
	mkdir /data/ftp
	chmod -R 755 /data
	chmod -R 777 /data/ftp
	
	# 建立限制用户访问目录的空文件
	touch /etc/vsftpd/chroot_list
	
	# 如果启用vsftpd日志需手动建立日志文件
	touch /var/log/xferlog 
	touch /var/log/vsftpd.log


##配置PASV模式（可选）

> vsftpd默认没有开启PASV模式，现在FTP只能通过PORT模式连接，要开启PASV默认需要通过下面的配置

	打开/etc/vsftpd/vsftpd.conf，在末尾添加
	
	# 开启PASV模式
	pasv_enable=YES

	# 最小端口号
	pasv_min_port=40000

	# 最大端口号
	pasv_max_port=41000
	
	# 此选项激活时，将关闭PASV模式的安全检查
	pasv_promiscuous=YES
	
	# 在防火墙配置内开启40000到40080端口
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 40000:41000 -j ACCEPT
	
	# 重启iptabls和vsftpd
	service iptables restart
	service vsftpd restart
	
	# 现在可以使用PASV模式连接你的FTP服务器了~

## 启动
	service vsftpd start

## 常见问题

### 创建用户时，确保与上层目录同一个组（nginx）
	useradd -d /disk/www/www.taokezhu.cn -g nginx -s /sbin/nologin hunhun

### 上层目录必需要有写权限（root:root 用户和组）
	chmod 755 /disk/www/

### 子目录读写权限（hunhun:nginx 用户和组）
	chmod 755 /disk/www/www.taokezhu.cn/

### 用户可以离开主目录（否则从中移除 hunhun）
	/etc/vsftpd/chroot_list

### 开启被动模式
	vi /etc/vsftpd/vsftpd.conf
	pasv_enable=YES
	pasv_min_port=40000
	pasv_max_port=41000

### iptables 影响
	vi /etc/sysconfig/iptables-config
	IPTABLES_MODULES="ip_conntrack_netbios_ns ip_conntrack_ftp"

	vi /etc/sysconfig/iptables
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 40000:41000 -j ACCEPT

### 关闭 SELINUX（需要重启）
	vi /etc/selinux/config
	SELINUX=disabled

