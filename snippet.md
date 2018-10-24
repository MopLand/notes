# Snippet

> 各种代码片段

## PHP

### 今天/明天/昨天的时间
	strtotime('today')
	strtotime('tomorrow')
	strtotime('yesterday')

### 30 天前的时间
	strtotime('-30 days')

### 一周后的时间
	strtotime('+1 week')

### 3个月后的时间
	strtotime('+3 month')

### 本月第一天
	strtotime('first day of this month')

### 本月最后一天
	strtotime('last day of this month')

### 上一个月的时间
	strtotime('last month')

### 本周一 和 本周日
	strtotime('last Monday')
	strtotime('Sunday')

### 上周开始时间
	strtotime('Monday last week')

### 上周结束时间
	strtotime('Sunday last week')

### 上周三开始时间
	strtotime('Monday last week +2 day')

### 昨天最后一秒
	strtotime('today -1 second')

### 一前年的时间
	strtotime('last year')