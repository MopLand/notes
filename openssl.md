# OpenSSL

## RSA密钥生成命令

### 生成RSA私钥
	openssl genrsa -out rsa_private_key.pem 1024

### 生成RSA公钥
	openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem

### 将RSA私钥转换成PKCS8格式
	openssl pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt
	注意：“>”符号后面的才是需要输入的命令。

## Certbot 证书工具

### yum 安装
	
	yum install certbot

### pyOpenSSL 冲突

	# 删除原有安装
	yum remove certbot && pip uninstall pyOpenSSL

	# 更新 devel 工具
	yum install -y python-devel
	yum install -y openssl-devel

	# 安装 certbot
	yum install certbot

	# 安装 pyOpenSSL
	pip install pyOpenSSL

### 生成域名证书

#### 单个域名

	certbot certonly --email admin@veryide.com --agree-tos --webroot -w /disk/www/ssl.veryide.net -d ssl.veryide.net

#### 多个域名

	certbot certonly --email admin@veryide.com --agree-tos --webroot -w /disk/www/veryide.net -d veryide.net -d www.veryide.net -w /disk/www/veryide.com -d veryide.com -d www.veryide.com

#### 通配符证书

	# 执行脚本，使用 DNS 验证
	certbot --server https://acme-v02.api.letsencrypt.org/directory -d "*.veryide.net" --manual --preferred-challenges dns-01 certonly

	# 配置域名 TXT 记录
	_acme-challenge.veryide.net

### 续约证书

	# 不保存任何证书到磁盘
	certbot renew --dry-run

	# 强制更新，有次数限制
	certbot renew --dry-run --force-renewal

	# 更新完后，执行钩子脚本
	certbot renew --deploy-hook /disk/certserv.sh

### 定时更新脚本

	# 每周一凌晨4点30自动更新证书，更新成功就自动重启 Nginx 服务
	30 4 * * 1 certbot renew --deploy-hook "systemctl restart nginx" --quiet > /dev/null 2>&1 &

	# 每周一凌晨4点30自动更新证书，更新成功就执行 Shell 脚本
	30 4 * * 1 certbot renew --deploy-hook /disk/certserv.sh --quiet > /dev/null 2>&1 &

## Nginx 证书配置

	server {
		listen 443;
		ssl on;
		ssl_certificate /disk/certs/example.crt;
		ssl_certificate_key /disk/certs/.cert/example.key;
	}

## 参考资料
- [Let’s Encrypt 提供，有效期 90 天](https://www.sslforfree.com/)
- [Let’s Encrypt 证书生成教程](https://free.com.tw/ssl-for-free/)
- [https://blog.zengrong.net/post/2650.html](https://blog.zengrong.net/post/2650.html)