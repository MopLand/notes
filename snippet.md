# Snippet

> 各种代码片段

## PHP

### 三元运算符

	(expr1) ? (expr2) : (expr3)
	在 expr1 求值为 TRUE 时的值为 expr2，否则为 expr3

	(expr1) ?: (expr3)
	简写 ?: 等同于 !empty(expr1) ? expr1 : expr3
	
	(expr1) ?? (expr3)
	简写 ?? 等同于 isset(expr1) ? expr1 : expr3

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
	
### 使用修正短语来获得准确时间
	strtotime('last day of 20181031 + 1 month')

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
	
### 将数组格式成表格显示
	$tbody = array_reduce($res, function($a, $b){return $a.="<tr><td>".implode("</td><td>",$b)."</td></tr>";});

	$thead = "<tr><th>" . implode("</th><th>", array_keys($res[0])) . "</th></tr>";

	echo '<table class="table table-striped">'. $thead . $tbody .'</table>';
	
### 修正 64位系统 JSON_BIGINT_AS_STRING 无效的问题
	/**
	 * 修正 64位系统 JSON_BIGINT_AS_STRING 无效的问题
	 * https://github.com/firebase/php-jwt/blob/master/src/JWT.php
	 * 32bit int_max 2147483647
	 * 64bit int_max 9223372036854775807
	 */
	if (PHP_INT_SIZE == 8) {
		$max = strlen((string) PHP_INT_MAX) - 1;
		$txt = preg_replace('/:\s*(-?\d{' . $max . ',})/', ': "$1"', $txt);
		$ret = json_decode($txt, TRUE);
	} else {
		$ret = json_decode($txt, TRUE, 512, JSON_BIGINT_AS_STRING);
	}
	
## HTML
	
## JavaScript

### 修正 JSON.parse 不支持 int64 的问题

	body.replace(/:([0-9]{15,}),/g, ':"$1",');

### 随机指定长度字符

	Math.random().toString(36).substr(2);
	
### 将大金额格式为：XX万元

	Hybrid.App.format = function( num ){
		return num / 10000 + '万元';
	}
	
### 将整个表单变成只读

	<fieldset disabled="disabled">
		<form>
		...
		</form>
	</fieldset>

## CSS

### 带阴影的浮动条
	width: 100%;
    height: auto;
    background-color: #fff;
    position: fixed;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);

### 文字下方颜色条

	margin: 1.5rem 0;
    font-size: 1.8rem;
    padding-left: 10px;
    padding-right: 10px;
    display: inline-block;
    box-shadow: inset 0 -8px 0 #b0d3ff;
	
### 文字颜色渐变
	background: linear-gradient(to right,#ff8a00,#e52e71);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-box-decoration-break: clone;
	font-weight: 700;



