# 正则表达式

## 匹配以中文开头的字符

	^[^a-z\*\>\#]

## 银行卡号格式化显示

	<code><?php echo preg_replace('/(\d{4})(?=\d)/','$1</code><code>', $cardid);?></code>
	
## 匹配 {} 包围的字符
	\{(.+)\}

## 常用链接

- 在线正则测试：[https://regexr.com/](https://regexr.com/)
- 正则学习和测试：[http://notes.veryide.com/r.js/regex.html](http://notes.veryide.com/r.js/regex.html)