# 正则表达式

## PHP
	
### 银行卡号格式化显示
	<code><?php echo preg_replace('/(\d{4})(?=\d)/','$1</code><code>', $bankcard);?></code>
	
### Ymd 格式日期填充 -
	<?php echo preg_replace('/(\d{4})(\d{2})(\d{2})/', '$1-$2-$3', $start_date);?>
	
### 使用 \n 或 || 分解字符串
	preg_split('/(\n|,|(\|\|))/', $text );
	
### 过滤 ../ 等路径字符
	preg_replace('/[\\\\\/]/ism', '', $file);
	
### 移除图片 URL 上尺寸尾巴
	preg_replace( '/_(\d+?)x(\d+?)\.jpg/', '', $string );

## JavaScript

### 不包含某些字符串
	/^((?!wxid_).)*$/

### 匹配正则表达式
	/\/(.*)\/(.+)?/

### 匹配所有不可见字符
	/[\s+\p{C}\s+]/
	/[\s+\p{C}]{3,}/

### 匹配头尾不可见字符
	/^([\s\p{C}]+)|([\s\p{C}]+)$/
	
### 匹配淘口令字符
	/(\S)([a-zA-Z0-9]{11})\1/

### 匹配以中文开头的字符

	/^[^a-z\*\>\#]/
	
### 匹配 {} 包围的字符
	\{(.+)\}

## 常用链接

- 在线正则测试：[https://regexr.com/](https://regexr.com/)
- 正则学习和测试：[http://notes.veryide.com/r.js/regex.html](http://notes.veryide.com/r.js/regex.html)