/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.5.23 : Database - azyj
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`azyj` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `azyj`;

/*Table structure for table `t_bas_cell` */

CREATE TABLE `t_bas_cell` (
  `cell_id` varchar(32) NOT NULL COMMENT '小区id',
  `cell_name` longtext NOT NULL COMMENT '小区名称',
  `cell_details` varchar(128) DEFAULT NULL COMMENT '小区介绍详情(保存静态文件名)',
  `cell_seq` int(11) NOT NULL COMMENT '社区运营商对店铺排序',
  `province` varchar(6) NOT NULL COMMENT '省',
  `city` varchar(6) NOT NULL COMMENT '市',
  `area` varchar(6) NOT NULL COMMENT '区',
  `longitude` varchar(64) DEFAULT NULL COMMENT '店铺地址经度',
  `latitude` varchar(64) DEFAULT NULL COMMENT '店铺地址纬度',
  `community_id` varchar(32) DEFAULT NULL COMMENT '社区id',
  `inst_area` varchar(32) DEFAULT NULL COMMENT '区县运营商id',
  PRIMARY KEY (`cell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='真实小区表';

/*Data for the table `t_bas_cell` */

LOCK TABLES `t_bas_cell` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_bas_inst_inventory` */

CREATE TABLE `t_bas_inst_inventory` (
  `inst_id` varchar(32) NOT NULL COMMENT '机构ID 机构表t_bas_institution主键 目前库存记录到社区运营商，由市运营商或市总代初始化库存，区县运营商或区县代理商修改社区的库存',
  `pro_id` varchar(32) NOT NULL COMMENT '商品id，商品表主键',
  `num` decimal(10,0) NOT NULL COMMENT '库存数量',
  `warn_num` decimal(10,0) DEFAULT NULL COMMENT '预警数量，如果为空获取机构的预警数量',
  PRIMARY KEY (`inst_id`,`pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构商品库存表';

/*Data for the table `t_bas_inst_inventory` */

LOCK TABLES `t_bas_inst_inventory` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_bas_inst_inventory_journal` */

CREATE TABLE `t_bas_inst_inventory_journal` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `inst_id` varchar(32) NOT NULL COMMENT '库存机构ID',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `flag` char(1) NOT NULL COMMENT '出入库标志；1：进库（+）；2：出库（-）',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  `proc_type` varchar(6) NOT NULL COMMENT '处理类型 1：商品出售减库 2推送商品加库 3修改库存',
  `add_user` varchar(32) DEFAULT NULL COMMENT '添加用户',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构库存流水表';

/*Data for the table `t_bas_inst_inventory_journal` */

LOCK TABLES `t_bas_inst_inventory_journal` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_bas_institution` */

CREATE TABLE `t_bas_institution` (
  `inst_id` varchar(12) NOT NULL COMMENT '机构编号 采用【1平台类型+2位机构类别+5-9位序号（序号从10001开始）】 平台类型(A爱赞商城)',
  `inst_category` char(1) NOT NULL COMMENT '1.公司，2.运营商，3.供应商，4.店铺，5.代理商',
  `inst_type` varchar(2) NOT NULL COMMENT '11.总公司 21.市运营商，22.区县运营商，23.社区运营商 31.总供应商 43.虚拟网店，44.专营店，45.联营店 51.市总代理商，52.区县代理商',
  `inst_name` longtext NOT NULL COMMENT '名称',
  `parent_inst` varchar(32) DEFAULT NULL COMMENT '上级机构',
  `inst_site` varchar(32) DEFAULT NULL COMMENT '站点别名',
  `province` varchar(6) NOT NULL COMMENT '省',
  `city` varchar(6) NOT NULL COMMENT '市',
  `area` varchar(6) NOT NULL COMMENT '区',
  `platform_user_id` varchar(32) DEFAULT NULL COMMENT '平台管理员ID',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `open_status` char(1) DEFAULT NULL COMMENT '开通状态,0未开通,1已开通',
  `open_time` datetime DEFAULT NULL COMMENT '开通时间',
  `contact_user` varchar(32) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `wx` varchar(128) DEFAULT NULL COMMENT '微信',
  `contact_addr` longtext COMMENT '联系地址',
  `zip_code` varchar(6) DEFAULT NULL COMMENT '邮编',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `email` longtext COMMENT '邮件',
  `settle_bank` varchar(32) DEFAULT NULL COMMENT '开户银行',
  `settle_bank_term` varchar(128) DEFAULT NULL COMMENT '支行网点',
  `settle_acc_name` varchar(64) DEFAULT NULL COMMENT '开户名',
  `settle_account` varchar(32) DEFAULT NULL COMMENT '账号',
  `settle_finance_link` varchar(64) DEFAULT NULL COMMENT '财务联系人',
  `settle_finance_tel` varchar(32) DEFAULT NULL COMMENT '财务联系电话',
  `settle_province` varchar(6) DEFAULT NULL COMMENT '开户银行省份',
  `settle_city` varchar(6) DEFAULT NULL COMMENT '开户银行城市',
  `iventory_warn_num` decimal(10,0) DEFAULT NULL COMMENT '机构自己设置的商品预警数量',
  `product_check_open` decimal(6,0) DEFAULT NULL COMMENT '当前机构是否开通商品审核（如果为0表示下级机构添加商品不用本机构审核通过）,0不审核,1审核',
  `settle_flow_fee` decimal(10,0) DEFAULT NULL COMMENT '市运营商流量费比率',
  PRIMARY KEY (`inst_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构表';

/*Data for the table `t_bas_institution` */

LOCK TABLES `t_bas_institution` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_bas_institution_check` */

CREATE TABLE `t_bas_institution_check` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `inst_id` varchar(12) NOT NULL COMMENT '机构编号 采用【1平台类型+2位机构类别+5-9位序号（序号从10001开始）】 平台类型(A爱赞商城)',
  `inst_category` char(1) NOT NULL COMMENT '1.公司，2.运营商，3.供应商，4.店铺，5.代理商',
  `inst_type` varchar(2) NOT NULL COMMENT '11.总公司 21.市运营商，22.区县运营商，23.社区运营商 31.总供应商 43.虚拟网店，44.专营店，45.联营店 51.市总代理商，52.区县代理商',
  `inst_name` longtext NOT NULL COMMENT '名称',
  `parent_inst` varchar(32) DEFAULT NULL COMMENT '上级机构',
  `inst_site` varchar(32) DEFAULT NULL COMMENT '站点别名',
  `province` varchar(6) NOT NULL COMMENT '省',
  `city` varchar(6) NOT NULL COMMENT '市',
  `area` varchar(6) NOT NULL COMMENT '区',
  `platform_user_id` varchar(32) DEFAULT NULL COMMENT '平台管理员ID',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `open_status` char(1) DEFAULT NULL COMMENT '开通状态,0未开通,1已开通',
  `open_time` datetime DEFAULT NULL COMMENT '开通时间',
  `contact_user` varchar(32) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `wx` varchar(128) DEFAULT NULL COMMENT '微信',
  `contact_addr` longtext COMMENT '联系地址',
  `zip_code` varchar(6) DEFAULT NULL COMMENT '邮编',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `email` longtext COMMENT '邮件',
  `settle_bank` varchar(32) DEFAULT NULL COMMENT '开户银行',
  `settle_bank_term` varchar(128) DEFAULT NULL COMMENT '支行网点',
  `settle_acc_name` varchar(64) DEFAULT NULL COMMENT '开户名',
  `settle_account` varchar(32) DEFAULT NULL COMMENT '账号',
  `settle_finance_link` varchar(64) DEFAULT NULL COMMENT '财务联系人',
  `settle_finance_tel` varchar(32) DEFAULT NULL COMMENT '财务联系电话',
  `settle_province` varchar(6) DEFAULT NULL COMMENT '开户银行省份',
  `settle_city` varchar(6) DEFAULT NULL COMMENT '开户银行城市',
  `iventory_warn_num` decimal(10,0) DEFAULT NULL COMMENT '机构自己设置的商品预警数量',
  `product_check_open` varchar(6) DEFAULT NULL COMMENT '当前机构是否开通商品审核（如果为0表示下级机构添加商品不用本机构审核通过）,0不审核,1审核',
  `status` varchar(6) DEFAULT NULL COMMENT '处理状态 0未处理 1已处理（已成为历史记录）',
  `check_inst` varchar(32) DEFAULT NULL COMMENT '初审机构ID',
  `check_status` char(1) DEFAULT NULL COMMENT '初审状态,0待提交,1待审核,2审核通过,3审核不通过',
  `check_time` datetime DEFAULT NULL COMMENT '初审时间',
  `check_memo` longtext COMMENT '初审意见',
  `recheck_inst` varchar(32) DEFAULT NULL COMMENT '复审机构ID',
  `recheck_status` char(1) DEFAULT NULL COMMENT '复审状态,1待审核,2审核通过,3审核不通过',
  `recheck_time` datetime DEFAULT NULL COMMENT '复审时间',
  `recheck_memo` longtext COMMENT '复审意见',
  `settle_flow_fee` decimal(10,0) DEFAULT NULL COMMENT '市流量费比率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构审核表';

/*Data for the table `t_bas_institution_check` */

LOCK TABLES `t_bas_institution_check` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_decorate_ad` */

CREATE TABLE `t_decorate_ad` (
  `ad_id` varchar(32) NOT NULL COMMENT '广告ID',
  `inst_id` varchar(32) NOT NULL COMMENT '机构ID',
  `position_id` varchar(32) NOT NULL COMMENT '位置',
  `title` longtext COMMENT '标题',
  `link_url` longtext COMMENT '链接地址',
  `memo` longtext COMMENT '描述',
  `seq` int(11) DEFAULT NULL COMMENT 'seq',
  `ad_type` char(1) DEFAULT NULL COMMENT '0图片，2,flash 3-商品',
  `ad_content` varchar(32) DEFAULT NULL COMMENT '根据类型不同而不同：类型为商品则为店铺商品ID,如果是图片或flash为图片或文件路径',
  `check_status` char(1) DEFAULT NULL COMMENT '审核状态,0待提交,1待审核,2审核通过,3审核不通过  （前期可以考虑直接审核通过）',
  `check_time` datetime DEFAULT NULL COMMENT '审核时间',
  `check_operator` varchar(32) DEFAULT NULL COMMENT '审核操作员',
  `check_memo` longtext COMMENT '审核意见',
  `line_status` char(1) DEFAULT NULL COMMENT '上下线状态1上线0下线',
  `check_commit_time` datetime DEFAULT NULL COMMENT '提交审核时间',
  PRIMARY KEY (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告表';

/*Data for the table `t_decorate_ad` */

LOCK TABLES `t_decorate_ad` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_decorate_ad_position` */

CREATE TABLE `t_decorate_ad_position` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `position_id` varchar(128) NOT NULL COMMENT '广告位置编号,页面引用的值',
  `position_name` varchar(128) NOT NULL COMMENT '位置名称',
  `pic` varchar(128) NOT NULL COMMENT '广告位置示意图片',
  `num` int(11) NOT NULL COMMENT '数量',
  `seq` int(11) NOT NULL COMMENT '排序',
  `memo` longtext COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告位置表';

/*Data for the table `t_decorate_ad_position` */

LOCK TABLES `t_decorate_ad_position` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_decorate_banner` */

CREATE TABLE `t_decorate_banner` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `group_name` varchar(128) DEFAULT NULL COMMENT '导航组名',
  `name` varchar(64) DEFAULT NULL COMMENT '导航名称',
  `url` varchar(256) DEFAULT NULL COMMENT '导航地址',
  `seq` int(11) DEFAULT NULL COMMENT '序号',
  `site_id` varchar(32) DEFAULT NULL COMMENT '站点ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点和店铺导航配置（装修表）';

/*Data for the table `t_decorate_banner` */

LOCK TABLES `t_decorate_banner` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_attribute` */

CREATE TABLE `t_hom_attribute` (
  `att_id` varchar(4) NOT NULL COMMENT '属性ID',
  `group_id` varchar(4) NOT NULL COMMENT '属性类型,关联T_HOM_ATTRIBUTE_GROUP',
  `att_name` varchar(64) NOT NULL COMMENT '属性名称',
  `pic` varchar(64) DEFAULT NULL COMMENT '属性图片,LOGO等',
  `seq` int(11) NOT NULL COMMENT '排序',
  `status` char(1) DEFAULT NULL COMMENT '审核状态0未审核，1已审核  系统添加默认值是1 店铺默认值是0，公司审核后变为1',
  PRIMARY KEY (`att_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品属性表';

/*Data for the table `t_hom_attribute` */

LOCK TABLES `t_hom_attribute` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_attribute_group` */

CREATE TABLE `t_hom_attribute_group` (
  `group_id` varchar(4) NOT NULL COMMENT '属性组ID',
  `group_name` varchar(64) NOT NULL COMMENT '属性组名称',
  `required` char(1) NOT NULL COMMENT '后台商品录入时验证,0非必须,1必须',
  `search` char(1) NOT NULL COMMENT '前台商品列表条件查询 0不做筛选 1做筛选',
  `spec` char(1) DEFAULT NULL COMMENT '0不是规格 1是规格  （目前本项目忽略改字段）',
  `input_type` char(1) NOT NULL COMMENT '值类型 0单选 1多选  2输入',
  `add_inst` varchar(32) DEFAULT NULL COMMENT '系统添加为null,如果是店铺添加则为店铺ＩＤ',
  `status` char(1) DEFAULT NULL COMMENT '审核状态0未审核，1已审核  系统添加默认值是1 店铺默认值是0，公司审核后变为1',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='属性分组表';

/*Data for the table `t_hom_attribute_group` */

LOCK TABLES `t_hom_attribute_group` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_brand` */

CREATE TABLE `t_hom_brand` (
  `brand_id` varchar(4) NOT NULL COMMENT '品牌编号:主键；对应于“商品属性表[T_FEA_ATTRIBUTE]”的“属性ID”',
  `brand_name` varchar(64) NOT NULL COMMENT '品牌名称:',
  `brand_tag` varchar(64) DEFAULT NULL COMMENT '品牌标签:用于搜索匹配',
  `brand_pic` longtext COMMENT '品牌Logo保存Logo图片的名称',
  `brand_list_pic` longtext NOT NULL COMMENT '品牌图片:用于列表显示；保存图片的名称',
  `brand_intro` longtext COMMENT '品牌介绍:图文结合方式，编辑器编辑(保存静态文件名)',
  `add_time` datetime NOT NULL COMMENT '增加时间',
  `status` char(1) NOT NULL COMMENT '0停用 1正常',
  `seq` int(11) DEFAULT NULL COMMENT '排序',
  `pinyin` varchar(255) DEFAULT NULL COMMENT '多个拼音用json格式 [拼音1,拼音2]',
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='null';

/*Data for the table `t_hom_brand` */

LOCK TABLES `t_hom_brand` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_classify` */

CREATE TABLE `t_hom_classify` (
  `classify_id` varchar(4) NOT NULL COMMENT '分类ID',
  `classify_name` varchar(32) NOT NULL COMMENT '分类名称',
  `parent_id` varchar(4) DEFAULT NULL,
  `classify_level` int(11) NOT NULL COMMENT '分类等级',
  `seq` int(11) NOT NULL COMMENT '排序',
  `status` char(1) NOT NULL COMMENT '状态,1:有效,0:无效',
  `pic` varchar(64) DEFAULT NULL COMMENT '图片',
  `price_range` longtext COMMENT '价格区间json格式，例如[{min:30,max:50},{min:51,max:80}]',
  PRIMARY KEY (`classify_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类表';

/*Data for the table `t_hom_classify` */

LOCK TABLES `t_hom_classify` WRITE;

insert  into `t_hom_classify`(`classify_id`,`classify_name`,`parent_id`,`classify_level`,`seq`,`status`,`pic`,`price_range`) values ('cc','sd','',2,4,'0',NULL,NULL);
insert  into `t_hom_classify`(`classify_id`,`classify_name`,`parent_id`,`classify_level`,`seq`,`status`,`pic`,`price_range`) values ('d30a','ds','cc',3,7,'9',NULL,NULL);
insert  into `t_hom_classify`(`classify_id`,`classify_name`,`parent_id`,`classify_level`,`seq`,`status`,`pic`,`price_range`) values ('dd','ddaaa','ff',3,2,'0',NULL,NULL);
insert  into `t_hom_classify`(`classify_id`,`classify_name`,`parent_id`,`classify_level`,`seq`,`status`,`pic`,`price_range`) values ('ee','pam','ff',3,3,'0',NULL,NULL);
insert  into `t_hom_classify`(`classify_id`,`classify_name`,`parent_id`,`classify_level`,`seq`,`status`,`pic`,`price_range`) values ('f55d','uiee','dd',8,9,'1',NULL,NULL);
insert  into `t_hom_classify`(`classify_id`,`classify_name`,`parent_id`,`classify_level`,`seq`,`status`,`pic`,`price_range`) values ('ff','fna','',2,1,'0',NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `t_hom_classify_attr` */

CREATE TABLE `t_hom_classify_attr` (
  `classify_id` varchar(32) NOT NULL COMMENT '分类ID,关联T_HOM_CLASSIFY',
  `group_id` varchar(32) NOT NULL COMMENT '属性组id',
  `attr_id` varchar(32) NOT NULL COMMENT '属性ID,关联T_HOM_ATTRIBUTE',
  `seq` int(11) NOT NULL COMMENT '排序',
  `add_date` datetime DEFAULT NULL COMMENT '新增时间',
  PRIMARY KEY (`classify_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类同属性关联表';

/*Data for the table `t_hom_classify_attr` */

LOCK TABLES `t_hom_classify_attr` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_classify_attr_group` */

CREATE TABLE `t_hom_classify_attr_group` (
  `classify_id` varchar(4) NOT NULL COMMENT '分类ID,关联T_home_CLASSIFY',
  `group_id` varchar(4) NOT NULL COMMENT '属性类型ID,关联T_HOM_ATTRIBUTE_GROUP',
  `seq` int(11) NOT NULL COMMENT '排序',
  `classify_id_list` varchar(255) DEFAULT NULL COMMENT '格式：[当前分类id,父级分类id,...]分类以及父分类组合，查询一个分类下的属性组时不用递归用like',
  PRIMARY KEY (`classify_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类同属性类别关联表';

/*Data for the table `t_hom_classify_attr_group` */

LOCK TABLES `t_hom_classify_attr_group` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_logistics_template` */

CREATE TABLE `t_hom_logistics_template` (
  `id` varchar(32) NOT NULL,
  `add_time` datetime NOT NULL COMMENT '添加时间',
  `add_inst` varchar(32) NOT NULL COMMENT '添加机构 市可以添加本市的模板，如果店铺没有配置使用市运营商配置的模板',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `template` longtext NOT NULL COMMENT '[{min:0,max:5,price:30},{min:31,max:100000,price:30}...]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物流费用模板';

/*Data for the table `t_hom_logistics_template` */

LOCK TABLES `t_hom_logistics_template` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_pro_same` */

CREATE TABLE `t_hom_pro_same` (
  `shp_pro_id` varchar(32) NOT NULL COMMENT '店铺商品ID',
  `same_id` varchar(32) NOT NULL COMMENT '关联序号',
  `title` varchar(26) NOT NULL COMMENT '标题',
  `tag` varchar(64) NOT NULL COMMENT '标签',
  `seq` int(11) NOT NULL COMMENT '排序',
  `pic` varchar(64) DEFAULT NULL COMMENT '标签图片',
  `shop_id` varchar(32) DEFAULT NULL COMMENT '店铺ID',
  PRIMARY KEY (`shp_pro_id`,`same_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='同商品关联表';

/*Data for the table `t_hom_pro_same` */

LOCK TABLES `t_hom_pro_same` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_pro_store` */

CREATE TABLE `t_hom_pro_store` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `attr` longtext COMMENT '商品规格属性[{group_id:属性组id,attr_id:属性id},...]',
  `unit` varchar(6) DEFAULT NULL COMMENT '商品单位  1：个 2：斤',
  `num` decimal(10,0) DEFAULT NULL COMMENT '库存数量',
  `inst_id` varchar(32) DEFAULT NULL COMMENT '机构',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品库存表';

/*Data for the table `t_hom_pro_store` */

LOCK TABLES `t_hom_pro_store` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_pro_store_journal` */

CREATE TABLE `t_hom_pro_store_journal` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `pro_store_id` varchar(32) NOT NULL COMMENT '库存表ID',
  `num` decimal(10,0) NOT NULL COMMENT '数量',
  `inst_id` varchar(32) NOT NULL COMMENT '机构',
  `add_time` datetime NOT NULL COMMENT '创建时间',
  `num_flag` varchar(6) NOT NULL COMMENT '1库存+  2库存-',
  `proc_type` varchar(6) NOT NULL COMMENT '1购买 2上级加库存 3上级减库存',
  `add_user` varchar(32) NOT NULL COMMENT '添加用户，前后台用户ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品库存流水表';

/*Data for the table `t_hom_pro_store_journal` */

LOCK TABLES `t_hom_pro_store_journal` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_pro_tags` */

CREATE TABLE `t_hom_pro_tags` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `tag_name` varchar(64) NOT NULL COMMENT '标签名称',
  `add_inst` varchar(32) DEFAULT NULL COMMENT '如果为空表示公司添加的，格站点或店铺可以使用但不允许修改',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品标签表';

/*Data for the table `t_hom_pro_tags` */

LOCK TABLES `t_hom_pro_tags` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_product` */

CREATE TABLE `t_hom_product` (
  `pro_id` varchar(32) NOT NULL COMMENT '产品ID',
  `pro_push_type` varchar(6) DEFAULT NULL COMMENT '商品类型，11.总直销推送商品，12.总代理推送商品，21.运营商店铺商品，31.社区店铺商品',
  `pro_sell_type` char(1) DEFAULT NULL COMMENT '商品销售类型，0自销 1代销 2经销 3自销+代销 4自销+经销 5 代销+经销  6自销+代销+经销',
  `pro_code` varchar(126) DEFAULT NULL COMMENT '供应商商品编号',
  `pro_name` longtext NOT NULL COMMENT '商品名称',
  `num` int(11) NOT NULL COMMENT '商品数量',
  `buy_limit` int(11) NOT NULL COMMENT '限购数量,0不限购',
  `pro_area` varchar(64) DEFAULT NULL COMMENT '产地（描述）',
  `classify_id` varchar(32) DEFAULT NULL COMMENT '商品分类ＩＤ',
  `classify_id_list` varchar(255) DEFAULT NULL COMMENT '多级商品分类 json格式[,分类id,分类id],查询该分类的商品时 不用递归用"like ,分类id,"',
  `brand` varchar(32) DEFAULT NULL COMMENT '品牌(固有属性)',
  `tags` longtext COMMENT '标签id 使用,分隔',
  `att_json` longtext COMMENT '[{属性输入类型:XX,属性id:XX,属性值:[属性值1,属性值2]}...]',
  `pro_intro` longtext COMMENT '商品简介',
  `pro_details` varchar(128) DEFAULT NULL COMMENT '商品详情(保存静态文件名)',
  `faq` longtext COMMENT '常见问题',
  `seo_title` longtext COMMENT '页面标题',
  `seo_keyword` longtext COMMENT '页面关键字',
  `seo_description` longtext COMMENT '页面描述',
  `pic` varchar(64) DEFAULT NULL COMMENT '默认图片',
  `pics` longtext COMMENT '商品浏览图片集',
  `add_time` datetime DEFAULT NULL COMMENT '增加时间',
  `sup_price` decimal(12,2) DEFAULT NULL COMMENT '供货价（根据商品类型不同为供应商供货价或店铺代销时的供货价）  其他的总公司供货价，市供货价在推送表中在推送时设置供货价。',
  `max_price` decimal(12,2) DEFAULT NULL COMMENT '最高销售价',
  `min_price` decimal(12,2) NOT NULL COMMENT '最低销售价',
  `price` decimal(12,2) unsigned zerofill NOT NULL COMMENT '默认销售价',
  `market_price` decimal(12,2) DEFAULT NULL COMMENT '市场参考价',
  `check_inst` varchar(32) NOT NULL COMMENT '初审机构ID',
  `check_status` char(1) DEFAULT NULL COMMENT '初审状态,0待提交,1待审核,2审核通过,3审核不通过',
  `check_time` datetime DEFAULT NULL COMMENT '初审时间',
  `check_memo` longtext COMMENT '初审意见',
  `recheck_inst` varchar(32) NOT NULL COMMENT '复审机构ID',
  `recheck_status` char(1) DEFAULT NULL COMMENT '复审状态,0待提交,1待审核,2审核通过,3审核不通过',
  `recheck_time` datetime DEFAULT NULL COMMENT '复审时间',
  `recheck_memo` longtext COMMENT '复审意见',
  `status` char(1) DEFAULT NULL COMMENT '商品状态,0无效,1有效',
  `add_inst` varchar(32) NOT NULL COMMENT '添加机构ID',
  `belong_inst` varchar(32) NOT NULL COMMENT '所属机构ID',
  `order_inst` varchar(32) NOT NULL COMMENT '跟单机构ID',
  `price_unit` varchar(32) DEFAULT NULL COMMENT '商品单位 1件 2千克',
  `to_check_time` datetime DEFAULT NULL COMMENT '提交审核时间',
  `tabs` longtext COMMENT '定义页签[{name:售后说明,file:xXX.html,seq:1},{name:安装说明,file:xXX.html,seq:1}]',
  `remark` longtext COMMENT '产品备注--备忘说明',
  PRIMARY KEY (`pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品表';

/*Data for the table `t_hom_product` */

LOCK TABLES `t_hom_product` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_hom_push` */

CREATE TABLE `t_hom_push` (
  `push_id` varchar(32) NOT NULL COMMENT '推送ID',
  `parent_push_id_list` varchar(255) DEFAULT NULL COMMENT '上级推送ＩＤ集 第一级推送为空　[,上级推送ID1,上级推送ＩＤ2] 避免递归查询',
  `parent_push_level` int(11) NOT NULL COMMENT '第一级推送为0，第二级推送为1... 可以结合上级推送ＩＤ集查询树',
  `parent_push_id` varchar(32) DEFAULT NULL COMMENT '上级推送ID 无上级推送为空',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `add_inst` varchar(32) NOT NULL COMMENT '添加机构ID(记录当前推送机构的ID，例如总公司推送到市则为总公司机构ID)',
  `push_type` char(1) NOT NULL COMMENT '推送类型,1总直销推送，2总代理推送 3.运营商推送,4.店铺推送',
  `push_price_type` char(1) DEFAULT NULL COMMENT '推送价格类型 1统一推送价  2按地区或机构推送价格不同（如果是不同推送价 推送的价格取push_inst的价格）',
  `push_price` decimal(10,0) DEFAULT NULL COMMENT '推送机构的供货价 结算时也用这个值做差价利润 如果push_price_type为1统一推送价格 有值，否则为null',
  `push_obj_type` char(1) NOT NULL COMMENT '推送对象类型,1.地区,2.机构',
  `push_obj` longtext NOT NULL COMMENT '推送对象 如果推送对象为地区则inst_id为空，如果推送对象是机构则area为空 json [{area_id:城市ID,inst_id:机构ID,num:库存数量,price:推送价格},...]',
  `status` char(1) NOT NULL COMMENT '状态(0.无效,1.有效)',
  `push_time` datetime NOT NULL COMMENT '推送时间',
  `batch_ver` int(11) DEFAULT NULL COMMENT '批量更新版本号 和店铺商品表保持一致，防止批量推送有问题 可以回滚',
  PRIMARY KEY (`push_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品推送表（可代卖商品库）';

/*Data for the table `t_hom_push` */

LOCK TABLES `t_hom_push` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_inf_friendly_link` */

CREATE TABLE `t_inf_friendly_link` (
  `link_id` varchar(32) NOT NULL COMMENT '主键',
  `link_url` longtext NOT NULL COMMENT '链接地址',
  `title` varchar(64) NOT NULL COMMENT '标题',
  `logo` varchar(64) DEFAULT NULL COMMENT 'LOGO',
  `seq` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情链接表';

/*Data for the table `t_inf_friendly_link` */

LOCK TABLES `t_inf_friendly_link` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_inf_message_site` */

CREATE TABLE `t_inf_message_site` (
  `message_id` varchar(32) NOT NULL COMMENT '主键',
  `inst_id` varchar(32) NOT NULL COMMENT '机构ID',
  `title` varchar(64) NOT NULL COMMENT '资讯标题',
  `user_id` varchar(32) NOT NULL COMMENT '发布人',
  `pub_time` datetime NOT NULL COMMENT '发布时间',
  `content` longtext NOT NULL COMMENT '资讯内容',
  `type` char(1) DEFAULT NULL COMMENT '资讯类型 根据UI判断可以参考公共树或者数据字典',
  `status` char(1) NOT NULL COMMENT '状态，0无效，1有效',
  `show_flag` char(1) NOT NULL COMMENT '首页展示标志:0显示（默认）、1不显示',
  `top_flag` char(1) NOT NULL COMMENT '置顶标志:0普通（默认）、1置顶',
  `msg_pic` varchar(128) DEFAULT NULL COMMENT '资讯图片文件名',
  `msg_keyword` longtext COMMENT '资讯检索关键字',
  `praise_count` int(11) DEFAULT NULL COMMENT '赞个数',
  `click_count` int(11) DEFAULT NULL COMMENT '点击数',
  `subject` longtext COMMENT '摘要',
  `seo_title` longtext NOT NULL COMMENT 'seo标题',
  `seo_keys` longtext NOT NULL COMMENT 'seo关键字',
  `seo_desc` longtext NOT NULL COMMENT 'seo描述',
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点新闻资讯';

/*Data for the table `t_inf_message_site` */

LOCK TABLES `t_inf_message_site` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_man_menu` */

CREATE TABLE `t_man_menu` (
  `menu_id` varchar(64) NOT NULL COMMENT '单菜id',
  `name` varchar(64) NOT NULL COMMENT '单菜名称',
  `url` longtext COMMENT '菜单地址',
  `parent` varchar(64) NOT NULL COMMENT '上级id',
  `menu_level` int(11) NOT NULL COMMENT '次级',
  `operation_security` char(1) NOT NULL COMMENT '是否需要操作授权（0不需要（默认），1需要）',
  `seq` int(11) NOT NULL COMMENT '顺序号',
  `pic` varchar(128) DEFAULT NULL COMMENT '菜单图片',
  `trade_id_list` longtext COMMENT '交易ID集合，以逗号分隔',
  `platform` varchar(3) NOT NULL COMMENT '平台',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

/*Data for the table `t_man_menu` */

LOCK TABLES `t_man_menu` WRITE;

insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('BASICINFO','基本信息',NULL,'ROOT',1,'1',4,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('DAYEND','日终','','ROOT',1,'1',5,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('INIT_DB_CACHE','刷新缓存','/manager/system/cache/refresh.html','SYSTEM_MANAGER',2,'1',5,'icon-10.gif',NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('MANAGER_USER','操作员管理',NULL,'ROOT',1,'1',98,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('MEMSET','成员结算',NULL,'ROOT',1,'1',1,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('PLATACOUNT','平台账务',NULL,'ROOT',1,'1',2,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('PRODUCT_CLASSIFY','商品分类','/manager/system/classify/list.html?tradeiD=classifyList','PRODUCT_MANAGER',2,'1',1,NULL,'','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('PRODUCT_MANAGER','商品管理','','ROOT',1,'0',1,NULL,'','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('SETREQ','结算请求',NULL,'ROOT',1,'1',3,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('SYSTEM_CODE','数据字典','/manager/system/code/list.html?tradeId=manCodeList','SYSTEM_MANAGER',2,'1',2,NULL,'manCodeList,manCodeAdd,manCodeToUpdate,manCodeUpdate,manCodeDel','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('SYSTEM_MANAGER','系统管理',NULL,'ROOT',1,'1',99,'icon-1.gif   ',NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('SYSTEM_MANAGER_OPER_RECORD','操作流水记录','/manager/system/record/list.html?tradeId=manRecordList','SYSTEM_MANAGER',2,'1',4,'icon-9.gif  ','manRecordList','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('SYSTEM_MANAGER_ROLE','操作员角色','/manager/system/role/list.html?tradeId=manRoleList','MANAGER_USER',2,'1',2,'icon-3.gif   ','manRoleList,manRoleAdd,manRoleInfo,manRoleUpdate,manRoleDel,roleAuth,roleAuthView,roleAuthSave','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('SYSTEM_MANAGER_USER','操作员管理','/manager/system/user/list.html?tradeId=manUserList','MANAGER_USER',2,'1',1,'icon-3.gif','manUserList,manUserAdd,manUserInfo,manUserUpdate,manUserDel,manUserResetPwd,userAuth,userAuthView,userAuthSave,manSonUserList,synUserAuth','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('SYSTEM_MENU','菜单管理','/manager/system/menu/list.html?tradeId=manMenuList','SYSTEM_MANAGER',2,'1',1,'icon-3.gif','manMenuAdd,manMenuList,manMenuInfo,manMenuToUpdate,manMenuUpdate,manMenuDel','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('SYSTEM_PARAMS','系统参数配置','/manager/system/param/list.html?tradeId=manParamList','SYSTEM_MANAGER',2,'1',3,'icon-18.gif   ','manParamList,manParamAdd,manParamToUpdate,manParamUpdate,manParamDel','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('test','test',NULL,'ROOT',99,'1',1,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('test1','test1','/manager/test/list.html?tradeId=instList','test',2,'1',1,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_ERR_MSG','结算错误信息','/manager/dayend/errmsg/list.html?tradeId=errMsgList','DAYEND',2,'0',2,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_HAND_SET','手动结算','/manager/dayend/handset/list.html?tradeId=handSetList','DAYEND',2,'1',3,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_INSTITUTION_MANAGER','机构信息','/manager/baseinfo/inst/list.html?tradeId=instList','BASICINFO',2,'1',2,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_MEM_ALL_ACCOUNT','成员账务总账','/manager/memset/memallaccount/list.html?tradeId=memAllAccountList','MEMSET',2,'0',5,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_MEM_CLEAR','成员清算','/manager/memset/memclear/list.html?tradeId=memClearList','MEMSET',2,'1',3,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_MEM_CLEAR_MONTH','成员清算月统计','/manager/memset/clearmonth/list.html?tradeId=clearMonthList','MEMSET',2,'1',4,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_MEM_FLOW','成员结算流水','/manager/memset/memsetflow/list.html?tradeId=memSetFlowList','MEMSET',2,'1',2,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_PLAT_ALL_ACOUNT','平台账务总账','/manager/plataccount/platallaccount/list.html?tradeId=platAllAccountList','PLATACOUNT',2,'0',3,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_PLAT_DAY_STATIC','平台账务日统计','/manager/plataccount/platdaystatic/list.html?tradeId=platDayStaticList','PLATACOUNT',2,'0',2,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_PLAT_FLOW','平台账务流水','/manager/plataccount/platflow/list.html?tradeId=platFlowList','PLATACOUNT',2,'0',1,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_PLAT_INFO_MANAGER','平台信息','/manager/baseinfo/plat/list.html?tradeId=platList','BASICINFO',2,'1',3,NULL,'platList,platAdd,platDel,platUpdate,platInfo','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_SET_CHECK','结算申请核对','/manager/setreq/setcheck/list.html?tradeId=setCheckList','SETREQ',2,'1',3,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_SET_CHECK_TEMP','录入核对数据','/manager/dayend/setchecktemp/list.html?tradeId=setCheckTempList','DAYEND',2,'1',5,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_SET_FLOW_STATUS','流程状态','/manager/dayend/flowstatus/list.html?tradeId=flowStatusList','DAYEND',2,'1',6,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_SET_REQ','结算请求','/manager/setreq/setreq/list.html?tradeId=setReqList','SETREQ',2,'1',1,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_SET_REQ_HIS','结算请求历史','/manager/setreq/setreqhis/list.html?tradeId=setReqHisList','SETREQ',2,'1',2,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_SET_REQ_TEMP','录入请求数据','/manager/dayend/setreqtemp/list.html?tradeId=setReqTempList','DAYEND',2,'1',4,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_SET_SPLIT','结算分成','/manager/memset/setsplit/list.html?tradeId=setSplitList','MEMSET',2,'1',1,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_SET_TRACE','结算日志','/manager/dayend/settrace/list.html?tradeId=setTraceList','DAYEND',2,'1',1,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_TRAN_CODE_MANAGER','交易码','/manager/baseinfo/trancode/list.html?tradeId=tranCodeList','BASICINFO',2,'1',4,NULL,NULL,'MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_USER_MANAGER','人员信息','/manager/baseinfo/user/list.html?tradeId=userList','BASICINFO',2,'1',1,NULL,'userList,userInfo','MAN');
insert  into `t_man_menu`(`menu_id`,`name`,`url`,`parent`,`menu_level`,`operation_security`,`seq`,`pic`,`trade_id_list`,`platform`) values ('T_USER_PLAT_RELATION','用户平台权限','/manager/baseinfo/userplatrelation/list.html?tradeId=userPlatRelationList','BASICINFO',2,'1',5,NULL,NULL,'MAN');

UNLOCK TABLES;

/*Table structure for table `t_man_oper_record` */

CREATE TABLE `t_man_oper_record` (
  `seq_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `oper_id` varchar(64) NOT NULL COMMENT '交易ID',
  `relation_id` varchar(128) NOT NULL COMMENT '关联ID',
  `oper_time` datetime NOT NULL COMMENT '操作时间',
  `oper_desc` longtext NOT NULL COMMENT '操作描述',
  `oper_user_id` varchar(32) NOT NULL COMMENT '操作人ID',
  `oper_user_name` varchar(64) NOT NULL COMMENT '操作人姓名',
  `oper_table` longtext NOT NULL COMMENT '操作表',
  `platform` varchar(3) DEFAULT NULL COMMENT '平台',
  `inst_id` varchar(32) DEFAULT NULL COMMENT '机构',
  PRIMARY KEY (`seq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1363 DEFAULT CHARSET=utf8 COMMENT='后台操作日志表';

/*Data for the table `t_man_oper_record` */

LOCK TABLES `t_man_oper_record` WRITE;

insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1,'manLogin','admin','2014-05-20 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (2,'manLogout','admin','2014-05-20 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (3,'manLogin','admin','2014-05-20 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (4,'manLogout','admin','2014-05-20 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (5,'manLogin','admin','2014-05-20 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (21,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (22,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (23,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (24,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (41,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (42,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (43,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (44,'userAdd','aaaa;adffdsd','2014-05-21 00:00:00','新增人员信息,用户ID:aaaa,平台:adffdsd,用户姓名:dsffdsf,密码:ddsfdfs,邮箱:dfsfdfd,邮箱认证:,联系电话:dsffdsdsf,手机号码:3443234234,身份证:sfdsfdfs,注册时间:$sysTime,性别:,QQ号码:wewqewqewe,手机认证:,省:dsdsf,市:fdsfs,区:sdffs','admin','超级管理员','T_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (45,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (61,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (62,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (63,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (64,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (65,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (66,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (67,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (68,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (69,'manLogin','admin','2014-05-21 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (81,'manLogin','admin','2014-05-23 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (101,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (102,'manCodeAdd','IDENTIFY_FLAG;0','2014-05-26 00:00:00','新增数据字典,代码类型:IDENTIFY_FLAG,代码ID:0,代码名称:未认证,显示顺序:1,备注:认证类型','admin','超级管理员','T_PUB_SYSTEM_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (103,'manCodeUpdate','IDENTIFY_FLAG;0','2014-05-26 00:00:00','修改数据字典,代码类型:IDENTIFY_FLAG,代码ID:0,代码名称:未认证,显示顺序:1,备注:null','admin','超级管理员','T_PUB_SYSTEM_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (104,'manCodeAdd','IDENTIFY_FLAG;1','2014-05-26 00:00:00','新增数据字典,代码类型:IDENTIFY_FLAG,代码ID:1,代码名称:已认证,显示顺序:2,备注:认证类型','admin','超级管理员','T_PUB_SYSTEM_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (105,'manCodeAdd','SEX_TYPE;0','2014-05-26 00:00:00','新增数据字典,代码类型:SEX_TYPE,代码ID:0,代码名称:保密,显示顺序:1,备注:性别','admin','超级管理员','T_PUB_SYSTEM_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (106,'manCodeAdd','SEX_TYPE;1','2014-05-26 00:00:00','新增数据字典,代码类型:SEX_TYPE,代码ID:1,代码名称:男,显示顺序:2,备注:性别','admin','超级管理员','T_PUB_SYSTEM_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (107,'manCodeAdd','SEX_TYPE;2','2014-05-26 00:00:00','新增数据字典,代码类型:SEX_TYPE,代码ID:2,代码名称:女,显示顺序:3,备注:性别','admin','超级管理员','T_PUB_SYSTEM_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (108,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (121,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (122,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (123,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (124,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (125,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (126,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (127,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (128,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (129,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (130,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (131,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (132,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (133,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (134,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (135,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (136,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (137,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (138,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (139,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (140,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (141,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (142,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (143,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (144,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (145,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (161,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (162,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (163,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (164,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (165,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (166,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (167,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (168,'manLogout','admin','2014-05-26 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (169,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (170,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (171,'manLogin','admin','2014-05-26 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (181,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (201,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (202,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (203,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (204,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (205,'manMenuUpdate','T_PLAT_FLOW','2014-05-27 00:00:00','修改菜单,单菜id:T_PLAT_FLOW,单菜名称:平台账务流水,菜单地址:/manager/plataccount/platflow/list.html?tradeId=platFlowList,父菜单:PLATACOUNT,菜单级别:2,是否需要操作授权:0,顺序号:1,交易集:,平台:null','admin','超级管理员','T_MAN_MENU','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (206,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (207,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (208,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (209,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (210,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (211,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (212,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (213,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (214,'manLogin','admin','2014-05-27 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (221,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (222,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (223,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (224,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (225,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (226,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (227,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (228,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (229,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (230,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (241,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (242,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (243,'manMenuUpdate','T_MEM_ALL_ACCOUNT','2014-05-28 00:00:00','修改菜单,单菜id:T_MEM_ALL_ACCOUNT,单菜名称:成员账务总账,菜单地址:/manager/memset/memallaccount/list.html?tradeId=memAllAcountList,父菜单:MEMSET,菜单级别:2,是否需要操作授权:0,顺序号:5,交易集:,平台:null','admin','超级管理员','T_MAN_MENU','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (244,'manMenuUpdate','T_MEM_ALL_ACCOUNT','2014-05-28 00:00:00','修改菜单,单菜id:T_MEM_ALL_ACCOUNT,单菜名称:成员账务总账,菜单地址:/manager/memset/memallaccount/list.html?tradeId=memAllAcountList,父菜单:MEMSET,菜单级别:2,是否需要操作授权:0,顺序号:5,交易集:,平台:null','admin','超级管理员','T_MAN_MENU','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (245,'manMenuUpdate','T_MEM_ALL_ACCOUNT','2014-05-28 00:00:00','修改菜单,单菜id:T_MEM_ALL_ACCOUNT,单菜名称:成员账务总账,菜单地址:/manager/memset/memallaccount/list.html?tradeId=memAllAccountList,父菜单:MEMSET,菜单级别:2,是否需要操作授权:0,顺序号:5,交易集:,平台:null','admin','超级管理员','T_MAN_MENU','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (246,'manMenuUpdate','T_PLAT_DAY_STATIC','2014-05-28 00:00:00','修改菜单,单菜id:T_PLAT_DAY_STATIC,单菜名称:平台账务日统计,菜单地址:/manager/plataccount/platdaystatic/list.html?tradeId=platDayStaticList,父菜单:PLATACOUNT,菜单级别:2,是否需要操作授权:0,顺序号:2,交易集:,平台:null','admin','超级管理员','T_MAN_MENU','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (247,'manMenuUpdate','T_PLAT_ALL_ACOUNT','2014-05-28 00:00:00','修改菜单,单菜id:T_PLAT_ALL_ACOUNT,单菜名称:平台账务总账,菜单地址:/manager/plataccount/platallaccount/list.html?tradeId=platAllAccountList,父菜单:PLATACOUNT,菜单级别:2,是否需要操作授权:0,顺序号:3,交易集:,平台:null','admin','超级管理员','T_MAN_MENU','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (248,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (249,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (261,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (262,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (263,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (264,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (265,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (266,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (267,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (268,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (269,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (270,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (271,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (272,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (273,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (274,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (275,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (276,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (277,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (278,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (279,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (280,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (281,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (282,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (283,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (284,'manLogout','admin','2014-05-28 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (285,'manLogin','admin','2014-05-28 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (301,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (302,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (303,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (304,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (305,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (306,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (307,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (321,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (341,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (342,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (343,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (361,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (362,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (363,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (364,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (365,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (381,'manLogin','admin','2014-05-29 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (401,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (402,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (403,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (404,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (405,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (406,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (407,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (408,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (409,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (410,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (411,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (421,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (422,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (423,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (424,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (425,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (426,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (427,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (428,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (429,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (430,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (431,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (432,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (433,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (434,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (435,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (436,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (437,'manLogin','admin','2014-05-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (441,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (442,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (443,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (444,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (445,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (446,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (447,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (461,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (462,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (463,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (464,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (465,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (466,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (467,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (468,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (469,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (470,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (471,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (472,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (473,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (474,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (475,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (476,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (477,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (478,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (479,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (480,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (481,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (482,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (483,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (484,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (485,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (486,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (487,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (488,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (489,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (490,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (491,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (501,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (502,'manLogin','admin','2014-06-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (521,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (522,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (523,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (524,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (525,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (526,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (527,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (528,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (529,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (530,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (531,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (532,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (533,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (534,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (535,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (536,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (537,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (538,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (539,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (540,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (541,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (542,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (543,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (544,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (545,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (546,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (547,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (548,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (549,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (550,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (551,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (552,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (553,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (554,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (555,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (561,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (562,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (563,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (564,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (565,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (566,'manMenuUpdate','T_ERR_MSG','2014-06-04 00:00:00','修改菜单,单菜id:T_ERR_MSG,单菜名称:结算错误信息,菜单地址:/manager/dayend/errmsg/list.html?tradeId=errMsgList,父菜单:DAYEND,菜单级别:2,是否需要操作授权:0,顺序号:2,交易集:,平台:null','admin','超级管理员','T_MAN_MENU','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (567,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (581,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (582,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (583,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (584,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (585,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (586,'manLogin','admin','2014-06-04 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (601,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (602,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (603,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (604,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (605,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (606,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (607,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (608,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (609,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (610,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (611,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (612,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (613,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (614,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (615,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (616,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (617,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (618,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (619,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (620,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (621,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (622,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (623,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (624,'manLogin','admin','2014-06-05 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (641,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (642,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (643,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (644,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (645,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (646,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (647,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (648,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (649,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (650,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (651,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (652,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (653,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (654,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (655,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (656,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (657,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (658,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (659,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (660,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (661,'manLogin','admin','2014-06-06 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (681,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (682,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (683,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (684,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (685,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (686,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (687,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (688,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (689,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (690,'manLogin','admin','2014-06-09 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (703,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (704,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (705,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (706,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (707,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (708,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (709,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (710,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (711,'tranCodeUpdate','123','2014-06-10 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd,交易码说明:dfd fgf dg,结算单位列表:123,结算金额列表:123,结算参数列表:123,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (712,'tranCodeUpdate','123','2014-06-10 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd,交易码说明:dfd fgf dg,结算单位列表:123,结算金额列表:123,结算参数列表:123,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (713,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (714,'tranCodeUpdate','123','2014-06-10 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd,交易码说明:dfd fgf dg,结算单位列表:123,结算金额列表:123,结算参数列表:123,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (715,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (716,'manLogin','admin','2014-06-10 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (717,'tranCodeUpdate','123','2014-06-10 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd,交易码说明:dfd fgf dg,结算单位列表:123,结算金额列表:123,结算参数列表:123,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (718,'tranCodeUpdate','123','2014-06-10 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd,交易码说明:dfd fgf dg,结算单位列表:123,结算金额列表:123,结算参数列表:123,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (719,'tranCodeUpdate','123','2014-06-10 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd,交易码说明:dfd fgf dg,结算单位列表:123,结算金额列表:123,结算参数列表:123,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (720,'tranCodeUpdate','123','2014-06-10 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd,交易码说明:dfd fgf dg,结算单位列表:123,结算金额列表:123,结算参数列表:123,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (721,'tranCodeUpdate','123','2014-06-10 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd,交易码说明:dfd fgf dg1,结算单位列表:123,结算金额列表:123,结算参数列表:123,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (722,'tranCodeUpdate','123','2014-06-10 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd1,交易码说明:dfd fgf dg1,结算单位列表:1231,结算金额列表:1231,结算参数列表:1231,交易码分类:2,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (723,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (724,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (725,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (726,'tranCodeUpdate','123','2014-06-11 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd1,交易码说明:dfd fgf dg1,结算单位列表:1231,结算金额列表:1231,结算参数列表:1231,交易码分类:2,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (727,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (728,'tranCodeUpdate','123','2014-06-11 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd1,交易码说明:dfd fgf dg1,结算单位列表:1231,结算金额列表:1231,结算参数列表:1231,交易码分类:2,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (729,'tranCodeUpdate','123','2014-06-11 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd1,交易码说明:dfd fgf dg1,结算单位列表:1231,结算金额列表:1231,结算参数列表:1231,交易码分类:2,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (730,'tranCodeUpdate','123','2014-06-11 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd1,交易码说明:dfd fgf dg1,结算单位列表:1231,结算金额列表:1231,结算参数列表:1231,交易码分类:2,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (731,'tranCodeUpdate','123','2014-06-11 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd1,交易码说明:dfd fgf dg1,结算单位列表:1231,结算金额列表:1231,结算参数列表:1231,交易码分类:2,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (732,'tranCodeUpdate','123','2014-06-11 00:00:00','修改交易码,交易码:123,交易码名称:fdsfd1,交易码说明:dfd fgf dg1,结算单位列表:1231,结算金额列表:1231,结算参数列表:1231,交易码分类:2,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (733,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (734,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (735,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (736,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (738,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (739,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (741,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (742,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (743,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (745,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (746,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (747,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (751,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (752,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (753,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (754,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (755,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (756,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (757,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (758,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (759,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (760,'manLogin','admin','2014-06-11 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (761,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (762,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (763,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (764,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (765,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (766,'tranCodeUpdate','tran3','2014-06-11 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (781,'manLogin','admin','2014-06-12 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (782,'manLogin','admin','2014-06-12 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (783,'tranCodeUpdate','tran3','2014-06-12 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (784,'tranCodeUpdate','tran3','2014-06-12 00:00:00','修改交易码,交易码:tran3,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (785,'manLogin','admin','2014-06-12 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (786,'tranCodeDel','tran_code=tran5','2014-06-12 00:00:00','删除交易码,tran_code=tran5','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (787,'tranCodeDel','tran_code=tran5','2014-06-12 00:00:00','删除交易码,tran_code=tran5','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (788,'tranCodeDel','tran_code=tran5','2014-06-12 00:00:00','删除交易码,tran_code=tran5','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (789,'tranCodeDel','tran_code=tran5','2014-06-12 00:00:00','删除交易码,tran_code=tran5','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (790,'tranCodeDel','tran_code=tran5','2014-06-12 00:00:00','删除交易码,tran_code=tran5','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (791,'manLogin','admin','2014-06-12 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (792,'tranCodeDel','tran_code=tran5','2014-06-12 00:00:00','删除交易码,tran_code=tran5,tran_code=tran6','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (793,'tranCodeDel','tran_code=123','2014-06-12 00:00:00','删除交易码,tran_code=123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (794,'tranCodeUpdate','tran5','2014-06-12 00:00:00','修改交易码,交易码:tran5,交易码名称:dsdsa,交易码说明:ssa,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT1|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (795,'tranCodeUpdate','tran6','2014-06-12 00:00:00','修改交易码,交易码:tran6,交易码名称:vcv,交易码说明:dfd dfgfd fvgfd,结算单位列表:emt1|emt2,结算金额列表:amt1|amt2,结算参数列表:num1|num2,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (796,'tranCodeDel','tran_code=tran5','2014-06-12 00:00:00','删除交易码,tran_code=tran5','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (798,'tranCodeUpdate','tran7','2014-06-12 00:00:00','修改交易码,交易码:tran7,交易码名称:dfds df,交易码说明:sdfds dfvds,结算单位列表:EMT1|EMT2|EMT3:EMT5|EMT4,结算金额列表:AMT7|AMT2|AMT3|AMT4|AMT5,结算参数列表:NUM1|NUM2|NUM3,交易码分类:1,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (799,'manLogin','admin','2014-06-12 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (802,'manLogin','admin','2014-06-12 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (804,'tranCodeUpdate','tran9','2014-06-12 00:00:00','修改交易码,交易码:tran9,交易码名称:f1,交易码说明:dfdsf,结算单位列表:null,结算金额列表:AMT1|AMT2,结算参数列表:NUM1|NUM2|NUM3,交易码分类:0,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (805,'tranCodeUpdate','tran9','2014-06-12 00:00:00','修改交易码,交易码:tran9,交易码名称:f1,交易码说明:dfdsf,结算单位列表:null,结算金额列表:AMT1|AMT2,结算参数列表:NUM1|NUM2|NUM3,交易码分类:0,平台编码:123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (821,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (822,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (823,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (825,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (826,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (827,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (834,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (835,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (836,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (840,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (841,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (842,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (843,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (844,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (845,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (846,'manLogin','admin','2014-06-13 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (861,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (862,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (863,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (864,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (865,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (866,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (867,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (868,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (869,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (870,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (871,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (872,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (873,'manLogin','admin','2014-06-16 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (881,'manLogin','admin','2014-06-17 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (882,'manLogin','admin','2014-06-17 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (883,'manLogin','admin','2014-06-17 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (884,'manLogin','admin','2014-06-17 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (901,'manLogin','admin','2014-06-18 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (902,'manLogin','admin','2014-06-18 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (903,'tranCodeUpdate','tran6','2014-06-18 00:00:00','修改交易码,交易码:tran6,交易码名称:vcv,交易码说明:dfd dfgfd fvgfd,结算单位列表:emt1|emt2,结算金额列表:amt1|amt2,结算参数列表:num1|num2,交易码分类:1,平台编码:null','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (921,'manLogin','admin','2014-06-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (923,'manLogin','admin','2014-06-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (924,'manLogin','admin','2014-06-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (925,'manLogin','admin','2014-06-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (926,'manLogin','admin','2014-06-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (927,'manLogin','admin','2014-06-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (929,'tranCodeUpdate','tran_fc2','2014-06-30 00:00:00','修改交易码,交易码:tran_fc2,交易码名称:添加结算分成交易码,交易码说明:添加结算分成交易码2,结算单位列表:b1|b2|b3,结算金额列表:a1|a2|a3,结算参数列表:c1|c2|c3,交易码分类:1,平台编码:null','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (930,'manLogin','admin','2014-06-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (931,'manLogin','admin','2014-06-30 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (941,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (942,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (943,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (944,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (945,'manUserAdd','tangf','2014-07-01 00:00:00','新增操作员,用户登录名:tangf,用户姓名:唐峰,登录密码:tangf,岗位:M,部门:MDF,状态:1,用户类型:0,上级用户:admin,机构ID:-*-,机构类型:11,平台类型:MAN,密码修改策略:1','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (946,'manRoleAdd','1404176187519083291921681198','2014-07-01 00:00:00','新增操作员角色,角色ID:1404176187519083291921681198,角色名称:admin,角色描述:管理员,机构类型:11,平台类型:MAN,添加用户ID:admin','admin','超级管理员','T_MAN_ROLE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (947,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (948,'roleAuthSave','1404176187519083291921681198','2014-07-01 00:00:00','操作员角色授权,角色ID:1404176187519083291921681198,权限:ROOT;MEMSET;T_SET_SPLIT;T_MEM_FLOW;T_MEM_CLEAR;T_MEM_CLEAR_MONTH;T_MEM_ALL_ACCOUNT;PLATACOUNT;T_PLAT_FLOW;T_PLAT_DAY_STATIC;T_PLAT_ALL_ACOUNT;SETREQ;T_SET_REQ;T_SET_REQ_HIS;T_SET_CHECK;BASICINFO;T_USER_MANAGER;userList$#_T_USER_MANAGER;userInfo$#_T_USER_MANAGER;T_PLAT_INFO_MANAGER;platList$#_T_PLAT_INFO_MANAGER;platAdd$#_T_PLAT_INFO_MANAGER;platDel$#_T_PLAT_INFO_MANAGER;platUpdate$#_T_PLAT_INFO_MANAGER;platInfo$#_T_PLAT_INFO_MANAGER;T_TRAN_CODE_MANAGER;DAYEND;T_SET_TRACE;T_ERR_MSG;T_HAND_SET;MANAGER_USER;SYSTEM_MANAGER_USER;manUserList$#_SYSTEM_MANAGER_USER;manUserAdd$#_SYSTEM_MANAGER_USER;manUserInfo$#_SYSTEM_MANAGER_USER;manUserUpdate$#_SYSTEM_MANAGER_USER;manUserDel$#_SYSTEM_MANAGER_USER;manUserResetPwd$#_SYSTEM_MANAGER_USER;userAuth$#_SYSTEM_MANAGER_USER;userAuthView$#_SYSTEM_MANAGER_USER;userAuthSave$#_SYSTEM_MANAGER_USER;manSonUserList$#_SYSTEM_MANAGER_USER;synUserAuth$#_SYSTEM_MANAGER_USER;SYSTEM_MANAGER_ROLE;manRoleList$#_SYSTEM_MANAGER_ROLE;manRoleAdd$#_SYSTEM_MANAGER_ROLE;manRoleInfo$#_SYSTEM_MANAGER_ROLE;manRoleUpdate$#_SYSTEM_MANAGER_ROLE;manRoleDel$#_SYSTEM_MANAGER_ROLE;roleAuth$#_SYSTEM_MANAGER_ROLE;roleAuthView$#_SYSTEM_MANAGER_ROLE;roleAuthSave$#_SYSTEM_MANAGER_ROLE;SYSTEM_MANAGER;SYSTEM_MENU;manMenuAdd$#_SYSTEM_MENU;manMenuList$#_SYSTEM_MENU;manMenuInfo$#_SYSTEM_MENU;manMenuToUpdate$#_SYSTEM_MENU;manMenuUpdate$#_SYSTEM_MENU;manMenuDel$#_SYSTEM_MENU;SYSTEM_CODE;manCodeList$#_SYSTEM_CODE;manCodeAdd$#_SYSTEM_CODE;manCodeToUpdate$#_SYSTEM_CODE;manCodeUpdate$#_SYSTEM_CODE;manCodeDel$#_SYSTEM_CODE;SYSTEM_PARAMS;manParamList$#_SYSTEM_PARAMS;manParamAdd$#_SYSTEM_PARAMS;manParamToUpdate$#_SYSTEM_PARAMS;manParamUpdate$#_SYSTEM_PARAMS;manParamDel$#_SYSTEM_PARAMS;SYSTEM_MANAGER_OPER_RECORD;manRecordList$#_SYSTEM_MANAGER_OPER_RECORD;INIT_DB_CACHE','admin','超级管理员','T_MAN_ROLE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (949,'userAuthSave','tangf','2014-07-01 00:00:00','操作员授权,用户ID:tangf,平台编号:MAN,角色ID列表:1404176187519083291921681198','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (950,'manLogout','admin','2014-07-01 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (951,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (952,'manUserResetPwd','tangf','2014-07-01 00:00:00','重置操作员密码,用户ID:tangf,平台类型:MAN,用户类型:0,上级用户:admin,密码修改策略:1','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (953,'manLogout','admin','2014-07-01 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (954,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (955,'manUserResetPwd','tangf','2014-07-01 00:00:00','重置操作员密码,用户ID:tangf,平台类型:MAN,用户类型:0,上级用户:admin,密码修改策略:1','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (956,'manUserResetPwd','tangf','2014-07-01 00:00:00','重置操作员密码,用户ID:tangf,平台类型:MAN,用户类型:0,上级用户:admin,密码修改策略:1','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (957,'manUserResetPwd','tangf','2014-07-01 00:00:00','重置操作员密码,用户ID:tangf,平台类型:MAN,用户类型:0,上级用户:admin,密码修改策略:1','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (958,'manUserResetPwd','tangf','2014-07-01 00:00:00','重置操作员密码,用户ID:tangf,平台类型:MAN,用户类型:0,上级用户:admin,密码修改策略:1','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (959,'manLogout','admin','2014-07-01 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (960,'manLogout','tangf','2014-07-01 00:00:00','管理后台退出,用户ID:tangf','tangf','唐峰','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (961,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (962,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (963,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (964,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (965,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (966,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (968,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (969,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (974,'tranCodeUpdate','SetPay','2014-07-01 00:00:00','修改交易码,交易码:SetPay,交易码名称:商品订单,交易码说明:XXX,结算单位列表:z|a|F,结算金额列表:A1|A2|C3,结算参数列表:r|v|b,交易码分类:1,平台编码:null','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (975,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (976,'tranCodeDel','tran_code=SetPay','2014-07-01 00:00:00','删除交易码,tran_code=SetPay','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (977,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (978,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (979,'platAdd','768','2014-07-01 00:00:00','新增平台信息,平台ID:768,平台名称:gfd,备注:fgfgf,过程控制参数:,增加时间:2014-07-01 19:15:56','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (983,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (984,'manLogout','admin','2014-07-01 00:00:00','管理后台退出,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (985,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1004,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1005,'platAdd','afsdf','2014-07-01 00:00:00','新增平台信息,平台ID:afsdf,平台名称:asdfasf,备注:asdf,过程控制参数:,增加时间:','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1022,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1027,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1028,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1043,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1052,'tranCodeUpdate','SetPay','2014-07-01 00:00:00','修改交易码,交易码:SetPay,交易码名称:订单商品,交易码说明:勿用,结算单位列表:b1|b2|b3,结算金额列表:a1|a2|a3,结算参数列表:c1|c2|c3,交易码分类:1,平台编码:null','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1054,'tranCodeUpdate','SetPay','2014-07-01 00:00:00','修改交易码,交易码:SetPay,交易码名称:订单商品,交易码说明:测试用勿删除,结算单位列表:b1|b2|b3,结算金额列表:a1|a2|a3,结算参数列表:c1|c2|c3,交易码分类:1,平台编码:null','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1059,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1066,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1081,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1082,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1083,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1084,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1085,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1087,'tranCodeUpdate','SetPay','2014-07-01 00:00:00','修改交易码,交易码:SetPay,交易码名称:订单商品,交易码说明:测试用勿删除,结算单位列表:b1|b2|b3,结算金额列表:a1|a2|a3,结算参数列表:c1|c2|c3,交易码分类:1,平台编码:null','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1088,'tranCodeUpdate','SetPay','2014-07-01 00:00:00','修改交易码,交易码:SetPay,交易码名称:订单商品,交易码说明:测试用勿删除,结算单位列表:b1|b2|b3,结算金额列表:a1|a2|a3,结算参数列表:c1|c2|c3,交易码分类:1,平台编码:null','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1089,'tranCodeUpdate','SetPay','2014-07-01 00:00:00','修改交易码,交易码:SetPay,交易码名称:订单商品,交易码说明:测试用勿删除,结算单位列表:b1|b2|b3,结算金额列表:a1|a2|a3,结算参数列表:c1|c2|c3,交易码分类:1,平台编码:null','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1101,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1102,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1104,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1105,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1106,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1108,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1111,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1112,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1113,'manLogin','admin','2014-07-01 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1121,'manLogin','admin','2014-07-02 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1161,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1162,'tranCodeUpdate','SetPay','2014-07-03 00:00:00','修改交易码,交易码:SetPay,交易码名称:订单商品,交易码说明:测试用勿删除,结算单位列表:b1|b2|b3,结算金额列表:a1|a2|a3,结算参数列表:c1|c2|c3,交易码分类:1,平台编码:null','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1181,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1182,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1183,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1184,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1186,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1187,'platAdd','ddd','2014-07-03 00:00:00','新增平台信息,平台ID:ddd,平台名称:ddd,备注:ddd,过程控制参数:,增加时间:2014-07-03 16:56:12','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1201,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1202,'platDel','plat_id=ddd','2014-07-03 00:00:00','删除平台信息,plat_id=ddd','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1203,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1204,'platAdd','1234','2014-07-03 00:00:00','新增平台信息,平台ID:1234,平台名称:3432,备注:23,过程控制参数:,增加时间:2014-07-04 01:15:26','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1205,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1206,'platDel','plat_id=1234','2014-07-03 00:00:00','删除平台信息,plat_id=1234','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1207,'platAdd','3434','2014-07-03 00:00:00','新增平台信息,平台ID:3434,平台名称:3243,备注:34,过程控制参数:,增加时间:2014-07-04 01:18:38','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1208,'platDel','plat_id=3434','2014-07-03 00:00:00','删除平台信息,plat_id=3434','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1209,'platAdd','dfds','2014-07-03 00:00:00','新增平台信息,平台ID:dfds,平台名称:fdgd,备注:dsfds,过程控制参数:,增加时间:2014-07-04 01:21:02','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1210,'platDel','plat_id=dfds','2014-07-03 00:00:00','删除平台信息,plat_id=dfds','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1211,'platAdd','ddd','2014-07-03 00:00:00','新增平台信息,平台ID:ddd,平台名称:dddd,备注:ddd,过程控制参数:,增加时间:2014-07-03 17:21:11','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1212,'platDel','plat_id=ddd','2014-07-03 00:00:00','删除平台信息,plat_id=ddd','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1213,'platAdd','gg','2014-07-03 00:00:00','新增平台信息,平台ID:gg,平台名称:ggg,备注:ggg,过程控制参数:,增加时间:2014-07-03 17:23:18','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1214,'platAdd','fff','2014-07-03 00:00:00','新增平台信息,平台ID:fff,平台名称:fff,备注:fff,过程控制参数:,增加时间:2014-07-03 17:25:44','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1215,'manLogin','admin','2014-07-03 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1221,'manLogin','admin','2014-07-07 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1222,'platAdd','fdsf','2014-07-07 00:00:00','新增平台信息,平台ID:fdsf,平台名称:dsf,备注:dsfsd,过程控制参数:,增加时间:2014-07-07 17:51:02','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1223,'platDel','plat_id=fdsf','2014-07-07 00:00:00','删除平台信息,plat_id=fdsf','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1224,'platAdd','sd','2014-07-07 00:00:00','新增平台信息,平台ID:sd,平台名称:sad,备注:sd,过程控制参数:,增加时间:2014-07-07 17:51:59','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1226,'tranCodeDel','tran_code=sdas','2014-07-07 00:00:00','删除交易码,tran_code=sdas','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1227,'platDel','plat_id=sd','2014-07-07 00:00:00','删除平台信息,plat_id=sd','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1228,'platAdd','sd','2014-07-07 00:00:00','新增平台信息,平台ID:sd,平台名称:asd,备注:asd,过程控制参数:,增加时间:2014-07-07 17:54:21','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1229,'platDel','plat_id=sd','2014-07-07 00:00:00','删除平台信息,plat_id=sd','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1230,'platAdd','sdsa','2014-07-07 00:00:00','新增平台信息,平台ID:sdsa,平台名称:sad,备注:sad,过程控制参数:,增加时间:2014-07-07 17:55:11','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1232,'platAdd','cxzc','2014-07-07 00:00:00','新增平台信息,平台ID:cxzc,平台名称:xzc,备注:zxc,过程控制参数:,增加时间:2014-07-07 18:06:30','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1233,'manLogin','admin','2014-07-07 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1234,'manLogin','admin','2014-07-07 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1241,'manLogin','admin','2014-07-07 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1242,'manLogin','admin','2014-07-07 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1243,'manLogin','admin','2014-07-07 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1261,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1262,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1263,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1264,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1265,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1266,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1268,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1270,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1271,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1272,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1273,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1274,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1275,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1276,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1277,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1282,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1283,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1301,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1302,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1303,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1304,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1305,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1306,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1307,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1308,'tranCodeDel','tran_code=123','2014-07-08 00:00:00','删除交易码,tran_code=123','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1309,'tranCodeDel','tran_code=dfd','2014-07-08 00:00:00','删除交易码,tran_code=dfd','admin','超级管理员','T_TRAN_CODE','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1310,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1311,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1312,'manLogin','admin','2014-07-08 00:00:00','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1313,'classifyUpdate','dd','2015-02-13 11:45:28','修改商品分类表,分类ID:dd','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1314,'classifyUpdate','ee','2015-02-13 11:49:48','修改商品分类表,分类ID:ee','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1315,'manLogin','admin','2015-02-13 13:35:24','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1316,'manLogin','admin','2015-02-13 13:36:35','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1317,'manLogin','admin','2015-02-13 13:37:38','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1318,'manLogin','admin','2015-02-13 14:33:13','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1319,'manLogin','admin','2015-02-13 15:03:16','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1320,'manLogin','admin','2015-02-13 15:17:05','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1321,'manLogin','admin','2015-02-13 15:17:57','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1322,'manLogin','admin','2015-02-13 15:25:17','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1323,'manLogin','admin','2015-02-13 15:30:58','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1324,'manLogin','admin','2015-02-13 16:02:10','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1325,'manLogin','admin','2015-02-13 16:04:40','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1326,'manLogin','admin','2015-02-13 17:02:10','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1327,'manLogin','admin','2015-02-13 17:03:23','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1328,'manLogin','admin','2015-02-13 17:12:12','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1329,'manLogin','admin','2015-02-13 17:13:30','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1330,'manLogin','admin','2015-02-13 18:02:02','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1331,'manLogin','admin','2015-02-13 18:27:08','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1332,'manLogin','admin','2015-02-13 19:07:35','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1333,'platAdd','ii','2015-02-13 19:24:46','新增平台信息,平台ID:ii,平台名称:oo,备注:uu,过程控制参数:null,增加时间:2015-02-27 19:24:26','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1334,'manLogin','admin','2015-02-13 19:30:40','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1335,'platAdd','ddd','2015-02-13 19:34:29','新增平台信息,平台ID:ddd,平台名称:sss,备注:gdf,过程控制参数:null,增加时间:2015-02-13 19:34:24','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1336,'manLogin','admin','2015-02-13 19:48:45','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1337,'classifyUpdate','dd','2015-02-13 19:49:46','修改商品分类表,分类ID:dd','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1338,'classifyUpdate','dd','2015-02-13 19:55:38','修改商品分类表,分类ID:dd','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1339,'manLogin','admin','2015-02-13 20:46:37','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1340,'platAdd','ds','2015-02-13 20:47:15','新增平台信息,平台ID:ds,平台名称:io,备注:kjkh,过程控制参数:null,增加时间:2015-02-13 20:46:53','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1341,'platAdd','jk','2015-02-13 20:51:12','新增平台信息,平台ID:jk,平台名称:8j,备注:8,过程控制参数:null,增加时间:2015-02-13 20:51:01','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1342,'manLogin','admin','2015-02-13 20:51:43','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1343,'platAdd','df','2015-02-13 20:52:23','新增平台信息,平台ID:df,平台名称:sd,备注:a,过程控制参数:null,增加时间:2015-02-13 20:52:05','admin','超级管理员','T_PLAT_INFO','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1344,'classifyAdd','','2015-02-13 21:22:20','新增商品分类表','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1345,'classifyAdd','','2015-02-13 21:23:03','新增商品分类表','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1346,'classifyAdd','','2015-02-13 21:24:55','新增商品分类表','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1347,'manLogin','admin','2015-02-13 21:55:33','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1348,'manLogin','admin','2015-02-13 21:57:39','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1349,'manLogin','admin','2015-02-13 21:57:59','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1350,'manLogin','admin','2015-02-13 21:58:33','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1351,'manLogin','admin','2015-02-13 21:59:53','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1352,'manLogin','admin','2015-02-13 22:00:34','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1353,'manLogin','admin','2015-02-13 22:39:45','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1354,'manLogin','admin','2015-02-13 22:40:52','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1355,'classifyDel','','2015-02-13 22:53:37','删除商品分类表,75e2','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1356,'manLogin','admin','2015-02-13 22:56:54','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1357,'classifyAdd','','2015-02-13 22:57:17','新增商品分类表','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1358,'classifyDel','','2015-02-13 22:57:33','删除商品分类表,ss','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1359,'classifyUpdate','f55d','2015-02-13 22:57:56','修改商品分类表,分类ID:f55d','admin','超级管理员','t_hom_classify','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1360,'manLogin','admin','2015-02-14 13:29:22','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1361,'manLogin','admin','2015-02-14 15:39:39','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');
insert  into `t_man_oper_record`(`seq_id`,`oper_id`,`relation_id`,`oper_time`,`oper_desc`,`oper_user_id`,`oper_user_name`,`oper_table`,`platform`,`inst_id`) values (1362,'manLogin','admin','2015-02-14 15:49:43','管理后台登陆,用户ID:admin','admin','超级管理员','T_MAN_USER','MAN','-*-');

UNLOCK TABLES;

/*Table structure for table `t_man_role` */

CREATE TABLE `t_man_role` (
  `role_id` varchar(32) NOT NULL COMMENT '角色id',
  `role_name` varchar(64) NOT NULL COMMENT '角色名称',
  `role_desc` varchar(128) NOT NULL COMMENT '色角描述',
  `user_id` varchar(32) NOT NULL COMMENT '添加用户ID',
  `inst_type` varchar(2) NOT NULL COMMENT '机构类型',
  `def_role` char(1) NOT NULL COMMENT '是否默认权限,0不是,1是',
  `platform` varchar(32) NOT NULL COMMENT '平台类别，数据字典PUB_PLATFORM',
  `add_time` datetime DEFAULT NULL COMMENT '增加时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色定义表';

/*Data for the table `t_man_role` */

LOCK TABLES `t_man_role` WRITE;

insert  into `t_man_role`(`role_id`,`role_name`,`role_desc`,`user_id`,`inst_type`,`def_role`,`platform`,`add_time`) values ('1404176187519083291921681198','manager','操作员','admin','11','0','MAN','2014-07-01 00:00:00');
insert  into `t_man_role`(`role_id`,`role_name`,`role_desc`,`user_id`,`inst_type`,`def_role`,`platform`,`add_time`) values ('1404807918464016371921681198','xzp2009','操作员-管理员权限','admin','11','0','MAN','2014-07-08 00:00:00');

UNLOCK TABLES;

/*Table structure for table `t_man_role_menu` */

CREATE TABLE `t_man_role_menu` (
  `role_id` varchar(32) NOT NULL COMMENT 't_man_role主键',
  `menu_id` varchar(64) NOT NULL COMMENT 't_man_menu主键',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单关系表';

/*Data for the table `t_man_role_menu` */

LOCK TABLES `t_man_role_menu` WRITE;

insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','BASICINFO');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','DAYEND');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','INIT_DB_CACHE');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','MANAGER_USER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','MEMSET');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','PLATACOUNT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','ROOT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','SETREQ');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','SYSTEM_CODE');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','SYSTEM_MANAGER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','SYSTEM_MANAGER_OPER_RECORD');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','SYSTEM_MANAGER_ROLE');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','SYSTEM_MANAGER_USER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','SYSTEM_MENU');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','SYSTEM_PARAMS');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_ERR_MSG');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_HAND_SET');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_MEM_ALL_ACCOUNT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_MEM_CLEAR');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_MEM_CLEAR_MONTH');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_MEM_FLOW');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_PLAT_ALL_ACOUNT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_PLAT_DAY_STATIC');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_PLAT_FLOW');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_PLAT_INFO_MANAGER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_SET_CHECK');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_SET_REQ');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_SET_REQ_HIS');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_SET_SPLIT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_SET_TRACE');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_TRAN_CODE_MANAGER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404176187519083291921681198','T_USER_MANAGER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','BASICINFO');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','DAYEND');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','INIT_DB_CACHE');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','MANAGER_USER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','MEMSET');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','PLATACOUNT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','ROOT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','SETREQ');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','SYSTEM_CODE');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','SYSTEM_MANAGER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','SYSTEM_MANAGER_OPER_RECORD');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','SYSTEM_MANAGER_ROLE');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','SYSTEM_MANAGER_USER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','SYSTEM_MENU');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','SYSTEM_PARAMS');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_ERR_MSG');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_HAND_SET');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_INSTITUTION_MANAGER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_MEM_ALL_ACCOUNT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_MEM_CLEAR');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_MEM_CLEAR_MONTH');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_MEM_FLOW');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_PLAT_ALL_ACOUNT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_PLAT_DAY_STATIC');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_PLAT_FLOW');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_PLAT_INFO_MANAGER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_SET_CHECK');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_SET_REQ');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_SET_REQ_HIS');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_SET_REQ_TEMP');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_SET_SPLIT');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_SET_TRACE');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_TRAN_CODE_MANAGER');
insert  into `t_man_role_menu`(`role_id`,`menu_id`) values ('1404807918464016371921681198','T_USER_MANAGER');

UNLOCK TABLES;

/*Table structure for table `t_man_role_trade` */

CREATE TABLE `t_man_role_trade` (
  `role_id` varchar(32) NOT NULL COMMENT '角色ID',
  `trade_id` varchar(32) NOT NULL COMMENT '交易ID',
  PRIMARY KEY (`role_id`,`trade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

/*Data for the table `t_man_role_trade` */

LOCK TABLES `t_man_role_trade` WRITE;

insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manCodeAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manCodeDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manCodeList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manCodeToUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manCodeUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manMenuAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manMenuDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manMenuInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manMenuList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manMenuToUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manMenuUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manParamAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manParamDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manParamList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manParamToUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manParamUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manRecordList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manRoleAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manRoleDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manRoleInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manRoleList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manRoleUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manSonUserList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manUserAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manUserDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manUserInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manUserList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manUserResetPwd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','manUserUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','platAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','platDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','platInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','platList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','platUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','roleAuth');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','roleAuthSave');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','roleAuthView');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','synUserAuth');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','userAuth');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','userAuthSave');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','userAuthView');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','userInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404176187519083291921681198','userList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manCodeAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manCodeDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manCodeList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manCodeToUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manCodeUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manMenuAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manMenuDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manMenuInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manMenuList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manMenuToUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manMenuUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manParamAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manParamDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manParamList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manParamToUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manParamUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manRecordList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manRoleAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manRoleDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manRoleInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manRoleList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manRoleUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manSonUserList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manUserAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manUserDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manUserInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manUserList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manUserResetPwd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','manUserUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','platAdd');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','platDel');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','platInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','platList');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','platUpdate');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','roleAuth');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','roleAuthSave');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','roleAuthView');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','synUserAuth');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','userAuth');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','userAuthSave');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','userAuthView');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','userInfo');
insert  into `t_man_role_trade`(`role_id`,`trade_id`) values ('1404807918464016371921681198','userList');

UNLOCK TABLES;

/*Table structure for table `t_man_trade_des` */

CREATE TABLE `t_man_trade_des` (
  `platform` varchar(32) NOT NULL COMMENT '平台编号',
  `trade_id` varchar(64) NOT NULL COMMENT '交易编号',
  `remark` longtext COMMENT '交易描述',
  PRIMARY KEY (`platform`,`trade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易描述表';

/*Data for the table `t_man_trade_des` */

LOCK TABLES `t_man_trade_des` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_man_user` */

CREATE TABLE `t_man_user` (
  `user_id` varchar(32) NOT NULL COMMENT '用户编号(登陆时使用)',
  `user_name` longtext NOT NULL COMMENT '用户姓名',
  `user_password` varchar(64) NOT NULL COMMENT '用户密码',
  `post` varchar(128) DEFAULT NULL COMMENT '岗位',
  `department` varchar(128) DEFAULT NULL COMMENT '部门描述',
  `status` char(1) NOT NULL COMMENT '状态（1正常、0停用）',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `user_type` char(1) NOT NULL COMMENT '0：普通用户1：系统管理员2:机构管理员',
  `login_num` int(11) NOT NULL COMMENT '登陆次数',
  `login_time` datetime DEFAULT NULL COMMENT '登陆时间',
  `parent_id` varchar(32) DEFAULT NULL COMMENT '添加该用户的上级用户',
  `login_err_num` int(11) NOT NULL COMMENT '错误登陆次数',
  `login_err_time` datetime DEFAULT NULL COMMENT '错误登陆时间',
  `inst_id` varchar(32) NOT NULL COMMENT '机构ID',
  `inst_type` varchar(2) NOT NULL COMMENT '机构类型',
  `platform` varchar(32) NOT NULL COMMENT '平台类别，数据字典PUB_PLATFORM',
  `add_time` datetime DEFAULT NULL COMMENT '增加时间',
  `pwd_update_flag` varchar(32) DEFAULT NULL COMMENT '密码修改标志1强制修改、0无需修改（默认）',
  PRIMARY KEY (`user_id`,`platform`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户表';

/*Data for the table `t_man_user` */

LOCK TABLES `t_man_user` WRITE;

insert  into `t_man_user`(`user_id`,`user_name`,`user_password`,`post`,`department`,`status`,`remark`,`user_type`,`login_num`,`login_time`,`parent_id`,`login_err_num`,`login_err_time`,`inst_id`,`inst_type`,`platform`,`add_time`,`pwd_update_flag`) values ('admin','超级管理员','6ED23C14BD62024112D1C9E767DA4C2C30366E395961',NULL,NULL,'1',NULL,'1',1103,'2015-02-14 15:49:43','-*-',0,'2015-02-13 13:35:19','-*-','11','MAN','2014-05-20 00:00:00','0');
insert  into `t_man_user`(`user_id`,`user_name`,`user_password`,`post`,`department`,`status`,`remark`,`user_type`,`login_num`,`login_time`,`parent_id`,`login_err_num`,`login_err_time`,`inst_id`,`inst_type`,`platform`,`add_time`,`pwd_update_flag`) values ('tangf','唐峰','ED866B2CD8453747DA28215B5B40400831424C65757442596166417661593167','M','MDF','1',NULL,'0',2,'2014-07-03 00:00:00','admin',2,'2014-09-29 00:00:00','-*-','11','MAN','2014-07-01 00:00:00','1');

UNLOCK TABLES;

/*Table structure for table `t_man_user_role` */

CREATE TABLE `t_man_user_role` (
  `user_id` varchar(32) NOT NULL COMMENT '用户号',
  `role_id` varchar(32) NOT NULL COMMENT '角色号',
  `platform` varchar(32) NOT NULL COMMENT '平台类别，数据字典PUB_PLATFORM',
  PRIMARY KEY (`user_id`,`role_id`,`platform`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

/*Data for the table `t_man_user_role` */

LOCK TABLES `t_man_user_role` WRITE;

insert  into `t_man_user_role`(`user_id`,`role_id`,`platform`) values ('tangf','1404176187519083291921681198','MAN');

UNLOCK TABLES;

/*Table structure for table `t_mem_cart` */

CREATE TABLE `t_mem_cart` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `add_time` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `user_id` varchar(32) DEFAULT NULL COMMENT 't_mem_user.user_id',
  `cart_cookie_id` varchar(32) DEFAULT NULL COMMENT '如果用户未登录，给客户端返回uuid的cart_cookie_id,查询用户的购物车是car_cookie_id或者user_id',
  `shp_id` varchar(32) DEFAULT NULL COMMENT 't_shp_shop.shp_id',
  `shp_name` varchar(100) DEFAULT NULL COMMENT 't_shp_shop.shp_name',
  `shp_phone` varchar(256) DEFAULT NULL COMMENT '店铺联系电话',
  `shp_pro_id` varchar(32) DEFAULT NULL COMMENT 't_shp_product.shp_pro_id',
  `number` int(8) DEFAULT NULL COMMENT '数量',
  `attr` text COMMENT '属性',
  `price` decimal(12,2) DEFAULT NULL COMMENT '价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物车';

/*Data for the table `t_mem_cart` */

LOCK TABLES `t_mem_cart` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_mem_collect` */

CREATE TABLE `t_mem_collect` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `user_id` varchar(32) DEFAULT NULL COMMENT 'xbm_member.userId',
  `type` varchar(32) DEFAULT NULL COMMENT '收藏类型 0店铺收藏 1商品收藏 3品牌收藏',
  `target` varchar(32) DEFAULT NULL COMMENT '收藏的目标',
  `target_name` varchar(100) DEFAULT NULL COMMENT '收藏目标名称',
  `description` text COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='我的收藏';

/*Data for the table `t_mem_collect` */

LOCK TABLES `t_mem_collect` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_mem_comments` */

CREATE TABLE `t_mem_comments` (
  `comments_id` varchar(32) NOT NULL COMMENT '主键',
  `user_id` varchar(32) NOT NULL COMMENT '点评用户ID',
  `ord_pro_id` varchar(32) DEFAULT NULL COMMENT '订单商品ID',
  `title` varchar(32) NOT NULL COMMENT '点评标题',
  `quality_point` decimal(6,3) NOT NULL COMMENT '质量得分',
  `server_point` decimal(6,3) NOT NULL COMMENT '服务得分',
  `spec_point` decimal(6,3) NOT NULL COMMENT '性价比得分',
  `content` longtext COMMENT '点评内容',
  `comments_time` datetime NOT NULL COMMENT '点评时间',
  `check_status` char(1) NOT NULL COMMENT '状态，0待审核，1审核通过，2审核不通过',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `pro_name` longtext NOT NULL COMMENT '商品名称',
  `order_time` datetime NOT NULL COMMENT '购买时间',
  `check_time` datetime DEFAULT NULL COMMENT '审核时间',
  `logistics_point` decimal(6,3) DEFAULT NULL COMMENT '用户物流评价',
  `install_point` decimal(6,3) DEFAULT NULL COMMENT '用户安装评价',
  `pic` longtext COMMENT '图片,多个用分号隔开',
  `shp_pro_id` varchar(32) DEFAULT NULL COMMENT '店铺商品ID',
  `is_front_back` char(1) DEFAULT NULL COMMENT '前后台点评标识：0、前台点评，1、后台点评',
  PRIMARY KEY (`comments_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户点评表';

/*Data for the table `t_mem_comments` */

LOCK TABLES `t_mem_comments` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_mem_feedback` */

CREATE TABLE `t_mem_feedback` (
  `feedback_id` varchar(32) NOT NULL COMMENT '主键',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `type` char(1) NOT NULL COMMENT '类型(1:投诉,2:建议,0:其他)',
  `content` longtext NOT NULL COMMENT '反馈内容',
  `status` char(1) DEFAULT NULL COMMENT '状态,0:未受理,1:已受理',
  `pic` varchar(64) DEFAULT NULL COMMENT '图片',
  `phone` varchar(64) DEFAULT NULL COMMENT '联系电话',
  `reply` longtext COMMENT '回复',
  `inst_id` varchar(32) DEFAULT NULL COMMENT '投诉机构',
  `reply_time` datetime DEFAULT NULL COMMENT '受理时间',
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户反馈表';

/*Data for the table `t_mem_feedback` */

LOCK TABLES `t_mem_feedback` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_mem_invoice` */

CREATE TABLE `t_mem_invoice` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `add_time` bigint(20) NOT NULL COMMENT '创建时间',
  `user_id` varchar(32) NOT NULL COMMENT '用ID',
  `head_type` varchar(32) DEFAULT NULL COMMENT '目标不用，发票抬头【0：单位，1：个人】',
  `head` varchar(128) NOT NULL COMMENT '单位',
  `content` varchar(500) NOT NULL COMMENT '内容',
  `type` varchar(10) DEFAULT NULL COMMENT '目标不用， 发票类型  1普通发票（纸质）  2普通发票（电子） 3增值税发票',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发票';

/*Data for the table `t_mem_invoice` */

LOCK TABLES `t_mem_invoice` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_mem_notice` */

CREATE TABLE `t_mem_notice` (
  `notice_id` varchar(32) NOT NULL COMMENT '主键',
  `send_user_id` varchar(32) NOT NULL COMMENT '发送用户ID',
  `receive_user_id` longtext COMMENT '接收用户ID,空为所有用户可见,多个用分号隔开',
  `notice_type` char(1) NOT NULL COMMENT '通知类型,1:系统,2:管理员,3:用户',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `content` longtext NOT NULL COMMENT '消息内容',
  `read_status` char(1) NOT NULL COMMENT '阅读状态,0未读,1已读',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站内消息表';

/*Data for the table `t_mem_notice` */

LOCK TABLES `t_mem_notice` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_mem_receipt_addr` */

CREATE TABLE `t_mem_receipt_addr` (
  `addr_id` varchar(32) NOT NULL COMMENT '主键',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `receipt_user` varchar(32) NOT NULL COMMENT '收货人姓名',
  `province` varchar(6) NOT NULL COMMENT '省',
  `city` varchar(6) NOT NULL COMMENT '市',
  `region` varchar(6) DEFAULT NULL COMMENT '区',
  `address` longtext NOT NULL COMMENT '详细地址',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机',
  `postcode` varchar(6) DEFAULT NULL COMMENT '邮编',
  `floor` int(11) DEFAULT NULL COMMENT '楼层（若是平房或地下室，填“1”）',
  `lift` char(1) DEFAULT NULL COMMENT '有无电梯（1:有、0:没有）',
  `best_time` varchar(64) DEFAULT NULL COMMENT '最佳送货时间',
  `type` char(1) NOT NULL COMMENT '1:用户添加2:订单添加',
  `is_default` char(1) DEFAULT NULL COMMENT '是否是默认地址,0.不是,1是',
  `update_date` datetime NOT NULL COMMENT '最后一次修改的时间',
  PRIMARY KEY (`addr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='常用收货地址';

/*Data for the table `t_mem_receipt_addr` */

LOCK TABLES `t_mem_receipt_addr` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_mem_show_order` */

CREATE TABLE `t_mem_show_order` (
  `show_id` varchar(32) NOT NULL COMMENT '主键',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `ord_pro_id` varchar(32) NOT NULL COMMENT '订单商品ID',
  `title` varchar(64) NOT NULL COMMENT '标题',
  `content` longtext COMMENT '内容',
  `pic` longtext NOT NULL COMMENT '图片,多个用分号隔开',
  `show_time` datetime NOT NULL COMMENT '晒单时间',
  `check_status` char(1) NOT NULL COMMENT '审核状态，0待审核，1审核通过，2审核不通过',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `pro_name` longtext NOT NULL COMMENT '商品名称',
  `order_time` datetime NOT NULL COMMENT '购买时间',
  PRIMARY KEY (`show_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户晒单表';

/*Data for the table `t_mem_show_order` */

LOCK TABLES `t_mem_show_order` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_mem_user` */

CREATE TABLE `t_mem_user` (
  `user_id` varchar(32) NOT NULL COMMENT '用户名',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `password` varchar(64) NOT NULL COMMENT '登录密码',
  `user_name` varchar(32) DEFAULT NULL COMMENT '真实名',
  `province` varchar(6) DEFAULT NULL COMMENT '省',
  `city` varchar(6) DEFAULT NULL COMMENT '市',
  `area` varchar(6) DEFAULT NULL COMMENT '区',
  `community` varchar(32) DEFAULT NULL COMMENT '真实小区id',
  `card_id` varchar(32) DEFAULT NULL COMMENT '身份证',
  `birthdate` datetime DEFAULT NULL COMMENT '出生日期',
  `sex` char(1) NOT NULL COMMENT '性别,0:保密,1:男,2:女',
  `email_check_status` char(1) NOT NULL COMMENT '邮箱验证标识,0:未验证,1:已验证',
  `qq` varchar(16) DEFAULT NULL COMMENT 'QQ',
  `msn` varchar(32) DEFAULT NULL COMMENT 'MSN',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机',
  `portrait` varchar(64) DEFAULT NULL COMMENT '头像',
  `status` char(1) NOT NULL COMMENT '状态,0:停用,1:正常',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `login_num` int(11) NOT NULL COMMENT '登录次数',
  `login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `session_id` longtext COMMENT '登录sessionID',
  `login_err_num` int(11) NOT NULL COMMENT '错误登录次数',
  `login_err_time` datetime DEFAULT NULL COMMENT '错误登录时间',
  `level_id` char(1) NOT NULL COMMENT '用户等级',
  `register_ip` varchar(16) DEFAULT NULL COMMENT '注册IP',
  `login_ip` varchar(16) DEFAULT NULL COMMENT '最后登录IP',
  `available_money` decimal(12,2) DEFAULT NULL COMMENT '可提现金额',
  `wx_openid` varchar(64) DEFAULT NULL COMMENT '微信账号，微信绑定账号是修改',
  `pre_card_id` varchar(128) DEFAULT NULL COMMENT '绑定的预付费卡号',
  `full_address` longtext COMMENT '用户详细地址',
  `union_login_way` varchar(64) DEFAULT NULL COMMENT '用户中心联合登录方式(QQ、百度、新浪微博）,多个,号分隔',
  `type` char(1) DEFAULT NULL COMMENT '测试版-0、体验版-1、标准版-2、网页版-9',
  `membership_level` char(1) DEFAULT NULL COMMENT '会员级别：0普通会员1金牌会员2白金会员3钻石会员',
  `golden_bean_number` int(11) DEFAULT NULL COMMENT '金豆数量，默认为0',
  `avail_golden_bean` int(11) DEFAULT NULL COMMENT '可用金豆数，默认为0',
  `frozen_golden_bean` int(11) DEFAULT NULL COMMENT '冻结金豆数，默认为0',
  `members_source` varchar(32) DEFAULT NULL COMMENT '会员来源，如：平台名称',
  `growth_value` varchar(16) DEFAULT NULL COMMENT '成长值,默认0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `t_mem_user` */

LOCK TABLES `t_mem_user` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ord_order` */

CREATE TABLE `t_ord_order` (
  `order_id` varchar(16) NOT NULL COMMENT '订单ID 采用【2位订单前缀+6位日期（yymmdd）+8位序号（序号从100001开始） 10.爱赞商城测试环境，20.爱赞商城生产环境',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `shp_inst` varchar(32) NOT NULL COMMENT '下单店铺ID',
  `order_inst` varchar(32) DEFAULT NULL COMMENT '跟单机构ID【本市配送和退换货审核机构】',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_status` char(1) NOT NULL COMMENT '订单状态：0.未受理,1.受理中,2.已取消,3.已结束.4.已完成',
  `amount` decimal(12,2) NOT NULL COMMENT '订单金额,为商品销售价金额',
  `real_amount` decimal(12,2) DEFAULT NULL COMMENT '实际支付金额',
  `pay_status` char(1) DEFAULT NULL COMMENT '支付状态,1.未付款,2.已付款,3：部分付款',
  `pay_exp_time` datetime DEFAULT NULL COMMENT '支付截至时间，如果为空，则不限制',
  `pay_way` varchar(1) DEFAULT NULL COMMENT '支付方式,1.在线支付,2.线下店铺支付(自销的支付流量费，其他的付全款) 结算平台考虑销售店铺下线支付时结算给该店铺的金额为0',
  `user_pay_way` char(1) DEFAULT NULL COMMENT '用户支付方式,1.在线支付,2货到付款',
  `deliver_status` char(1) DEFAULT NULL COMMENT '0未申请发货，1已申请发货（下单店铺向跟单机构申请发货） 2已发货   对于用户0和1都是未发货，发货申请是针对跟单者',
  `pay_time` datetime DEFAULT NULL COMMENT '支付扣款时间',
  `proc_bean` varchar(128) DEFAULT NULL COMMENT '扣款成功后执行的业务bean',
  `accept_user` varchar(32) DEFAULT NULL COMMENT '受理操作员',
  `accept_time` datetime DEFAULT NULL COMMENT '受理时间',
  `order_type` char(1) NOT NULL COMMENT '订单类型，1普通订单（默认）',
  `pay_id` longtext COMMENT '支付ID',
  `province` varchar(6) DEFAULT NULL COMMENT '省',
  `city` varchar(6) DEFAULT NULL COMMENT '市',
  `area` varchar(6) DEFAULT NULL COMMENT '区',
  `del_flag` char(1) NOT NULL COMMENT '订单删除标记：0.未删除;1.已删除',
  `channel` varchar(6) DEFAULT NULL COMMENT '数据字典T_MOBILE_CHANNEL渠道标志MALL网上商城（默认）、MOBILE手机商城、WECHAT微信商城',
  `remark` longtext COMMENT '订单备注',
  `preferential_amount` decimal(12,2) DEFAULT NULL COMMENT '订单优惠金额',
  `membership_level` char(1) DEFAULT NULL COMMENT '购买该订单会员级别：0普通会员1金牌会员2白金会员3钻石会员',
  `golden_bean_number` int(11) DEFAULT NULL COMMENT '该订单产生的金豆数量，默认为0',
  `growth_value` int(11) DEFAULT NULL COMMENT '该订单产生的成长值,默认0',
  `growth_amount` int(11) DEFAULT NULL COMMENT '该订单使用金豆数量',
  `overplus_growth_amount` int(11) DEFAULT NULL COMMENT '剩余金豆未退数量',
  `edit_comment` longtext COMMENT '备注',
  `logistics_amount` decimal(12,2) DEFAULT NULL COMMENT '物流费',
  `pay_logistics_amount` decimal(12,2) DEFAULT NULL COMMENT '实际物流费',
  `member_amount` decimal(12,2) DEFAULT NULL COMMENT '会员折扣金额',
  `coupon_amount` decimal(12,2) DEFAULT NULL COMMENT '优惠劵优惠金额',
  `promotion_amount` decimal(12,2) DEFAULT NULL COMMENT '促销活动的优惠金额',
  `reduce_amount` decimal(12,2) DEFAULT NULL COMMENT '店铺优惠金额',
  `pay_amount` decimal(12,2) DEFAULT NULL COMMENT '实际支付金额',
  `coupon_ids` varchar(500) DEFAULT NULL COMMENT '优惠劵编号,分割',
  `promotion_ids` varchar(500) DEFAULT NULL COMMENT '促销活动编号,分割',
  `system_order_status` varchar(10) DEFAULT NULL COMMENT '0未支付1待发货2已发货31人工已取消 32系统取消  41人工已完成  42系统完成',
  `receipt_addr_info` text COMMENT '收货地址信息JSON数据',
  `need_invoice` varchar(10) DEFAULT NULL COMMENT '是否需要发票[Y:要,N:不要]',
  `invoice_info` text COMMENT '发票信息JSON数据',
  `deliver_type` varchar(10) DEFAULT NULL COMMENT '配送方式[1:快递,2:自提]',
  `delever_period` varchar(10) DEFAULT NULL COMMENT '配送时段[1:工作日,2:周末,3:工作周末日,4:无限制]',
  ` uy_remark` varchar(500) DEFAULT NULL COMMENT '买家留言',
  `can_settle_status` varchar(10) DEFAULT NULL COMMENT '是否可分佣[0:未分佣,1:可分佣]',
  `send_settle_status` varchar(10) DEFAULT NULL COMMENT '发送分佣状态[0:未发送,1:已发送]',
  `logistics_companyCode` varchar(64) DEFAULT NULL COMMENT '物流公司',
  `logistics_code` varchar(128) DEFAULT NULL COMMENT '物流号',
  `product_count` int(12) DEFAULT NULL COMMENT '订单商品总数',
  `order_real_amount` decimal(12,2) DEFAULT NULL COMMENT '订单商品实际总额',
  `order_sell_amount` decimal(12,2) DEFAULT NULL COMMENT '订单商品单价总额',
  `order_member_amount` decimal(12,2) DEFAULT NULL COMMENT '订单商品会员价总额',
  `order_market_amount` decimal(12,2) DEFAULT NULL COMMENT '订单商品市场价总额',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

/*Data for the table `t_ord_order` */

LOCK TABLES `t_ord_order` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ord_pay` */

CREATE TABLE `t_ord_pay` (
  `pay_id` varchar(32) NOT NULL COMMENT '支付ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `pay_amount` decimal(12,2) NOT NULL COMMENT '支付金额',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  `pay_status` char(1) NOT NULL COMMENT '支付状态：0等待付款，1已付款，2部分退款，3全额退款',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `pay_way` char(1) DEFAULT NULL COMMENT '支付方式：1网银在线支付2红包账户余额支付3金豆支付',
  `pay_bank` varchar(32) DEFAULT NULL COMMENT '支付银行',
  `pay_sign` varchar(128) DEFAULT NULL COMMENT '支付签名',
  `refund_amount` decimal(12,2) NOT NULL COMMENT '累计退款金额',
  `trace_id` varchar(32) DEFAULT NULL COMMENT '支付平台流水号',
  `bank_journal` varchar(32) DEFAULT NULL COMMENT '银行流水号',
  `wx_open_id` varchar(32) DEFAULT NULL COMMENT '微信支付保存OPEN_ID',
  PRIMARY KEY (`pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单支付表';

/*Data for the table `t_ord_pay` */

LOCK TABLES `t_ord_pay` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ord_product` */

CREATE TABLE `t_ord_product` (
  `ord_pro_id` varchar(32) NOT NULL COMMENT '订单商品ＩＤ',
  `order_id` varchar(32) NOT NULL COMMENT '订单ID',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `pro_classify_first` varchar(32) NOT NULL COMMENT '网站商品一级分类',
  `pro_classify_two` varchar(32) NOT NULL COMMENT '网站商品二级分类 结算时根据运营商+二级分类',
  `shp_pro_id` varchar(32) NOT NULL COMMENT '店铺商品表ID',
  `push_id` varchar(32) NOT NULL COMMENT '推送ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `pro_name` longtext NOT NULL COMMENT '商品名称',
  `pro_code` longtext COMMENT '商品编号',
  `num` int(11) NOT NULL COMMENT '商品数量',
  `pro_att` longtext COMMENT '商品可选属性',
  `sale_type` char(1) NOT NULL COMMENT '销售类型1.自销,2.代销',
  `push_type` char(1) NOT NULL COMMENT '11.总直销推送商品，12.总代理推送商品，21.运营商店铺商品，31.社区店铺商品',
  `price` decimal(12,2) NOT NULL COMMENT '销售价，商城价',
  `pay_price` decimal(12,2) DEFAULT NULL COMMENT '实际支付金额',
  `deliver_status` char(1) NOT NULL COMMENT '发货状态：1待处理，2取消发货,3已发货,4确认收货,5拒绝收货',
  `deliver_time` datetime DEFAULT NULL COMMENT '确认收货时间、拒绝收货时间',
  `refund_flag` char(1) NOT NULL COMMENT '退换标志0:无退换1:退换处理中2:退换完成',
  `refund_num` int(11) NOT NULL COMMENT '累计退款商品数量',
  `logistics_amount` decimal(12,2) NOT NULL COMMENT '累计扣减物流费',
  `refund_amount` decimal(12,2) NOT NULL COMMENT '累计退款金额',
  `shp_inst` varchar(32) NOT NULL COMMENT '下单店铺ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_type` char(1) NOT NULL COMMENT '订单类型,1普通订单',
  `cancel_conf_time` datetime DEFAULT NULL COMMENT '取消发货、确认发货时间',
  `channel` varchar(6) DEFAULT NULL COMMENT 'channel 1网站订单、2手机订单 3微信订单',
  `discount_amount_yhq` int(11) DEFAULT NULL COMMENT '优惠券使用金额',
  `discount_ord_amount` decimal(12,2) DEFAULT NULL COMMENT '订单折扣金额 例如给用户优惠20元',
  `membership_level` char(1) DEFAULT NULL COMMENT '购买该订单商品会员级别：0普通会员1金牌会员2白金会员3钻石会员',
  `golden_bean_number` int(11) DEFAULT NULL COMMENT '该订单商品产生的金豆数量，默认为0',
  `growth_value` int(11) DEFAULT NULL COMMENT '该订单商品产生的成长值,默认0',
  PRIMARY KEY (`ord_pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品表';

/*Data for the table `t_ord_product` */

LOCK TABLES `t_ord_product` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ord_product_oper` */

CREATE TABLE `t_ord_product_oper` (
  `ord_pro_id` varchar(32) NOT NULL COMMENT '订单商品ID',
  `order_id` varchar(32) NOT NULL COMMENT '订单ID',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `deliver_user` varchar(32) DEFAULT NULL COMMENT '发货操作员',
  `deliver_time` datetime DEFAULT NULL COMMENT '发货时间',
  `logistics_id` varchar(32) DEFAULT NULL COMMENT '物流公司ID',
  `logistics_code` longtext COMMENT '发货物流号',
  `receipt_user` varchar(32) DEFAULT NULL COMMENT '收货/拒收操作员',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货/拒收时间',
  `receipt_memo` longtext COMMENT '收货/拒收备注',
  `cancel_user` varchar(32) DEFAULT NULL COMMENT '取消操作员',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  `cancel_memo` longtext COMMENT '取消操作备注',
  `comment_status` char(1) DEFAULT NULL COMMENT '点评标记,0:未点评,1已点评',
  `show_order_status` char(1) DEFAULT NULL COMMENT '晒单标记,0:未晒单,1已晒单',
  `logistics_name` longtext COMMENT '物流公司名称',
  PRIMARY KEY (`ord_pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品操作表';

/*Data for the table `t_ord_product_oper` */

LOCK TABLES `t_ord_product_oper` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ord_refund` */

CREATE TABLE `t_ord_refund` (
  `refund_id` varchar(32) NOT NULL COMMENT '退款流水号',
  `order_id` varchar(32) NOT NULL COMMENT '订单ID',
  `shp_inst` varchar(32) NOT NULL COMMENT '下单机构ID',
  `order_inst` varchar(32) NOT NULL COMMENT '跟单店铺ID',
  `pay_id` longtext NOT NULL COMMENT '支付订单ID;例如：p1|p2|p3',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `logistics_amount` decimal(12,2) DEFAULT NULL COMMENT '退款商品累计扣减物流费',
  `refund_amount` decimal(12,2) NOT NULL COMMENT '退款商品累计退款金额',
  `add_time` datetime NOT NULL COMMENT '申请时间',
  `add_user` varchar(32) NOT NULL COMMENT '申请人',
  `refund_type` char(1) NOT NULL COMMENT '退款原因类型：1取消发货，2拒绝收货，3退货',
  `refund_reason` longtext COMMENT '退款原因描述',
  `refund_status` char(1) NOT NULL COMMENT '退款状态：0申请退款，1拒绝申请，2审核通过，3已退款',
  `check_user` varchar(32) DEFAULT NULL COMMENT '审核人',
  `check_time` datetime DEFAULT NULL COMMENT '审核时间',
  `check_offer` longtext COMMENT '审核建议（同意或拒绝理由）',
  `refund_user` varchar(32) DEFAULT NULL COMMENT '退款人',
  `refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  `returns_id` varchar(32) DEFAULT NULL COMMENT '退货流水号,当退款原因为.退货.时需要',
  `sep_ref_amount` longtext COMMENT '保存对应支付ID的金额，例如：12.4|10|234',
  `pri_id_yhq` varchar(32) DEFAULT NULL COMMENT '优惠券序号,保存订单优惠表序号字段',
  `pri_id_dz` varchar(32) DEFAULT NULL COMMENT '打折序号,保存订单优惠表序号字段',
  `pri_id_hb` varchar(32) DEFAULT NULL COMMENT '红包序号,保存订单优惠表的支付ID',
  `discount_amount_yhq` int(11) DEFAULT NULL COMMENT '优惠劵使用金额',
  `discount_amount_dz` int(11) DEFAULT NULL COMMENT '打折优惠金额',
  `discount_amount_hb` int(11) DEFAULT NULL COMMENT '单次退红额',
  `pri_id` int(11) DEFAULT NULL COMMENT '序号(订单使用优惠表主键，用于退红包的支付ID)',
  `send_golden_number` int(11) DEFAULT NULL COMMENT '订单赠送的金豆数',
  `send_growth_value` int(11) DEFAULT NULL COMMENT '订单赠送的成长值',
  `refund_growth_value` int(11) DEFAULT NULL COMMENT '单次退金豆数量',
  PRIMARY KEY (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款表';

/*Data for the table `t_ord_refund` */

LOCK TABLES `t_ord_refund` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ord_refund_product` */

CREATE TABLE `t_ord_refund_product` (
  `refund_id` varchar(32) NOT NULL COMMENT '退款流水表',
  `ord_pro_id` varchar(32) NOT NULL COMMENT '订单商品ID',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `pro_name` longtext NOT NULL COMMENT '商品名称',
  `num` int(11) NOT NULL COMMENT '退款数量',
  `real_price` decimal(12,2) NOT NULL COMMENT '实际销售金额(单价)',
  `logistics_amount` decimal(12,2) NOT NULL COMMENT '扣减物流费',
  `refund_amount` decimal(12,2) NOT NULL COMMENT '退款金额=实际销售金额*退款数量-扣减物流费',
  `refuse_type` char(1) DEFAULT NULL COMMENT '拒绝收货再次申请退款用，1表示有效，0表示无效',
  `discount_amount_yhq` int(11) DEFAULT NULL COMMENT '优惠劵使用金额',
  `discount_amount_dz` int(11) DEFAULT NULL COMMENT '打折优惠金额',
  `discount_amount_hb` int(11) DEFAULT NULL COMMENT '单次退红额',
  `send_golden_number` int(11) DEFAULT NULL COMMENT '订单商品赠送的金豆数',
  `send_growth_value` int(11) DEFAULT NULL COMMENT '订单商品赠送的成长值',
  `refund_growth_value` int(11) DEFAULT NULL COMMENT '单次退金豆数量',
  PRIMARY KEY (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退款商品表';

/*Data for the table `t_ord_refund_product` */

LOCK TABLES `t_ord_refund_product` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_ord_returns` */

CREATE TABLE `t_ord_returns` (
  `returns_id` varchar(32) NOT NULL COMMENT '退换货ID',
  `ord_pro_id` varchar(32) NOT NULL COMMENT '订单商品ID',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `order_id` varchar(32) NOT NULL COMMENT '订单ID',
  `shp_inst` varchar(32) NOT NULL COMMENT '下单店铺ID',
  `order_inst` varchar(32) NOT NULL COMMENT '跟单机构ID',
  `pro_name` longtext NOT NULL COMMENT '商品名称',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `num` int(11) NOT NULL COMMENT '退换货商品数量',
  `real_price` decimal(12,2) NOT NULL COMMENT '实际销售价',
  `type` char(1) NOT NULL COMMENT '退换货类型：1退货，2换货',
  `status` char(1) NOT NULL COMMENT '退换货状态：0申请退/换货，1取消申请，2拒绝受理，3受理中，4处理完成',
  `add_time` datetime NOT NULL COMMENT '申请时间',
  `problem` longtext NOT NULL COMMENT '问题描述',
  `pic` longtext COMMENT '问题描述图片,多个用分号隔开',
  `linkman` varchar(32) NOT NULL COMMENT '联系人',
  `phone` varchar(32) NOT NULL COMMENT '联系号码',
  `accept_user` varchar(32) DEFAULT NULL COMMENT '受理人',
  `accept_time` datetime DEFAULT NULL COMMENT '受理时间',
  `accept_offer` longtext COMMENT '受理建议（同意或拒绝理由）',
  `returns_reason` char(1) NOT NULL COMMENT '退换货原因:0.用户退换货,1.拒绝收货,2.取消发货',
  PRIMARY KEY (`returns_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='退换货表';

/*Data for the table `t_ord_returns` */

LOCK TABLES `t_ord_returns` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_plat_info` */

CREATE TABLE `t_plat_info` (
  `plat_id` varchar(32) NOT NULL COMMENT '平台编号，主键',
  `plat_name` varchar(64) NOT NULL COMMENT '平台名称',
  `plat_desc` longtext COMMENT '备注',
  `pro_flag` char(1) DEFAULT NULL COMMENT '过程控制参数，0：不影响后续结算，1：影响后续结算',
  `add_time` datetime DEFAULT NULL COMMENT '增加时间',
  PRIMARY KEY (`plat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='平台信息表';

/*Data for the table `t_plat_info` */

LOCK TABLES `t_plat_info` WRITE;

insert  into `t_plat_info`(`plat_id`,`plat_name`,`plat_desc`,`pro_flag`,`add_time`) values ('1','11222222','11111111111',NULL,'2015-02-06 17:55:12');
insert  into `t_plat_info`(`plat_id`,`plat_name`,`plat_desc`,`pro_flag`,`add_time`) values ('333','33','333333333333333',NULL,'2015-02-10 09:47:17');
insert  into `t_plat_info`(`plat_id`,`plat_name`,`plat_desc`,`pro_flag`,`add_time`) values ('555','man','man',NULL,NULL);
insert  into `t_plat_info`(`plat_id`,`plat_name`,`plat_desc`,`pro_flag`,`add_time`) values ('ddd','sss','gdf',NULL,'2015-02-13 19:34:24');
insert  into `t_plat_info`(`plat_id`,`plat_name`,`plat_desc`,`pro_flag`,`add_time`) values ('df','sd','a',NULL,'2015-02-13 20:52:05');
insert  into `t_plat_info`(`plat_id`,`plat_name`,`plat_desc`,`pro_flag`,`add_time`) values ('ds','io','kjkh',NULL,'2015-02-13 20:46:53');
insert  into `t_plat_info`(`plat_id`,`plat_name`,`plat_desc`,`pro_flag`,`add_time`) values ('ii','oo','uu',NULL,'2015-02-27 19:24:26');
insert  into `t_plat_info`(`plat_id`,`plat_name`,`plat_desc`,`pro_flag`,`add_time`) values ('jk','8j','8',NULL,'2015-02-13 20:51:01');

UNLOCK TABLES;

/*Table structure for table `t_pub_area` */

CREATE TABLE `t_pub_area` (
  `area_id` varchar(32) NOT NULL COMMENT '地区ID',
  `area_name` varchar(64) NOT NULL COMMENT '地区名称',
  `status` char(1) NOT NULL COMMENT '状态：0无效，1有效',
  `area_pinyin` varchar(64) DEFAULT NULL COMMENT '地区拼音',
  `area_level` char(1) NOT NULL COMMENT '地区等级,1省,2市,3区',
  `parent_area_id` varchar(32) NOT NULL COMMENT '上级地区ID',
  `area_desc` varchar(64) DEFAULT NULL COMMENT '地区描述',
  `alias` varchar(64) NOT NULL COMMENT '地区别名',
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='地区表';

/*Data for the table `t_pub_area` */

LOCK TABLES `t_pub_area` WRITE;

insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110000','北京','1','beijing','1','0',NULL,'北京');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110100','北京市','1','beijing','2','110000',NULL,'北京');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110101','东城区','1','dongcheng','3','110100',NULL,'东城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110102','西城区','1','xicheng','3','110100',NULL,'西城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110105','朝阳区','1','chaoyang','3','110100',NULL,'朝阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110106','丰台区','1','fengtai','3','110100',NULL,'丰台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110107','石景山区','1','shijingshan','3','110100',NULL,'石景山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110108','海淀区','1','haidian','3','110100',NULL,'海淀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110109','门头沟区','1','mentougou','3','110100',NULL,'门头沟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110111','房山区','1','fangshan','3','110100',NULL,'房山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110112','通州区','1','tongzhou','3','110100',NULL,'通州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110113','顺义区','1','shunyi','3','110100',NULL,'顺义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110114','昌平区','1','changping','3','110100',NULL,'昌平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110115','大兴区','1','daxing','3','110100',NULL,'大兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110116','怀柔区','1','huairou','3','110100',NULL,'怀柔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110117','平谷区','1','pinggu','3','110100',NULL,'平谷');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110200','县辖区','0','xianxiaqu','2','110000',NULL,'县辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110228','密云县','1','miyun','3','110100',NULL,'密云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('110229','延庆县','1','yanqing','3','110100',NULL,'延庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120000','天津','1','tianjin','1','0',NULL,'天津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120100','天津市','1','tianjin','2','120000',NULL,'天津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120101','和平区','1','heping','3','120100',NULL,'和平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120102','河东区','1','hedong','3','120100',NULL,'河东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120103','河西区','1','hexi','3','120100',NULL,'河西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120104','南开区','1','nankai','3','120100',NULL,'南开');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120105','河北区','1','hebei','3','120100',NULL,'河北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120106','红桥区','1','hongqiao','3','120100',NULL,'红桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120110','东丽区','1','dongli','3','120100',NULL,'东丽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120111','西青区','1','xiqing','3','120100',NULL,'西青');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120112','津南区','1','jinnan','3','120100',NULL,'津南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120113','北辰区','1','beichen','3','120100',NULL,'北辰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120114','武清区','1','wuqing','3','120100',NULL,'武清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120115','宝坻区','1','baochi','3','120100',NULL,'宝坻');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120116','滨海新区','1','binhaixin','3','120100',NULL,'滨海新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120200','县辖区','0','xianxiaqu','2','120000',NULL,'县辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120221','宁河县','1','ninghe','3','120100',NULL,'宁河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120223','静海县','1','jinghai','3','120100',NULL,'静海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('120225','蓟县','1','jixian','3','120100',NULL,'蓟县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130000','河北省','1','hebei','1','0',NULL,'河北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130100','石家庄市','1','shijiazhuang','2','130000',NULL,'石家庄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130101','市辖区','0','shixiaqu','3','130100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130102','长安区','1','zhangan','3','130100',NULL,'长安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130103','桥东区','1','qiaodong','3','130100',NULL,'桥东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130104','桥西区','1','qiaoxi','3','130100',NULL,'桥西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130105','新华区','1','xinhua','3','130100',NULL,'新华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130107','井陉矿区','1','jingxingkuang','3','130100',NULL,'井陉矿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130108','裕华区','1','yuhua','3','130100',NULL,'裕华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130121','井陉县','1','jingxing','3','130100',NULL,'井陉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130123','正定县','1','zhengding','3','130100',NULL,'正定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130124','栾城县','1','luancheng','3','130100',NULL,'栾城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130125','行唐县','1','xingtang','3','130100',NULL,'行唐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130126','灵寿县','1','lingshou','3','130100',NULL,'灵寿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130127','高邑县','1','gaoyi','3','130100',NULL,'高邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130128','深泽县','1','shenze','3','130100',NULL,'深泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130129','赞皇县','1','zanhuang','3','130100',NULL,'赞皇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130130','无极县','1','wuji','3','130100',NULL,'无极');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130131','平山县','1','pingshan','3','130100',NULL,'平山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130132','元氏县','1','yuanshi','3','130100',NULL,'元氏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130133','赵县','1','zhaoxian','3','130100',NULL,'赵县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130181','辛集市','1','xinji','3','130100',NULL,'辛集');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130182','藁城市','1','gaocheng','3','130100',NULL,'藁城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130183','晋州市','1','jinzhou','3','130100',NULL,'晋州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130184','新乐市','1','xinle','3','130100',NULL,'新乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130185','鹿泉市','1','luquan','3','130100',NULL,'鹿泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130200','唐山市','1','tangshan','2','130000',NULL,'唐山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130201','市辖区','0','shixiaqu','3','130200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130202','路南区','1','lunan','3','130200',NULL,'路南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130203','路北区','1','lubei','3','130200',NULL,'路北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130204','古冶区','1','guye','3','130200',NULL,'古冶');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130205','开平区','1','kaiping','3','130200',NULL,'开平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130207','丰南区','1','fengnan','3','130200',NULL,'丰南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130208','丰润区','1','fengrun','3','130200',NULL,'丰润');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130209','曹妃甸区','1','caofeidian','3','130200',NULL,'曹妃甸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130223','滦县','1','luanxian','3','130200',NULL,'滦县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130224','滦南县','1','luannan','3','130200',NULL,'滦南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130225','乐亭县','1','leting','3','130200',NULL,'乐亭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130227','迁西县','1','qianxi','3','130200',NULL,'迁西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130229','玉田县','1','yutian','3','130200',NULL,'玉田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130281','遵化市','1','zunhua','3','130200',NULL,'遵化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130283','迁安市','1','qianan','3','130200',NULL,'迁安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130300','秦皇岛市','1','qinhuangdao','2','130000',NULL,'秦皇岛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130301','市辖区','0','shixiaqu','3','130300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130302','海港区','1','haigang','3','130300',NULL,'海港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130303','山海关区','1','shanhaiguan','3','130300',NULL,'山海关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130304','北戴河区','1','beidaihe','3','130300',NULL,'北戴河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130321','青龙满族自治县','1','qinglongmanzuzizhi','3','130300',NULL,'青龙满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130322','昌黎县','1','changli','3','130300',NULL,'昌黎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130323','抚宁县','1','funing','3','130300',NULL,'抚宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130324','卢龙县','1','lulong','3','130300',NULL,'卢龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130400','邯郸市','1','handan','2','130000',NULL,'邯郸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130401','市辖区','0','shixiaqu','3','130400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130402','邯山区','1','hanshan','3','130400',NULL,'邯山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130403','丛台区','1','congtai','3','130400',NULL,'丛台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130404','复兴区','1','fuxing','3','130400',NULL,'复兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130406','峰峰矿区','1','fengfengkuang','3','130400',NULL,'峰峰矿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130421','邯郸县','1','handan','3','130400',NULL,'邯郸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130423','临漳县','1','linzhang','3','130400',NULL,'临漳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130424','成安县','1','chengan','3','130400',NULL,'成安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130425','大名县','1','daming','3','130400',NULL,'大名');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130426','涉县','1','shexian','3','130400',NULL,'涉县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130427','磁县','1','cixian','3','130400',NULL,'磁县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130428','肥乡县','1','feixiang','3','130400',NULL,'肥乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130429','永年县','1','yongnian','3','130400',NULL,'永年');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130430','邱县','1','qiuxian','3','130400',NULL,'邱县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130431','鸡泽县','1','jize','3','130400',NULL,'鸡泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130432','广平县','1','guangping','3','130400',NULL,'广平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130433','馆陶县','1','guantao','3','130400',NULL,'馆陶');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130434','魏县','1','weixian','3','130400',NULL,'魏县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130435','曲周县','1','quzhou','3','130400',NULL,'曲周');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130481','武安市','1','wuan','3','130400',NULL,'武安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130500','邢台市','1','xingtai','2','130000',NULL,'邢台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130501','市辖区','0','shixiaqu','3','130500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130502','桥东区','1','qiaodong','3','130500',NULL,'桥东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130503','桥西区','1','qiaoxi','3','130500',NULL,'桥西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130521','邢台县','1','xingtai','3','130500',NULL,'邢台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130522','临城县','1','lincheng','3','130500',NULL,'临城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130523','内丘县','1','neiqiu','3','130500',NULL,'内丘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130524','柏乡县','1','boxiang','3','130500',NULL,'柏乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130525','隆尧县','1','longyao','3','130500',NULL,'隆尧');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130526','任县','1','renxian','3','130500',NULL,'任县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130527','南和县','1','nanhe','3','130500',NULL,'南和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130528','宁晋县','1','ningjin','3','130500',NULL,'宁晋');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130529','巨鹿县','1','julu','3','130500',NULL,'巨鹿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130530','新河县','1','xinhe','3','130500',NULL,'新河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130531','广宗县','1','guangzong','3','130500',NULL,'广宗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130532','平乡县','1','pingxiang','3','130500',NULL,'平乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130533','威县','1','weixian','3','130500',NULL,'威县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130534','清河县','1','qinghe','3','130500',NULL,'清河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130535','临西县','1','linxi','3','130500',NULL,'临西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130581','南宫市','1','nangong','3','130500',NULL,'南宫');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130582','沙河市','1','shahe','3','130500',NULL,'沙河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130600','保定市','1','baoding','2','130000',NULL,'保定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130601','市辖区','0','shixiaqu','3','130600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130602','新市区','1','xinshi','3','130600',NULL,'新市');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130603','北市区','1','beishi','3','130600',NULL,'北市');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130604','南市区','1','nanshi','3','130600',NULL,'南市');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130621','满城县','1','mancheng','3','130600',NULL,'满城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130622','清苑县','1','qingyuan','3','130600',NULL,'清苑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130623','涞水县','1','laishui','3','130600',NULL,'涞水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130624','阜平县','1','fuping','3','130600',NULL,'阜平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130625','徐水县','1','xushui','3','130600',NULL,'徐水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130626','定兴县','1','dingxing','3','130600',NULL,'定兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130627','唐县','1','tangxian','3','130600',NULL,'唐县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130628','高阳县','1','gaoyang','3','130600',NULL,'高阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130629','容城县','1','rongcheng','3','130600',NULL,'容城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130630','涞源县','1','laiyuan','3','130600',NULL,'涞源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130631','望都县','1','wangdou','3','130600',NULL,'望都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130632','安新县','1','anxin','3','130600',NULL,'安新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130633','易县','1','yixian','3','130600',NULL,'易县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130634','曲阳县','1','quyang','3','130600',NULL,'曲阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130635','蠡县','1','lixian','3','130600',NULL,'蠡县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130636','顺平县','1','shunping','3','130600',NULL,'顺平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130637','博野县','1','boye','3','130600',NULL,'博野');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130638','雄县','1','xiongxian','3','130600',NULL,'雄县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130681','涿州市','1','zhuozhou','3','130600',NULL,'涿州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130682','定州市','1','dingzhou','3','130600',NULL,'定州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130683','安国市','1','anguo','3','130600',NULL,'安国');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130684','高碑店市','1','gaobeidian','3','130600',NULL,'高碑店');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130700','张家口市','1','zhangjiakou','2','130000',NULL,'张家口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130701','市辖区','0','shixiaqu','3','130700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130702','桥东区','1','qiaodong','3','130700',NULL,'桥东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130703','桥西区','1','qiaoxi','3','130700',NULL,'桥西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130705','宣化区','1','xuanhua','3','130700',NULL,'宣化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130706','下花园区','1','xiahuayuan','3','130700',NULL,'下花园');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130721','宣化县','1','xuanhua','3','130700',NULL,'宣化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130722','张北县','1','zhangbei','3','130700',NULL,'张北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130723','康保县','1','kangbao','3','130700',NULL,'康保');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130724','沽源县','1','guyuan','3','130700',NULL,'沽源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130725','尚义县','1','shangyi','3','130700',NULL,'尚义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130726','蔚县','1','yuxian','3','130700',NULL,'蔚县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130727','阳原县','1','yangyuan','3','130700',NULL,'阳原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130728','怀安县','1','huaian','3','130700',NULL,'怀安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130729','万全县','1','wanquan','3','130700',NULL,'万全');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130730','怀来县','1','huailai','3','130700',NULL,'怀来');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130731','涿鹿县','1','zhuolu','3','130700',NULL,'涿鹿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130732','赤城县','1','chicheng','3','130700',NULL,'赤城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130733','崇礼县','1','chongli','3','130700',NULL,'崇礼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130800','承德市','1','chengde','2','130000',NULL,'承德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130801','市辖区','0','shixiaqu','3','130800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130802','双桥区','1','shuangqiao','3','130800',NULL,'双桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130803','双滦区','1','shuangluan','3','130800',NULL,'双滦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130804','鹰手营子矿区','1','yingshouyingzikuang','3','130800',NULL,'鹰手营子矿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130821','承德县','1','chengde','3','130800',NULL,'承德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130822','兴隆县','1','xinglong','3','130800',NULL,'兴隆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130823','平泉县','1','pingquan','3','130800',NULL,'平泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130824','滦平县','1','luanping','3','130800',NULL,'滦平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130825','隆化县','1','longhua','3','130800',NULL,'隆化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130826','丰宁满族自治县','1','fengningmanzuzizhi','3','130800',NULL,'丰宁满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130827','宽城满族自治县','1','kuanchengmanzuzizhi','3','130800',NULL,'宽城满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130828','围场满族蒙古族自治县','1','weichangmanzumengguzuzizhi','3','130800',NULL,'围场满族蒙古族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130900','沧州市','1','cangzhou','2','130000',NULL,'沧州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130901','市辖区','0','shixiaqu','3','130900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130902','新华区','1','xinhua','3','130900',NULL,'新华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130903','运河区','1','yunhe','3','130900',NULL,'运河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130921','沧县','1','cangxian','3','130900',NULL,'沧县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130922','青县','1','qingxian','3','130900',NULL,'青县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130923','东光县','1','dongguang','3','130900',NULL,'东光');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130924','海兴县','1','haixing','3','130900',NULL,'海兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130925','盐山县','1','yanshan','3','130900',NULL,'盐山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130926','肃宁县','1','suning','3','130900',NULL,'肃宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130927','南皮县','1','nanpi','3','130900',NULL,'南皮');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130928','吴桥县','1','wuqiao','3','130900',NULL,'吴桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130929','献县','1','xianxian','3','130900',NULL,'献县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130930','孟村回族自治县','1','mengcunhuizuzizhi','3','130900',NULL,'孟村回族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130981','泊头市','1','botou','3','130900',NULL,'泊头');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130982','任丘市','1','renqiu','3','130900',NULL,'任丘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130983','黄骅市','1','huanghua','3','130900',NULL,'黄骅');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('130984','河间市','1','hejian','3','130900',NULL,'河间');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131000','廊坊市','1','langfang','2','130000',NULL,'廊坊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131001','市辖区','0','shixiaqu','3','131000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131002','安次区','1','anci','3','131000',NULL,'安次');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131003','广阳区','1','guangyang','3','131000',NULL,'广阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131022','固安县','1','guan','3','131000',NULL,'固安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131023','永清县','1','yongqing','3','131000',NULL,'永清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131024','香河县','1','xianghe','3','131000',NULL,'香河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131025','大城县','1','dacheng','3','131000',NULL,'大城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131026','文安县','1','wenan','3','131000',NULL,'文安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131028','大厂回族自治县','1','dachanghuizuzizhi','3','131000',NULL,'大厂回族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131081','霸州市','1','bazhou','3','131000',NULL,'霸州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131082','三河市','1','sanhe','3','131000',NULL,'三河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131100','衡水市','1','hengshui','2','130000',NULL,'衡水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131101','市辖区','0','shixiaqu','3','131100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131102','桃城区','1','taocheng','3','131100',NULL,'桃城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131121','枣强县','1','zaoqiang','3','131100',NULL,'枣强');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131122','武邑县','1','wuyi','3','131100',NULL,'武邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131123','武强县','1','wuqiang','3','131100',NULL,'武强');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131124','饶阳县','1','raoyang','3','131100',NULL,'饶阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131125','安平县','1','anping','3','131100',NULL,'安平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131126','故城县','1','gucheng','3','131100',NULL,'故城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131127','景县','1','jingxian','3','131100',NULL,'景县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131128','阜城县','1','fucheng','3','131100',NULL,'阜城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131181','冀州市','1','jizhou','3','131100',NULL,'冀州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('131182','深州市','1','shenzhou','3','131100',NULL,'深州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140000','山西省','1','shanxi','1','0',NULL,'山西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140100','太原市','1','taiyuan','2','140000',NULL,'太原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140101','市辖区','0','shixiaqu','3','140100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140105','小店区','1','xiaodian','3','140100',NULL,'小店');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140106','迎泽区','1','yingze','3','140100',NULL,'迎泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140107','杏花岭区','1','xinghualing','3','140100',NULL,'杏花岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140108','尖草坪区','1','jiancaoping','3','140100',NULL,'尖草坪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140109','万柏林区','1','wanbolin','3','140100',NULL,'万柏林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140110','晋源区','1','jinyuan','3','140100',NULL,'晋源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140121','清徐县','1','qingxu','3','140100',NULL,'清徐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140122','阳曲县','1','yangqu','3','140100',NULL,'阳曲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140123','娄烦县','1','loufan','3','140100',NULL,'娄烦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140181','古交市','1','gujiao','3','140100',NULL,'古交');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140200','大同市','1','datong','2','140000',NULL,'大同');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140201','市辖区','0','shixiaqu','3','140200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140202','城区','1','chengqu','3','140200',NULL,'城区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140203','矿区','1','kuangqu','3','140200',NULL,'矿区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140211','南郊区','1','nanjiao','3','140200',NULL,'南郊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140212','新荣区','1','xinrong','3','140200',NULL,'新荣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140221','阳高县','1','yanggao','3','140200',NULL,'阳高');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140222','天镇县','1','tianzhen','3','140200',NULL,'天镇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140223','广灵县','1','guangling','3','140200',NULL,'广灵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140224','灵丘县','1','lingqiu','3','140200',NULL,'灵丘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140225','浑源县','1','hunyuan','3','140200',NULL,'浑源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140226','左云县','1','zuoyun','3','140200',NULL,'左云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140227','大同县','1','datong','3','140200',NULL,'大同');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140300','阳泉市','1','yangquan','2','140000',NULL,'阳泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140301','市辖区','0','shixiaqu','3','140300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140302','城区','1','chengqu','3','140300',NULL,'城区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140303','矿区','1','kuangqu','3','140300',NULL,'矿区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140311','郊区','1','jiaoqu','3','140300',NULL,'郊区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140321','平定县','1','pingding','3','140300',NULL,'平定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140322','盂县','1','yuxian','3','140300',NULL,'盂县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140400','长治市','1','zhangzhi','2','140000',NULL,'长治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140401','市辖区','0','shixiaqu','3','140400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140402','城区','1','chengqu','3','140400',NULL,'城区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140411','郊区','1','jiaoqu','3','140400',NULL,'郊区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140421','长治县','1','zhangzhi','3','140400',NULL,'长治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140423','襄垣县','1','xiangyuan','3','140400',NULL,'襄垣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140424','屯留县','1','tunliu','3','140400',NULL,'屯留');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140425','平顺县','1','pingshun','3','140400',NULL,'平顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140426','黎城县','1','licheng','3','140400',NULL,'黎城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140427','壶关县','1','huguan','3','140400',NULL,'壶关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140428','长子县','1','zhangzi','3','140400',NULL,'长子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140429','武乡县','1','wuxiang','3','140400',NULL,'武乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140430','沁县','1','qinxian','3','140400',NULL,'沁县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140431','沁源县','1','qinyuan','3','140400',NULL,'沁源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140481','潞城市','1','lucheng','3','140400',NULL,'潞城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140500','晋城市','1','jincheng','2','140000',NULL,'晋城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140501','晋城市市辖区','0','jincheng','3','140500',NULL,'晋城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140502','城区','1','chengqu','3','140500',NULL,'城区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140521','沁水县','1','qinshui','3','140500',NULL,'沁水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140522','阳城县','1','yangcheng','3','140500',NULL,'阳城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140524','陵川县','1','lingchuan','3','140500',NULL,'陵川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140525','泽州县','1','zezhou','3','140500',NULL,'泽州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140581','高平市','1','gaoping','3','140500',NULL,'高平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140600','朔州市','1','shuozhou','2','140000',NULL,'朔州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140601','市辖区','0','shixiaqu','3','140600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140602','朔城区','1','shuocheng','3','140600',NULL,'朔城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140603','平鲁区','1','pinglu','3','140600',NULL,'平鲁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140621','山阴县','1','shanyin','3','140600',NULL,'山阴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140622','应县','1','yingxian','3','140600',NULL,'应县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140623','右玉县','1','youyu','3','140600',NULL,'右玉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140624','怀仁县','1','huairen','3','140600',NULL,'怀仁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140700','晋中市','1','jinzhong','2','140000',NULL,'晋中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140701','市辖区','0','shixiaqu','3','140700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140702','榆次区','1','yuci','3','140700',NULL,'榆次');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140721','榆社县','1','yushe','3','140700',NULL,'榆社');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140722','左权县','1','zuoquan','3','140700',NULL,'左权');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140723','和顺县','1','heshun','3','140700',NULL,'和顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140724','昔阳县','1','xiyang','3','140700',NULL,'昔阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140725','寿阳县','1','shouyang','3','140700',NULL,'寿阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140726','太谷县','1','taigu','3','140700',NULL,'太谷');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140727','祁县','1','qixian','3','140700',NULL,'祁县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140728','平遥县','1','pingyao','3','140700',NULL,'平遥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140729','灵石县','1','lingshi','3','140700',NULL,'灵石');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140781','介休市','1','jiexiu','3','140700',NULL,'介休');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140800','运城市','1','yuncheng','2','140000',NULL,'运城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140801','市辖区','0','shixiaqu','3','140800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140802','盐湖区','1','yanhu','3','140800',NULL,'盐湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140821','临猗县','1','linyi','3','140800',NULL,'临猗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140822','万荣县','1','wanrong','3','140800',NULL,'万荣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140823','闻喜县','1','wenxi','3','140800',NULL,'闻喜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140824','稷山县','1','jishan','3','140800',NULL,'稷山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140825','新绛县','1','xinjiang','3','140800',NULL,'新绛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140826','绛县','1','jiangxian','3','140800',NULL,'绛县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140827','垣曲县','1','yuanqu','3','140800',NULL,'垣曲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140828','夏县','1','xiaxian','3','140800',NULL,'夏县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140829','平陆县','1','pinglu','3','140800',NULL,'平陆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140830','芮城县','1','ruicheng','3','140800',NULL,'芮城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140881','永济市','1','yongji','3','140800',NULL,'永济');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140882','河津市','1','hejin','3','140800',NULL,'河津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140900','忻州市','1','xinzhou','2','140000',NULL,'忻州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140901','市辖区','0','shixiaqu','3','140900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140902','忻府区','1','xinfu','3','140900',NULL,'忻府');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140921','定襄县','1','dingxiang','3','140900',NULL,'定襄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140922','五台县','1','wutai','3','140900',NULL,'五台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140923','代县','1','daixian','3','140900',NULL,'代县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140924','繁峙县','1','fanzhi','3','140900',NULL,'繁峙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140925','宁武县','1','ningwu','3','140900',NULL,'宁武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140926','静乐县','1','jingle','3','140900',NULL,'静乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140927','神池县','1','shenchi','3','140900',NULL,'神池');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140928','五寨县','1','wuzhai','3','140900',NULL,'五寨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140929','岢岚县','1','kelan','3','140900',NULL,'岢岚');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140930','河曲县','1','hequ','3','140900',NULL,'河曲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140931','保德县','1','baode','3','140900',NULL,'保德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140932','偏关县','1','pianguan','3','140900',NULL,'偏关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('140981','原平市','1','yuanping','3','140900',NULL,'原平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141000','临汾市','1','linfen','2','140000',NULL,'临汾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141001','市辖区','0','shixiaqu','3','141000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141002','尧都区','1','yaodou','3','141000',NULL,'尧都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141021','曲沃县','1','quwo','3','141000',NULL,'曲沃');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141022','翼城县','1','yicheng','3','141000',NULL,'翼城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141023','襄汾县','1','xiangfen','3','141000',NULL,'襄汾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141024','洪洞县','1','hongdong','3','141000',NULL,'洪洞');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141025','古县','1','guxian','3','141000',NULL,'古县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141026','安泽县','1','anze','3','141000',NULL,'安泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141027','浮山县','1','fushan','3','141000',NULL,'浮山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141028','吉县','1','jixian','3','141000',NULL,'吉县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141029','乡宁县','1','xiangning','3','141000',NULL,'乡宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141030','大宁县','1','daning','3','141000',NULL,'大宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141031','隰县','1','xixian','3','141000',NULL,'隰县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141032','永和县','1','yonghe','3','141000',NULL,'永和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141033','蒲县','1','puxian','3','141000',NULL,'蒲县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141034','汾西县','1','fenxi','3','141000',NULL,'汾西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141081','侯马市','1','houma','3','141000',NULL,'侯马');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141082','霍州市','1','huozhou','3','141000',NULL,'霍州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141100','吕梁市','1','lvliang','2','140000',NULL,'吕梁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141101','市辖区','0','shixiaqu','3','141100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141102','离石区','1','lishi','3','141100',NULL,'离石');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141121','文水县','1','wenshui','3','141100',NULL,'文水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141122','交城县','1','jiaocheng','3','141100',NULL,'交城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141123','兴县','1','xingxian','3','141100',NULL,'兴县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141124','临县','1','linxian','3','141100',NULL,'临县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141125','柳林县','1','liulin','3','141100',NULL,'柳林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141126','石楼县','1','shilou','3','141100',NULL,'石楼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141127','岚县','1','lanxian','3','141100',NULL,'岚县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141128','方山县','1','fangshan','3','141100',NULL,'方山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141129','中阳县','1','zhongyang','3','141100',NULL,'中阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141130','交口县','1','jiaokou','3','141100',NULL,'交口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141181','孝义市','1','xiaoyi','3','141100',NULL,'孝义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('141182','汾阳市','1','fenyang','3','141100',NULL,'汾阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150000','内蒙古自治区','1','neimengguzizhi','1','0',NULL,'内蒙古自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150100','呼和浩特市','1','huhehaote','2','150000',NULL,'呼和浩特');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150101','市辖区','0','shixiaqu','3','150100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150102','新城区','1','xincheng','3','150100',NULL,'新城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150103','回民区','1','huimin','3','150100',NULL,'回民');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150104','玉泉区','1','yuquan','3','150100',NULL,'玉泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150105','赛罕区','1','saihan','3','150100',NULL,'赛罕');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150121','土默特左旗','1','tumotezuoqi','3','150100',NULL,'土默特左旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150122','托克托县','1','tuoketuo','3','150100',NULL,'托克托');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150123','和林格尔县','1','helingeer','3','150100',NULL,'和林格尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150124','清水河县','1','qingshuihe','3','150100',NULL,'清水河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150125','武川县','1','wuchuan','3','150100',NULL,'武川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150200','包头市','1','baotou','2','150000',NULL,'包头');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150201','市辖区','0','shixiaqu','3','150200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150202','东河区','1','donghe','3','150200',NULL,'东河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150203','昆都仑区','1','kundoulun','3','150200',NULL,'昆都仑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150204','青山区','1','qingshan','3','150200',NULL,'青山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150205','石拐区','1','shiguai','3','150200',NULL,'石拐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150206','白云鄂博矿区','1','baiyunebokuang','3','150200',NULL,'白云鄂博矿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150207','九原区','1','jiuyuan','3','150200',NULL,'九原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150221','土默特右旗','1','tumoteyouqi','3','150200',NULL,'土默特右旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150222','固阳县','1','guyang','3','150200',NULL,'固阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150223','达尔罕茂明安联合旗','1','daerhanmaominganlianheqi','3','150200',NULL,'达尔罕茂明安联合旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150231','稀土高新区','1','xitugaoxinqu','3','150200',NULL,'稀土高新区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150300','乌海市','1','wuhai','2','150000',NULL,'乌海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150301','市辖区','0','shixiaqu','3','150300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150302','海勃湾区','1','haibowan','3','150300',NULL,'海勃湾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150303','海南区','1','hainan','3','150300',NULL,'海南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150304','乌达区','1','wuda','3','150300',NULL,'乌达');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150400','赤峰市','1','chifeng','2','150000',NULL,'赤峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150401','市辖区','0','shixiaqu','3','150400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150402','红山区','1','hongshan','3','150400',NULL,'红山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150403','元宝山区','1','yuanbaoshan','3','150400',NULL,'元宝山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150404','松山区','1','songshan','3','150400',NULL,'松山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150421','阿鲁科尔沁旗','1','alukeerqinqi','3','150400',NULL,'阿鲁科尔沁旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150422','巴林左旗','1','balinzuoqi','3','150400',NULL,'巴林左旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150423','巴林右旗','1','balinyouqi','3','150400',NULL,'巴林右旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150424','林西县','1','linxi','3','150400',NULL,'林西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150425','克什克腾旗','1','keshenketengqi','3','150400',NULL,'克什克腾旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150426','翁牛特旗','1','wengniuteqi','3','150400',NULL,'翁牛特旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150428','喀喇沁旗','1','kalaqinqi','3','150400',NULL,'喀喇沁旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150429','宁城县','1','ningcheng','3','150400',NULL,'宁城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150430','敖汉旗','1','aohanqi','3','150400',NULL,'敖汉旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150500','通辽市','1','tongliao','2','150000',NULL,'通辽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150501','市辖区','0','shixiaqu','3','150500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150502','科尔沁区','1','keerqin','3','150500',NULL,'科尔沁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150521','科尔沁左翼中旗','1','keerqinzuoyizhongqi','3','150500',NULL,'科尔沁左翼中旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150522','科尔沁左翼后旗','1','keerqinzuoyihouqi','3','150500',NULL,'科尔沁左翼后旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150523','开鲁县','1','kailu','3','150500',NULL,'开鲁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150524','库伦旗','1','kulunqi','3','150500',NULL,'库伦旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150525','奈曼旗','1','naimanqi','3','150500',NULL,'奈曼旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150526','扎鲁特旗','1','zhaluteqi','3','150500',NULL,'扎鲁特旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150581','霍林郭勒市','1','huolinguole','3','150500',NULL,'霍林郭勒');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150600','鄂尔多斯市','1','eerduosi','2','150000',NULL,'鄂尔多斯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150601','市辖区','0','shixiaqu','3','150600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150602','东胜区','1','dongsheng','3','150600',NULL,'东胜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150621','达拉特旗','1','dalateqi','3','150600',NULL,'达拉特旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150622','准格尔旗','1','zhungeerqi','3','150600',NULL,'准格尔旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150623','鄂托克前旗','1','etuokeqianqi','3','150600',NULL,'鄂托克前旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150624','鄂托克旗','1','etuokeqi','3','150600',NULL,'鄂托克旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150625','杭锦旗','1','hangjinqi','3','150600',NULL,'杭锦旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150626','乌审旗','1','wushenqi','3','150600',NULL,'乌审旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150627','伊金霍洛旗','1','yijinhuoluoqi','3','150600',NULL,'伊金霍洛旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150631','康巴什新区','1','kangbashen','3','150600',NULL,'康巴什');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150700','呼伦贝尔市','1','hulunbeier','2','150000',NULL,'呼伦贝尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150701','市辖区','0','shixiaqu','3','150700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150702','海拉尔区','1','hailaer','3','150700',NULL,'海拉尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150721','阿荣旗','1','arongqi','3','150700',NULL,'阿荣旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150722','莫力达瓦达斡尔族自治旗','1','molidawadawoerzuzizhiqi','3','150700',NULL,'莫力达瓦达斡尔族自治旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150723','鄂伦春自治旗','1','elunchunzizhiqi','3','150700',NULL,'鄂伦春自治旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150724','鄂温克族自治旗','1','ewenkezuzizhiqi','3','150700',NULL,'鄂温克族自治旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150725','陈巴尔虎旗','1','chenbaerhuqi','3','150700',NULL,'陈巴尔虎旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150726','新巴尔虎左旗','1','xinbaerhuzuoqi','3','150700',NULL,'新巴尔虎左旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150727','新巴尔虎右旗','1','xinbaerhuyouqi','3','150700',NULL,'新巴尔虎右旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150731','扎赉诺尔区','1','zhalainuoer','3','150700',NULL,'扎赉诺尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150781','满洲里市','1','manzhouli','3','150700',NULL,'满洲里');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150782','牙克石市','1','yakeshi','3','150700',NULL,'牙克石');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150783','扎兰屯市','1','zhalantun','3','150700',NULL,'扎兰屯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150784','额尔古纳市','1','eerguna','3','150700',NULL,'额尔古纳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150785','根河市','1','genhe','3','150700',NULL,'根河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150800','巴彦淖尔市','1','bayannaoer','2','150000',NULL,'巴彦淖尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150801','市辖区','0','shixiaqu','3','150800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150802','临河区','1','linhe','3','150800',NULL,'临河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150821','五原县','1','wuyuan','3','150800',NULL,'五原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150822','磴口县','1','dengkou','3','150800',NULL,'磴口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150823','乌拉特前旗','1','wulateqianqi','3','150800',NULL,'乌拉特前旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150824','乌拉特中旗','1','wulatezhongqi','3','150800',NULL,'乌拉特中旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150825','乌拉特后旗','1','wulatehouqi','3','150800',NULL,'乌拉特后旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150826','杭锦后旗','1','hangjinhouqi','3','150800',NULL,'杭锦后旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150900','乌兰察布市','1','wulanchabu','2','150000',NULL,'乌兰察布');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150901','市辖区','0','shixiaqu','3','150900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150902','集宁区','1','jining','3','150900',NULL,'集宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150921','卓资县','1','zhuozi','3','150900',NULL,'卓资');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150922','化德县','1','huade','3','150900',NULL,'化德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150923','商都县','1','shangdou','3','150900',NULL,'商都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150924','兴和县','1','xinghe','3','150900',NULL,'兴和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150925','凉城县','1','liangcheng','3','150900',NULL,'凉城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150926','察哈尔右翼前旗','1','chahaeryouyiqianqi','3','150900',NULL,'察哈尔右翼前旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150927','察哈尔右翼中旗','1','chahaeryouyizhongqi','3','150900',NULL,'察哈尔右翼中旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150928','察哈尔右翼后旗','1','chahaeryouyihouqi','3','150900',NULL,'察哈尔右翼后旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150929','四子王旗','1','siziwangqi','3','150900',NULL,'四子王旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('150981','丰镇市','1','fengzhen','3','150900',NULL,'丰镇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152200','兴安盟','1','xinganmeng','2','150000',NULL,'兴安盟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152201','乌兰浩特市','1','wulanhaote','3','152200',NULL,'乌兰浩特');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152202','阿尔山市','1','aershan','3','152200',NULL,'阿尔山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152221','科尔沁右翼前旗','1','keerqinyouyiqianqi','3','152200',NULL,'科尔沁右翼前旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152222','科尔沁右翼中旗','1','keerqinyouyizhongqi','3','152200',NULL,'科尔沁右翼中旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152223','扎赉特旗','1','zhalaiteqi','3','152200',NULL,'扎赉特旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152224','突泉县','1','tuquan','3','152200',NULL,'突泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152500','锡林郭勒盟','1','xilinguolemeng','2','150000',NULL,'锡林郭勒盟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152501','二连浩特市','1','erlianhaote','3','152500',NULL,'二连浩特');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152502','锡林浩特市','1','xilinhaote','3','152500',NULL,'锡林浩特');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152522','阿巴嘎旗','1','abagaqi','3','152500',NULL,'阿巴嘎旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152523','苏尼特左旗','1','sunitezuoqi','3','152500',NULL,'苏尼特左旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152524','苏尼特右旗','1','suniteyouqi','3','152500',NULL,'苏尼特右旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152525','东乌珠穆沁旗','1','dongwuzhumuqinqi','3','152500',NULL,'东乌珠穆沁旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152526','西乌珠穆沁旗','1','xiwuzhumuqinqi','3','152500',NULL,'西乌珠穆沁旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152527','太仆寺旗','1','taipusiqi','3','152500',NULL,'太仆寺旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152528','镶黄旗','1','xianghuangqi','3','152500',NULL,'镶黄旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152529','正镶白旗','1','zhengxiangbaiqi','3','152500',NULL,'正镶白旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152530','正蓝旗','1','zhenglanqi','3','152500',NULL,'正蓝旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152531','多伦县','1','duolun','3','152500',NULL,'多伦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152541','乌拉盖管理区','1','wulagai','3','152500',NULL,'乌拉盖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152900','阿拉善盟','1','alashanmeng','2','150000',NULL,'阿拉善盟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152921','阿拉善左旗','1','alashanzuoqi','3','152900',NULL,'阿拉善左旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152922','阿拉善右旗','1','alashanyouqi','3','152900',NULL,'阿拉善右旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('152923','额济纳旗','1','ejinaqi','3','152900',NULL,'额济纳旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210000','辽宁省','1','liaoning','1','0',NULL,'辽宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210100','沈阳市','1','shenyang','2','210000',NULL,'沈阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210101','市辖区','0','shixiaqu','3','210100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210102','和平区','1','heping','3','210100',NULL,'和平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210103','沈河区','1','shenhe','3','210100',NULL,'沈河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210104','大东区','1','dadong','3','210100',NULL,'大东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210105','皇姑区','1','huanggu','3','210100',NULL,'皇姑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210106','铁西区','1','tiexi','3','210100',NULL,'铁西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210111','苏家屯区','1','sujiatun','3','210100',NULL,'苏家屯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210112','东陵区','1','dongling','3','210100',NULL,'东陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210113','沈北新区','1','shenbeixin','3','210100',NULL,'沈北新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210114','于洪区','1','yuhong','3','210100',NULL,'于洪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210122','辽中县','1','liaozhong','3','210100',NULL,'辽中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210123','康平县','1','kangping','3','210100',NULL,'康平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210124','法库县','1','faku','3','210100',NULL,'法库');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210181','新民市','1','xinmin','3','210100',NULL,'新民');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210200','大连市','1','dalian','2','210000',NULL,'大连');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210201','市辖区','0','shixiaqu','3','210200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210202','中山区','1','zhongshan','3','210200',NULL,'中山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210203','西岗区','1','xigang','3','210200',NULL,'西岗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210204','沙河口区','1','shahekou','3','210200',NULL,'沙河口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210211','甘井子区','1','ganjingzi','3','210200',NULL,'甘井子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210212','旅顺口区','1','lvshunkou','3','210200',NULL,'旅顺口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210213','金州区','1','jinzhou','3','210200',NULL,'金州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210224','长海县','1','zhanghai','3','210200',NULL,'长海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210281','瓦房店市','1','wafangdian','3','210200',NULL,'瓦房店');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210282','普兰店市','1','pulandian','3','210200',NULL,'普兰店');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210283','庄河市','1','zhuanghe','3','210200',NULL,'庄河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210300','鞍山市','1','anshan','2','210000',NULL,'鞍山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210301','市辖区','0','shixiaqu','3','210300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210302','铁东区','1','tiedong','3','210300',NULL,'铁东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210303','铁西区','1','tiexi','3','210300',NULL,'铁西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210304','立山区','1','lishan','3','210300',NULL,'立山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210311','千山区','1','qianshan','3','210300',NULL,'千山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210321','台安县','1','taian','3','210300',NULL,'台安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210323','岫岩满族自治县','1','xiuyanmanzuzizhi','3','210300',NULL,'岫岩满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210381','海城市','1','haicheng','3','210300',NULL,'海城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210400','抚顺市','1','fushun','2','210000',NULL,'抚顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210401','市辖区','0','shixiaqu','3','210400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210402','新抚区','1','xinfu','3','210400',NULL,'新抚');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210403','东洲区','1','dongzhou','3','210400',NULL,'东洲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210404','望花区','1','wanghua','3','210400',NULL,'望花');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210411','顺城区','1','shuncheng','3','210400',NULL,'顺城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210421','抚顺县','1','fushun','3','210400',NULL,'抚顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210422','新宾满族自治县','1','xinbinmanzuzizhi','3','210400',NULL,'新宾满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210423','清原满族自治县','1','qingyuanmanzuzizhi','3','210400',NULL,'清原满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210500','本溪市','1','benxi','2','210000',NULL,'本溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210501','市辖区','0','shixiaqu','3','210500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210502','平山区','1','pingshan','3','210500',NULL,'平山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210503','溪湖区','1','xihu','3','210500',NULL,'溪湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210504','明山区','1','mingshan','3','210500',NULL,'明山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210505','南芬区','1','nanfen','3','210500',NULL,'南芬');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210521','本溪满族自治县','1','benximanzuzizhi','3','210500',NULL,'本溪满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210522','桓仁满族自治县','1','huanrenmanzuzizhi','3','210500',NULL,'桓仁满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210600','丹东市','1','dandong','2','210000',NULL,'丹东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210601','市辖区','0','shixiaqu','3','210600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210602','元宝区','1','yuanbao','3','210600',NULL,'元宝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210603','振兴区','1','zhenxing','3','210600',NULL,'振兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210604','振安区','1','zhenan','3','210600',NULL,'振安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210624','宽甸满族自治县','1','kuandianmanzuzizhi','3','210600',NULL,'宽甸满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210681','东港市','1','donggang','3','210600',NULL,'东港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210682','凤城市','1','fengcheng','3','210600',NULL,'凤城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210700','锦州市','1','jinzhou','2','210000',NULL,'锦州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210701','市辖区','0','shixiaqu','3','210700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210702','古塔区','1','guta','3','210700',NULL,'古塔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210703','凌河区','1','linghe','3','210700',NULL,'凌河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210711','太和区','1','taihe','3','210700',NULL,'太和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210726','黑山县','1','heishan','3','210700',NULL,'黑山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210727','义县','1','yixian','3','210700',NULL,'义县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210781','凌海市','1','linghai','3','210700',NULL,'凌海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210782','北镇市','1','beizhen','3','210700',NULL,'北镇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210800','营口市','1','yingkou','2','210000',NULL,'营口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210801','市辖区','0','shixiaqu','3','210800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210802','站前区','1','zhanqian','3','210800',NULL,'站前');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210803','西市区','1','xishi','3','210800',NULL,'西市');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210804','鲅鱼圈区','1','bayuquan','3','210800',NULL,'鲅鱼圈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210811','老边区','1','laobian','3','210800',NULL,'老边');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210881','盖州市','1','gaizhou','3','210800',NULL,'盖州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210882','大石桥市','1','dashiqiao','3','210800',NULL,'大石桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210900','阜新市','1','fuxin','2','210000',NULL,'阜新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210901','市辖区','0','shixiaqu','3','210900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210902','海州区','1','haizhou','3','210900',NULL,'海州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210903','新邱区','1','xinqiu','3','210900',NULL,'新邱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210904','太平区','1','taiping','3','210900',NULL,'太平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210905','清河门区','1','qinghemen','3','210900',NULL,'清河门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210911','细河区','1','xihe','3','210900',NULL,'细河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210921','阜新蒙古族自治县','1','fuxinmengguzuzizhi','3','210900',NULL,'阜新蒙古族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('210922','彰武县','1','zhangwu','3','210900',NULL,'彰武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211000','辽阳市','1','liaoyang','2','210000',NULL,'辽阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211001','市辖区','0','shixiaqu','3','211000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211002','白塔区','1','baita','3','211000',NULL,'白塔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211003','文圣区','1','wensheng','3','211000',NULL,'文圣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211004','宏伟区','1','hongwei','3','211000',NULL,'宏伟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211005','弓长岭区','1','gongzhangling','3','211000',NULL,'弓长岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211011','太子河区','1','taizihe','3','211000',NULL,'太子河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211021','辽阳县','1','liaoyang','3','211000',NULL,'辽阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211081','灯塔市','1','dengta','3','211000',NULL,'灯塔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211100','盘锦市','1','panjin','2','210000',NULL,'盘锦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211101','市辖区','0','shixiaqu','3','211100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211102','双台子区','1','shuangtaizi','3','211100',NULL,'双台子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211103','兴隆台区','1','xinglongtai','3','211100',NULL,'兴隆台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211121','大洼县','1','dawa','3','211100',NULL,'大洼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211122','盘山县','1','panshan','3','211100',NULL,'盘山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211200','铁岭市','1','tieling','2','210000',NULL,'铁岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211201','市辖区','0','shixiaqu','3','211200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211202','银州区','1','yinzhou','3','211200',NULL,'银州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211204','清河区','1','qinghe','3','211200',NULL,'清河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211221','铁岭县','1','tieling','3','211200',NULL,'铁岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211223','西丰县','1','xifeng','3','211200',NULL,'西丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211224','昌图县','1','changtu','3','211200',NULL,'昌图');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211281','调兵山市','1','diaobingshan','3','211200',NULL,'调兵山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211282','开原市','1','kaiyuan','3','211200',NULL,'开原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211300','朝阳市','1','chaoyang','2','210000',NULL,'朝阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211301','市辖区','0','shixiaqu','3','211300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211302','双塔区','1','shuangta','3','211300',NULL,'双塔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211303','龙城区','1','longcheng','3','211300',NULL,'龙城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211321','朝阳县','1','chaoyang','3','211300',NULL,'朝阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211322','建平县','1','jianping','3','211300',NULL,'建平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211324','喀喇沁左翼蒙古族自治县','1','kalaqinzuoyimengguzuzizhi','3','211300',NULL,'喀喇沁左翼蒙古族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211381','北票市','1','beipiao','3','211300',NULL,'北票');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211382','凌源市','1','lingyuan','3','211300',NULL,'凌源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211400','葫芦岛市','1','huludao','2','210000',NULL,'葫芦岛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211401','市辖区','0','shixiaqu','3','211400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211402','连山区','1','lianshan','3','211400',NULL,'连山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211403','龙港区','1','longgang','3','211400',NULL,'龙港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211404','南票区','1','nanpiao','3','211400',NULL,'南票');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211421','绥中县','1','suizhong','3','211400',NULL,'绥中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211422','建昌县','1','jianchang','3','211400',NULL,'建昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('211481','兴城市','1','xingcheng','3','211400',NULL,'兴城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220000','吉林省','1','jilin','1','0',NULL,'吉林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220100','长春市','1','zhangchun','2','220000',NULL,'长春');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220101','市辖区','0','shixiaqu','3','220100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220102','南关区','1','nanguan','3','220100',NULL,'南关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220103','宽城区','1','kuancheng','3','220100',NULL,'宽城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220104','朝阳区','1','chaoyang','3','220100',NULL,'朝阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220105','二道区','1','erdao','3','220100',NULL,'二道');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220106','绿园区','1','lvyuan','3','220100',NULL,'绿园');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220112','双阳区','1','shuangyang','3','220100',NULL,'双阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220122','农安县','1','nongan','3','220100',NULL,'农安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220181','九台市','1','jiutai','3','220100',NULL,'九台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220182','榆树市','1','yushu','3','220100',NULL,'榆树');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220183','德惠市','1','dehui','3','220100',NULL,'德惠');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220200','吉林市','1','jilin','2','220000',NULL,'吉林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220201','市辖区','0','shixiaqu','3','220200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220202','昌邑区','1','changyi','3','220200',NULL,'昌邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220203','龙潭区','1','longtan','3','220200',NULL,'龙潭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220204','船营区','1','chuanying','3','220200',NULL,'船营');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220211','丰满区','1','fengman','3','220200',NULL,'丰满');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220221','永吉县','1','yongji','3','220200',NULL,'永吉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220281','蛟河市','1','jiaohe','3','220200',NULL,'蛟河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220282','桦甸市','1','huadian','3','220200',NULL,'桦甸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220283','舒兰市','1','shulan','3','220200',NULL,'舒兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220284','磐石市','1','panshi','3','220200',NULL,'磐石');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220300','四平市','1','siping','2','220000',NULL,'四平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220301','市辖区','0','shixiaqu','3','220300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220302','铁西区','1','tiexi','3','220300',NULL,'铁西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220303','铁东区','1','tiedong','3','220300',NULL,'铁东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220322','梨树县','1','lishu','3','220300',NULL,'梨树');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220323','伊通满族自治县','1','yitongmanzuzizhi','3','220300',NULL,'伊通满族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220381','公主岭市','1','gongzhuling','3','220300',NULL,'公主岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220382','双辽市','1','shuangliao','3','220300',NULL,'双辽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220400','辽源市','1','liaoyuan','2','220000',NULL,'辽源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220401','市辖区','0','shixiaqu','3','220400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220402','龙山区','1','longshan','3','220400',NULL,'龙山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220403','西安区','1','xian','3','220400',NULL,'西安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220421','东丰县','1','dongfeng','3','220400',NULL,'东丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220422','东辽县','1','dongliao','3','220400',NULL,'东辽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220500','通化市','1','tonghua','2','220000',NULL,'通化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220501','市辖区','0','shixiaqu','3','220500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220502','东昌区','1','dongchang','3','220500',NULL,'东昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220503','二道江区','1','erdaojiang','3','220500',NULL,'二道江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220521','通化县','1','tonghua','3','220500',NULL,'通化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220523','辉南县','1','huinan','3','220500',NULL,'辉南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220524','柳河县','1','liuhe','3','220500',NULL,'柳河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220581','梅河口市','1','meihekou','3','220500',NULL,'梅河口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220582','集安市','1','jian','3','220500',NULL,'集安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220600','白山市','1','baishan','2','220000',NULL,'白山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220601','市辖区','0','shixiaqu','3','220600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220602','浑江区','1','hunjiang','3','220600',NULL,'浑江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220605','江源区','1','jiangyuan','3','220600',NULL,'江源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220621','抚松县','1','fusong','3','220600',NULL,'抚松');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220622','靖宇县','1','jingyu','3','220600',NULL,'靖宇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220623','长白朝鲜族自治县','1','zhangbaichaoxianzuzizhi','3','220600',NULL,'长白朝鲜族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220681','临江市','1','linjiang','3','220600',NULL,'临江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220700','松原市','1','songyuan','2','220000',NULL,'松原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220701','市辖区','0','shixiaqu','3','220700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220702','宁江区','1','ningjiang','3','220700',NULL,'宁江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220721','前郭尔罗斯蒙古族自治县','1','qianguoerluosimengguzuzizhi','3','220700',NULL,'前郭尔罗斯蒙古族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220722','长岭县','1','zhangling','3','220700',NULL,'长岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220723','乾安县','1','qianan','3','220700',NULL,'乾安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220724','扶余县','1','fuyu','3','220700',NULL,'扶余');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220800','白城市','1','baicheng','2','220000',NULL,'白城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220801','市辖区','0','shixiaqu','3','220800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220802','洮北区','1','taobei','3','220800',NULL,'洮北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220821','镇赉县','1','zhenlai','3','220800',NULL,'镇赉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220822','通榆县','1','tongyu','3','220800',NULL,'通榆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220881','洮南市','1','taonan','3','220800',NULL,'洮南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('220882','大安市','1','daan','3','220800',NULL,'大安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('222400','延边朝鲜族自治州','1','yanbianchaoxianzuzizhizhou','2','220000',NULL,'延边朝鲜族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('222401','延吉市','1','yanji','3','222400',NULL,'延吉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('222402','图们市','1','tumen','3','222400',NULL,'图们');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('222403','敦化市','1','dunhua','3','222400',NULL,'敦化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('222404','珲春市','1','hunchun','3','222400',NULL,'珲春');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('222405','龙井市','1','longjing','3','222400',NULL,'龙井');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('222406','和龙市','1','helong','3','222400',NULL,'和龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('222424','汪清县','1','wangqing','3','222400',NULL,'汪清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('222426','安图县','1','antu','3','222400',NULL,'安图');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230000','黑龙江省','1','heilongjiang','1','0',NULL,'黑龙江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230100','哈尔滨市','1','haerbin','2','230000',NULL,'哈尔滨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230101','市辖区','0','shixiaqu','3','230100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230102','道里区','1','daoli','3','230100',NULL,'道里');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230103','南岗区','1','nangang','3','230100',NULL,'南岗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230104','道外区','1','daowai','3','230100',NULL,'道外');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230108','平房区','1','pingfang','3','230100',NULL,'平房');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230109','松北区','1','songbei','3','230100',NULL,'松北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230110','香坊区','1','xiangfang','3','230100',NULL,'香坊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230111','呼兰区','1','hulan','3','230100',NULL,'呼兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230112','阿城区','1','acheng','3','230100',NULL,'阿城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230123','依兰县','1','yilan','3','230100',NULL,'依兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230124','方正县','1','fangzheng','3','230100',NULL,'方正');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230125','宾县','1','binxian','3','230100',NULL,'宾县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230126','巴彦县','1','bayan','3','230100',NULL,'巴彦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230127','木兰县','1','mulan','3','230100',NULL,'木兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230128','通河县','1','tonghe','3','230100',NULL,'通河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230129','延寿县','1','yanshou','3','230100',NULL,'延寿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230182','双城市','1','shuangcheng','3','230100',NULL,'双城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230183','尚志市','1','shangzhi','3','230100',NULL,'尚志');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230184','五常市','1','wuchang','3','230100',NULL,'五常');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230200','齐齐哈尔市','1','qiqihaer','2','230000',NULL,'齐齐哈尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230201','市辖区','0','shixiaqu','3','230200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230202','龙沙区','1','longsha','3','230200',NULL,'龙沙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230203','建华区','1','jianhua','3','230200',NULL,'建华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230204','铁锋区','1','tiefeng','3','230200',NULL,'铁锋');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230205','昂昂溪区','1','angangxi','3','230200',NULL,'昂昂溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230206','富拉尔基区','1','fulaerji','3','230200',NULL,'富拉尔基');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230207','碾子山区','1','nianzishan','3','230200',NULL,'碾子山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230208','梅里斯达斡尔族区','1','meilisidawoerzu','3','230200',NULL,'梅里斯达斡尔族');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230221','龙江县','1','longjiang','3','230200',NULL,'龙江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230223','依安县','1','yian','3','230200',NULL,'依安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230224','泰来县','1','tailai','3','230200',NULL,'泰来');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230225','甘南县','1','gannan','3','230200',NULL,'甘南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230227','富裕县','1','fuyu','3','230200',NULL,'富裕');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230229','克山县','1','keshan','3','230200',NULL,'克山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230230','克东县','1','kedong','3','230200',NULL,'克东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230231','拜泉县','1','baiquan','3','230200',NULL,'拜泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230281','讷河市','1','nehe','3','230200',NULL,'讷河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230300','鸡西市','1','jixi','2','230000',NULL,'鸡西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230301','市辖区','0','shixiaqu','3','230300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230302','鸡冠区','1','jiguan','3','230300',NULL,'鸡冠');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230303','恒山区','1','hengshan','3','230300',NULL,'恒山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230304','滴道区','1','didao','3','230300',NULL,'滴道');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230305','梨树区','1','lishu','3','230300',NULL,'梨树');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230306','城子河区','1','chengzihe','3','230300',NULL,'城子河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230307','麻山区','1','mashan','3','230300',NULL,'麻山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230321','鸡东县','1','jidong','3','230300',NULL,'鸡东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230381','虎林市','1','hulin','3','230300',NULL,'虎林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230382','密山市','1','mishan','3','230300',NULL,'密山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230400','鹤岗市','1','hegang','2','230000',NULL,'鹤岗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230401','市辖区','0','shixiaqu','3','230400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230402','向阳区','1','xiangyang','3','230400',NULL,'向阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230403','工农区','1','gongnong','3','230400',NULL,'工农');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230404','南山区','1','nanshan','3','230400',NULL,'南山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230405','兴安区','1','xingan','3','230400',NULL,'兴安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230406','东山区','1','dongshan','3','230400',NULL,'东山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230407','兴山区','1','xingshan','3','230400',NULL,'兴山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230421','萝北县','1','luobei','3','230400',NULL,'萝北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230422','绥滨县','1','suibin','3','230400',NULL,'绥滨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230500','双鸭山市','1','shuangyashan','2','230000',NULL,'双鸭山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230501','市辖区','0','shixiaqu','3','230500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230502','尖山区','1','jianshan','3','230500',NULL,'尖山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230503','岭东区','1','lingdong','3','230500',NULL,'岭东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230505','四方台区','1','sifangtai','3','230500',NULL,'四方台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230506','宝山区','1','baoshan','3','230500',NULL,'宝山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230521','集贤县','1','jixian','3','230500',NULL,'集贤');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230522','友谊县','1','youyi','3','230500',NULL,'友谊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230523','宝清县','1','baoqing','3','230500',NULL,'宝清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230524','饶河县','1','raohe','3','230500',NULL,'饶河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230600','大庆市','1','daqing','2','230000',NULL,'大庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230601','市辖区','0','shixiaqu','3','230600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230602','萨尔图区','1','saertu','3','230600',NULL,'萨尔图');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230603','龙凤区','1','longfeng','3','230600',NULL,'龙凤');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230604','让胡路区','1','ranghulu','3','230600',NULL,'让胡路');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230605','红岗区','1','honggang','3','230600',NULL,'红岗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230606','大同区','1','datong','3','230600',NULL,'大同');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230621','肇州县','1','zhaozhou','3','230600',NULL,'肇州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230622','肇源县','1','zhaoyuan','3','230600',NULL,'肇源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230623','林甸县','1','lindian','3','230600',NULL,'林甸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230624','杜尔伯特蒙古族自治县','1','duerbotemengguzuzizhi','3','230600',NULL,'杜尔伯特蒙古族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230700','伊春市','1','yichun','2','230000',NULL,'伊春');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230701','市辖区','0','shixiaqu','3','230700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230702','伊春区','1','yichun','3','230700',NULL,'伊春');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230703','南岔区','1','nancha','3','230700',NULL,'南岔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230704','友好区','1','youhao','3','230700',NULL,'友好');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230705','西林区','1','xilin','3','230700',NULL,'西林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230706','翠峦区','1','cuiluan','3','230700',NULL,'翠峦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230707','新青区','1','xinqing','3','230700',NULL,'新青');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230708','美溪区','1','meixi','3','230700',NULL,'美溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230709','金山屯区','1','jinshantun','3','230700',NULL,'金山屯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230710','五营区','1','wuying','3','230700',NULL,'五营');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230711','乌马河区','1','wumahe','3','230700',NULL,'乌马河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230712','汤旺河区','1','tangwanghe','3','230700',NULL,'汤旺河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230713','带岭区','1','dailing','3','230700',NULL,'带岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230714','乌伊岭区','1','wuyiling','3','230700',NULL,'乌伊岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230715','红星区','1','hongxing','3','230700',NULL,'红星');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230716','上甘岭区','1','shangganling','3','230700',NULL,'上甘岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230722','嘉荫县','1','jiayin','3','230700',NULL,'嘉荫');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230781','铁力市','1','tieli','3','230700',NULL,'铁力');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230800','佳木斯市','1','jiamusi','2','230000',NULL,'佳木斯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230801','市辖区','0','shixiaqu','3','230800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230803','向阳区','1','xiangyang','3','230800',NULL,'向阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230804','前进区','1','qianjin','3','230800',NULL,'前进');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230805','东风区','1','dongfeng','3','230800',NULL,'东风');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230811','郊区','1','jiaoqu','3','230800',NULL,'郊区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230822','桦南县','1','huanan','3','230800',NULL,'桦南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230826','桦川县','1','huachuan','3','230800',NULL,'桦川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230828','汤原县','1','tangyuan','3','230800',NULL,'汤原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230833','抚远县','1','fuyuan','3','230800',NULL,'抚远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230881','同江市','1','tongjiang','3','230800',NULL,'同江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230882','富锦市','1','fujin','3','230800',NULL,'富锦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230900','七台河市','1','qitaihe','2','230000',NULL,'七台河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230901','市辖区','0','shixiaqu','3','230900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230902','新兴区','1','xinxing','3','230900',NULL,'新兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230903','桃山区','1','taoshan','3','230900',NULL,'桃山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230904','茄子河区','1','qiezihe','3','230900',NULL,'茄子河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('230921','勃利县','1','boli','3','230900',NULL,'勃利');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231000','牡丹江市','1','mudanjiang','2','230000',NULL,'牡丹江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231001','市辖区','0','shixiaqu','3','231000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231002','东安区','1','dongan','3','231000',NULL,'东安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231003','阳明区','1','yangming','3','231000',NULL,'阳明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231004','爱民区','1','aimin','3','231000',NULL,'爱民');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231005','西安区','1','xian','3','231000',NULL,'西安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231024','东宁县','1','dongning','3','231000',NULL,'东宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231025','林口县','1','linkou','3','231000',NULL,'林口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231081','绥芬河市','1','suifenhe','3','231000',NULL,'绥芬河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231083','海林市','1','hailin','3','231000',NULL,'海林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231084','宁安市','1','ningan','3','231000',NULL,'宁安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231085','穆棱市','1','muleng','3','231000',NULL,'穆棱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231091','江南新区','1','jiangnanxinqu','3','231000',NULL,'江南新区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231100','黑河市','1','heihe','2','230000',NULL,'黑河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231101','市辖区','0','shixiaqu','3','231100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231102','爱辉区','1','aihui','3','231100',NULL,'爱辉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231121','嫩江县','1','nenjiang','3','231100',NULL,'嫩江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231123','逊克县','1','xunke','3','231100',NULL,'逊克');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231124','孙吴县','1','sunwu','3','231100',NULL,'孙吴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231181','北安市','1','beian','3','231100',NULL,'北安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231182','五大连池市','1','wudalianchi','3','231100',NULL,'五大连池');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231191','特殊经济合作区','1','teshujingjihezuoqu','3','231100',NULL,'特殊经济合作区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231200','绥化市','1','suihua','2','230000',NULL,'绥化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231201','市辖区','0','shixiaqu','3','231200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231202','北林区','1','beilin','3','231200',NULL,'北林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231221','望奎县','1','wangkui','3','231200',NULL,'望奎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231222','兰西县','1','lanxi','3','231200',NULL,'兰西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231223','青冈县','1','qinggang','3','231200',NULL,'青冈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231224','庆安县','1','qingan','3','231200',NULL,'庆安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231225','明水县','1','mingshui','3','231200',NULL,'明水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231226','绥棱县','1','suileng','3','231200',NULL,'绥棱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231281','安达市','1','anda','3','231200',NULL,'安达');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231282','肇东市','1','zhaodong','3','231200',NULL,'肇东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('231283','海伦市','1','hailun','3','231200',NULL,'海伦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('232700','大兴安岭地区','1','daxinganlingdi','2','230000',NULL,'大兴安岭地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('232721','呼玛县','1','huma','3','232700',NULL,'呼玛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('232722','塔河县','1','tahe','3','232700',NULL,'塔河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('232723','漠河县','1','mohe','3','232700',NULL,'漠河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('232731','松岭区','1','songling','3','232700',NULL,'松岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('232732','新林区','1','xinlin','3','232700',NULL,'新林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('232733','呼中区','1','huzhong','3','232700',NULL,'呼中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('232741','加格达奇区','1','jiagedaqi','3','232700',NULL,'加格达奇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310000','上海','1','shanghai','1','0',NULL,'上海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310100','上海市','1','shanghai','2','310000',NULL,'上海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310101','黄浦区','1','huangpu','3','310100',NULL,'黄浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310104','徐汇区','1','xuhui','3','310100',NULL,'徐汇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310105','长宁区','1','zhangning','3','310100',NULL,'长宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310106','静安区','1','jingan','3','310100',NULL,'静安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310107','普陀区','1','putuo','3','310100',NULL,'普陀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310108','闸北区','1','zhabei','3','310100',NULL,'闸北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310109','虹口区','1','hongkou','3','310100',NULL,'虹口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310110','杨浦区','1','yangpu','3','310100',NULL,'杨浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310112','闵行区','1','minxing','3','310100',NULL,'闵行');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310113','宝山区','1','baoshan','3','310100',NULL,'宝山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310114','嘉定区','1','jiading','3','310100',NULL,'嘉定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310115','浦东新区','1','pudongxin','3','310100',NULL,'浦东新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310116','金山区','1','jinshan','3','310100',NULL,'金山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310117','松江区','1','songjiang','3','310100',NULL,'松江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310118','青浦区','1','qingpu','3','310100',NULL,'青浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310120','奉贤区','1','fengxian','3','310100',NULL,'奉贤');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310121','南区','1','nanqu','3','310100',NULL,'南区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310122','南汇区','1','nanhuiqu','3','310100',NULL,'南汇区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310200','县辖区','0','xianxiaqu','2','310000',NULL,'县辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('310230','崇明县','1','chongming','3','310100',NULL,'崇明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320000','江苏省','1','jiangsu','1','0',NULL,'江苏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320100','南京市','1','nanjing','2','320000',NULL,'南京');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320101','市辖区','0','shixiaqu','3','320100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320102','玄武区','1','xuanwu','3','320100',NULL,'玄武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320103','白下区','1','baixia','3','320100',NULL,'白下');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320104','秦淮区','1','qinhuai','3','320100',NULL,'秦淮');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320105','建邺区','1','jianye','3','320100',NULL,'建邺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320106','鼓楼区','1','gulou','3','320100',NULL,'鼓楼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320107','下关区','1','xiaguan','3','320100',NULL,'下关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320111','浦口区','1','pukou','3','320100',NULL,'浦口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320113','栖霞区','1','qixia','3','320100',NULL,'栖霞');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320114','雨花台区','1','yuhuatai','3','320100',NULL,'雨花台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320115','江宁区','1','jiangning','3','320100',NULL,'江宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320116','六合区','1','liuhe','3','320100',NULL,'六合');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320124','溧水县','1','lishui','3','320100',NULL,'溧水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320125','高淳区','1','gaochun','3','320100',NULL,'高淳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320200','无锡市','1','wuxi','2','320000',NULL,'无锡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320201','市辖区','0','shixiaqu','3','320200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320202','崇安区','1','chongan','3','320200',NULL,'崇安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320203','南长区','1','nanzhang','3','320200',NULL,'南长');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320204','北塘区','1','beitang','3','320200',NULL,'北塘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320205','锡山区','1','xishan','3','320200',NULL,'锡山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320206','惠山区','1','huishan','3','320200',NULL,'惠山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320211','滨湖区','1','binhu','3','320200',NULL,'滨湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320281','江阴市','1','jiangyin','3','320200',NULL,'江阴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320282','宜兴市','1','yixing','3','320200',NULL,'宜兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320300','徐州市','1','xuzhou','2','320000',NULL,'徐州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320301','市辖区','0','shixiaqu','3','320300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320302','鼓楼区','1','gulou','3','320300',NULL,'鼓楼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320303','云龙区','1','yunlong','3','320300',NULL,'云龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320305','贾汪区','1','jiawang','3','320300',NULL,'贾汪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320311','泉山区','1','quanshan','3','320300',NULL,'泉山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320312','铜山区','1','tongshan','3','320300',NULL,'铜山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320321','丰县','1','fengxian','3','320300',NULL,'丰县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320322','沛县','1','peixian','3','320300',NULL,'沛县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320324','睢宁县','1','suining','3','320300',NULL,'睢宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320381','新沂市','1','xinyi','3','320300',NULL,'新沂');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320382','邳州市','1','pizhou','3','320300',NULL,'邳州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320400','常州市','1','changzhou','2','320000',NULL,'常州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320401','市辖区','0','shixiaqu','3','320400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320402','天宁区','1','tianning','3','320400',NULL,'天宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320404','钟楼区','1','zhonglou','3','320400',NULL,'钟楼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320405','戚墅堰区','1','qishuyan','3','320400',NULL,'戚墅堰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320411','新北区','1','xinbei','3','320400',NULL,'新北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320412','武进区','1','wujin','3','320400',NULL,'武进');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320481','溧阳市','1','liyang','3','320400',NULL,'溧阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320482','金坛市','1','jintan','3','320400',NULL,'金坛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320500','苏州市','1','suzhou','2','320000',NULL,'苏州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320501','市辖区','0','shixiaqu','3','320500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320505','虎丘区','1','huqiu','3','320500',NULL,'虎丘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320506','吴中区','1','wuzhong','3','320500',NULL,'吴中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320507','相城区','1','xiangcheng','3','320500',NULL,'相城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320508','姑苏区','1','gusu','3','320500',NULL,'姑苏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320509','吴江区','1','wujiang','3','320500',NULL,'吴江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320581','常熟市','1','changshu','3','320500',NULL,'常熟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320582','张家港市','1','zhangjiagang','3','320500',NULL,'张家港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320583','昆山市','1','kunshan','3','320500',NULL,'昆山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320585','太仓市','1','taicang','3','320500',NULL,'太仓');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320600','南通市','1','nantong','2','320000',NULL,'南通');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320601','市辖区','0','shixiaqu','3','320600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320602','崇川区','1','chongchuan','3','320600',NULL,'崇川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320611','港闸区','1','gangzha','3','320600',NULL,'港闸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320612','通州区','1','tongzhou','3','320600',NULL,'通州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320621','海安县','1','haian','3','320600',NULL,'海安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320623','如东县','1','rudong','3','320600',NULL,'如东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320681','启东市','1','qidong','3','320600',NULL,'启东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320682','如皋市','1','rugao','3','320600',NULL,'如皋');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320684','海门市','1','haimen','3','320600',NULL,'海门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320700','连云港市','1','lianyungang','2','320000',NULL,'连云港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320701','市辖区','0','shixiaqu','3','320700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320703','连云区','1','lianyun','3','320700',NULL,'连云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320705','新浦区','1','xinpu','3','320700',NULL,'新浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320706','海州区','1','haizhou','3','320700',NULL,'海州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320721','赣榆县','1','ganyu','3','320700',NULL,'赣榆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320722','东海县','1','donghai','3','320700',NULL,'东海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320723','灌云县','1','guanyun','3','320700',NULL,'灌云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320724','灌南县','1','guannan','3','320700',NULL,'灌南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320800','淮安市','1','huaian','2','320000',NULL,'淮安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320801','市辖区','0','shixiaqu','3','320800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320802','清河区','1','qinghe','3','320800',NULL,'清河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320803','淮安区','1','huaian','3','320800',NULL,'淮安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320804','淮阴区','1','huaiyin','3','320800',NULL,'淮阴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320811','清浦区','1','qingpu','3','320800',NULL,'清浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320826','涟水县','1','lianshui','3','320800',NULL,'涟水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320829','洪泽县','1','hongze','3','320800',NULL,'洪泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320830','盱眙县','1','xuyi','3','320800',NULL,'盱眙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320831','金湖县','1','jinhu','3','320800',NULL,'金湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320900','盐城市','1','yancheng','2','320000',NULL,'盐城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320901','市辖区','0','shixiaqu','3','320900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320902','亭湖区','1','tinghu','3','320900',NULL,'亭湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320903','盐都区','1','yandou','3','320900',NULL,'盐都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320921','响水县','1','xiangshui','3','320900',NULL,'响水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320922','滨海县','1','binhai','3','320900',NULL,'滨海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320923','阜宁县','1','funing','3','320900',NULL,'阜宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320924','射阳县','1','sheyang','3','320900',NULL,'射阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320925','建湖县','1','jianhu','3','320900',NULL,'建湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320981','东台市','1','dongtai','3','320900',NULL,'东台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('320982','大丰市','1','dafeng','3','320900',NULL,'大丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321000','扬州市','1','yangzhou','2','320000',NULL,'扬州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321001','市辖区','0','shixiaqu','3','321000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321002','广陵区','1','guangling','3','321000',NULL,'广陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321003','邗江区','1','hanjiang','3','321000',NULL,'邗江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321012','江都区','1','jiangdou','3','321000',NULL,'江都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321023','宝应县','1','baoying','3','321000',NULL,'宝应');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321031','开发区','1','kaifaqu','3','321000',NULL,'开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321081','仪征市','1','yizheng','3','321000',NULL,'仪征');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321084','高邮市','1','gaoyou','3','321000',NULL,'高邮');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321100','镇江市','1','zhenjiang','2','320000',NULL,'镇江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321101','市辖区','0','shixiaqu','3','321100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321102','京口区','1','jingkou','3','321100',NULL,'京口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321111','润州区','1','runzhou','3','321100',NULL,'润州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321112','丹徒区','1','dantu','3','321100',NULL,'丹徒');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321121','镇江新区','1','zhenjiangxinqu','3','321100',NULL,'镇江新区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321181','丹阳市','1','danyang','3','321100',NULL,'丹阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321182','扬中市','1','yangzhong','3','321100',NULL,'扬中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321183','句容市','1','jurong','3','321100',NULL,'句容');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321200','泰州市','1','taizhou','2','320000',NULL,'泰州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321201','市辖区','0','shixiaqu','3','321200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321202','海陵区','1','hailing','3','321200',NULL,'海陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321203','高港区','1','gaogang','3','321200',NULL,'高港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321281','兴化市','1','xinghua','3','321200',NULL,'兴化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321282','靖江市','1','jingjiang','3','321200',NULL,'靖江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321283','泰兴市','1','taixing','3','321200',NULL,'泰兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321284','姜堰市','1','jiangyan','3','321200',NULL,'姜堰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321300','宿迁市','1','suqian','2','320000',NULL,'宿迁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321301','市辖区','0','shixiaqu','3','321300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321302','宿城区','1','sucheng','3','321300',NULL,'宿城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321311','宿豫区','1','suyu','3','321300',NULL,'宿豫');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321322','沭阳县','1','shuyang','3','321300',NULL,'沭阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321323','泗阳县','1','siyang','3','321300',NULL,'泗阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('321324','泗洪县','1','sihong','3','321300',NULL,'泗洪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330000','浙江省','1','zhejiang','1','0',NULL,'浙江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330100','杭州市','1','hangzhou','2','330000',NULL,'杭州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330101','市辖区','0','shixiaqu','3','330100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330102','上城区','1','shangcheng','3','330100',NULL,'上城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330103','下城区','1','xiacheng','3','330100',NULL,'下城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330104','江干区','1','jianggan','3','330100',NULL,'江干');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330105','拱墅区','1','gongshu','3','330100',NULL,'拱墅');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330106','西湖区','1','xihu','3','330100',NULL,'西湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330108','滨江区','1','binjiang','3','330100',NULL,'滨江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330109','萧山区','1','xiaoshan','3','330100',NULL,'萧山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330110','余杭区','1','yuhang','3','330100',NULL,'余杭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330122','桐庐县','1','tonglu','3','330100',NULL,'桐庐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330127','淳安县','1','chunan','3','330100',NULL,'淳安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330182','建德市','1','jiande','3','330100',NULL,'建德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330183','富阳市','1','fuyang','3','330100',NULL,'富阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330185','临安市','1','linan','3','330100',NULL,'临安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330200','宁波市','1','ningbo','2','330000',NULL,'宁波');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330201','市辖区','0','shixiaqu','3','330200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330203','海曙区','1','haishu','3','330200',NULL,'海曙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330204','江东区','1','jiangdong','3','330200',NULL,'江东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330205','江北区','1','jiangbei','3','330200',NULL,'江北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330206','北仑区','1','beilun','3','330200',NULL,'北仑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330211','镇海区','1','zhenhai','3','330200',NULL,'镇海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330212','鄞州区','1','yinzhou','3','330200',NULL,'鄞州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330225','象山县','1','xiangshan','3','330200',NULL,'象山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330226','宁海县','1','ninghai','3','330200',NULL,'宁海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330281','余姚市','1','yuyao','3','330200',NULL,'余姚');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330282','慈溪市','1','cixi','3','330200',NULL,'慈溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330283','奉化市','1','fenghua','3','330200',NULL,'奉化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330300','温州市','1','wenzhou','2','330000',NULL,'温州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330301','市辖区','0','shixiaqu','3','330300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330302','鹿城区','1','lucheng','3','330300',NULL,'鹿城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330303','龙湾区','1','longwan','3','330300',NULL,'龙湾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330304','瓯海区','1','ouhai','3','330300',NULL,'瓯海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330322','洞头县','1','dongtou','3','330300',NULL,'洞头');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330324','永嘉县','1','yongjia','3','330300',NULL,'永嘉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330326','平阳县','1','pingyang','3','330300',NULL,'平阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330327','苍南县','1','cangnan','3','330300',NULL,'苍南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330328','文成县','1','wencheng','3','330300',NULL,'文成');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330329','泰顺县','1','taishun','3','330300',NULL,'泰顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330381','瑞安市','1','ruian','3','330300',NULL,'瑞安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330382','乐清市','1','leqing','3','330300',NULL,'乐清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330400','嘉兴市','1','jiaxing','2','330000',NULL,'嘉兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330401','市辖区','0','shixiaqu','3','330400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330402','南湖区','1','nanhu','3','330400',NULL,'南湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330411','秀洲区','1','xiuzhou','3','330400',NULL,'秀洲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330421','嘉善县','1','jiashan','3','330400',NULL,'嘉善');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330424','海盐县','1','haiyan','3','330400',NULL,'海盐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330481','海宁市','1','haining','3','330400',NULL,'海宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330482','平湖市','1','pinghu','3','330400',NULL,'平湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330483','桐乡市','1','tongxiang','3','330400',NULL,'桐乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330500','湖州市','1','huzhou','2','330000',NULL,'湖州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330501','市辖区','0','shixiaqu','3','330500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330502','吴兴区','1','wuxing','3','330500',NULL,'吴兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330503','南浔区','1','nanxun','3','330500',NULL,'南浔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330521','德清县','1','deqing','3','330500',NULL,'德清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330522','长兴县','1','zhangxing','3','330500',NULL,'长兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330523','安吉县','1','anji','3','330500',NULL,'安吉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330600','绍兴市','1','shaoxing','2','330000',NULL,'绍兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330601','市辖区','0','shixiaqu','3','330600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330602','越城区','1','yuecheng','3','330600',NULL,'越城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330621','绍兴县','1','shaoxing','3','330600',NULL,'绍兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330624','新昌县','1','xinchang','3','330600',NULL,'新昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330681','诸暨市','1','zhuji','3','330600',NULL,'诸暨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330682','上虞市','1','shangyu','3','330600',NULL,'上虞');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330683','嵊州市','1','shengzhou','3','330600',NULL,'嵊州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330700','金华市','1','jinhua','2','330000',NULL,'金华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330701','市辖区','0','shixiaqu','3','330700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330702','婺城区','1','wucheng','3','330700',NULL,'婺城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330703','金东区','1','jindong','3','330700',NULL,'金东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330723','武义县','1','wuyi','3','330700',NULL,'武义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330726','浦江县','1','pujiang','3','330700',NULL,'浦江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330727','磐安县','1','panan','3','330700',NULL,'磐安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330781','兰溪市','1','lanxi','3','330700',NULL,'兰溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330782','义乌市','1','yiwu','3','330700',NULL,'义乌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330783','东阳市','1','dongyang','3','330700',NULL,'东阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330784','永康市','1','yongkang','3','330700',NULL,'永康');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330800','衢州市','1','quzhou','2','330000',NULL,'衢州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330801','市辖区','0','shixiaqu','3','330800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330802','柯城区','1','kecheng','3','330800',NULL,'柯城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330803','衢江区','1','qujiang','3','330800',NULL,'衢江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330822','常山县','1','changshan','3','330800',NULL,'常山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330824','开化县','1','kaihua','3','330800',NULL,'开化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330825','龙游县','1','longyou','3','330800',NULL,'龙游');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330881','江山市','1','jiangshan','3','330800',NULL,'江山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330900','舟山市','1','zhoushan','2','330000',NULL,'舟山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330901','市辖区','0','shixiaqu','3','330900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330902','定海区','1','dinghai','3','330900',NULL,'定海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330903','普陀区','1','putuo','3','330900',NULL,'普陀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330921','岱山县','1','daishan','3','330900',NULL,'岱山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('330922','嵊泗县','1','shengsi','3','330900',NULL,'嵊泗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331000','台州市','1','taizhou','2','330000',NULL,'台州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331001','市辖区','0','shixiaqu','3','331000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331002','椒江区','1','jiaojiang','3','331000',NULL,'椒江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331003','黄岩区','1','huangyan','3','331000',NULL,'黄岩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331004','路桥区','1','luqiao','3','331000',NULL,'路桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331021','玉环县','1','yuhuan','3','331000',NULL,'玉环');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331022','三门县','1','sanmen','3','331000',NULL,'三门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331023','天台县','1','tiantai','3','331000',NULL,'天台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331024','仙居县','1','xianju','3','331000',NULL,'仙居');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331081','温岭市','1','wenling','3','331000',NULL,'温岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331082','临海市','1','linhai','3','331000',NULL,'临海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331100','丽水市','1','lishui','2','330000',NULL,'丽水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331101','市辖区','0','shixiaqu','3','331100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331102','莲都区','1','liandou','3','331100',NULL,'莲都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331121','青田县','1','qingtian','3','331100',NULL,'青田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331122','缙云县','1','jinyun','3','331100',NULL,'缙云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331123','遂昌县','1','suichang','3','331100',NULL,'遂昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331124','松阳县','1','songyang','3','331100',NULL,'松阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331125','云和县','1','yunhe','3','331100',NULL,'云和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331126','庆元县','1','qingyuan','3','331100',NULL,'庆元');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331127','景宁畲族自治县','1','jingningshezuzizhi','3','331100',NULL,'景宁畲族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('331181','龙泉市','1','longquan','3','331100',NULL,'龙泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340000','安徽省','1','anhui','1','0',NULL,'安徽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340100','合肥市','1','hefei','2','340000',NULL,'合肥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340101','市辖区','0','shixiaqu','3','340100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340102','瑶海区','1','yaohai','3','340100',NULL,'瑶海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340103','庐阳区','1','luyang','3','340100',NULL,'庐阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340104','蜀山区','1','shushan','3','340100',NULL,'蜀山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340111','包河区','1','baohe','3','340100',NULL,'包河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340121','长丰县','1','zhangfeng','3','340100',NULL,'长丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340122','肥东县','1','feidong','3','340100',NULL,'肥东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340123','肥西县','1','feixi','3','340100',NULL,'肥西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340124','庐江县','1','lujiang','3','340100',NULL,'庐江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340181','巢湖市','1','chaohu','3','340100',NULL,'巢湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340200','芜湖市','1','wuhu','2','340000',NULL,'芜湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340201','市辖区','0','shixiaqu','3','340200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340202','镜湖区','1','jinghu','3','340200',NULL,'镜湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340203','弋江区','1','yijiang','3','340200',NULL,'弋江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340207','鸠江区','1','jiujiang','3','340200',NULL,'鸠江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340208','三山区','1','sanshan','3','340200',NULL,'三山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340221','芜湖县','1','wuhu','3','340200',NULL,'芜湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340222','繁昌县','1','fanchang','3','340200',NULL,'繁昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340223','南陵县','1','nanling','3','340200',NULL,'南陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340225','无为县','1','wuwei','3','340200',NULL,'无为');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340300','蚌埠市','1','bangbu','2','340000',NULL,'蚌埠');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340301','市辖区','0','shixiaqu','3','340300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340302','龙子湖区','1','longzihu','3','340300',NULL,'龙子湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340303','蚌山区','1','bangshan','3','340300',NULL,'蚌山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340304','禹会区','1','yuhui','3','340300',NULL,'禹会');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340311','淮上区','1','huaishang','3','340300',NULL,'淮上');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340321','怀远县','1','huaiyuan','3','340300',NULL,'怀远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340322','五河县','1','wuhe','3','340300',NULL,'五河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340323','固镇县','1','guzhen','3','340300',NULL,'固镇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340400','淮南市','1','huainan','2','340000',NULL,'淮南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340401','市辖区','0','shixiaqu','3','340400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340402','大通区','1','datong','3','340400',NULL,'大通');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340403','田家庵区','1','tianjiaan','3','340400',NULL,'田家庵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340404','谢家集区','1','xiejiaji','3','340400',NULL,'谢家集');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340405','八公山区','1','bagongshan','3','340400',NULL,'八公山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340406','潘集区','1','panji','3','340400',NULL,'潘集');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340421','凤台县','1','fengtai','3','340400',NULL,'凤台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340500','马鞍山市','1','maanshan','2','340000',NULL,'马鞍山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340501','市辖区','0','shixiaqu','3','340500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340503','花山区','1','huashan','3','340500',NULL,'花山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340504','雨山区','1','yushan','3','340500',NULL,'雨山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340506','博望区','1','bowang','3','340500',NULL,'博望');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340521','当涂县','1','dangtu','3','340500',NULL,'当涂');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340522','含山县','1','hanshan','3','340500',NULL,'含山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340523','和县','1','hexian','3','340500',NULL,'和县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340600','淮北市','1','huaibei','2','340000',NULL,'淮北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340601','市辖区','0','shixiaqu','3','340600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340602','杜集区','1','duji','3','340600',NULL,'杜集');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340603','相山区','1','xiangshan','3','340600',NULL,'相山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340604','烈山区','1','lieshan','3','340600',NULL,'烈山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340621','濉溪县','1','suixi','3','340600',NULL,'濉溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340700','铜陵市','1','tongling','2','340000',NULL,'铜陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340701','市辖区','0','shixiaqu','3','340700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340702','铜官山区','1','tongguanshan','3','340700',NULL,'铜官山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340703','狮子山区','1','shizishan','3','340700',NULL,'狮子山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340711','郊区','1','jiaoqu','3','340700',NULL,'郊区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340721','铜陵县','1','tongling','3','340700',NULL,'铜陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340800','安庆市','1','anqing','2','340000',NULL,'安庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340801','市辖区','0','shixiaqu','3','340800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340802','迎江区','1','yingjiang','3','340800',NULL,'迎江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340803','大观区','1','daguan','3','340800',NULL,'大观');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340811','宜秀区','1','yixiu','3','340800',NULL,'宜秀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340822','怀宁县','1','huaining','3','340800',NULL,'怀宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340823','枞阳县','1','zongyang','3','340800',NULL,'枞阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340824','潜山县','1','qianshan','3','340800',NULL,'潜山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340825','太湖县','1','taihu','3','340800',NULL,'太湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340826','宿松县','1','susong','3','340800',NULL,'宿松');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340827','望江县','1','wangjiang','3','340800',NULL,'望江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340828','岳西县','1','yuexi','3','340800',NULL,'岳西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('340881','桐城市','1','tongcheng','3','340800',NULL,'桐城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341000','黄山市','1','huangshan','2','340000',NULL,'黄山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341001','市辖区','0','shixiaqu','3','341000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341002','屯溪区','1','tunxi','3','341000',NULL,'屯溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341003','黄山区','1','huangshan','3','341000',NULL,'黄山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341004','徽州区','1','huizhou','3','341000',NULL,'徽州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341021','歙县','1','shexian','3','341000',NULL,'歙县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341022','休宁县','1','xiuning','3','341000',NULL,'休宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341023','黟县','1','yixian','3','341000',NULL,'黟县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341024','祁门县','1','qimen','3','341000',NULL,'祁门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341100','滁州市','1','chuzhou','2','340000',NULL,'滁州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341101','市辖区','0','shixiaqu','3','341100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341102','琅琊区','1','langya','3','341100',NULL,'琅琊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341103','南谯区','1','nanqiao','3','341100',NULL,'南谯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341122','来安县','1','laian','3','341100',NULL,'来安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341124','全椒县','1','quanjiao','3','341100',NULL,'全椒');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341125','定远县','1','dingyuan','3','341100',NULL,'定远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341126','凤阳县','1','fengyang','3','341100',NULL,'凤阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341181','天长市','1','tianzhang','3','341100',NULL,'天长');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341182','明光市','1','mingguang','3','341100',NULL,'明光');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341200','阜阳市','1','fuyang','2','340000',NULL,'阜阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341201','市辖区','0','shixiaqu','3','341200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341202','颍州区','1','yingzhou','3','341200',NULL,'颍州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341203','颍东区','1','yingdong','3','341200',NULL,'颍东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341204','颍泉区','1','yingquan','3','341200',NULL,'颍泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341221','临泉县','1','linquan','3','341200',NULL,'临泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341222','太和县','1','taihe','3','341200',NULL,'太和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341225','阜南县','1','funan','3','341200',NULL,'阜南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341226','颍上县','1','yingshang','3','341200',NULL,'颍上');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341282','界首市','1','jieshou','3','341200',NULL,'界首');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341300','宿州市','1','suzhou','2','340000',NULL,'宿州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341301','市辖区','0','shixiaqu','3','341300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341302','埇桥区','1','yongqiao','3','341300',NULL,'埇桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341321','砀山县','1','dangshan','3','341300',NULL,'砀山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341322','萧县','1','xiaoxian','3','341300',NULL,'萧县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341323','灵璧县','1','lingbi','3','341300',NULL,'灵璧');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341324','泗县','1','sixian','3','341300',NULL,'泗县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341500','六安市','1','liuan','2','340000',NULL,'六安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341501','市辖区','0','shixiaqu','3','341500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341502','金安区','1','jinan','3','341500',NULL,'金安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341503','裕安区','1','yuan','3','341500',NULL,'裕安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341521','寿县','1','shouxian','3','341500',NULL,'寿县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341522','霍邱县','1','huoqiu','3','341500',NULL,'霍邱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341523','舒城县','1','shucheng','3','341500',NULL,'舒城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341524','金寨县','1','jinzhai','3','341500',NULL,'金寨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341525','霍山县','1','huoshan','3','341500',NULL,'霍山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341600','亳州市','1','bozhou','2','340000',NULL,'亳州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341601','市辖区','0','shixiaqu','3','341600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341602','谯城区','1','qiaocheng','3','341600',NULL,'谯城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341621','涡阳县','1','woyang','3','341600',NULL,'涡阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341622','蒙城县','1','mengcheng','3','341600',NULL,'蒙城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341623','利辛县','1','lixin','3','341600',NULL,'利辛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341700','池州市','1','chizhou','2','340000',NULL,'池州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341701','市辖区','0','shixiaqu','3','341700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341702','贵池区','1','guichi','3','341700',NULL,'贵池');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341721','东至县','1','dongzhi','3','341700',NULL,'东至');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341722','石台县','1','shitai','3','341700',NULL,'石台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341723','青阳县','1','qingyang','3','341700',NULL,'青阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341800','宣城市','1','xuancheng','2','340000',NULL,'宣城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341801','市辖区','0','shixiaqu','3','341800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341802','宣州区','1','xuanzhou','3','341800',NULL,'宣州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341821','郎溪县','1','langxi','3','341800',NULL,'郎溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341822','广德县','1','guangde','3','341800',NULL,'广德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341823','泾县','1','jingxian','3','341800',NULL,'泾县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341824','绩溪县','1','jixi','3','341800',NULL,'绩溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341825','旌德县','1','jingde','3','341800',NULL,'旌德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('341881','宁国市','1','ningguo','3','341800',NULL,'宁国');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350000','福建省','1','fujian','1','0',NULL,'福建');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350100','福州市','1','fuzhou','2','350000',NULL,'福州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350101','市辖区','0','shixiaqu','3','350100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350102','鼓楼区','1','gulou','3','350100',NULL,'鼓楼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350103','台江区','1','taijiang','3','350100',NULL,'台江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350104','仓山区','1','cangshan','3','350100',NULL,'仓山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350105','马尾区','1','mawei','3','350100',NULL,'马尾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350111','晋安区','1','jinan','3','350100',NULL,'晋安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350121','闽侯县','1','minhou','3','350100',NULL,'闽侯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350122','连江县','1','lianjiang','3','350100',NULL,'连江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350123','罗源县','1','luoyuan','3','350100',NULL,'罗源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350124','闽清县','1','minqing','3','350100',NULL,'闽清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350125','永泰县','1','yongtai','3','350100',NULL,'永泰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350128','平潭县','1','pingtan','3','350100',NULL,'平潭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350181','福清市','1','fuqing','3','350100',NULL,'福清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350182','长乐市','1','zhangle','3','350100',NULL,'长乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350200','厦门市','1','shamen','2','350000',NULL,'厦门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350201','市辖区','0','shixiaqu','3','350200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350203','思明区','1','siming','3','350200',NULL,'思明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350205','海沧区','1','haicang','3','350200',NULL,'海沧');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350206','湖里区','1','huli','3','350200',NULL,'湖里');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350211','集美区','1','jimei','3','350200',NULL,'集美');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350212','同安区','1','tongan','3','350200',NULL,'同安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350213','翔安区','1','xiangan','3','350200',NULL,'翔安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350300','莆田市','1','putian','2','350000',NULL,'莆田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350301','市辖区','0','shixiaqu','3','350300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350302','城厢区','1','chengxiang','3','350300',NULL,'城厢');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350303','涵江区','1','hanjiang','3','350300',NULL,'涵江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350304','荔城区','1','licheng','3','350300',NULL,'荔城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350305','秀屿区','1','xiuyu','3','350300',NULL,'秀屿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350322','仙游县','1','xianyou','3','350300',NULL,'仙游');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350400','三明市','1','sanming','2','350000',NULL,'三明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350401','市辖区','0','shixiaqu','3','350400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350402','梅列区','1','meilie','3','350400',NULL,'梅列');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350403','三元区','1','sanyuan','3','350400',NULL,'三元');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350421','明溪县','1','mingxi','3','350400',NULL,'明溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350423','清流县','1','qingliu','3','350400',NULL,'清流');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350424','宁化县','1','ninghua','3','350400',NULL,'宁化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350425','大田县','1','datian','3','350400',NULL,'大田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350426','尤溪县','1','youxi','3','350400',NULL,'尤溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350427','沙县','1','shaxian','3','350400',NULL,'沙县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350428','将乐县','1','jiangle','3','350400',NULL,'将乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350429','泰宁县','1','taining','3','350400',NULL,'泰宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350430','建宁县','1','jianning','3','350400',NULL,'建宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350481','永安市','1','yongan','3','350400',NULL,'永安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350500','泉州市','1','quanzhou','2','350000',NULL,'泉州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350501','市辖区','0','shixiaqu','3','350500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350502','鲤城区','1','licheng','3','350500',NULL,'鲤城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350503','丰泽区','1','fengze','3','350500',NULL,'丰泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350504','洛江区','1','luojiang','3','350500',NULL,'洛江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350505','泉港区','1','quangang','3','350500',NULL,'泉港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350521','惠安县','1','huian','3','350500',NULL,'惠安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350524','安溪县','1','anxi','3','350500',NULL,'安溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350525','永春县','1','yongchun','3','350500',NULL,'永春');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350526','德化县','1','dehua','3','350500',NULL,'德化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350527','金门县','0','jinmen','3','350500',NULL,'金门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350581','石狮市','1','shishi','3','350500',NULL,'石狮');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350582','晋江市','1','jinjiang','3','350500',NULL,'晋江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350583','南安市','1','nanan','3','350500',NULL,'南安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350600','漳州市','1','zhangzhou','2','350000',NULL,'漳州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350601','市辖区','0','shixiaqu','3','350600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350602','芗城区','1','xiangcheng','3','350600',NULL,'芗城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350603','龙文区','1','longwen','3','350600',NULL,'龙文');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350622','云霄县','1','yunxiao','3','350600',NULL,'云霄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350623','漳浦县','1','zhangpu','3','350600',NULL,'漳浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350624','诏安县','1','zhaoan','3','350600',NULL,'诏安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350625','长泰县','1','zhangtai','3','350600',NULL,'长泰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350626','东山县','1','dongshan','3','350600',NULL,'东山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350627','南靖县','1','nanjing','3','350600',NULL,'南靖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350628','平和县','1','pinghe','3','350600',NULL,'平和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350629','华安县','1','huaan','3','350600',NULL,'华安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350681','龙海市','1','longhai','3','350600',NULL,'龙海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350700','南平市','1','nanping','2','350000',NULL,'南平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350701','市辖区','0','shixiaqu','3','350700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350702','延平区','1','yanping','3','350700',NULL,'延平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350721','顺昌县','1','shunchang','3','350700',NULL,'顺昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350722','浦城县','1','pucheng','3','350700',NULL,'浦城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350723','光泽县','1','guangze','3','350700',NULL,'光泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350724','松溪县','1','songxi','3','350700',NULL,'松溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350725','政和县','1','zhenghe','3','350700',NULL,'政和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350781','邵武市','1','shaowu','3','350700',NULL,'邵武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350782','武夷山市','1','wuyishan','3','350700',NULL,'武夷山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350783','建瓯市','1','jianou','3','350700',NULL,'建瓯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350784','建阳市','1','jianyang','3','350700',NULL,'建阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350800','龙岩市','1','longyan','2','350000',NULL,'龙岩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350801','市辖区','0','shixiaqu','3','350800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350802','新罗区','1','xinluo','3','350800',NULL,'新罗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350821','长汀县','1','zhangting','3','350800',NULL,'长汀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350822','永定县','1','yongding','3','350800',NULL,'永定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350823','上杭县','1','shanghang','3','350800',NULL,'上杭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350824','武平县','1','wuping','3','350800',NULL,'武平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350825','连城县','1','liancheng','3','350800',NULL,'连城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350881','漳平市','1','zhangping','3','350800',NULL,'漳平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350900','宁德市','1','ningde','2','350000',NULL,'宁德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350901','市辖区','0','shixiaqu','3','350900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350902','蕉城区','1','jiaocheng','3','350900',NULL,'蕉城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350921','霞浦县','1','xiapu','3','350900',NULL,'霞浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350922','古田县','1','gutian','3','350900',NULL,'古田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350923','屏南县','1','pingnan','3','350900',NULL,'屏南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350924','寿宁县','1','shouning','3','350900',NULL,'寿宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350925','周宁县','1','zhouning','3','350900',NULL,'周宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350926','柘荣县','1','zherong','3','350900',NULL,'柘荣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350981','福安市','1','fuan','3','350900',NULL,'福安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('350982','福鼎市','1','fuding','3','350900',NULL,'福鼎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360000','江西省','1','jiangxi','1','0',NULL,'江西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360100','南昌市','1','nanchang','2','360000',NULL,'南昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360101','市辖区','0','shixiaqu','3','360100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360102','东湖区','1','donghu','3','360100',NULL,'东湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360103','西湖区','1','xihu','3','360100',NULL,'西湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360104','青云谱区','1','qingyunpu','3','360100',NULL,'青云谱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360105','湾里区','1','wanli','3','360100',NULL,'湾里');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360111','青山湖区','1','qingshanhu','3','360100',NULL,'青山湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360121','南昌县','1','nanchang','3','360100',NULL,'南昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360122','新建县','1','xinjian','3','360100',NULL,'新建');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360123','安义县','1','anyi','3','360100',NULL,'安义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360124','进贤县','1','jinxian','3','360100',NULL,'进贤');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360125','红谷滩区','1','honggutan','3','360100',NULL,'红谷滩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360200','景德镇市','1','jingdezhen','2','360000',NULL,'景德镇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360201','市辖区','0','shixiaqu','3','360200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360202','昌江区','1','changjiang','3','360200',NULL,'昌江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360203','珠山区','1','zhushan','3','360200',NULL,'珠山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360222','浮梁县','1','fuliang','3','360200',NULL,'浮梁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360281','乐平市','1','leping','3','360200',NULL,'乐平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360300','萍乡市','1','pingxiang','2','360000',NULL,'萍乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360301','市辖区','0','shixiaqu','3','360300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360302','安源区','1','anyuan','3','360300',NULL,'安源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360313','湘东区','1','xiangdong','3','360300',NULL,'湘东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360321','莲花县','1','lianhua','3','360300',NULL,'莲花');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360322','上栗县','1','shangli','3','360300',NULL,'上栗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360323','芦溪县','1','luxi','3','360300',NULL,'芦溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360400','九江市','1','jiujiang','2','360000',NULL,'九江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360401','市辖区','0','shixiaqu','3','360400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360402','庐山区','1','lushan','3','360400',NULL,'庐山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360403','浔阳区','1','xunyang','3','360400',NULL,'浔阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360421','九江县','1','jiujiang','3','360400',NULL,'九江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360423','武宁县','1','wuning','3','360400',NULL,'武宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360424','修水县','1','xiushui','3','360400',NULL,'修水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360425','永修县','1','yongxiu','3','360400',NULL,'永修');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360426','德安县','1','dean','3','360400',NULL,'德安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360427','星子县','1','xingzi','3','360400',NULL,'星子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360428','都昌县','1','douchang','3','360400',NULL,'都昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360429','湖口县','1','hukou','3','360400',NULL,'湖口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360430','彭泽县','1','pengze','3','360400',NULL,'彭泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360481','瑞昌市','1','ruichang','3','360400',NULL,'瑞昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360482','共青城市','1','gongqingcheng','3','360400',NULL,'共青城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360500','新余市','1','xinyu','2','360000',NULL,'新余');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360501','市辖区','0','shixiaqu','3','360500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360502','渝水区','1','yushui','3','360500',NULL,'渝水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360521','分宜县','1','fenyi','3','360500',NULL,'分宜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360600','鹰潭市','1','yingtan','2','360000',NULL,'鹰潭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360601','市辖区','0','shixiaqu','3','360600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360602','月湖区','1','yuehu','3','360600',NULL,'月湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360622','余江县','1','yujiang','3','360600',NULL,'余江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360681','贵溪市','1','guixi','3','360600',NULL,'贵溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360700','赣州市','1','ganzhou','2','360000',NULL,'赣州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360701','市辖区','0','shixiaqu','3','360700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360702','章贡区','1','zhanggong','3','360700',NULL,'章贡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360721','赣县','1','ganxian','3','360700',NULL,'赣县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360722','信丰县','1','xinfeng','3','360700',NULL,'信丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360723','大余县','1','dayu','3','360700',NULL,'大余');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360724','上犹县','1','shangyou','3','360700',NULL,'上犹');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360725','崇义县','1','chongyi','3','360700',NULL,'崇义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360726','安远县','1','anyuan','3','360700',NULL,'安远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360727','龙南县','1','longnan','3','360700',NULL,'龙南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360728','定南县','1','dingnan','3','360700',NULL,'定南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360729','全南县','1','quannan','3','360700',NULL,'全南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360730','宁都县','1','ningdou','3','360700',NULL,'宁都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360731','于都县','1','yudou','3','360700',NULL,'于都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360732','兴国县','1','xingguo','3','360700',NULL,'兴国');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360733','会昌县','1','huichang','3','360700',NULL,'会昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360734','寻乌县','1','xunwu','3','360700',NULL,'寻乌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360735','石城县','1','shicheng','3','360700',NULL,'石城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360781','瑞金市','1','ruijin','3','360700',NULL,'瑞金');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360782','南康市','1','nankang','3','360700',NULL,'南康');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360800','吉安市','1','jian','2','360000',NULL,'吉安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360801','市辖区','0','shixiaqu','3','360800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360802','吉州区','1','jizhou','3','360800',NULL,'吉州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360803','青原区','1','qingyuan','3','360800',NULL,'青原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360821','吉安县','1','jian','3','360800',NULL,'吉安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360822','吉水县','1','jishui','3','360800',NULL,'吉水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360823','峡江县','1','xiajiang','3','360800',NULL,'峡江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360824','新干县','1','xingan','3','360800',NULL,'新干');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360825','永丰县','1','yongfeng','3','360800',NULL,'永丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360826','泰和县','1','taihe','3','360800',NULL,'泰和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360827','遂川县','1','suichuan','3','360800',NULL,'遂川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360828','万安县','1','wanan','3','360800',NULL,'万安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360829','安福县','1','anfu','3','360800',NULL,'安福');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360830','永新县','1','yongxin','3','360800',NULL,'永新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360881','井冈山市','1','jinggangshan','3','360800',NULL,'井冈山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360900','宜春市','1','yichun','2','360000',NULL,'宜春');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360901','市辖区','0','shixiaqu','3','360900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360902','袁州区','1','yuanzhou','3','360900',NULL,'袁州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360921','奉新县','1','fengxin','3','360900',NULL,'奉新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360922','万载县','1','wanzai','3','360900',NULL,'万载');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360923','上高县','1','shanggao','3','360900',NULL,'上高');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360924','宜丰县','1','yifeng','3','360900',NULL,'宜丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360925','靖安县','1','jingan','3','360900',NULL,'靖安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360926','铜鼓县','1','tonggu','3','360900',NULL,'铜鼓');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360981','丰城市','1','fengcheng','3','360900',NULL,'丰城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360982','樟树市','1','zhangshu','3','360900',NULL,'樟树');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('360983','高安市','1','gaoan','3','360900',NULL,'高安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361000','抚州市','1','fuzhou','2','360000',NULL,'抚州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361001','市辖区','0','shixiaqu','3','361000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361002','临川区','1','linchuan','3','361000',NULL,'临川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361021','南城县','1','nancheng','3','361000',NULL,'南城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361022','黎川县','1','lichuan','3','361000',NULL,'黎川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361023','南丰县','1','nanfeng','3','361000',NULL,'南丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361024','崇仁县','1','chongren','3','361000',NULL,'崇仁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361025','乐安县','1','lean','3','361000',NULL,'乐安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361026','宜黄县','1','yihuang','3','361000',NULL,'宜黄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361027','金溪县','1','jinxi','3','361000',NULL,'金溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361028','资溪县','1','zixi','3','361000',NULL,'资溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361029','东乡县','1','dongxiang','3','361000',NULL,'东乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361030','广昌县','1','guangchang','3','361000',NULL,'广昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361100','上饶市','1','shangrao','2','360000',NULL,'上饶');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361101','市辖区','0','shixiaqu','3','361100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361102','信州区','1','xinzhou','3','361100',NULL,'信州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361121','上饶县','1','shangrao','3','361100',NULL,'上饶');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361122','广丰县','1','guangfeng','3','361100',NULL,'广丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361123','玉山县','1','yushan','3','361100',NULL,'玉山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361124','铅山县','1','qianshan','3','361100',NULL,'铅山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361125','横峰县','1','hengfeng','3','361100',NULL,'横峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361126','弋阳县','1','yiyang','3','361100',NULL,'弋阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361127','余干县','1','yugan','3','361100',NULL,'余干');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361128','鄱阳县','1','poyang','3','361100',NULL,'鄱阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361129','万年县','1','wannian','3','361100',NULL,'万年');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361130','婺源县','1','wuyuan','3','361100',NULL,'婺源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('361181','德兴市','1','dexing','3','361100',NULL,'德兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370000','山东省','1','shandong','1','0',NULL,'山东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370100','济南市','1','jinan','2','370000',NULL,'济南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370101','市辖区','0','shixiaqu','3','370100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370102','历下区','1','lixia','3','370100',NULL,'历下');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370103','市中区','1','shizhong','3','370100',NULL,'市中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370104','槐荫区','1','huaiyin','3','370100',NULL,'槐荫');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370105','天桥区','1','tianqiao','3','370100',NULL,'天桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370112','历城区','1','licheng','3','370100',NULL,'历城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370113','长清区','1','zhangqing','3','370100',NULL,'长清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370124','平阴县','1','pingyin','3','370100',NULL,'平阴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370125','济阳县','1','jiyang','3','370100',NULL,'济阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370126','商河县','1','shanghe','3','370100',NULL,'商河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370181','章丘市','1','zhangqiu','3','370100',NULL,'章丘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370200','青岛市','1','qingdao','2','370000',NULL,'青岛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370201','市辖区','0','shixiaqu','3','370200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370202','市南区','1','shinan','3','370200',NULL,'市南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370203','市北区','1','shibei','3','370200',NULL,'市北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370205','四方区','1','sifang','3','370200',NULL,'四方');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370211','黄岛区','1','huangdao','3','370200',NULL,'黄岛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370212','崂山区','1','laoshan','3','370200',NULL,'崂山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370213','李沧区','1','licang','3','370200',NULL,'李沧');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370214','城阳区','1','chengyang','3','370200',NULL,'城阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370281','胶州市','1','jiaozhou','3','370200',NULL,'胶州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370282','即墨市','1','jimo','3','370200',NULL,'即墨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370283','平度市','1','pingdu','3','370200',NULL,'平度');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370284','胶南市','1','jiaonan','3','370200',NULL,'胶南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370285','莱西市','1','laixi','3','370200',NULL,'莱西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370300','淄博市','1','zibo','2','370000',NULL,'淄博');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370301','市辖区','0','shixiaqu','3','370300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370302','淄川区','1','zichuan','3','370300',NULL,'淄川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370303','张店区','1','zhangdian','3','370300',NULL,'张店');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370304','博山区','1','boshan','3','370300',NULL,'博山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370305','临淄区','1','linzi','3','370300',NULL,'临淄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370306','周村区','1','zhoucun','3','370300',NULL,'周村');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370321','桓台县','1','huantai','3','370300',NULL,'桓台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370322','高青县','1','gaoqing','3','370300',NULL,'高青');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370323','沂源县','1','yiyuan','3','370300',NULL,'沂源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370400','枣庄市','1','zaozhuang','2','370000',NULL,'枣庄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370401','市辖区','0','shixiaqu','3','370400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370402','市中区','1','shizhong','3','370400',NULL,'市中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370403','薛城区','1','xuecheng','3','370400',NULL,'薛城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370404','峄城区','1','yicheng','3','370400',NULL,'峄城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370405','台儿庄区','1','taierzhuang','3','370400',NULL,'台儿庄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370406','山亭区','1','shanting','3','370400',NULL,'山亭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370481','滕州市','1','tengzhou','3','370400',NULL,'滕州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370500','东营市','1','dongying','2','370000',NULL,'东营');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370501','市辖区','0','shixiaqu','3','370500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370502','东营区','1','dongying','3','370500',NULL,'东营');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370503','河口区','1','hekou','3','370500',NULL,'河口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370521','垦利县','1','kenli','3','370500',NULL,'垦利');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370522','利津县','1','lijin','3','370500',NULL,'利津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370523','广饶县','1','guangrao','3','370500',NULL,'广饶');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370600','烟台市','1','yantai','2','370000',NULL,'烟台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370601','市辖区','0','shixiaqu','3','370600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370602','芝罘区','1','zhifu','3','370600',NULL,'芝罘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370611','福山区','1','fushan','3','370600',NULL,'福山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370612','牟平区','1','mouping','3','370600',NULL,'牟平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370613','莱山区','1','laishan','3','370600',NULL,'莱山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370634','长岛县','1','zhangdao','3','370600',NULL,'长岛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370641','高新区','1','gaoxinqu','3','370600',NULL,'高新区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370651','开发区','1','kaifaqu','3','370600',NULL,'开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370681','龙口市','1','longkou','3','370600',NULL,'龙口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370682','莱阳市','1','laiyang','3','370600',NULL,'莱阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370683','莱州市','1','laizhou','3','370600',NULL,'莱州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370684','蓬莱市','1','penglai','3','370600',NULL,'蓬莱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370685','招远市','1','zhaoyuan','3','370600',NULL,'招远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370686','栖霞市','1','qixia','3','370600',NULL,'栖霞');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370687','海阳市','1','haiyang','3','370600',NULL,'海阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370700','潍坊市','1','weifang','2','370000',NULL,'潍坊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370701','市辖区','0','shixiaqu','3','370700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370702','潍城区','1','weicheng','3','370700',NULL,'潍城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370703','寒亭区','1','hanting','3','370700',NULL,'寒亭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370704','坊子区','1','fangzi','3','370700',NULL,'坊子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370705','奎文区','1','kuiwen','3','370700',NULL,'奎文');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370724','临朐县','1','linqu','3','370700',NULL,'临朐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370725','昌乐县','1','changle','3','370700',NULL,'昌乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370781','青州市','1','qingzhou','3','370700',NULL,'青州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370782','诸城市','1','zhucheng','3','370700',NULL,'诸城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370783','寿光市','1','shouguang','3','370700',NULL,'寿光');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370784','安丘市','1','anqiu','3','370700',NULL,'安丘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370785','高密市','1','gaomi','3','370700',NULL,'高密');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370786','昌邑市','1','changyi','3','370700',NULL,'昌邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370800','济宁市','1','jining','2','370000',NULL,'济宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370801','市辖区','0','shixiaqu','3','370800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370802','市中区','1','shizhong','3','370800',NULL,'市中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370811','任城区','1','rencheng','3','370800',NULL,'任城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370826','微山县','1','weishan','3','370800',NULL,'微山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370827','鱼台县','1','yutai','3','370800',NULL,'鱼台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370828','金乡县','1','jinxiang','3','370800',NULL,'金乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370829','嘉祥县','1','jiaxiang','3','370800',NULL,'嘉祥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370830','汶上县','1','wenshang','3','370800',NULL,'汶上');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370831','泗水县','1','sishui','3','370800',NULL,'泗水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370832','梁山县','1','liangshan','3','370800',NULL,'梁山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370881','曲阜市','1','qufu','3','370800',NULL,'曲阜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370882','兖州市','1','yanzhou','3','370800',NULL,'兖州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370883','邹城市','1','zoucheng','3','370800',NULL,'邹城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370900','泰安市','1','taian','2','370000',NULL,'泰安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370901','市辖区','0','shixiaqu','3','370900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370902','泰山区','1','taishan','3','370900',NULL,'泰山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370911','岱岳区','1','daiyue','3','370900',NULL,'岱岳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370921','宁阳县','1','ningyang','3','370900',NULL,'宁阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370923','东平县','1','dongping','3','370900',NULL,'东平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370982','新泰市','1','xintai','3','370900',NULL,'新泰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('370983','肥城市','1','feicheng','3','370900',NULL,'肥城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371000','威海市','1','weihai','2','370000',NULL,'威海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371001','市辖区','0','shixiaqu','3','371000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371002','环翠区','1','huancui','3','371000',NULL,'环翠');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371081','文登市','1','wendeng','3','371000',NULL,'文登');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371082','荣成市','1','rongcheng','3','371000',NULL,'荣成');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371083','乳山市','1','rushan','3','371000',NULL,'乳山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371100','日照市','1','rizhao','2','370000',NULL,'日照');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371101','市辖区','0','shixiaqu','3','371100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371102','东港区','1','donggang','3','371100',NULL,'东港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371103','岚山区','1','lanshan','3','371100',NULL,'岚山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371121','五莲县','1','wulian','3','371100',NULL,'五莲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371122','莒县','1','juxian','3','371100',NULL,'莒县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371200','莱芜市','1','laiwu','2','370000',NULL,'莱芜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371201','市辖区','0','shixiaqu','3','371200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371202','莱城区','1','laicheng','3','371200',NULL,'莱城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371203','钢城区','1','gangcheng','3','371200',NULL,'钢城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371300','临沂市','1','linyi','2','370000',NULL,'临沂');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371301','市辖区','0','shixiaqu','3','371300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371302','兰山区','1','lanshan','3','371300',NULL,'兰山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371311','罗庄区','1','luozhuang','3','371300',NULL,'罗庄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371312','河东区','1','hedong','3','371300',NULL,'河东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371321','沂南县','1','yinan','3','371300',NULL,'沂南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371322','郯城县','1','tancheng','3','371300',NULL,'郯城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371323','沂水县','1','yishui','3','371300',NULL,'沂水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371324','苍山县','1','cangshan','3','371300',NULL,'苍山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371325','费县','1','feixian','3','371300',NULL,'费县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371326','平邑县','1','pingyi','3','371300',NULL,'平邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371327','莒南县','1','junan','3','371300',NULL,'莒南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371328','蒙阴县','1','mengyin','3','371300',NULL,'蒙阴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371329','临沭县','1','linshu','3','371300',NULL,'临沭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371400','德州市','1','dezhou','2','370000',NULL,'德州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371401','市辖区','0','shixiaqu','3','371400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371402','德城区','1','decheng','3','371400',NULL,'德城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371421','陵县','1','lingxian','3','371400',NULL,'陵县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371422','宁津县','1','ningjin','3','371400',NULL,'宁津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371423','庆云县','1','qingyun','3','371400',NULL,'庆云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371424','临邑县','1','linyi','3','371400',NULL,'临邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371425','齐河县','1','qihe','3','371400',NULL,'齐河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371426','平原县','1','pingyuan','3','371400',NULL,'平原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371427','夏津县','1','xiajin','3','371400',NULL,'夏津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371428','武城县','1','wucheng','3','371400',NULL,'武城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371481','乐陵市','1','leling','3','371400',NULL,'乐陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371482','禹城市','1','yucheng','3','371400',NULL,'禹城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371500','聊城市','1','liaocheng','2','370000',NULL,'聊城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371501','市辖区','0','shixiaqu','3','371500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371502','东昌府区','1','dongchangfu','3','371500',NULL,'东昌府');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371521','阳谷县','1','yanggu','3','371500',NULL,'阳谷');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371522','莘县','1','xinxian','3','371500',NULL,'莘县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371523','茌平县','1','chiping','3','371500',NULL,'茌平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371524','东阿县','1','donga','3','371500',NULL,'东阿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371525','冠县','1','guanxian','3','371500',NULL,'冠县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371526','高唐县','1','gaotang','3','371500',NULL,'高唐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371581','临清市','1','linqing','3','371500',NULL,'临清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371600','滨州市','1','binzhou','2','370000',NULL,'滨州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371601','市辖区','0','shixiaqu','3','371600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371602','滨城区','1','bincheng','3','371600',NULL,'滨城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371621','惠民县','1','huimin','3','371600',NULL,'惠民');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371622','阳信县','1','yangxin','3','371600',NULL,'阳信');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371623','无棣县','1','wudi','3','371600',NULL,'无棣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371624','沾化县','1','zhanhua','3','371600',NULL,'沾化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371625','博兴县','1','boxing','3','371600',NULL,'博兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371626','邹平县','1','zouping','3','371600',NULL,'邹平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371700','菏泽市','1','heze','2','370000',NULL,'菏泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371701','市辖区','0','shixiaqu','3','371700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371702','牡丹区','1','mudan','3','371700',NULL,'牡丹');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371721','曹县','1','caoxian','3','371700',NULL,'曹县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371722','单县','1','danxian','3','371700',NULL,'单县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371723','成武县','1','chengwu','3','371700',NULL,'成武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371724','巨野县','1','juye','3','371700',NULL,'巨野');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371725','郓城县','1','yuncheng','3','371700',NULL,'郓城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371726','鄄城县','1','juancheng','3','371700',NULL,'鄄城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371727','定陶县','1','dingtao','3','371700',NULL,'定陶');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('371728','东明县','1','dongming','3','371700',NULL,'东明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410000','河南省','1','henan','1','0',NULL,'河南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410100','郑州市','1','zhengzhou','2','410000',NULL,'郑州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410101','市辖区','0','shixiaqu','3','410100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410102','中原区','1','zhongyuan','3','410100',NULL,'中原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410103','二七区','1','erqi','3','410100',NULL,'二七');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410104','管城回族区','1','guanchenghuizu','3','410100',NULL,'管城回族');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410105','金水区','1','jinshui','3','410100',NULL,'金水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410106','上街区','1','shangjie','3','410100',NULL,'上街');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410108','惠济区','1','huiji','3','410100',NULL,'惠济');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410122','中牟县','1','zhongmou','3','410100',NULL,'中牟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410131','郑东新区','1','zhengdong','3','410100',NULL,'郑东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410141','高新技术开发区','1','gaoxinjishukaifaqu','3','410100',NULL,'高新技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410151','经济技术开发区','1','jingjijishukaifaqu','3','410100',NULL,'经济技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410181','巩义市','1','gongyi','3','410100',NULL,'巩义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410182','荥阳市','1','yingyang','3','410100',NULL,'荥阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410183','新密市','1','xinmi','3','410100',NULL,'新密');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410184','新郑市','1','xinzheng','3','410100',NULL,'新郑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410185','登封市','1','dengfeng','3','410100',NULL,'登封');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410200','开封市','1','kaifeng','2','410000',NULL,'开封');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410201','市辖区','0','shixiaqu','3','410200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410202','龙亭区','1','longting','3','410200',NULL,'龙亭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410203','顺河回族区','1','shunhehuizu','3','410200',NULL,'顺河回族');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410204','鼓楼区','1','gulou','3','410200',NULL,'鼓楼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410205','禹王台区','1','yuwangtai','3','410200',NULL,'禹王台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410211','金明区','1','jinming','3','410200',NULL,'金明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410221','杞县','1','qixian','3','410200',NULL,'杞县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410222','通许县','1','tongxu','3','410200',NULL,'通许');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410223','尉氏县','1','weishi','3','410200',NULL,'尉氏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410224','开封县','1','kaifeng','3','410200',NULL,'开封');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410225','兰考县','1','lankao','3','410200',NULL,'兰考');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410231','经济技术开发区','1','jingjijishukaifaqu','3','410200',NULL,'经济技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410300','洛阳市','1','luoyang','2','410000',NULL,'洛阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410301','市辖区','0','shixiaqu','3','410300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410302','老城区','1','laocheng','3','410300',NULL,'老城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410303','西工区','1','xigong','3','410300',NULL,'西工');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410304','瀍河回族区','1','chanhehuizu','3','410300',NULL,'瀍河回族');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410305','涧西区','1','jianxi','3','410300',NULL,'涧西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410306','吉利区','1','jili','3','410300',NULL,'吉利');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410311','洛龙区','1','luolong','3','410300',NULL,'洛龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410322','孟津县','1','mengjin','3','410300',NULL,'孟津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410323','新安县','1','xinan','3','410300',NULL,'新安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410324','栾川县','1','luanchuan','3','410300',NULL,'栾川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410325','嵩县','1','songxian','3','410300',NULL,'嵩县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410326','汝阳县','1','ruyang','3','410300',NULL,'汝阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410327','宜阳县','1','yiyang','3','410300',NULL,'宜阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410328','洛宁县','1','luoning','3','410300',NULL,'洛宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410329','伊川县','1','yichuan','3','410300',NULL,'伊川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410331','高新技术开发区','1','gaoxinjishukaifaqu','3','410300',NULL,'高新技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410341','经济技术开发区','1','jingjijishukaifaqu','3','410300',NULL,'经济技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410381','偃师市','1','yanshi','3','410300',NULL,'偃师');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410400','平顶山市','1','pingdingshan','2','410000',NULL,'平顶山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410401','市辖区','0','shixiaqu','3','410400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410402','新华区','1','xinhua','3','410400',NULL,'新华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410403','卫东区','1','weidong','3','410400',NULL,'卫东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410404','石龙区','1','shilong','3','410400',NULL,'石龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410411','湛河区','1','zhanhe','3','410400',NULL,'湛河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410421','宝丰县','1','baofeng','3','410400',NULL,'宝丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410422','叶县','1','yexian','3','410400',NULL,'叶县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410423','鲁山县','1','lushan','3','410400',NULL,'鲁山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410425','郏县','1','jiaxian','3','410400',NULL,'郏县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410481','舞钢市','1','wugang','3','410400',NULL,'舞钢');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410482','汝州市','1','ruzhou','3','410400',NULL,'汝州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410500','安阳市','1','anyang','2','410000',NULL,'安阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410501','市辖区','0','shixiaqu','3','410500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410502','文峰区','1','wenfeng','3','410500',NULL,'文峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410503','北关区','1','beiguan','3','410500',NULL,'北关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410505','殷都区','1','yindou','3','410500',NULL,'殷都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410506','龙安区','1','longan','3','410500',NULL,'龙安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410522','安阳县','1','anyang','3','410500',NULL,'安阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410523','汤阴县','1','tangyin','3','410500',NULL,'汤阴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410526','滑县','1','huaxian','3','410500',NULL,'滑县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410527','内黄县','1','neihuang','3','410500',NULL,'内黄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410531','高新技术开发区','1','gaoxinjishukaifaqu','3','410500',NULL,'高新技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410581','林州市','1','linzhou','3','410500',NULL,'林州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410600','鹤壁市','1','hebi','2','410000',NULL,'鹤壁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410601','市辖区','0','shixiaqu','3','410600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410602','鹤山区','1','heshan','3','410600',NULL,'鹤山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410603','山城区','1','shancheng','3','410600',NULL,'山城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410611','淇滨区','1','qibin','3','410600',NULL,'淇滨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410621','浚县','1','junxian','3','410600',NULL,'浚县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410622','淇县','1','qixian','3','410600',NULL,'淇县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410631','经济技术开发区','1','jingjijishukaifaqu','3','410600',NULL,'经济技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410700','新乡市','1','xinxiang','2','410000',NULL,'新乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410701','市辖区','0','shixiaqu','3','410700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410702','红旗区','1','hongqi','3','410700',NULL,'红旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410703','卫滨区','1','weibin','3','410700',NULL,'卫滨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410704','凤泉区','1','fengquan','3','410700',NULL,'凤泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410711','牧野区','1','muye','3','410700',NULL,'牧野');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410721','新乡县','1','xinxiang','3','410700',NULL,'新乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410724','获嘉县','1','huojia','3','410700',NULL,'获嘉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410725','原阳县','1','yuanyang','3','410700',NULL,'原阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410726','延津县','1','yanjin','3','410700',NULL,'延津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410727','封丘县','1','fengqiu','3','410700',NULL,'封丘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410728','长垣县','1','zhangyuan','3','410700',NULL,'长垣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410731','经济技术开发区','1','jingjijishukaifaqu','3','410700',NULL,'经济技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410781','卫辉市','1','weihui','3','410700',NULL,'卫辉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410782','辉县市','1','huixian','3','410700',NULL,'辉县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410800','焦作市','1','jiaozuo','2','410000',NULL,'焦作');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410801','市辖区','0','shixiaqu','3','410800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410802','解放区','1','jiefang','3','410800',NULL,'解放');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410803','中站区','1','zhongzhan','3','410800',NULL,'中站');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410804','马村区','1','macun','3','410800',NULL,'马村');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410811','山阳区','1','shanyang','3','410800',NULL,'山阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410821','修武县','1','xiuwu','3','410800',NULL,'修武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410822','博爱县','1','boai','3','410800',NULL,'博爱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410823','武陟县','1','wuzhi','3','410800',NULL,'武陟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410825','温县','1','wenxian','3','410800',NULL,'温县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410882','沁阳市','1','qinyang','3','410800',NULL,'沁阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410883','孟州市','1','mengzhou','3','410800',NULL,'孟州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410900','濮阳市','1','puyang','2','410000',NULL,'濮阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410901','市辖区','0','shixiaqu','3','410900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410902','华龙区','1','hualong','3','410900',NULL,'华龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410922','清丰县','1','qingfeng','3','410900',NULL,'清丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410923','南乐县','1','nanle','3','410900',NULL,'南乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410926','范县','1','fanxian','3','410900',NULL,'范县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410927','台前县','1','taiqian','3','410900',NULL,'台前');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410928','濮阳县','1','puyang','3','410900',NULL,'濮阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('410931','经济技术开发区','1','jingjijishukaifaqu','3','410900',NULL,'经济技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411000','许昌市','1','xuchang','2','410000',NULL,'许昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411001','市辖区','0','shixiaqu','3','411000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411002','魏都区','1','weidou','3','411000',NULL,'魏都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411023','许昌县','1','xuchang','3','411000',NULL,'许昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411024','鄢陵县','1','yanling','3','411000',NULL,'鄢陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411025','襄城县','1','xiangcheng','3','411000',NULL,'襄城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411031','经济技术开发区','1','jingjijishukaifaqu','3','411000',NULL,'经济技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411081','禹州市','1','yuzhou','3','411000',NULL,'禹州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411082','长葛市','1','zhangge','3','411000',NULL,'长葛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411100','漯河市','1','luohe','2','410000',NULL,'漯河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411101','市辖区','0','shixiaqu','3','411100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411102','源汇区','1','yuanhui','3','411100',NULL,'源汇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411103','郾城区','1','yancheng','3','411100',NULL,'郾城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411104','召陵区','1','zhaoling','3','411100',NULL,'召陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411121','舞阳县','1','wuyang','3','411100',NULL,'舞阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411122','临颍县','1','linying','3','411100',NULL,'临颍');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411131','经济技术开发区','1','jingjijishukaifaqu','3','411100',NULL,'经济技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411200','三门峡市','1','sanmenxia','2','410000',NULL,'三门峡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411201','市辖区','0','shixiaqu','3','411200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411202','湖滨区','1','hubin','3','411200',NULL,'湖滨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411221','渑池县','1','mianchi','3','411200',NULL,'渑池');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411222','陕县','1','shanxian','3','411200',NULL,'陕县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411224','卢氏县','1','lushi','3','411200',NULL,'卢氏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411281','义马市','1','yima','3','411200',NULL,'义马');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411282','灵宝市','1','lingbao','3','411200',NULL,'灵宝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411300','南阳市','1','nanyang','2','410000',NULL,'南阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411301','市辖区','0','shixiaqu','3','411300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411302','宛城区','1','wancheng','3','411300',NULL,'宛城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411303','卧龙区','1','wolong','3','411300',NULL,'卧龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411321','南召县','1','nanzhao','3','411300',NULL,'南召');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411322','方城县','1','fangcheng','3','411300',NULL,'方城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411323','西峡县','1','xixia','3','411300',NULL,'西峡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411324','镇平县','1','zhenping','3','411300',NULL,'镇平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411325','内乡县','1','neixiang','3','411300',NULL,'内乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411326','淅川县','1','xichuan','3','411300',NULL,'淅川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411327','社旗县','1','sheqi','3','411300',NULL,'社旗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411328','唐河县','1','tanghe','3','411300',NULL,'唐河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411329','新野县','1','xinye','3','411300',NULL,'新野');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411330','桐柏县','1','tongbo','3','411300',NULL,'桐柏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411341','高新技术开发区','1','gaoxinjishukaifaqu','3','411300',NULL,'高新技术开发区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411381','邓州市','1','dengzhou','3','411300',NULL,'邓州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411400','商丘市','1','shangqiu','2','410000',NULL,'商丘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411401','市辖区','0','shixiaqu','3','411400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411402','梁园区','1','liangyuan','3','411400',NULL,'梁园');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411403','睢阳区','1','suiyang','3','411400',NULL,'睢阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411421','民权县','1','minquan','3','411400',NULL,'民权');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411422','睢县','1','suixian','3','411400',NULL,'睢县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411423','宁陵县','1','ningling','3','411400',NULL,'宁陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411424','柘城县','1','zhecheng','3','411400',NULL,'柘城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411425','虞城县','1','yucheng','3','411400',NULL,'虞城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411426','夏邑县','1','xiayi','3','411400',NULL,'夏邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411481','永城市','1','yongcheng','3','411400',NULL,'永城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411500','信阳市','1','xinyang','2','410000',NULL,'信阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411501','市辖区','0','shixiaqu','3','411500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411502','浉河区','1','shihe','3','411500',NULL,'浉河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411503','平桥区','1','pingqiao','3','411500',NULL,'平桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411521','罗山县','1','luoshan','3','411500',NULL,'罗山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411522','光山县','1','guangshan','3','411500',NULL,'光山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411523','新县','1','xinxian','3','411500',NULL,'新县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411524','商城县','1','shangcheng','3','411500',NULL,'商城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411525','固始县','1','gushi','3','411500',NULL,'固始');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411526','潢川县','1','huangchuan','3','411500',NULL,'潢川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411527','淮滨县','1','huaibin','3','411500',NULL,'淮滨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411528','息县','1','xixian','3','411500',NULL,'息县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411600','周口市','1','zhoukou','2','410000',NULL,'周口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411601','市辖区','0','shixiaqu','3','411600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411602','川汇区','1','chuanhui','3','411600',NULL,'川汇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411621','扶沟县','1','fugou','3','411600',NULL,'扶沟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411622','西华县','1','xihua','3','411600',NULL,'西华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411623','商水县','1','shangshui','3','411600',NULL,'商水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411624','沈丘县','1','shenqiu','3','411600',NULL,'沈丘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411625','郸城县','1','dancheng','3','411600',NULL,'郸城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411626','淮阳县','1','huaiyang','3','411600',NULL,'淮阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411627','太康县','1','taikang','3','411600',NULL,'太康');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411628','鹿邑县','1','luyi','3','411600',NULL,'鹿邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411681','项城市','1','xiangcheng','3','411600',NULL,'项城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411700','驻马店市','1','zhumadian','2','410000',NULL,'驻马店');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411701','市辖区','0','shixiaqu','3','411700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411702','驿城区','1','yicheng','3','411700',NULL,'驿城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411721','西平县','1','xiping','3','411700',NULL,'西平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411722','上蔡县','1','shangcai','3','411700',NULL,'上蔡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411723','平舆县','1','pingyu','3','411700',NULL,'平舆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411724','正阳县','1','zhengyang','3','411700',NULL,'正阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411725','确山县','1','queshan','3','411700',NULL,'确山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411726','泌阳县','1','miyang','3','411700',NULL,'泌阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411727','汝南县','1','runan','3','411700',NULL,'汝南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411728','遂平县','1','suiping','3','411700',NULL,'遂平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('411729','新蔡县','1','xincai','3','411700',NULL,'新蔡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('412000','济源','1','jiyuan','2','410000',NULL,'济源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('412001','济源','1','jiyuan','3','412000',NULL,'济源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('419000','济源市','0','jiyuan','2','410000',NULL,'济源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420000','湖北省','1','hubei','1','0',NULL,'湖北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420100','武汉市','1','wuhan','2','420000',NULL,'武汉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420101','市辖区','0','shixiaqu','3','420100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420102','江岸区','1','jiangan','3','420100',NULL,'江岸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420103','江汉区','1','jianghan','3','420100',NULL,'江汉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420104','硚口区','1','qiaokou','3','420100',NULL,'硚口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420105','汉阳区','1','hanyang','3','420100',NULL,'汉阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420106','武昌区','1','wuchang','3','420100',NULL,'武昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420107','青山区','1','qingshan','3','420100',NULL,'青山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420111','洪山区','1','hongshan','3','420100',NULL,'洪山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420112','东西湖区','1','dongxihu','3','420100',NULL,'东西湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420113','汉南区','1','hannan','3','420100',NULL,'汉南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420114','蔡甸区','1','caidian','3','420100',NULL,'蔡甸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420115','江夏区','1','jiangxia','3','420100',NULL,'江夏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420116','黄陂区','1','huangpo','3','420100',NULL,'黄陂');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420117','新洲区','1','xinzhou','3','420100',NULL,'新洲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420200','黄石市','1','huangshi','2','420000',NULL,'黄石');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420201','市辖区','0','shixiaqu','3','420200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420202','黄石港区','1','huangshigang','3','420200',NULL,'黄石港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420203','西塞山区','1','xisaishan','3','420200',NULL,'西塞山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420204','下陆区','1','xialu','3','420200',NULL,'下陆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420205','铁山区','1','tieshan','3','420200',NULL,'铁山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420222','阳新县','1','yangxin','3','420200',NULL,'阳新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420281','大冶市','1','daye','3','420200',NULL,'大冶');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420300','十堰市','1','shiyan','2','420000',NULL,'十堰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420301','市辖区','0','shixiaqu','3','420300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420302','茅箭区','1','maojian','3','420300',NULL,'茅箭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420303','张湾区','1','zhangwan','3','420300',NULL,'张湾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420321','郧县','1','yunxian','3','420300',NULL,'郧县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420322','郧西县','1','yunxi','3','420300',NULL,'郧西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420323','竹山县','1','zhushan','3','420300',NULL,'竹山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420324','竹溪县','1','zhuxi','3','420300',NULL,'竹溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420325','房县','1','fangxian','3','420300',NULL,'房县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420381','丹江口市','1','danjiangkou','3','420300',NULL,'丹江口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420500','宜昌市','1','yichang','2','420000',NULL,'宜昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420501','市辖区','0','shixiaqu','3','420500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420502','西陵区','1','xiling','3','420500',NULL,'西陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420503','伍家岗区','1','wujiagang','3','420500',NULL,'伍家岗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420504','点军区','1','dianjun','3','420500',NULL,'点军');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420505','猇亭区','1','yaoting','3','420500',NULL,'猇亭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420506','夷陵区','1','yiling','3','420500',NULL,'夷陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420525','远安县','1','yuanan','3','420500',NULL,'远安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420526','兴山县','1','xingshan','3','420500',NULL,'兴山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420527','秭归县','1','zigui','3','420500',NULL,'秭归');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420528','长阳土家族自治县','1','zhangyangtujiazuzizhi','3','420500',NULL,'长阳土家族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420529','五峰土家族自治县','1','wufengtujiazuzizhi','3','420500',NULL,'五峰土家族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420581','宜都市','1','yidou','3','420500',NULL,'宜都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420582','当阳市','1','dangyang','3','420500',NULL,'当阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420583','枝江市','1','zhijiang','3','420500',NULL,'枝江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420600','襄阳市','1','xiangyang','2','420000',NULL,'襄阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420601','市辖区','0','shixiaqu','3','420600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420602','襄城区','1','xiangcheng','3','420600',NULL,'襄城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420606','樊城区','1','fancheng','3','420600',NULL,'樊城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420607','襄州区','1','xiangzhou','3','420600',NULL,'襄州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420624','南漳县','1','nanzhang','3','420600',NULL,'南漳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420625','谷城县','1','gucheng','3','420600',NULL,'谷城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420626','保康县','1','baokang','3','420600',NULL,'保康');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420682','老河口市','1','laohekou','3','420600',NULL,'老河口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420683','枣阳市','1','zaoyang','3','420600',NULL,'枣阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420684','宜城市','1','yicheng','3','420600',NULL,'宜城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420700','鄂州市','1','ezhou','2','420000',NULL,'鄂州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420701','市辖区','0','shixiaqu','3','420700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420702','梁子湖区','1','liangzihu','3','420700',NULL,'梁子湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420703','华容区','1','huarong','3','420700',NULL,'华容');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420704','鄂城区','1','echeng','3','420700',NULL,'鄂城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420800','荆门市','1','jingmen','2','420000',NULL,'荆门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420801','市辖区','0','shixiaqu','3','420800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420802','东宝区','1','dongbao','3','420800',NULL,'东宝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420804','掇刀区','1','duodao','3','420800',NULL,'掇刀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420821','京山县','1','jingshan','3','420800',NULL,'京山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420822','沙洋县','1','shayang','3','420800',NULL,'沙洋');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420881','钟祥市','1','zhongxiang','3','420800',NULL,'钟祥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420900','孝感市','1','xiaogan','2','420000',NULL,'孝感');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420901','市辖区','0','shixiaqu','3','420900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420902','孝南区','1','xiaonan','3','420900',NULL,'孝南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420921','孝昌县','1','xiaochang','3','420900',NULL,'孝昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420922','大悟县','1','dawu','3','420900',NULL,'大悟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420923','云梦县','1','yunmeng','3','420900',NULL,'云梦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420981','应城市','1','yingcheng','3','420900',NULL,'应城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420982','安陆市','1','anlu','3','420900',NULL,'安陆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('420984','汉川市','1','hanchuan','3','420900',NULL,'汉川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421000','荆州市','1','jingzhou','2','420000',NULL,'荆州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421001','市辖区','0','shixiaqu','3','421000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421002','沙市区','1','shashi','3','421000',NULL,'沙市');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421003','荆州区','1','jingzhou','3','421000',NULL,'荆州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421022','公安县','1','gongan','3','421000',NULL,'公安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421023','监利县','1','jianli','3','421000',NULL,'监利');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421024','江陵县','1','jiangling','3','421000',NULL,'江陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421081','石首市','1','shishou','3','421000',NULL,'石首');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421083','洪湖市','1','honghu','3','421000',NULL,'洪湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421087','松滋市','1','songzi','3','421000',NULL,'松滋');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421100','黄冈市','1','huanggang','2','420000',NULL,'黄冈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421101','市辖区','0','shixiaqu','3','421100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421102','黄州区','1','huangzhou','3','421100',NULL,'黄州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421121','团风县','1','tuanfeng','3','421100',NULL,'团风');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421122','红安县','1','hongan','3','421100',NULL,'红安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421123','罗田县','1','luotian','3','421100',NULL,'罗田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421124','英山县','1','yingshan','3','421100',NULL,'英山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421125','浠水县','1','xishui','3','421100',NULL,'浠水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421126','蕲春县','1','qichun','3','421100',NULL,'蕲春');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421127','黄梅县','1','huangmei','3','421100',NULL,'黄梅');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421181','麻城市','1','macheng','3','421100',NULL,'麻城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421182','武穴市','1','wuxue','3','421100',NULL,'武穴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421200','咸宁市','1','xianning','2','420000',NULL,'咸宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421201','市辖区','0','shixiaqu','3','421200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421202','咸安区','1','xianan','3','421200',NULL,'咸安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421221','嘉鱼县','1','jiayu','3','421200',NULL,'嘉鱼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421222','通城县','1','tongcheng','3','421200',NULL,'通城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421223','崇阳县','1','chongyang','3','421200',NULL,'崇阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421224','通山县','1','tongshan','3','421200',NULL,'通山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421281','赤壁市','1','chibi','3','421200',NULL,'赤壁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421300','随州市','1','suizhou','2','420000',NULL,'随州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421301','市辖区','0','shixiaqu','3','421300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421303','曾都区','1','cengdou','3','421300',NULL,'曾都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421321','随县','1','suixian','3','421300',NULL,'随县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('421381','广水市','1','guangshui','3','421300',NULL,'广水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('422800','恩施土家族苗族自治州','1','enshitujiazumiaozuzizhizhou','2','420000',NULL,'恩施土家族苗族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('422801','恩施市','1','enshi','3','422800',NULL,'恩施');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('422802','利川市','1','lichuan','3','422800',NULL,'利川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('422822','建始县','1','jianshi','3','422800',NULL,'建始');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('422823','巴东县','1','badong','3','422800',NULL,'巴东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('422825','宣恩县','1','xuanen','3','422800',NULL,'宣恩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('422826','咸丰县','1','xianfeng','3','422800',NULL,'咸丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('422827','来凤县','1','laifeng','3','422800',NULL,'来凤');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('422828','鹤峰县','1','hefeng','3','422800',NULL,'鹤峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('423100','仙桃市','1','xiantao','2','420000',NULL,'仙桃');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('423101','仙桃','1','xiantao','3','423100',NULL,'仙桃');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('423200','潜江市','1','qianjiang','2','420000',NULL,'潜江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('423202','潜江','1','qianjiang','3','423200',NULL,'潜江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('423300','天门市','1','tianmen','2','420000',NULL,'天门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('423301','天门','1','tianmen','3','423300',NULL,'天门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('423400','神农架林','1','shennongjialin','2','420000',NULL,'神农架林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('423401','神农架林','1','shennongjialin','3','423400',NULL,'神农架林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('429000','省直辖县级行政区划','0','shengzhixiaxianjixingzhengquhua','2','420000',NULL,'省直辖县级行政区划');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430000','湖南省','1','hunan','1','0',NULL,'湖南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430100','长沙市','1','zhangsha','2','430000',NULL,'长沙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430101','市辖区','0','shixiaqu','3','430100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430102','芙蓉区','1','furong','3','430100',NULL,'芙蓉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430103','天心区','1','tianxin','3','430100',NULL,'天心');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430104','岳麓区','1','yuelu','3','430100',NULL,'岳麓');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430105','开福区','1','kaifu','3','430100',NULL,'开福');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430111','雨花区','1','yuhua','3','430100',NULL,'雨花');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430112','望城区','1','wangcheng','3','430100',NULL,'望城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430121','长沙县','1','zhangsha','3','430100',NULL,'长沙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430124','宁乡县','1','ningxiang','3','430100',NULL,'宁乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430181','浏阳市','1','liuyang','3','430100',NULL,'浏阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430200','株洲市','1','zhuzhou','2','430000',NULL,'株洲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430201','市辖区','0','shixiaqu','3','430200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430202','荷塘区','1','hetang','3','430200',NULL,'荷塘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430203','芦淞区','1','lusong','3','430200',NULL,'芦淞');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430204','石峰区','1','shifeng','3','430200',NULL,'石峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430211','天元区','1','tianyuan','3','430200',NULL,'天元');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430221','株洲县','1','zhuzhou','3','430200',NULL,'株洲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430223','攸县','1','youxian','3','430200',NULL,'攸县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430224','茶陵县','1','chaling','3','430200',NULL,'茶陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430225','炎陵县','1','yanling','3','430200',NULL,'炎陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430231','云龙示范区','1','yunlong','3','430200',NULL,'云龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430281','醴陵市','1','liling','3','430200',NULL,'醴陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430300','湘潭市','1','xiangtan','2','430000',NULL,'湘潭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430301','市辖区','0','shixiaqu','3','430300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430302','雨湖区','1','yuhu','3','430300',NULL,'雨湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430304','岳塘区','1','yuetang','3','430300',NULL,'岳塘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430321','湘潭县','1','xiangtan','3','430300',NULL,'湘潭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430381','湘乡市','1','xiangxiang','3','430300',NULL,'湘乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430382','韶山市','1','shaoshan','3','430300',NULL,'韶山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430400','衡阳市','1','hengyang','2','430000',NULL,'衡阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430401','市辖区','0','shixiaqu','3','430400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430405','珠晖区','1','zhuhui','3','430400',NULL,'珠晖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430406','雁峰区','1','yanfeng','3','430400',NULL,'雁峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430407','石鼓区','1','shigu','3','430400',NULL,'石鼓');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430408','蒸湘区','1','zhengxiang','3','430400',NULL,'蒸湘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430412','南岳区','1','nanyue','3','430400',NULL,'南岳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430421','衡阳县','1','hengyang','3','430400',NULL,'衡阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430422','衡南县','1','hengnan','3','430400',NULL,'衡南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430423','衡山县','1','hengshan','3','430400',NULL,'衡山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430424','衡东县','1','hengdong','3','430400',NULL,'衡东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430426','祁东县','1','qidong','3','430400',NULL,'祁东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430481','耒阳市','1','leiyang','3','430400',NULL,'耒阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430482','常宁市','1','changning','3','430400',NULL,'常宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430500','邵阳市','1','shaoyang','2','430000',NULL,'邵阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430501','市辖区','0','shixiaqu','3','430500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430502','双清区','1','shuangqing','3','430500',NULL,'双清');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430503','大祥区','1','daxiang','3','430500',NULL,'大祥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430511','北塔区','1','beita','3','430500',NULL,'北塔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430521','邵东县','1','shaodong','3','430500',NULL,'邵东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430522','新邵县','1','xinshao','3','430500',NULL,'新邵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430523','邵阳县','1','shaoyang','3','430500',NULL,'邵阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430524','隆回县','1','longhui','3','430500',NULL,'隆回');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430525','洞口县','1','dongkou','3','430500',NULL,'洞口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430527','绥宁县','1','suining','3','430500',NULL,'绥宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430528','新宁县','1','xinning','3','430500',NULL,'新宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430529','城步苗族自治县','1','chengbumiaozuzizhi','3','430500',NULL,'城步苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430581','武冈市','1','wugang','3','430500',NULL,'武冈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430600','岳阳市','1','yueyang','2','430000',NULL,'岳阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430601','市辖区','0','shixiaqu','3','430600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430602','岳阳楼区','1','yueyanglou','3','430600',NULL,'岳阳楼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430603','云溪区','1','yunxi','3','430600',NULL,'云溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430611','君山区','1','junshan','3','430600',NULL,'君山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430621','岳阳县','1','yueyang','3','430600',NULL,'岳阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430623','华容县','1','huarong','3','430600',NULL,'华容');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430624','湘阴县','1','xiangyin','3','430600',NULL,'湘阴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430626','平江县','1','pingjiang','3','430600',NULL,'平江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430681','汨罗市','1','miluo','3','430600',NULL,'汨罗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430682','临湘市','1','linxiang','3','430600',NULL,'临湘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430700','常德市','1','changde','2','430000',NULL,'常德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430701','市辖区','0','shixiaqu','3','430700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430702','武陵区','1','wuling','3','430700',NULL,'武陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430703','鼎城区','1','dingcheng','3','430700',NULL,'鼎城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430721','安乡县','1','anxiang','3','430700',NULL,'安乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430722','汉寿县','1','hanshou','3','430700',NULL,'汉寿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430723','澧县','1','lixian','3','430700',NULL,'澧县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430724','临澧县','1','linli','3','430700',NULL,'临澧');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430725','桃源县','1','taoyuan','3','430700',NULL,'桃源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430726','石门县','1','shimen','3','430700',NULL,'石门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430781','津市市','1','jinshi','3','430700',NULL,'津市');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430800','张家界市','1','zhangjiajie','2','430000',NULL,'张家界');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430801','市辖区','0','shixiaqu','3','430800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430802','永定区','1','yongding','3','430800',NULL,'永定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430811','武陵源区','1','wulingyuan','3','430800',NULL,'武陵源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430821','慈利县','1','cili','3','430800',NULL,'慈利');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430822','桑植县','1','sangzhi','3','430800',NULL,'桑植');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430900','益阳市','1','yiyang','2','430000',NULL,'益阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430901','市辖区','0','shixiaqu','3','430900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430902','资阳区','1','ziyang','3','430900',NULL,'资阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430903','赫山区','1','heshan','3','430900',NULL,'赫山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430921','南县','1','nanxian','3','430900',NULL,'南县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430922','桃江县','1','taojiang','3','430900',NULL,'桃江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430923','安化县','1','anhua','3','430900',NULL,'安化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('430981','沅江市','1','yuanjiang','3','430900',NULL,'沅江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431000','郴州市','1','chenzhou','2','430000',NULL,'郴州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431001','市辖区','0','shixiaqu','3','431000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431002','北湖区','1','beihu','3','431000',NULL,'北湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431003','苏仙区','1','suxian','3','431000',NULL,'苏仙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431021','桂阳县','1','guiyang','3','431000',NULL,'桂阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431022','宜章县','1','yizhang','3','431000',NULL,'宜章');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431023','永兴县','1','yongxing','3','431000',NULL,'永兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431024','嘉禾县','1','jiahe','3','431000',NULL,'嘉禾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431025','临武县','1','linwu','3','431000',NULL,'临武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431026','汝城县','1','rucheng','3','431000',NULL,'汝城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431027','桂东县','1','guidong','3','431000',NULL,'桂东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431028','安仁县','1','anren','3','431000',NULL,'安仁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431081','资兴市','1','zixing','3','431000',NULL,'资兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431100','永州市','1','yongzhou','2','430000',NULL,'永州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431101','市辖区','0','shixiaqu','3','431100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431102','零陵区','1','lingling','3','431100',NULL,'零陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431103','冷水滩区','1','lengshuitan','3','431100',NULL,'冷水滩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431121','祁阳县','1','qiyang','3','431100',NULL,'祁阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431122','东安县','1','dongan','3','431100',NULL,'东安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431123','双牌县','1','shuangpai','3','431100',NULL,'双牌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431124','道县','1','daoxian','3','431100',NULL,'道县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431125','江永县','1','jiangyong','3','431100',NULL,'江永');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431126','宁远县','1','ningyuan','3','431100',NULL,'宁远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431127','蓝山县','1','lanshan','3','431100',NULL,'蓝山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431128','新田县','1','xintian','3','431100',NULL,'新田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431129','江华瑶族自治县','1','jianghuayaozuzizhi','3','431100',NULL,'江华瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431200','怀化市','1','huaihua','2','430000',NULL,'怀化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431201','市辖区','0','shixiaqu','3','431200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431202','鹤城区','1','hecheng','3','431200',NULL,'鹤城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431221','中方县','1','zhongfang','3','431200',NULL,'中方');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431222','沅陵县','1','yuanling','3','431200',NULL,'沅陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431223','辰溪县','1','chenxi','3','431200',NULL,'辰溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431224','溆浦县','1','xupu','3','431200',NULL,'溆浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431225','会同县','1','huitong','3','431200',NULL,'会同');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431226','麻阳苗族自治县','1','mayangmiaozuzizhi','3','431200',NULL,'麻阳苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431227','新晃侗族自治县','1','xinhuangdongzuzizhi','3','431200',NULL,'新晃侗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431228','芷江侗族自治县','1','zhijiangdongzuzizhi','3','431200',NULL,'芷江侗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431229','靖州苗族侗族自治县','1','jingzhoumiaozudongzuzizhi','3','431200',NULL,'靖州苗族侗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431230','通道侗族自治县','1','tongdaodongzuzizhi','3','431200',NULL,'通道侗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431241','洪江区','1','hongjiang','3','431200',NULL,'洪江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431281','洪江市','1','hongjiang','3','431200',NULL,'洪江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431300','娄底市','1','loudi','2','430000',NULL,'娄底');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431301','市辖区','0','shixiaqu','3','431300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431302','娄星区','1','louxing','3','431300',NULL,'娄星');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431321','双峰县','1','shuangfeng','3','431300',NULL,'双峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431322','新化县','1','xinhua','3','431300',NULL,'新化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431381','冷水江市','1','lengshuijiang','3','431300',NULL,'冷水江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('431382','涟源市','1','lianyuan','3','431300',NULL,'涟源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('433100','湘西土家族苗族自治州','1','xiangxitujiazumiaozuzizhizhou','2','430000',NULL,'湘西土家族苗族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('433101','吉首市','1','jishou','3','433100',NULL,'吉首');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('433122','泸溪县','1','luxi','3','433100',NULL,'泸溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('433123','凤凰县','1','fenghuang','3','433100',NULL,'凤凰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('433124','花垣县','1','huayuan','3','433100',NULL,'花垣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('433125','保靖县','1','baojing','3','433100',NULL,'保靖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('433126','古丈县','1','guzhang','3','433100',NULL,'古丈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('433127','永顺县','1','yongshun','3','433100',NULL,'永顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('433130','龙山县','1','longshan','3','433100',NULL,'龙山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440000','广东省','1','guangdong','1','0',NULL,'广东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440100','广州市','1','guangzhou','2','440000',NULL,'广州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440101','市辖区','0','shixiaqu','3','440100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440103','荔湾区','1','liwan','3','440100',NULL,'荔湾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440104','越秀区','1','yuexiu','3','440100',NULL,'越秀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440105','海珠区','1','haizhu','3','440100',NULL,'海珠');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440106','天河区','1','tianhe','3','440100',NULL,'天河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440111','白云区','1','baiyun','3','440100',NULL,'白云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440112','黄埔区','1','huangpu','3','440100',NULL,'黄埔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440113','番禺区','1','fanyu','3','440100',NULL,'番禺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440114','花都区','1','huadou','3','440100',NULL,'花都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440115','南沙区','1','nansha','3','440100',NULL,'南沙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440116','萝岗区','1','luogang','3','440100',NULL,'萝岗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440183','增城市','1','zengcheng','3','440100',NULL,'增城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440184','从化市','1','conghua','3','440100',NULL,'从化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440200','韶关市','1','shaoguan','2','440000',NULL,'韶关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440201','市辖区','0','shixiaqu','3','440200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440203','武江区','1','wujiang','3','440200',NULL,'武江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440204','浈江区','1','zhenjiang','3','440200',NULL,'浈江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440205','曲江区','1','qujiang','3','440200',NULL,'曲江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440222','始兴县','1','shixing','3','440200',NULL,'始兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440224','仁化县','1','renhua','3','440200',NULL,'仁化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440229','翁源县','1','wengyuan','3','440200',NULL,'翁源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440232','乳源瑶族自治县','1','ruyuanyaozuzizhi','3','440200',NULL,'乳源瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440233','新丰县','1','xinfeng','3','440200',NULL,'新丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440281','乐昌市','1','lechang','3','440200',NULL,'乐昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440282','南雄市','1','nanxiong','3','440200',NULL,'南雄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440300','深圳市','1','shenzhen','2','440000',NULL,'深圳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440301','市辖区','0','shixiaqu','3','440300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440303','罗湖区','1','luohu','3','440300',NULL,'罗湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440304','福田区','1','futian','3','440300',NULL,'福田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440305','南山区','1','nanshan','3','440300',NULL,'南山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440306','宝安区','1','baoan','3','440300',NULL,'宝安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440307','龙岗区','1','longgang','3','440300',NULL,'龙岗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440308','盐田区','1','yantian','3','440300',NULL,'盐田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440400','珠海市','1','zhuhai','2','440000',NULL,'珠海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440401','市辖区','0','shixiaqu','3','440400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440402','香洲区','1','xiangzhou','3','440400',NULL,'香洲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440403','斗门区','1','doumen','3','440400',NULL,'斗门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440404','金湾区','1','jinwan','3','440400',NULL,'金湾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440500','汕头市','1','shantou','2','440000',NULL,'汕头');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440501','市辖区','0','shixiaqu','3','440500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440507','龙湖区','1','longhu','3','440500',NULL,'龙湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440511','金平区','1','jinping','3','440500',NULL,'金平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440512','濠江区','1','haojiang','3','440500',NULL,'濠江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440513','潮阳区','1','chaoyang','3','440500',NULL,'潮阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440514','潮南区','1','chaonan','3','440500',NULL,'潮南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440515','澄海区','1','chenghai','3','440500',NULL,'澄海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440523','南澳县','1','nanao','3','440500',NULL,'南澳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440600','佛山市','1','foshan','2','440000',NULL,'佛山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440601','市辖区','0','shixiaqu','3','440600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440604','禅城区','1','shancheng','3','440600',NULL,'禅城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440605','南海区','1','nanhai','3','440600',NULL,'南海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440606','顺德区','1','shunde','3','440600',NULL,'顺德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440607','三水区','1','sanshui','3','440600',NULL,'三水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440608','高明区','1','gaoming','3','440600',NULL,'高明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440700','江门市','1','jiangmen','2','440000',NULL,'江门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440701','市辖区','0','shixiaqu','3','440700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440703','蓬江区','1','pengjiang','3','440700',NULL,'蓬江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440704','江海区','1','jianghai','3','440700',NULL,'江海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440705','新会区','1','xinhui','3','440700',NULL,'新会');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440781','台山市','1','taishan','3','440700',NULL,'台山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440783','开平市','1','kaiping','3','440700',NULL,'开平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440784','鹤山市','1','heshan','3','440700',NULL,'鹤山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440785','恩平市','1','enping','3','440700',NULL,'恩平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440800','湛江市','1','zhanjiang','2','440000',NULL,'湛江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440801','市辖区','0','shixiaqu','3','440800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440802','赤坎区','1','chikan','3','440800',NULL,'赤坎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440803','霞山区','1','xiashan','3','440800',NULL,'霞山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440804','坡头区','1','potou','3','440800',NULL,'坡头');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440811','麻章区','1','mazhang','3','440800',NULL,'麻章');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440823','遂溪县','1','suixi','3','440800',NULL,'遂溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440825','徐闻县','1','xuwen','3','440800',NULL,'徐闻');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440881','廉江市','1','lianjiang','3','440800',NULL,'廉江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440882','雷州市','1','leizhou','3','440800',NULL,'雷州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440883','吴川市','1','wuchuan','3','440800',NULL,'吴川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440900','茂名市','1','maoming','2','440000',NULL,'茂名');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440901','市辖区','0','shixiaqu','3','440900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440902','茂南区','1','maonan','3','440900',NULL,'茂南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440903','茂港区','1','maogang','3','440900',NULL,'茂港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440923','电白县','1','dianbai','3','440900',NULL,'电白');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440981','高州市','1','gaozhou','3','440900',NULL,'高州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440982','化州市','1','huazhou','3','440900',NULL,'化州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('440983','信宜市','1','xinyi','3','440900',NULL,'信宜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441200','肇庆市','1','zhaoqing','2','440000',NULL,'肇庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441201','市辖区','0','shixiaqu','3','441200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441202','端州区','1','duanzhou','3','441200',NULL,'端州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441203','鼎湖区','1','dinghu','3','441200',NULL,'鼎湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441223','广宁县','1','guangning','3','441200',NULL,'广宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441224','怀集县','1','huaiji','3','441200',NULL,'怀集');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441225','封开县','1','fengkai','3','441200',NULL,'封开');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441226','德庆县','1','deqing','3','441200',NULL,'德庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441283','高要市','1','gaoyao','3','441200',NULL,'高要');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441284','四会市','1','sihui','3','441200',NULL,'四会');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441300','惠州市','1','huizhou','2','440000',NULL,'惠州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441301','市辖区','0','shixiaqu','3','441300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441302','惠城区','1','huicheng','3','441300',NULL,'惠城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441303','惠阳区','1','huiyang','3','441300',NULL,'惠阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441322','博罗县','1','boluo','3','441300',NULL,'博罗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441323','惠东县','1','huidong','3','441300',NULL,'惠东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441324','龙门县','1','longmen','3','441300',NULL,'龙门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441400','梅州市','1','meizhou','2','440000',NULL,'梅州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441401','市辖区','0','shixiaqu','3','441400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441402','梅江区','1','meijiang','3','441400',NULL,'梅江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441421','梅县','1','meixian','3','441400',NULL,'梅县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441422','大埔县','1','dapu','3','441400',NULL,'大埔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441423','丰顺县','1','fengshun','3','441400',NULL,'丰顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441424','五华县','1','wuhua','3','441400',NULL,'五华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441426','平远县','1','pingyuan','3','441400',NULL,'平远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441427','蕉岭县','1','jiaoling','3','441400',NULL,'蕉岭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441481','兴宁市','1','xingning','3','441400',NULL,'兴宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441500','汕尾市','1','shanwei','2','440000',NULL,'汕尾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441501','市辖区','0','shixiaqu','3','441500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441502','城区','1','chengqu','3','441500',NULL,'城区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441521','海丰县','1','haifeng','3','441500',NULL,'海丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441523','陆河县','1','luhe','3','441500',NULL,'陆河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441581','陆丰市','1','lufeng','3','441500',NULL,'陆丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441600','河源市','1','heyuan','2','440000',NULL,'河源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441601','市辖区','0','shixiaqu','3','441600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441602','源城区','1','yuancheng','3','441600',NULL,'源城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441621','紫金县','1','zijin','3','441600',NULL,'紫金');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441622','龙川县','1','longchuan','3','441600',NULL,'龙川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441623','连平县','1','lianping','3','441600',NULL,'连平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441624','和平县','1','heping','3','441600',NULL,'和平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441625','东源县','1','dongyuan','3','441600',NULL,'东源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441700','阳江市','1','yangjiang','2','440000',NULL,'阳江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441701','市辖区','0','shixiaqu','3','441700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441702','江城区','1','jiangcheng','3','441700',NULL,'江城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441721','阳西县','1','yangxi','3','441700',NULL,'阳西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441723','阳东县','1','yangdong','3','441700',NULL,'阳东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441781','阳春市','1','yangchun','3','441700',NULL,'阳春');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441800','清远市','1','qingyuan','2','440000',NULL,'清远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441801','市辖区','0','shixiaqu','3','441800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441802','清城区','1','qingcheng','3','441800',NULL,'清城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441821','佛冈县','1','fogang','3','441800',NULL,'佛冈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441823','阳山县','1','yangshan','3','441800',NULL,'阳山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441825','连山壮族瑶族自治县','1','lianshanzhuangzuyaozuzizhi','3','441800',NULL,'连山壮族瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441826','连南瑶族自治县','1','liannanyaozuzizhi','3','441800',NULL,'连南瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441827','清新县','1','qingxin','3','441800',NULL,'清新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441881','英德市','1','yingde','3','441800',NULL,'英德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441882','连州市','1','lianzhou','3','441800',NULL,'连州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441900','东莞市','1','dongguan','2','440000',NULL,'东莞');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('441901','东莞','1','dongguan','3','441900',NULL,'东莞');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('442000','中山市','1','zhongshan','2','440000',NULL,'中山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('442001','中山','1','zhongshan','3','442000',NULL,'中山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('442002','五桂山区','1','wuguishan','3','442000',NULL,'五桂山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('442003','石岐区','1','shiqi','3','442000',NULL,'石岐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445100','潮州市','1','chaozhou','2','440000',NULL,'潮州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445101','市辖区','0','shixiaqu','3','445100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445102','湘桥区','1','xiangqiao','3','445100',NULL,'湘桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445121','潮安县','1','chaoan','3','445100',NULL,'潮安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445122','饶平县','1','raoping','3','445100',NULL,'饶平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445200','揭阳市','1','jieyang','2','440000',NULL,'揭阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445201','市辖区','0','shixiaqu','3','445200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445202','榕城区','1','rongcheng','3','445200',NULL,'榕城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445221','揭东县','1','jiedong','3','445200',NULL,'揭东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445222','揭西县','1','jiexi','3','445200',NULL,'揭西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445224','惠来县','1','huilai','3','445200',NULL,'惠来');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445281','普宁市','1','puning','3','445200',NULL,'普宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445300','云浮市','1','yunfu','2','440000',NULL,'云浮');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445301','市辖区','0','shixiaqu','3','445300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445302','云城区','1','yuncheng','3','445300',NULL,'云城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445321','新兴县','1','xinxing','3','445300',NULL,'新兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445322','郁南县','1','yunan','3','445300',NULL,'郁南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445323','云安县','1','yunan','3','445300',NULL,'云安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('445381','罗定市','1','luoding','3','445300',NULL,'罗定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450000','广西壮族自治区','1','guangxizhuangzuzizhi','1','0',NULL,'广西壮族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450100','南宁市','1','nanning','2','450000',NULL,'南宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450101','市辖区','0','shixiaqu','3','450100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450102','兴宁区','1','xingning','3','450100',NULL,'兴宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450103','青秀区','1','qingxiu','3','450100',NULL,'青秀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450105','江南区','1','jiangnan','3','450100',NULL,'江南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450107','西乡塘区','1','xixiangtang','3','450100',NULL,'西乡塘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450108','良庆区','1','liangqing','3','450100',NULL,'良庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450109','邕宁区','1','yongning','3','450100',NULL,'邕宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450122','武鸣县','1','wuming','3','450100',NULL,'武鸣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450123','隆安县','1','longan','3','450100',NULL,'隆安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450124','马山县','1','mashan','3','450100',NULL,'马山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450125','上林县','1','shanglin','3','450100',NULL,'上林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450126','宾阳县','1','binyang','3','450100',NULL,'宾阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450127','横县','1','hengxian','3','450100',NULL,'横县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450200','柳州市','1','liuzhou','2','450000',NULL,'柳州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450201','市辖区','0','shixiaqu','3','450200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450202','城中区','1','chengzhong','3','450200',NULL,'城中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450203','鱼峰区','1','yufeng','3','450200',NULL,'鱼峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450204','柳南区','1','liunan','3','450200',NULL,'柳南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450205','柳北区','1','liubei','3','450200',NULL,'柳北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450221','柳江县','1','liujiang','3','450200',NULL,'柳江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450222','柳城县','1','liucheng','3','450200',NULL,'柳城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450223','鹿寨县','1','luzhai','3','450200',NULL,'鹿寨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450224','融安县','1','rongan','3','450200',NULL,'融安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450225','融水苗族自治县','1','rongshuimiaozuzizhi','3','450200',NULL,'融水苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450226','三江侗族自治县','1','sanjiangdongzuzizhi','3','450200',NULL,'三江侗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450300','桂林市','1','guilin','2','450000',NULL,'桂林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450301','市辖区','0','shixiaqu','3','450300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450302','秀峰区','1','xiufeng','3','450300',NULL,'秀峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450303','叠彩区','1','diecai','3','450300',NULL,'叠彩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450304','象山区','1','xiangshan','3','450300',NULL,'象山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450305','七星区','1','qixing','3','450300',NULL,'七星');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450311','雁山区','1','yanshan','3','450300',NULL,'雁山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450321','阳朔县','1','yangshuo','3','450300',NULL,'阳朔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450322','临桂区','1','lingui','3','450300',NULL,'临桂');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450323','灵川县','1','lingchuan','3','450300',NULL,'灵川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450324','全州县','1','quanzhou','3','450300',NULL,'全州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450325','兴安县','1','xingan','3','450300',NULL,'兴安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450326','永福县','1','yongfu','3','450300',NULL,'永福');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450327','灌阳县','1','guanyang','3','450300',NULL,'灌阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450328','龙胜各族自治县','1','longshenggezuzizhi','3','450300',NULL,'龙胜各族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450329','资源县','1','ziyuan','3','450300',NULL,'资源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450330','平乐县','1','pingle','3','450300',NULL,'平乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450331','荔浦县','1','lipu','3','450300',NULL,'荔浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450332','恭城瑶族自治县','1','gongchengyaozuzizhi','3','450300',NULL,'恭城瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450400','梧州市','1','wuzhou','2','450000',NULL,'梧州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450401','市辖区','0','shixiaqu','3','450400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450403','万秀区','1','wanxiu','3','450400',NULL,'万秀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450404','蝶山区','1','dieshan','3','450400',NULL,'蝶山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450405','长洲区','1','zhangzhou','3','450400',NULL,'长洲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450421','苍梧县','1','cangwu','3','450400',NULL,'苍梧');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450422','藤县','1','tengxian','3','450400',NULL,'藤县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450423','蒙山县','1','mengshan','3','450400',NULL,'蒙山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450481','岑溪市','1','cenxi','3','450400',NULL,'岑溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450500','北海市','1','beihai','2','450000',NULL,'北海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450501','市辖区','0','shixiaqu','3','450500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450502','海城区','1','haicheng','3','450500',NULL,'海城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450503','银海区','1','yinhai','3','450500',NULL,'银海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450512','铁山港区','1','tieshangang','3','450500',NULL,'铁山港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450521','合浦县','1','hepu','3','450500',NULL,'合浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450600','防城港市','1','fangchenggang','2','450000',NULL,'防城港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450601','市辖区','0','shixiaqu','3','450600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450602','港口区','1','gangkou','3','450600',NULL,'港口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450603','防城区','1','fangcheng','3','450600',NULL,'防城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450621','上思县','1','shangsi','3','450600',NULL,'上思');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450681','东兴市','1','dongxing','3','450600',NULL,'东兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450700','钦州市','1','qinzhou','2','450000',NULL,'钦州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450701','市辖区','0','shixiaqu','3','450700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450702','钦南区','1','qinnan','3','450700',NULL,'钦南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450703','钦北区','1','qinbei','3','450700',NULL,'钦北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450721','灵山县','1','lingshan','3','450700',NULL,'灵山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450722','浦北县','1','pubei','3','450700',NULL,'浦北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450800','贵港市','1','guigang','2','450000',NULL,'贵港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450801','市辖区','0','shixiaqu','3','450800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450802','港北区','1','gangbei','3','450800',NULL,'港北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450803','港南区','1','gangnan','3','450800',NULL,'港南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450804','覃塘区','1','tantang','3','450800',NULL,'覃塘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450821','平南县','1','pingnan','3','450800',NULL,'平南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450881','桂平市','1','guiping','3','450800',NULL,'桂平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450900','玉林市','1','yulin','2','450000',NULL,'玉林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450901','市辖区','0','shixiaqu','3','450900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450902','玉州区','1','yuzhou','3','450900',NULL,'玉州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450921','容县','1','rongxian','3','450900',NULL,'容县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450922','陆川县','1','luchuan','3','450900',NULL,'陆川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450923','博白县','1','bobai','3','450900',NULL,'博白');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450924','兴业县','1','xingye','3','450900',NULL,'兴业');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('450981','北流市','1','beiliu','3','450900',NULL,'北流');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451000','百色市','1','baise','2','450000',NULL,'百色');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451001','市辖区','0','shixiaqu','3','451000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451002','右江区','1','youjiang','3','451000',NULL,'右江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451021','田阳县','1','tianyang','3','451000',NULL,'田阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451022','田东县','1','tiandong','3','451000',NULL,'田东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451023','平果县','1','pingguo','3','451000',NULL,'平果');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451024','德保县','1','debao','3','451000',NULL,'德保');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451025','靖西县','1','jingxi','3','451000',NULL,'靖西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451026','那坡县','1','neipo','3','451000',NULL,'那坡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451027','凌云县','1','lingyun','3','451000',NULL,'凌云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451028','乐业县','1','leye','3','451000',NULL,'乐业');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451029','田林县','1','tianlin','3','451000',NULL,'田林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451030','西林县','1','xilin','3','451000',NULL,'西林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451031','隆林各族自治县','1','longlingezuzizhi','3','451000',NULL,'隆林各族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451100','贺州市','1','hezhou','2','450000',NULL,'贺州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451101','市辖区','0','shixiaqu','3','451100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451102','八步区','1','babu','3','451100',NULL,'八步');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451121','昭平县','1','zhaoping','3','451100',NULL,'昭平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451122','钟山县','1','zhongshan','3','451100',NULL,'钟山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451123','富川瑶族自治县','1','fuchuanyaozuzizhi','3','451100',NULL,'富川瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451131','平桂管理区','1','pinggui','3','451100',NULL,'平桂');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451200','河池市','1','hechi','2','450000',NULL,'河池');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451201','市辖区','0','shixiaqu','3','451200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451202','金城江区','1','jinchengjiang','3','451200',NULL,'金城江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451221','南丹县','1','nandan','3','451200',NULL,'南丹');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451222','天峨县','1','tiane','3','451200',NULL,'天峨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451223','凤山县','1','fengshan','3','451200',NULL,'凤山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451224','东兰县','1','donglan','3','451200',NULL,'东兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451225','罗城仫佬族自治县','1','luochengmulaozuzizhi','3','451200',NULL,'罗城仫佬族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451226','环江毛南族自治县','1','huanjiangmaonanzuzizhi','3','451200',NULL,'环江毛南族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451227','巴马瑶族自治县','1','bamayaozuzizhi','3','451200',NULL,'巴马瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451228','都安瑶族自治县','1','douanyaozuzizhi','3','451200',NULL,'都安瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451229','大化瑶族自治县','1','dahuayaozuzizhi','3','451200',NULL,'大化瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451281','宜州市','1','yizhou','3','451200',NULL,'宜州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451300','来宾市','1','laibin','2','450000',NULL,'来宾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451301','市辖区','0','shixiaqu','3','451300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451302','兴宾区','1','xingbin','3','451300',NULL,'兴宾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451321','忻城县','1','xincheng','3','451300',NULL,'忻城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451322','象州县','1','xiangzhou','3','451300',NULL,'象州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451323','武宣县','1','wuxuan','3','451300',NULL,'武宣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451324','金秀瑶族自治县','1','jinxiuyaozuzizhi','3','451300',NULL,'金秀瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451381','合山市','1','heshan','3','451300',NULL,'合山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451400','崇左市','1','chongzuo','2','450000',NULL,'崇左');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451401','市辖区','0','shixiaqu','3','451400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451402','江洲区','1','jiangzhou','3','451400',NULL,'江洲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451421','扶绥县','1','fusui','3','451400',NULL,'扶绥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451422','宁明县','1','ningming','3','451400',NULL,'宁明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451423','龙州县','1','longzhou','3','451400',NULL,'龙州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451424','大新县','1','daxin','3','451400',NULL,'大新');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451425','天等县','1','tiandeng','3','451400',NULL,'天等');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('451481','凭祥市','1','pingxiang','3','451400',NULL,'凭祥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460000','海南省','1','hainan','1','0',NULL,'海南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460100','海口市','1','haikou','2','460000',NULL,'海口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460101','市辖区','0','shixiaqu','3','460100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460105','秀英区','1','xiuying','3','460100',NULL,'秀英');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460106','龙华区','1','longhua','3','460100',NULL,'龙华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460107','琼山区','1','qiongshan','3','460100',NULL,'琼山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460108','美兰区','1','meilan','3','460100',NULL,'美兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460200','三亚市','1','sanya','2','460000',NULL,'三亚');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460201','市辖区','0','shixiaqu','3','460200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460203','河东区','1','hedong','3','460200',NULL,'河东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460204','河西区','1','hexi','3','460200',NULL,'河西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460300','三沙市','1','sansha','2','460000',NULL,'三沙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460321','西沙群岛','1','xishaqundao','3','460300',NULL,'西沙群岛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460322','南沙群岛','1','nanshaqundao','3','460300',NULL,'南沙群岛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('460323','中沙群岛的岛礁及其海域','1','zhongshaqundaodedaojiaojiqihaiyu','3','460300',NULL,'中沙群岛的岛礁及其海域');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461000','五指山市','1','wuzhishan','2','460000',NULL,'五指山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461001','五指山','1','wuzhishan','3','461000',NULL,'五指山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461100','琼海市','1','qionghai','2','460000',NULL,'琼海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461101','琼海','1','qionghai','3','461100',NULL,'琼海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461200','儋州市','1','danzhou','2','460000',NULL,'儋州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461201','儋州','1','danzhou','3','461200',NULL,'儋州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461400','文昌市','1','wenchang','2','460000',NULL,'文昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461401','文昌','1','wenchang','3','461400',NULL,'文昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461500','万宁市','1','wanning','2','460000',NULL,'万宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461501','万宁','1','wanning','3','461500',NULL,'万宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461600','东方市','1','dongfang','2','460000',NULL,'东方');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('461601','东方','1','dongfang','3','461600',NULL,'东方');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469000','省直辖县级行政区划','1','shengzhixiaxianjixingzhengquhua','2','460000',NULL,'省直辖县级行政区划');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469021','定安县','1','dingan','3','469000',NULL,'定安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469022','屯昌县','1','tunchang','3','469000',NULL,'屯昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469023','澄迈县','1','chengmai','3','469000',NULL,'澄迈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469024','临高县','1','lingao','3','469000',NULL,'临高');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469025','白沙黎族自治县','1','baishalizuzizhi','3','469000',NULL,'白沙黎族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469026','昌江黎族自治县','1','changjianglizuzizhi','3','469000',NULL,'昌江黎族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469027','乐东黎族自治县','1','ledonglizuzizhi','3','469000',NULL,'乐东黎族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469028','陵水黎族自治县','1','lingshuilizuzizhi','3','469000',NULL,'陵水黎族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469029','保亭黎族苗族自治县','1','baotinglizumiaozuzizhi','3','469000',NULL,'保亭黎族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('469030','琼中黎族苗族自治县','1','qiongzhonglizumiaozuzizhi','3','469000',NULL,'琼中黎族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500000','重庆','1','chongqing','1','0',NULL,'重庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500100','重庆市','1','chongqing','2','500000',NULL,'重庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500101','万州区','1','wanzhou','3','500100',NULL,'万州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500102','涪陵区','1','fuling','3','500100',NULL,'涪陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500103','渝中区','1','yuzhong','3','500100',NULL,'渝中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500104','大渡口区','1','dadukou','3','500100',NULL,'大渡口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500105','江北区','1','jiangbei','3','500100',NULL,'江北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500106','沙坪坝区','1','shapingba','3','500100',NULL,'沙坪坝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500107','九龙坡区','1','jiulongpo','3','500100',NULL,'九龙坡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500108','南岸区','1','nanan','3','500100',NULL,'南岸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500109','北碚区','1','beibei','3','500100',NULL,'北碚');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500110','綦江区','1','qijiang','3','500100',NULL,'綦江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500111','大足区','1','dazu','3','500100',NULL,'大足');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500112','渝北区','1','yubei','3','500100',NULL,'渝北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500113','巴南区','1','banan','3','500100',NULL,'巴南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500114','黔江区','1','qianjiang','3','500100',NULL,'黔江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500115','长寿区','1','zhangshou','3','500100',NULL,'长寿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500116','江津区','1','jiangjin','3','500100',NULL,'江津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500117','合川区','1','hechuan','3','500100',NULL,'合川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500118','永川区','1','yongchuan','3','500100',NULL,'永川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500119','南川区','1','nanchuan','3','500100',NULL,'南川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500200','县辖区','0','xianxiaqu','2','500000',NULL,'县辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500223','潼南县','1','tongnan','3','500100',NULL,'潼南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500224','铜梁县','1','tongliang','3','500100',NULL,'铜梁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500226','荣昌县','1','rongchang','3','500100',NULL,'荣昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500227','璧山县','1','bishan','3','500100',NULL,'璧山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500228','梁平县','1','liangping','3','500100',NULL,'梁平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500229','城口县','1','chengkou','3','500100',NULL,'城口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500230','丰都县','1','fengdou','3','500100',NULL,'丰都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500231','垫江县','1','dianjiang','3','500100',NULL,'垫江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500232','武隆县','1','wulong','3','500100',NULL,'武隆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500233','忠县','1','zhongxian','3','500100',NULL,'忠县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500234','开县','1','kaixian','3','500100',NULL,'开县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500235','云阳县','1','yunyang','3','500100',NULL,'云阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500236','奉节县','1','fengjie','3','500100',NULL,'奉节');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500237','巫山县','1','wushan','3','500100',NULL,'巫山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500238','巫溪县','1','wuxi','3','500100',NULL,'巫溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500240','石柱土家族自治县','1','shizhutujiazuzizhi','3','500100',NULL,'石柱土家族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500241','秀山土家族苗族自治县','1','xiushantujiazumiaozuzizhi','3','500100',NULL,'秀山土家族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500242','酉阳土家族苗族自治县','1','youyangtujiazumiaozuzizhi','3','500100',NULL,'酉阳土家族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('500243','彭水苗族土家族自治县','1','pengshuimiaozutujiazuzizhi','3','500100',NULL,'彭水苗族土家族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510000','四川省','1','sichuan','1','0',NULL,'四川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510100','成都市','1','chengdou','2','510000',NULL,'成都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510101','市辖区','0','shixiaqu','3','510100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510104','锦江区','1','jinjiang','3','510100',NULL,'锦江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510105','青羊区','1','qingyang','3','510100',NULL,'青羊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510106','金牛区','1','jinniu','3','510100',NULL,'金牛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510107','武侯区','1','wuhou','3','510100',NULL,'武侯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510108','成华区','1','chenghua','3','510100',NULL,'成华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510112','龙泉驿区','1','longquanyi','3','510100',NULL,'龙泉驿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510113','青白江区','1','qingbaijiang','3','510100',NULL,'青白江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510114','新都区','1','xindou','3','510100',NULL,'新都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510115','温江区','1','wenjiang','3','510100',NULL,'温江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510121','金堂县','1','jintang','3','510100',NULL,'金堂');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510122','双流县','1','shuangliu','3','510100',NULL,'双流');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510124','郫县','1','pixian','3','510100',NULL,'郫县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510129','大邑县','1','dayi','3','510100',NULL,'大邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510131','蒲江县','1','pujiang','3','510100',NULL,'蒲江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510132','新津县','1','xinjin','3','510100',NULL,'新津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510181','都江堰市','1','doujiangyan','3','510100',NULL,'都江堰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510182','彭州市','1','pengzhou','3','510100',NULL,'彭州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510183','邛崃市','1','qionglai','3','510100',NULL,'邛崃');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510184','崇州市','1','chongzhou','3','510100',NULL,'崇州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510300','自贡市','1','zigong','2','510000',NULL,'自贡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510301','市辖区','0','shixiaqu','3','510300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510302','自流井区','1','ziliujing','3','510300',NULL,'自流井');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510303','贡井区','1','gongjing','3','510300',NULL,'贡井');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510304','大安区','1','daan','3','510300',NULL,'大安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510311','沿滩区','1','yantan','3','510300',NULL,'沿滩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510321','荣县','1','rongxian','3','510300',NULL,'荣县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510322','富顺县','1','fushun','3','510300',NULL,'富顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510400','攀枝花市','1','panzhihua','2','510000',NULL,'攀枝花');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510401','市辖区','0','shixiaqu','3','510400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510402','东区','1','dongqu','3','510400',NULL,'东区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510403','西区','1','xiqu','3','510400',NULL,'西区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510411','仁和区','1','renhe','3','510400',NULL,'仁和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510421','米易县','1','miyi','3','510400',NULL,'米易');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510422','盐边县','1','yanbian','3','510400',NULL,'盐边');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510500','泸州市','1','luzhou','2','510000',NULL,'泸州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510501','市辖区','0','shixiaqu','3','510500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510502','江阳区','1','jiangyang','3','510500',NULL,'江阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510503','纳溪区','1','naxi','3','510500',NULL,'纳溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510504','龙马潭区','1','longmatan','3','510500',NULL,'龙马潭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510521','泸县','1','luxian','3','510500',NULL,'泸县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510522','合江县','1','hejiang','3','510500',NULL,'合江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510524','叙永县','1','xuyong','3','510500',NULL,'叙永');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510525','古蔺县','1','gulin','3','510500',NULL,'古蔺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510600','德阳市','1','deyang','2','510000',NULL,'德阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510601','市辖区','0','shixiaqu','3','510600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510603','旌阳区','1','jingyang','3','510600',NULL,'旌阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510623','中江县','1','zhongjiang','3','510600',NULL,'中江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510626','罗江县','1','luojiang','3','510600',NULL,'罗江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510681','广汉市','1','guanghan','3','510600',NULL,'广汉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510682','什邡市','1','shenfang','3','510600',NULL,'什邡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510683','绵竹市','1','mianzhu','3','510600',NULL,'绵竹');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510700','绵阳市','1','mianyang','2','510000',NULL,'绵阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510701','市辖区','0','shixiaqu','3','510700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510703','涪城区','1','fucheng','3','510700',NULL,'涪城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510704','游仙区','1','youxian','3','510700',NULL,'游仙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510722','三台县','1','santai','3','510700',NULL,'三台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510723','盐亭县','1','yanting','3','510700',NULL,'盐亭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510724','安县','1','anxian','3','510700',NULL,'安县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510725','梓潼县','1','zitong','3','510700',NULL,'梓潼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510726','北川羌族自治县','1','beichuanqiangzuzizhi','3','510700',NULL,'北川羌族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510727','平武县','1','pingwu','3','510700',NULL,'平武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510781','江油市','1','jiangyou','3','510700',NULL,'江油');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510800','广元市','1','guangyuan','2','510000',NULL,'广元');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510801','市辖区','0','shixiaqu','3','510800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510802','利州区','1','lizhou','3','510800',NULL,'利州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510811','元坝区','1','yuanba','3','510800',NULL,'元坝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510812','朝天区','1','chaotian','3','510800',NULL,'朝天');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510821','旺苍县','1','wangcang','3','510800',NULL,'旺苍');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510822','青川县','1','qingchuan','3','510800',NULL,'青川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510823','剑阁县','1','jiange','3','510800',NULL,'剑阁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510824','苍溪县','1','cangxi','3','510800',NULL,'苍溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510900','遂宁市','1','suining','2','510000',NULL,'遂宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510901','市辖区','0','shixiaqu','3','510900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510903','船山区','1','chuanshan','3','510900',NULL,'船山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510904','安居区','1','anju','3','510900',NULL,'安居');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510921','蓬溪县','1','pengxi','3','510900',NULL,'蓬溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510922','射洪县','1','shehong','3','510900',NULL,'射洪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('510923','大英县','1','daying','3','510900',NULL,'大英');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511000','内江市','1','neijiang','2','510000',NULL,'内江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511001','市辖区','0','shixiaqu','3','511000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511002','市中区','1','shizhong','3','511000',NULL,'市中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511011','东兴区','1','dongxing','3','511000',NULL,'东兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511024','威远县','1','weiyuan','3','511000',NULL,'威远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511025','资中县','1','zizhong','3','511000',NULL,'资中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511028','隆昌县','1','longchang','3','511000',NULL,'隆昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511100','乐山市','1','leshan','2','510000',NULL,'乐山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511101','市辖区','0','shixiaqu','3','511100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511102','市中区','1','shizhong','3','511100',NULL,'市中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511111','沙湾区','1','shawan','3','511100',NULL,'沙湾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511112','五通桥区','1','wutongqiao','3','511100',NULL,'五通桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511113','金口河区','1','jinkouhe','3','511100',NULL,'金口河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511123','犍为县','1','jianwei','3','511100',NULL,'犍为');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511124','井研县','1','jingyan','3','511100',NULL,'井研');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511126','夹江县','1','jiajiang','3','511100',NULL,'夹江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511129','沐川县','1','muchuan','3','511100',NULL,'沐川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511132','峨边彝族自治县','1','ebianyizuzizhi','3','511100',NULL,'峨边彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511133','马边彝族自治县','1','mabianyizuzizhi','3','511100',NULL,'马边彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511181','峨眉山市','1','emeishan','3','511100',NULL,'峨眉山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511300','南充市','1','nanchong','2','510000',NULL,'南充');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511301','市辖区','0','shixiaqu','3','511300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511302','顺庆区','1','shunqing','3','511300',NULL,'顺庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511303','高坪区','1','gaoping','3','511300',NULL,'高坪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511304','嘉陵区','1','jialing','3','511300',NULL,'嘉陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511321','南部县','1','nanbu','3','511300',NULL,'南部');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511322','营山县','1','yingshan','3','511300',NULL,'营山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511323','蓬安县','1','pengan','3','511300',NULL,'蓬安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511324','仪陇县','1','yilong','3','511300',NULL,'仪陇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511325','西充县','1','xichong','3','511300',NULL,'西充');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511381','阆中市','1','langzhong','3','511300',NULL,'阆中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511400','眉山市','1','meishan','2','510000',NULL,'眉山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511401','市辖区','0','shixiaqu','3','511400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511402','东坡区','1','dongpo','3','511400',NULL,'东坡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511421','仁寿县','1','renshou','3','511400',NULL,'仁寿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511422','彭山县','1','pengshan','3','511400',NULL,'彭山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511423','洪雅县','1','hongya','3','511400',NULL,'洪雅');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511424','丹棱县','1','danleng','3','511400',NULL,'丹棱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511425','青神县','1','qingshen','3','511400',NULL,'青神');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511500','宜宾市','1','yibin','2','510000',NULL,'宜宾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511501','市辖区','0','shixiaqu','3','511500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511502','翠屏区','1','cuiping','3','511500',NULL,'翠屏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511503','南溪区','1','nanxi','3','511500',NULL,'南溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511521','宜宾县','1','yibin','3','511500',NULL,'宜宾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511523','江安县','1','jiangan','3','511500',NULL,'江安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511524','长宁县','1','zhangning','3','511500',NULL,'长宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511525','高县','1','gaoxian','3','511500',NULL,'高县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511526','珙县','1','gongxian','3','511500',NULL,'珙县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511527','筠连县','1','yunlian','3','511500',NULL,'筠连');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511528','兴文县','1','xingwen','3','511500',NULL,'兴文');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511529','屏山县','1','pingshan','3','511500',NULL,'屏山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511600','广安市','1','guangan','2','510000',NULL,'广安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511601','市辖区','0','shixiaqu','3','511600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511602','广安区','1','guangan','3','511600',NULL,'广安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511621','岳池县','1','yuechi','3','511600',NULL,'岳池');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511622','武胜县','1','wusheng','3','511600',NULL,'武胜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511623','邻水县','1','linshui','3','511600',NULL,'邻水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511681','华蓥市','1','huaying','3','511600',NULL,'华蓥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511700','达州市','1','dazhou','2','510000',NULL,'达州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511701','市辖区','0','shixiaqu','3','511700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511702','通川区','1','tongchuan','3','511700',NULL,'通川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511721','达县','1','daxian','3','511700',NULL,'达县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511722','宣汉县','1','xuanhan','3','511700',NULL,'宣汉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511723','开江县','1','kaijiang','3','511700',NULL,'开江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511724','大竹县','1','dazhu','3','511700',NULL,'大竹');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511725','渠县','1','quxian','3','511700',NULL,'渠县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511781','万源市','1','wanyuan','3','511700',NULL,'万源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511800','雅安市','1','yaan','2','510000',NULL,'雅安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511801','市辖区','0','shixiaqu','3','511800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511802','雨城区','1','yucheng','3','511800',NULL,'雨城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511803','名山区','1','mingshan','3','511800',NULL,'名山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511822','荥经县','1','yingjing','3','511800',NULL,'荥经');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511823','汉源县','1','hanyuan','3','511800',NULL,'汉源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511824','石棉县','1','shimian','3','511800',NULL,'石棉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511825','天全县','1','tianquan','3','511800',NULL,'天全');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511826','芦山县','1','lushan','3','511800',NULL,'芦山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511827','宝兴县','1','baoxing','3','511800',NULL,'宝兴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511900','巴中市','1','bazhong','2','510000',NULL,'巴中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511901','市辖区','0','shixiaqu','3','511900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511902','巴州区','1','bazhou','3','511900',NULL,'巴州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511921','通江县','1','tongjiang','3','511900',NULL,'通江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511922','南江县','1','nanjiang','3','511900',NULL,'南江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('511923','平昌县','1','pingchang','3','511900',NULL,'平昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('512000','资阳市','1','ziyang','2','510000',NULL,'资阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('512001','市辖区','0','shixiaqu','3','512000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('512002','雁江区','1','yanjiang','3','512000',NULL,'雁江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('512021','安岳县','1','anyue','3','512000',NULL,'安岳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('512022','乐至县','1','lezhi','3','512000',NULL,'乐至');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('512081','简阳市','1','jianyang','3','512000',NULL,'简阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513200','阿坝藏族羌族自治州','1','abazangzuqiangzuzizhizhou','2','510000',NULL,'阿坝藏族羌族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513221','汶川县','1','wenchuan','3','513200',NULL,'汶川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513222','理县','1','lixian','3','513200',NULL,'理县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513223','茂县','1','maoxian','3','513200',NULL,'茂县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513224','松潘县','1','songpan','3','513200',NULL,'松潘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513225','九寨沟县','1','jiuzhaigou','3','513200',NULL,'九寨沟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513226','金川县','1','jinchuan','3','513200',NULL,'金川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513227','小金县','1','xiaojin','3','513200',NULL,'小金');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513228','黑水县','1','heishui','3','513200',NULL,'黑水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513229','马尔康县','1','maerkang','3','513200',NULL,'马尔康');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513230','壤塘县','1','rangtang','3','513200',NULL,'壤塘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513231','阿坝县','1','aba','3','513200',NULL,'阿坝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513232','若尔盖县','1','ruoergai','3','513200',NULL,'若尔盖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513233','红原县','1','hongyuan','3','513200',NULL,'红原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513300','甘孜藏族自治州','1','ganzizangzuzizhizhou','2','510000',NULL,'甘孜藏族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513321','康定县','1','kangding','3','513300',NULL,'康定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513322','泸定县','1','luding','3','513300',NULL,'泸定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513323','丹巴县','1','danba','3','513300',NULL,'丹巴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513324','九龙县','1','jiulong','3','513300',NULL,'九龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513325','雅江县','1','yajiang','3','513300',NULL,'雅江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513326','道孚县','1','daofu','3','513300',NULL,'道孚');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513327','炉霍县','1','luhuo','3','513300',NULL,'炉霍');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513328','甘孜县','1','ganzi','3','513300',NULL,'甘孜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513329','新龙县','1','xinlong','3','513300',NULL,'新龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513330','德格县','1','dege','3','513300',NULL,'德格');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513331','白玉县','1','baiyu','3','513300',NULL,'白玉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513332','石渠县','1','shiqu','3','513300',NULL,'石渠');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513333','色达县','1','seda','3','513300',NULL,'色达');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513334','理塘县','1','litang','3','513300',NULL,'理塘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513335','巴塘县','1','batang','3','513300',NULL,'巴塘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513336','乡城县','1','xiangcheng','3','513300',NULL,'乡城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513337','稻城县','1','daocheng','3','513300',NULL,'稻城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513338','得荣县','1','derong','3','513300',NULL,'得荣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513400','凉山彝族自治州','1','liangshanyizuzizhizhou','2','510000',NULL,'凉山彝族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513401','西昌市','1','xichang','3','513400',NULL,'西昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513422','木里藏族自治县','1','mulizangzuzizhi','3','513400',NULL,'木里藏族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513423','盐源县','1','yanyuan','3','513400',NULL,'盐源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513424','德昌县','1','dechang','3','513400',NULL,'德昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513425','会理县','1','huili','3','513400',NULL,'会理');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513426','会东县','1','huidong','3','513400',NULL,'会东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513427','宁南县','1','ningnan','3','513400',NULL,'宁南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513428','普格县','1','puge','3','513400',NULL,'普格');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513429','布拖县','1','butuo','3','513400',NULL,'布拖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513430','金阳县','1','jinyang','3','513400',NULL,'金阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513431','昭觉县','1','zhaojue','3','513400',NULL,'昭觉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513432','喜德县','1','xide','3','513400',NULL,'喜德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513433','冕宁县','1','mianning','3','513400',NULL,'冕宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513434','越西县','1','yuexi','3','513400',NULL,'越西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513435','甘洛县','1','ganluo','3','513400',NULL,'甘洛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513436','美姑县','1','meigu','3','513400',NULL,'美姑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('513437','雷波县','1','leibo','3','513400',NULL,'雷波');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520000','贵州省','1','guizhou','1','0',NULL,'贵州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520100','贵阳市','1','guiyang','2','520000',NULL,'贵阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520101','市辖区','0','shixiaqu','3','520100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520102','南明区','1','nanming','3','520100',NULL,'南明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520103','云岩区','1','yunyan','3','520100',NULL,'云岩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520111','花溪区','1','huaxi','3','520100',NULL,'花溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520112','乌当区','1','wudang','3','520100',NULL,'乌当');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520113','白云区','1','baiyun','3','520100',NULL,'白云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520114','小河区','1','xiaohe','3','520100',NULL,'小河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520121','开阳县','1','kaiyang','3','520100',NULL,'开阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520122','息烽县','1','xifeng','3','520100',NULL,'息烽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520123','修文县','1','xiuwen','3','520100',NULL,'修文');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520181','清镇市','1','qingzhen','3','520100',NULL,'清镇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520200','六盘水市','1','liupanshui','2','520000',NULL,'六盘水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520201','钟山区','1','zhongshan','3','520200',NULL,'钟山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520203','六枝特区','1','liuzhite','3','520200',NULL,'六枝特');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520221','水城县','1','shuicheng','3','520200',NULL,'水城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520222','盘县','1','panxian','3','520200',NULL,'盘县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520300','遵义市','1','zunyi','2','520000',NULL,'遵义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520301','市辖区','0','shixiaqu','3','520300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520302','红花岗区','1','honghuagang','3','520300',NULL,'红花岗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520303','汇川区','1','huichuan','3','520300',NULL,'汇川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520321','遵义县','1','zunyi','3','520300',NULL,'遵义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520322','桐梓县','1','tongzi','3','520300',NULL,'桐梓');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520323','绥阳县','1','suiyang','3','520300',NULL,'绥阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520324','正安县','1','zhengan','3','520300',NULL,'正安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520325','道真仡佬族苗族自治县','1','daozhengelaozumiaozuzizhi','3','520300',NULL,'道真仡佬族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520326','务川仡佬族苗族自治县','1','wuchuangelaozumiaozuzizhi','3','520300',NULL,'务川仡佬族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520327','凤冈县','1','fenggang','3','520300',NULL,'凤冈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520328','湄潭县','1','meitan','3','520300',NULL,'湄潭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520329','余庆县','1','yuqing','3','520300',NULL,'余庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520330','习水县','1','xishui','3','520300',NULL,'习水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520381','赤水市','1','chishui','3','520300',NULL,'赤水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520382','仁怀市','1','renhuai','3','520300',NULL,'仁怀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520400','安顺市','1','anshun','2','520000',NULL,'安顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520401','市辖区','0','shixiaqu','3','520400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520402','西秀区','1','xixiu','3','520400',NULL,'西秀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520421','平坝县','1','pingba','3','520400',NULL,'平坝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520422','普定县','1','puding','3','520400',NULL,'普定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520423','镇宁布依族苗族自治县','1','zhenningbuyizumiaozuzizhi','3','520400',NULL,'镇宁布依族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520424','关岭布依族苗族自治县','1','guanlingbuyizumiaozuzizhi','3','520400',NULL,'关岭布依族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520425','紫云苗族布依族自治县','1','ziyunmiaozubuyizuzizhi','3','520400',NULL,'紫云苗族布依族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520500','毕节市','1','bijie','2','520000',NULL,'毕节');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520502','七星关区','1','qixingguan','3','520500',NULL,'七星关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520521','大方县','1','dafang','3','520500',NULL,'大方');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520522','黔西县','1','qianxi','3','520500',NULL,'黔西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520523','金沙县','1','jinsha','3','520500',NULL,'金沙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520524','织金县','1','zhijin','3','520500',NULL,'织金');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520525','纳雍县','1','nayong','3','520500',NULL,'纳雍');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520526','威宁彝族回族苗族自治县','1','weiningyizuhuizumiaozuzizhi','3','520500',NULL,'威宁彝族回族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520527','赫章县','1','hezhang','3','520500',NULL,'赫章');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520600','铜仁市','1','tongren','2','520000',NULL,'铜仁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520602','碧江区','1','bijiang','3','520600',NULL,'碧江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520603','万山区','1','wanshan','3','520600',NULL,'万山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520621','江口县','1','jiangkou','3','520600',NULL,'江口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520622','玉屏侗族自治县','1','yupingdongzuzizhi','3','520600',NULL,'玉屏侗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520623','石阡县','1','shiqian','3','520600',NULL,'石阡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520624','思南县','1','sinan','3','520600',NULL,'思南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520625','印江土家族苗族自治县','1','yinjiangtujiazumiaozuzizhi','3','520600',NULL,'印江土家族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520626','德江县','1','dejiang','3','520600',NULL,'德江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520627','沿河土家族自治县','1','yanhetujiazuzizhi','3','520600',NULL,'沿河土家族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('520628','松桃苗族自治县','1','songtaomiaozuzizhi','3','520600',NULL,'松桃苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522300','黔西南布依族苗族自治州','1','qianxinanbuyizumiaozuzizhizhou','2','520000',NULL,'黔西南布依族苗族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522301','兴义市','1','xingyi','3','522300',NULL,'兴义');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522322','兴仁县','1','xingren','3','522300',NULL,'兴仁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522323','普安县','1','puan','3','522300',NULL,'普安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522324','晴隆县','1','qinglong','3','522300',NULL,'晴隆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522325','贞丰县','1','zhenfeng','3','522300',NULL,'贞丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522326','望谟县','1','wangmo','3','522300',NULL,'望谟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522327','册亨县','1','ceheng','3','522300',NULL,'册亨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522328','安龙县','1','anlong','3','522300',NULL,'安龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522600','黔东南苗族侗族自治州','1','qiandongnanmiaozudongzuzizhizhou','2','520000',NULL,'黔东南苗族侗族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522601','凯里市','1','kaili','3','522600',NULL,'凯里');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522622','黄平县','1','huangping','3','522600',NULL,'黄平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522623','施秉县','1','shibing','3','522600',NULL,'施秉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522624','三穗县','1','sansui','3','522600',NULL,'三穗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522625','镇远县','1','zhenyuan','3','522600',NULL,'镇远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522626','岑巩县','1','cengong','3','522600',NULL,'岑巩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522627','天柱县','1','tianzhu','3','522600',NULL,'天柱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522628','锦屏县','1','jinping','3','522600',NULL,'锦屏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522629','剑河县','1','jianhe','3','522600',NULL,'剑河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522630','台江县','1','taijiang','3','522600',NULL,'台江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522631','黎平县','1','liping','3','522600',NULL,'黎平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522632','榕江县','1','rongjiang','3','522600',NULL,'榕江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522633','从江县','1','congjiang','3','522600',NULL,'从江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522634','雷山县','1','leishan','3','522600',NULL,'雷山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522635','麻江县','1','majiang','3','522600',NULL,'麻江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522636','丹寨县','1','danzhai','3','522600',NULL,'丹寨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522700','黔南布依族苗族自治州','1','qiannanbuyizumiaozuzizhizhou','2','520000',NULL,'黔南布依族苗族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522701','都匀市','1','douyun','3','522700',NULL,'都匀');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522702','福泉市','1','fuquan','3','522700',NULL,'福泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522722','荔波县','1','libo','3','522700',NULL,'荔波');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522723','贵定县','1','guiding','3','522700',NULL,'贵定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522725','瓮安县','1','wengan','3','522700',NULL,'瓮安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522726','独山县','1','dushan','3','522700',NULL,'独山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522727','平塘县','1','pingtang','3','522700',NULL,'平塘');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522728','罗甸县','1','luodian','3','522700',NULL,'罗甸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522729','长顺县','1','zhangshun','3','522700',NULL,'长顺');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522730','龙里县','1','longli','3','522700',NULL,'龙里');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522731','惠水县','1','huishui','3','522700',NULL,'惠水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('522732','三都水族自治县','1','sandoushuizuzizhi','3','522700',NULL,'三都水族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530000','云南省','1','yunnan','1','0',NULL,'云南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530100','昆明市','1','kunming','2','530000',NULL,'昆明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530101','市辖区','0','shixiaqu','3','530100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530102','五华区','1','wuhua','3','530100',NULL,'五华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530103','盘龙区','1','panlong','3','530100',NULL,'盘龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530111','官渡区','1','guandu','3','530100',NULL,'官渡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530112','西山区','1','xishan','3','530100',NULL,'西山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530113','东川区','1','dongchuan','3','530100',NULL,'东川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530114','呈贡区','1','chenggong','3','530100',NULL,'呈贡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530122','晋宁县','1','jinning','3','530100',NULL,'晋宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530124','富民县','1','fumin','3','530100',NULL,'富民');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530125','宜良县','1','yiliang','3','530100',NULL,'宜良');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530126','石林彝族自治县','1','shilinyizuzizhi','3','530100',NULL,'石林彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530127','嵩明县','1','songming','3','530100',NULL,'嵩明');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530128','禄劝彝族苗族自治县','1','luquanyizumiaozuzizhi','3','530100',NULL,'禄劝彝族苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530129','寻甸回族彝族自治县','1','xundianhuizuyizuzizhi','3','530100',NULL,'寻甸回族彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530181','安宁市','1','anning','3','530100',NULL,'安宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530300','曲靖市','1','qujing','2','530000',NULL,'曲靖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530301','市辖区','0','shixiaqu','3','530300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530302','麒麟区','1','qilin','3','530300',NULL,'麒麟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530321','马龙县','1','malong','3','530300',NULL,'马龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530322','陆良县','1','luliang','3','530300',NULL,'陆良');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530323','师宗县','1','shizong','3','530300',NULL,'师宗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530324','罗平县','1','luoping','3','530300',NULL,'罗平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530325','富源县','1','fuyuan','3','530300',NULL,'富源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530326','会泽县','1','huize','3','530300',NULL,'会泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530328','沾益县','1','zhanyi','3','530300',NULL,'沾益');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530381','宣威市','1','xuanwei','3','530300',NULL,'宣威');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530400','玉溪市','1','yuxi','2','530000',NULL,'玉溪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530402','红塔区','1','hongta','3','530400',NULL,'红塔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530421','江川县','1','jiangchuan','3','530400',NULL,'江川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530422','澄江县','1','chengjiang','3','530400',NULL,'澄江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530423','通海县','1','tonghai','3','530400',NULL,'通海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530424','华宁县','1','huaning','3','530400',NULL,'华宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530425','易门县','1','yimen','3','530400',NULL,'易门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530426','峨山彝族自治县','1','eshanyizuzizhi','3','530400',NULL,'峨山彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530427','新平彝族傣族自治县','1','xinpingyizudaizuzizhi','3','530400',NULL,'新平彝族傣族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530428','元江哈尼族彝族傣族自治县','1','yuanjianghanizuyizudaizuzizhi','3','530400',NULL,'元江哈尼族彝族傣族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530500','保山市','1','baoshan','2','530000',NULL,'保山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530501','市辖区','0','shixiaqu','3','530500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530502','隆阳区','1','longyang','3','530500',NULL,'隆阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530521','施甸县','1','shidian','3','530500',NULL,'施甸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530522','腾冲县','1','tengchong','3','530500',NULL,'腾冲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530523','龙陵县','1','longling','3','530500',NULL,'龙陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530524','昌宁县','1','changning','3','530500',NULL,'昌宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530600','昭通市','1','zhaotong','2','530000',NULL,'昭通');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530601','市辖区','0','shixiaqu','3','530600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530602','昭阳区','1','zhaoyang','3','530600',NULL,'昭阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530621','鲁甸县','1','ludian','3','530600',NULL,'鲁甸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530622','巧家县','1','qiaojia','3','530600',NULL,'巧家');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530623','盐津县','1','yanjin','3','530600',NULL,'盐津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530624','大关县','1','daguan','3','530600',NULL,'大关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530625','永善县','1','yongshan','3','530600',NULL,'永善');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530626','绥江县','1','suijiang','3','530600',NULL,'绥江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530627','镇雄县','1','zhenxiong','3','530600',NULL,'镇雄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530628','彝良县','1','yiliang','3','530600',NULL,'彝良');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530629','威信县','1','weixin','3','530600',NULL,'威信');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530630','水富县','1','shuifu','3','530600',NULL,'水富');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530700','丽江市','1','lijiang','2','530000',NULL,'丽江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530701','市辖区','0','shixiaqu','3','530700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530702','古城区','1','gucheng','3','530700',NULL,'古城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530721','玉龙纳西族自治县','1','yulongnaxizuzizhi','3','530700',NULL,'玉龙纳西族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530722','永胜县','1','yongsheng','3','530700',NULL,'永胜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530723','华坪县','1','huaping','3','530700',NULL,'华坪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530724','宁蒗彝族自治县','1','ninglangyizuzizhi','3','530700',NULL,'宁蒗彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530800','普洱市','1','puer','2','530000',NULL,'普洱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530801','市辖区','0','shixiaqu','3','530800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530802','思茅区','1','simao','3','530800',NULL,'思茅');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530821','宁洱哈尼族彝族自治县','1','ningerhanizuyizuzizhi','3','530800',NULL,'宁洱哈尼族彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530822','墨江哈尼族自治县','1','mojianghanizuzizhi','3','530800',NULL,'墨江哈尼族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530823','景东彝族自治县','1','jingdongyizuzizhi','3','530800',NULL,'景东彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530824','景谷傣族彝族自治县','1','jinggudaizuyizuzizhi','3','530800',NULL,'景谷傣族彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530825','镇沅彝族哈尼族拉祜族自治县','1','zhenyuanyizuhanizulahuzuzizhi','3','530800',NULL,'镇沅彝族哈尼族拉祜族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530826','江城哈尼族彝族自治县','1','jiangchenghanizuyizuzizhi','3','530800',NULL,'江城哈尼族彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530827','孟连傣族拉祜族佤族自治县','1','mengliandaizulahuzuwazuzizhi','3','530800',NULL,'孟连傣族拉祜族佤族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530828','澜沧拉祜族自治县','1','lancanglahuzuzizhi','3','530800',NULL,'澜沧拉祜族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530829','西盟佤族自治县','1','ximengwazuzizhi','3','530800',NULL,'西盟佤族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530900','临沧市','1','lincang','2','530000',NULL,'临沧');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530901','市辖区','0','shixiaqu','3','530900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530902','临翔区','1','linxiang','3','530900',NULL,'临翔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530921','凤庆县','1','fengqing','3','530900',NULL,'凤庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530922','云县','1','yunxian','3','530900',NULL,'云县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530923','永德县','1','yongde','3','530900',NULL,'永德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530924','镇康县','1','zhenkang','3','530900',NULL,'镇康');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530925','双江拉祜族佤族布朗族傣族自治县','1','shuangjianglahuzuwazubulangzudaizuzizhi','3','530900',NULL,'双江拉祜族佤族布朗族傣族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530926','耿马傣族佤族自治县','1','gengmadaizuwazuzizhi','3','530900',NULL,'耿马傣族佤族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('530927','沧源佤族自治县','1','cangyuanwazuzizhi','3','530900',NULL,'沧源佤族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532300','楚雄彝族自治州','1','chuxiongyizuzizhizhou','2','530000',NULL,'楚雄彝族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532301','楚雄市','1','chuxiong','3','532300',NULL,'楚雄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532322','双柏县','1','shuangbo','3','532300',NULL,'双柏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532323','牟定县','1','mouding','3','532300',NULL,'牟定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532324','南华县','1','nanhua','3','532300',NULL,'南华');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532325','姚安县','1','yaoan','3','532300',NULL,'姚安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532326','大姚县','1','dayao','3','532300',NULL,'大姚');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532327','永仁县','1','yongren','3','532300',NULL,'永仁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532328','元谋县','1','yuanmou','3','532300',NULL,'元谋');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532329','武定县','1','wuding','3','532300',NULL,'武定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532331','禄丰县','1','lufeng','3','532300',NULL,'禄丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532500','红河哈尼族彝族自治州','1','honghehanizuyizuzizhizhou','2','530000',NULL,'红河哈尼族彝族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532501','个旧市','1','gejiu','3','532500',NULL,'个旧');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532502','开远市','1','kaiyuan','3','532500',NULL,'开远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532503','蒙自市','1','mengzi','3','532500',NULL,'蒙自');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532523','屏边苗族自治县','1','pingbianmiaozuzizhi','3','532500',NULL,'屏边苗族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532524','建水县','1','jianshui','3','532500',NULL,'建水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532525','石屏县','1','shiping','3','532500',NULL,'石屏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532526','弥勒县','1','mile','3','532500',NULL,'弥勒');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532527','泸西县','1','luxi','3','532500',NULL,'泸西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532528','元阳县','1','yuanyang','3','532500',NULL,'元阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532529','红河县','1','honghe','3','532500',NULL,'红河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532530','金平苗族瑶族傣族自治县','1','jinpingmiaozuyaozudaizuzizhi','3','532500',NULL,'金平苗族瑶族傣族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532531','绿春县','1','lvchun','3','532500',NULL,'绿春');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532532','河口瑶族自治县','1','hekouyaozuzizhi','3','532500',NULL,'河口瑶族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532600','文山壮族苗族自治州','1','wenshanzhuangzumiaozuzizhizhou','2','530000',NULL,'文山壮族苗族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532601','文山市','1','wenshan','3','532600',NULL,'文山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532622','砚山县','1','yanshan','3','532600',NULL,'砚山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532623','西畴县','1','xichou','3','532600',NULL,'西畴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532624','麻栗坡县','1','malipo','3','532600',NULL,'麻栗坡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532625','马关县','1','maguan','3','532600',NULL,'马关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532626','丘北县','1','qiubei','3','532600',NULL,'丘北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532627','广南县','1','guangnan','3','532600',NULL,'广南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532628','富宁县','1','funing','3','532600',NULL,'富宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532800','西双版纳傣族自治州','1','xishuangbannadaizuzizhizhou','2','530000',NULL,'西双版纳傣族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532801','景洪市','1','jinghong','3','532800',NULL,'景洪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532822','勐海县','1','menghai','3','532800',NULL,'勐海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532823','勐腊县','1','mengla','3','532800',NULL,'勐腊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532900','大理白族自治州','1','dalibaizuzizhizhou','2','530000',NULL,'大理白族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532901','大理市','1','dali','3','532900',NULL,'大理');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532922','漾濞彝族自治县','1','yangbiyizuzizhi','3','532900',NULL,'漾濞彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532923','祥云县','1','xiangyun','3','532900',NULL,'祥云');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532924','宾川县','1','binchuan','3','532900',NULL,'宾川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532925','弥渡县','1','midu','3','532900',NULL,'弥渡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532926','南涧彝族自治县','1','nanjianyizuzizhi','3','532900',NULL,'南涧彝族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532927','巍山彝族回族自治县','1','weishanyizuhuizuzizhi','3','532900',NULL,'巍山彝族回族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532928','永平县','1','yongping','3','532900',NULL,'永平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532929','云龙县','1','yunlong','3','532900',NULL,'云龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532930','洱源县','1','eryuan','3','532900',NULL,'洱源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532931','剑川县','1','jianchuan','3','532900',NULL,'剑川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('532932','鹤庆县','1','heqing','3','532900',NULL,'鹤庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533100','德宏傣族景颇族自治州','1','dehongdaizujingpozuzizhizhou','2','530000',NULL,'德宏傣族景颇族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533102','瑞丽市','1','ruili','3','533100',NULL,'瑞丽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533103','芒市','1','mangshi','3','533100',NULL,'芒市');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533122','梁河县','1','lianghe','3','533100',NULL,'梁河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533123','盈江县','1','yingjiang','3','533100',NULL,'盈江');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533124','陇川县','1','longchuan','3','533100',NULL,'陇川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533300','怒江傈僳族自治州','1','nujianglisuzuzizhizhou','2','530000',NULL,'怒江傈僳族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533321','泸水县','1','lushui','3','533300',NULL,'泸水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533323','福贡县','1','fugong','3','533300',NULL,'福贡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533324','贡山独龙族怒族自治县','1','gongshandulongzunuzuzizhi','3','533300',NULL,'贡山独龙族怒族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533325','兰坪白族普米族自治县','1','lanpingbaizupumizuzizhi','3','533300',NULL,'兰坪白族普米族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533400','迪庆藏族自治州','1','diqingzangzuzizhizhou','2','530000',NULL,'迪庆藏族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533421','香格里拉县','1','xianggelila','3','533400',NULL,'香格里拉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533422','德钦县','1','deqin','3','533400',NULL,'德钦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('533423','维西傈僳族自治县','1','weixilisuzuzizhi','3','533400',NULL,'维西傈僳族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540000','西藏自治区','1','xizangzizhi','1','0',NULL,'西藏自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540100','拉萨市','1','lasa','2','540000',NULL,'拉萨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540101','市辖区','0','shixiaqu','3','540100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540102','城关区','1','chengguan','3','540100',NULL,'城关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540121','林周县','1','linzhou','3','540100',NULL,'林周');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540122','当雄县','1','dangxiong','3','540100',NULL,'当雄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540123','尼木县','1','nimu','3','540100',NULL,'尼木');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540124','曲水县','1','qushui','3','540100',NULL,'曲水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540125','堆龙德庆县','1','duilongdeqing','3','540100',NULL,'堆龙德庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540126','达孜县','1','dazi','3','540100',NULL,'达孜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('540127','墨竹工卡县','1','mozhugongka','3','540100',NULL,'墨竹工卡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542100','昌都地区','1','changdoudi','2','540000',NULL,'昌都地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542121','昌都县','1','changdou','3','542100',NULL,'昌都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542122','江达县','1','jiangda','3','542100',NULL,'江达');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542123','贡觉县','1','gongjue','3','542100',NULL,'贡觉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542124','类乌齐县','1','leiwuqi','3','542100',NULL,'类乌齐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542125','丁青县','1','dingqing','3','542100',NULL,'丁青');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542126','察雅县','1','chaya','3','542100',NULL,'察雅');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542127','八宿县','1','basu','3','542100',NULL,'八宿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542128','左贡县','1','zuogong','3','542100',NULL,'左贡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542129','芒康县','1','mangkang','3','542100',NULL,'芒康');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542132','洛隆县','1','luolong','3','542100',NULL,'洛隆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542133','边坝县','1','bianba','3','542100',NULL,'边坝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542200','山南地区','1','shannandi','2','540000',NULL,'山南地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542221','乃东县','1','naidong','3','542200',NULL,'乃东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542222','扎囊县','1','zhanang','3','542200',NULL,'扎囊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542223','贡嘎县','1','gongga','3','542200',NULL,'贡嘎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542224','桑日县','1','sangri','3','542200',NULL,'桑日');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542225','琼结县','1','qiongjie','3','542200',NULL,'琼结');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542226','曲松县','1','qusong','3','542200',NULL,'曲松');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542227','措美县','1','cuomei','3','542200',NULL,'措美');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542228','洛扎县','1','luozha','3','542200',NULL,'洛扎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542229','加查县','1','jiacha','3','542200',NULL,'加查');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542231','隆子县','1','longzi','3','542200',NULL,'隆子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542232','错那县','1','cuonei','3','542200',NULL,'错那');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542233','浪卡子县','1','langkazi','3','542200',NULL,'浪卡子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542300','日喀则地区','1','rikazedi','2','540000',NULL,'日喀则地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542301','日喀则市','1','rikaze','3','542300',NULL,'日喀则');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542322','南木林县','1','nanmulin','3','542300',NULL,'南木林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542323','江孜县','1','jiangzi','3','542300',NULL,'江孜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542324','定日县','1','dingri','3','542300',NULL,'定日');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542325','萨迦县','1','sajia','3','542300',NULL,'萨迦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542326','拉孜县','1','lazi','3','542300',NULL,'拉孜');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542327','昂仁县','1','angren','3','542300',NULL,'昂仁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542328','谢通门县','1','xietongmen','3','542300',NULL,'谢通门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542329','白朗县','1','bailang','3','542300',NULL,'白朗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542330','仁布县','1','renbu','3','542300',NULL,'仁布');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542331','康马县','1','kangma','3','542300',NULL,'康马');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542332','定结县','1','dingjie','3','542300',NULL,'定结');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542333','仲巴县','1','zhongba','3','542300',NULL,'仲巴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542334','亚东县','1','yadong','3','542300',NULL,'亚东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542335','吉隆县','1','jilong','3','542300',NULL,'吉隆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542336','聂拉木县','1','nielamu','3','542300',NULL,'聂拉木');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542337','萨嘎县','1','saga','3','542300',NULL,'萨嘎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542338','岗巴县','1','gangba','3','542300',NULL,'岗巴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542400','那曲地区','1','neiqudi','2','540000',NULL,'那曲地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542421','那曲县','1','neiqu','3','542400',NULL,'那曲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542422','嘉黎县','1','jiali','3','542400',NULL,'嘉黎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542423','比如县','1','biru','3','542400',NULL,'比如');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542424','聂荣县','1','nierong','3','542400',NULL,'聂荣');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542425','安多县','1','anduo','3','542400',NULL,'安多');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542426','申扎县','1','shenzha','3','542400',NULL,'申扎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542427','索县','1','suoxian','3','542400',NULL,'索县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542428','班戈县','1','bange','3','542400',NULL,'班戈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542429','巴青县','1','baqing','3','542400',NULL,'巴青');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542430','尼玛县','1','nima','3','542400',NULL,'尼玛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542441','双湖县','1','shuanghu','3','542400',NULL,'双湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542500','阿里地区','1','alidi','2','540000',NULL,'阿里地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542521','普兰县','1','pulan','3','542500',NULL,'普兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542522','札达县','1','zhada','3','542500',NULL,'札达');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542523','噶尔县','1','gaer','3','542500',NULL,'噶尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542524','日土县','1','ritu','3','542500',NULL,'日土');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542525','革吉县','1','geji','3','542500',NULL,'革吉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542526','改则县','1','gaize','3','542500',NULL,'改则');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542527','措勤县','1','cuoqin','3','542500',NULL,'措勤');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542600','林芝地区','1','linzhidi','2','540000',NULL,'林芝地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542621','林芝县','1','linzhi','3','542600',NULL,'林芝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542622','工布江达县','1','gongbujiangda','3','542600',NULL,'工布江达');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542623','米林县','1','milin','3','542600',NULL,'米林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542624','墨脱县','1','motuo','3','542600',NULL,'墨脱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542625','波密县','1','bomi','3','542600',NULL,'波密');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542626','察隅县','1','chayu','3','542600',NULL,'察隅');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('542627','朗县','1','langxian','3','542600',NULL,'朗县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610000','陕西省','1','shanxi','1','0',NULL,'陕西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610100','西安市','1','xian','2','610000',NULL,'西安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610101','市辖区','0','shixiaqu','3','610100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610102','新城区','1','xincheng','3','610100',NULL,'新城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610103','碑林区','1','beilin','3','610100',NULL,'碑林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610104','莲湖区','1','lianhu','3','610100',NULL,'莲湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610111','灞桥区','1','baqiao','3','610100',NULL,'灞桥');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610112','未央区','1','weiyang','3','610100',NULL,'未央');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('6101120001','龙岭山庄','1','longling','4','610112',NULL,'龙岭山庄');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('6101120002','丽廷豪苑','1','liting','4','610112',NULL,'丽廷豪苑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610113','雁塔区','1','yanta','3','610100',NULL,'雁塔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610114','阎良区','1','yanliang','3','610100',NULL,'阎良');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610115','临潼区','1','lintong','3','610100',NULL,'临潼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610116','长安区','1','zhangan','3','610100',NULL,'长安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610122','蓝田县','1','lantian','3','610100',NULL,'蓝田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610124','周至县','1','zhouzhi','3','610100',NULL,'周至');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610125','户县','1','huxian','3','610100',NULL,'户县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610126','高陵县','1','gaoling','3','610100',NULL,'高陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610131','西咸新区','1','xixian','3','610100',NULL,'西咸');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610141','沣谓新区','1','fengwei','3','610100',NULL,'沣谓');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610151','高新区','1','gaoxinqu','3','610100',NULL,'高新区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610200','铜川市','1','tongchuan','2','610000',NULL,'铜川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610201','市辖区','0','shixiaqu','3','610200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610202','王益区','1','wangyi','3','610200',NULL,'王益');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610203','印台区','1','yintai','3','610200',NULL,'印台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610204','耀州区','1','yaozhou','3','610200',NULL,'耀州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610222','宜君县','1','yijun','3','610200',NULL,'宜君');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610300','宝鸡市','1','baoji','2','610000',NULL,'宝鸡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610301','市辖区','0','shixiaqu','3','610300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610302','渭滨区','1','weibin','3','610300',NULL,'渭滨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610303','金台区','1','jintai','3','610300',NULL,'金台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610304','陈仓区','1','chencang','3','610300',NULL,'陈仓');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610322','凤翔县','1','fengxiang','3','610300',NULL,'凤翔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610323','岐山县','1','qishan','3','610300',NULL,'岐山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610324','扶风县','1','fufeng','3','610300',NULL,'扶风');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610326','眉县','1','meixian','3','610300',NULL,'眉县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610327','陇县','1','longxian','3','610300',NULL,'陇县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610328','千阳县','1','qianyang','3','610300',NULL,'千阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610329','麟游县','1','linyou','3','610300',NULL,'麟游');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610330','凤县','1','fengxian','3','610300',NULL,'凤县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610331','太白县','1','taibai','3','610300',NULL,'太白');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610400','咸阳市','1','xianyang','2','610000',NULL,'咸阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610401','市辖区','0','shixiaqu','3','610400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610402','秦都区','1','qindou','3','610400',NULL,'秦都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610403','杨陵区','1','yangling','3','610400',NULL,'杨陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610404','渭城区','1','weicheng','3','610400',NULL,'渭城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610422','三原县','1','sanyuan','3','610400',NULL,'三原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610423','泾阳县','1','jingyang','3','610400',NULL,'泾阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610424','乾县','1','qianxian','3','610400',NULL,'乾县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610425','礼泉县','1','liquan','3','610400',NULL,'礼泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610426','永寿县','1','yongshou','3','610400',NULL,'永寿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610427','彬县','1','binxian','3','610400',NULL,'彬县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610428','长武县','1','zhangwu','3','610400',NULL,'长武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610429','旬邑县','1','xunyi','3','610400',NULL,'旬邑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610430','淳化县','1','chunhua','3','610400',NULL,'淳化');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610431','武功县','1','wugong','3','610400',NULL,'武功');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610441','泾渭新区','1','jingwei','3','610400',NULL,'泾渭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610481','兴平市','1','xingping','3','610400',NULL,'兴平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610500','渭南市','1','weinan','2','610000',NULL,'渭南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610501','市辖区','0','shixiaqu','3','610500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610502','临渭区','1','linwei','3','610500',NULL,'临渭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610521','华县','1','huaxian','3','610500',NULL,'华县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610522','潼关县','1','tongguan','3','610500',NULL,'潼关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610523','大荔县','1','dali','3','610500',NULL,'大荔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610524','合阳县','1','heyang','3','610500',NULL,'合阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610525','澄城县','1','chengcheng','3','610500',NULL,'澄城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610526','蒲城县','1','pucheng','3','610500',NULL,'蒲城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610527','白水县','1','baishui','3','610500',NULL,'白水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610528','富平县','1','fuping','3','610500',NULL,'富平');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610581','韩城市','1','hancheng','3','610500',NULL,'韩城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610582','华阴市','1','huayin','3','610500',NULL,'华阴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610600','延安市','1','yanan','2','610000',NULL,'延安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610601','市辖区','0','shixiaqu','3','610600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610602','宝塔区','1','baota','3','610600',NULL,'宝塔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610621','延长县','1','yanzhang','3','610600',NULL,'延长');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610622','延川县','1','yanchuan','3','610600',NULL,'延川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610623','子长县','1','zizhang','3','610600',NULL,'子长');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610624','安塞县','1','ansai','3','610600',NULL,'安塞');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610625','志丹县','1','zhidan','3','610600',NULL,'志丹');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610626','吴起县','1','wuqi','3','610600',NULL,'吴起');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610627','甘泉县','1','ganquan','3','610600',NULL,'甘泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610628','富县','1','fuxian','3','610600',NULL,'富县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610629','洛川县','1','luochuan','3','610600',NULL,'洛川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610630','宜川县','1','yichuan','3','610600',NULL,'宜川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610631','黄龙县','1','huanglong','3','610600',NULL,'黄龙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610632','黄陵县','1','huangling','3','610600',NULL,'黄陵');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610700','汉中市','1','hanzhong','2','610000',NULL,'汉中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610701','市辖区','0','shixiaqu','3','610700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610702','汉台区','1','hantai','3','610700',NULL,'汉台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610721','南郑县','1','nanzheng','3','610700',NULL,'南郑');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610722','城固县','1','chenggu','3','610700',NULL,'城固');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610723','洋县','1','yangxian','3','610700',NULL,'洋县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610724','西乡县','1','xixiang','3','610700',NULL,'西乡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610725','勉县','1','mianxian','3','610700',NULL,'勉县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610726','宁强县','1','ningqiang','3','610700',NULL,'宁强');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610727','略阳县','1','lveyang','3','610700',NULL,'略阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610728','镇巴县','1','zhenba','3','610700',NULL,'镇巴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610729','留坝县','1','liuba','3','610700',NULL,'留坝');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610730','佛坪县','1','foping','3','610700',NULL,'佛坪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610800','榆林市','1','yulin','2','610000',NULL,'榆林');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610801','市辖区','0','shixiaqu','3','610800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610802','榆阳区','1','yuyang','3','610800',NULL,'榆阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610821','神木县','1','shenmu','3','610800',NULL,'神木');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610822','府谷县','1','fugu','3','610800',NULL,'府谷');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610823','横山县','1','hengshan','3','610800',NULL,'横山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610824','靖边县','1','jingbian','3','610800',NULL,'靖边');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610825','定边县','1','dingbian','3','610800',NULL,'定边');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610826','绥德县','1','suide','3','610800',NULL,'绥德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610827','米脂县','1','mizhi','3','610800',NULL,'米脂');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610828','佳县','1','jiaxian','3','610800',NULL,'佳县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610829','吴堡县','1','wubao','3','610800',NULL,'吴堡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610830','清涧县','1','qingjian','3','610800',NULL,'清涧');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610831','子洲县','1','zizhou','3','610800',NULL,'子洲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610900','安康市','1','ankang','2','610000',NULL,'安康');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610901','市辖区','0','shixiaqu','3','610900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610902','汉滨区','1','hanbin','3','610900',NULL,'汉滨');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610921','汉阴县','1','hanyin','3','610900',NULL,'汉阴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610922','石泉县','1','shiquan','3','610900',NULL,'石泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610923','宁陕县','1','ningshan','3','610900',NULL,'宁陕');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610924','紫阳县','1','ziyang','3','610900',NULL,'紫阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610925','岚皋县','1','langao','3','610900',NULL,'岚皋');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610926','平利县','1','pingli','3','610900',NULL,'平利');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610927','镇坪县','1','zhenping','3','610900',NULL,'镇坪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610928','旬阳县','1','xunyang','3','610900',NULL,'旬阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('610929','白河县','1','baihe','3','610900',NULL,'白河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('611000','商洛市','1','shangluo','2','610000',NULL,'商洛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('611001','市辖区','0','shixiaqu','3','611000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('611002','商州区','1','shangzhou','3','611000',NULL,'商州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('611021','洛南县','1','luonan','3','611000',NULL,'洛南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('611022','丹凤县','1','danfeng','3','611000',NULL,'丹凤');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('611023','商南县','1','shangnan','3','611000',NULL,'商南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('611024','山阳县','1','shanyang','3','611000',NULL,'山阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('611025','镇安县','1','zhenan','3','611000',NULL,'镇安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('611026','柞水县','1','zuoshui','3','611000',NULL,'柞水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620000','甘肃省','1','gansu','1','0',NULL,'甘肃');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620100','兰州市','1','lanzhou','2','620000',NULL,'兰州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620101','市辖区','0','shixiaqu','3','620100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620102','城关区','1','chengguan','3','620100',NULL,'城关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620103','七里河区','1','qilihe','3','620100',NULL,'七里河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620104','西固区','1','xigu','3','620100',NULL,'西固');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620105','安宁区','1','anning','3','620100',NULL,'安宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620111','红古区','1','honggu','3','620100',NULL,'红古');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620121','永登县','1','yongdeng','3','620100',NULL,'永登');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620122','皋兰县','1','gaolan','3','620100',NULL,'皋兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620123','榆中县','1','yuzhong','3','620100',NULL,'榆中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620200','嘉峪关市','1','jiayuguan','2','620000',NULL,'嘉峪关');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620201','市辖区','0','shixiaqu','3','620200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620202','峪泉镇','1','yuquanzhen','3','620200',NULL,'峪泉镇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620203','文殊镇','1','wenshuzhen','3','620200',NULL,'文殊镇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620204','新城镇','1','xinchengzhen','3','620200',NULL,'新城镇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620300','金昌市','1','jinchang','2','620000',NULL,'金昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620301','市辖区','0','shixiaqu','3','620300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620302','金川区','1','jinchuan','3','620300',NULL,'金川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620321','永昌县','1','yongchang','3','620300',NULL,'永昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620400','白银市','1','baiyin','2','620000',NULL,'白银');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620401','市辖区','0','shixiaqu','3','620400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620402','白银区','1','baiyin','3','620400',NULL,'白银');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620403','平川区','1','pingchuan','3','620400',NULL,'平川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620421','靖远县','1','jingyuan','3','620400',NULL,'靖远');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620422','会宁县','1','huining','3','620400',NULL,'会宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620423','景泰县','1','jingtai','3','620400',NULL,'景泰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620500','天水市','1','tianshui','2','620000',NULL,'天水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620501','市辖区','0','shixiaqu','3','620500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620502','秦州区','1','qinzhou','3','620500',NULL,'秦州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620503','麦积区','1','maiji','3','620500',NULL,'麦积');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620521','清水县','1','qingshui','3','620500',NULL,'清水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620522','秦安县','1','qinan','3','620500',NULL,'秦安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620523','甘谷县','1','gangu','3','620500',NULL,'甘谷');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620524','武山县','1','wushan','3','620500',NULL,'武山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620525','张家川回族自治县','1','zhangjiachuanhuizuzizhi','3','620500',NULL,'张家川回族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620600','武威市','1','wuwei','2','620000',NULL,'武威');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620601','市辖区','0','shixiaqu','3','620600',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620602','凉州区','1','liangzhou','3','620600',NULL,'凉州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620621','民勤县','1','minqin','3','620600',NULL,'民勤');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620622','古浪县','1','gulang','3','620600',NULL,'古浪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620623','天祝藏族自治县','1','tianzhuzangzuzizhi','3','620600',NULL,'天祝藏族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620700','张掖市','1','zhangye','2','620000',NULL,'张掖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620701','市辖区','0','shixiaqu','3','620700',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620702','甘州区','1','ganzhou','3','620700',NULL,'甘州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620721','肃南裕固族自治县','1','sunanyuguzuzizhi','3','620700',NULL,'肃南裕固族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620722','民乐县','1','minle','3','620700',NULL,'民乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620723','临泽县','1','linze','3','620700',NULL,'临泽');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620724','高台县','1','gaotai','3','620700',NULL,'高台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620725','山丹县','1','shandan','3','620700',NULL,'山丹');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620800','平凉市','1','pingliang','2','620000',NULL,'平凉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620801','市辖区','0','shixiaqu','3','620800',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620802','崆峒区','1','kongtong','3','620800',NULL,'崆峒');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620821','泾川县','1','jingchuan','3','620800',NULL,'泾川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620822','灵台县','1','lingtai','3','620800',NULL,'灵台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620823','崇信县','1','chongxin','3','620800',NULL,'崇信');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620824','华亭县','1','huating','3','620800',NULL,'华亭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620825','庄浪县','1','zhuanglang','3','620800',NULL,'庄浪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620826','静宁县','1','jingning','3','620800',NULL,'静宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620900','酒泉市','1','jiuquan','2','620000',NULL,'酒泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620901','市辖区','0','shixiaqu','3','620900',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620902','肃州区','1','suzhou','3','620900',NULL,'肃州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620921','金塔县','1','jinta','3','620900',NULL,'金塔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620922','瓜州县','1','guazhou','3','620900',NULL,'瓜州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620923','肃北蒙古族自治县','1','subeimengguzuzizhi','3','620900',NULL,'肃北蒙古族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620924','阿克塞哈萨克族自治县','1','akesaihasakezuzizhi','3','620900',NULL,'阿克塞哈萨克族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620981','玉门市','1','yumen','3','620900',NULL,'玉门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('620982','敦煌市','1','dunhuang','3','620900',NULL,'敦煌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621000','庆阳市','1','qingyang','2','620000',NULL,'庆阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621001','市辖区','0','shixiaqu','3','621000',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621002','西峰区','1','xifeng','3','621000',NULL,'西峰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621021','庆城县','1','qingcheng','3','621000',NULL,'庆城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621022','环县','1','huanxian','3','621000',NULL,'环县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621023','华池县','1','huachi','3','621000',NULL,'华池');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621024','合水县','1','heshui','3','621000',NULL,'合水');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621025','正宁县','1','zhengning','3','621000',NULL,'正宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621026','宁县','1','ningxian','3','621000',NULL,'宁县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621027','镇原县','1','zhenyuan','3','621000',NULL,'镇原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621100','定西市','1','dingxi','2','620000',NULL,'定西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621101','市辖区','0','shixiaqu','3','621100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621102','安定区','1','anding','3','621100',NULL,'安定');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621121','通渭县','1','tongwei','3','621100',NULL,'通渭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621122','陇西县','1','longxi','3','621100',NULL,'陇西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621123','渭源县','1','weiyuan','3','621100',NULL,'渭源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621124','临洮县','1','lintao','3','621100',NULL,'临洮');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621125','漳县','1','zhangxian','3','621100',NULL,'漳县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621126','岷县','1','minxian','3','621100',NULL,'岷县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621200','陇南市','1','longnan','2','620000',NULL,'陇南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621201','市辖区','0','shixiaqu','3','621200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621202','武都区','1','wudou','3','621200',NULL,'武都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621221','成县','1','chengxian','3','621200',NULL,'成县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621222','文县','1','wenxian','3','621200',NULL,'文县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621223','宕昌县','1','dangchang','3','621200',NULL,'宕昌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621224','康县','1','kangxian','3','621200',NULL,'康县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621225','西和县','1','xihe','3','621200',NULL,'西和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621226','礼县','1','lixian','3','621200',NULL,'礼县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621227','徽县','1','huixian','3','621200',NULL,'徽县');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('621228','两当县','1','liangdang','3','621200',NULL,'两当');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('622900','临夏回族自治州','1','linxiahuizuzizhizhou','2','620000',NULL,'临夏回族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('622901','临夏市','1','linxia','3','622900',NULL,'临夏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('622921','临夏县','1','linxia','3','622900',NULL,'临夏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('622922','康乐县','1','kangle','3','622900',NULL,'康乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('622923','永靖县','1','yongjing','3','622900',NULL,'永靖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('622924','广河县','1','guanghe','3','622900',NULL,'广河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('622925','和政县','1','hezheng','3','622900',NULL,'和政');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('622926','东乡族自治县','1','dongxiangzuzizhi','3','622900',NULL,'东乡族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('622927','积石山保安族东乡族撒拉族自治县','1','jishishanbaoanzudongxiangzusalazuzizhi','3','622900',NULL,'积石山保安族东乡族撒拉族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('623000','甘南藏族自治州','1','gannanzangzuzizhizhou','2','620000',NULL,'甘南藏族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('623001','合作市','1','hezuo','3','623000',NULL,'合作');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('623021','临潭县','1','lintan','3','623000',NULL,'临潭');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('623022','卓尼县','1','zhuoni','3','623000',NULL,'卓尼');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('623023','舟曲县','1','zhouqu','3','623000',NULL,'舟曲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('623024','迭部县','1','diebu','3','623000',NULL,'迭部');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('623025','玛曲县','1','maqu','3','623000',NULL,'玛曲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('623026','碌曲县','1','liuqu','3','623000',NULL,'碌曲');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('623027','夏河县','1','xiahe','3','623000',NULL,'夏河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630000','青海省','1','qinghai','1','0',NULL,'青海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630100','西宁市','1','xining','2','630000',NULL,'西宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630101','市辖区','0','shixiaqu','3','630100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630102','城东区','1','chengdong','3','630100',NULL,'城东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630103','城中区','1','chengzhong','3','630100',NULL,'城中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630104','城西区','1','chengxi','3','630100',NULL,'城西');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630105','城北区','1','chengbei','3','630100',NULL,'城北');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630121','大通回族土族自治县','1','datonghuizutuzuzizhi','3','630100',NULL,'大通回族土族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630122','湟中县','1','huangzhong','3','630100',NULL,'湟中');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('630123','湟源县','1','huangyuan','3','630100',NULL,'湟源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632100','海东地区','1','haidongdi','2','630000',NULL,'海东地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632121','平安县','1','pingan','3','632100',NULL,'平安');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632122','民和回族土族自治县','1','minhehuizutuzuzizhi','3','632100',NULL,'民和回族土族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632123','乐都县','1','ledou','3','632100',NULL,'乐都');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632126','互助土族自治县','1','huzhutuzuzizhi','3','632100',NULL,'互助土族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632127','化隆回族自治县','1','hualonghuizuzizhi','3','632100',NULL,'化隆回族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632128','循化撒拉族自治县','1','xunhuasalazuzizhi','3','632100',NULL,'循化撒拉族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632200','海北藏族自治州','1','haibeizangzuzizhizhou','2','630000',NULL,'海北藏族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632221','门源回族自治县','1','menyuanhuizuzizhi','3','632200',NULL,'门源回族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632222','祁连县','1','qilian','3','632200',NULL,'祁连');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632223','海晏县','1','haiyan','3','632200',NULL,'海晏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632224','刚察县','1','gangcha','3','632200',NULL,'刚察');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632300','黄南藏族自治州','1','huangnanzangzuzizhizhou','2','630000',NULL,'黄南藏族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632321','同仁县','1','tongren','3','632300',NULL,'同仁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632322','尖扎县','1','jianzha','3','632300',NULL,'尖扎');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632323','泽库县','1','zeku','3','632300',NULL,'泽库');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632324','河南蒙古族自治县','1','henanmengguzuzizhi','3','632300',NULL,'河南蒙古族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632500','海南藏族自治州','1','hainanzangzuzizhizhou','2','630000',NULL,'海南藏族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632521','共和县','1','gonghe','3','632500',NULL,'共和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632522','同德县','1','tongde','3','632500',NULL,'同德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632523','贵德县','1','guide','3','632500',NULL,'贵德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632524','兴海县','1','xinghai','3','632500',NULL,'兴海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632525','贵南县','1','guinan','3','632500',NULL,'贵南');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632600','果洛藏族自治州','1','guoluozangzuzizhizhou','2','630000',NULL,'果洛藏族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632621','玛沁县','1','maqin','3','632600',NULL,'玛沁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632622','班玛县','1','banma','3','632600',NULL,'班玛');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632623','甘德县','1','gande','3','632600',NULL,'甘德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632624','达日县','1','dari','3','632600',NULL,'达日');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632625','久治县','1','jiuzhi','3','632600',NULL,'久治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632626','玛多县','1','maduo','3','632600',NULL,'玛多');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632700','玉树藏族自治州','1','yushuzangzuzizhizhou','2','630000',NULL,'玉树藏族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632721','玉树县','1','yushu','3','632700',NULL,'玉树');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632722','杂多县','1','zaduo','3','632700',NULL,'杂多');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632723','称多县','1','chengduo','3','632700',NULL,'称多');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632724','治多县','1','zhiduo','3','632700',NULL,'治多');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632725','囊谦县','1','nangqian','3','632700',NULL,'囊谦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632726','曲麻莱县','1','qumalai','3','632700',NULL,'曲麻莱');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632800','海西蒙古族藏族自治州','1','haiximengguzuzangzuzizhizhou','2','630000',NULL,'海西蒙古族藏族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632801','格尔木市','1','geermu','3','632800',NULL,'格尔木');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632802','德令哈市','1','delingha','3','632800',NULL,'德令哈');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632821','乌兰县','1','wulan','3','632800',NULL,'乌兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632822','都兰县','1','doulan','3','632800',NULL,'都兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('632823','天峻县','1','tianjun','3','632800',NULL,'天峻');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640000','宁夏回族自治区','1','ningxiahuizuzizhi','1','0',NULL,'宁夏回族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640100','银川市','1','yinchuan','2','640000',NULL,'银川');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640101','市辖区','0','shixiaqu','3','640100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640104','兴庆区','1','xingqing','3','640100',NULL,'兴庆');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640105','西夏区','1','xixia','3','640100',NULL,'西夏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640106','金凤区','1','jinfeng','3','640100',NULL,'金凤');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640121','永宁县','1','yongning','3','640100',NULL,'永宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640122','贺兰县','1','helan','3','640100',NULL,'贺兰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640181','灵武市','1','lingwu','3','640100',NULL,'灵武');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640200','石嘴山市','1','shizuishan','2','640000',NULL,'石嘴山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640201','市辖区','0','shixiaqu','3','640200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640202','大武口区','1','dawukou','3','640200',NULL,'大武口');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640205','惠农区','1','huinong','3','640200',NULL,'惠农');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640221','平罗县','1','pingluo','3','640200',NULL,'平罗');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640300','吴忠市','1','wuzhong','2','640000',NULL,'吴忠');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640301','市辖区','0','shixiaqu','3','640300',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640302','利通区','1','litong','3','640300',NULL,'利通');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640303','红寺堡区','1','hongsibao','3','640300',NULL,'红寺堡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640323','盐池县','1','yanchi','3','640300',NULL,'盐池');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640324','同心县','1','tongxin','3','640300',NULL,'同心');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640381','青铜峡市','1','qingtongxia','3','640300',NULL,'青铜峡');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640400','固原市','1','guyuan','2','640000',NULL,'固原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640401','市辖区','0','shixiaqu','3','640400',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640402','原州区','1','yuanzhou','3','640400',NULL,'原州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640422','西吉县','1','xiji','3','640400',NULL,'西吉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640423','隆德县','1','longde','3','640400',NULL,'隆德');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640424','泾源县','1','jingyuan','3','640400',NULL,'泾源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640425','彭阳县','1','pengyang','3','640400',NULL,'彭阳');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640500','中卫市','1','zhongwei','2','640000',NULL,'中卫');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640501','市辖区','0','shixiaqu','3','640500',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640502','沙坡头区','1','shapotou','3','640500',NULL,'沙坡头');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640521','中宁县','1','zhongning','3','640500',NULL,'中宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('640522','海原县','1','haiyuan','3','640500',NULL,'海原');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650000','新疆维吾尔自治区','1','xinjiangweiwuerzizhi','1','0',NULL,'新疆维吾尔自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650100','乌鲁木齐市','1','wulumuqi','2','650000',NULL,'乌鲁木齐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650101','市辖区','0','shixiaqu','3','650100',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650102','天山区','1','tianshan','3','650100',NULL,'天山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650103','沙依巴克区','1','shayibake','3','650100',NULL,'沙依巴克');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650104','新市区','1','xinshi','3','650100',NULL,'新市');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650105','水磨沟区','1','shuimogou','3','650100',NULL,'水磨沟');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650106','头屯河区','1','toutunhe','3','650100',NULL,'头屯河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650107','达坂城区','1','dabancheng','3','650100',NULL,'达坂城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650109','米东区','1','midong','3','650100',NULL,'米东');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650121','乌鲁木齐县','1','wulumuqi','3','650100',NULL,'乌鲁木齐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650200','克拉玛依市','1','kelamayi','2','650000',NULL,'克拉玛依');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650201','市辖区','0','shixiaqu','3','650200',NULL,'市辖区');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650202','独山子区','1','dushanzi','3','650200',NULL,'独山子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650203','克拉玛依区','1','kelamayi','3','650200',NULL,'克拉玛依');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650204','白碱滩区','1','baijiantan','3','650200',NULL,'白碱滩');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('650205','乌尔禾区','1','wuerhe','3','650200',NULL,'乌尔禾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652100','吐鲁番地区','1','tulufandi','2','650000',NULL,'吐鲁番地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652101','吐鲁番市','1','tulufan','3','652100',NULL,'吐鲁番');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652122','鄯善县','1','shanshan','3','652100',NULL,'鄯善');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652123','托克逊县','1','tuokexun','3','652100',NULL,'托克逊');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652200','哈密地区','1','hamidi','2','650000',NULL,'哈密地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652201','哈密市','1','hami','3','652200',NULL,'哈密');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652222','巴里坤哈萨克自治县','1','balikunhasakezizhi','3','652200',NULL,'巴里坤哈萨克自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652223','伊吾县','1','yiwu','3','652200',NULL,'伊吾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652300','昌吉回族自治州','1','changjihuizuzizhizhou','2','650000',NULL,'昌吉回族自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652301','昌吉市','1','changji','3','652300',NULL,'昌吉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652302','阜康市','1','fukang','3','652300',NULL,'阜康');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652323','呼图壁县','1','hutubi','3','652300',NULL,'呼图壁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652324','玛纳斯县','1','manasi','3','652300',NULL,'玛纳斯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652325','奇台县','1','qitai','3','652300',NULL,'奇台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652327','吉木萨尔县','1','jimusaer','3','652300',NULL,'吉木萨尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652328','木垒哈萨克自治县','1','muleihasakezizhi','3','652300',NULL,'木垒哈萨克自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652700','博尔塔拉蒙古自治州','1','boertalamengguzizhizhou','2','650000',NULL,'博尔塔拉蒙古自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652701','博乐市','1','bole','3','652700',NULL,'博乐');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652722','精河县','1','jinghe','3','652700',NULL,'精河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652723','温泉县','1','wenquan','3','652700',NULL,'温泉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652800','巴音郭楞蒙古自治州','1','bayinguolengmengguzizhizhou','2','650000',NULL,'巴音郭楞蒙古自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652801','库尔勒市','1','kuerle','3','652800',NULL,'库尔勒');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652822','轮台县','1','luntai','3','652800',NULL,'轮台');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652823','尉犁县','1','weili','3','652800',NULL,'尉犁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652824','若羌县','1','ruoqiang','3','652800',NULL,'若羌');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652825','且末县','1','qiemo','3','652800',NULL,'且末');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652826','焉耆回族自治县','1','yanqihuizuzizhi','3','652800',NULL,'焉耆回族自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652827','和静县','1','hejing','3','652800',NULL,'和静');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652828','和硕县','1','heshuo','3','652800',NULL,'和硕');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652829','博湖县','1','bohu','3','652800',NULL,'博湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652900','阿克苏地区','1','akesudi','2','650000',NULL,'阿克苏地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652901','阿克苏市','1','akesu','3','652900',NULL,'阿克苏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652922','温宿县','1','wensu','3','652900',NULL,'温宿');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652923','库车县','1','kuche','3','652900',NULL,'库车');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652924','沙雅县','1','shaya','3','652900',NULL,'沙雅');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652925','新和县','1','xinhe','3','652900',NULL,'新和');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652926','拜城县','1','baicheng','3','652900',NULL,'拜城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652927','乌什县','1','wushen','3','652900',NULL,'乌什');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652928','阿瓦提县','1','awati','3','652900',NULL,'阿瓦提');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('652929','柯坪县','1','keping','3','652900',NULL,'柯坪');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653000','克孜勒苏柯尔克孜自治州','1','kezilesukeerkezizizhizhou','2','650000',NULL,'克孜勒苏柯尔克孜自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653001','阿图什市','1','atushen','3','653000',NULL,'阿图什');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653022','阿克陶县','1','aketao','3','653000',NULL,'阿克陶');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653023','阿合奇县','1','aheqi','3','653000',NULL,'阿合奇');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653024','乌恰县','1','wuqia','3','653000',NULL,'乌恰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653100','喀什地区','1','kashendi','2','650000',NULL,'喀什地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653101','喀什市','1','kashen','3','653100',NULL,'喀什');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653121','疏附县','1','shufu','3','653100',NULL,'疏附');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653122','疏勒县','1','shule','3','653100',NULL,'疏勒');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653123','英吉沙县','1','yingjisha','3','653100',NULL,'英吉沙');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653124','泽普县','1','zepu','3','653100',NULL,'泽普');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653125','莎车县','1','shache','3','653100',NULL,'莎车');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653126','叶城县','1','yecheng','3','653100',NULL,'叶城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653127','麦盖提县','1','maigaiti','3','653100',NULL,'麦盖提');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653128','岳普湖县','1','yuepuhu','3','653100',NULL,'岳普湖');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653129','伽师县','1','jiashi','3','653100',NULL,'伽师');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653130','巴楚县','1','bachu','3','653100',NULL,'巴楚');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653131','塔什库尔干塔吉克自治县','1','tashenkuergantajikezizhi','3','653100',NULL,'塔什库尔干塔吉克自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653200','和田地区','1','hetiandi','2','650000',NULL,'和田地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653201','和田市','1','hetian','3','653200',NULL,'和田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653221','和田县','1','hetian','3','653200',NULL,'和田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653222','墨玉县','1','moyu','3','653200',NULL,'墨玉');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653223','皮山县','1','pishan','3','653200',NULL,'皮山');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653224','洛浦县','1','luopu','3','653200',NULL,'洛浦');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653225','策勒县','1','cele','3','653200',NULL,'策勒');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653226','于田县','1','yutian','3','653200',NULL,'于田');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('653227','民丰县','1','minfeng','3','653200',NULL,'民丰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654000','伊犁哈萨克自治州','1','yilihasakezizhizhou','2','650000',NULL,'伊犁哈萨克自治州');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654002','伊宁市','1','yining','3','654000',NULL,'伊宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654003','奎屯市','1','kuitun','3','654000',NULL,'奎屯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654021','伊宁县','1','yining','3','654000',NULL,'伊宁');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654022','察布查尔锡伯自治县','1','chabuchaerxibozizhi','3','654000',NULL,'察布查尔锡伯自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654023','霍城县','1','huocheng','3','654000',NULL,'霍城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654024','巩留县','1','gongliu','3','654000',NULL,'巩留');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654025','新源县','1','xinyuan','3','654000',NULL,'新源');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654026','昭苏县','1','zhaosu','3','654000',NULL,'昭苏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654027','特克斯县','1','tekesi','3','654000',NULL,'特克斯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654028','尼勒克县','1','nileke','3','654000',NULL,'尼勒克');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654200','塔城地区','1','tachengdi','2','650000',NULL,'塔城地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654201','塔城市','1','tacheng','3','654200',NULL,'塔城');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654202','乌苏市','1','wusu','3','654200',NULL,'乌苏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654221','额敏县','1','emin','3','654200',NULL,'额敏');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654223','沙湾县','1','shawan','3','654200',NULL,'沙湾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654224','托里县','1','tuoli','3','654200',NULL,'托里');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654225','裕民县','1','yumin','3','654200',NULL,'裕民');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654226','和布克赛尔蒙古自治县','1','hebukesaiermengguzizhi','3','654200',NULL,'和布克赛尔蒙古自治');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654300','阿勒泰地区','1','aletaidi','2','650000',NULL,'阿勒泰地');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654301','阿勒泰市','1','aletai','3','654300',NULL,'阿勒泰');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654321','布尔津县','1','buerjin','3','654300',NULL,'布尔津');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654322','富蕴县','1','fuyun','3','654300',NULL,'富蕴');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654323','福海县','1','fuhai','3','654300',NULL,'福海');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654324','哈巴河县','1','habahe','3','654300',NULL,'哈巴河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654325','青河县','1','qinghe','3','654300',NULL,'青河');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('654326','吉木乃县','1','jimunai','3','654300',NULL,'吉木乃');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('655000','石河子市','1','shihezi','2','650000',NULL,'石河子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('655001','石河子','1','shihezi','3','655000',NULL,'石河子');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('655100','阿拉尔市','1','alaer','2','650000',NULL,'阿拉尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('655101','阿拉尔','1','alaer','3','655100',NULL,'阿拉尔');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('655200','图木舒克市','1','tumushuke','2','650000',NULL,'图木舒克');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('655201','图木舒克','1','tumushuke','3','655200',NULL,'图木舒克');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('655300','五家渠市','1','wujiaqu','2','650000',NULL,'五家渠');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('655301','五家渠','1','wujiaqu','3','655300',NULL,'五家渠');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('656100','北屯市','1','beitunshi','2','650000',NULL,'北屯市');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('656101','北屯','1','beitun','3','656100',NULL,'北屯');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('659000','自治区直辖县级行政区划','0','zizhiquzhixiaxianjixingzhengquhua','2','650000',NULL,'自治区直辖县级行政区划');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('710000','海外','1','zzjw','1','0',NULL,'海外');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('710100','海外','1','zzjw','2','710000',NULL,'海外');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('710101','海外','1','zzjw','3','710100',NULL,'海外');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('810000','香港','1','zzgw','1','0',NULL,'香港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('810100','香港','1','zzgw','2','810000',NULL,'香港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('810101','香港','1','zzgw','3','810100',NULL,'香港');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('820000','澳门','1','zzhw','1','0',NULL,'澳门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('820100','澳门','1','zzhw','2','820000',NULL,'澳门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('820101','澳门','1','zzhw','3','820100',NULL,'澳门');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('830000','台湾','1','zziw','1','0',NULL,'台湾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('830100','台湾','1','zziw','2','830000',NULL,'台湾');
insert  into `t_pub_area`(`area_id`,`area_name`,`status`,`area_pinyin`,`area_level`,`parent_area_id`,`area_desc`,`alias`) values ('830101','台湾','1','zziw','3','830100',NULL,'台湾');

UNLOCK TABLES;

/*Table structure for table `t_pub_bank` */

CREATE TABLE `t_pub_bank` (
  `bank_id` varchar(32) NOT NULL COMMENT '银行ID',
  `bank_name` varchar(32) NOT NULL COMMENT '银行名称',
  `status` char(1) NOT NULL COMMENT '状态0:禁用1:启用',
  `image` varchar(128) NOT NULL COMMENT '银行图片',
  `bank_flag` char(1) NOT NULL COMMENT '标记0:网银1:支付平台',
  PRIMARY KEY (`bank_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付银行表';

/*Data for the table `t_pub_bank` */

LOCK TABLES `t_pub_bank` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_pub_help` */

CREATE TABLE `t_pub_help` (
  `help_id` varchar(32) NOT NULL COMMENT '帮助ＩＤ',
  `help_cat_parent` varchar(32) NOT NULL COMMENT '一级分类',
  `help_cat_son` varchar(32) DEFAULT NULL COMMENT '二级分类',
  `help_name` varchar(64) DEFAULT NULL COMMENT '标题',
  `help_seq` varchar(32) NOT NULL COMMENT '序号',
  `help_content` varchar(128) NOT NULL COMMENT '文件路径名',
  `status` varchar(6) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`help_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮助表';

/*Data for the table `t_pub_help` */

LOCK TABLES `t_pub_help` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_pub_mould` */

CREATE TABLE `t_pub_mould` (
  `mould_key` varchar(128) NOT NULL COMMENT '模板KEY',
  `mould_value` longtext NOT NULL COMMENT '模板内容',
  `mould_remark` longtext NOT NULL COMMENT '模板备注',
  PRIMARY KEY (`mould_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信模板表';

/*Data for the table `t_pub_mould` */

LOCK TABLES `t_pub_mould` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_pub_sensitive` */

CREATE TABLE `t_pub_sensitive` (
  `sensitive_id` varchar(32) NOT NULL COMMENT '主键',
  `sensitive_type` varchar(2) NOT NULL COMMENT '敏感词类型',
  `sensitive_code` longtext NOT NULL COMMENT '敏感词',
  PRIMARY KEY (`sensitive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='敏感词汇表';

/*Data for the table `t_pub_sensitive` */

LOCK TABLES `t_pub_sensitive` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_pub_sms` */

CREATE TABLE `t_pub_sms` (
  `seq_no` int(11) NOT NULL COMMENT '序列号',
  `mobile` varchar(11) NOT NULL COMMENT '手机号',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `content` longtext NOT NULL COMMENT '短信内容',
  `templet_id` longtext COMMENT '模板ID',
  `session_id` longtext COMMENT '会话ID',
  `check_code` varchar(8) DEFAULT NULL COMMENT '短信验证码',
  `status` char(1) NOT NULL COMMENT '短信发送状态1：待发送2：发送成功3：发送失败',
  `smscode` varchar(32) DEFAULT NULL COMMENT '接口返回码',
  `smsmsg` longtext COMMENT '接口返回描述',
  `ip` varchar(128) DEFAULT NULL COMMENT 'IP',
  `referer` longtext COMMENT 'referer',
  `sms_channel` varchar(128) DEFAULT NULL COMMENT '短信渠道',
  PRIMARY KEY (`seq_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信信息表';

/*Data for the table `t_pub_sms` */

LOCK TABLES `t_pub_sms` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_pub_system_code` */

CREATE TABLE `t_pub_system_code` (
  `code_type` varchar(128) NOT NULL COMMENT '代码类型',
  `code_id` varchar(32) NOT NULL COMMENT '代码编号',
  `code_name` varchar(50) NOT NULL COMMENT '代码名称',
  `seq` int(11) NOT NULL COMMENT '排序',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`code_type`,`code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统代码表';

/*Data for the table `t_pub_system_code` */

LOCK TABLES `t_pub_system_code` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_pub_system_params` */

CREATE TABLE `t_pub_system_params` (
  `param_name` varchar(64) NOT NULL COMMENT '参数名称',
  `param_value` longtext NOT NULL COMMENT '参数值',
  `remark` longtext COMMENT '备注',
  `can_modify` char(1) NOT NULL COMMENT '修改标志0:不可修改1:可修改',
  PRIMARY KEY (`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统参数配置表';

/*Data for the table `t_pub_system_params` */

LOCK TABLES `t_pub_system_params` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_pub_tree` */

CREATE TABLE `t_pub_tree` (
  `inst_id` varchar(32) NOT NULL COMMENT '站点机构ID',
  `classify_id` varchar(32) NOT NULL COMMENT '分类ID,主键',
  `classify_name` varchar(32) NOT NULL COMMENT '分类名称',
  `parent_id` varchar(32) NOT NULL COMMENT '上级分类ID没有上级分类填0',
  `level` char(1) NOT NULL COMMENT '分类等级1一级分类、2二级分类',
  `seq` varchar(32) NOT NULL COMMENT '排序按大到小排序；默认为100',
  `status` char(1) NOT NULL COMMENT '状态(1有效、2无效)',
  `type` varchar(6) DEFAULT NULL COMMENT '树类型类型 1资讯',
  PRIMARY KEY (`classify_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公共分类表';

/*Data for the table `t_pub_tree` */

LOCK TABLES `t_pub_tree` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_settle_fee_config` */

CREATE TABLE `t_settle_fee_config` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `inst_id` varchar(32) DEFAULT NULL COMMENT '市站或社区站ID system为系统默认配置（找不到站配置找系统默认配置）',
  `pro_push_type` varchar(6) DEFAULT NULL COMMENT '商品类型，11.总直销推送商品，12.总代理推送商品，21.运营商店铺商品，31.社区店铺商品',
  `classify_id` varchar(32) DEFAULT NULL COMMENT '二级分类',
  `fee_type` varchar(6) NOT NULL COMMENT '1 流量费，2系统维护费',
  `fee` decimal(10,0) NOT NULL COMMENT '费率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='结算配置表';

/*Data for the table `t_settle_fee_config` */

LOCK TABLES `t_settle_fee_config` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_shp_classify` */

CREATE TABLE `t_shp_classify` (
  `classify_id` varchar(4) NOT NULL COMMENT '分类ID',
  `classify_name` varchar(32) NOT NULL COMMENT '分类名称',
  `parent_id` varchar(4) DEFAULT NULL COMMENT '上级分类',
  `classify_level` int(11) NOT NULL COMMENT '分类等级',
  `seq` int(11) NOT NULL COMMENT '排序',
  `status` char(1) NOT NULL COMMENT '状态,1:有效,0:无效',
  `shp_id` varchar(32) NOT NULL COMMENT '店铺ID',
  `pic` varchar(255) DEFAULT NULL COMMENT '分类图标',
  PRIMARY KEY (`classify_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺商品分类表';

/*Data for the table `t_shp_classify` */

LOCK TABLES `t_shp_classify` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_shp_cls_pro` */

CREATE TABLE `t_shp_cls_pro` (
  `classify_id` varchar(4) NOT NULL COMMENT '分类ID',
  `shp_pro_id` varchar(32) NOT NULL COMMENT '店铺商品ID',
  PRIMARY KEY (`classify_id`,`shp_pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺商品分类同店铺商品关联表';

/*Data for the table `t_shp_cls_pro` */

LOCK TABLES `t_shp_cls_pro` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_shp_product` */

CREATE TABLE `t_shp_product` (
  `shp_pro_id` varchar(32) NOT NULL COMMENT '店铺商品ID',
  `shp_id` varchar(32) NOT NULL COMMENT '店铺ID',
  `pro_id` varchar(32) NOT NULL COMMENT '商品ID',
  `push_id` varchar(32) NOT NULL COMMENT '推送ID',
  `shelve_status` char(1) NOT NULL COMMENT '上下架状态（1:上架、0:下架）',
  `shelve_time` datetime DEFAULT NULL COMMENT '上下架时间',
  `shp_city_inst` varchar(32) DEFAULT NULL COMMENT '店铺上级市站ID',
  `shp_community_inst` varchar(32) DEFAULT NULL COMMENT '店铺上级社区机构ID',
  `province` varchar(6) NOT NULL COMMENT '店铺-省',
  `city` varchar(6) NOT NULL COMMENT '店铺-市',
  `area` varchar(6) NOT NULL COMMENT '店铺-区',
  `supply_type` char(1) NOT NULL COMMENT '供货渠道,1.厂家,2.店铺',
  `sale_type` char(1) NOT NULL COMMENT '销售类型,1自销,2.代销',
  `agent_type` char(1) NOT NULL COMMENT '代理类型,1.自由代理,2.市独家代理,3.区独家代理',
  `add_time` datetime NOT NULL COMMENT '增加时间',
  `pay_num` int(11) DEFAULT NULL COMMENT '销量（实际支付数量）',
  `order_num` int(11) NOT NULL COMMENT '下单量（包含未支付数量）',
  `page_view` int(11) NOT NULL COMMENT '浏览次数,人气',
  `collect_num` int(11) NOT NULL COMMENT '收藏次数,关注',
  `custom_price` decimal(12,2) DEFAULT NULL COMMENT '店铺自定义销售价',
  `batch_ver` int(11) DEFAULT NULL COMMENT '批量更新版本号批量导入时和推送表保持一致 方便回滚',
  `pro_tags` varchar(255) NOT NULL COMMENT '商品标签[标签id1,标签id2]',
  PRIMARY KEY (`shp_pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺商品表（可销售商品库）';

/*Data for the table `t_shp_product` */

LOCK TABLES `t_shp_product` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_shp_product_sort` */

CREATE TABLE `t_shp_product_sort` (
  `shp_pro_id` varchar(32) NOT NULL COMMENT '店铺商品ID',
  `shp_seq_1` int(11) DEFAULT NULL COMMENT '店铺默认排序',
  `shp_seq_2` int(11) DEFAULT NULL COMMENT '店铺新品排序',
  `shp_seq_3` int(11) DEFAULT NULL COMMENT '店铺热卖排序',
  `city_seq_1` int(11) DEFAULT NULL COMMENT '市站默认排序',
  `city_seq_2` int(11) DEFAULT NULL COMMENT '市站新品排序',
  `city_seq_3` int(11) DEFAULT NULL COMMENT '市站热卖排序',
  `community_seq_1` int(11) DEFAULT NULL COMMENT '社区站默认排序',
  `community_seq_2` int(11) DEFAULT NULL COMMENT '社区站新品排序',
  `community_seq_3` int(11) DEFAULT NULL COMMENT '社区站热卖排序',
  PRIMARY KEY (`shp_pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺商品排序表';

/*Data for the table `t_shp_product_sort` */

LOCK TABLES `t_shp_product_sort` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_shp_shop` */

CREATE TABLE `t_shp_shop` (
  `shp_id` varchar(32) NOT NULL COMMENT '同机构表的机构ID',
  `shp_name` longtext NOT NULL COMMENT '店铺名称',
  `qq_list` int(255) DEFAULT NULL COMMENT '在线客服QQ号[qq1,qq2,qq3]',
  `phone` varchar(255) DEFAULT NULL COMMENT '服务热线[服务热线1,服务热线2]',
  `work_time` longtext COMMENT '服务时间',
  `address` longtext COMMENT '店铺地址',
  `shp_details` varchar(128) DEFAULT NULL COMMENT '店铺详情(保存静态文件名)',
  `city_inst` varchar(32) NOT NULL COMMENT '市运营商ID',
  `city_seq` int(11) DEFAULT NULL COMMENT '市运营商对店铺排序',
  `community_inst` varchar(32) NOT NULL COMMENT '社区运营商ID',
  `community_seq` int(11) DEFAULT NULL COMMENT '社区运营商对店铺排序',
  `banner_pic` varchar(128) DEFAULT NULL COMMENT '店铺店招图片',
  `list_pic` varchar(128) DEFAULT NULL COMMENT '店铺列表图片图片',
  `main_push_flag` char(1) DEFAULT NULL COMMENT '是否主推标志',
  `longitude` varchar(64) DEFAULT NULL COMMENT '店铺地址经度',
  `latitude` varchar(64) DEFAULT NULL COMMENT '店铺地址纬度',
  `show_shp_classify` char(1) DEFAULT NULL COMMENT '展示店铺分类0不展示1展示',
  `shop_comment` longtext COMMENT '店铺介绍 经验范围',
  `route_first` varchar(128) DEFAULT NULL COMMENT '交通路线2',
  `route_second` varchar(128) DEFAULT NULL COMMENT '交通路线1',
  `withdraw_address` varchar(128) DEFAULT NULL COMMENT '自提地址',
  `withdraw_time` varchar(128) DEFAULT NULL COMMENT '自提时间',
  PRIMARY KEY (`shp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺表';

/*Data for the table `t_shp_shop` */

LOCK TABLES `t_shp_shop` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_user_plat_relation` */

CREATE TABLE `t_user_plat_relation` (
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `plat_id` varchar(32) NOT NULL COMMENT '平台编号',
  PRIMARY KEY (`user_id`,`plat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户平台数据关系';

/*Data for the table `t_user_plat_relation` */

LOCK TABLES `t_user_plat_relation` WRITE;

insert  into `t_user_plat_relation`(`user_id`,`plat_id`) values ('admin','555');

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
