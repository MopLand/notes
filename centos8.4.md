
# CentOS 8.4

## 内核更新
yum update

### PHP 8 在 CentOS 8 / RHEL 8 包存储库中不可用，我们必须启用 EPEL 和 remi 存储库
sudo dnf install -y epel-release
sudo dnf install -y centos-release-stream
sudo dnf install -y http://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo dnf install -y dnf-utils

### 清除 DNF 软件包管理器的缓存
dnf clean all

## 安装 PHP

### 查看可用的 PHP 版本
sudo dnf module list php

### 安装最新版本 PHP
sudo dnf module install -y php:remi-8.3

### 安装 PHP 扩展
sudo dnf install -y php-gd
sudo dnf install -y php-zip
sudo dnf install -y php-pdo
sudo dnf install -y php-pdo_mysql
sudo dnf install -y php-redis
sudo dnf install -y php-opcache
sudo dnf install -y php-imagick
sudo dnf install -y php-bcmath

### 配置 PHP-FPM
/etc/php-fpm.d/www.conf
user = nginx
group = nginx

### 修改权限
chown -R nginx:nginx /var/lib/php/session

## 安装 Nginx

### 查看可用的 Nginx 版本
sudo dnf module list nginx

### 安装最新版本 Nginx
sudo dnf module install -y nginx:1.20

### 如果无法安装，重置 Nginx 软件
sudo dnf module reset nginx

### 设置 Nginx 为自启动
systemctl enable nginx

### 启动 Nginx
systemctl start nginx

## 安装 Git

### 查看可用的 Git 版本
sudo dnf list git

### 安装最新版本 Git
sudo dnf install -y git

### 全局Git配置

	# 默认用户名
	git config --global user.name "Lay"

	# 合并策略
	git config --global pull.rebase false
	
	# 默认 Email
	git config --global user.email "veryide@qq.com"
	
	# 存储密码
	git config --global credential.helper store

### 添加 SSH 私钥
echo '-----BEGIN RSA PRIVATE KEY-----' >> /root/.ssh/id_rsa


## 克隆仓库

### 摘取远程仓库
git clone --depth 1 git@gitee.com:bangbang/JellyBox.git "/disk/www/baohe.com"

### 初始化项目
php dora init

### 修改权限
chown -R nginx:nginx /disk/www/baohe.com

## 安装 Nodejs

### 安装最新版本 Nodejs
sudo dnf module install -y nodejs:16

### 更改为国内镜像
npm config set registry https://registry.npmmirror.com

### 安装 PM2
npm install pm2 -g
npm install mysql -g

### 无法安装时，先清理缓存
npm cache verify

## 安装 CertBot

### 安装最新版本 Git
sudo dnf install -y certbot

### 验证版本号
certbot --version

### python 软链接
ln -s /usr/libexec/platform-python3.6 /usr/bin/python

## 其他

### 变更文件所有者
chown -R nginx:nginx /disk/www/assets.baohe.com

### 按特定用户变更
find /disk/www/assets.baohe.com -user 993 -exec chown nginx:nginx {} \;

### 各个项目拉取
git clone --depth 1 git@github.com:MopLand/Startup.git "/disk/www/startup"
git clone --depth 1 git@gitee.com:mopland/GeeZan.git "/disk/www/oa.baohe.com"
git clone --depth 1 git@gitee.com:bangbang/devops.git "/disk/www/dev.baohe.com"
git clone --depth 1 git@gitee.com:bangbang/Books.git "/disk/www/biz.baohe.com"
git clone --depth 1 git@gitee.com:bangbang/JellyBox_Go.git "/disk/www/go.baohe.com"
git clone --depth 1 git@gitee.com:mopland/Messager.git "/disk/www/Messager"
git clone --depth 1 git@git.oschina.net:bangbang/ShowCase.git "/disk/www/sku.baohe.com"
git clone --depth 1 git@gitee.com:MopLand/UrlShort.git "/disk/www/url.taoke.com"
git clone --depth 1 git@git.oschina.net:bangbang/JellyBox_CMS.git "/disk/www/cms.baohe.com"

###参考链接
- [如何在 CentOS 8 / RHEL 8 系统上安装 PHP 8 ?](https://zhuanlan.zhihu.com/p/615971837)
- [CentOS8安装PHP83](https://blog.csdn.net/tomjk/article/details/134073569)
