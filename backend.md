# 后端面试题

## PHP

### HTTP 中 POST、GET、PUT、DELETE 方式的区别？

	HTTP定义了与服务器交互的不同的方法，最基本的是POST、GET、PUT、DELETE，与其比不可少的URL的全称是资源描述符，我们可以这样理解：url描述了一个网络上资源，而 post、get、put、delete 就是对这个资源进行增、删、改、查的操作！

### 常用的属性的访问修饰符有哪些？分别代表什么含义？

	private, protected, public

	类外：public, var

	子类中：public, protected, var

	本类中：private, protected, public, var

### $this 和 self、parent 这三个关键词分别代表什么？在哪些场合下使用？

	$this 当前对象
	self 当前类
	parent 当前类的父类
	
	$this 在当前类中使用,使用->调用属性和方法。
	self 也在当前类中使用，不过需要使用::调用。
	parent 在类中使用。

### 作用域操作符 :: 如何使用？都在哪些场合下使用？

	1. 调用类常量
	2. 调用静态方法

### 什么是魔术方法？常用的魔术方法有哪几个？

	__construct()
	__destruct()
	__autoload()
	__call()
	__tostring()

###  __tostring()魔术方法在什么时候被自动执行？

	当 echo 或者 print 一个对象时，就是自动触发，而且 __tostring() 必须要返回一个值

### 什么是 session？为什么使用它？

	session 是指终端用户访问服务器在这个会话中不同页面切换共享的全局数据。
	session 数据保存在服务器端，每个 session 都有一个唯一的 sessionId。

### 什么是 cookie？为什么使用它？

	cookie是保存在客户端的数据，一些网站用来区分鉴别用户。php可以set和get cookie。

### 什么是 Composer？工作原理是什么？

	Composer 是 PHP 的一个依赖管理工具。工作原理就是将已开发好的扩展包从 packagist.org composer 仓库下载到我们的应用程序中，并声明依赖关系和版本控制。

## 数据库

### 什么是索引，作用是什么？

	索引类似于字典的前面的查字表，把某个字段的数据从头到尾排序放在一起，并写明对应的数据记录的位置。这样搜索的时候只要翻这个就可以了，不需要从头到尾遍历数据

### 常见索引类型有那些？

	1. 普通索引
	2. 唯一索引
	3. 主键索引
	4. 组合索引
	5. 全文索引

### 索引创建的原则？

	最左前缀原理
	选择区分度高的列作为索引
	尽量的扩展索引，不要新建索引
	最适合的索引的列是出现在where子句中的列或连接子句中指定的列

### 高并发如何处理？

	使用缓存
	优化数据库，提升数据库使用效率

### InnoDB 和 MyISAM 的区别？

	Innodb 支持事务处理、外键和行级锁，而 MyISAM 不支持

### 请简述为什么要使用数据库的事务？

	数据库事务(Database Transaction) ，是指作为单个逻辑工作单元执行的一系列操作，要么完全地执行，要么完全地不执行

## 缓存

### 有哪些常见的缓存方式？

	Redis Memcached 和 文件

### Redis、Memecached 这两者有什么区别？

	Redis 支持更加丰富的数据存储类型，String、Hash、List、Set 和 Sorted Set。Memcached 仅支持简单的 key-value 结构。
	Memcached key/value存储比 Redis 采用 hash 结构来做 key/value 存储的内存利用率更高。
	Redis 提供了事务的功能，可以保证一系列命令的原子性
	Redis 支持数据的持久化，可以将内存中的数据保持在磁盘中
	Redis 只使用单核，而 Memcached 可以使用多核，所以平均每一个核上 Redis 在存储小数据时比 Memcached 性能更高。

### Redis 如何实现持久化？

	RDB 持久化，将 redis 在内存中的的状态保存到硬盘中，相当于备份数据库状态。
	AOF 持久化（Append-Only-File），AOF 持久化是通过保存 Redis 服务器锁执行的写状态来记录数据库的。相当于备份数据库接收到的命令，所有被写入 AOF 的
	命令都是以 redis 的协议格式来保存的。

## 其他

### 有没有使用过 Git 或 SVN？


### 有接触或使用过哪些后端框架？


### 使用过哪些数据库？分别用在什么场景？


### 什么是SQL注入？如何防止SQL注入？


### 有没有写过接口？如何保证数据安全？


### 谈一谈对数据安全理解和措施？


### 文件上传功能如何实现？


### 有没有使用脚本处理过图片？


### 有没有接入过微信开放平台？


### 有没有接入过微信支付和支付宝？

