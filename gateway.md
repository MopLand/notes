# Gateway

## Gateway

	Gateway 是 Dora 框架中专门处理接口验证的模块，位于 /app/admin/model

## 基本用法

### Controller

	@name   页面名称
	@cross  跨域访问，true || false
	@author 文档作者署名
	@notice 描述说明
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
	@iprate IP 速度限制，默认打开 on || 关闭限制 off
	@action 入口地址，通常与 Action 同名
	@crumbs 关联地址，导航条 Action 名称
	@cloned 复制配置，从其他 Action 引用并合并配置
	@tester 测试方法，默认不是 false || 启用 true
	@remove 弃用标记，默认不是 false || 弃用 true || 迁移 path（支持 :mod 标记）
	@manual 文档状态，默认可见 visible || 隐藏 hidden
	@navbar 导航状态，默认显示 visible || 隐藏 hidden
	@signed 签名验证, 默认严格 strict || 松散 loosed
	@access 访问限制，默认允许 allowed || 验证 limited || 关闭 closed
	@method 请求方式，GET / POST / GET&POST
	@input 输入参数，type name summary {options}
	@param 请求参数，type name summary {options}
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
		 * @remove jingdong/giftList
		 * @method GET
		 * @input string type 产品类型 {default=home}
		 * @param integer uid 用户ID
		 * @param number money 金额限定
		 * @param pagenum page 当前页码
		 * @param sorting extra 筛选排序 {optional=b.id,a.fans,a.income,b.income_yester,b.income_recent,b.income_month,a.logined_time; per=asc}
		 * @param mobile phone 手机号码 {required=1}
		 * @param string lists 文件清单 {posted=1}
		 * @param string field 搜索类型 {optional=trade_id,item_id; default=trade_id}
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
		
		/**
		 * @label  缓存图片
		 * @action buffer
		 * @remove :gateway/fx/buffer
		 * @method POST
		 * @example
		 * {
		 *	"status":0,
		 *	"result":"http://example.com/example"
		 * }
		 */
		public function bufferAction( $hash = NULL ) {
		
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
	/**
	 * @label 测试方法
	 * @action test
	 * @cache 600
	 * @sense result.path.valued
	 * @return json
	 */
	public function testAction(){
	
	}

### 复制其他 Action 参数配置
	/**
     * @label 淘宝
     * @action index
     * @param string q 关键词 {filter=\Library\StrExt::removeEmoji}
     * @param string s 条件 {optional=d.buyer_id,m.member_name,m.invite_code,l.trade_id,l.item_title,l.item_id}
     * @param integer status 状态
     * @param integer role 角色
     * @param string start 开始日期 {regexp=/^([\d\-]+)$/}
     * @param string final 结束日期 {regexp=/^([\d\-]+)$/}
     * @param string range 日期筛选类型
     * @param string promo 免单活动
	 * @active low
     * @access allowed
     */

	/**
     * @label 拼多多
     * @action pinduoduo
     * @cloned index
     */	 
	public function defaultAction( $act = NULL ) {
	
	}
	 
### 定义特殊权限开关（定义在 class 层）	
	/**
	 * 用户管理
	 * @name	用户
	 * @weight	11
	 * @manual	hidden
	 * @switch	modify_role 调整等级
	 * @switch	modify_phone 修改手机号
	 */

### 使用 @format 格式化响应数据
	/**
     * @label 混合查询（含分页）
     * @action query
     * @param string q				搜索关键词
     * @param integer supid			大分类ID
     * @param integer subid			小分类ID
     * @param integer page			页码，默认 1
     * @param string fmt 格式
     * @format \App\Proxy\Model\Format::tbItem
     * @return json
     */
    function queryAction( ) {
		
		$model = new \App\Proxy\Model\Search();
		$result = $model->dispatch( $_GET, Request::getHttpHeader('QUERY_STRING') );
		
		return $result;

	}

### 调用其他控制器 Action，使用 setArgs() 方法传入参数
	/**
     * @label 首页千万补贴
     * @action millions
	 * @param integer page_no 页码，默认 1
	 * @param integer page_size 每页大小，默认 20
     * @return json
     */
    function millionsAction(){

        $page_no    = $this->arg('page_no', 1 );
		$page_size  = $this->arg('page_size', 20 );

        $mod = new \App\Proxy\Controller\Pddapi;

        $ret = $mod->setArgs( [
            'page'		=> $page_no,
            'limit'		=> $page_size,
            'act_ids'   => 10851,
            'flag'      => 'homepage'
        ])->activityAction();

        return $ret;
    }
	
### 使用 @tester 在 “开发” 中生成快捷方式，使用 @badge 输出标识
	/**
     * @label 推广链接
	 * @badge API
     * @action url
	 * @tester true
     * @access limited
     */
    public function urlAction(){
		
        $url = Request::getPost('url');
        $member_id = Request::getPost('member_id');
        $chainType = Request::getPost('chainType');
        $couponUrl = Request::getPost('couponUrl');

        $result = [];

        if( $url && $member_id ){

            $model = new \App\Proxy\Model\JdUnion();
            $model->setAccountConfig( $member_id );

            $result = $model->subUnionidPromotion( $url, $member_id, $couponUrl, '', '', $chainType );
        }

        $this->assign( 'url', $result );
    }