# Hybrid

> 基于 Vue 的前后端混合开发环境

## 安装使用
	<script src="//pubic.zhfile.com/js/ray.js">
	<script src="//pubic.zhfile.com/js/pack.hybrid.js">
	
## 基础选项

	# 调试模式，使用 Vue devtools
	debug ： false
	
	# 签名参数
	token : ''
	
	# 版本编号
	build : ''
	
	# 百度统计ID
	baidu : ''
	
	# 阿里妈妈PID
	mapid : ''
	
	# 附件目录
	attach : '/attach/'
	
	# 公共文件目录
	public : '/public/'
	
	# 文件上传接口
	upload : '/upload/native'
	
	# 文件删除接口
	remove : '/upload/remove'
	
	# 返回顶部元素
	scroll : '.gotop'
	
	# Vue 可选数据
	option : {}
	
	# Vue 扩展对象
	extend : {}
	
	# Vue 绑定元素
	element : '#app'
	
	# 标题规则
	docname : {}
	
	# 模块配置
	modules : {}
	
	# Cookie 前缀
	prefix : ''
	
	# 短网址生成接口   
	shorten : '/fn/tinyurl'
	
	# 错误消息收集接口
	jserror : '/fn/jserror'
	
## 初始化

	# 默认配置
	Hybrid.Start( );
	
	# 指定标题名称
	Hybrid.Start( { docname : { 'result' : 'goods_name' } } );
	
	# 附加可选数据
	Hybrid.Start( option : ( typeof option != 'undefined' ? option : {} ), { docname : { 'result' : 'goods_name' } } );
	
	# 附加扩展对象
	Hybrid.Start( option : ( typeof extend != 'undefined' ? extend : {} ), { docname : { 'result' : 'goods_name' } } );
	
	# 更改其他选项
	Hybrid.Start( token : '4e51967f2d70f4b6', { docname : { 'result' : 'goods_name' }, shorten : 'http://dwz.cn/add' } );

## 数据模板

#### 基本模板
	<fragment type="template">...</fragment>

#### flag
	数据标识，用于 Vue 模板访问
	<fragment type="template" flag="sample">
		<a v-bind:href="'detail?id=' + object.sample.goods_id">{{object.sample.goods_name}}</a>
	</fragment>

#### source
	数据来源：URL 地址
	<fragment type="template" flag="sample" source="/detail/related">...</fragment>

#### cache
	是否缓存：true 或 false，默认 false
	<fragment type="template" flag="sample" cache="true">...</fragment>

#### lazy
	延迟加载：数值，单位秒，默认 0
	<fragment type="template" flag="sample" lazy="5">...</fragment>

#### reload
	自动刷新：数值，单位秒，默认 0
	<fragment type="template" flag="sample" reload="10">...</fragment>

#### listen
	监听对象：选择器，通常与 event 属性配合使用
	<fragment type="template" flag="sample" listen=".btn a">...</fragment>
	<fragment type="template" flag="sample" listen="window">...</fragment>

#### event
	事件行为：有效的事件名称，如 click / change / scroll 等
	<fragment type="template" flag="sample" event="click">...</fragment>
	
	通常与 listen 属性配合使用
	<fragment type="template" flag="sample" listen=".btn a" event="click">...</fragment>
	<fragment type="template" flag="sample" listen="window" event="scroll">...</fragment>

#### initial
	是否初始化数据：true 或 false，事件触发时不会主动加载，可以使用此选项来初始化
	<fragment type="template" flag="sample" initial="true">...</fragment>

#### paging
	是否有分页：true 或 false，默认 false，会处理页码，通常与 分页组件 配合使用
	<fragment type="template" flag="sample" paging="true">...</fragment>
	
#### padding
	是否启用数据填充：true 或 false，默认 false，为 true 时将不断进行数据累加
	<fragment type="template" flag="sample" padding="true">...</fragment>
	
#### history
	是否启用历史记录：true 或 false，会更新 URL 至 state
	<fragment type="template" flag="sample" history="true">...</fragment>

## 分页组件

### next 仅下一页
	<paging next="true" :numbers="numbers" :current="current" :pagenum="pagenum" v-on:paging="paging"></paging>

### prev 上下分页
	<paging prev="true" next="true" :numbers="numbers" :current="current" :pagenum="pagenum" v-on:paging="paging"></paging>

### nums 带页码分页
	<paging prev="true" next="true" nums="true" :numbers="numbers" :current="current" :pagenum="pagenum" v-on:paging="paging"></paging>
	
## 表单提交

### 标签属性
	<form method="post" target="ajax"></form>

### 表单验证

#### 语法示例
	<input type="text" class="form-control" data-valid-name="用户昵称" data-valid-empty="yes" />

#### 支持属性

	# data-valid-name
	提示文字 * 必填项
	
	# data-valid-empty
	"yes" 强制检查，"no" 值可为空，不为空时检查
	
	# data-valid-number
	同上，数字类检查
	
	# data-valid-secure
	同上，安全字符检查
	
	# data-valid-password
	同上，密码类型属性，CSS 表达式或其他
	
	# data-valid-ip
	同上，IP地址型属性
	
	# data-valid-url
	同上，链接地址属性
	
	# data-valid-email
	同上，邮箱地址属性
	
	# data-valid-idcard
	同上，身份证号属性
	
	# data-valid-phone
	同上，电话号码属性
	
	# data-valid-mobile
	同上，手机号码属性
	
	# data-valid-datetime
	同上，时间日期属性
	
	# data-valid-regexp
	同上，正则表达式
	
	# data-valid-confirm
	字符串，将当前值与目标元素的值进行比较（CSS 选择器）
	
	# data-valid-minsize
	数值，字符最小长度
	
	# data-valid-maxsize
	数值，字符最大长度
	
	# data-valid-accept
	字符串，允许上传的扩展名（以空隔分隔），针对文件选择器有效

## Ajax 处理

### A 标签
	<a data-type="ajax" data-href="/detail/request">...</a>

### INPUT 标签
	<input type="text" name="url" data-type="ajax" data-href="/debug/checkin?url=" />
	input 的值会附加到 data-href 内容后面，然后发起 Ajax 请求，可以配合 data-variable 将返回的值写入变量

#### data-confirm 确认操作
	<a data-type="ajax" data-href="/detail/request" data-confirm="确定吗？">...</a>
	当点击 "确定" 后，才会发起 Ajax 请求

#### data-message 提示信息
	<a data-type="ajax" data-href="/detail/request" data-message="我知道了">...</a>
	仅弹出提示信息，不会发起 Ajax 请求

#### data-caching 是否缓存
	<a data-type="ajax" data-href="/detail/request" data-caching="true">...</a>

#### data-execute 执行事件
	<a data-type="ajax" data-href="/detail/request" data-execute="click">...</a>
	会在页面加载完成后，自动执行一次事件

#### data-variable 更新变量

	# 更新指定变量
	<a data-type="ajax" data-href="/detail/request" data-variable="object.result.goods_name">...</a>

	# 更新动态变量
	<div v-for="(v, k) in object.manual">
		<a data-type="ajax" data-href="/detail/change" v-bind:data-variable="'object.manual.'+ k +'.price'">
			&yen; <strong>{{v.price}}</strong>
		</a>
	</div>

#### data-padding 追加数据
	<a data-type="ajax" data-href="/detail/request" data-variable="object.comment" data-padding="true">...</a>
	当 object.comment 不存在时，会使用 Vue.set 方法创建对象并赋值，否则将会执行 push 方法追加数据

#### data-callback 回调方法
	<a data-type="ajax" data-href="/detail/request" data-callback="console.log">...</a>
	回调函数可以接收两个参数 console.log( data, node )，其中 data 为当前返回数据，node 是当前 ajax 发起元素 <a />

#### data-duration 消息时长，单位：秒
	<button data-duration="10" data-type="ajax" data-message="Hello World!">消息提示</button>

### 后端响应

#### 处理返回
	<?php
	Response::callback( array( 'return'=> 0, 'result'=> $result ), $this->ajax );

#### 常规数据
	{
		'return'=> 0, 
		'result'=> $data
	}
	
#### Ajax 消息
	{
		'return'=> 0, 
		'result'=> '操作成功'
	}

#### 变量数据
	{
		'return'=> 0, 
		'result'=> '操作成功', 
		'variable'=> '这是一条字符串'
	}

----------

	{
		'return'=> 0, 
		'result'=> '操作成功', 
		'variable'=> {
			'goods_id' => 530598549821,
			'goods_name' => '美多丝洗发'
		}
	}

----------

	{
		'return'=> -1000, 
		'result'=> '操作失败', 
		'variable'=> null
	}


#### 带分页信息
	{
		// 返回状态
		'return'=> 0,

		// 当前页码
		'paging'=> $page, 

		// 每页数量
		'limit'=> $size, 

		// 总记录数
		'total'=> $this->db->numRows, 

		// 本页数据
		'result'=> $data
	}

#### 其他数据
	{
		// 重置表单：true 或 false
		'reset'=> true,

		// 是否刷新：true 或 false
		'reload'=> true,

		// 是否回退：true 或 false
		'backing'=> true,

		// 替换链接
		'replace'=> 'http://www.baidu.com',

		// 跳转链接
		'target'=> 'http://www.baidu.com'
	}

#### return 规范

**0	没有错误**

	{
		'return'=> 0, 
		'result'=> '操作成功'
	}

**> 0 消息编号**

	{
		'return'=> 12345, 
		'result'=> '用户注册成功'
	}

**< 0 错误编号**

	{
		'return'=> -1000, 
		'result'=> '必要的错误不能为空'
	}

## Vue 方法

### nl2br( value )
	将换行符替换成 <br />
	Hybrid.App.nl2br();

### format( value, format )
	日期和时间格式化
	Hybrid.App.format();

### truncate( value, length )
	字符串截断方法
	Hybrid.App.truncate();

### currency( value )
	货币金额格式化
	Hybrid.App.currency();

### numerical( value )
	大数字格式化，如：9.5万
	Hybrid.App.numerical();

### resized( imgsrc, sized )
	调整图片尺寸
	Hybrid.App.nl2br();

### convert( detail )
	商品详情链接
	Hybrid.App.convert( detail );

### wechat()
	检测是否为微信浏览器，在微信中会返回微信版本号，否则返回 false
	Hybrid.App.wechat();
	"6.0.2.56"

### nettype()
	检测网络类型（微信环境），在微信中会返回当前网络类型（WIFI / 2G / 3G+），否则返回 null
	Hybrid.App.nettype();
	"WIFI"

### mobile()
	检测是否为手机浏览器，在移动设备中返回设备类型（iPhone / iPod / Android / iOS / SymbianOS / Windows Phone），否则返回 false
	Hybrid.App.mobile();
	"Android"

### qrcode( data )
	返回二维码 URL 地址
	Hybrid.App.qrcode( data );

### createUrl( parts, param, anchor )
	URL 生成，parts：路径参数，param：GET 参数，anchor：锚点名称
	多模块时，需要在 modules 中传入模块信息
	Hybrid.App.createUrl( parts, param, anchor );

## 其他功能

### Vue 可选数据
	{{ option }}

### Vue 扩展对象
	
	var extend = {
		data : {
			option : {
				sites : {"baidu.com":"weibo.com","sina.com"}
			}
		},
		methods : {
			test: function(){
				alert( this.pagenum );
			}
		},
		mounted : function(){
			console.log('mounted');
		}
	};

	Hybrid.Start( 'extend' : extend );

----------

	{{ option.sites }}
	<a v-on:click="test()">Test!</a>

### Vue URL参数
	{{ params }}

	示例数据，从当前 URL 中提取 GET 参数，其中数组（parent[child]）将自动转换成 parent.child 格式

	{ 'id' : 123456, 'text' : 'hello', 'data' : { 0 : 'aaa', 1 : 'bbb' }, 'extra.site' : 'tmall', 'extra.name' : '天猫' }

### Vue 模板
	Vue 处理完成后，显示元素，需要在 CSS 中定义 [v-cloak]{ display:none; }

	<fragment type="template" v-cloak>...</fragment>

### 编辑器对象
	Hybrid.Editor

### 提示样式

	#toast{ }
		#toast.default{ /* 普通样式 */ }
		#toast.success{ /* 成功样式 */ }
		#toast.invalid{ /* 失败样式 */ }

### 原生上传

	<input type="file" model="native" config="" />

	<input type="file" model="native" config='{ "model" : "pics", "multi" : 5 }' />

	<input type="file" model="native" config='{ "model" : "pics", "multi" : 5 }' value="//www.baidu.com/img/baidu_logo.gif" readonly />

	<input type="file" model="native" config='{ "model" : "pics", "range" : [1000, 1200], "thumb" : 50 }' />

	<input type="file" model="native" config='{ "model" : "pics", "slice" : [ 200, 150 ], "thumb" : [ 200, 150 ] }' />

	<input type="file" model="native" config='{ "model" : "pics", "range" : [1000, 1200], "group" : [ 50, [ 400, 300 ], [800, 600] ] }' />

	参考资料：http://www.veryide.com/projects/upload/

### 高级图片上传

	<input type="file" model="magick" storage="" preview="" config="" />

	<input type="file" model="magick" storage=".text" preview="#view" config='{ "quality" : "50","output" : "jpg" }' />

	<input type="file" model="magick" name="image" config='{ "slice" : [ 200, 150 ], "thumb" : [ 200, 150 ] }' />

	参考资料：http://www.veryide.com/projects/magick/

### 上传参数

	model:	上传模式（native 原生文件上传 / magick 图片压缩算法上传 / editor 编辑器文件上传）

	token:	签名参数（可能是加密后的用户信息）

	config: 上传配置（可选）

		thumb: 可选，创建一个图片缩略图副本； 
		group: 可选，同时创建多个尺寸图片副本，如：[ 50, [ 400, 300 ], [800, 600] ]
		slice: 可选，对原图进行裁切处理；按指定尺寸裁切：[1024, 768]；按宽度百分比裁切：80
		range: 可选，对原图限制最大尺寸；限制最大的宽度和高度：[1024, 768]，超出时将缩放；

### 文本复制
	<input type="text" clipboard />

	<input type="text" data-clipboard-tips="复制成功" clipboard />

	参考资料：[https://clipboardjs.com/](https://clipboardjs.com/)

### URL简化
	<input type="text" data-url-simplify />
	
### URL缩短
	<input type="text" data-url-tinyurl />

### 标签嗅探
	原生文件上传、图片压缩上传、复制到剪贴板、富文本编辑器，都依赖了标签嗅探，用来判断是否需要加载相关的脚本和资源文件

	1. 图片延迟加载 img[raw] 如：<img raw="https://www.baidu.com/img/baidu.gif" />
	2. 原生文件上传 input[model=native] 如：<input type="file" model="native" config="" />
	3. 图片压缩上传 input[model=magick] 如：<input type="file" model="magick" storage="" preview="" />
	4. 富文本编辑器 textarea[editor] 如：<textarea editor="" />
	5. 复制到剪贴板 [clipboard] 如：<input type="text" data-clipboard-target="#target" clipboard />

## 已知问题

	1. 不能使用 <template> 包含 <fragment>，会导致 <fragment> 无法生效
	2. <fragment> 中动态创建的 Vue 数据，使用前需要使用 v-if 判断
	3. 不同类型的上传都是经过 Hybrid.config.upload，其中 model 参数表示上传方式
	4. 表单 Ajax 提交，仅对 method="post" target="ajax" 有效，所有的 Ajax 请求都需返回 xml 数据
	5. 优化考虑，当页面不可见时（document.visibilityState == 'hidden'），将暂停数据定时请求
