# Composer

> PHP Composer 安装与使用说明

## 安装

### Linux 

	curl -sS https://getcomposer.org/installer | php
	mv composer.phar /usr/local/bin/composer

### Windows

	# 基本 CLI
	https://getcomposer.org/Composer-Setup.exe

	# 友好 GUI
	https://www.getcomposercat.com/

## 常用命令

### 中国镜像
	
	composer config repo.packagist composer https://packagist.laravel-china.org

	composer config -g repo.packagist composer https://packagist.phpcomposer.com

### 查看版本号
	composer -V

### 下载包，根据 composer.json 配置
	composer install

### 更新包（更新项目依赖）
	composer update

### 指明具体的包
	composer update vendor/package vendor/package2

### 新增包（申明依赖）
	composer require vendor/package:2.* vendor/package2:dev-master

### 搜索包
	composer search monolog

### 查看包（查看项目依赖）
	composer show

### 根据指定包名查看
	composer show monolog/monolog

## composer.json

	{
		"name":             "meta/silk",
	    "description":      "The sample program",
	    "keywords":         ["silk", "online shop", "good"],
	    "homepage":         "http://www.veryide.com ",
	    "time":             "2018-10-10",
	    "license":          "GPL",
		"require": {
			"elasticsearch/elasticsearch": "^5.3"
		},
		"autoload": {
			"psr-4": {
				"App\\": "app/",
				"Library\\": "library/"
			}
		},
		"scripts": {
			"post-autoload-dump": "@php vendor/optimize.php"
		}
	}

## 发布包

### 将项目发布到 Github

- 在根目录里创建 .gitignore 文件，把 vendor 目录和 composer.lock 文件排除 Git 之外

		cat .gitignore
		vendor/*
		composer.lock

- 推送代码至 GitHub

		git init
		git add .
		git commit -m "First commit"
		git remote add origin git@github.com:username/hello.git
		git push origin master


### 将项目在 Packagist 上注册

1. 在 [Packagist](https://packagist.org/packages/submit) 上注册账号并提交之前的 Github 项目

2. Packagist 会去检测此仓库地址的代码是否符合 Composer 的 Package 包的要求

3. 从 Packagist 获取 token，然后去 Github 配置下对应的 GitHub Service Hook 实现代码提交后 Packagist 自动拉取更新

## 参考文档

- [https://packagist.org/](https://packagist.org/)
- [http://docs.phpcomposer.com/](http://docs.phpcomposer.com/)
- [http://www.chenjie.info/1880](http://www.chenjie.info/1880)