# Migrating

> Project DORA 升级和迁移指导

## PHP

	$this->getnum
	Request::getNum
	
	$this->getgpc
	Request::getPost
	
	$this->getPost
	Request::getPost
	
	$this->getpage
	Request::getPage
	
	$this->gettime
	Request::getTime
	
	$this->get
	Request::get
	
	$this->post
	Request::post
	
	$this->paging
	Request::paging
	
	$this->callback
	Response::callback
	
	$this->redirect
	Response::redirect
	
	Toolkit::referer
	Request::referer
	
	Toolkit::getIP
	Request::getIP
	
	Toolkit::GetCurUrl
	Request::GetCurUrl
	
	Toolkit::GetAbsUrl
	Request::GetAbsUrl
	
	Toolkit::GetCurFile
	Request::GetCurFile
	
	Toolkit::getcookie
	Request::getCookie
	
	Toolkit::setcookie
	Request::setCookie
	
	Toolkit::parselink
	Service::parseLink
	
	Mobile::getHttpHeader
	Request::getHttpHeader
	
	Mobile::getUA
	Request::getUA
	
	Mobile::sendMail
	Service::sendMail
	
	Mobile::getHttpAccept
	Request::getHttpAccept
	
	Mobile::check_device
	Request::check_device
	
	Mobile::check_wechat
	Request::check_wechat
	
	Mobile::check_mobile
	Request::check_mobile
	
	Toolkit::authcrypt
	Security::authcrypt
	
	$this->_method == 'POST'
	Request::method( 'POST' )
	
	Output::
	Response::
	
	Toolkit::JSON
	StrExt::JSON
	
	Toolkit::getOrderId
	StrExt::orderId
	
	Toolkit::rand
	StrExt::random
	
	Toolkit::getrandstr
	StrExt::uniqId
	
	Toolkit::getRandColor
	StrExt::color
	
	use Library\Toolkit;
	use Library\StrExt;
	use Library\Request;
	use Library\Security;
	
	use Library\Mobile;
	use Library\Request;
	use Library\Service;
	
	Toolkit::isQQ
	Security::isQQ
	
	Toolkit::isMobile
	Security::isMobile
	
	Toolkit::isEmail
	Security::isEmail
	
	Toolkit::isHttp
	Security::isHttp
	
	$_G['config']['host']
	Service::getConfig('basic.host')
	
	$_G['config']['root']
	Service::getConfig('basic.root')
	
	$_G['config']['base']
	Service::getConfig('basic.base')
	
	$_G['config']['secret']
	Service::getConfig('security.secret')
	
	$_G['config']['access']
	Service::getConfig('security.access')
	
	$_G['config']['start']
	Service::getConfig('security.finish')
	
	$_G['product']['charset']
	Service::getConfig('product.charset')
	
	$_G['errors']['security']
	Service::getConfig('errors.security')
	
	$_G['product']['version']
	Service::getConfig('product.build')
	
	$_G['setting']['attach']
	Service::getConfig('attach')
	
	$_G['upload']
	Service::getConfig('upload')
	
	$_G['project']['paging']
	Service::getConfig('project.paging')
	
	$_G['runtime']
	Service::$runtime
	
	$_G['master']['permission']
	Service::getModule('admin', 'permission')
	
	$_CACHE['master']['config']
	Service::getCached( 'config' )
	
	Setting::getval
	Service::getConfig
	
	Fs::readfile( $url, TRUE )
	Request::fetch( $url )
	
	Fs::readfile
	Request::fetch
	
	Toolkit::FormatDateDiff
	DateTime::FormatDateDiff

## 模板

	$_G['runtime']
	$html->runtime
	
	$_G['project']['powered']
	$html->config['project.powered']
	
	$_G['product']['appname']
	$html->config['product.appname']
	
	$_G['product']['version']
	$html->config['product.build']
	
	$_G['master']['copyright']
	$html->module['admin']['copyright']
	
	$_G['master']
	$html->module['admin']
	
	$_G['referer']
	$html->runtime['referer']
	
	$_G['config']['host']
	$html->config['basic.host']
	
	$_G['config']['root']
	$html->config['basic.root']
	
	$_G['config']['base']
	$html->config['basic.base']
	
	$_CACHE['master']
	$html->cached
	
	$html->markurl
	$html->createUrl

## 视图

### lightbox

	rel="lightbox[plants]"
	data-toggle="lightbox" data-gallery="gallery"
	
	"rel" : "lightbox[plants]"
	"data-toggle" : "lightbox", "data-gallery" : "gallery"

### magick upload

	v-bind:upload	
	model="magick" v-bind:storage

### native upload

	config='{	
	model="native" config='{

### cached

	$this->klass->fetch(	
	Config::fetch( 'common',

	$this->klass->saved( $key, $alias, $value, $datatype );	
	Config::saved( 'common', $key, $value, $alias, $datatype );

	$this->klass->cache();

### download

	# 原始方式
	Response::format('xls');
	Response::content( NULL, date('m.d_').' 代理提现导出' );
	
	# 新方式
	Response::export( date('m.d_') . ' 代理提现导出', NULL, 'xls' );

### bootstrap3 => bootstrap4

	<div class="form-group">
	<div class="form-group row">
	
	<label class="col-sm-2 control-label">
	<label class="col-sm-2 col-form-label">

	class="col-md-2 control-label"
	class="col-sm-2 col-form-label"

	class="btn btn-secondary btn-xs">搜索</button>
	class="btn btn-secondary">搜索</button>

	class="btn btn-secondary btn-sm">搜索</button>
	class="btn btn-secondary">搜索</button>

	<label class="radio-inline">
	<label class="form-check form-check-inline">

	<a class="btn btn-primary btn-sm"
	<a class="btn btn-primary"

	<p class="form-control-static">
	<p class="form-control-plaintext">

	<div class="panel panel-default">
	<div class="card mb-3">

	<div class="panel-body">
	<div class="card-body">

	<blockquote>
	<blockquote class="blockquote">

	class="col-sm-offset-2
	class="offset-2

	label label-
	badge badge-

	panel-heading
	card-header

	class="btn btn-sm btn-success"
	class="btn btn-success"

	<a class="btn btn-sm btn-secondary" data-url
	<button type="button" class="btn btn-sm btn-danger" data-url

	btn-default
	btn-secondary

	btn-xs"
	btn-sm"
	
	cdn.bootcss.com
	cdn.staticfile.org
	
	cdn.bootcss.org/bootstrap
	cdn.staticfile.org/twitter-bootstrap

### remove

	<i class="glyphicon glyphicon-plus-sign"></i> 
	<i class="glyphicon glyphicon-trash"></i> 
	<i class="glyphicon glyphicon-edit"></i> 














