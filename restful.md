# Restful 接口规范

## 约定
	GET（Select）：查询
	POST（Create）：创建
	PUT（Replace）：替换
	PATCH（Update）：更新
	DELETE（Remove）：删除

## SSL
	Restful API一定要使用 HTTPS 传输

## JSON
	目前，JSON 作为唯一的交互格式

## 命名规则
	snake

## 鉴权
	restful API 是无状态的也就是说用户请求的鉴权和 cookie 以及 session 无关，每一次请求都应该包含鉴权证明。
	统一使用 Token 或者 OAuth2.0 认证。

## 状态码
	200 ok  - 成功返回状态，对应，GET,PUT,PATCH,DELETE.
	201 created  - 成功创建。
	304 not modified   - HTTP缓存有效。
	400 bad request   - 请求格式错误。
	401 unauthorized   - 未授权。
	403 forbidden   - 鉴权成功，但是该用户没有权限。
	404 not found - 请求的资源不存在
	405 method not allowed - 该http方法不被允许。
	410 gone - 这个url对应的资源现在不可用。
	415 unsupported media type - 请求类型错误。
	422 unprocessable entity - 校验错误时用。
	429 too many request - 请求过多。

## 示例

### 电影
	GET /movies 
	POST /movies 
	GET /movies/12 
	PUT /movies/12 
	PATCH /movies/12 
	DELETE /movies/12

### 电影评论
	GET /movies/12/comments 
	POST /movies/12/comments 
	GET /movies/12/comments/5
	PUT /moviess/12/comments/5 
	PATCH /movies/12/comments/5 
	DELETE /movies/12/comments/5

### 过滤，查询，排序
	GET https://api.com/movies?state=open&search=funny&sort=-priority,created_at

## 优秀案例
	https://developer.github.com/v3/