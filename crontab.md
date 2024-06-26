
# Crontab

## 常用命令

	# 编辑任务
	crontab -e
	
	# 查看任务
	crontab -l
	
	# 重启任务
	service crond restart
	
	# 中文编码兼容
	export LANG=en_US.UTF-8

## 规则格式

![](notes/image/crontab.png)

## 使用例子
	
	# 每天 23 点重启机器
	00 23 * * * reboot

	# 每天 23:10 开始采集
	10 23 * * * service jd start

	# 每天上午 10 点结束采集
	00 10 * * * service jd stop

	# 每天 10 点 10 分重启机器
	00 10 * * * reboot
	
	# 每隔1分钟运行一次脚本
	*/1 * * * * /path_to_script
	
	# 每天9:00 - 22:00，每5分钟执行一次
	*/5 9-22 * * * /path_to_script

	# 每隔1小时(1:00,2:00,3:00)运行一次脚本
	0 */1 * * * /path_to_script

	# 每隔1小时(1:20,2:20,3:20)运行一次脚本
	20 */1 * * * /path_to_script

	# 运行脚本时，丢掉返回的信息
	20 */1 * * * /path_to_script > /dev/null 2>&1

## 实际示例

	# 项目自动更新（每天9:00 - 22:00，每10分钟执行一次）
	*/5 9-22 * * * /disk/shell/gitpull.sh > /var/log/gitpull.log
	
	# 自动优化自检（每天执行一次）
	03 03 * * * /disk/shell/auto-test.sh > /var/log/auto-test.log 2>&1
	
	# Cron 任务调度，每分钟执行
	* * * * * php /disk/www/worker.com/index.php /cron/cron/run

	# 每天8:00 - 22:00，每 15 分钟一次
	*/15 8-22 * * * curl http://example.com/cron/mins > /dev/null 2>&1

	# 每天 23:30 执行一次
	30 23 * * * curl http://example.com/cron/days > /dev/null 2>&1

	# 分佣订单数据汇总（每天 1:00 和 12:00 各执行一次）
	0 1,12 * * * curl http://api.example.com/commission/cron > /dev/null 2>&1

	# 以上相同功能，使用 PHP 执行
	0 1,12 * * * php /disk/www/example.com/index.php /api/commission/cron > /dev/null 2>&1
	
	# 淘客易一手券商品抓取，间隔 10 分钟
	*/10 0,8-23 * * * php /disk/www/example.com/index.php /cron/dataoke/night/dis

	# 云端商品采集（每天8至23点，间隔20分钟）
	*/10 8-23 * * * /disk/www/www.example.com/cron/cloud.sh > /dev/null 2>&1
	
	# 大淘客商品采集（大淘客比较慢，所以半小时采一次）
	*/25 8-23 * * * /disk/www/www.example.com/cron/dataoke.sh > /dev/null 2>&1
	
	# 商品优惠券统计（每天 9:00 - 23:50，每15分钟执行一次）
	*/15 9-23 * * * curl http://api.example.com/cron/hour > /dev/null 2>&1
	
	# 商品每日自动结算（每天 23:50 执行一次）
	50 23 * * * curl http://api.example.com/cron/days > /dev/null 2>&1
	
	# 日志文件自动压缩（每周执行一次）
	7 7 * * 7 /disk/shell/ziplogs.sh > /var/log/ziplogs.log 2>&1
	
	# 项目自动更新（每天9:00 - 22:00，每10分钟执行一次）
	*/10 9-22 * * * /disk/shell/gitpull.sh > /var/log/gitpull.log
	
	# 自动封锁将连接数超过150的IP（每 5 分钟执行一次）
	*/5 * * * * /disk/shell/blockip.sh > /dev/null 2>&1
	
	# 每天 4:00 重启机器
	0 04 * * * /usr/sbin/reboot

## 相关链接

- [crontab 命令说明](http://man.linuxde.net/crontab)
- [Crontab 表达式生成器](https://crontab.guru/)
- [Crontab 表达式执行时间验证](http://www.atool.org/crontab.php)
- [Linux shell中2>&1的含义解释](https://blog.csdn.net/zhaominpro/article/details/82630528)

	
