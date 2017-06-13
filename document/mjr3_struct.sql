/*
Navicat MySQL Data Transfer

Source Server         : mjr3
Source Server Version : 50527
Source Host           : 192.168.10.146:3306
Source Database       : mjr3

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2015-05-07 08:53:54
*/

SET FOREIGN_KEY_CHECKS=0;
drop DATABASE IF EXISTS yiwu;
CREATE DATABASE yiwu DEFAULT CHARSET =utf8;
use yiwu;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员操作记录表';

-- ----------------------------
-- Table structure for t_area
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_area;
CREATE TABLE `t_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `areaId` varchar(30) DEFAULT NULL COMMENT '区域代码',
  `areaName` varchar(50) DEFAULT NULL COMMENT '区域名称',
  `parentId` bigint(20) DEFAULT NULL COMMENT '父ID',
  `parentAareaId` varchar(30) DEFAULT NULL COMMENT '上级区域代码',
  `areaLevel` int(2) DEFAULT NULL COMMENT '级别',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='地区表';

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
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='参数值';

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
  KEY `roleId` (`roleId`),
  KEY `adminId` (`adminId`),
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
  KEY `roleId` (`roleId`),
  KEY `adminId` (`menuId`),
  CONSTRAINT `t_role_menu_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES t_role (`id`),
  CONSTRAINT `t_role_menu_ibfk_2` FOREIGN KEY (`menuId`) REFERENCES t_menu (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='权限菜单表';

-- ----------------------------
-- Table structure for t_score
-- ----------------------------#TODO:积分字典表,缓存
DROP TABLE IF EXISTS t_score_dict;
CREATE TABLE `t_score_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `scoreName` varchar(20) DEFAULT NULL COMMENT '积分名称',
  `scoreType` varchar(20) DEFAULT NULL COMMENT '积分类型',
  `score` int(10) DEFAULT NULL COMMENT '积分',
  `awardLevel` varchar(5) DEFAULT 'V0' COMMENT '奖励级别',
  `scoreStatus` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1","禁用"}',
  `awardExpirationDate` datetime DEFAULT NULL COMMENT '过期时间',
  `remarks` varchar(50) DEFAULT NULL COMMENT '备注',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分字典表';

DROP TABLE IF EXISTS t_score;
CREATE TABLE `t_score` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `scoreId` bigint(20) DEFAULT NULL COMMENT '积分ID',
  `remarks` varchar(50) DEFAULT NULL COMMENT '备注',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `scoreId` (`scoreId`),
  CONSTRAINT `t_score_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_score_ibfk_2` FOREIGN KEY (`scoreId`) REFERENCES t_score_dict (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分表';

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
  PRIMARY KEY (`id`)
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
  `helpTypeId` bigint(20) DEFAULT NULL COMMENT '帮助类型ID',
  PRIMARY KEY (`id`),
  KEY `helpTypeId` (`helpTypeId`),
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
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='帮助类型';

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
  `description` varchar(300) DEFAULT NULL COMMENT '公司概要',
  `isDelete` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  `orderNo` int(3) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合作伙伴或链接';

-- ----------------------------
-- Table structure for t_media_report
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_media_report;
CREATE TABLE `t_media_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(60) DEFAULT '' COMMENT '标题',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `content` text COMMENT '内容',
  `adminId` bigint(20) DEFAULT NULL COMMENT '发布ID',
  `orderNo` int(3) DEFAULT NULL COMMENT '排序',
  `src` varchar(60) DEFAULT NULL COMMENT '来源名称',
  `keywords` varchar(60) DEFAULT NULL,
  `srcUrl` varchar(60) DEFAULT NULL COMMENT '来源URL',
  `srcImgPath` varchar(60) DEFAULT NULL COMMENT '图片路径',
  `isDelete` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  `reportType` ENUM('1','2') DEFAULT NULL COMMENT '类型{"1":"行业资讯","2":"媒体报道"}',
  `viewCount` int(10) DEFAULT '0' COMMENT '浏览量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='媒体报道';

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS t_message;
CREATE TABLE `t_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `senderId` bigint(20) DEFAULT NULL COMMENT '发送者ID',
  `receiverId` bigint(20) DEFAULT NULL COMMENT '接收者ID',
  `parentId` bigint(20) DEFAULT NULL COMMENT '父消息ID',
  `messageTitle` varchar(30) DEFAULT NULL COMMENT '消息标题',
  `messageContent` varchar(200) DEFAULT NULL COMMENT '消息内容',
  `createTime` datetime DEFAULT NULL COMMENT '发送时间',
  `isDelete` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"未删除","1":"已删除"}',
  `messageType` ENUM('0','1') DEFAULT '0' COMMENT '消息类型{"0":"发送","1":"接收"}',
  PRIMARY KEY (`id`),
  KEY `senderId` (`senderId`),
  KEY `receiverId` (`receiverId`),
  CONSTRAINT `t_message_ibfk_1` FOREIGN KEY (`senderId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_message_ibfk_2` FOREIGN KEY (`receiverId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_message_parentId` check (messageTitle is not null and parentId is not null )
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息表(messageType后续可能升级为论坛版块类型 或 新建论坛消息版块表)';

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------TODO:缓存
DROP TABLE IF EXISTS t_notice;
CREATE TABLE `t_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `noticeTitle` varchar(30) DEFAULT '' COMMENT '公告标题',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `noticeContent` tinytext COMMENT '内容',
  `adminId` bigint(20) DEFAULT NULL COMMENT '发布ID',
  `orderNo` int(3) DEFAULT NULL COMMENT '排序',
  `isDelete` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公告';

-- ----------------------------
-- Table structure for t_sms
-- ----------------------------
DROP TABLE IF EXISTS t_sms;
CREATE TABLE `t_sms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `smsContent` varchar(300) DEFAULT NULL COMMENT '短信内容',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `cellPhone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `smsType` varchar(20) DEFAULT NULL COMMENT '发送类型',
  `sendStatus` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"失败","1":"成功"}',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_sms_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信信息表,主动短信通知';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信发送记录,有次数限定时使用';

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
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `isEnable` int(1) DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  `regIp` varchar(15) DEFAULT NULL COMMENT '注册IP',
  `lastLoginIp` varchar(15) DEFAULT NULL COMMENT '最后登录Ip',
  `lastLoginTime` datetime DEFAULT NULL COMMENT '最后登录时间',
  `source` ENUM('0','1','2','3') DEFAULT '0' COMMENT '来源{"0":"普通会员","1":"新浪","2":"QQ"}',
  `type` ENUM('0','1','2','3','4') DEFAULT '0' COMMENT '类型{"0":"普通用户","1":"经纪人","2":"担保机构","3":"合作伙伴","4":"其它"}',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userName` (`userName`) USING BTREE,
  UNIQUE KEY `cellPhone` (`cellPhone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Table structure for t_user_detail
-- ----------------------------
/*DROP TABLE IF EXISTS `t_user_detail`;
CREATE TABLE `t_user_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `score` int(10) DEFAULT '0' COMMENT '积分',
  `userId` bigint(20) DEFAULT NULL,
  `awardLevel` varchar(5) DEFAULT 'V0' COMMENT '奖励级别',
  `isNew` int(1) DEFAULT '1' COMMENT '是否新手（0,否,1是）',
  `awardTimeLevel` varchar(5) DEFAULT 'V0' COMMENT '奖励级别',
  `awardExpirationDate` datetime DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_user_detail_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户详情';*/

-- ----------------------------
-- Table structure for t_user_login_record
-- ----------------------------
DROP TABLE IF EXISTS t_user_login_record;
CREATE TABLE `t_user_login_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `createTime` datetime DEFAULT NULL COMMENT '登录时间',
  `loginIp` varchar(30) DEFAULT NULL COMMENT '登录IP',
  `clientType` ENUM('PC','Android','IOS') DEFAULT 'PC' COMMENT '客户端{"PC":"电脑","Android":"安卓机","IOS":"苹果"}',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_user_login_record_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录记录表';

-- ----------------------------
-- Table structure for t_account
-- ----------------------------
DROP TABLE IF EXISTS `t_account`;
CREATE TABLE `t_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `usableAmount` decimal(18,2) DEFAULT '0.00' COMMENT '可用余额',
  `frozenAmount` decimal(18,2) DEFAULT '0.00' COMMENT '冻结金额',
  `investAmount` decimal(13,2) DEFAULT '0.00' COMMENT '理财金额',
  `totalInvestAmount` decimal(13,2) DEFAULT '0.00' COMMENT '总理财金额',
  `loanAmount` decimal(12,2) DEFAULT '0.00' COMMENT '借款金额',
  `totalLoanAmount` decimal(12,2) DEFAULT '0.00' COMMENT '总借款金额',
  `total_income` decimal(13,2) DEFAULT '0.00' COMMENT '累计收益',
  `totalRechargeAmount` decimal(13,2) DEFAULT '0.00' COMMENT '总充值金额',
  `totalWithdrawAmount` decimal(13,2) DEFAULT '0.00' COMMENT '总提现金额',
  `tradePassword` varchar(100) DEFAULT NULL COMMENT '交易密码',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_account_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户表';

-- ----------------------------
-- Table structure for t_apply_borrow
-- ----------------------------
DROP TABLE IF EXISTS `t_apply_borrow`;
CREATE TABLE `t_apply_borrow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `borrowerName` varchar(20) DEFAULT NULL COMMENT '借款人姓名',
  `borrowerCellPhone` varchar(13) DEFAULT NULL COMMENT '借款人手机号',
  `houseProvince` varchar(30) DEFAULT NULL COMMENT '住址省份',
  `borrowUse` varchar(50) DEFAULT NULL COMMENT '借款用途',
  `houseCity` varchar(30) DEFAULT NULL COMMENT '住址城市',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `borrowAmount` decimal(10,2) DEFAULT '0.00' COMMENT '借款金额',
  `borrowDealine` int(5) DEFAULT '0' COMMENT '借款期限（月）',
  `borrowerType` ENUM('0','1') DEFAULT NULL COMMENT '借款人类型{"0":"个人","1":"企业"}',
  `borrowType` ENUM('0','1','2','3',',4','5','6') DEFAULT NULL COMMENT '借款类型{"4":"银票","5":"保理","0":"房","1":"车","2":"信用标","3":"其它"}',
  `address` varchar(80) DEFAULT NULL COMMENT '住址',
  `remarks` varchar(300) DEFAULT NULL COMMENT '备注',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `repaymentFrom` VARCHAR(200) DEFAULT NULL COMMENT '还款来源',
  `mortgage` VARCHAR(200) DEFAULT NULL COMMENT '抵/质押物',
  `ip` VARCHAR(32) DEFAULT '127.0..0.1' COMMENT '用户IP',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款申请表';

-- ----------------------------
-- Table structure for t_bank_card
# TODO:暂无银行字典表,如果有应缓存
-- ----------------------------//按创建时间最新的为默认卡
DROP TABLE IF EXISTS `t_bank_card`;
CREATE TABLE `t_bank_card` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bankName` varchar(30) DEFAULT NULL COMMENT '银行名称',
  `subBankName` varchar(50) DEFAULT NULL COMMENT '支行名称',
  `bankCode` varchar(8) DEFAULT NULL COMMENT '银行编号',
  `bankCardNo` varchar(20) DEFAULT NULL COMMENT '银行卡号',
  `cardStatus` ENUM('0','1','2','3') DEFAULT NULL COMMENT '状态{"1":"审核中","1":"审核通过","3":"审核不通过","4":"黑名单"}',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_bank_card_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行卡信息';

-- ----------------------------
-- Table structure for t_borrow
-- ----------------------------
DROP TABLE IF EXISTS `t_borrow`;
CREATE TABLE `t_borrow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `borrowTitle` varchar(50) DEFAULT NULL COMMENT '借款标题',
  `borrowerId` bigint(20) DEFAULT NULL COMMENT '借款申请ID',
  `annualRate` decimal(5,2) DEFAULT '0.00' COMMENT '年化利率',
  `borrowAmount` decimal(18,2) DEFAULT '0.00' COMMENT '借款金额',
  `deadline` int(5) DEFAULT '0' COMMENT '借款期限',
  `deadlineType` ENUM('0','1') DEFAULT '1' COMMENT '期限类型{"0":"天","1":"月"}',
  `raisingPeriod` int(2) DEFAULT '0' COMMENT '筹标期限（天）',
  `minInvestAmount` decimal(18,2) DEFAULT '0.00' COMMENT '最小投标金额',
  `maxInvestAmount` decimal(18,2) DEFAULT '0.00' COMMENT '最大投标金额',
  `repayType` ENUM('0','1','2','3') DEFAULT '0' COMMENT '还款方式{"0":"一次性还款","1":"按月付息,到期还本","3":"等额本息"}',
  `details` text COMMENT '借款详情',
  `windControlTip` text COMMENT '风控意见',
  `hasBorrowAmount` decimal(18,2) DEFAULT '0.00' COMMENT '已募集金额',
  `createTime` datetime DEFAULT NULL COMMENT '创建日期',
  `investStartTime` datetime DEFAULT NULL COMMENT '发标时间',
  `fullTime` datetime DEFAULT NULL COMMENT '满标时间',
  `firstAuditId` bigint(20) DEFAULT NULL COMMENT '审核人ID',
  `auditTime` datetime DEFAULT NULL COMMENT '放款时间',
  `repayDate` date DEFAULT NULL COMMENT '还款日期',
  `borrowNo` varchar(30) NOT NULL COMMENT '借款编号',
  `borrowStatus` ENUM('1','2','3','4','5','6','7','8','9','10','11') DEFAULT '1' COMMENT '借款状态{"1":"申请中","2":"初审失败","3":"复审中","4":"复审失败","5":"筹标中","6":"流标","7":"还款中","8":"已还款","9":"转让中"}',
  `borrowType` ENUM('0','1') DEFAULT '0' COMMENT '标的类型{"0":"信用标","1":"抵押标"}',
  `fullAuditId` bigint(20) DEFAULT NULL COMMENT '复审ID',
  `personBorrowerId` bigint(20) DEFAULT NULL COMMENT '借款人个人信息Id',
  `createId` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `lastUpdateId` bigint(20) DEFAULT NULL COMMENT '最后修改人ID',
  `lastUpateTime` datetime DEFAULT NULL COMMENT '最后修改时间',
  `ordId` varchar(50) DEFAULT NULL COMMENT '借款订单号',
  `clockAmount` decimal(18,2) DEFAULT '0.00' COMMENT '投标锁定金额',
  `borrowPurpose` varchar(30) DEFAULT NULL COMMENT '借款用途',
  PRIMARY KEY (`id`),
  KEY `borrowerId` (`borrowerId`),
  KEY `borrowTitle` (`borrowTitle`),
  CONSTRAINT `t_borrow_ibfk_1` FOREIGN KEY (`borrowerId`) REFERENCES t_apply_borrow (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000000 DEFAULT CHARSET=utf8 COMMENT='借款表';

#TODO:缓存
DROP TABLE IF EXISTS `t_attr_dict`;
CREATE TABLE `t_attr_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
#   `borrowId` bigint(20) DEFAULT NULL COMMENT '借款Id',
  `attrName` varchar(30) DEFAULT NULL COMMENT '附件名称',
  `attrPath` varchar(100) DEFAULT NULL COMMENT '(示例)附件路径',
  `orderNo` varchar(100) DEFAULT NULL COMMENT '排序',
  `description` VARCHAR(300) DEFAULT NULL COMMENT '附件描述',
  `attrStatus` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"启用","1":"禁用"}',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件字典';

-- ----------------------------
-- Table structure for t_borrow_attr
-- ----------------------------
DROP TABLE IF EXISTS `t_borrow_attr`;
CREATE TABLE `t_borrow_attr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `borrowId` bigint(20) DEFAULT NULL COMMENT '借款Id',
  `attrName` varchar(30) DEFAULT NULL COMMENT '附件ID',
  `attrPath` varchar(100) DEFAULT NULL COMMENT '附件路径',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `borrowId` (`borrowId`),
  CONSTRAINT `t_borrow_attr_ibfk_1` FOREIGN KEY (`borrowId`) REFERENCES `t_borrow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款附件';

-- ----------------------------
-- Table structure for t_claim
-- ----------------------------
DROP TABLE IF EXISTS `t_claim`;
CREATE TABLE `t_claim` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ordDate` date DEFAULT NULL COMMENT '订单日期',
  `ordId` varchar(32) DEFAULT NULL COMMENT '订单号',
  `claimAmount` decimal(18,2) DEFAULT '0.00' COMMENT '债权价值(现市场价)',
  `claimAnnualRate` decimal(5,2) DEFAULT '0.00' COMMENT '债权年化收益',
  `claimPriceAmount` decimal(18,2) DEFAULT '0.00' COMMENT '债权价格',
  `claimCapitalAmount` decimal(18,2) DEFAULT '0.00' COMMENT '债权本金',
  `claimProfitAmount` decimal(18,2) DEFAULT '0.00' COMMENT '债权收益(=债权价格*债权年化收益率)',
  `claimUserProfitAmount` decimal(18,2) DEFAULT '0.00' COMMENT '转让人的收益(=债权价格-债权本金)',
  `expectProfitAmount` decimal(18,2) DEFAULT '0.00' COMMENT '债权预期收益(=债权价值-债权本金)',

  `remainClaimAmount` decimal(18,2) DEFAULT '0.00' COMMENT '剩余债权价值',
  `remainClaimPriceAmount` decimal(18,2) DEFAULT '0.00' COMMENT '剩余债权价格',
  `remainClaimCapitalAmount` decimal(18,2) DEFAULT '0.00' COMMENT '剩余债权本金',
  `remainClaimProfitAmount` decimal(18,2) DEFAULT '0.00' COMMENT '剩余债权收益',
  `remainExpectProfitAmount` decimal(18,2) DEFAULT '0.00' COMMENT '剩余债权预期收益',
# 上5列主要供自动投标用
  `claimStatus` ENUM('0','1','2','3') DEFAULT '0' COMMENT '状态{"0":"申请中","1":"购买中","2":"已完成","4":"已取消"}',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `claimUserId` bigint(20) DEFAULT NULL COMMENT '债权人ID',
  `investId` bigint(20) DEFAULT NULL COMMENT '投资ID',
  `borrowId` bigint(20) DEFAULT NULL COMMENT '借款ID',
  `remainDays` int(5) DEFAULT NULL COMMENT '剩余还款天数',
  `lastRepayDate` date DEFAULT NULL COMMENT '最后还款时间',
  `finishTime` datetime DEFAULT NULL COMMENT '债权转让完时间',
  PRIMARY KEY (`id`),
  KEY `investId` (`investId`),
  KEY `claimUserId` (`claimUserId`),
  CONSTRAINT `t_claim_ibfk_1` FOREIGN KEY (`investId`) REFERENCES `t_invest` (`id`),
  CONSTRAINT `t_claim_ibfk_2` FOREIGN KEY (`claimUserId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='债权转让表';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='礼券字典表';

DROP TABLE IF EXISTS `t_coupon`;
CREATE TABLE `t_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(11) DEFAULT NULL COMMENT '用户id',
  `couponId` bigint(11) DEFAULT NULL COMMENT '礼券id',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `couponRemarks` varchar(80) DEFAULT NULL COMMENT '备注',
  `couponStatus` ENUM('1','2','3','4','5','6') DEFAULT NULL COMMENT '状态{"1":"未领取","2","未使用","3":"已使用","4":"未领取过期","5":"未使用过期","6":"处理中"}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='礼券表';

-- ----------------------------
-- Table structure for t_fund_record
-- ----------------------------//TODO:AOP切入增加
DROP TABLE IF EXISTS `t_fund_record`;
CREATE TABLE `t_fund_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `operAmount` decimal(18,2) DEFAULT '0.00' COMMENT '操作金额',
  `inAmount` decimal(18,2) DEFAULT '0.00' COMMENT '可用余额增加金额',
--   `outAmount` decimal(18,2) DEFAULT '0.00' COMMENT '可用余额减少金额',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
--   `fundMode` varchar(30) DEFAULT NULL COMMENT '项目名称',
--   `fundType` int(3) DEFAULT NULL COMMENT '项目类型',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `usableAmount` decimal(18,2) DEFAULT '0.00' COMMENT '可用余额',
  `frozenAmount` decimal(18,2) DEFAULT '0.00' COMMENT '冻结金额',
--   `operType` int(1) DEFAULT '1' COMMENT '操作类型（1为添加可用余额,2,冻结可用余额,3为解冻可用余额,4为减少可用余额）',
  `operType` ENUM('1','2','3','4','5','6') DEFAULT '1' COMMENT '操作类型{"1":"投资","2":"借款","3":"还款","4":"赎回","5":"充值","6":"提现"}',
  `traderId` VARCHAR(50) DEFAULT NULL COMMENT '订单ID或流水号',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_fund_record_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金记录表';

-- ----------------------------
-- Table structure for t_invest
-- ----------------------------
DROP TABLE IF EXISTS `t_invest`;
CREATE TABLE `t_invest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ordId` varchar(50) DEFAULT NULL COMMENT '订单号',
  `ordDate` date DEFAULT NULL COMMENT '订单时间',
  `borrowId` bigint(20) DEFAULT NULL COMMENT '借款ID',
  `investorId` bigint(20) DEFAULT NULL COMMENT '投资人Id',
  `investTime` datetime DEFAULT NULL COMMENT '投资时间',
  `realAmount` decimal(18,2) DEFAULT '0.00' COMMENT '实际投资额度',
  `investAmount` decimal(18,2) DEFAULT '0.00' COMMENT '投资金额',
  `transferAmount` decimal(18,2) DEFAULT '0.00' COMMENT '已投资金额',
  `result` ENUM('0','1','2') DEFAULT '0' COMMENT '是否成功{"0":"处理中","1":"成功","2":"失败"}',
  `claimId` bigint(20) DEFAULT NULL COMMENT '债权Id',
  `isClaim` ENUM('0','1') DEFAULT '0' COMMENT '是否转让{"0":"否","1":"是"}',
  `remarks` varchar(80) DEFAULT NULL COMMENT '投资备注',
  PRIMARY KEY (`id`),
  KEY `t_invest_ibfk_1` (`investorId`),
  KEY `borrowId` (`borrowId`),
  CONSTRAINT `t_invest_ibfk_1` FOREIGN KEY (`investorId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_invest_ibfk_2` FOREIGN KEY (`borrowId`) REFERENCES `t_borrow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资表';

-- ----------------------------
-- Table structure for t_invest_award
-- ----------------------------
DROP TABLE IF EXISTS `t_invest_award`;
CREATE TABLE `t_invest_award` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `awardLevel` varchar(5) DEFAULT NULL COMMENT '奖励级别',
  `dueinAmount` decimal(18,2) DEFAULT '0.00' COMMENT '待收金额',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `investId` bigint(20) DEFAULT NULL COMMENT '投资ID',
  `awardRate` decimal(5,2) DEFAULT '0.00' COMMENT '奖励比例',
  `awardAmount` decimal(18,2) DEFAULT '0.00' COMMENT '奖励金额',
  `awardStatus` ENUM('0','1','2','3','4') DEFAULT '0' COMMENT '状态{"0":"未发放","1":"准备发放","2":"发放中","3":"发放成功","4":"禁止发放"}',
  `awardType` ENUM('0','1','2') DEFAULT '0' COMMENT '类型{"0":"新手奖励","1":"投资奖励","2":"推荐奖励"}',
  `awardTime` datetime DEFAULT NULL COMMENT '奖励时间',
  `borrowId` bigint(20) DEFAULT NULL COMMENT '借款ID',
  `remarks` varchar(50) DEFAULT NULL COMMENT '奖励备注',
  `statusRemarks` varchar(30) DEFAULT NULL COMMENT '状态备注',
  `numOfPeroids` int(2) DEFAULT NULL COMMENT '期数',
  `borrowTitle` varchar(50) DEFAULT NULL COMMENT '借款标题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='奖励推荐';

-- ----------------------------
-- Table structure for t_jot_borrower
-- ----------------------------//TODO:社保,公积金等
DROP TABLE IF EXISTS `t_jot_borrower`;
CREATE TABLE `t_jot_borrower` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `jobProvince` varchar(30) DEFAULT NULL COMMENT '工作省份',
  `jobCity` varchar(30) DEFAULT NULL COMMENT '工作城市',
  `jobYear` varchar(30) DEFAULT NULL COMMENT '工作年限',
  `companyIndustry` varchar(50) DEFAULT NULL COMMENT '公司行业',
  `companyNature` varchar(50) DEFAULT NULL COMMENT '公司性质',
  `position` varchar(50) DEFAULT NULL COMMENT '岗位或职位',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `personBorrowerId` bigint(20) DEFAULT NULL COMMENT '借款人ID',
  PRIMARY KEY (`id`),
  KEY `personBorrowerId` (`personBorrowerId`),
  CONSTRAINT `t_jot_borrower_ibfk_1` FOREIGN KEY (`personBorrowerId`) REFERENCES `t_person_borrower` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款人工作情况';

-- ----------------------------
-- Table structure for t_notice_setting
-- ----------------------------
DROP TABLE IF EXISTS `t_notice_setting`;
CREATE TABLE `t_notice_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `isMessage` ENUM('0','1') DEFAULT '1' COMMENT '站内信{"1":"否","0":"是"}',
  `isSms` ENUM('0','1') DEFAULT '0' COMMENT '短信{"1":"否","0":"是"}',
  `isEmail` ENUM('0','1') DEFAULT '0' COMMENT '邮件{"1":"否","0":"是"}',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `lastUpdateTime` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_notice_setting_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知类型设置';

-- ----------------------------
-- Table structure for t_person
-- ----------------------------
DROP TABLE IF EXISTS `t_person`;
CREATE TABLE `t_person` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `realName` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `cardNo` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `cardPath1` varchar(200) DEFAULT NULL COMMENT '身份证正面',
  `cardpath2` varchar(200) DEFAULT NULL COMMENT '身份证背面',
  `sex` ENUM('0','1') DEFAULT '0' COMMENT '性别{"0":"男","1":"女"}',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `birthDate` date DEFAULT NULL COMMENT '出生日期',
  `isAuth` ENUM('0','1','2') DEFAULT '0' COMMENT '是否可用{"0":"未认证","1":"认证成功","2":"认证失败"}',
  `remark` varchar(50) DEFAULT NULL COMMENT '认证失败原因',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_person_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='实名认证';

-- ----------------------------
-- Table structure for t_person_borrower
-- ----------------------------
DROP TABLE IF EXISTS `t_person_borrower`;
CREATE TABLE `t_person_borrower` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `borrowerName` varchar(20) DEFAULT NULL COMMENT '姓名',
  `borrowerIdCard` varchar(30) DEFAULT NULL COMMENT '身份证',
  `borrowerCellPhone` varchar(13) DEFAULT NULL COMMENT '手机号',
  `birthDate` date DEFAULT NULL COMMENT '出生日期',
  `sex` ENUM('1','2') DEFAULT NULL COMMENT '性别{"1":"男","2":"女"}',
  `age` int(3) DEFAULT NULL COMMENT '年龄',
  `maritalStatus` ENUM('0','1','2') DEFAULT '2' COMMENT '婚否{"0":"未婚","1":"已婚","2":"未知"}',
  `childrenStatus` ENUM('0','1','2') DEFAULT '2' COMMENT '是否有孩子{"0":"否","1":"是","2":"未知"}',
  `houseRegisteProvince` varchar(30) DEFAULT NULL COMMENT '户籍省份',
  `houseRegisteCity` varchar(30) DEFAULT NULL COMMENT '户籍城市',
  `monthlyIncomeLevel` varchar(30) DEFAULT NULL COMMENT '月收入水平',
  `houseStatus` ENUM('0','1','2') DEFAULT '2' COMMENT '是否有房{"0":"否","1":"是","2":"未知"}',
  `carStatus` ENUM('0','1','2') DEFAULT '2' COMMENT '是否有车{"0":"否","1":"是","2":"未知"}',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `borrowmoney` decimal(10,2) DEFAULT '0.00' COMMENT '借款金额',
  `borrowtime` int(10) DEFAULT '0' COMMENT '借款期限（月）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款人信息';

-- ----------------------------
-- Table structure for t_recharge
-- ----------------------------
DROP TABLE IF EXISTS `t_recharge`;
CREATE TABLE `t_recharge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `rechargeAmount` decimal(18,2) DEFAULT '0.00' COMMENT '充值金额',
  `rechargeRealAmount` decimal(18,2) DEFAULT '0.00' COMMENT '到账金额',
  `feeAmount` decimal(18,2) DEFAULT '0.00' COMMENT '充值费用',
  `createTime` datetime DEFAULT NULL COMMENT '充值时间',
  `result` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"失败","1":"成功"}',
  `finishTime` datetime DEFAULT NULL COMMENT '充值完成时间',
  `ordDate` date DEFAULT NULL COMMENT '订单时间',
  `ordId` varchar(50) DEFAULT NULL COMMENT '订单号',
  `thirdOrdId` varchar(50) DEFAULT NULL COMMENT '第三方订单号',
  `bankName` varchar(50) DEFAULT NULL COMMENT '充值银行',
  `bankCard` varchar(50) DEFAULT NULL COMMENT '充值',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  `ip` varchar(18) DEFAULT NULL COMMENT 'IP地址',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_recharge_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值表';

-- ----------------------------
-- Table structure for t_referee_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_referee_relation`;
CREATE TABLE `t_referee_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) DEFAULT NULL COMMENT ' 被推荐人ID',
  `refereeId` bigint(20) DEFAULT NULL COMMENT '推荐人ID(推荐码)',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `couponStatus` ENUM('0','1') DEFAULT '0' COMMENT '奖励给否{"0":"未给","1":"已给"}',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `refereeId` (`refereeId`),
  CONSTRAINT `t_referee_relation_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_referee_relation_ibfk_2` FOREIGN KEY (`refereeId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推荐关系表';

-- ----------------------------
-- Table structure for t_repay
-- ----------------------------
DROP TABLE IF EXISTS `t_repay`;
CREATE TABLE `t_repay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ordId` varchar(50) DEFAULT NULL COMMENT '订单号',
  `investId` bigint(20) DEFAULT NULL COMMENT '投资ID',
  `borrowId` bigint(20) DEFAULT NULL COMMENT '借款ID',
  `investorId` bigint(20) DEFAULT NULL COMMENT '投资人ID',
  `repayDate` date DEFAULT NULL COMMENT '预定还款日期',
  `realRepayTime` datetime DEFAULT NULL COMMENT '实际还款时间',
  `capitalAmount` decimal(18,2) DEFAULT '0.00' COMMENT '应还本金',
  `profitAmount` decimal(18,2) DEFAULT '0.00' COMMENT '应还收益',
  `remainCapitalAmount` decimal(18,2) DEFAULT '0.00' COMMENT '剩余本金',
  `remainProfitAmount` decimal(18,2) DEFAULT '0.00' COMMENT '剩余利息',
  `feeAmount` decimal(18,2) DEFAULT '0.00' COMMENT '居间费用',
  `repayStatus` ENUM('0','1') DEFAULT '0' COMMENT '状态{"0":"未还款","1":"已还款"}',
  `peroids` int(3) DEFAULT '1' COMMENT '总期数',
  `numOfPeriods` int(3) DEFAULT '1' COMMENT '第几期',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `investId` (`investId`),
  KEY `borrowId` (`borrowId`),
  KEY `investorId` (`investorId`),
  CONSTRAINT `t_repay_ibfk_1` FOREIGN KEY (`investId`) REFERENCES `t_invest` (`id`),
  CONSTRAINT `t_repay_ibfk_2` FOREIGN KEY (`borrowId`) REFERENCES `t_borrow` (`id`),
  CONSTRAINT `t_repay_ibfk_3` FOREIGN KEY (`investorId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='还款表';

-- ----------------------------
-- Table structure for t_repay_borrower
-- ----------------------------
DROP TABLE IF EXISTS `t_repay_borrower`;
CREATE TABLE `t_repay_borrower` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `borrowId` bigint(20) DEFAULT NULL COMMENT '借款ID',
  `borrwerId` bigint(20) DEFAULT NULL COMMENT '借款人ID',
  `repayDate` date DEFAULT NULL COMMENT '预定还款日期',
  `realRepayTime` datetime DEFAULT NULL COMMENT '实际还款时间',
  `capitalAmount` decimal(18,2) DEFAULT '0.00' COMMENT '应还本金',
  `profitAmount` decimal(18,2) DEFAULT '0.00' COMMENT '应还收益',
  `remainCapitalAmount` decimal(18,2) DEFAULT '0.00' COMMENT '剩余本金',
  `remainProfitAmount` decimal(18,2) DEFAULT '0.00' COMMENT '剩余利息',
  `repayStatus` ENUM('0','1','2') DEFAULT '0' COMMENT '状态{"0":"未还款","1":"已还款","3":"还款处理中"}',
  `peroids` int(3) DEFAULT '1' COMMENT '总期数',
  `numOfPeriods` int(3) DEFAULT '1' COMMENT '已还期数',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `ordId` varchar(36) DEFAULT NULL COMMENT '订单ID',
  PRIMARY KEY (`id`),
  KEY `borrowId` (`borrowId`),
  KEY `investorId` (`borrwerId`),
  CONSTRAINT `t_repay_borrower_ibfk_2` FOREIGN KEY (`borrowId`) REFERENCES `t_borrow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款人总还款表';

-- ----------------------------
-- Table structure for t_thrid_account
-- ----------------------------
DROP TABLE IF EXISTS `t_thrid_account`;
CREATE TABLE `t_thrid_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `thirdUserId` varchar(30) DEFAULT NULL COMMENT '第三方用户ID',
  `isOpen` ENUM('0','1') DEFAULT '0' COMMENT '是否开通{"1":"已开通","0":"未开通"}',
  `openTime` datetime DEFAULT NULL COMMENT '开通时间',
  `isAccredit` ENUM('0','1','2') DEFAULT '0' COMMENT '是否授权{"0":"未处理","1":"授权成功","2":"授权失败"}',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `t_thrid_account_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='第三方托管账户';

-- ----------------------------
-- Table structure for t_transfer
-- ----------------------------
DROP TABLE IF EXISTS `t_transfer`;
CREATE TABLE `t_transfer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `transOutId` bigint(20) DEFAULT NULL COMMENT '转出者ID',
  `transInId` bigint(20) DEFAULT NULL COMMENT '转入者ID',
  `ordId` varchar(35) DEFAULT NULL COMMENT '订单号',
  `ordDate` date DEFAULT NULL COMMENT '订单时间',
  `transAmount` decimal(18,2) DEFAULT '0.00' COMMENT '转账金额',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `tranStatus` ENUM('1','2','3') DEFAULT '1' COMMENT '状态{"1":"转账中","2","转账成功","3":"转账失败"}',
  `feeAmount` decimal(18,2) DEFAULT '0.00' COMMENT '手续费',
  `remarks` varchar(50) DEFAULT NULL COMMENT '转账备注',
  `statusRemarks` varchar(50) DEFAULT NULL COMMENT '状态备注',
  `seriesNumber` varchar(30) DEFAULT NULL COMMENT '转账序列号(ID或其它序列号)',
  `finishTime` datetime DEFAULT NULL COMMENT '完成时间',
  `transType` varchar(20) DEFAULT NULL COMMENT '转账类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='转账';

-- ----------------------------
-- Table structure for t_withdraw_cash
-- ----------------------------
DROP TABLE IF EXISTS `t_withdraw_cash`;
CREATE TABLE `t_withdraw_cash` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ordId` varchar(50) DEFAULT NULL COMMENT '订单号',
  `ordDate` date DEFAULT NULL COMMENT '订单时间',
  `withdrawAmount` decimal(18,2) DEFAULT NULL COMMENT '提现金额',
  `accountAmount` decimal(18,2) DEFAULT '0.00' COMMENT '到账金额',
  `feeAmount` decimal(18,2) DEFAULT NULL COMMENT '手续费',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `withdrawStatus` ENUM('1','2','3','4') DEFAULT '1' COMMENT '状态{"1":"申请中","2":"处理中","3":"提现成功","4":"提现失败"}',
  `remarks` varchar(80) DEFAULT NULL COMMENT '备注',
  `userId` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `bankCardId` bigint(20) DEFAULT NULL COMMENT '银行卡号',
  `adminId` bigint(20) DEFAULT NULL COMMENT '处理人ID',
  `ip` varchar(18) DEFAULT NULL COMMENT 'IP地址',
  `platformCollect` decimal(18,2) DEFAULT '0.00' COMMENT '平台收取提现手续费',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `bankCardId` (`bankCardId`),
  KEY `adminId` (`adminId`),
  CONSTRAINT `t_withdraw_cash_ibfk_1` FOREIGN KEY (`userId`) REFERENCES t_user (`id`),
  CONSTRAINT `t_withdraw_cash_ibfk_2` FOREIGN KEY (`bankCardId`) REFERENCES `t_bank_card` (`id`),
  CONSTRAINT `t_withdraw_cash_ibfk_3` FOREIGN KEY (`adminId`) REFERENCES t_admin (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='提现金额';

#系统字典表 TODO:缓存
DROP TABLE IF EXISTS t_system_dict;
CREATE TABLE t_system_dict(
  id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  code VARCHAR(64) NOT NULL COMMENT 'key',
value VARCHAR(20480) NOT NULL COMMENT 'value',
description VARCHAR(200) COMMENT '描述',
status ENUM('0','1') DEFAULT '0' NOT NULL COMMENT '状态{"0":"启用","1":"禁用"}',
ctime DATETIME NOT NULL COMMENT '创建时间',
orderNo INT(4) NOT NULL COMMENT '显示顺序'
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

DROP TABLE if EXISTS t_statistics;
CREATE TABLE yiwu.t_statistics(
  id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  name VARCHAR(64) COMMENT '名称',
  sqlString VARCHAR(4096) NOT NULL COMMENT 'SQL脚本',
  columnList VARCHAR(512) NOT NULL COMMENT '显示列',
  description VARCHAR(200) NOT NULL COMMENT '描述',
  cteime DATETIME NOT NULL COMMENT '创建时间'
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='统计定义表';

DROP TABLE if EXISTS t_borrow_type_attach;
CREATE TABLE t_borrow_type_attach(
  id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  borrowerType ENUM('0','1') NOT NULL COMMENT '借款人类型{"0":"个人","1":"企业"}',
  borrowType ENUM('0','1','2','3',',4','5','6') NOT NULL COMMENT '借款类型{"0":"房","1":"车","2":"信用标","3":"其它","4":"银票","5":"保理"}',
  borrowTypeDetail VARCHAR(32) DEFAULT '' COMMENT '借款类型说明',
  attachId bigint(20) NOT NULL COMMENT '附件ID',
  ctime DATETIME NOT NULL COMMENT '创建时间',
  remark VARCHAR(200) COMMENT '备注',
  status ENUM('0','1') DEFAULT '0' NOT NULL COMMENT '状态{"0":"启用","1":"禁用"}',
  CONSTRAINT `t_borrow_type_attach_ibfk_1` FOREIGN KEY (`attachId`) REFERENCES `t_attr_dict` (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='借款类型附件定义表';

DROP TABLE if EXISTS t_verify_record;
CREATE TABLE t_verify_record(
  id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  borrowId bigint(20) NOT NULL COMMENT '借款ID',
  personBorrowerId bigint(20) NOT NULL COMMENT '借款人信息ID',
  firstVerifyId bigint(20) NOT NULL COMMENT '初审人ID',
  firstVerifyIdea VARCHAR(200) COMMENT '初审人意见',
  firstVerifyResult ENUM('0','1','2') NOT NULL DEFAULT '2' COMMENT '初审结果{"0":"通过","1":"不通过","2":"跟进中"}',
  firstVerifyTime DATETIME COMMENT '初审时间',
  repeatVerifyId bigint(20) COMMENT '复审人ID',
  repeatVerifyIdea VARCHAR(200) COMMENT '复审人意见',
  repeatVerifyResult ENUM('0','1','2') COMMENT '复审结果{"0":"通过","1":"不通过","2":"跟进中"}',
  repeatVerifyTime DATETIME COMMENT '复审时间',
  lastVerifyId bigint(20) COMMENT '终审人ID',
  lastVerifyIdea VARCHAR(200) COMMENT '终审人意见',
  lastVerifyResult ENUM('0','1','2') COMMENT '终审结果{"0":"通过","1":"不通过","2":"跟进中"}',
  lastVerifyTime DATETIME COMMENT '终审时间',
  thridId VARCHAR(50) COMMENT '第三方账户ID',
  cardId VARCHAR(32) COMMENT '银行卡号',
  CONSTRAINT `t_verify_record_ibfk_1` FOREIGN KEY (`borrowId`) REFERENCES `t_borrow` (`id`),
  CONSTRAINT `t_verify_record_ibfk_2` FOREIGN KEY (`personBorrowerId`) REFERENCES `t_person_borrower` (`id`),
  CONSTRAINT `t_verify_record_ibfk_3` FOREIGN KEY (`firstVerifyId`) REFERENCES t_admin (`id`),
  CONSTRAINT `t_verify_record_ibfk_4` FOREIGN KEY (`repeatVerifyId`) REFERENCES t_admin (`id`),
  CONSTRAINT `t_verify_record_ibfk_5` FOREIGN KEY (`lastVerifyId`) REFERENCES t_admin (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='审核记录表';

DROP TABLE if EXISTS t_trans_info;
CREATE TABLE t_trans_info(
  id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'ID',
  thridId bigint(20) NOT NULL COMMENT '第三方账号ID',
  bankUser VARCHAR(32) COMMENT '姓名',
  cardId VARCHAR(32) NOT NULL COMMENT '银行卡号',
  transAmount DECIMAL(13,2) NOT NULL COMMENT '交易金额',
  content VARCHAR(2048) COMMENT '报文',
  ctime DATETIME COMMENT '请求时间',
  orderId VARCHAR(50) NOT NULL COMMENT '订单ID或流水号',
  socketType ENUM('0','1') NOT NULL COMMENT '请求类型{"0":"发送","1":"接收"}',
  thridName VARCHAR(32) COMMENT '第三方支付机构名称',
  tradeType VARCHAR(32) NOT NULL COMMENT '交易类型'
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='交易报文记录表';
