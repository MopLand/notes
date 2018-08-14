# Framework

## 基本架构

- Web（Nginx 阿里云）
- MySQL（阿里云/本地）
- 附件（与 Web 同台备份，异步至七牛云）

## 常用目录

- Web 程序：/disk/www
- Web 附件：/disk/attach
- MySQL 数据：/var/lib/mysql
- MySQL 备份：/disk/backup

## 七牛镜像

### MySQL 备份

- shell 脚本，每天备份至 /disk/backup
- qrshell 工具，定时同步至七牛 backup
- 参考 backup.sh

### 上传附件存储

- 附件上传汇总至 /disk/www/attach.zhfile.com/
- 给上传目录绑定域名：attach.src.zhfile.com
- 七牛资源绑定 CNAME：attach.zhfile.com
- 七牛资源设置镜像源：attach.src.zhfile.com
- attach 为任何可用标识，如：s1 ~ s9

### 公用静态资源

- 资源上传汇总至 /disk/www/public.zhfile.com/
- 给上传目录绑定域名：public.src.zhfile.com
- 七牛资源绑定 CNAME：public.zhfile.com
- 七牛资源设置镜像源：public.src.zhfile.com

### 建立软链接
	ln -s /disk/www/shihuizhu.com/attach/goods /disk/www/s3.zhfile.com/goods

### 上传附件配置

- s0.zhfile.com	商品图	
- s1.zhfile.com	阿里云	115.28.216.202	/disk/www/s1.zhfile.com
- s2.zhfile.com	商品图	119.29.76.42	/disk/www/s2.zhfile.com
- s3.zhfile.com	实惠猪	119.29.76.42	/disk/www/s3.zhfile.com
