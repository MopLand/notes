# 前端面试题

## HTML

### 行内元素有哪些？块级元素有哪些？ 空(void)元素有那些？

（1）行内元素有：a b span img input select strong（强调的语气）

（2）块级元素有：div ul ol li dl dt dd h1 h2 h3 h4… p

（3）常见的空元素（开始标签与结束标签之间没有内容的元素）：

	常用空元素
	<br> <hr> <img> <input> <link> <meta>

	不常用空元素
	* <area> <col>
	* <base>  为页面上的所有链接规定默认地址或默认目标。
	* <command> command 元素表示用户能够调用的命令。
	* <embed> 标签定义嵌入的内容，比如插件。
	* <keygen> 标签规定用于表单的密钥对生成器字段。当提交表单时，私钥存储在本地，公钥发送到服务器。
	* <param> 此标签可为包含它的 <object> 或者 <applet> 标签提供参数。
	* <source> 标签允许您规定可替换的视频/音频文件供浏览器根据它对媒体类型或者编解码器的支持进行选择。
	* <track> <track> 标签为诸如 video 元素之类的媒介规定外部文本轨道。
	* <wbr> <p>果想学习 AJAX <wbr>Http<wbr>Request 对象。</p>   规定在文本中的何处适合添加换行符。

### 简述一下你对HTML语义化的理解？

	用正确的标签做正确的事情。
	html语义化让页面的内容结构化，结构更清晰，便于浏览器、搜索引擎的解析;
	即使在没有样式CSS情况下也以一种文档格式显示，并且是容易阅读的;
	搜索引擎的爬虫也依赖于HTML标记来确定上下文和各个关键字的权重，利于SEO;
	使阅读源代码的人对网站更容易将网站分块，便于阅读维护理解。

### 请描述一下 cookies，sessionStorage 和 localStorage 的区别？

	cookie 是网站为了标示用户身份而储存在用户本地终端（Client Side）上的数据（通常经过加密）。
	cookie 数据始终在同源的 http 请求中携带（即使不需要），记会在浏览器和服务器间来回传递。
	sessionStorage 和 localStorage 不会自动把数据发给服务器，仅在本地保存。
	
	存储大小：
	cookie数据大小不能超过4k。
	sessionStorage 和 localStorage 虽然也有存储大小的限制，但比 cookie 大得多，可以达到 5M 或更大。
	
	过期时间：
	localStorage    存储持久数据，浏览器关闭后数据不丢失除非主动删除数据；
	sessionStorage  数据在当前浏览器窗口关闭后自动删除。
	cookie          设置的 cookie 过期时间之前一直有效，即使窗口或浏览器关闭

### iframe 有那些缺点？

	1. iframe 会阻塞主页面的 onload 事件；
	2. 搜索引擎的检索程序无法解读这种页面，不利于SEO;	
	3. iframe 和主页面共享连接池，而浏览器对相同域的连接有限制，所以会影响页面的并行加载。

### Label的作用是什么？是怎么用的？

	label标签来定义表单控件间的关系,当用户选择该标签时，浏览器会自动将焦点转到和标签相关的表单控件上。
	
	<label for="Name">Number:</label>
	<input type="text" name="Name" id="Name"/>	
	<label>Date:<input type="text" name="B"/></label>

### 如何实现浏览器内多个标签页之间的通信? 

	WebSocket、SharedWorker；
	也可以调用 localstorge、cookies 等本地存储方式；
	
	localstorge 另一个浏览上下文里被添加、修改或删除时，它都会触发一个事件，我们通过监听事件，来实现页面信息通信；

### 页面可见性（Page Visibility API） 可以有哪些用途？

	通过 visibilityState 的值检测页面当前是否可见，以及打开网页的时间等;
	在页面被切换到其他后台进程的时候，自动暂停音乐或视频的播放；

### 网页验证码是干嘛的，是为了解决什么安全问题？

	区分用户是计算机还是人的公共全自动程序。可以防止恶意破解密码、刷票、论坛灌水；
	有效防止黑客对某一个特定注册用户用特定程序暴力破解方式进行不断的登陆尝试。

### 谈谈对html5的了解

	1. 良好的移动性，以移动设备为主。
	2. 响应式设计，以适应自动变化的屏幕尺寸
	3. 支持离线缓存技术，webStorage本地缓存
	4. 新增 canvas，video，audio 等新标签元素。新特殊内容元素：article，footer，header，nav，section等，新的表单控件：calendar，date，time，email，url，search。
	5. 地理定位
	6. 新增 WebSocket 和 Service Worker 技术

## CSS

### 介绍一下标准的CSS的盒子模型？低版本IE的盒子模型有什么不同的？

	1. IE 盒子模型 和 W3C 盒子模型；
	2. 盒模型： 内容(content)、填充(padding)、边界(margin)、 边框(border)；
	3. 区  别： IE的 content 部分把 border 和 padding 计算了进去;

### CSS 选择器有哪些？哪些属性可以继承？

	选择器
	1. id选择器（ # myid）
	2. 类选择器（.myclassname）
	3. 标签选择器（div, h1, p）
	4. 相邻选择器（h1 + p）
	5. 子选择器（ul > li）
	6. 后代选择器（li a）
	7. 通配符选择器（ * ）
	8. 属性选择器（a[rel = "external"]）
	9. 伪类选择器（a:hover, li:nth-child）

	可继承的样式
	font-size font-family color, UL LI DL DD DT
	
	不可继承的样式
	border padding margin width height

### CSS优先级算法如何计算？

	* 优先级就近原则，同权重情况下样式定义最近者为准;
	* 载入样式以最后载入的定位为准;

	优先级为
	同权重: 内联样式表（标签内部）> 嵌入样式表（当前文件中）> 外部样式表（外部文件中）。
	!important >  id > class > tag
	important 比 内联优先级高

### position 有哪些值？各自有什么作用？

	absolute
	生成绝对定位的元素，相对于值不为 static的第一个父元素进行定位。

	fixed （老IE不支持）
	生成绝对定位的元素，相对于浏览器窗口进行定位。

	relative
	生成相对定位的元素，相对于其正常位置进行定位。

	inherit
	规定从父元素继承 position 属性的值。

	static
	默认值。没有定位，元素出现在正常的流中（忽略 top, bottom, left, right z-index 声明）。

### margin 和 padding 分别适合什么场景使用？

	margin 是用来隔开元素与元素的间距
	margin 用于布局分开元素使元素与元素互不相干

	padding 是用来隔开元素与内容的间隔
	padding 用于元素与内容之间的间隔，让内容（文字）与（包裹）元素之间有一段

### png、jpg、gif 这些图片格式各有什么特点？有没有了解过webp？

	1. png 是便携式网络图片（Portable Network Graphics）是一种无损数据压缩位图文件格式， 优点是：压缩比高，色彩好。 大多数地方都可以用。

	2. jpg 是一种针对相片使用的一种失真压缩方法，是一种破坏性的压缩，在色调及颜色平滑变化做的 不错。 在www上，被用来储存和传输照片的格式。

	3. gif 是一种位图文件格式，以8位色重现真色彩的图像。可以实现动画效果时候

	4. webp 是谷歌在2010年推出的图片格式，压缩率只有 jpg 的2/3，大小比 png 小了45%，缺点是压缩的时间更久了。目前只有谷歌和 opera 支持。

### 请求资源的时候不要让它带 cookie 怎么做？这么做有什么好处？

	静态资源放 CDN ，用 cookie free domain 因为 cookie 有域的限制，因此不能跨域提交请求，故使用非 主要域名的时候，请求头中就不会带有cookie数据，这样可以降低请求头的大小，降低请求时间，从而达到 降低整体请求延时的目的。

## JavaScript

### eval 是做什么的？

	它的功能是把对应的字符串解析成JS代码并运行；
	应该避免使用eval，不安全，非常耗性能（2次，一次解析成js语句，一次执行）。

### apply 和 call 方法的异同？

	call() 方法参数将依次传递给借用的方法作参数，即 fn.call(thisobj, arg1,arg2,arg3...argn)，有n个参数

	apply() 方法第一个参数是对象，第二个参数是数组 fn.apply(thisobj,arg)，此处的arg是一个数组,只有两个参数

### 什么是 window 对象? 什么是 document 对象?

	window 对象是指浏览器打开的窗口。
	document 对象是 Document 对象（HTML 文档对象）的一个只读引用，是 window 对象的一个属性。

### 对 JSON 的了解？

	JSON(JavaScript Object Notation) 是一种轻量级的数据交换格式。
	它是基于JavaScript的一个子集。数据格式简单, 易于读写, 占用带宽小。

### 将 JSON 对象转为字符串形式？

	JSON.stringify

### 将 JSON 字符串转为对象形式？

	JSON.parse

### 谈谈你对闭包的理解？


### Ajax 解决浏览器缓存问题？

	1. 在ajax发送请求前加上 xhr.setRequestHeader("If-Modified-Since", "0")
	
	2. 在ajax发送请求前加上 xhr.setRequestHeader("Cache-Control", "no-cache")
	
	3. 在URL后面加上一个随机数或时间戳： "rnd=" + Math.random();

### 同步和异步的区别?

	同步的概念应该是来自于OS中关于同步的概念:不同进程为协同完成某项工作而在先后次序上调整(通过阻塞,唤醒等方式). 同步强调的是顺序性.谁先谁后.异步则不存在这种顺序性.

	同步：
	浏览器访问服务器请求，用户看得到页面刷新，重新发请求,等请求完，页面刷新，新内容出现，用户看到新内容,进行下一步操作。
	
	异步：
	浏览器访问服务器请求，用户正常操作，浏览器后端进行请求。等请求完，页面不刷新，新内容也会出现，用户看到新内容。

## 其他问题

### 原来公司工作流程是怎么样的，如何与其他人协作的？如何夸部门合作的？

	1. 与后台沟通接口文档
	2. 使用原型软件设计原型
	3. 进行开发
	4. 后期测试
	5. 部署上线

### 你遇到过比较难的技术问题是？你是如何解决的？


### 常使用的库有哪些？常用的前端开发工具？开发过什么应用或组件？


### 有没有使用过 Node.js？


### 如何对网站的文件和资源进行优化

	1. 文件合并（目的是减少 http 请求）
	2. 文件压缩（目的是直接减少文件下载的体积）
	3. 使用 cdn 托管资源
	4. 使用缓存
	5. gizp 压缩你的js和css文件
	6. meta 标签优化（title,description,keywords）, heading 标签的优化, alt 优化
	7. 反向链接，网站外链接优化


### 什么叫优雅降级和渐进增强？

	优雅降级：

	Web站点在所有新式浏览器中都能正常工作，如果用户使用的是老式浏览器，则代码会针对旧版本的
	IE进行降级处理了,使之在旧式浏览器上以某种形式降级体验却不至于完全不能用。

	如：border-shadow
	
	渐进增强：

	从被所有浏览器支持的基本功能开始，逐步地添加那些只有新版本浏览器才支持的功能,向页面增加
	不影响基础浏览器的额外样式和功能的。当浏览器支持时，它们会自动地呈现出来并发挥作用。

	如：默认使用 Flash 上传，但如果浏览器支持 HTML5 的文件上传功能，则使用HTML5实现更好的体验；