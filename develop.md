# Develop

## 基础知识

### 目录结构
	app									# 应用目录
		master							# 默认应用
			module.php					# 模块配置（可选）
			controller					# 控制器
				index.php				# index 控制器
			model						# 模型
			views						# 视图
				index					# index 视图目录
					index.php			# indexAction 对应视图
		admin
			module.php					# 模块配置（可选）
			controller					# 控制器
			model						# 模型
			views						# 视图

	attach								# 上传附件
		image							# 图片
		flash							# Flash
		media							# 多媒体
		mixed							# 其它文件

	config								# 配置文件
		attach.php						# 附件上传
		config.php						# 常规配置
		email.php						# 邮件配置
		domain.php						# 域名配置
		global.php						# 全局配置
		project.php						# 项目配置
		licence.php						# 授权文件
		...								# 其它配置

	cached								# 缓存目录
		compile							# 编译缓存
		dataset							# 数据缓存
		memorys							# 临时缓存
		modules							# 模块配置

	library								# 公共类库
		...								# 各种类库

	public								# 公共资源
		js								# JS 类库
		vue								# Vue 类库
		jquery							# jQuery 类库
		fonts							# 字体资源
		charts							# 报表组件
		errors							# 错误视图
		editor							# 编辑器资源、脚本
		awesome							# 字符图标
		location						# 位置数据
		lightbox						# LightBox 图片展示插件
		template						# 公共模板，包含设置和邮件模板
		bootstarp						# Bootstarp CSS 框架

	static								# 项目资源
		js								# JS 类库
		admin							# 后台资源
		style							# CSS 样式
		sprite							# CSS 图片
		images							# 图片资源

	views								# master 视图
		index							# indexController 视图目录
			index.php					# indexAction 对应视图

	vendor								# 依赖类库
		autoload.php					# 类库自动加载脚本
		gitbuild.php					# Git 提交自动版本号
		optimize.php					# Composer 优化脚本
		initialize.php					# 项目配置初始化脚本
		composer						# Composer 核心文件

	index.php							# 入口文件
	crossdomain.xml						# Flash 跨域配置
	composer.json						# Composer 配置
	robots.txt							# 搜索引擎规则
	README.md							# ReadMe 文件
	.htacess							# Apache 规则
	.gitignore							# Git 忽略规则

### 特殊目录
	_doc				项目数据字典、文档和其他
	cron				任务脚本相关（通常是 Nodejs）

### 目录权限

	# 可读 0644
	# chmod -R 0644 ./
	./*

	# 可读可写 0755
	# chmod -R 0755 ./attach/ ./config/ ./cached/
	./attach/
	./config/
	./cached/

### 书写规范

#### 工具推荐
	Atom / VS Code

#### 编码约定

	1.统一使用 UTF-8 编码
	2.统一使用 TAB 4 个字符宽度来控制缩进
	3.PHP / JS 定义类、函数以及重要算法必需要有注释
	4.CSS / HTML 内容需按结构层次控制缩进
	5.CSS 必需有基本的注释说明

#### 目录和文件

	1.目录和文件均使用小写 + 下划线
	2.类库、函数文件统一以 .php 为后缀
	3.类的文件名均以命名空间定义，并且命名空间的路径和类库文件所在路径一致
	4.类文件采用驼峰法命名（首字母大写），其它文件采用小写+下划线命名
	5.类名和类文件名保持一致，统一采用驼峰法命名（首字母大写）
	6.公共资源目录（./public/）因为是所有项目通用环境，禁止特例更改
	7.独立于项目的静态资源存放在 ./static/ 目录

#### 函数和类、属性命名

	1.类的命名采用驼峰法（首字母大写），例如 User、UserType，需要添加后缀，例如 UserController 和 UserModel
	2.函数的命名使用小写字母和下划线（小写字母开头）的方式，例如 get_client_ip
	3.方法的命名使用驼峰法（首字母小写），例如 getUserName
	4.属性的命名使用驼峰法（首字母小写），例如 tableName、instance
	5.以双下划线 “__” 打头的函数或方法作为魔术方法，例如 __call 和 __autoload
	6.所有的方法必须声明可见性，例如：public、private 和 protected
	7.禁止使用短标记，例如：<?= .............. ?>
	8.为防止 php 直接访问，需要在文件开始部分加上：<?php !defined('DOC_ROOT') && die('Access Denied');

#### 常量和配置

	1.常量以大写字母和下划线命名，例如 DOC_ROOT 和 MOD_ROOT
	2.配置参数以小写字母、下划线或点命名，例如 url_route_on、 url_convert 和 router.regular
	3.常量必需使用大写，例如：TRUE, FALSE, NULL

#### 类命名空间规范

	1.应用的根命名空间统一为 App
	2.类库的根命名空间统一为 Library

#### 数据表和字段

	1.数据库优先编码：UTF-8
	2.数据库存储引擎：InnoDB
	3.数据库命名规范：[项目] + [模块]，例如：tengcu_oa
	4.数据表命名规范：[前缀] + [模块] + [表名]，例如：
		pre_agent_list		代理主表
		pre_agent_payment	代理提现表

	5.数据表字段命名示例：
		单一字段
		id			自增ID
		status		状态值

		关联字段
		agent_id	代理ID
		agent_name	代理名称

		字段类型
		id			自增ID		int(11)	
		sn			序列号		varchar(16)				#使用 Toolkit::getrandstr() 方法生成
		trade		支付流水号	varchar(32)
		status		状态			tinyint(2)
		receive		领取状态		tinyint(2) unsigned		#unsigned 表示不包含负值
		dateline	时间			int(11)					#时间戳
		datetime	YMD格式时间	int(11)					#为了加快索引

	6.数据表和字段采用小写加下划线方式命名，并注意字段名不要以下划线开头，例如 think_user 表和 user_name 字段
	7.不建议使用驼峰和中文作为数据表字段命名

#### 前端约定
	
	1.尽量不使用JQuery，如有必要请引用 /public/jquery/jquery.min.js
	其中还包含 jquery.resize、jquery.validate、jquery.waterfall、jquery.zoom 等插件
	
	2.前端 MVVM 框架请使用 Vue.js
	http://cn.vuejs.org/

	3.优先使用 Webkit 渲染，针对 360、QQ 等双核浏览器有效：
	<meta name="renderer" content="webkit">

### GIT 约定

#### 本地忽略配置文件变化

	1.【重要】忽略本地配置文件的更改，防止影响生产环境配置
	git update-index --assume-unchanged config/attach.php
	git update-index --assume-unchanged config/config.php
	git update-index --assume-unchanged config/domain.php
	git update-index --assume-unchanged config/email.php
	git update-index --assume-unchanged config/global.php
	git update-index --assume-unchanged config/licence.php

	2.重新跟踪文件变化
	git update-index --no-assume-unchanged config/example.php

	3.脚本化工具（内容同上）
	Windows
	work/ignore.bat
	
	Linux
	work/ignore.sh

#### 提交时自动更新版本号

	1. 创建 hooks 文件：.git/hooks/pre-commit

	#!/bin/sh
	# 自动更新版本号
	php vendor/gitbuild.php
	exec git add ./config/project.php

	2. 将在每次提交时，自动更新 config/project.php

	product.build

### 项目初始化

	# 命令行执行
	php vendor/initialize.php

	# 主要工作项
	将自动完成 config/config.php 中的各种秘钥更新，创建 cached 子目录

### 开发环境

	# php.ini
	# 未定义时，将在程序中标识为 product
	# 通常有 product 或 develop

	[app]
	app.environ = develop

	# 可以在控制器中读取
	$this->_environ

	# 使用 PHP 函数获取
	get_cfg_var('app.environ')

### 系统常量

	# 目录分隔符
	DS

	# 系统根目录
	DOC_ROOT

	# 当前模块根目录
	MOD_ROOT

	# 系统工作方式（自定义 | 标准 MVC）
	APP_MODE : special | general

	# 应用层目录
	APP_ROOT

	# 当前模块相对路径
	APP_BASE

### 命名空间

	# PHP 内置类
	$class = new \stdClass();
	$xml  =  new \SimpleXmlElement( $string );

	# 定义函数类
	namespace Library\Wechat;
	class SHA1 { }

	# 调用函数类
	$class = new \Library\Wechat\SHA1();

	# 调用模型类
	$model = new \App\Master\Model\Goods();

	# 根命名空间
	Library			./library/
	App				./app/
	Model			

## 配置文件

### 常规配置

	# 数据库、缓存等配置
	config/config.php

	# 本地和上传附件配置
	config/attach.php

	# 邮件配置
	config/emaill.php

	# 全局配置选项
	config/global.php

	# 项目配置
	config/project.php

### 模块模块
	app/*/module.php

## 路由规则

### 常规方式

	# URL
	http://example.com

	# 对应方法
	App\Master\Controller\Index\indexAction

	----------------------

	# URL
	http://example.com/course

	# 对应方法
	App\Master\Controller\Course\indexAction

	----------------------

	# URL
	http://example.com/course/list

	# 对应方法
	App\Master\Controller\Course\listAction

	----------------------

	# URL
	http://example.com/course/item/123

	# 对应方法
	App\Master\Controller\Course\itemAction( $id )

	----------------------

	# URL
	http://example.com/course/item/123/live

	# 对应方法
	App\Master\Controller\Course\itemAction( $id, $cate )

	----------------------

	# URL
	http://example.com/course/art

	# 对应方法
	App\Master\Controller\Course\defaultAction( $cate )

### 路由过滤

	# URL
	http://example.com/coupon/

	# 规则匹配，定义在 ./app/*/module.php
	# 目标 URL 必需包含完整的 [Controller] 和 [Action]，否则会抛出 404 错误
	'router.filter' => array(

		# Bad
		'/^\/(today|week|month|ratio|grade|coupon)/' => '/find/?word=\1',

		# Good
		'/^\/(today|week|month|ratio|grade|coupon)/' => '/find/index/?word=\1',

		# 将 Fn 请求转发至 master 模块
		'/fn\/(.+?)/' => '/master/fn/\\1',
	);

	# 对应位置
	App\Master\Controller\Find\indexAction

	App\Master\Controller\Fn

## CLI 模式

### 基本语法

	# 命令
	php /disk/www/example.com/index.php

	# 对应方法
	App\Master\Controller\Index\indexAction

	----------------------

	# 命令
	php /disk/www/example.com/index.php /debug/test

	# 对应方法
	App\Master\Controller\Debug\testAction

	----------------------

	# 命令
	php /disk/www/example.com/index.php /admin/cron

	# 对应方法
	App\Admin\Controller\Cron\indexAction
	
### 传入参数

	# 命令
	php /disk/www/example.com/index.php /cron/account/test -foo bar
	
	# 获取参数列表
	func_get_args()
	
	# 获取路径加参数，使用 / 连接
	Request::getArgv()
	
	# 获取指定的参数，省略 - 符号
	Request::getArgv('foo')

## Controller 控制器

### 基本语法

	<?php

	namespace App\Master\Controller;

	!defined('DOC_ROOT') && die('Access Denied');

	// 引入类库
	use Library\Fs;
	use Library\Request;

	// 首页控制器
	class Index extends \Library\Controller {

		// 首页
		public function indexAction() {
			$url = Request::getPost('url');
			echo $url;
		}

		// 默认方法
		public function defaultAction( $action ) {
			echo $action;
		}

	}

### 类的继承

	# common.php

	<?php
	namespace App\Master\Controller;

	!defined('DOC_ROOT') && die('Access Denied');

	// 引入类库
	use Library\Request;

	class Common extends \Library\Controller {

		// 初始化方法，自动执行
		function init(){

			// Ajax 请求
			$this->ajax = Request::getPost('ajax');

			// Token 签名
			$this->token = Request::getPost('token');

			// 打开连接
			$this->connect();

			// Ajax 处理
			if( $this->ajax ){

				// 禁用视图
				$this->disable();

			}

		}

	}

	----------------------

	# second.php

	<?php
	namespace App\Master\Controller;

	// 引入类库
	use Library\StrExt;
	use Library\Service;
	use Library\Response;

	!defined('DOC_ROOT') && die('Access Denied');

	class Second extends CommonController {

		function init(){
			// 执行 common 类的 init 方法
			parent::init();
		}

		function indexAction() {
			echo StrExt::orderId();
		}

		function wechatAction() {
			
			// 实例化类
			$wx = new \Library\Wechat();

			// 删除菜单
            $res = $wx->deleteMenu();

		}

		function arrivalAction() {

			// 实例化模型
			$model = new \App\Master\Model\Goods();

			$result = $model->getByFilter( array(), $order = 'goods_id DESC', 1, $size = 40 );

			Response::callback( $result, $this->ajax );

		}

	}

### 公共变量

	# 运行环境
	$this->_environ

	# 当前控制器名称，首字母会大写
	$this->_control

	# 当前模块名称
	$this->_module

	# 当前方法名称
	$this->_action

	# 页面执行耗时
	$this->_timer

### 公共对象

	# 当前模板引擎对象
	$this->_template

	# 当前数据连接对象
	$this->db

	# 当前 Controller 实例
	Controller::$instance

### 公共方法

	# 数据库连接
	$this->connect()

	# 初始化，每个控制器都会自动执行此方法
	$this->init()

### 视图输出

	# 是否优化视图
	$this->optimize

	# 禁用模板视图
	$this->disable()

	# 禁用 HTTP 头
	$this->discard()

	# 赋值模板变量
	$this->assign( $key, $val )

	# 指定视图根目录，不包含 views
	$this->setDir( $name )

	# 指定视图子目录， views 的下级名称，用来实现多视图
	$this->setTpl( $name )

	# 指定缓冲捕获
	$this->setCap( $func )

	# 显示页面通知
	$this->notice( $message, $redirect = NULL )

	# 指定输出视图
	$this->display( $view = NULL, $vars = NULL )

### 路由方法

	# 入口 Action
	indexAction

	# 默认 Action
	# 当访问的 Action 不存在时，会自动转入到这里，同时将 Action 名称，当作第一个参数传入
	defaultAction

	# URL
	/item/123456
	
	# 对应方法
	function defaultAction( $id ){
		echo $id;
	}

## 模板引擎

### 目录结构

	# 一般情况下的目录结构，其中 [module] 为模块名称
	app/[module]/views/

	# 可以在控制器中使用 setdir 指定视图位置，如
	$this->setDir( DOC_ROOT );
	----------------------
	./views/

	# 也可以使用 settpl 指定视图模板名称，如
	$this->setDir( 'newlook' );
	----------------------
	./views/newlook/

### 可用变量

	# 系统缓存
	$html->cached

	# 全局配置
	$html->config

	# 模块配置
	$html->module

	# 请求参数
	$html->params

	# 运行状态
	$html->runtime

### 视图方法

	# 合并并压缩 JS / CSS 文件，通常用于 ./static/ 下的资源引用
	$html->combine( $file, $wrapper = FALSE )

	# 返回静态资源地址，通常用于 ./public/ 下的资源引用
	$html->assets( $file, $wrapper = FALSE, $version = NULL, $suffix = NULL )

	# 获取视图文件地址，通常配合 include 等包含文件命令使用
	$html->file( $fileName, $format = '.php' )

	# 获取静态文本内容，通常配合 echo 等内容输出命令使用
	$html->fill( $file, $variables = NULL )

	# 生成来自缓存的JS地址
	$html->script( $file, $extra = 'js', $prefix = 'cached' )

	# URL 生成，参考 Service::createUrl
	$html->createUrl()

	# 获取全局配置，参考 Service::getConfig
	$html->getConfig()

	# 获取模块配置，参考 Service::getModule
	$html->getModule()

	# 获取服务器标识，最后一位IP
	$html->serverTag()

	# 显示 poweredBy 信息
	$html->poweredBy( $anchor = TRUE )

## 错误处理

### 视图位置
	# 定义在 ./config/config.php
	./public/errors/database.php		# 数据库错误
	./public/errors/exception.php		# 程序异常
	./public/errors/notfound.php		# 未找到页面
	./public/errors/security.php		# 安全验证
	./public/errors/turnoff.php			# 关闭站点
	./public/errors/server_error.html	# 服务端错误（通常是 PHP-FPM）

### 抛出异常
	trigger_error('Source images do not exist', E_USER_ERROR);

### 日志记录
	\Library\Service::writeLog( $event, $desc = NULL, $opts = array() )

### 删除日志
	\Library\Service::cleanLog( $event, $opts = array() )

## Model 模型

### 继承方法

	<?php

	namespace App\Master\Model;

	!defined('DOC_ROOT') && die('Access Denied');

	// 商品标签和分类获取
	class Tags extends \Library\Model {

		function __construct( ) {
			parent::__construct();
		}

	}

### 内置变量

	# 数据库对象
	$this->db

	# 当前客户端 IP
	$this->ip

## 函数库

### 类库索引

	\Library\Arrays				# 数组操作
	\Library\Attach				# 附件上传
	\Library\Bootstrap			# 引导程序
	\Library\Cached				# 系统及模块缓存处理
	\Library\Config				# 系统及模块配置管理
	\Library\Captcha			# 通用验证码类
	\Library\Censor				# 关键词过滤以及审核类
	\Library\Controller			# 主控制器实现类
	\Library\Database			# 系统级数据库维护工具
	\Library\DateTime			# 日期与时间函数
	\Library\Error				# 系统错误处理
	\Library\Fs					# FileSystem 文件系统
	\Library\Fn					# 公共功能服务控制器
	\Library\Ftp				# FTP 文件上传操作
	\Library\HTML				# HTML 模板类
	\Library\HttpClient			# HTTP 类封装
	\Library\Model				# 模型基础类
	\Library\Mysql				# MySQL 类封装
	\Library\Request			# 数据输入接口类
	\Library\Response			# 数据输出接口类
	\Library\RSA				# RSA 加密与解密
	\Library\Security			# 安全校验工具包
	\Library\Service			# 常用服务扩展包
	\Library\Setting			# 配置读与写
	\Library\StrExt				# 字符串扩展
	\Library\Template			# 模板引擎类
	\Library\Location			# 地理位置服务包
	\Library\Thumb				# 基本图片处理
	\Library\Token				# 签名与验证
	\Library\Wechat				# 微信 SDK 封装
	\Library\Widget				# Widget 控制器

### Attach 文件上传

	# 保存单个上传文件
	Attach::savefile( $param = array() )

	# 保存多个上传文件
	Attach::savemulti( $param = array() )

	# 删除文件
	Attach::delete( $file, $param = array() )

	# 检查上传文件
	Attach::checkfile( $filename, $filetype = '*' )

	# 获取主机
	Attach::gethost()

### Cached 缓存

	# 读取缓存
	Cached::get( $key )

	# 写入缓存
	Cached::set( $key, $val = NULL, $ttl = 3600 )

	# 删除指定的缓存
	Cached::delete( $key, $ttl = 0 )

	# 清除全部缓存
	Cached::remove()

	# 缓存单条数据记录
	Cached::saved( $file, $text, $dir = 'dataset' )

	# 缓存查询至JavaScript
	Cached::script( $sql, $var, $file, $option = array() )

	# 缓存多条数据记录
	Cached::multi( $query, $file, $option = array() )

	# 缓存单条数据记录
	Cached::rows( $query, $option = array() )

	# 缓存整张数据表
	Cached::table( $table, $option = array() )

### Config 配置

	# 获取配置
	Config::fetch( $module, $key, $raw = FALSE )

	# 获取全部配置
	Config::fetchAll( $module, $raw = FALSE )

	# 保存配置
	Config::saved( $module, $key, $value, $alias = NULL, $type = NULL )

	# 将配置写入缓存
	Cached::caching()

### DateTime 常用服务

	# 格式化日期显示
	DateTime::readable( $date, $showDate = 'Y-m-d H:i:s' )

	# 比较日期时间
	DateTime::differ( $interval, $date1, $date2 )

	# 日期比较函数
	DateTime::formatDiff( $d1, $d2 = '' )

	# 根据年月返回当月最大天数
	DateTime::getDays( $year, $month )

### Fs 文件系统

	# 根据当前文件得到本地真实地址
	Fs::locale( $file, $return = FALSE )

	# 根据当前文件得到缩略图地址
	Fs::thumb( $file , $size = NULL )

	# 处理多域名下附件路径问题
	Fs::attach( $text, $root = FALSE )

	# 获得用户头像地址
	Fs::avatar( $uid, $size = NULL )

	# 大小容量换算
	Fs::sizecount( $size )

	# 取得字节单位
	Fs::sizebytes( $val )

	# 取得文件夹大小
	Fs::dirsize( $dir, $format = FALSE )

	# 得到文件扩展名
	Fs::fileext( $filename )

	# 得到文件内置参数
	Fs::fileparm( $file, $param = NULL )

	# 获得文件名
	Fs::filename( $file, $extra = TRUE )

	# 删除文件
	Fs::unlink( $file )

	# 遍历文件目录
	Fs::glob( $pattern, $flags = 0, $ignore = array() )

	# 遍历子目录
	Fs::finddir( $root, $filter = array() )

	# 遍历子文件
	Fs::findfile( $root, $filter = array(), $extra = array() )

	# 获取文件内容
	Fs::readfile( $filename, $remote = FALSE, $options = array() )

	# 读写文件
	Fs::makefile( $file, $text, $mode = 'w' )

	# 创建目录
	Fs::mkdir( $file, $index = FALSE , $mode = 0755 )

	# 删除文件夹
	Fs::rmdir( $file )

### StrExt 字符操作

	# 格式化字符集名称
	StrExt::charset( $charset, $reset = FALSE )

	# 获取指定长度随机字符
	StrExt::random( $strlen )

	# 获取16或32位随机ID
	StrExt::uniqId( $strlen = 16 )

	# 生成唯一订单号（16位）
	StrExt::orderId()

	# 获取随机颜色值，格式：#AABBCC
	StrExt::color()

	# 编码或解码JSON，并修正JSON不支持中文的问题
	StrExt::JSON( $data )

	# 使用正则提取数据
	StrExt::match( $source, $regex, $index = NULL, $useall = FALSE )

	# 字符串截取
	StrExt::substr($string, $length, $ellipsis = '...')

	# 字符转实体
	StrExt::entity_encode( $string, $charset )

	# 将 UNICODE 字符编码
	StrExt::html_unicode_encode( $string, $charset )

	# 将内容进行UNICODE编码
	StrExt::unicode_encode( $string, $charset )

	# 将UNICODE编码后的内容进行解码
	StrExt::unicode_decode( $string, $charset )

	# 编码特殊符号
	StrExt::spec_chars( $string ) 

	# 解码字符串
	StrExt::unescape( $string )

	# 截取过长URL(只能用于文件显示)
	StrExt::suburl( $string, $strlen )

	# 字符串是否在另一字符串中出现
	StrExt::strexists( $string, $find )

	# 隐藏部分字符串
	StrExt::hidden( $string, $strlen = 2 )

	# 获得首字母索引
	StrExt::indexed( $string )

	# 过滤XML标准规定的无效字节
	StrExt::xmlnode( $xml )

	# 清除HTML标记
	StrExt::clearHtml( $string )

	# 移除HTML标签
	StrExt::deleteHtml( $string )

	# 压缩HTML，删除无用空白
	StrExt::compress( $string )

	# 修正无效的序列化字符
	StrExt::unserialize( $string )

### Service 常用服务

	# 引导实例
	Service::$boot

	# 系统缓存
	Service::$cached

	# 全局配置
	Service::$config

	# 模块配置
	Service::$module

	# 运行状态
	Service::$runtime

	# 获取全局配置
	Service::getConfig( $key = NULL )

	# 设置全局配置（临时改变，不会持久存储）
	Service::setConfig( $key, $val = NULL )

	# 获取缓存数据
	Service::getCached( $mod, $key = NULL )

	# 设置缓存数据（临时改变，不会持久存储）
	Service::setCached( $mod, $key, $val = NULL )

	# 获取模块配置
	Service::getModule( $mod, $key = NULL )

	# 设置模块配置（临时改变，不会持久存储）
	Service::setModule( $mod, $key, $val = NULL )

	# 完整页码
	Service::multiPage( $url, $opt = array() )

	# 简单页码
	Service::simplePage( $pagenum, $curpage, $current, $style = 'pagination', $lang = NULL )

	# URL 生成
	Service::createUrl( $parts = NULL, $param = NULL, $anchor = NULL )

	# 发送手机短信
	Service::sendSMS( $mobile, $format, $variable )

	# 验证邮件配置
	Service::validMail()

	# 普通邮件发送函数
	Service::sendMail( $address, $subject, $content, $template = NULL )

	# 清空或暂存上下文数据
	Service::context( $name = NULL, $clip = NULL )

	# 写入一条系统日志
	Service::writeLog( $event, $desc = NULL, $opts = array() )

	# 清理某一类型日志
	Service::cleanLog( $event, $opts = array() )

### Location 位置服务

	# 获取手机号码归属地
	Location::getSeat( $number = NULL )

	# 获取位置数据清单
	# 数据来自 public/location/location.php
	Location::getData( $index = NULL )

	# 更新纯真数据库文件
	Location::upgrade( $filename = NULL )

	# 返回 IP 所在地
	# IP 数据库配置位置：global.module.ipdata
	# IP 数据库下载地址：http://www.cz88.net/
	Location::convert( $ip )

### Request 请求

	# 当前模块名称
	Request::$module

	# 当前控制器名称，首字母会大写
	Request::$control

	# 当前方法名称
	Request::$action

	# 当前传入参数
	Request::$params

	# 当前请求方式
	Request::method( $action = NULL )

	# 是否 Ajax 请求
	Request::inajax()

	# 获取 URL 资源内容
	Request::fetch( $url, $option = array(), &$handle )

	# 获取 GET 请求
	Request::get( $key = NULL, $filter = NULL )

	# 获取 POST 请求
	Request::post( $key = NULL, $filter = NULL )

	# 获取 GET 或 POST 请求
	Request::getPost( $key = NULL, $filter = NULL )

	# 获取页码参数
	Request::getPage( $key = NULL )

	# 获取 Argv 参数
	Request::getArgv( $key = NULL )

	# 获取数值
	Request::getNum( $key, $default = 0 )

	# 获取两个输入框组成的时间值
	Request::getTime( $name, $now = NULL )

	# 获取客户端 IP
	Request::getIP()

	# 获取 Cookie 值
	Request::getCookie( $var, $prefix = TRUE )

	# 设置或清除 Cookie
	Request::setCookie( $var, $value = '', $life = 0, $prefix = 1, $httponly = FALSE )

	# 获得当前的脚本网址
	Request::GetCurUrl( $encode = FALSE )

	# 获得当前的绝对网址
	Request::GetAbsUrl( $encode = FALSE )

	# 是否为手机访问
	Request::check_mobile()

	# 获取移动设备系统名称
	Request::check_device()

	# 返回是否在微信内浏览和微信版本号
	Request::check_wechat()
	
	# 返回是否为微信小程序请求
	Request::check_service()

	# 获取 HTTP Header 信息
	Request::getHttpHeader( $key = NULL )

	# 获取 USER AGENT 信息
	Request::getUA()

	# 获取 HTTP ACCEPT 信息
	Request::getHttpAccept()

	# 取得手机类型
	Request::getPhoneType()

	# 判断SSL是否启用
	Request::isSSL()

	# 判断是否支持 Webp
	Request::isWebp()

	# 判断是否是 IE 浏览器
	Request::isMsie()

	# 判断是否是 iPhone
	Request::isIphone()

	# 判断是否是 Android
	Request::isAndroid()

	# 判断是否为蜘蛛
	Request::isSpider()

### Response 输出

	# 输出 JSON 数据
	Response::jsonp( $data, $callback = '', $exit = FALSE )

	# 输出 AJAX 数据
	Response::ajax( array $data, $exit = FALSE )

	# 缓存数据5分钟（客户端）
	Response::cached( 60 * 5 )

	# 直接下载文档
	Response::download( $file, $filename )

	# 下载报表数据
	Response::export( $name, $content, $suffix = 'csv' )

	# 将内容格式成 js 脚本
	Response::script( $string )

	# URL 重定向
	Response::redirect( $url, $msg = '' )
	
	# 返回 JSONP 格式数据
	Response::callback( $dataset, $callback = NULL )

### Security 安全

	# 令牌生成
	Security::generate( TRUE )

	# 令牌校验
	Security::valid( $token )

	# 检查当前 IP 是否在规则内
	Security::check_ipzone( $array, $ip = NULL )

	# 按规则检查提交参数
	Security::check_params( $param, $valid = array(), $default = NULL )

	# 使用 Mcrypt 对消息进行加密或解密
	Security::message( $data, $key, $mode = 'encode' )

	# 使用 MD5 给密码加盐
	Security::password( $password, $salt )

	# 检验是否为IP地址
	Security::isIP( $var )

	# 检验 QQ
	Security::isQQ( $var )

	# 检验邮编
	Security::isZip( $var )

	# 检验网址
	Security::isHttp( $var )

	# 检验 Email
	Security::isEmail( $var )

	# 检验身份证
	Security::isIDCard( $var )

	# 检验是否是中文
	Security::isChinese( $var )

	# 检验是否是英文
	Security::isEnglish( $var )

	# 检验是否为手机号码
	Security::isMobile( $var )

	# 检验是否为固定电话
	Security::isPhone( $var )

	# 检验是否含有非法字符
	Security::isSafety( $var )

	# 检验是否含为合法用户名
	Security::isUsername( $var )

	# 检验是否为合法密码
	Security::isPassword( $var )

	# 检验日期是否合法
	Security::isDateTime( $var )

## Mysql 数据库

### 常规方法

	# 数据库连接
	$this->db->connect()

	# 数据库版本
	$this->db->version()

	# 设置数据库句柄属性
	$this->db->setattr()

	# 取回一个数据库连接的属性
	$this->db->getattr()

	# 返回一个可用驱动的数组
	$this->db->drivers()

	# 关闭mysql链接
	$this->db->close()

### 数据查询

	# 单条查询
	$this->db->getone()
	
	# 得到指定字段的值
	$this->db->getval()
	
	# 多条查询
	$this->db->getall()
	
	# 多条查询
	$this->db->select()
	
	# 返回当前查询总数
	$this->db->total()

### 数据更新

	# 更新字段累加
	$this->db->statis()

	# 插入一条新记录
	$this->db->insert()

	# 插入或替换一条新记录
	$this->db->replace()

	# 更新数据记录
	$this->db->update()

	# 删除数据记录
	$this->db->delete()

### 事务支持

	# 检查是否在一个事务内
	$this->db->inTrans()

	# 启动事务
	$this->db->startTrans()

	# 事务回滚
	$this->db->rollback()

	# 用于非自动提交状态下面的查询提交
	$this->db->commit()

### 辅助方法

	# 数据库查询次数
	$this->db->_queries

	# 返回最后执行的sql语句
	$this->db->getLastSql()

	# 得到记录集的总数
	$this->db->getNumRows()
	
	# 得到结果集中字段的数
	$this->db->getNumFields()
	
	# 取得上一次INSERT动作所产生的ID值
	$this->db->getInsertId()
	
	# 取得上一次增加、删除、修改所影响行的数量
	$this->db->getAffectedRows()

## 最佳实践

### 配置选项获取

	# 获取顶级选项
	Service::getConfig('global')

	# 获取站点信息
	Service::getConfig('global.basic')

	# 获取网站标题
	Service::getConfig('global.basic.title')

	# 获取本地缓存配置，并移除前缀（locale.）
	Service::getConfig('locale', TRUE)

### 模块选项获取

	# 获取 master 选项
	Service::getModule('master')

	# 获取 admin 选项
	Service::getModule('admin')

	# 获取 master 下的 payment_type 选项
	Service::getModule('master', 'payment_type')

### 多模块与域名

	# 模块声明
	# 第一个模块将作为默认模块，未绑定的域名将指向它
	./config/project.php
	'product.module' => array('master', 'admin');

	# 域名绑定
	./config/domain.php
	'domain.module' => array (
		'master' => 'www.example.com',
		'admin' => 'admin.example.com',
	);

### 多模板视图

	# 设置视图位置
	$this->setdir( DOC_ROOT );

	# 设置视图名称
	$this->settpl( 'newlook' );

	# 包含其他视图
	include $html->file( 'views/header' );

	# 包含其他视图，使用自定义的相对路径
	include $html->file( '/views/master/header' );

### createUrl URL生成

	# 当前模块 URL 生成
	echo $html->createUrl( array( 'system', 'index', 'version' ), 'ajax=?' );

	# 使用字符串 URL 生成
	echo $html->createUrl( ':agent/auth/signin/' );

	# 同时指定协议 URL 生成
	echo $html->createUrl( 'http://:agent/auth/signin/', $_GET );

	# 指定模块 URL 生成
	echo $html->createUrl( array( ':agent', 'auth', 'signin' ), 'ajax=?', 'anchor' );

	# 带协议的 URL 生成
	echo $html->createUrl( array( 'http://', ':agent', 'auth', 'signin' ), 'ajax=?', 'anchor' );

	# 自适应协议的 URL 生成
	echo $html->createUrl( array( 'auto://', ':admin', 'auth', 'signin' ), 'ajax=?', 'anchor' );

	# 指定域名的 URL 生成
	echo $html->createUrl( array( 'auto://', 'example.com', 'auth', 'signin' ), 'ajax=?' );

### assets 静态资源直接引用

>  会根据 config/domain.php 中的配置来决定是否引用 CDN 资源

	$html->assets( '/public/js/ray.js' );

	$html->assets(array('/public/js/pack.html5.js', '/public/js/pack.respond.js'), TRUE);

### combine 静态资源合并引用

>  仅适用于本地资源，可根据文件名适配，不支持 js / css 同时引用

	$html->combine( '/static/style/common.css' );

	$html->combine(array('/static/style/common.css', '/static/style/index.css'), TRUE);

### 日志记录

>  基本日志记录

	Service::writeLog( 'EVENT_NAME', var_export( $data, TRUE ) );

>  带用户信息的日志记录

	Service::writeLog( 'MEMBER_PROFILE', var_export( $data, TRUE ), array( 'userid' => 12345, 'username' => 'TEST' ) );

### 表格下载

	# 控制器
	<?php

	use Library\Request;
	use Library\Response;

	// Ajax 请求
	$this->ajax = Request::getPost('ajax');

	// 控制器
	if ( $this->ajax == 'export' ) {

		// 指定内容格式和文件名称
		Response::export( date('m.d_') . '数据导出', NULL, 'xls' );

		// 捕获视图中的表格，并输出
		$this->setcap(function ($html) {

			// 移除忽略的标签和内容
			$html = preg_replace('/<\s*(\S+)[^>]+role="ignore"[^>]*>.*<\s*\/\s*\1\s*>/isU', '', $html);

			// 移除 A 标签链接
			$html = preg_replace("/<a[^>]*>(.*)<\/a>/isU", '${1}', $html);

			// 定位表格
			preg_match('/\<table class="(.*)"\>(.*)\<\/table\>/isU', $html, $match);

			if ($match) {
				// 重定义表格样式
				return preg_replace('/\<table class="(.*)"\>/sU', '<table border="1">', $match[0]);
			}
		});

	}

	# 视图
	<?php include MOD_ROOT .'views/header.php';?>
		...
		<table class="table table-striped">
		...
		</table>
		...
	<?php include MOD_ROOT .'views/footer.php';?>

### CSV 下载

	<?php

	use Library\Request;
	use Library\Response;

	// Ajax 请求
	$this->ajax = Request::getPost('ajax');

	// 控制器
	if ( $this->ajax == 'export' ) {

		//禁用视图和 HTTP 头
		$this->disable();
		$this->discard();

		$this->db->setattr(\PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, FALSE);

		$result = $this->db->query( $sql );

		$struct = array(
			'member_id' => '#',
			'phone' => '手机号',
			'member_name' => '昵称',
			'invite_code' => '邀请码',
			'taobao_uid' => '淘宝UID',
			'member_role' => '角色',
			'qq' => 'QQ',
			'wechat' => '微信',
			'layer' => '层级',
			'fans' => '粉丝',
			'balance' => '可用余额',
			'credits' => '可用津贴',
			'income' => '累计收益',
			'status' => '状态',
		);

		Response::excel( '用户数据 - '.date('Y-m-d'), $struct, $result );

	}

### 更新标题

	$this->setcap(function ($html) {
		return preg_replace('/<title>(.*) - (.*)<\/title>/', '<title>News - $2</title>', $html);
	});

### 多模板视图

	// 设置模板目录
	// DOC_ROOT . 'views/'
	$this->setdir( DOC_ROOT );

	// 设置模板主题
	// DOC_ROOT . 'views/' . $theme
	// DOC_ROOT . 'views/default'
	// 优先在 $theme 中查找，没找到将在 default 中查找
	$this->settpl( $theme );

### 来路验证

	use Library\Request;
	use Library\Response;

	// Ajax 请求
	$this->ajax = Request::getPost('ajax');

	// Token 签名
	$this->token = Request::getPost('token');

	// Ajax 处理
	if( $this->ajax ){

		// 禁用视图
		$this->disable();

		// 获取来路信息
		$domain = Request::getHttpHeader('HTTP_HOST');
		$referer = Request::getHttpHeader('HTTP_REFERER');

		// 未知来路限制
		if( !$referer || strpos( $referer, $domain ) === FALSE ){
			Response::callback( array( 'return'=> -1001, 'result'=> 'Invalid referer parameters' ), $this->ajax );
		}

		// 验证签名参数
		if( !$this->token || !Token::valid( $this->token ) ){
			Response::callback( array( 'return'=> -1002, 'result'=> 'Invalid token parameters' ), $this->ajax );
		}

	}

### 文件上传

	use Library\Attach;

	public function simpleUpload(){		
		return Attach::savefile( array( 'field' => 'file' ) );
	}

### 在析构函数中统一赋值变量

>  好处是，其他 Action 中可以对变量进行处理，而不用多次 $this->assign

	public function __destruct() {
		
		$this->assign( 'website', $this->website );
		
		$this->assign( 'widgets', $this->widgets );

		$this->assign( 'category', $this->category );

		parent::__destruct();

	}
	
### 通过控制器中的注释生成权限缓存

	/**
	 * 文件描述
	 * @name   页面名称
	 * @weight 排序权重，从小到大，范围 1~255
	 * @navbar 是否可见，默认可见 visible || 隐藏 hidden
	 * @access 访问限制，默认允许 allowed || 关闭 closed
	 */
	class Admin extends Common {

		function init(){
			parent::init();
		}

		/**
		 * 导航菜单
		 * @label  导航名称
		 * @action 入口地址，通常与 Action 同名
		 * @navbar 导航显示，默认显示 visible || 隐藏 hidden
		 * @access 访问限制，默认允许 allowed || 验证 limited || 关闭 closed
		 * @markup 样式标识
		 */
		public function indexAction() {
		
		}

		/**
		 * API 接口
		 * @label  导航名称
		 * @action 入口地址，通常与 Action 同名
		 * @param  定义参数，type name summary [required]
		 * @method  请求方式，GET / POST / GET&POST
		 * @access 访问限制，默认允许 allowed || 验证 limited || 关闭 closed
		 * @example 代码示例，必需是最后一个属性
		 */
		public function requestAction() {
		
		}
		
		/**
		 * @label 已处理
		 * @action success
		 * @access limited
		 */

		/**
		 * @label 已取消
		 * @action cancel
		 * @access limited
		 */
		public function defaultAction($act = null) {
		
		}
		
		/**
		 * @label 方法示例
		 * @action apply
		 * @navbar hidden
		 * @access limited
		 */
		public function applyAction( $id = NULL ) {
		
		}
		
		/**
		 * @label 删除订单
		 * @action delete
		 * @navbar hidden
		 * @markup text-danger
		 * @access closed
		 */
		public function deleteAction( $id = NULL ) {
		
		}
		
		/**
		 * @label 产品列表
		 * @action product
		 * @method GET
		 * @param int size 每页数量
		 * @param int page 当前页码
		 * @param string keyword 搜索关键字
		 * @access limited
		 * @example
		 * {
		 *	"status":0,
		 *	"result":[]
		 * }
		 */
		public function productAction( ) {
		
		}

	}


