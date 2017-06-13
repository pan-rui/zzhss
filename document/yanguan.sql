
SET FOREIGN_KEY_CHECKS=0;
drop DATABASE IF EXISTS yg;
CREATE DATABASE yg DEFAULT CHARSET =utf8;
use yg;
-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS t_admin;
CREATE TABLE `t_admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `adminName` varchar(20) DEFAULT NULL COMMENT '用户名',
  `pwd` varchar(32) DEFAULT NULL COMMENT '密码',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `isEnable` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Table structure for t_admin_action_log
-- ----------------------------
DROP TABLE IF EXISTS t_admin_action_log;
CREATE TABLE `t_admin_action_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `adminId` bigint(20) DEFAULT NULL COMMENT '管理员ID',
  `action` varchar(200) DEFAULT NULL COMMENT '访问路径',
  `refAction` varchar(200) DEFAULT NULL COMMENT '引用路径',
  `ip` varchar(20) DEFAULT NULL COMMENT 'IP地址',
  `actionPara` text COMMENT '参数',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_admin_action_log_ibfk_1` FOREIGN KEY (`adminId`) REFERENCES t_admin (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员操作记录表';

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_menu;
CREATE TABLE `t_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `menuName` varchar(30) DEFAULT NULL COMMENT '名称',
  `url` varchar(50) DEFAULT NULL COMMENT '路径',
  `menuLevel` enum('1','2','3') DEFAULT '1' COMMENT '菜单级别{"1":"一级菜单","2":"二级菜单","3":"三级菜单"}',
  `isIntercept` ENUM('0','1') DEFAULT '0' COMMENT '拦截{"0":"否","1":"是"}',
  `parentId` bigint(20) DEFAULT '0'COMMENT '父ID',
  `icon` VARCHAR(16) DEFAULT '' COMMENT '图标',
  `sort` int(2) DEFAULT 1 COMMENT '排序',
  `fixedly` varchar(200) DEFAULT '["id"]' COMMENT '固定列',
  `active` varchar(500) DEFAULT NULL COMMENT '活动列',
  `search` varchar(200) DEFAULT '["id"]' COMMENT '搜索条件',
  `operate` varchar(1024) DEFAULT NULL COMMENT '操作项',
  `cMenu` varchar(1024) DEFAULT NULL COMMENT '右键菜单项',
  `help` varchar(200) DEFAULT NULL COMMENT '帮助内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY menu_url(url) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='后台菜单表';



-- ----------------------------
-- Table structure for t_role
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_role;
CREATE TABLE `t_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `roleName` varchar(20) DEFAULT NULL COMMENT '角色名',
  `description` varchar(50) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for t_role_admin
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_role_admin;
CREATE TABLE `t_role_admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `adminId` bigint(20) DEFAULT NULL COMMENT '管理员ID',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  #   KEY `roleId` (`roleId`),
  #   KEY `adminId` (`adminId`),
  CONSTRAINT `t_role_admin_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES t_role (`id`),
  CONSTRAINT `t_role_admin_ibfk_2` FOREIGN KEY (`adminId`) REFERENCES t_admin (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='管理员角色关联表';

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_role_auth;
CREATE TABLE `t_role_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `roleId` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menuId` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  #   KEY `roleId` (`roleId`),
  #   KEY `adminId` (`menuId`),
  CONSTRAINT `t_role_menu_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES t_role (`id`),
  CONSTRAINT `t_role_menu_ibfk_2` FOREIGN KEY (`menuId`) REFERENCES t_menu (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='权限菜单表';

-- ----------------------------
-- Table structure for t_user_action_log
-- ----------------------------
DROP TABLE IF EXISTS t_user_action_log;
CREATE TABLE `t_user_action_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `action` varchar(200) DEFAULT NULL COMMENT '访问路径',
  `refAction` varchar(500) DEFAULT NULL COMMENT '引用路径',
  `ip` varchar(20) DEFAULT NULL COMMENT 'IP地址',
  `actionPara` text COMMENT '参数',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_user_action_log_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='用户操作记录表';

-- ----------------------------
-- Table structure for t_banner
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_banner;
CREATE TABLE `t_banner` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bannerName` varchar(30) DEFAULT NULL COMMENT 'banner名称',
  `imgPath` varchar(50) DEFAULT NULL COMMENT '图片路径',
  `url` varchar(50) DEFAULT NULL COMMENT '路径',
  `orderNo` int(11) DEFAULT NULL COMMENT '排序',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `isDelete` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='banner表';

-- ----------------------------
-- Table structure for t_help
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_help;
CREATE TABLE `t_help` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `questionName` varchar(100) DEFAULT NULL COMMENT '问题',
  `answer` text COMMENT '答案',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `orderNo` int(3) DEFAULT NULL COMMENT '排序',
  `helpTypeId` bigint(20) DEFAULT NULL COMMENT '帮助类型ID',
  PRIMARY KEY (`id`),
  #   KEY `helpTypeId` (`helpTypeId`),
  CONSTRAINT `t_help_ibfk_1` FOREIGN KEY (`helpTypeId`) REFERENCES t_help_type (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='帮助';

-- ----------------------------
-- Table structure for t_help_type
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_help_type;
CREATE TABLE `t_help_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `helpTypeName` varchar(30) DEFAULT NULL COMMENT '名称类型',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `orderNo` int(3) DEFAULT NULL COMMENT '排序',
  `helpTypeId` int(1) DEFAULT '0' COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='帮助类型';

-- ----------------------------
-- Table structure for t_links
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_links;
CREATE TABLE `t_links` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `linkName` varchar(30) DEFAULT NULL COMMENT '合作伙伴名称',
  `imagePath` varchar(50) DEFAULT NULL COMMENT 'logo路径',
  `shortName` varchar(20) DEFAULT NULL COMMENT '合作伙伴简称',
  `linkUrl` varchar(50) DEFAULT NULL COMMENT '官网地址',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `description` varchar(10240) DEFAULT NULL COMMENT '公司概要',
  `isDelete` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  `orderNo` int(3) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='合作伙伴或链接';

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_notice;
CREATE TABLE `t_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `noticeTitle` varchar(30) DEFAULT '' COMMENT '公告标题',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `noticeContent` tinytext COMMENT '内容',
  `adminId` bigint(20) DEFAULT NULL COMMENT '发布者ID',
  `orderNo` int(3) DEFAULT NULL COMMENT '排序',
  `isDelete` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='公告';

-- ----------------------------
-- Table structure for t_sms 短信活动推广模板
-- ----------------------------
DROP TABLE IF EXISTS t_sms;
CREATE TABLE `t_sms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `smsContent` varchar(300) DEFAULT NULL COMMENT '模板内容',
  `smsType` varchar(20) DEFAULT NULL COMMENT '模板类型',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `sendStatus` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  PRIMARY KEY (`id`)
  #   KEY `userId` (`userId`),
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='短信模板表';

-- ----------------------------
-- Table structure for t_sms_record //TODO:update
-- ----------------------------
DROP TABLE IF EXISTS t_sms_record;
CREATE TABLE `t_sms_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `keyVal` varchar(15) DEFAULT NULL COMMENT '注册IP或手机号',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `mobileStatus` ENUM('0','1','2','3') DEFAULT '0'  COMMENT '状态{"0":"可用","1":"黑名单","2":"停机","3":"注销"}',
  `counts` int(5) DEFAULT 0 COMMENT '次数,超过上限锁号',
  `totalCount` int(5) DEFAULT 0 COMMENT '总次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='短信发送记录,有次数限定时使用';

-- ----------------------------
-- Table structure for t_user//TODO:update
-- ----------------------------
DROP TABLE IF EXISTS t_user;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱地址',
  `pwd` varchar(32) DEFAULT NULL COMMENT '用户密码',
  `cellPhone` varchar(12) DEFAULT NULL COMMENT '手机号码',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `isEnable` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  `regIp` varchar(15) DEFAULT NULL COMMENT '注册IP',
  `lastLoginIp` varchar(15) DEFAULT NULL COMMENT '最后登录Ip',
  `lastLoginTime` datetime DEFAULT NULL COMMENT '最后登录时间',
  `type` ENUM('0','1','2','3','4') DEFAULT '0' COMMENT '类型{"0":"普通用户","1":"区代理","2":"省代理","3":"市代理","4":"供应商","5":"业务员"}',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userName` (`userName`) USING BTREE,
  UNIQUE KEY `cellPhone` (`cellPhone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='用户';

# DROP INDEX userName ON yg.t_user;
# DROP INDEX cellPhone ON yg.t_user;
# DROP INDEX t_user_cellPhone_uindex ON yg.t_user;
ALTER TABLE yg.t_user ADD UNIQUE cellPhone(cellPhone);
ALTER TABLE yg.t_user ADD UNIQUE useName(userName);
# ALTER TABLE yg.t_user ADD  CONSTRAINT UNIQUE (cellPhone);
-- ----------------------------
-- Table structure for t_user_login_record
-- ----------------------------
DROP TABLE IF EXISTS t_user_login_record;
CREATE TABLE `t_user_login_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) NOT NULL COMMENT '用户ID',
  `createTime` datetime DEFAULT NULL COMMENT '登录时间',
  `loginIp` varchar(30) DEFAULT NULL COMMENT '登录IP',
  `clientType` ENUM('PC','Android','IOS') DEFAULT 'PC' COMMENT '客户端{"PC":"电脑","Android":"安卓机","IOS":"苹果"}',
  PRIMARY KEY (`id`),
  #   KEY `userId` (`userId`),
  CONSTRAINT `t_user_login_record_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录记录表';

-- ----------------------------
-- Table structure for t_coupon
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS `t_coupon_dict`;
CREATE TABLE `t_coupon_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `couponName` varchar(30) DEFAULT NULL COMMENT '礼券名称',
  `couponAmount` decimal(18,2) DEFAULT NULL COMMENT '礼券金额',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `couponRemarks` varchar(80) DEFAULT NULL COMMENT '备注(code)',
  `couponStatus` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  `isWithdraw` ENUM('0','1') DEFAULT '0' COMMENT '允许提现{"0":"是","1":"否"}',
  `couponType` ENUM('0','1','2') DEFAULT '0' COMMENT '类型{"0":"红包","1":"推荐奖励","2":"其它"}',
  `expirationDate` datetime DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='礼券字典表';

DROP TABLE IF EXISTS `t_coupon`;
CREATE TABLE `t_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(11) DEFAULT NULL COMMENT '用户id',
  `couponId` bigint(11) DEFAULT NULL COMMENT '礼券id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `useTime` datetime DEFAULT NULL COMMENT '使用时间',
  `couponRemarks` varchar(80) DEFAULT NULL COMMENT '备注',
  `couponStatus` ENUM('1','2','3','4','5','6') DEFAULT NULL COMMENT '状态{"1":"未领取","2":"未使用","3":"已使用","4":"未领取过期","5":"未使用过期","6":"处理中"}',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_coupon_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='礼券表';

-- ----------------------------
-- Table structure for t_referee_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_referee_relation`;
CREATE TABLE `t_referee_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) NOT NULL COMMENT ' 被推荐人ID',
  `refereeId` bigint(20) NOT NULL NULL COMMENT '推荐人ID(推荐码)',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `couponStatus` ENUM('0','1') DEFAULT '0' COMMENT '奖励给否{"0":"未给","1":"已给"}',
  PRIMARY KEY (`id`),
  #   KEY `userId` (`userId`),
  #   KEY `refereeId` (`refereeId`),
  CONSTRAINT `t_referee_relation_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_referee_relation_ibfk_2` FOREIGN KEY (`refereeId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推荐关系表';

#系统字典表 TODO:缓存
DROP TABLE IF EXISTS t_system_dict;
CREATE TABLE t_system_dict(
  id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  code VARCHAR(64) NOT NULL COMMENT 'key',
  value VARCHAR(20480) NOT NULL COMMENT 'value',
  description VARCHAR(200) COMMENT '描述',
  status ENUM('0','1') DEFAULT '0' NOT NULL COMMENT '状态{"0":"启用","1":"禁用"}',
  ctime DATETIME NOT NULL COMMENT '创建时间',
  orderNo INT(4) NOT NULL COMMENT '显示顺序'
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

/*-- ----------------------------
-- Table structure for t_para
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_para;
CREATE TABLE `t_para` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `paraName` varchar(20) DEFAULT NULL COMMENT '名称',
  `paraCode` varchar(32) DEFAULT NULL COMMENT '编码Code',
  `paraKey` varchar(32) DEFAULT NULL COMMENT 'key',
  `paraValue` varchar(200) DEFAULT NULL COMMENT '值',
  `description` varchar(100) DEFAULT NULL COMMENT ' 描述',
  `isDelete` enum('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='参数值';*/

DROP TABLE if EXISTS t_statistics;
CREATE TABLE t_statistics(
  id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  name VARCHAR(64) COMMENT '名称',
  sqlString VARCHAR(4096) NOT NULL COMMENT 'SQL脚本',
  columnList VARCHAR(512) NOT NULL COMMENT '显示列',
  description VARCHAR(200) NOT NULL COMMENT '描述',
  cteime DATETIME NOT NULL COMMENT '创建时间'
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='统计定义表';


-- ----------------------------
-- Table structure for t_warehouse 仓库
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse`;
CREATE TABLE `t_warehouse` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `utime` datetime DEFAULT NULL COMMENT '修改时间',
  `agentId` BIGINT(20) NOT NULL COMMENT '代理ID',
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  `code` varchar(50) DEFAULT NULL COMMENT '编号',
  `province` varchar(16) DEFAULT NULL COMMENT '省编号',
  `city` varchar(10) DEFAULT NULL COMMENT '市编号',
  `areas` varchar(10) DEFAULT NULL COMMENT '区编号',
  `lng` varchar(50) DEFAULT NULL COMMENT '经度',
  `lat` varchar(50) DEFAULT NULL COMMENT '纬度',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_warehouse_ibfk_1` FOREIGN KEY (`agentId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_in 入库表
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_in`;
CREATE TABLE `t_warehouse_in` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `utime` datetime DEFAULT NULL COMMENT '修改时间',
  `agentId` BIGINT(20) NOT NULL COMMENT '代理ID',
  `warehouseId` BIGINT(20) NOT NULL COMMENT '仓库ID',
  `code` varchar(20) DEFAULT NULL COMMENT '仓库编号',
  `operator` varchar(20) DEFAULT NULL COMMENT '操作员',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_warehouse_in_ibfk_1` FOREIGN KEY (`agentId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for t_order     订单表
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `userId` BIGINT(20)  NOT NULL COMMENT '用户ID',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  `utime` datetime COMMENT '修改时间',
  `orderSn` varchar(32) DEFAULT '' COMMENT '流水号',
  `payType` ENUM('0','1') DEFAULT '0' COMMENT '付款方式{"0":"支付宝","1":"微信"}',
  `contact` BIGINT(20) NOT NULL COMMENT '联系方式ID',
  #   `f_deliver` varchar(10)  DEFAULT '' COMMENT '配送方式',
  #   `f_addr` varchar(100)  DEFAULT '',
  `storeId` BIGINT(20) NOT NULL COMMENT '分店ID',
  `money` double(16,2) DEFAULT '0.00' COMMENT '消费金额',
  #   `f_point` int(11) DEFAULT '0',
  `discount` double(16,2) DEFAULT '0.00' COMMENT '会员折扣',
  `preferential` double(16,2) DEFAULT '0.00' COMMENT '优惠金额',
  `freight` double(16,2) DEFAULT '0.00' COMMENT '运费',
  `bill` varchar(100)  DEFAULT '' COMMENT '发票号',
  `couponId` BIGINT(20)  DEFAULT null COMMENT '优惠卷ID',
  `couponPrice` double(16,2) DEFAULT '0.00' COMMENT '优惠卷抵扣金额',
  `payMoney` double(16,2) DEFAULT '0.00' COMMENT '实付金额',
  `orderMoney` double(16,2) DEFAULT '0.00' COMMENT '订单金额',
  #   `orderCount` int(11) DEFAULT '0'COMMENT '订单数量',
  `payNum` varchar(100)  DEFAULT '' COMMENT '支付流水号',
  `state` ENUM('0','1','2','3','4','5','6','7','8')  DEFAULT '0' COMMENT '订单状态{"0":"下单待付款","1":"待发货","2":"待收货","3":"申请退款中","4":"退款审核失败","5":"收货确认中","6":"待放款","7":"交易完成","8":"已取消","9":"已退货"}',
  `description` varchar(100)  DEFAULT '' COMMENT '描述',
    `deliveryTime` ENUM('1234567','12345','67') DEFAULT '1234567' COMMENT '配送时间:{"1234567":"周一至周日","12345":"(工作日)周一至周五","67":"节假日(周六周日)"}',
  `payInfo` VARCHAR(200) DEFAULT NULL COMMENT '支付详情',
  `startDeliveryTime` datetime DEFAULT NULL COMMENT '发货时间',
  `endDeliveryTime` datetime DEFAULT NULL COMMENT '收货时间',
  `logistics` varchar(10)  DEFAULT '' COMMENT '物流公司',
  `logisticsId` varchar(50)  DEFAULT '' COMMENT '物流编号',
  `remark` varchar(256)  DEFAULT '' COMMENT '备注',
  `logisticsState` VARCHAR(4099) DEFAULT null COMMENT '物流状态',
  `reqIp` VARCHAR(15) COMMENT '请求IP',
  `shipments` VARCHAR(4097) DEFAULT '' Comment '发货详情',
  /*  `by_user_id` char(16)  DEFAULT NULL,
    `add_point` int(11) DEFAULT '0',
    `add_money` int(11) DEFAULT '0',*/
  PRIMARY KEY (`id`),
  CONSTRAINT `t_order_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_order_ibfk_2` FOREIGN KEY (`storeId`) REFERENCES t_warehouse (`id`),
  CONSTRAINT `t_order_ibfk_4` FOREIGN KEY (`contact`) REFERENCES t_delivery (`id`),
  CONSTRAINT `t_order_ibfk_3` FOREIGN KEY (`couponId`) REFERENCES t_coupon_dict (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 ;


-- ----------------------------
-- Table structure for t_order_item  订单项目表
-- ----------------------------
DROP TABLE IF EXISTS `t_order_item`;
CREATE TABLE `t_order_item` (
  `id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `orderId` BIGINT(20)  NOT NULL COMMENT '订单ID',
  `prodId` BIGINT(20)  NOT NULL COMMENT '产品ID',
  `prodName` char(50)  DEFAULT '' COMMENT '产品名称',
  `price` double(16,2) DEFAULT '0.00' COMMENT '产品价格',
  `priceY` double(16,2) DEFAULT '0.00' COMMENT '产优惠价',
  #   `point` int(11) DEFAULT '0',
  `count` int(11) DEFAULT '0' COMMENT '商品数量',
  imei JSON DEFAULT null COMMENT '产品编号',
  ctime DATETIME DEFAULT current_timestamp COMMENT '创建时间',
  #   `price_type` varchar(10)  DEFAULT '',
  /*  `spec1` varchar(20)  DEFAULT '',
    `spec2` varchar(20)  DEFAULT '',*/
  PRIMARY KEY (`id`,`orderId`),
  CONSTRAINT `t_order_item_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES t_order (`id`),
  CONSTRAINT `t_order_item_ibfk_2` FOREIGN KEY (`prodId`) REFERENCES t_product (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 ;

-- ----------------------------
-- Table structure for t_group_buy modify-->购物车
-- ----------------------------
DROP TABLE IF EXISTS `t_shopping_cart`;
CREATE TABLE `t_shopping_cart` (
  `id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ctime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `utime` datetime COMMENT '修改时间',
  `userId` BIGINT(20) NOT NULL COMMENT '用户ID',
  loginIp VARCHAR(16) DEFAULT '' COMMENT '登录IP',
  productItem JSON COMMENT '商品列表',
  #   `order_num` varchar(100)  DEFAULT NULL,
  #   `expiry_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `t_shopping_cart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 ;

-- ----------------------------
-- Table structure for t_order_refund 订单退款表---与订单表合并
-- ----------------------------
DROP TABLE IF EXISTS `t_order_refund`;
CREATE TABLE `t_order_refund` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` BIGINT(20) NOT NULL COMMENT '用户ID',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  `utime` datetime NOT NULL COMMENT '修改时间',
  `orderId` BIGINT(20) NOT NULL COMMENT '订单ID',
  `orderNum` varchar(100) DEFAULT NULL,
  `operateTime` datetime DEFAULT NULL COMMENT '退款时间',
  `tradeNum` varchar(64) DEFAULT NULL COMMENT '退款交易号',
  `voucher` varchar(128) DEFAULT NULL COMMENT '退款凭证',
  `accountType` ENUM('0','1') DEFAULT '0' COMMENT '账户类型{"0":"支付宝","1":"微信"}',
  `bankAcc` varchar(32) DEFAULT NULL COMMENT '账户号',
  `desc` varchar(64) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_order_refund_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_order_refund_ibfk_2` FOREIGN KEY (`orderId`) REFERENCES t_order (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_product_stock 商品库存表
-- ----------------------------
DROP TABLE IF EXISTS `t_product_stock`;
CREATE TABLE `t_product_stock` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `utime` datetime DEFAULT NULL COMMENT '修改时间',
  `userId` BIGINT(20) NOT NULL COMMENT '用户ID',
  `warehouseId` BIGINT(20) NOT NULL COMMENT '仓库ID',
  `prodId` BIGINT(20) NOT NULL COMMENT '产品ID',
  `stockCount` int(11) DEFAULT NULL COMMENT '库存数量',
  #   `spec_count` int(11) DEFAULT NULL,
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_product_stock_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_product_stock_ibfk_2` FOREIGN KEY (`warehouseId`) REFERENCES t_warehouse (`id`),
  CONSTRAINT `t_product_stock_ibfk_3` FOREIGN KEY (`prodId`) REFERENCES t_product (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_supplier    供应商表
-- ----------------------------
DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE `t_supplier` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `utime` datetime DEFAULT NULL COMMENT '修改时间',
  `userId` BIGINT(20) NOT NULL COMMENT '用户ID',
  `name` varchar(20) DEFAULT NULL COMMENT '供应商名',
  `code` varchar(20) DEFAULT NULL COMMENT '供应商编号',
  /*  `acc` varchar(50) DEFAULT NULL COMMENT '账号',
    `pwd` char(32) DEFAULT NULL COMMENT '操作密码',*/
  `img` varchar(100) DEFAULT NULL COMMENT 'logo',
  `linkman` varchar(20) DEFAULT NULL COMMENT '联系人',
  `address` varchar(500) DEFAULT NULL COMMENT '地扯',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `mail` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `desc` varchar(1000) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_supplier_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_product  商品表
-- TODO:缓存
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product`(
  `id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  `utime` datetime NOT NULL COMMENT '修改时间',
  `imei` varchar(15) DEFAULT '' COMMENT '产品编号',
  `name` varchar(50)  NOT NULL DEFAULT '' COMMENT '产品名称',
  `img` varchar(100)  NOT NULL DEFAULT '' COMMENT '缩略图',
  `imgs` JSON  DEFAULT null COMMENT '图集',
  `desc` varchar(1000)  NOT NULL DEFAULT '' COMMENT '描述',
  `price` double(16,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `priceY` double(16,2) NOT NULL DEFAULT '0.00' COMMENT '优惠价格',
  `spec` JSON  NOT NULL COMMENT '产品规格',
  `content` varchar(5000)  NOT NULL DEFAULT '' COMMENT '产品详情',#html格式
  `state` ENUM('0','1')  NOT NULL DEFAULT '0' COMMENT '产品状态{"0":"正常","1":"停产"}',
  `onLineDate` DATETIME NOT NULL DEFAULT current_timestamp COMMENT '上线日期',
  sellCount INT(11) DEFAULT 0 COMMENT '累计售出',
  install VARCHAR(4097) DEFAULT NULL COMMENT '安装描述',
  accessories VARCHAR(4099) DEFAULT NULL COMMENT '附件',
  #   `tag` varchar(512)  DEFAULT '',
  #   `diy_prod_page` varchar(32)  DEFAULT NULL,
  PRIMARY KEY (`id`)
  #   UNIQUE KEY product_imei(imei) USING BTREE
  #       CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`imei`) REFERENCES t_user (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 ;



-- ----------------------------
-- Table structure for t_warehouse_out 出库表
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_out`;
CREATE TABLE `t_warehouse_out` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `utime` datetime DEFAULT NULL COMMENT '修改时间',
  `userId` BIGINT(20) NOT NULL COMMENT '用户ID',
  `warehouseId` BIGINT(20) NOT NULL COMMENT '仓库ID',
  `agentId` BIGINT(20) NOT NULL COMMENT '代理ID',
  `orderId` BIGINT(20) NOT NULL COMMENT '订单ID',
  `code` varchar(20) DEFAULT NULL COMMENT '仓库编号',
  `operator` varchar(20) DEFAULT NULL COMMENT '操作员',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  CONSTRAINT `t_warehouse_out_ibfk_1` FOREIGN KEY (`agentId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_warehouse_out_ibfk_2` FOREIGN KEY (`userId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_warehouse_out_ibfk_3` FOREIGN KEY (`orderId`) REFERENCES t_order (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT  CHARSET=utf8;

DROP TABLE IF EXISTS t_freight;
CREATE TABLE t_freight (
  id BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  provinceCode VARCHAR(16) NOT NULL COMMENT '省编号',
  #{code:city....
  citys JSON NOT NULL COMMENT '市列表',
  amount DOUBLE(6,2) NOT NULL COMMENT '省内运费',
  ctime DATETIME DEFAULT current_timestamp COMMENT '创建时间',
  utime DATETIME DEFAULT current_timestamp COMMENT '修改时间',
  remark VARCHAR(32) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS t_delivery;
CREATE TABLE t_delivery
(
  id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  userId bigint(20) NOT NULL COMMENT '用户ID',
  name varchar(16) NOT NULL COMMENT '姓名',
  phone varchar(13) NOT NULL COMMENT '电话',
  province varchar(8) COMMENT '省',
  city varchar(8) COMMENT '市',
  area varchar(8) COMMENT '区',
  exact varchar(100) NOT NULL COMMENT '详细地址',
  zip varchar(7) COMMENT '邮编',
  mark varchar(32) COMMENT '标签',
  isDefault ENUM('0','1') DEFAULT '1' COMMENT '默认地址:{"0":"是","1":"否"}',
  ctime DATETIME COMMENT '创建时间',
  CONSTRAINT `t_delivery_ibfk_1` FOREIGN KEY (userId) REFERENCES t_user (id)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 ;

DROP TABLE IF EXISTS t_pay;
CREATE TABLE t_pay
(
  id bigint PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  businessSn varchar(32) NOT NULL COMMENT '商户号',
  appKey varchar(128) NOT NULL COMMENT 'AppKEY',
  cert varchar(128) NOT NULL COMMENT '证书路径',
  logo varchar(128) COMMENT '图标',
  name varchar(32) NOT NULL COMMENT '名称',
  ctime DATETIME  COMMENT '创建时间',
  testApi varchar(128) COMMENT '测试地址',
  utime DATETIME COMMENT '修改时间',
  api varchar(128) COMMENT '正式地址',
  `desc` varchar(256) COMMENT '描述',
  remark varchar(256) COMMENT '备注',
  head JSON comment '请求头参数',
  content JSON comment '请求主体参数'
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;


CREATE TABLE t_sale
(
  id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  userId bigint(20) NOT NULL COMMENT '用户ID',
  orderId BIGINT(20) NOT NULL COMMENT '订单ID',
  saleType ENUM('0','1','2') DEFAULT '0' COMMENT '售后类型:{"0":"维修","1":"换货","2":"退货"}',
  saleCount int(5) NOT NULL COMMENT '提交数量',
  description varchar(500) COMMENT '问题描述',
  picture VARCHAR(4098) COMMENT '图片信息',
  evidence ENUM('0','1') COMMENT '申请凭据:{"0":"发票","1":"检测报告"}',
  backType VARCHAR(50) COMMENT '返回方式',
  address varchar(100) COMMENT '收货地址',
  name VARCHAR(16) COMMENT '收货人',
  userName VARCHAR(16) COMMENT '客户姓名',
  phone VARCHAR(11) COMMENT '手机号码',
  ctime DATETIME COMMENT '创建时间',
  CONSTRAINT `t_sale_ibfk_1` FOREIGN KEY (userId) REFERENCES t_user (id),
  CONSTRAINT `t_sale_ibfk_2` FOREIGN KEY (orderId) REFERENCES t_order (id)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 ;
ALTER TABLE yg.t_sale CHANGE productName productId BIGINT(20) COMMENT '商品ID';

INSERT INTO yg.t_admin (id, adminName, pwd, createTime, isEnable) VALUES (999, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '2016-01-05 19:36:32', '0');
