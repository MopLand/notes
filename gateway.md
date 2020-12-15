# Gateway

## Gateway

	是 Dora 框架中专门处理接口验证的模块

## 基本用法

### Controller

	@name   页面名称
	@author 文档作者署名
	@weight 排序权重，从小到大，范围 1~255
	@source 代码来源，指定代码解析目标文件
	@navbar 导航状态，默认可见 visible || 隐藏 hidden
	@manual 文档状态，默认可见 visible || 隐藏 hidden
	@access 访问限制，默认允许 allowed || 关闭 closed
	@module 组件标识，用于组件状态控制页面
	@switch 特性开关，用于细粒度的权限控制，格式："@switch key desc"	
	@verify 需校验的请求信息，可选 appid, token, client, format
	@require 检查客户端版本，例如 JellyBox/1.2

### Action

	@label  导航名称
	@badge  导航标记
	@cross  跨域访问，true || false
	@cache  缓存响应数据，0 || second
	@sense  是否缓存开关，key 来自 return 数据，支持路径表达式（ab.cd.ef）
	@expire 页面过期时间，0 || second
	@locked 执行加锁时间，0 || second
	@replay 请求重放，默认允许 true || 禁止重放 false
	@action 入口地址，通常与 Action 同名
	@crumbs 关联地址，导航条 Action 名称
	@cloned 复制配置，从其他 Action 引用并合并配置
	@tester 测试方法，默认不是 false || 启用 true
	@manual 文档状态，默认可见 visible || 隐藏 hidden
	@navbar 导航状态，默认显示 visible || 隐藏 hidden
	@signed 签名验证, 默认严格 strict || 松散 loosed
	@access 访问限制，默认允许 allowed || 验证 limited || 关闭 closed
	@param  定义参数，type name summary {options}
	@field 响应参数，type name value summary
	@patch 变更记录，date author summary
	@notice 描述说明
	@linkup 相关链接
	@markup 样式标识
	@remark 备注说明
	@example 响应示例
	{
	"status":0,
	"result":[]
	}
	
## 用法示例
	
### 适用用于角色权限和导航菜单

	/**
	 * 文件描述
	 * @name   页面名称
	 * @author 文档作者署名
	 * @weight 排序权重，从小到大，范围 1~255
	 * @source 代码来源，指定代码解析目标文件
	 * @navbar 导航状态，默认可见 visible || 隐藏 hidden
	 * @manual 文档状态，默认可见 visible || 隐藏 hidden
	 * @access 访问限制，默认允许 allowed || 关闭 closed
	 * @module 组件标识，用于组件状态控制页面
	 * @switch 特性开关，用于细粒度的权限控制，格式："@switch key desc"
	 */
	class Admin extends Common {

		function init(){
			parent::init();
		}

		/**
		 * 导航菜单
		 * @label  导航名称
		 * @badge  导航标记
		 * @action 入口地址，通常与 Action 同名
		 * @crumbs 关联地址，导航条 Action 名称
		 * @cloned 复制配置，从其他 Action 引用并合并配置
		 * @tester 测试方法，默认不是 false || 启用 true
		 * @manual 文档状态，默认可见 visible || 隐藏 hidden
		 * @navbar 导航状态，默认显示 visible || 隐藏 hidden
		 * @access 访问限制，默认允许 allowed || 验证 limited || 关闭 closed
		 * @markup 样式标识
		 * @remark 备注说明
		 */
		public function indexAction() {
		
		}

		/**
		 * API 接口
		 * @label  导航名称
		 * @action 入口地址，通常与 Action 同名
		 * @method  请求方式，GET / POST / GET&POST
		 * @access 访问限制，默认允许 allowed || 验证 limited || 关闭 closed
		 * @param  定义参数，type name summary {required=1}
		 * @linkup 相关链接
		 * @example 代码示例，必需是最后一个属性
		 */
		public function requestAction() {
		
		}
		
		/**
		 * @label 已处理
		 * @action success
		 * @access limited
		 */

		/**
		 * @label 已取消
		 * @action cancel
		 * @access limited
		 */
		public function defaultAction($act = null) {
		
		}
		
		/**
		 * @label 方法示例
		 * @action apply
		 * @navbar hidden
		 * @remark 财务必需
		 * @access limited
		 */
		public function applyAction( $id = NULL ) {
		
		}
		
		/**
		 * @label 删除订单
		 * @action delete
		 * @navbar hidden
		 * @markup text-danger
		 * @access closed
		 */
		public function deleteAction( $id = NULL ) {
		
		}
		
		/**
		 * @label 订单拉取
		 * @badge API
		 * @action orders
		 * @tester true
		 * @access limited
		 */
		public function ordersAction( ) {
		
		}

	}

### 适用于 API 接口校验和数据处理

	/**
	 * 文件描述
	 * @name   页面名称
	 * @cross  跨域访问，true || false
	 * @cache  缓存响应数据，0 || second
	 * @expire 页面过期时间，0 || second
	 * @access 访问限制，默认允许 allowed || 关闭 closed
	 * @verify 需校验的请求信息，可选 appid, token, client, format
	 * @require 检查客户端版本，例如 JellyBox/1.2
	 */
	class Common extends \Library\Controller {
	
		use \App\Admin\Model\Gateway;

		function init(){
			parent::init();

			//开发模式
			$this->debug( Request::get('debug') == md5( date('md') ) );

			//检查参数
			$this->start( $this->_module, $this->_control, $this->_action );

			//回调方法
			$this->callback = $this->ajax;

			//读取缓存
			if( $data = $this->caching( Request::get() ) ){
				$this->respond( $data );
			}
			
		}
		
		/**
		 * @label  产品搜索
		 * @action search
		 * @cross  跨域访问，true || false
		 * @cache  缓存响应数据，0 || second
		 * @sense  是否缓存开关，key 来自 return 数据，支持路径表达式（ab.cd.ef）
		 * @expire 页面过期时间，0 || second
		 * @locked 执行加锁时间，0 || second
		 * @replay 请求重放，默认允许 true || 禁止重放 false
		 * @active 活跃级别，一般服务 normal || 低频服务 low
		 * @access 访问限制，默认允许 allowed || 验证 limited || 关闭 closed
		 * @signed 签名验证, 默认严格 strict || 松散 loosed
		 * @method GET
		 * @input string type 产品类型
		 * @param integer page 当前页码
		 * @param number money 金额限定
		 * @param mobile phone 手机号码 {required=1}
		 * @param string lists 文件清单 {posted=1}
		 * @param string field 搜索类型 {optional=trade_id,item_id}
		 * @param string start 开始日期 {regexp=/^([\d\-]+)$/}
		 * @param string final 结束日期 {regexp=/^([\d\-]+)$/}
		 * @param json object 数据对象
		 * @param string keyword 关键字 {required=1; filter=\Library\StrExt::removeExtra}
		 * @field int category taobao 商品类型：taobao、jingdong
		 * @field float price 9.99 商品价格
		 * @patch 2020-12-02 Lay 变更说明
		 * @patch 2020-12-25 Lay 节日提示
		 * @notice 描述说明信息
		 * @access limited
		 * @example
		 * {
		 *	"status":0,
		 *	"result":[]
		 * }
		 */
		public function searchAction( $type = NULL ) {
		
			//获取通过验证的参数
			$text = $this->arg('keyword');
		
			//获取参数值或默认值
			$page = $this->arg('page', 1);
		
		}
	
		public function __destruct() {

			//写入缓存
			if( isset( $this->dataset ) ){
				$this->caching( Request::get(), $this->dataset );
			}

			parent::__destruct();
		}

	}

## 高级用法

### 通过判断响应参数是否缓存
	@cache 600
	@sense valued

### 复制其他 Action 参数配置
	@label 拼多多
    @action pinduoduo
    @cloned index

### 定义特殊权限开关
	@switch	modify_role 调整等级
 	@switch	modify_phone 修改手机号