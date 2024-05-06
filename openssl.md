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

	# 更新 CA 证书	
	yum -y update ca-certificates

	# 删除原有安装
	yum remove certbot && pip uninstall pyOpenSSL

	# 更新 devel 工具
	yum install -y python-devel
	yum install -y openssl-devel

	# 安装 certbot
	yum install -y certbot

	# 安装 pyOpenSSL
	pip install -y pyOpenSSL

	# 新版本软链接
	rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python

### 生成域名证书

#### 单个域名
	certbot certonly --email admin@veryide.com --agree-tos --webroot -w /disk/www/ssl.veryide.net -d ssl.veryide.net

#### 多个域名
	certbot certonly --email admin@veryide.com --agree-tos --webroot -w /disk/www/veryide.net -d veryide.net -d www.veryide.net -w /disk/www/veryide.com -d veryide.com -d www.veryide.com
	
#### 证书目录
	/etc/letsencrypt/live/

#### 通配符证书

	# 执行脚本，手动 DNS 验证
	certbot --server https://acme-v02.api.letsencrypt.org/directory -d "*.veryide.net" --manual --preferred-challenges dns-01 certonly

	# 配置域名 TXT 记录
	_acme-challenge.veryide.net
	
	# 全自动化 DNS 验证
	certbot --server https://acme-v02.api.letsencrypt.org/directory -d "*.taokebaohe.com" --manual --preferred-challenges dns-01 certonly --manual-auth-hook /disk/shell/certbot-auth-dnspod.sh --deploy-hook /disk/shell/certbot-deploy.sh

### 续约证书

	# 不保存任何证书到磁盘
	certbot renew --dry-run

	# 强制更新，有次数限制
	certbot renew --dry-run --force-renewal

	# 更新完后，执行钩子脚本
	certbot renew --deploy-hook /disk/shell/certbot-deploy.sh
	
### 撤销证书
	certbot revoke --cert-path /etc/letsencrypt/archive/lanpixia.com/cert1.pem
	
### 删除证书
	certbot delete --cert-name lanpixia.com

### 定时更新脚本

	# 每周一凌晨3点30自动更新证书，更新成功就自动重启 Nginx 服务
	30 3 * * 1 certbot renew --deploy-hook "systemctl restart nginx" --quiet > /dev/null 2>&1 &

	# 每周一凌晨3点30自动更新证书，更新成功就执行 Shell 脚本
	30 3 * * 1 certbot renew --deploy-hook /disk/shell/certbot-deploy.sh --quiet > /dev/null 2>&1 &
	
	# 每周一凌晨3点30自动更新证书，更新成功就执行 Shell 脚本
	30 3 * * 1 certbot renew --manual-auth-hook /disk/shell/certbot-auth-dnspod.sh --deploy-hook /disk/shell/certbot-deploy.sh --quiet > /dev/null 2>&1 &
	
### 单域名文件验证
	certbot certonly --email admin@veryide.com --agree-tos --webroot -w /disk/www/ssl.veryide.net -d ssl.veryide.net --manual-auth-hook /disk/shell/certbot-auth-file.sh
	
### DNSPOD 解析认证

	# 在 dnspod 生成 API Token
	https://www.dnspod.cn/console/user/security
	
	# 并以 ID,Token 形式存入 /etc/dnspod_token 或 /disk/certs/dnspod_token
	91302,effb4ff11b869b26d99cbe086f8china
	
	# certbot 指定手动验证钩子
	certbot renew --manual-auth-hook /disk/shell/certbot-auth-dnspod.sh --deploy-hook /disk/shell/certbot-deploy.sh	

## Nginx 证书配置

	server {
		listen 443;
		ssl on;
		ssl_certificate /disk/certs/example.crt;
		ssl_certificate_key /disk/certs/.cert/example.key;
	}
	
## Apahce 证书配置

	<VirtualHost app.baohe.test:443>
		DocumentRoot "E:\Works\Baohe\run"
		ServerName app.baohe.test		
		# HTTPS 支持
		SSLEngine on
		SSLCertificateFile "E:/EasyPHP/certs/example.test.pem"
		SSLCertificateKeyFile "E:/EasyPHP/certs/example.test-key.pem"
	</VirtualHost>

## 常见错误

### SSLError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed
	yum install ca-certificates openssl
	
### TypeError: __str__ returned non-string (type Error)
	升级 Python 3.x 以上版本，或者安装 python2-certbot 版本（yum install python2-certbot），亦或者需要更新 CA 证书
	
### PHP SSL operation failed with code 1. OpenSSL Error messages: SSL routines:ssl3_get_server_certificate:certificate verify failed
	cd /disk/certs/ && wget https://curl.haxx.se/ca/cacert.pem --no-check-certificate -O cacert.pem
	openssl.cafile=/disk/certs/cacert.pem


## 参考资料
- [Let’s Encrypt 提供，有效期 90 天](https://www.sslforfree.com/)
- [Let’s Encrypt 证书生成教程](https://free.com.tw/ssl-for-free/)
- [使用 Let's Encrypt 加入全站 HTTPS 支持](https://blog.zengrong.net/post/2650.html)
- [Certbot 申请的 https 证书续期报错的解决方案](https://learnku.com/articles/16996/certbot-application-for-https-certificate-renewal-error-reporting-solution)
- [使用Certbot获取免费泛域名(通配符)证书](https://www.jianshu.com/p/1eb7060c5ede)
- [Certbot DNS Authenticator For DNSPod](https://github.com/al-one/certbot-auth-dnspod/)
- [Certbot 更改证书的域](https://www.wangan.com/docs/1252)
- [A simple zero-config tool to make locally trusted development certificates with any names you'd like.](https://github.com/FiloSottile/mkcert)
- [使用mkcert工具生成受信任的SSL证书，解决局域网本地https访问问题](https://cloud.tencent.com/developer/article/2191830)
- [用 mkcert 為 Apache 建立 vhost 的 SSL 安全連線](https://zhung.com.tw/article/%e7%94%a8mkcert%e7%82%baapache%e5%bb%ba%e7%ab%8bvhost%e7%9a%84ssl%e5%ae%89%e5%85%a8%e9%80%a3%e7%b7%9a/)
