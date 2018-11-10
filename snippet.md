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

### 本月第一天 和 最后一天
	strtotime('first day of this month')
	strtotime('last day of this month')

### 上个月的时间
	strtotime('last month')
	
### 上个月第一天 和 最后一天
	strtotime('first day of last month')
	strtotime('last day of last month')

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
	
### 格式化显示银行卡号
	<code><?php echo preg_replace('/(\d{4})(?=\d)/','$1</code><code>', $bankcard);?></code>
	
### 将数组格式成表格显示
	$tbody = array_reduce($res, function($a, $b){return $a.="<tr><td>".implode("</td><td>",$b)."</td></tr>";});

	$thead = "<tr><th>" . implode("</th><th>", array_keys($res[0])) . "</th></tr>";

	echo '<table class="table table-striped">'. $thead . $tbody .'</table>';
### 使用 \n 或 || 分解字符串
	preg_split('/(\n|,|(\|\|))/', $text );
	
## HTML
	
## JavaScript

### 随机指定长度字符

	Math.random().toString(36).substr(2);
	
### 将大金额格式为：XX万元

	Hybrid.App.format = function( num ){
		return num / 10000 + '万元';
	}

## CSS

### 文字下方颜色条

	margin: 1.5rem 0;
    font-size: 1.8rem;
    padding-left: 10px;
    padding-right: 10px;
    display: inline-block;
    box-shadow: inset 0 -8px 0 #b0d3ff;



