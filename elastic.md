# ElasticSearch

## 基本知识

	Relational DB -> Databases -> Tables -> Rows -> Columns
	Elasticsearch -> Indices   -> Types  -> Documents -> Fields

> Elasticsearch集群可以包含多个索引(indices)（数据库），每一个索引可以包含多个类型(types)（表），每一个类型包含多个文档(documents)（行），然后每个文档包含多个字段(Fields)（列）

## 数据层

- Index: Elasticsearch 用来存储数据的逻辑区域，它类似于关系型数据库中的 db 概念。一个 index 可以在一个或者多个 shard 上面，同时一个 shard 也可能会有多个 replicas

- Document: Elasticsearch 里面存储的实体数据，类似于关系数据中一个 table 里面的一行数据。document 由多个 field 组成，不同的 document 里面同名的 field 一定具有相同的类型。document 里面 field 可以重复出现，也就是一个 field 会有多个值，即 multivalued

- Document type: 为了查询需要，一个 index 可能会有多种 document，也就是 document type，但需要注意，不同 document 里面同名的 field 一定要是相同类型的

- Mapping: 存储 field 的相关映射信息，不同 document type 会有不同的mapping


## 服务层

- Node: 一个 server 实例

- Cluster: 多个 node 组成 cluster

- Shard: 数据分片，一个 index 可能会存在于多个 shards，不同 shards 可能在不同 nodes

- Replica: shard 的备份，有一个 primary shard，其余的叫做 replica shards

## 使用样例: 

### 1. 先创建名叫 index 的索引

	curl -XPUT http://localhost:9200/index

### 2. 创建名为 fulltext 的类型，并设定其使用 IK 分词器

> 这一步很重要，必须在往索引中添加数据前完成

	curl -XPOST http://localhost:9200/index/fulltext/_mapping -d'
	{
        "properties": {
            "content": {
                "type": "text",
                "analyzer": "ik_max_word",
                "search_analyzer": "ik_max_word"
            }
        }
	}'

### 3. 往索引库中添加数据
	curl -XPOST http://localhost:9200/index/fulltext/1 -d'{"content":"美国留给伊拉克的是个烂摊子吗"}'
	curl -XPOST http://localhost:9200/index/fulltext/2 -d'{"content":"公安部: 各地校车将享最高路权"}'
	curl -XPOST http://localhost:9200/index/fulltext/3 -d'{"content":"中韩渔警冲突调查: 韩警平均每天扣1艘中国渔船"}'
	curl -XPOST http://localhost:9200/index/fulltext/4 -d'{"content":"中国驻洛杉矶领事馆遭亚裔男子枪击 嫌犯已自首"}'

## IK 分词器

1. **ik_max_word** 会将文本做最细粒度的拆分，比如会将“中华人民共和国国歌”拆分为“中华人民共和国,中华人民,中华,华人,人民共和国,人民,人,民,共和国,共和,和,国国,国歌”，会穷尽各种可能的组合；

2. **ik_smart** 会做最粗粒度的拆分，比如会将“中华人民共和国国歌”拆分为“中华人民共和国,国歌”。

## 索引 API

### 创建索引

	PUT http://127.0.0.1:9200/geeduo/

### 创建类型

	POST http://127.0.0.1:9200/geeduo/goods/
	{}

### 创建映射

	POST http://127.0.0.1:9200/geeduo/goods/_mapping
	{
	        "properties": {
	            "goods_id": {
	                "type": "long"
	            },
	            "goods_name": {
	                "type": "text",
	                "analyzer": "ik_max_word",
	                "search_analyzer": "ik_max_word"
	            },
	            "goods_tags": {
	                "type": "text",
	                "analyzer": "ik_max_word",
	                "search_analyzer": "ik_max_word"
	            },
	            "goods_cate": {
	                "type": "text",
	                "analyzer": "ik_max_word",
	                "search_analyzer": "ik_max_word"
	            }
	        }
	    
	}

### 删除索引

	DELETE http://127.0.0.1:9200/geeduo/

### 查看映射

	GET http://127.0.0.1:9200/geeduo/goods/_mapping

## 搜索 API

### 搜索测试

	POST http://127.0.0.1:9200/geeduo/goods/_search
	{
	    "query": {
	        "query_string": {
	            "query": "中华人民共和国"
	        }
	    }
	}

### 搜索高亮

	POST http://127.0.0.1:9200/geeduo/goods/_search
	{
	    "query": {
	        "match": {
	            "goods_name": "我的世界玩具"
	        }
	    },
	    "highlight": {
	    	"pre_tags": "<strong>",
			"post_tags": "</strong>",
	        "fields": {
				"goods_name": {}
			}
	}

### 混合搜索

	POST http://127.0.0.1:9200/geeduo/goods/_search
	{
	    "query": {
	        "match_phrase": {
	            "goods_name": {
	                "query": "玩具我的世界",
	                "slop":  30
	            }
	        }
	    },
	    "highlight": {
	    	"pre_tags": "<strong>",
			"post_tags": "</strong>",
	        "fields": {
				"goods_name": {}
			}
		}
	}

## 分词 API

### 默认分词

	GET http://localhost:9200/index/_analyze?text=中华人民共和国

### IK 分词

	GET http://localhost:9200/index/_analyze?analyzer=ik_max_word&text=中华人民共和国


## 相关链接

1. Elasticsearch教程: http://www.yiibai.com/elasticsearch/

2. 拼音分词: https://github.com/medcl/elasticsearch-analysis-pinyin

3. IK中文分词: https://github.com/medcl/elasticsearch-analysis-ik

4. Elasticsearch 5 Ik+pinyin分词配置详解: http://blog.csdn.net/napoay/article/details/53907921

5. 理解ElasticSearch的中文分词器【IK】（版本: 1.6.0）: http://blog.csdn.net/lougnib/article/details/50442276

6. Chrome插件Sense: http://chrome.google.com/webstore/search/%20Sense?hl=zh-CN

7. 解决 MySQL 与 Elasticsearch 数据不对称问题: https://my.oschina.net/neochen/blog/1518679

