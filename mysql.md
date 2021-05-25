# MySQL

## 连接 MySQL

#### 连接本机
	mysql -u root -p

#### 连接远程
	mysql -h 110.110.110.110 -u root -p
	
#### 指定字符集
	mysql -u root -p --default-character-set=utf8mb4

## 常用命令

#### 显示当前进程列表
	SHOW PROCESSLIST;

#### 显示会话变量
	SHOW VARIABLES;
	SHOW SESSION VARIABLES;
	SHOW SESSION VARIABLES LIKE 'event_scheduler';

#### 设置会话变量
	SET wait_timeout = 10;
	SET SESSION wait_timeout = 10;

#### 显示系统变量
	SHOW GLOBAL VARIABLES;
	SHOW GLOBAL VARIABLES LIKE 'event_scheduler';

#### 设置全局变量
	SET GLOBAL wait_timeout = 10;

#### 显示当前数据库服务器中的数据库列表
	SHOW DATABASES;

#### 显示当前用户
	SELECT current_user;

#### 切换至某数据库
	USE `dbname`;

#### 显示数据表清单
	SHOW TABLES;

#### 显示数据表的结构
	DESCRIBE `tblname`;

#### 导入 SQL
	SOURCE d:/mysql.sql;

#### 刷新权限
	FLUSH PRIVILEGES;

## 表操作

#### 分析表
	ANALYZE TABLE `tblname`;

#### 优化表（会锁定表）
	OPTIMIZE TABLE `tblname`;

#### 检查表
	CHECK TABLE `tblname`;

#### 校验表
	CHECKSUM TABLE `tblname`;

#### 修复表
	REPAIR TABLE `tblname`;

#### 快速修复表（重建索引）
	REPAIR TABLE `tblname` QUICK;

#### 清空表
	TRUNCATE TABLE `pre_template_widget`;

#### 删除表
	DROP TABLE `tblname`;

----------

## 查询数据

#### 显示表中的记录
	SELECT * FROM `tblname`;

#### 联合查询
	SELECT a.*, b.* FROM `tbl_a` AS a LEFT JOIN `tbl_b` AS b ON a.id = b.id;

#### IF CASE 运算
	SELECT IF (priv=1, admin, guest) AS usertype FROM privs WHERE username = 'joe';

#### GROUP BY 分组查询
	SELECT name, SUM(price) FROM `tblname` GROUP BY name;

#### BETWEEN 查询
	SELECT name, SUM(price) FROM `tblname` WHERE `month` BETWEEN 1 AND 12;

#### 区分大小写查询
	SELECT * from `tblname` WHERE BINARY columnA = 'abc';
	
#### 截取部分字符串，查询超长文本会显著提高效率
	SELECT event_id, taking_time, memory_usage, SUBSTR(result, 1, 200) as result FROM `pre_cron_event`;

#### 分组查询并去重复
	SELECT admin_id, SUM( money ) FROM pre_tasks_list GROUP BY admin_id;
	
	SELECT admin_id, SUM( DISTINCT admin_id ) FROM pre_tasks_list GROUP BY admin_id;

#### 按状态值统计数量
	SELECT `status`, COUNT(*) AS stats FROM `pre_taobao_adzone` GROUP BY `status`;

#### 返回第一个非 NULL 的值
	SELECT COALESCE(NULL, NULL, 1);

#### 返回一个字符串结果，该结果由分组中的值连接组合而成
>	注意：mysql 的 group_concat_max_len 参数会影响运行结果
	
	SELECT GROUP_CONCAT(id) AS ids FROM pre_portal_category WHERE status > 0 AND parent = 10;
	
	SELECT GROUP_CONCAT(id SEPARATOR '|') AS ids FROM pre_portal_category WHERE status > 0 AND parent = 10;
	
	SELECT GROUP_CONCAT(id ORDER BY id DESC SEPARATOR ',') AS ids FROM pre_portal_category WHERE status > 0 AND parent = 10;
	
	SELECT COALESCE(GROUP_CONCAT(id ORDER BY id DESC SEPARATOR ','),0) AS ids FROM pre_portal_category WHERE status > 0 AND parent = 10;
	
	SELECT GROUP_CONCAT(goods_id SEPARATOR ',') AS ids FROM ( SELECT goods_id FROM `pre_goods_list` WHERE `status` = 1 AND `cate_route` IS NULL ORDER BY id DESC LIMIT 40 ) AS tmp;

#### 同时使用 GROUP BY 和 ORDER BY
	SELECT * FROM ( select id, agent_id, agent_name , sum(money) AS total FROM `pre_agent_trade` WHERE money > 0 AND `status` > 0 GROUP BY agent_id ) as t ORDER BY total DESC LIMIT 10;

#### 多个字段 GROUP BY
	SELECT SUM(total) FROM ( SELECT * FROM `pre_jingdong_deduct` WHERE id > 0 GROUP BY trade_id, sku_id) AS t;

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
	SELECT `id`, `gid`, `title`, stick, uid, `dateline`, `timeline`, FROM_UNIXTIME( `timeline`, '%Y/%m/%d %T' ) FROM `pre_goods_list` WHERE `status` > 0 ORDER BY stick DESC, timeline DESC limit 80, 40;

#### 代理销售前100
	SELECT t.agent_id, t.agent_name, l.qq, sum(t.money) as stat FROM `pre_trade_list` as t LEFT JOIN `pre_agent_list` as l on t.agent_id = l.agent_id group by t.agent_id ORDER BY stat DESC limit 100;

#### 连接多个字段
	SELECT CONCAT(first_name,' ',last_name) AS full_name FROM `tblname`;

#### 重复的渠道+广告位组合
	SELECT CONCAT( relation_id, '_', adzone_id ) AS idx, COUNT(*) AS q FROM `pre_member_relation` WHERE relation_id > 0 GROUP BY idx HAVING q > 1;

#### 移除小数后面的零
	SELECT (TRIM(attr_price) + 0 ) AS attr_price;

#### 指定使用索引
	SELECT id FROM data USE INDEX(type) WHERE type = 12345 AND level > 3 ORDER BY id;
	
	SELECT * FROM `pre_order_list` USE INDEX(PRIMARY, create_date,settle_date,member_id,tk_status) WHERE `create_date` BETWEEN 20200301 AND 20200331  ORDER BY order_id DESC LIMIT 0,20;
	
	SELECT SUM(money) AS money, COUNT(*) AS amount FROM `pre_order_deduct` USE INDEX(member_id,create_date) WHERE `member_id` = 355052 AND `create_date` BETWEEN 20200301 AND 20200331 AND `freeze` = 0;

#### 使用全文索引
	SELECT * FROM articles WHERE MATCH(content_column) AGAINST ('music');

#### 严格比较两个 NULL 值是否相等
	SELECT * FROM `tbl_a` A LEFT JOIN `tbl_b` B ON A.ID = B.ID WHERE A.column <=> B.column;
	
	SELECT * FROM `tbl_a` A LEFT JOIN `tbl_b` B ON A.ID = B.ID WHERE NOT( A.column <=> B.column );

#### 中文字符排序
	SELECT * FROM `tblname` ORDER BY CONVERT(vender_abbrev USING gbk) ASC;

#### WHERE IN 同时保持排序（IN 适合于外表数据量大而内表数据小的情况）
	SELECT * FROM `tblname` WHERE id IN(5,2,6,8,12,1) ORDER BY FIELD(id,5,2,6,8,12,1);

#### WHERE EXISTS（EXISTS 适合于外表小而内表大的情况）
	SELECT num FROM `tblname` AS t WHERE EXISTS( SELECT 1 FROM `tblmisc` WHERE num = t.num );

#### 查找以逗号分隔的值，IN 效率更好
	SELECT * FROM `pre_pinduoduo_goods` WHERE FIND_IN_SET(10700, opt_ids);
	
	SELECT COUNT(*) FROM `pre_member_client` WHERE FIND_IN_SET(`app_id`, '20860,20859,20858,20857,20856');

#### 查找某字段不以某符号结尾的记录
	SELECT * FROM `pre_article_list` WHERE id NOT IN ( SELECT id FROM `pre_article_list` WHERE article_content LIKE '%>' );

#### 查找没有店铺信息的店铺ID 
	SELECT seller_id FROM `pre_goods_list` WHERE seller_id NOT IN ( SELECT seller_id FROM `pre_goods_shop` ) AND status = 1 AND seller_id > 0 ORDER BY id DESC LIMIT 100;

#### 使用正则匹配
	SELECT * FROM `pre_wechat_account` WHERE 'www.example.com' REGEXP domain;

#### 按时段统计订单数量和金额
	SELECT COUNT(*), SUM(pub_share_pre_fee), FROM_UNIXTIME( UNIX_TIMESTAMP( create_time ), '%H' ) AS hour FROM pre_order_shadow WHERE create_date >= 20191010 GROUP BY hour;
	
#### 实现资金余额
	SELECT money, (SELECT SUM(money) FROM `pre_account_detail` WHERE id <= d.id and `member_id` = 10008) AS balance FROM `pre_account_detail` AS d WHERE `member_id` = 10008;

#### 两时间比较
	SELECT TIMESTAMPDIFF(DAY, '2018-03-20 23:59:00', '2015-03-22 00:00:00');
	
	SELECT DATEDIFF('2018-03-22 09:00:00', '2018-03-20 07:00:00');

#### 使用 LEAST 函数找到多个字段的最小值
	SELECT LEAST( ord.commission, ord.pub_share_pre_fee );

#### 使用 GREATEST 函数找到多个字段的最大值
	SELECT GREATEST( ord.commission, ord.pub_share_pre_fee );

#### 当前时间戳
	SELECT UNIX_TIMESTAMP();
	
#### 某月总天数
	SELECT DAY(LAST_DAY(CONCAT(months,'-01')));
	SELECT DAY(LAST_DAY(DATE_FORMAT( create_time, '%Y%m01')));
	
#### 获取字符串的 ASCII 值
	SELECT LENGTH(exp), ORD(CONVERT(exp USING ucs2));
	
#### 获取字符串的 UNICODE 值
	SELECT LENGTH(exp), HEX(CONVERT(exp USING ucs2));

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
	
	SELECT DATE_FORMAT( CURRENT_DATE - INTERVAL 15 DAY, '%Y%m%d' );
	# 15天前的格式化时间

----------

## 标志位运算（1,2,4,8,16,32）

### 查询语句
	SELECT * FROM `pre_member_relation` WHERE locked & 2;

### 增加标志
	UPDATE `pre_member_relation` SET locked = locked | 4 WHERE locked & 4 = 0;

### 移除标志
	UPDATE `pre_member_relation` SET locked = locked ^ 8 WHERE locked & 8;

----------

## JOIN 优化

### LEFT JOIN

> MySQL LEFT JOIN 会读取左边数据表的全部数据，即便右边表无对应数据

![](notes/image/mysql_left_join.gif)


### RIGHT JOIN

> MySQL RIGHT JOIN 会读取右边数据表的全部数据，即便左边边表无对应数据

![](notes/image/mysql_right_join.gif)

### INNER JOIN

> MySQL INNER JOIN 获取两个表中字段匹配关系的记录

![](notes/image/mysql_inner_join.gif)

### FULL JOIN

> MySQL FULL JOIN 当左表或右表中有匹配项时，返回所有记录

![](notes/image/mysql_full_join.gif)

----------

## 插入数据

### 插入数据
	INSERT INTO `tblname` VALUES ('a','b');

### 插入多条记录
	INSERT INTO `tblname` (`order_sn`) VALUES ('190730035448751133473'), ('190730386700411711658');

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

### 更新订单表商品主图
	UPDATE `pre_order_list` SET goods_thumb = ( SELECT goods_thumb FROM `pre_goods_list` WHERE goods_id = `pre_order_list`.num_iid ) WHERE goods_thumb IS NULL;

### 更新订单表来源字段
	UPDATE `pre_order_list` SET source = ( SELECT IF ( EXISTS( SELECT 1 FROM `pre_goods_list` WHERE goods_id = `pre_order_list`.num_iid ), 1, 2) ) WHERE source = 0;
	
### 更新和查询同一张表
	UPDATE `pre_member_relation` r INNER JOIN (SELECT `jingdong_uid`, `member_id`, `source_id` FROM `pre_member_relation`) b ON r.`source_id` = b.`member_id` SET r.`jingdong_uid` = b.jingdong_uid WHERE r.`jingdong_uid` IS NULL;

### 同时 JOIN 更新多个字段
	UPDATE `pre_member_upgrade` AS upg JOIN `pre_member_relation` AS rel ON rel.`member_id` = upg.member_id SET upg.source_id = rel.source_id, upg.source_name = rel.source_name WHERE upg.source_id IS NULL;

### 保留用户最新一条记录，其他删除
	DELETE FROM `tblname` WHERE id NOT IN( SELECT ids FROM ( SELECT max(id) AS ids FROM `tblname` GROUP BY openid ) AS tmp );

### 上架已通过审核的商品
	UPDATE `pre_goods_list` SET status = 1 WHERE gid IN ( SELECT gid FROM `pre_member_goods` WHERE status = 1 );

### 补全 URL 协议
	UPDATE `pre_member_list` SET avatar = CONCAT( 'https:', avatar ) WHERE SUBSTRING( avatar, 1, 2 ) = '//';

### 更新 Ymd 日期
	UPDATE `pre_member_upgrade` SET `datetime` = FROM_UNIXTIME(`dateline`, '%Y%m%d');
	
	UPDATE `pre_order_deduct` SET settle_date = DATE_FORMAT( settle_time, '%Y%m%d') WHERE `settle_time` IS NOT NULL AND `settle_date` = 0;
	
### 借助临时字段交换两列的值
	UPDATE `pre_widget_data` SET tmp = extend, extend = link, link = tmp, tmp = NULL WHERE extend LIKE '%:%';

----------

## 批量更新

### REPLACE INTO
	REPLACE INTO tbl(id, dr) VALUES (1,’2′),(2,’3′),(n,’y’);
	
### INSERT INTO
	INSERT INTO tbl (id, dr) VALUES (1,’2′),(2,’3′),…(x,’y’) ON DUPLICATE KEY UPDATE dr = VALUES(dr);

### WHEN x THEN y
	UPDATE tbl SET status = CASE id 
	WHEN 1 THEN 3
	WHEN 2 THEN 4
	WHEN 3 THEN 5
	END WHERE id IN (1,2,3);

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

### 复制表结构和数据（不带索引）
	CREATE TABLE `tblname` [AS] SELECT * FROM `users`;

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
	ALTER TABLE `tblname` MODIFY `url` VARCHAR(700) BINARY NOT NULL;

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

## 字段大小写

Collate 校对规则

```
*_bin: binary case sensitive collation，区分大小写
*_cs: case sensitive collation，区分大小写
*_ci: case insensitive collation，不区分大小写
```

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

## 存储过程

### 定义方法
	DELIMITER ;;
	DROP PROCEDURE IF EXISTS `func_tasks_save`;;
	CREATE PROCEDURE `func_tasks_save`(IN `task` varchar(64), IN `data` text, IN `stamp` INT(11))
	BEGIN
		
		-- 写入任务日志
		INSERT INTO `pre_system_tasks`(`task`,`data`,`duration`,`started_time`,`created_time`,`created_date`) VALUES( task, data, UNIX_TIMESTAMP() - stamp, stamp, UNIX_TIMESTAMP(), DATE_FORMAT(NOW(),'%Y%m%d') );

	END;;

	DELIMITER ;
	
### 调用方法
	CALL func_tasks_save( 'todo_minute_task', '', UNIX_TIMESTAMP() );
	
### 定时任务
	DELIMITER ;;
	CREATE EVENT `todo_fivemin_task`
	ON SCHEDULE EVERY '5' MINUTE STARTS '2016-05-18 00:00:05' ON COMPLETION PRESERVE
	ENABLE COMMENT '' DO
	BEGIN

		-- 任务开始时间
		SET @start_time = UNIX_TIMESTAMP();

		--

		-- 更新备案渠道使用数
		UPDATE `pre_taobao_beian` SET binding_num = ( SELECT COUNT(*) FROM `pre_member_relation` WHERE relation_id = `pre_taobao_beian`.relation_id );
		SELECT ROW_COUNT() INTO @row_count;

		-- 写入任务日志
		CALL func_tasks_save( 'todo_fivemin_task', @row_count, @start_time );

	END;;
	DELIMITER ;

----------

## 视图操作

### 创建视图
	CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `pre_tasks_order_extend` AS SELECT o.*, tk.taoke_name FROM `pre_tasks_order` AS o LEFT JOIN `pre_taoke_list` AS tk ON o.taoke_id = tk.taoke_id;

### 跨库建视图
	CREATE VIEW `pre_agent_config` AS select * FROM `tps`.`pre_agent_config`;

### 删除视图
	DROP VIEW `pre_tasks_order_extend`;

----------

## 操作用户

### 指定主机
	GRANT ALL PRIVILEGES ON *.* TO qcloud@localhost IDENTIFIED BY 'password' WITH GRANT OPTION;

### 任何主机
	GRANT ALL PRIVILEGES ON *.* TO qcloud@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;

### 修改用户密码
	ALTER USER test_user IDENTIFIED BY 'password';

### 修改当前登录用户
	ALTER USER USER() IDENTIFIED BY 'password';

### 使密码过期
	ALTER USER test_user IDENTIFIED BY 'password' PASSWORD EXPIRE;

### 使密码从不过期
	ALTER USER test_user IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER;

### 按默认设置过期时间
	ALTER USER test_user IDENTIFIED BY 'password' PASSWORD EXPIRE DEFAULT;

### 指定密码过期间隔
	ALTER USER test_user IDENTIFIED BY 'password' PASSWORD EXPIRE INTERVAL 90 DAY;

----------

## 事件调度器

### 全局开启
	SET GLOBAL event_scheduler=1;

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

### 执行一次
	ALTER EVENT `test_event` ON COMPLETION NOT PRESERVE;

### 持久执行
	ALTER EVENT `test_event` ON COMPLETION PRESERVE;

### 删除事件
	DROP EVENT IF EXISTS `test_event`;

----------

## 性能优化

### mysql 数据按条件导出

	# 仅导出部分数据
	mysqldump -hlocalhost -uuser -p --skip-triggers --no-create-info dbname tbname -w "id < 1000"  > /path/to/filename.sql

	# 仅导出结构
	mysqldump -uuser -ppass dbname -d --skip-add-drop-table --skip-comments --add-drop-database > /path/to/dbname.sql
	mysqldump -uuser -ppass dbname -d --skip-add-drop-table --skip-comments > /path/to/dbname.sql
	
	# 参数说明
	-d 只生成创建表结构的语句
	-t 只生成插入数据的语句

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

### 在 JOIN 表的时候使用相当类型的例，并将其索引

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

### 可省略 ORDER BY id ASC
	
	# 加上 id ASC 可能触发索引
	SELECT * FROM `pre_member_goods` WHERE `status` = 0 ORDER BY id ASC;
	
	# Mysql 默认使用 PRIMARY ASC 排序（升序），所以可以省略
	SELECT * FROM `pre_member_goods` WHERE `status` = 0;
	
### 将影响索引的 GROUP BY 稍后执行
	
	# Bad
	SELECT `item_id` FROM `pre_order_list` WHERE platform = 'kaola' AND `created_date` >= 20210510 AND `item_pic` = '' GROUP BY item_id LIMIT 100;
	
	# Good
	SELECT * FROM ( SELECT `item_id` FROM `pre_order_list` WHERE platform = 'kaola' AND `created_date` >= 20210510 AND `item_pic` = '' ) AS tmp GROUP BY item_id LIMIT 100;
	
### 使用准确的 WHERE 条件
	
	# Bad
	SELECT * FROM `pre_order_list` WHERE `order_code` != 13;
	
	# Good
	SELECT * FROM `pre_order_list` WHERE `order_code` IN( 3, 12, 14 );
	
### 使用准确的字段类型
	
	# Bad
	SELECT * FROM `pre_order_list` WHERE `trade_id` = 62465555;
	
	# Good
	SELECT * FROM `pre_order_list` WHERE `trade_id` = '62465555';
	
### 多个字段参与排序，确保结果恒等于
	
	# Bad
	SELECT item_id, count(*) AS stats FROM `pre_order_list` GROUP BY item_id ORDER BY stats DESC;
	
	# Good
	SELECT item_id, count(*) AS stats FROM `pre_order_list` GROUP BY item_id ORDER BY stats DESC, create_time DESC;
	
### 优先对 JOIN 的表进行条件过滤

	# Bad
	SELECT COUNT(ord.order_id) FROM `pre_order_list` AS ord LEFT JOIN `pre_taobao_token` AS tkl ON ord.member_id = tkl.member_id AND ord.item_id = tkl.goods_id WHERE ord.`platform` = 'taobao' AND ord.created_date = 20210513 AND tkl.created_date = 20210513;

	# Good
	SELECT COUNT(ord.order_id) FROM `pre_order_list` AS ord LEFT JOIN `pre_taobao_token` AS tkl ON tkl.created_date = 20210513 AND ord.member_id = tkl.member_id AND ord.item_id = tkl.goods_id WHERE ord.`platform` = 'taobao' AND ord.created_date = 20210513;

### 把IP地址存成 UNSIGNED INT

	使用 INET_ATON() 来把一个字符串IP转成一个整形，并使用 INET_NTOA() 把一个整形转成一个字符串IP
	
	而在PHP中，使用函数 ip2long() 和 long2ip()

### 拆分大的 DELETE 或 INSERT 语句

	DELETE FROM logs WHERE log_date <= '2009-11-01' LIMIT 1000;

### 按季度拆分大数据表，参考 backup_order
	7月备份 1~3 月，10月备份 4~6 月，1月备份 7~9 月，4月备份 10~12 月

## 配置说明

#### 配置文件
	/etc/my.cnf

#### [client]

	# 客户端默认端口和密码
	port = 3306
	password=root

	# 更改 sock 位置
	socket=/disk/mysql/mysql.sock
	
	# 同时更新 /etc/php.ini	
	mysql.default_socket = /disk/mysql/mysql.sock
	mysqli.default_socket = /disk/mysql/mysql.sock
	pdo_mysql.default_socket = /disk/mysql/mysql.sock
	
#### [mysqld]
	
	# 更改 Data 目录
	datadir=/disk/mysql
	
	# 更改 Sock 文件
	socket=/disk/mysql/mysql.sock

	# 等待超时（设置后会影响密集查询）
	wait_timeout = 10

	# 启用事件调度器
	event_scheduler = ON

	# 修复表进程
	myisam_repair_threads = 8

	# 最大连接数
	max_connections = 10240

	# 最大错误连接数（超过此值会导致拒绝连接请求）
	max_connect_errors = 1024

	# 连接的非NULL值的字符串长度
	group_concat_max_len = 102400

	# 慢查询时间限定
	long_query_time = 1

	# 开启慢查询日志
	slow_query_log = 1

	# 慢查询日志文件
	slow_query_log_file = /var/log/mysql.slow.log

	# 开启普通日志
	general_log = ON

	# 普通日志文件
	general_log_file = /var/log/mysql.general.log
	
	# 绑定 IP 地址
	bind-address	= 127.0.0.1

	# 禁止DNS反向解析（只使用IP连接，可以提升远程连接速度）
	skip-name-resolve = 1

	# 跳过权限验证表（常用于修改 root 密码）
	skip-grant-tables = 1
	
	# 默认存储引擎
	default-storage-engine = InnoDB

	# 独立表空间
	innodb_file_per_table = 1

	# 缓冲池字节大小（内存的 70%-80%）
	innodb_buffer_pool_size = 6G

	# 日志组每个日志文件的字节大小
	innodb_log_file_size = 256M

	# 写入日志文件时的缓冲区大小
	innodb_log_buffer_size = 8M

	# 等待事务锁超时时间
	innodb_lock_wait_timeout = 60
	
	# sql_mode 配置
	sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
	
#### 常用 sql_mode

	# ONLY_FULL_GROUP_BY
	对于GROUP BY聚合操作，如果在SELECT中的列，没有在GROUP BY中出现，那么这个SQL是不合法的，因为列不在GROUP BY从句中

	# NO_AUTO_VALUE_ON_ZERO
	该值影响自增长列的插入。默认设置下，插入0或NULL代表生成下一个自增长值。如果用户 希望插入的值为0，而该列又是自增长的，那么这个选项就有用了。

	# STRICT_TRANS_TABLES
	在该模式下，如果一个值不能插入到一个事务表中，则中断当前的操作，对非事务表不做限制

	# NO_ZERO_IN_DATE
	在严格模式下，不允许日期和月份为零

	# NO_ZERO_DATE
	设置该值，mysql数据库不允许插入零日期，插入零日期会抛出错误而不是警告。

	# ERROR_FOR_DIVISION_BY_ZERO
	在INSERT或UPDATE过程中，如果数据被零除，则产生错误而非警告。如 果未给出该模式，那么数据被零除时MySQL返回NULL

	# NO_AUTO_CREATE_USER
	禁止GRANT创建密码为空的用户

	# NO_ENGINE_SUBSTITUTION
	如果需要的存储引擎被禁用或未编译，那么抛出错误。不设置此值时，用默认的存储引擎替代，并抛出一个异常

	# PIPES_AS_CONCAT
	将”||”视为字符串的连接操作符而非或运算符，这和Oracle数据库是一样的，也和字符串的拼接函数Concat相类似
	
	# ANSI_QUOTES： 
	启用ANSI_QUOTES后，不能用双引号来引用字符串，因为它被解释为识别符
	

## 常见错误

#### 使用 source 导入数据报错 ERROR:Unknown command '\U'. ERROR:Unknown command '\A'. ERROR:Unknown command '\D'.

	# 指定默认编码
	mysql -uroot -p --default-character-set=utf8
	
	# 指定编码和库
	mysql -uroot -p --default-character-set=utf8 dbname < test_service.sql

#### MYSQL REPLACE INTO 和 INSERT INTO 的区别
	1. 表必须有主键或者是唯一索引,否则没有什么不同；
	2. 如果有主键或者是唯一索引，则REPLACE发现重复的先删除再插入，如果记录有多个字段，在插入的时候如果有的字段没有赋值，那么新插入的记录这些字段为空，且返回的值为删除的条数和插入的条数之和；而insert 发现重复的则报错。

#### Table 'performance_schema.session_status' doesn't exist
	mysql_upgrade -u root -p --force

#### SQLSTATE[HY000] [1129] is blocked because of many connection errors
	mysqladmin -uroot -p flush-hosts
	
#### SQLSTATE[42000]: Syntax error or access violation: 1055 Expression #5 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'xxx' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	
	
	# Mysql 5.6 以前
	SELECT count(*) as `stats`,`action` as `name`,`module` FROM `pre_order_list` GROUP BY `module` ORDER BY `stats` DESC
	
	# Mysql 5.7 以后，需要将更多的参数参与 GROUP BY 分类
	SELECT count(*) as `stats`,`action` as `name`,`module` FROM `pre_order_list` GROUP BY `action`, `module` ORDER BY `stats` DESC

#### Plugin '*81F5E21E35407D884A6CD4A731AEBFB6AF209E1B' is not loaded

	# 配置并重启 MySQL
	skip-grant-tables = 1
	
	# 使用 root 登录后执行
	USE mysql;
	UPDATE user SET authentication_string = password('root'), password_expired = 'N' WHERE user = 'root';
	UPDATE user SET plugin = "mysql_native_password";
	DELETE FROM user WHERE user = '';
	FLUSH PRIVILEGES;
	QUIT;
	
	# 移除配置后重启 MySQL
	#skip-grant-tables = 1

#### ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.
	SET authentication_string = password('my_password') WHERE user = 'root';	

#### ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
	SET password = password('!XXXXX);

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
	
#### 生成删除所有表语句间接现实清空数据库表
	SELECT CONCAT('DROP TABLE IF EXISTS `', table_name, '`;') FROM information_schema.tables WHERE table_schema = 'dbname';

### 相关链接

- [面试问烂的 MySQL 四种隔离级别](https://mp.weixin.qq.com/s/gkfzOtYWWhMgMgcRB32BoA)
- [mysql explain 用法和结果的含义](https://www.cnblogs.com/qiudongxu/p/10312777.html)
- [重现并分析在MySQL中使用replace into 的坑](https://blog.csdn.net/yangchunlu0101/article/details/80255537)
- [实战mysql存储程序与定时器](http://lobert.iteye.com/blog/1953827)
- [mysql中的事件](http://www.jianshu.com/p/8faa7dadd073)
- [项目中常用的19条MySQL优化](https://segmentfault.com/a/1190000012155267)
- [Creating Event that execute at end of each month](http://dba.stackexchange.com/questions/80049/creating-event-that-execute-at-end-of-each-month)
- [ON SCHEDULE EVERY 1 MONTH](http://www.java2s.com/Code/SQL/Event/ONSCHEDULEEVERY1MONTH.htm)
- [MySql常用30种SQL查询语句优化方法](https://segmentfault.com/a/1190000013935099)
- [MySQL 性能优化神器 Explain 使用分析](https://segmentfault.com/a/1190000008131735)
- [腾讯云 CDB for MySQL 使用规范指南](https://cloud.tencent.com/document/product/236/13390)
- [DCDB开发指南](https://cloud.tencent.com/document/product/557/7714)
- [mysql5.7系列修改root默认密码](https://www.cnblogs.com/activiti/p/7810166.html)
- [MySQL 5.7 忘记root密码，使用--skip-grant-tables重置root密码的通用方法](https://majing.io/posts/10000005451184)
- [解决mysql source 命令导入数据库 乱码](https://blog.csdn.net/xuz0917/article/details/51746207)
- [数据库状态标识位flag设计](https://www.cnblogs.com/gouyg/p/mysql-flag-php.html)
- [MySQL索引的类型](https://www.cnblogs.com/Aiapple/p/5693239.html)
- [MySQL索引失效的几种情况](https://www.cnblogs.com/binyue/p/4058931.html)
- [MySQL表的碎片整理和空间回收小结](https://www.cnblogs.com/kerrycode/p/10943122.html)
- [MySQL大表优化方案](https://mp.weixin.qq.com/s/fRfAEYqWsNhaJ6ZN8Y6Iew)
- [炸裂！82张图进阶MySQL的高级玩法！](https://mp.weixin.qq.com/s/_jiTYpyqtasCZ25lVJ7waA)
- [浅谈分库分表那些事儿](https://mp.weixin.qq.com/s/X6FI9Ci7ZXGDNDCkh2VnNA)
- [SQL 性能起飞了！](https://mp.weixin.qq.com/s/YbZfp8UXODZ4V55dvRxJRw)
- [求教SQL流水账余额的方法](https://bbs.csdn.net/topics/391070561)
