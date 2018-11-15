# MySQL

## 命令行

#### 显示当前数据库服务器中的数据库列表

	SHOW DATABASES;

#### 切换至某数据库
	USE `dbname`;

#### 显示数据表清单
	SHOW TABLES;

#### 显示数据表的结构
	DESCRIBE `tblname`;

#### 导入 SQL
	SOURCE d:/mysql.sql;

#### 重建索引
	REPAIR TABLE `tblname` QUICK;

#### 刷新权限
	FLUSH PRIVILEGES;

#### 显示系统变量值
	SHOW VARIABLES LIKE 'max_connections';

----------

## 查询数据

#### 显示表中的记录
	SELECT * FROM `tblname`;

#### 联合查询
	SELECT a.*, b.* FROM `tbla` AS a LEFT JOIN `tblb` AS b ON a.id = b.id;

#### IF CASE 运算
	SELECT IF (priv=1, admin, guest) AS usertype FROM privs WHERE username = joe;

#### GROUP BY 分组查询
	SELECT name, SUM(price) FROM `tblname` GROUP BY name;

#### BETWEEN 查询
	SELECT name, SUM(price) FROM `tblname` WHERE `month` BETWEEN 1 AND 12;

#### 分组查询并去重复
	SELECT admin_id, SUM( money ) FROM pre_tasks_list GROUP BY admin_id;

	SELECT admin_id, SUM( DISTINCT admin_id ) FROM pre_tasks_list GROUP BY admin_id;

#### 返回第一个非 NULL 的值
	SELECT COALESCE(NULL, NULL, 1);

#### 返回一个字符串结果，该结果由分组中的值连接组合而成
	SELECT GROUP_CONCAT(id) AS ids FROM pre_portal_category WHERE status > 0 AND parent = 10;

	SELECT GROUP_CONCAT(id SEPARATOR '|') AS ids FROM pre_portal_category WHERE status > 0 AND parent = 10;

	SELECT GROUP_CONCAT(id ORDER BY id DESC SEPARATOR ',') AS ids FROM pre_portal_category WHERE status > 0 AND parent = 10;

	SELECT COALESCE(GROUP_CONCAT(id ORDER BY id DESC SEPARATOR ','),0) AS ids FROM pre_portal_category WHERE status > 0 AND parent = 10;

#### 同时使用 GROUP BY 和 ORDER BY
	SELECT * FROM ( select id, agent_id, agent_name , sum(money) AS total FROM `pre_agent_trade` WHERE money > 0 AND `status` > 0 GROUP BY agent_id ) as t ORDER BY total DESC LIMIT 10;

#### 取分组第一条记录
	SELECT * FROM `pre_market_version` WHERE id IN( SELECT MAX(id) FROM `pre_market_version` GROUP BY `appid` );

#### 查询重复记录
	SELECT email, COUNT(email) AS q FROM emails_table GROUP BY email HAVING q > 1 ORDER BY q DESC;
	
#### 销售额前100的代理
	SELECT t.agent_id, t.agent_name, a.qq, sum(t.money) AS total FROM `pre_agent_trade` as t left join pre_agent_list as a on a.agent_id = t.agent_id WHERE t.money > 0 GROUP BY t.agent_id ORDER BY total DESC LIMIT 100;

#### 返回得分最高的 20 条记录，每个用户保留一条记录
	SELECT raw.userid, raw.username, tmp.score, min(time) time FROM (select userid, max(score) score FROM `pre_testing_record` WHERE activity_id = ? GROUP BY userid) tmp JOIN `pre_testing_record` raw ON raw.userid = tmp.userid AND tmp.score = raw.score WHERE activity_id = ? GROUP BY tmp.userid, tmp.score ORDER BY tmp.score DESC, time ASC, raw.record_id ASC LIMIT 20;

#### 左连接的表中有多条数据，只取按时间排序最大的一条
	SELECT c.*, g.goods_name, g.goods_short, g.goods_thumb, g.attr_price FROM `pre_goods_list` AS g INNER JOIN `pre_goods_comment` AS c ON c.goods_id = g.goods_id WHERE g.goods_id > 0 AND g.attr_comment > 0 AND c.comment_id = (SELECT MAX(comment_id) FROM `pre_goods_comment` WHERE goods_id = g.goods_id);
	
#### 最近7天，每个时段查询
	SELECT FROM_UNIXTIME(dateline,'%H') AS hh, appid, `version`, count(*) FROM pre_app_statis WHERE `datetime` > DATE_SUB(CURDATE(), INTERVAL 7 DAY) GROUP BY hh, appid, `version`;

#### 最近7天，每个版本查询
	SELECT `datetime`, appid, `version`, count(*) FROM pre_app_statis WHERE appid = 1 AND `datetime` > DATE_SUB(CURDATE(), INTERVAL 7 DAY) GROUP BY `datetime`, `version`;

#### 提现次数大于 2 笔的用户
	SELECT agent_id, agent_name, `money`, `datetime`, count(*) as stat FROM `pre_agent_trade` WHERE `money` < 0 and `datetime` >= 20160720 group by agent_id HAVING stat > 1;

#### 查找重复的卡密
	SELECT agent_id, agent_name, code, count(*) as stat FROM `pre_agent_cdkey` GROUP BY code HAVING stat > 1;

#### 新注册代理付款金额
	SELECT t.sn, t.id, t.money, c.agent_id, c.agent_name from pre_agent_trade as t LEFT JOIN ( SELECT * FROM `pre_agent_cdkey` WHERE trade_id > 0 ORDER BY trade_id ASC group by trade_id ) AS c on t.id = c.trade_id WHERE t.sn != '';

#### 商品搜索页排序显示
	SELECT `id`, `gid`, `title`, stick, uid, `dateline`, `timeline`, from_unixtime( `timeline`, '%Y/%m/%d %T' ) FROM `pre_goods_list` WHERE 1 = 1 AND `status` > 0 ORDER BY stick DESC, timeline DESC limit 80, 40;

#### 代理销售前100
	SELECT t.agent_id, t.agent_name, l.qq, sum(t.money) as stat FROM `pre_trade_list` as t LEFT JOIN `pre_agent_list` as l on t.agent_id = l.agent_id group by t.agent_id ORDER BY stat DESC limit 100;

#### 连接多个字段
	SELECT CONCAT(name,' ',surname) AS complete_name FROM users;

#### 移除小数后面的零
	SELECT (TRIM(attr_price) + 0 ) AS attr_price;

#### 指定使用索引
	SELECT id FROM data USE INDEX(type) WHERE type = 12345 AND level > 3 ORDER BY id;

#### 使用全文索引
	SELECT * FROM articles WHERE MATCH(content_column) AGAINST ('music');

#### 中文字符排序
	SELECT * FROM `tblname` ORDER BY CONVERT(vender_abbrev USING gbk) ASC;

#### Where IN 同时保持排序（IN 适合于外表数据量大而内表数据小的情况）
	SELECT * FROM `tblname` WHERE id IN(5,2,6,8,12,1) ORDER BY FIELD(id,5,2,6,8,12,1);

#### Where EXISTS（EXISTS 适合于外表小而内表大的情况）
	SELECT num FROM `tblname` AS t where EXISTS( SELECT 1 FROM `tblmisc` WHERE num = t.num );

#### 查找以逗号分隔的值，IN 效率更好
	SELECT COUNT(*) FROM `pre_member_client` WHERE FIND_IN_SET(`app_id`, '20860,20859,20858,20857,20856');
	
#### 查找某字段不以某符号结尾的记录
	SELECT * FROM `pre_article_list` WHERE id NOT IN ( SELECT id FROM `pre_article_list` WHERE article_content LIKE '%>' );

#### 使用正则匹配
	SELECT * FROM `pre_wechat_account` WHERE 'www.example.com' REGEXP domain;

#### 当前时间戳
	SELECT UNIX_TIMESTAMP();

#### 格式化时间

	SELECT DATE_FORMAT(NOW(),'%Y') YEAR;
	# 输出结果：2012
	
	SELECT DATE_FORMAT(NOW(),'%y') YEAR;
	# 输出结果：12
	
	SELECT DATE_FORMAT(NOW(),'%m') MONTH;
	# 输出结果：11
	
	SELECT DATE_FORMAT(NOW(),'%d') DAY;
	# 输出结果：15
	
	SELECT DATE_FORMAT(NOW(),'%T') TIME;
	# 输出结果：14:44:50
	
	SELECT DATE_FORMAT(NOW(),'%Y-%m-%d') DATE;	
	# 输出结果：2012-11-15
	
	SELECT DATE_FORMAT(NOW(),'%Y-%m-%d-%T') DATETIME;
	# 输出结果：2012-11-15-14:46:57
	
	SELECT FROM_UNIXTIME( 1529640863, '%Y%m%d');
	# 输出结果：20180622

	SELECT CURRENT_DATE - INTERVAL 15 DAY;
	# 15天前的时间

	SELECT CURRENT_DATE - INTERVAL 1 MONTH;
	# 1个月前的时间

	SELECT UNIX_TIMESTAMP( CURRENT_DATE - INTERVAL 15 DAY );
	# 15天前的时间戳

----------

## 插入数据

### 插入数据
	INSERT INTO `tblname` VALUES ('a','b');

### 从一个表插入另外一个表
	INSERT INTO `tblname` (field1,field2,field3) SELECT newfield1,newfield2,'fixed value' FROM `tblname2`;
	
### 将过期商品拷贝到备份表
	REPLACE INTO `pre_goods_backup` SELECT * FROM `pre_goods_list` WHERE `status` = 0 AND `coupon_expire` - today <= valid;

----------

## 删除和更新

### 删除数据
	DELETE FROM `tblname` WHERE site_id = 46;
	
### 带查询的删除
	DELETE FROM `tblname` WHERE gid IN( SELECT gid FROM `pre_goods_list` WHERE `status` = 0 AND `coupon_expire` - today <= valid );

### 更新数据
	UPDATE `tblname` SET field1 = 'a', field2 = 'b' WHERE field3 = 'c';

### 带条件更新
	UPDATE `tblname` SET leader = IF( id in (1,2), 1, 0) WHERE gid = 1 LIMIT 10;

### 在0或1之间切换
	UPDATE `tblname` SET field = 1 - field;

### 带查询的更新
	UPDATE pre_tasks_list SET payout_quantity =( SELECT count(*) FROM pre_tasks_order WHERE pre_tasks_order.status = 1 AND pre_tasks_list.id = pre_tasks_order.tasks_id );

### 保留用户最新一条记录，其他删除
	DELETE FROM `tblname` WHERE id NOT IN( SELECT ids FROM ( SELECT max(id) AS ids FROM `tblname` GROUP BY openid ) AS tmp );

### 上架已通过审核的商品
	UPDATE `pre_goods_list` SET status = 1 WHERE gid IN ( SELECT gid FROM `pre_member_goods` WHERE status = 1 );
	
### 补全 URL 协议
	UPDATE `pre_member_list` SET avatar = CONCAT( 'https:', avatar ) WHERE SUBSTRING( avatar, 1, 2 ) = '//';
	
----------

## 结构更改

### 建表结构
	SHOW CREATE TABLE `tblname`;

### 重建数据表
	TRUNCATE TABLE `tblname`;

### 更改表引擎
	ALTER TABLE `tblname` ENGINE = innodb;

### 创建数据库
	CREATE DATABASE `dbname`;

### 复制表结构
	CREATE TABLE `tblname` LIKE `users`;

### 完全复制表
	CREATE TABLE `tblname` SELECT * FROM `users`;
		
### 备份表不存在时，复制表结构
	CREATE TABLE IF NOT EXISTS `pre_goods_backup` LIKE `pre_goods_list`;

### 创建数据表
	CREATE TABLE `tblname` (
	  `id` int(11) NOT NULL auto_increment,
	  `fid` int(11) NOT NULL,
	  `appid` varchar(15) NOT NULL,
	  `uid` int(11) NOT NULL,
	  `username` varchar(30) default NULL,
	  `config` text,
	  `state` tinyint(4) NOT NULL,
	  `dateline` int(11) NOT NULL,
	  `ip` varchar(15) NOT NULL,
	  PRIMARY KEY  (`id`),
	  KEY `fid` (`fid`),
	  KEY `appid` (`appid`),
	  KEY `uid` (`uid`),
	  KEY `username` (`username`)
	) ENGINE=MyISAM;

### 重命名表名
	ALTER TABLE `tblname` RENAME `abc`;

### 更改表名
	RENAME TABLE `oldname` TO `tblname`;

### 修改字段类型
	ALTER TABLE `tblname` MODIFY `field` VARCHAR(255) NULL DEFAULT NULL;

### 修改字段区分大小写
	ALTER TABLE `tblname` MODIFY `url` varchar(700) BINARY NOT NULL;

### 同时修改字段名和类型
	ALTER TABLE `tblname` CHANGE `new` `old` VARCHAR(255) NULL DEFAULT NULL;

### 新增字段
	ALTER TABLE `tblname` ADD `new` INT NOT NULL AFTER `abc`;

### 新增索引
	CREATE INDEX `state` ON `tblname` (`state`);

	CREATE UNIQUE INDEX `state` ON `tblname` (`state`);

### 删除主键
	ALTER TABLE `tblname` DROP PRIMARY KEY;

### 删除主键，去自增
	ALTER TABLE `tblname` MODIFY id INT, DROP PRIMARY KEY;

### 删除表
	DROP TABLE IF EXISTS `tblname`;

### 删除字段
	ALTER TABLE `tblname` DROP `field`;

### 删除索引
	ALTER TABLE `tblname` DROP INDEX `field`;

### 整表转编码
	ALTER TABLE `tblname` CONVERT TO CHARACTER SET utf8;

----------

## 触发器操作

### 新增触发器
	CREATE TRIGGER `tasks_order_totals` AFTER INSERT ON `pre_tasks_order` FOR EACH ROW
	BEGIN
	    UPDATE pre_tasks_dist set `total` = `total` + 1, `money` = `money` + new.money WHERE tasks_id = new.tasks_id;
	END;;

### 触发器时机
	AFTER UPDATE	更新时
	BEFORE UPDATE	更新前

	AFTER INSERT	插入时
	BEFORE INSERT	插入前

	AFTER DELETE	删除时
	BEFORE DELETE	删除前

### 单个变量定义
	DECLARE stats INT;

    SET stats = ( SELECT COUNT(*) FROM pre_tasks_order WHERE tasks_id = new.tasks_id AND taoke_id = old.taoke_id AND status = 1 LIMIT 1 );
    UPDATE pre_tasks_dist set valid = stats WHERE tasks_id = old.tasks_id AND taoke_id = old.taoke_id;

### 多个变量赋值
	DECLARE stats INT;
	DECLARE total decimal(10,2);

    SELECT COUNT(*),SUM(money) INTO @stats,@total FROM pre_tasks_order WHERE tasks_id = new.tasks_id AND taoke_id = old.taoke_id AND status = 1;
    UPDATE pre_tasks_dist set `valid` = @stats, `money` = @total WHERE tasks_id = old.tasks_id AND taoke_id = old.taoke_id;

### 删除触发器
	DROP TRIGGER `tasks_order_totals`;

----------

## 自定义函数

### 定义方法
	DELIMITER ;;
	DROP FUNCTION IF EXISTS fetch_month;
	CREATE FUNCTION fetch_month() RETURNS INT READS SQL DATA
	BEGIN

		-- 上月时间
		DECLARE m_begin INT DEFAULT( date_add(date_add(LAST_DAY(CURRENT_DATE),interval 1 DAY),interval -2 MONTH) );
		DECLARE m_final INT DEFAULT( LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) );

		RETURN( m_final - m_begin );
	END;
	;;

### 调用方法
	SELECT fetch_month();

----------

## 存储过程

### 定义方法
	DELIMITER //
	DROP PROCEDURE IF EXISTS create_serial //
	CREATE PROCEDURE create_serial()
	BEGIN 
		DECLARE init INT DEFAULT 1;
		
		WHILE init < 200 DO
			INSERT INTO pre_agent_serial(code) VALUES(replace(RAND(),'.',''));
			SET init = init + 1;
		END WHILE;
	END;
	//

### 调用方法
	call create_serial();

----------

## 视图操作

### 创建视图
	CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `pre_tasks_order_extend` AS SELECT o.*, tk.taoke_name FROM `pre_tasks_order` AS o LEFT JOIN `pre_taoke_list` AS tk ON o.taoke_id = tk.taoke_id;

### 跨库建视图
	CREATE VIEW `pre_agent_config` AS select * FROM `tps`.`pre_agent_config`;

### 删除视图
	DROP VIEW `pre_tasks_order_extend`;

----------

## 添加用户

### 指定主机
	GRANT ALL PRIVILEGES ON *.* TO qcloud@localhost IDENTIFIED BY 'password' WITH GRANT OPTION;

### 任何主机
	GRANT ALL PRIVILEGES ON *.* TO qcloud@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;

----------

## 事件调度器

### 全局开启
	set global event_scheduler=1;

### 创建方法
	DELIMITER $$
	CREATE EVENT `test_event`
	ON SCHEDULE
	    EVERY 1 MINUTE
	    ON COMPLETION PRESERVE
	DO
	BEGIN
		INSERT INTO `tblname`(`time`) VALUES (NOW());		
	
	END $$	
	DELIMITER ;

### 关闭事件
	ALTER EVENT `test_event` DISABLE;

### 开启事件
	ALTER EVENT `test_event` ENABLE;

### 删除事件
	DROP EVENT IF EXISTS `test_event`;

----------

## 性能优化

### 为查询缓存优化你的查询

	<?php
	// 查询缓存不开启
	$result = mysql_query("SELECT username FROM user WHERE signup_date >= CURDATE()");
	 
	// 开启查询缓存
	$today = date("Y-m-d");
	$result = mysql_query("SELECT username FROM user WHERE signup_date >= '$today'");

### EXPLAIN 你的 SELECT 查询

	EXPLAIN SELECT COUNT(*) FROM `pre_member_goods` WHERE `status` = 0 AND uid = 12003;

### 当只要一行数据时使用 LIMIT 1

	SELECT * FROM `pre_member_goods` WHERE `status` = 0 AND uid = 12003 LIMIT 1;

### 为搜索字段建索引

	ALTER TABLE `pre_member_goods` ADD INDEX `status` (`status`);

### 在Join表的时候使用相当类型的例，并将其索引

	<?php
	$sql = "SELECT company_name FROM users LEFT JOIN companies ON (users.state = companies.state)
    WHERE users.id = $user_id";

	$result = mysql_query( $sql );

### 千万不要 ORDER BY RAND()

	<?php
	// 千万不要这样做
	$r = mysql_query("SELECT username FROM user ORDER BY RAND() LIMIT 1");
	 
	// 这要会更好
	$r = mysql_query("SELECT count(*) FROM user");
	$d = mysql_fetch_row($r);
	$rand = mt_rand(0,$d[0] - 1);
	 
	$r = mysql_query("SELECT username FROM user LIMIT $rand, 1");

### 避免 SELECT *
	
	SELECT goods_id, goods_name FROM `pre_member_goods` WHERE `status` = 0 AND uid = 12003 LIMIT 1;

### 永远为每张表设置一个ID

	ALTER TABLE `test` ADD `id` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

### 把IP地址存成 UNSIGNED INT

	使用 INET_ATON() 来把一个字符串IP转成一个整形，并使用 INET_NTOA() 把一个整形转成一个字符串IP

	而在PHP中，使用函数 ip2long() 和 long2ip()

### 拆分大的 DELETE 或 INSERT 语句

	DELETE FROM logs WHERE log_date <= '2009-11-01' LIMIT 1000;

## 配置说明

#### 配置文件
	/etc/my.cnf

#### 等待超时（设置后会影响密集查询）
	wait_timeout = 10

#### 启用事件调度器
	event_scheduler = ON

#### 修复表进程
	myisam_repair_threads = 8

#### 最大连接数
	max_connections = 10240

#### 最大错误连接数（超过此值会导致拒绝连接请求）
	max_connect_errors = 1024

#### 连接的非NULL值的字符串长度
	group_concat_max_len = 102400

#### 慢查询时间限定
	long_query_time = 1

#### 开启慢查询日志
	slow_query_log = 1

#### 慢查询日志文件
	slow_query_log_file = /var/log/mysql.slow.log

#### 开启普通日志
	general_log = ON

#### 普通日志文件
	general_log_file = /var/log/mysql.general.log

#### 禁止DNS反向解析（可以提升远程连接速度）
	skip-name-resolve

#### 独立表空间
	innodb_file_per_table = 1

#### 缓冲池字节大小（内存的 70%-80%）
	innodb_buffer_pool_size = 6G

#### 日志组每个日志文件的字节大小
	innodb_log_file_size = 256M

#### 写入日志文件时的缓冲区大小
	innodb_log_buffer_size = 8M

#### 更改 Data 目录

	# /etc/my.cnf

	[mysqld]
	datadir=/disk/mysql
	socket=/disk/mysql/mysql.sock

#### 更改 sock 位置

	# /etc/my.cnf

	[client]
	socket=/disk/mysql/mysql.sock

	# /etc/php.ini

	mysql.default_socket = /disk/mysql/mysql.sock
	mysqli.default_socket = /disk/mysql/mysql.sock
	pdo_mysql.default_socket = /disk/mysql/mysql.sock

## 常见错误

#### Table 'performance_schema.session_status' doesn't exist
	mysql_upgrade -u root -p --force
	
#### SQLSTATE[HY000] [1129] is blocked because of many connection errors
	mysqladmin -uroot -p flush-hosts

#### ERROR 1040(00000):Too many connections

	表明云数据库实例当前最大连接数超过了限制。请检查程序，适当减少数据库的连接数。

#### 批量修改表引擎（MyISAM 转 InnoDB）
	SET @DATABASE_NAME = 'tblname';
	SELECT  CONCAT('ALTER TABLE `', table_name, '` ENGINE=InnoDB;') AS sql_statements
	FROM    information_schema.tables AS tb
	WHERE   table_schema = @DATABASE_NAME
	AND     `ENGINE` = 'MyISAM'
	AND     `TABLE_TYPE` = 'BASE TABLE'
	ORDER BY table_name DESC;

### 相关文章

- [http://lobert.iteye.com/blog/1953827](http://lobert.iteye.com/blog/1953827)
- [http://www.jianshu.com/p/8faa7dadd073](http://www.jianshu.com/p/8faa7dadd073)
- [creating-event-that-execute-at-end-of-each-month](http://dba.stackexchange.com/questions/80049/creating-event-that-execute-at-end-of-each-month)
- [ON SCHEDULE EVERY 1 MONTH](http://www.java2s.com/Code/SQL/Event/ONSCHEDULEEVERY1MONTH.htm)
- [MySql常用30种SQL查询语句优化方法](https://segmentfault.com/a/1190000013935099)
- [MySQL 性能优化神器 Explain 使用分析](https://segmentfault.com/a/1190000008131735)
- [腾讯云 CDB for MySQL 使用规范指南](https://cloud.tencent.com/document/product/236/13390)
- [DCDB开发指南](https://cloud.tencent.com/document/product/557/7714)