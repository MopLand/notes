# YAF

## Windows

### 安装
	将 php_yaf.dll 和 php_yaf.pdb，复制到	php/ext

### php.ini
	extension=php_yaf.dll

## CentOS

### 安装 php-devel
	yum --enablerepo=remi,remi-test install php-devel

### 安装 YAF
	pecl install yaf

### 添加 php.ini
	extension=yaf.so

## 配置

	# 使用命名空间
	yaf.use_namespace=On

	# 开发或者生产环境
	yaf.environ=develop

