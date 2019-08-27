# Laravel

## 安装
	composer global require laravel/installer

## 起步

	# 创建项目
	laravel new blog
	
	# 进入目录，并执行安装
	cd blog && composer install
	
	# 生成 Key
	php artisan key:generate
	
	# 运行项目
	php artisan serve