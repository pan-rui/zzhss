/*
Navicat MySQL Data Transfer

Source Server         : yunshang
Source Server Version : 50619
Source Host           : localhost:3306
Source Database       : yx_yunshang

Target Server Type    : MYSQL
Target Server Version : 50619
File Encoding         : 65001

Date: 2015-02-02 20:38:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_area
-- ----------------------------
DROP TABLE IF EXISTS `t_area`;
CREATE TABLE `t_area` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_provinces` varchar(800) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_citys` varchar(5000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_areas` varchar(10000) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_book
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_title` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_sub_title` varchar(256) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_title_img` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_addr` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_link_name` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_phone` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_period` int(11) DEFAULT NULL,
  `f_count` int(11) DEFAULT NULL,
  `f_state` char(1) COLLATE utf8_bin DEFAULT NULL,
  `f_join_total` int(11) DEFAULT NULL,
  `f_is_auth` char(1) COLLATE utf8_bin DEFAULT NULL,
  `f_content` text COLLATE utf8_bin,
  `f_start_time` datetime DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_ext_field` text COLLATE utf8_bin,
  `f_ext_ctrl_code` text COLLATE utf8_bin,
  `f_ext_struct_code` text COLLATE utf8_bin,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_book_recd
-- ----------------------------
DROP TABLE IF EXISTS `t_book_recd`;
CREATE TABLE `t_book_recd` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_book_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_phone` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_name` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_addr` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_start_time` datetime DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_remark` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ext_data` text COLLATE utf8_bin,
  `f_state` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_user_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_brand
-- ----------------------------
DROP TABLE IF EXISTS `t_brand`;
CREATE TABLE `t_brand` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_img` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_option` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_card
-- ----------------------------
DROP TABLE IF EXISTS `t_card`;
CREATE TABLE `t_card` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_desc` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_img` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `f_from` double(16,2) DEFAULT NULL,
  `f_to` double(16,2) DEFAULT NULL,
  `f_level` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `f_discount` int(11) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_card_privilege
-- ----------------------------
DROP TABLE IF EXISTS `t_card_privilege`;
CREATE TABLE `t_card_privilege` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_card_id` char(16) DEFAULT NULL,
  `f_name` varchar(32) DEFAULT NULL,
  `f_desc` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_card_user
-- ----------------------------
DROP TABLE IF EXISTS `t_card_user`;
CREATE TABLE `t_card_user` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin DEFAULT '',
  `f_card_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_card_num` int(11) NOT NULL,
  `f_store_id` char(16) COLLATE utf8_bin DEFAULT '',
  `f_user_id` char(16) COLLATE utf8_bin DEFAULT '',
  `f_get_time` datetime DEFAULT NULL,
  `f_level_time` datetime DEFAULT NULL,
  `f_state` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_desc` varchar(1000) COLLATE utf8_bin DEFAULT '',
  `f_uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_class
-- ----------------------------
DROP TABLE IF EXISTS `t_class`;
CREATE TABLE `t_class` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_parent` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_coupon
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon`;
CREATE TABLE `t_coupon` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_desc` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_img` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `f_price` double(16,2) DEFAULT NULL,
  `f_apply_count` int(11) DEFAULT '0',
  `f_count` int(11) DEFAULT '0',
  `f_get_count` int(11) DEFAULT '0',
  `f_use_count` int(11) DEFAULT '0',
  `f_order_use` char(1) COLLATE utf8_bin DEFAULT '1',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_coupon_user
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon_user`;
CREATE TABLE `t_coupon_user` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin DEFAULT '',
  `f_coupon_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_user_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_order_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_get_time` datetime DEFAULT NULL,
  `f_use_time` datetime DEFAULT NULL,
  `f_state` char(1) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_dept
-- ----------------------------
DROP TABLE IF EXISTS `t_dept`;
CREATE TABLE `t_dept` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_favorite
-- ----------------------------
DROP TABLE IF EXISTS `t_favorite`;
CREATE TABLE `t_favorite` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_product` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_column` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_author` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_title` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_desc` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_img` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_price_type` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_price` double(16,2) NOT NULL DEFAULT '0.00',
  `f_price_yh` double(16,2) NOT NULL DEFAULT '0.00',
  `f_jifen` int(11) NOT NULL DEFAULT '0',
  `f_content` varchar(10000) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_group_buy
-- ----------------------------
DROP TABLE IF EXISTS `t_group_buy`;
CREATE TABLE `t_group_buy` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_group_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_order_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_order_num` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `f_user_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_num` int(11) DEFAULT '1',
  `f_expiry_time` datetime DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_group_buy_item
-- ----------------------------
DROP TABLE IF EXISTS `t_group_buy_item`;
CREATE TABLE `t_group_buy_item` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_group_buy_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_status` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_proof` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_phone` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_group_buy_list
-- ----------------------------
DROP TABLE IF EXISTS `t_group_buy_list`;
CREATE TABLE `t_group_buy_list` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_rule` varchar(4000) COLLATE utf8_bin DEFAULT '',
  `f_join_num` int(11) DEFAULT '0',
  `f_title` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `f_title_img` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_sub_title` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `f_combo_desc` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `f_buy_notes` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `f_is_book` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_validity` int(11) DEFAULT '0',
  `f_start_time` datetime DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_status` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_goods_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_goods_img` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_goods_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_goods_price` double(12,2) DEFAULT NULL,
  `f_price` double(12,2) DEFAULT NULL,
  `f_delivery` char(1) COLLATE utf8_bin DEFAULT '2',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_images
-- ----------------------------
DROP TABLE IF EXISTS `t_images`;
CREATE TABLE `t_images` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_column` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_author` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_title` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_img` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_imgs` varchar(2000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(10000) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_list
-- ----------------------------
DROP TABLE IF EXISTS `t_list`;
CREATE TABLE `t_list` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_column` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_author` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_title` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_desc` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_img` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_link` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(10000) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_lottery
-- ----------------------------
DROP TABLE IF EXISTS `t_lottery`;
CREATE TABLE `t_lottery` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_title` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `f_title_img` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_sub_title` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_join_total` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `f_start_time` datetime DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_state` char(1) COLLATE utf8_bin DEFAULT '1',
  `f_content` text COLLATE utf8_bin,
  `f_is_auth` char(1) COLLATE utf8_bin DEFAULT '1',
  `f_times` int(11) DEFAULT '1',
  `f_type` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_plan` text COLLATE utf8_bin,
  `f_lottery_num` int(11) DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_lottery_item
-- ----------------------------
DROP TABLE IF EXISTS `t_lottery_item`;
CREATE TABLE `t_lottery_item` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_name` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `f_prize` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `f_counts` int(11) DEFAULT '0',
  `f_probability` double DEFAULT '0',
  `f_winners` int(11) DEFAULT '0',
  `f_lottery_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_prize_type` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_point_value` int(11) DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_lottery_record
-- ----------------------------
DROP TABLE IF EXISTS `t_lottery_record`;
CREATE TABLE `t_lottery_record` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_lottery_item_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_phone` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `f_name` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `f_lottery_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_exchange_sn` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `f_is_exchange` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_addr` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `f_user_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_material
-- ----------------------------
DROP TABLE IF EXISTS `t_material`;
CREATE TABLE `t_material` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(32) DEFAULT NULL,
  `f_class_id` char(16) DEFAULT NULL,
  `f_type` char(1) DEFAULT NULL,
  `f_ext` varchar(8) DEFAULT NULL,
  `f_path` varchar(128) DEFAULT NULL,
  `f_mini_path` varchar(128) DEFAULT NULL,
  `f_content` text,
  `f_desc` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_material_class
-- ----------------------------
DROP TABLE IF EXISTS `t_material_class`;
CREATE TABLE `t_material_class` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_news
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_author` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_title` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_desc` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_img` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(10000) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_opp
-- ----------------------------
DROP TABLE IF EXISTS `t_opp`;
CREATE TABLE `t_opp` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_contact` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_phone` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_email` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_type` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_state` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_note` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user_id` char(16) COLLATE utf8_bin DEFAULT '',
  `f_num` varchar(100) COLLATE utf8_bin DEFAULT '',
  `f_pay` varchar(10) COLLATE utf8_bin DEFAULT '',
  `f_contact` varchar(100) COLLATE utf8_bin DEFAULT '',
  `f_deliver` varchar(10) COLLATE utf8_bin DEFAULT '',
  `f_addr` varchar(100) COLLATE utf8_bin DEFAULT '',
  `f_store_id` char(16) COLLATE utf8_bin DEFAULT '',
  `f_money` double(16,2) DEFAULT '0.00',
  `f_point` int(11) DEFAULT '0',
  `f_discount` double(16,2) DEFAULT '0.00',
  `f_youhui` double(16,2) DEFAULT '0.00',
  `f_freight` double(16,2) DEFAULT '0.00',
  `f_bill` varchar(100) COLLATE utf8_bin DEFAULT '',
  `f_coupon_price_id` varchar(2000) COLLATE utf8_bin DEFAULT '',
  `f_coupon_price` double(16,2) DEFAULT '0.00',
  `f_pay_money` double(16,2) DEFAULT '0.00',
  `f_order_money` double(16,2) DEFAULT '0.00',
  `f_order_count` int(11) DEFAULT '0',
  `f_pay_num` varchar(100) COLLATE utf8_bin DEFAULT '',
  `f_pay_state` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_deliver_state` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_receiver_state` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_state` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_desc` varchar(100) COLLATE utf8_bin DEFAULT '',
  `f_flow` text COLLATE utf8_bin,
  `f_pay_info` text COLLATE utf8_bin,
  `f_start_delivery_time` datetime DEFAULT NULL,
  `f_end_delivery_time` datetime DEFAULT NULL,
  `f_logistics` varchar(10) COLLATE utf8_bin DEFAULT '',
  `f_logistics_id` varchar(50) COLLATE utf8_bin DEFAULT '',
  `f_remark` varchar(256) COLLATE utf8_bin DEFAULT '',
  `f_logistics_state` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_by_user_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_add_point` int(11) DEFAULT '0',
  `f_add_money` int(11) DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_order_item
-- ----------------------------
DROP TABLE IF EXISTS `t_order_item`;
CREATE TABLE `t_order_item` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_order_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_prod_id` char(16) COLLATE utf8_bin DEFAULT '',
  `f_price` double(16,2) DEFAULT '0.00',
  `f_price_yh` double(16,2) DEFAULT '0.00',
  `f_point` int(11) DEFAULT '0',
  `f_count` int(11) DEFAULT '0',
  `f_price_type` varchar(10) COLLATE utf8_bin DEFAULT '',
  `f_spec1` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_spec2` varchar(20) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`f_id`,`f_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_order_refund
-- ----------------------------
DROP TABLE IF EXISTS `t_order_refund`;
CREATE TABLE `t_order_refund` (
  `f_id` char(16) NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_order_id` char(16) DEFAULT NULL,
  `f_order_num` varchar(100) DEFAULT NULL,
  `f_operate_time` datetime DEFAULT NULL,
  `f_trade_num` varchar(64) DEFAULT NULL,
  `f_voucher` varchar(128) DEFAULT NULL,
  `f_bank_name` varchar(32) DEFAULT NULL,
  `f_bank_acc` varchar(32) DEFAULT NULL,
  `f_desc` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_page
-- ----------------------------
DROP TABLE IF EXISTS `t_page`;
CREATE TABLE `t_page` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_author` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_title` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(20000) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_pic
-- ----------------------------
DROP TABLE IF EXISTS `t_pic`;
CREATE TABLE `t_pic` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_column` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(5000) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_code` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_img` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_imgs` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_brand` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_desc` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_type` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_price_type` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_price` double(16,2) NOT NULL DEFAULT '0.00',
  `f_price_yh` double(16,2) NOT NULL DEFAULT '0.00',
  `f_point` int(11) NOT NULL DEFAULT '0',
  `f_stock_count` int(11) NOT NULL DEFAULT '0',
  `f_warn_count` int(11) NOT NULL DEFAULT '0',
  `f_spec` varchar(5000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(10000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_state` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_heart` int(11) DEFAULT '0',
  `f_content_p` text COLLATE utf8_bin,
  `f_share` int(11) DEFAULT '0',
  `f_tag` varchar(512) COLLATE utf8_bin DEFAULT '',
  `f_config` text COLLATE utf8_bin,
  `f_diy_prod_page` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `f_store_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_product_type` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '0:实物、1:虚拟物品',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_product_class
-- ----------------------------
DROP TABLE IF EXISTS `t_product_class`;
CREATE TABLE `t_product_class` (
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_class` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_product` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_class`,`f_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_product_share_recd
-- ----------------------------
DROP TABLE IF EXISTS `t_product_share_recd`;
CREATE TABLE `t_product_share_recd` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_user_id` char(16) DEFAULT NULL,
  `f_user_name` varchar(16) DEFAULT NULL,
  `f_product_id` char(16) NOT NULL COMMENT '分类id产品id组合主键',
  `f_product_name` varchar(64) NOT NULL,
  `f_ip` varchar(36) DEFAULT NULL,
  `f_share_to` char(1) DEFAULT NULL COMMENT '0：短信\r\n            1：新浪微博\r\n            2：腾讯微博\r\n            3：qq空间',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_product_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_product_stock`;
CREATE TABLE `t_product_stock` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime DEFAULT NULL,
  `f_utime` datetime DEFAULT NULL,
  `f_uid` int(11) DEFAULT '0',
  `f_warehouse_id` char(16) DEFAULT NULL,
  `f_prod_id` char(16) DEFAULT NULL,
  `f_stock_count` int(11) DEFAULT NULL,
  `f_spec_count` int(11) DEFAULT NULL,
  `f_note` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_ques_answer
-- ----------------------------
DROP TABLE IF EXISTS `t_ques_answer`;
CREATE TABLE `t_ques_answer` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_ques_opt_id` char(16) DEFAULT NULL,
  `f_phone` varchar(16) NOT NULL,
  `f_name` varchar(16) NOT NULL,
  `f_answer` varchar(64) DEFAULT NULL,
  `f_ques_id` char(16) NOT NULL,
  `f_survery_recd_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_ques_option
-- ----------------------------
DROP TABLE IF EXISTS `t_ques_option`;
CREATE TABLE `t_ques_option` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_name` varchar(64) NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_ques_id` char(16) NOT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_shake_list
-- ----------------------------
DROP TABLE IF EXISTS `t_shake_list`;
CREATE TABLE `t_shake_list` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_bg_img` varchar(128) COLLATE utf8_bin DEFAULT '',
  `f_fall_img` varchar(512) COLLATE utf8_bin DEFAULT '',
  `f_title` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `f_title_img` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `f_period` char(1) COLLATE utf8_bin DEFAULT NULL,
  `f_period_num` int(11) DEFAULT NULL,
  `f_speed` int(11) DEFAULT NULL,
  `f_speed_num` double DEFAULT NULL,
  `f_start_time` datetime DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_status` char(1) COLLATE utf8_bin DEFAULT NULL,
  `f_content` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `f_max_count` int(11) DEFAULT '100',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_site
-- ----------------------------
DROP TABLE IF EXISTS `t_site`;
CREATE TABLE `t_site` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL DEFAULT '0',
  `f_url` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_header` text COLLATE utf8_bin NOT NULL,
  `f_brand` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_image` varchar(2000) COLLATE utf8_bin NOT NULL,
  `f_container` text COLLATE utf8_bin NOT NULL,
  `f_part` text COLLATE utf8_bin NOT NULL,
  `f_footer` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_bottom` text COLLATE utf8_bin NOT NULL,
  `f_zdy` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_css` text COLLATE utf8_bin NOT NULL,
  `f_login` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_config` text COLLATE utf8_bin,
  `f_site_type` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '0：免费版\r\n            1：标准版\r\n            2：定制版\r\n            3：连锁版\r\n            4：独立部署版',
  `f_search` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`),
  UNIQUE KEY `f_uid` (`f_uid`),
  UNIQUE KEY `f_url` (`f_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_site_page
-- ----------------------------
DROP TABLE IF EXISTS `t_site_page`;
CREATE TABLE `t_site_page` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL DEFAULT '0',
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_header` varchar(2000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_container` text COLLATE utf8_bin,
  `f_bottom` varchar(2000) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_sms_send_recd
-- ----------------------------
DROP TABLE IF EXISTS `t_sms_send_recd`;
CREATE TABLE `t_sms_send_recd` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_content` varchar(256) DEFAULT NULL,
  `f_phone` char(11) DEFAULT NULL,
  `f_state` char(1) DEFAULT '0',
  `f_type` char(1) DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sm_interact_recd
-- ----------------------------
DROP TABLE IF EXISTS `t_sm_interact_recd`;
CREATE TABLE `t_sm_interact_recd` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_sm_interact_id` char(16) DEFAULT NULL,
  `f_nick_name` varchar(16) DEFAULT NULL,
  `f_photo` varchar(256) DEFAULT NULL,
  `f_source` char(1) DEFAULT NULL COMMENT '0：微信\r\n            1：易信\r\n            2：来往',
  `f_media_type` char(1) DEFAULT NULL COMMENT '0：文本\r\n            1：图片\r\n            2：语音',
  `f_media_cont` varchar(128) DEFAULT NULL,
  `f_state` char(1) DEFAULT '0' COMMENT '0：未处理\r\n            1：审核通过\r\n            2：审核不通过',
  `f_good_num` int(11) DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_social_media_interact
-- ----------------------------
DROP TABLE IF EXISTS `t_social_media_interact`;
CREATE TABLE `t_social_media_interact` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_title` varchar(16) DEFAULT NULL,
  `f_sub_title` varchar(256) DEFAULT NULL,
  `f_title_img` varchar(128) DEFAULT NULL,
  `f_state` char(1) DEFAULT NULL COMMENT '0：未开始 1：进行中 2：已结束',
  `f_join_total` int(11) DEFAULT '0' COMMENT '默认0',
  `f_content` text,
  `f_start_time` datetime DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_bg_img` varchar(128) DEFAULT NULL,
  `f_diy_style` varchar(2000) DEFAULT NULL,
  `f_is_auto_ok` char(1) DEFAULT '1' COMMENT '0：否\r\n            1：是',
  `f_m_bg_img` varchar(128) DEFAULT NULL,
  `f_m_diy_style` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_spec
-- ----------------------------
DROP TABLE IF EXISTS `t_spec`;
CREATE TABLE `t_spec` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_spic
-- ----------------------------
DROP TABLE IF EXISTS `t_spic`;
CREATE TABLE `t_spic` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_column` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(5000) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_staff
-- ----------------------------
DROP TABLE IF EXISTS `t_staff`;
CREATE TABLE `t_staff` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_zhiwu` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_dept` varchar(36) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_sex` varchar(2) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_phone` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_email` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_acc` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_pwd` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_store` char(16) COLLATE utf8_bin DEFAULT '',
  `f_type` char(1) COLLATE utf8_bin DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_store
-- ----------------------------
DROP TABLE IF EXISTS `t_store`;
CREATE TABLE `t_store` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_lng` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_lat` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_provinces` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_citys` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_areas` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_type` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_address` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_phone` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_zipcode` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_img` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_code` int(11) DEFAULT '0',
  `f_qrcode_img` varchar(100) COLLATE utf8_bin DEFAULT '',
  `f_wx_group_id` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `f_logo` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_disable_logo` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_attention_num` int(11) DEFAULT '0',
  `f_map_type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '0：谷歌地图\r\n            1：百度地图',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_store_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_store_resource`;
CREATE TABLE `t_store_resource` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_store_id` char(16) DEFAULT NULL,
  `f_store_name` varchar(32) DEFAULT NULL,
  `f_res_type` char(1) DEFAULT NULL COMMENT '0:图文列表\r\n            1:团购列表',
  `f_res_id` char(16) DEFAULT NULL,
  `f_res_title` varchar(64) DEFAULT NULL,
  `f_sub_res_title` varchar(128) DEFAULT NULL,
  `f_res_title_img` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_supplier
-- ----------------------------
DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE `t_supplier` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime DEFAULT NULL,
  `f_utime` datetime DEFAULT NULL,
  `f_uid` int(11) DEFAULT '0',
  `f_name` varchar(20) DEFAULT NULL,
  `f_code` varchar(20) DEFAULT NULL,
  `f_acc` varchar(50) DEFAULT NULL,
  `f_pwd` char(32) DEFAULT NULL,
  `f_img` varchar(100) DEFAULT NULL,
  `f_linkman` varchar(20) DEFAULT NULL,
  `f_address` varchar(500) DEFAULT NULL,
  `f_phone` varchar(20) DEFAULT NULL,
  `f_mail` varchar(50) DEFAULT NULL,
  `f_sheng` varchar(20) DEFAULT NULL,
  `f_shi` varchar(20) DEFAULT NULL,
  `f_qu` varchar(20) DEFAULT NULL,
  `f_desc` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_survery
-- ----------------------------
DROP TABLE IF EXISTS `t_survery`;
CREATE TABLE `t_survery` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_title` varchar(64) NOT NULL,
  `f_sub_title` varchar(128) DEFAULT NULL,
  `f_title_img` varchar(256) DEFAULT NULL,
  `f_join_total` int(11) NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `f_end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `f_state` char(1) NOT NULL COMMENT '0：未开始\r\n            1：进行中\r\n            2：已结束',
  `f_content` longtext,
  `f_source` char(1) DEFAULT '0' COMMENT '0：调查问卷\r\n            1：抽奖活动',
  `f_is_set_answer` char(1) NOT NULL DEFAULT '0' COMMENT '0：不需要\r\n            1：需要',
  `f_is_auth` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_survery_ques
-- ----------------------------
DROP TABLE IF EXISTS `t_survery_ques`;
CREATE TABLE `t_survery_ques` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_name` varchar(64) NOT NULL,
  `f_type` char(1) NOT NULL COMMENT '0：单选\r\n            1：多选\r\n            2：问答',
  `f_survery_id` char(16) NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_answer` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_survery_recd
-- ----------------------------
DROP TABLE IF EXISTS `t_survery_recd`;
CREATE TABLE `t_survery_recd` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_customer_id` char(36) DEFAULT NULL,
  `f_uid` int(11) NOT NULL,
  `f_phone` varchar(16) NOT NULL,
  `f_name` varchar(16) NOT NULL,
  `f_survery_id` char(16) NOT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_system
-- ----------------------------
DROP TABLE IF EXISTS `t_system`;
CREATE TABLE `t_system` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_acc` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_pwd` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`),
  UNIQUE KEY `f_acc` (`f_acc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_unit
-- ----------------------------
DROP TABLE IF EXISTS `t_unit`;
CREATE TABLE `t_unit` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL AUTO_INCREMENT,
  `f_is_users` char(1) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_sname` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_industry` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_linkman` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_phone` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_email` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_address` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_site_type` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '0：免费版\r\n            1：标准版\r\n            2：定制版\r\n            3：连锁版\r\n            4：独立部署版',
  `f_amount` double DEFAULT '0',
  `f_sms_price` double DEFAULT '0',
  PRIMARY KEY (`f_id`),
  UNIQUE KEY `f_uid` (`f_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=10624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_unit_recharge_recd
-- ----------------------------
DROP TABLE IF EXISTS `t_unit_recharge_recd`;
CREATE TABLE `t_unit_recharge_recd` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_amount` double DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime DEFAULT NULL,
  `f_utime` datetime DEFAULT NULL,
  `f_uid` int(11) DEFAULT '0',
  `f_acc` varchar(50) COLLATE utf8_bin DEFAULT '',
  `f_pwd` char(32) COLLATE utf8_bin DEFAULT '',
  `f_other_acc` varchar(50) COLLATE utf8_bin DEFAULT '',
  `f_ticket` varchar(100) COLLATE utf8_bin DEFAULT '',
  `f_name` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_img` varchar(256) COLLATE utf8_bin DEFAULT '',
  `f_nickname` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_address` varchar(500) COLLATE utf8_bin DEFAULT '',
  `f_sex` varchar(2) COLLATE utf8_bin DEFAULT '',
  `f_phone` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_mail` varchar(50) COLLATE utf8_bin DEFAULT '',
  `f_sheng` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_shi` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_qu` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_desc` varchar(1000) COLLATE utf8_bin DEFAULT '',
  `f_audit_desc` varchar(1000) COLLATE utf8_bin DEFAULT '',
  `f_state` char(1) COLLATE utf8_bin DEFAULT '0',
  `f_config` text COLLATE utf8_bin,
  `f_wx_open_id` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `f_store` char(16) COLLATE utf8_bin DEFAULT '',
  `f_alipay_app_id` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `f_credit` int(11) DEFAULT '1',
  `f_credit_state` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '1:正常、0:屏蔽',
  `f_by_user_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_add_point` int(11) DEFAULT '0',
  `f_add_money` int(11) DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_user_buy
-- ----------------------------
DROP TABLE IF EXISTS `t_user_buy`;
CREATE TABLE `t_user_buy` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin DEFAULT '',
  `f_user_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_store_id` char(16) COLLATE utf8_bin DEFAULT '',
  `f_buy_time` datetime DEFAULT NULL,
  `f_money` double(16,2) DEFAULT NULL,
  `f_source` varchar(50) COLLATE utf8_bin DEFAULT '',
  `f_source_type` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_note` varchar(1000) COLLATE utf8_bin DEFAULT '',
  `f_uid` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_pay_state` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '0：未支付，1：已支付',
  `f_num` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `f_pay_num` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `f_pay_info` text COLLATE utf8_bin,
  `f_order_state` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '0：进行中，1：已取消，2：已完成',
  `f_return_time` datetime DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_user_buy_use
-- ----------------------------
DROP TABLE IF EXISTS `t_user_buy_use`;
CREATE TABLE `t_user_buy_use` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin DEFAULT '',
  `f_user_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_store_id` char(16) COLLATE utf8_bin DEFAULT '',
  `f_order_id` char(16) COLLATE utf8_bin DEFAULT '',
  `f_use_time` datetime DEFAULT NULL,
  `f_money` double(16,2) DEFAULT NULL,
  `f_source` varchar(10) COLLATE utf8_bin DEFAULT '商品订单',
  `f_note` varchar(512) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_user_online_buy
-- ----------------------------
DROP TABLE IF EXISTS `t_user_online_buy`;
CREATE TABLE `t_user_online_buy` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime DEFAULT NULL,
  `f_utime` datetime DEFAULT NULL,
  `f_uid` char(16) DEFAULT NULL,
  `f_user_id` char(16) DEFAULT NULL,
  `f_store_id` char(16) DEFAULT NULL,
  `f_money` double(16,2) DEFAULT NULL,
  `f_pay_type` varchar(10) DEFAULT NULL,
  `f_pay_state` char(1) DEFAULT '0' COMMENT '0：未支付，1：已支付',
  `f_num` varchar(100) DEFAULT NULL,
  `f_pay_num` varchar(100) DEFAULT NULL,
  `f_pay_info` text,
  `f_order_state` char(1) DEFAULT '0' COMMENT '0：进行中，1：已取消，2：已完成',
  `f_note` varchar(1000) DEFAULT NULL,
  `f_pay_time` datetime DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_user_point
-- ----------------------------
DROP TABLE IF EXISTS `t_user_point`;
CREATE TABLE `t_user_point` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin DEFAULT '',
  `f_user_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_count` int(11) DEFAULT '0',
  `f_source` varchar(50) COLLATE utf8_bin DEFAULT '',
  `f_source_type` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_note` varchar(1000) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_user_point_use
-- ----------------------------
DROP TABLE IF EXISTS `t_user_point_use`;
CREATE TABLE `t_user_point_use` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_user_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_count` int(11) DEFAULT '0',
  `f_source` varchar(50) COLLATE utf8_bin DEFAULT '',
  `f_source_type` varchar(20) COLLATE utf8_bin DEFAULT '',
  `f_note` varchar(1000) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_user_store
-- ----------------------------
DROP TABLE IF EXISTS `t_user_store`;
CREATE TABLE `t_user_store` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_user_id` char(16) NOT NULL,
  `f_store_id` char(16) NOT NULL,
  `f_relation` char(1) DEFAULT NULL COMMENT '0：隶属关系\r\n            1：关注关系',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse`;
CREATE TABLE `t_warehouse` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime DEFAULT NULL,
  `f_utime` datetime DEFAULT NULL,
  `f_uid` int(11) DEFAULT '0',
  `f_name` varchar(20) DEFAULT NULL,
  `f_code` varchar(50) DEFAULT NULL,
  `f_provinces` varchar(16) DEFAULT NULL,
  `f_citys` varchar(10) DEFAULT NULL,
  `f_areas` varchar(10) DEFAULT NULL,
  `f_lng` varchar(50) DEFAULT NULL,
  `f_lat` varchar(50) DEFAULT NULL,
  `f_map_type` char(1) DEFAULT NULL COMMENT '0?????,1?????',
  `f_address` varchar(100) DEFAULT NULL,
  `f_phone` varchar(20) DEFAULT NULL,
  `f_type` char(1) DEFAULT '0' COMMENT '???0?1????',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_in
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_in`;
CREATE TABLE `t_warehouse_in` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime DEFAULT NULL,
  `f_utime` datetime DEFAULT NULL,
  `f_uid` int(11) DEFAULT '0',
  `f_warehouse_id` char(16) DEFAULT NULL,
  `f_supplier_id` char(16) DEFAULT NULL,
  `f_code` varchar(20) DEFAULT NULL,
  `f_operator` varchar(20) DEFAULT NULL,
  `f_note` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_in_item
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_in_item`;
CREATE TABLE `t_warehouse_in_item` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime DEFAULT NULL,
  `f_utime` datetime DEFAULT NULL,
  `f_uid` int(11) DEFAULT '0',
  `f_warehouse_in_id` char(16) DEFAULT NULL,
  `f_prod_id` char(16) DEFAULT NULL,
  `f_count` int(11) DEFAULT '0',
  `f_price` double DEFAULT '0',
  `f_money` double DEFAULT '0',
  `f_spec_count` text,
  `f_note` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_out
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_out`;
CREATE TABLE `t_warehouse_out` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime DEFAULT NULL,
  `f_utime` datetime DEFAULT NULL,
  `f_uid` int(11) DEFAULT '0',
  `f_warehouse_id` char(16) DEFAULT NULL,
  `f_user_id` char(16) DEFAULT NULL,
  `f_order_id` char(16) DEFAULT NULL,
  `f_code` varchar(20) DEFAULT NULL,
  `f_operator` varchar(20) DEFAULT NULL,
  `f_note` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_out_item
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_out_item`;
CREATE TABLE `t_warehouse_out_item` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime DEFAULT NULL,
  `f_utime` datetime DEFAULT NULL,
  `f_uid` int(11) DEFAULT '0',
  `f_warehouse_out_id` char(16) DEFAULT NULL,
  `f_prod_id` char(16) DEFAULT NULL,
  `f_count` int(11) DEFAULT '0',
  `f_price` double DEFAULT '0',
  `f_money` double DEFAULT '0',
  `f_spec_count` text,
  `f_note` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_weixin_set
-- ----------------------------
DROP TABLE IF EXISTS `t_weixin_set`;
CREATE TABLE `t_weixin_set` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_reply_type` char(1) COLLATE utf8_bin DEFAULT '1',
  `f_reply_way` char(1) COLLATE utf8_bin DEFAULT '1',
  `f_txt_content` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `f_keyword` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `f_event_source` char(1) COLLATE utf8_bin DEFAULT '0',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_weixin_set_list
-- ----------------------------
DROP TABLE IF EXISTS `t_weixin_set_list`;
CREATE TABLE `t_weixin_set_list` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_url` varchar(256) COLLATE utf8_bin DEFAULT '',
  `f_title` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `f_sub_title` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_title_img` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `f_weixin_set_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_word
-- ----------------------------
DROP TABLE IF EXISTS `t_word`;
CREATE TABLE `t_word` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL DEFAULT '0',
  `f_linkman` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_phone` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_wx_msg_recive_recd
-- ----------------------------
DROP TABLE IF EXISTS `t_wx_msg_recive_recd`;
CREATE TABLE `t_wx_msg_recive_recd` (
  `f_id` char(16) CHARACTER SET utf8 NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_user_id` char(16) CHARACTER SET utf8 DEFAULT NULL,
  `f_user_name` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `f_open_id` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `f_msg_type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '0：文本\r\n            1：图片\r\n            2：语音\r\n            3：视频\r\n            4：地理位置\r\n            5：链接\r\n            6：关注\r\n            7：自定义菜单\r\n            8：扫描二维码\r\n            9：自定义菜单链接',
  `f_media_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `f_media_info` text COLLATE utf8_bin COMMENT '图片：\r\n            {\r\n               "PicUrl":""// 图片路径\r\n            }\r\n            语音：\r\n            {\r\n               "Format":""\r\n            }\r\n            视频：\r\n            {\r\n                 "ThumbMediaId":""// 缩略图ID\r\n            }\r\n            地理位置：\r\n            {\r\n                 "Location_X":"", // 纬度\r\n                 "Location_Y":"",// 经度\r\n                 "Scale":"",//地图缩放大小\r\n                 "Label":""//地理位置信息\r\n            }\r\n            ',
  `f_msg_cont` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_resource` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '0： 普通消息\r\n            1：支付消息\r\n            2：维权消息',
  `f_msg_id` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_wx_reply_msg_recd
-- ----------------------------
DROP TABLE IF EXISTS `t_wx_reply_msg_recd`;
CREATE TABLE `t_wx_reply_msg_recd` (
  `f_id` char(16) CHARACTER SET utf8 NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `用户ID` char(16) CHARACTER SET utf8 DEFAULT NULL,
  `f_user_name` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `f_msg_type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '0：文本\r\n            1：视频\r\n            2：音频\r\n            3：地图\r\n            4：菜单\r\n            5：图片\r\n            6：图文',
  `f_msg_text` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_media_id` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `f_wx_msg_recd_id` char(16) COLLATE utf8_bin DEFAULT NULL,
  `f_msg_info` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_wx_right_protect_recd
-- ----------------------------
DROP TABLE IF EXISTS `t_wx_right_protect_recd`;
CREATE TABLE `t_wx_right_protect_recd` (
  `f_id` char(16) CHARACTER SET utf8 NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_user_name` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `f_user_id` char(16) CHARACTER SET utf8 DEFAULT NULL,
  `f_post_time` datetime DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_result` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '0：未处理\r\n            1：同意\r\n            2：拒绝\r\n            ',
  `f_feed_back_id` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `f_trans_id` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `f_reason` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_solution` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_ext_info` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_end_reason` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `f_open_id` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  `f_pic_info` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '["imgurl","imgurl"]',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_wx_warn
-- ----------------------------
DROP TABLE IF EXISTS `t_wx_warn`;
CREATE TABLE `t_wx_warn` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_error_type` varchar(8) DEFAULT NULL,
  `f_description` varchar(128) DEFAULT NULL,
  `f_alarm_content` varchar(256) DEFAULT NULL,
  `f_state` char(1) DEFAULT NULL COMMENT '0： 未处理 \r\n            1：已处理',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_auction
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_auction`;
CREATE TABLE `t_yx_auction` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_title` varchar(32) DEFAULT NULL,
  `f_sub_title` varchar(128) DEFAULT NULL,
  `f_img` varchar(128) DEFAULT NULL,
  `f_start_time` datetime DEFAULT NULL,
  `f_end_time` datetime DEFAULT NULL,
  `f_desc` text,
  `f_state` char(1) DEFAULT NULL COMMENT '0：未开始(默认)  1：进行中 2：已结束 3: 暂停',
  `f_price` double DEFAULT '0' COMMENT '默认0',
  `f_add_scope` double DEFAULT '0',
  `f_delay_time` int(11) DEFAULT '0' COMMENT '单位分钟',
  `f_class` varchar(20) DEFAULT NULL,
  `f_margin` double DEFAULT '0',
  `f_keywords` varchar(512) DEFAULT NULL,
  `f_publish` char(1) DEFAULT '0' COMMENT '1:已发布、0:未发布',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_auction_order
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_auction_order`;
CREATE TABLE `t_yx_auction_order` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_user_id` char(16) DEFAULT NULL,
  `f_auction_id` char(16) DEFAULT NULL,
  `f_pay` varchar(10) DEFAULT NULL COMMENT '支付宝、微信支付、余额支付',
  `f_deliver` varchar(10) DEFAULT NULL,
  `f_contact` varchar(100) DEFAULT NULL,
  `f_addr` varchar(100) DEFAULT NULL,
  `f_margin` double DEFAULT NULL,
  `f_auction_money` double DEFAULT '0',
  `f_money` double DEFAULT '0',
  `f_num` varchar(100) DEFAULT NULL,
  `f_pay_num` varchar(100) DEFAULT NULL,
  `f_pay_state` char(1) DEFAULT NULL COMMENT '0未支付，1已支付  2已退款',
  `f_deliver_state` char(1) DEFAULT NULL COMMENT '0未支付，1已支付',
  `f_receiver_state` char(1) DEFAULT NULL COMMENT '0未支付，1已支付',
  `f_logistics_state` char(1) DEFAULT '0' COMMENT '0：未货\r\n            1：已收货',
  `f_state` char(1) DEFAULT NULL COMMENT '0，执行中，1结束，2，取消，3退货',
  `f_desc` varchar(256) DEFAULT NULL COMMENT '存放取消和退货原因',
  `f_flow` text,
  `f_pay_info` text,
  `f_start_delivery_time` datetime DEFAULT NULL,
  `f_end_delivery_time` datetime DEFAULT NULL,
  `f_logistics` varchar(10) DEFAULT NULL,
  `f_logistics_id` varchar(50) DEFAULT NULL,
  `f_remark` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_auction_record
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_auction_record`;
CREATE TABLE `t_yx_auction_record` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_user_id` char(16) DEFAULT NULL,
  `f_auction_id` char(16) DEFAULT NULL,
  `f_bid_price` double DEFAULT NULL,
  `f_state` char(1) DEFAULT NULL COMMENT '默认1，最高价竞拍；0，竞拍失败',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_credit_record
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_credit_record`;
CREATE TABLE `t_yx_credit_record` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_user_id` char(16) DEFAULT NULL,
  `f_source` varchar(20) DEFAULT NULL COMMENT '微拍',
  `f_source_id` char(16) DEFAULT NULL,
  `f_score` int(11) DEFAULT '0',
  `f_remark` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_heka
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_heka`;
CREATE TABLE `t_yx_heka` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_to` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_from` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_bg` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_color` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_yx_magazine
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_magazine`;
CREATE TABLE `t_yx_magazine` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) DEFAULT NULL,
  `f_uid` char(16) DEFAULT NULL,
  `f_column_id` char(16) DEFAULT NULL,
  `f_title` varchar(64) DEFAULT NULL,
  `f_desc` varchar(128) DEFAULT NULL,
  `f_img` varchar(256) DEFAULT NULL,
  `f_source` varchar(32) DEFAULT NULL,
  `f_size` mediumtext,
  `f_pre_name` varchar(16) DEFAULT NULL,
  `f_pre_url` varchar(256) DEFAULT NULL,
  `f_face_style` char(1) DEFAULT '1' COMMENT '0：1列\r\n            1：2列\r\n            2：3列\r\n            3：1列显示最新2条章节信息',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_magazine_content
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_magazine_content`;
CREATE TABLE `t_yx_magazine_content` (
  `f_id` char(16) NOT NULL,
  `f_uid` char(16) NOT NULL,
  `f_section_id` char(16) NOT NULL,
  `f_ejournal_id` char(16) DEFAULT NULL,
  `f_title` varchar(64) NOT NULL,
  `f_img` varchar(256) DEFAULT NULL,
  `f_content` longtext,
  `f_size` mediumtext,
  `f_seq` int(11) DEFAULT NULL,
  `f_pictures` longtext COMMENT '[{"id":"xxx","name":"xxxx","src":"xxx","size":"123"}]',
  `f_tags` varchar(256) DEFAULT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_magazine_section
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_magazine_section`;
CREATE TABLE `t_yx_magazine_section` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) NOT NULL,
  `f_magazine_id` char(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_title` varchar(64) DEFAULT NULL,
  `f_desc` varchar(128) DEFAULT NULL,
  `f_img` varchar(256) DEFAULT NULL,
  `f_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_margin_record
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_margin_record`;
CREATE TABLE `t_yx_margin_record` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_user_id` char(16) DEFAULT NULL,
  `f_auction_id` char(16) DEFAULT NULL,
  `f_money` double DEFAULT NULL,
  `f_pay_type` varchar(10) DEFAULT NULL COMMENT '支付宝、余额支付',
  `f_pay_state` char(1) DEFAULT NULL COMMENT '0：未支付，1：已支付',
  `f_num` varchar(100) DEFAULT NULL,
  `f_pay_num` varchar(100) DEFAULT NULL,
  `f_pay_info` text,
  `f_order_state` char(1) DEFAULT NULL COMMENT '0：进行中，1：已取消，2：已完成',
  `f_pay_time` datetime DEFAULT NULL,
  `f_refund_time` datetime DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_meeting
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_meeting`;
CREATE TABLE `t_yx_meeting` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_title` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_content` varchar(10000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_start_time` datetime NOT NULL,
  `f_end_time` datetime NOT NULL,
  `f_address` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_count` int(11) NOT NULL DEFAULT '0',
  `f_join` int(11) NOT NULL DEFAULT '0',
  `f_sign` int(11) NOT NULL DEFAULT '0',
  `f_config` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_option` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_yx_meeting_user
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_meeting_user`;
CREATE TABLE `t_yx_meeting_user` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_meeting` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_phone` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_sign` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `f_job` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_company` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_status` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_desc` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_weixin` varchar(36) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_yx_promotion
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_promotion`;
CREATE TABLE `t_yx_promotion` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_type` char(1) DEFAULT '0' COMMENT '0：会员推广，1：商品推广',
  `f_source_id` char(16) DEFAULT NULL,
  `f_link` varchar(512) DEFAULT NULL,
  `f_point` int(11) DEFAULT '0',
  `f_content` varchar(128) DEFAULT NULL,
  `f_state` char(1) DEFAULT '1' COMMENT '0：暂停，1：进行中（默认）',
  `f_give_type` varchar(10) DEFAULT NULL COMMENT '?????',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yx_vote
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_vote`;
CREATE TABLE `t_yx_vote` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_title` varchar(500) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_type` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '单选',
  `f_start_time` datetime NOT NULL,
  `f_end_time` datetime NOT NULL,
  `f_desc` varchar(10000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_count` int(11) NOT NULL DEFAULT '0',
  `f_config` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_items` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_option` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_yx_vote_user
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_vote_user`;
CREATE TABLE `t_yx_vote_user` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ip` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_vote` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_items` varchar(500) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_yx_wprize
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_wprize`;
CREATE TABLE `t_yx_wprize` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_uid` int(11) NOT NULL,
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_desc` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_item` varchar(2000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_config` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_result` text COLLATE utf8_bin,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_yx_wprize_user
-- ----------------------------
DROP TABLE IF EXISTS `t_yx_wprize_user`;
CREATE TABLE `t_yx_wprize_user` (
  `f_id` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_wprize` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_code` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_phone` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `f_photo` varchar(256) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_zhifb_set
-- ----------------------------
DROP TABLE IF EXISTS `t_zhifb_set`;
CREATE TABLE `t_zhifb_set` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_reply_type` char(1) DEFAULT NULL COMMENT '0：关注回复  1：关键字回复',
  `f_reply_way` char(1) DEFAULT NULL COMMENT '1：自定义纯文本回复  2：自定义图文回复',
  `f_txt_content` varchar(256) DEFAULT NULL COMMENT '如：积分兑换订单等',
  `f_keyword` varchar(16) DEFAULT NULL,
  `f_event_source` char(1) DEFAULT NULL COMMENT '0:内容回复 1:菜单点击响应',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_zhifb_set_list
-- ----------------------------
DROP TABLE IF EXISTS `t_zhifb_set_list`;
CREATE TABLE `t_zhifb_set_list` (
  `f_id` char(16) NOT NULL,
  `f_ctime` datetime NOT NULL,
  `f_utime` datetime NOT NULL,
  `f_uid` int(11) DEFAULT NULL,
  `f_url` varchar(256) DEFAULT NULL,
  `f_title` varchar(32) DEFAULT NULL,
  `f_sub_title` varchar(128) DEFAULT NULL,
  `f_title_img` varchar(256) DEFAULT NULL,
  `f_weixin_set_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for v_auction_margin_r
-- ----------------------------
DROP VIEW IF EXISTS `v_auction_margin_r`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_auction_margin_r` AS (select `a`.`f_id` AS `f_id`,`a`.`f_uid` AS `f_uid`,`a`.`f_pay_time` AS `f_pay_time`,`a`.`f_refund_time` AS `f_refund_time`,`a`.`f_pay_state` AS `f_pay_state`,`a`.`f_order_state` AS `f_order_state`,`a`.`f_money` AS `f_money`,`a`.`f_pay_type` AS `f_pay_type`,`a`.`f_ctime` AS `f_ctime`,`b`.`f_id` AS `f_auctid`,`b`.`f_title` AS `f_auct_name`,`b`.`f_img` AS `f_auct_img`,`c`.`f_id` AS `f_user_id`,`c`.`f_name` AS `f_user_name`,`c`.`f_acc` AS `f_user_acc` from ((`t_yx_margin_record` `a` join `t_yx_auction` `b` on((`a`.`f_auction_id` = `b`.`f_id`))) join `t_user` `c` on((`a`.`f_user_id` = `c`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_card_user
-- ----------------------------
DROP VIEW IF EXISTS `v_card_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_card_user` AS (select `a`.`f_id` AS `f_id`,`a`.`f_card_id` AS `f_card_id`,`a`.`f_card_num` AS `f_card_num`,`a`.`f_get_time` AS `f_get_time`,`a`.`f_state` AS `f_state`,`b`.`f_id` AS `f_user_id`,`b`.`f_uid` AS `f_uid`,`b`.`f_img` AS `f_user_img`,`b`.`f_acc` AS `f_acc`,`b`.`f_name` AS `f_user_name`,`b`.`f_phone` AS `f_phone`,`b`.`f_nickname` AS `f_nickname`,`a`.`f_ctime` AS `f_ctime` from (`t_card_user` `a` left join `t_user` `b` on((`a`.`f_user_id` = `b`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_coupon_user
-- ----------------------------
DROP VIEW IF EXISTS `v_coupon_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_coupon_user` AS (select `a`.`f_id` AS `f_id`,`a`.`f_order_id` AS `f_order_id`,`a`.`f_get_time` AS `f_get_time`,`a`.`f_use_time` AS `f_use_time`,`a`.`f_coupon_id` AS `f_coupon_id`,`a`.`f_state` AS `f_state`,`b`.`f_name` AS `f_coupon_name`,`b`.`f_price` AS `f_price`,`b`.`f_count` AS `f_count`,`b`.`f_end_time` AS `f_end_time`,`b`.`f_img` AS `f_img`,`b`.`f_desc` AS `f_desc`,`b`.`f_order_use` AS `f_order_use`,`c`.`f_id` AS `f_user_id`,`c`.`f_acc` AS `f_acc`,`c`.`f_name` AS `f_user_name`,`a`.`f_ctime` AS `f_ctime` from ((`t_coupon_user` `a` left join `t_coupon` `b` on((`a`.`f_coupon_id` = `b`.`f_id`))) left join `t_user` `c` on((`a`.`f_user_id` = `c`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_favorite
-- ----------------------------
DROP VIEW IF EXISTS `v_favorite`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_favorite` AS (select `a`.`f_id` AS `f_id`,`a`.`f_ctime` AS `f_ctime`,`a`.`f_utime` AS `f_utime`,`a`.`f_user` AS `f_user`,`a`.`f_uid` AS `f_uid`,`a`.`f_product` AS `f_product`,`b`.`f_name` AS `f_name`,`b`.`f_img` AS `f_img`,`b`.`f_price_type` AS `f_price_type`,`b`.`f_price` AS `f_price`,`b`.`f_price_yh` AS `f_price_yh`,`b`.`f_point` AS `f_point` from (`t_favorite` `a` left join `t_product` `b` on((`a`.`f_product` = `b`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_order
-- ----------------------------
DROP VIEW IF EXISTS `v_order`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_order` AS (select `a`.`f_id` AS `f_id`,`a`.`f_uid` AS `f_uid`,`a`.`f_ctime` AS `f_ctime`,`a`.`f_utime` AS `f_utime`,`a`.`f_user_id` AS `f_user_id`,`a`.`f_num` AS `f_num`,`a`.`f_pay` AS `f_pay`,`a`.`f_contact` AS `f_contact`,`a`.`f_deliver` AS `f_deliver`,`a`.`f_addr` AS `f_addr`,`a`.`f_money` AS `f_money`,`a`.`f_point` AS `f_point`,`a`.`f_discount` AS `f_discount`,`a`.`f_youhui` AS `f_youhui`,`a`.`f_freight` AS `f_freight`,`a`.`f_bill` AS `f_bill`,`a`.`f_coupon_price_id` AS `f_coupon_price_id`,`a`.`f_coupon_price` AS `f_coupon_price`,`a`.`f_pay_money` AS `f_pay_money`,`a`.`f_order_money` AS `f_order_money`,`a`.`f_order_count` AS `f_order_count`,`a`.`f_pay_num` AS `f_pay_num`,`a`.`f_pay_state` AS `f_pay_state`,`a`.`f_deliver_state` AS `f_deliver_state`,`a`.`f_receiver_state` AS `f_receiver_state`,`a`.`f_state` AS `f_state`,`a`.`f_desc` AS `f_desc`,`a`.`f_flow` AS `f_flow`,`a`.`f_start_delivery_time` AS `f_start_delivery_time`,`a`.`f_end_delivery_time` AS `f_end_delivery_time`,`a`.`f_logistics` AS `f_logistics`,`a`.`f_logistics_id` AS `f_logistics_id`,`a`.`f_logistics_state` AS `f_logistics_state`,`a`.`f_pay_info` AS `f_pay_info`,`a`.`f_remark` AS `f_remark`,`b`.`f_id` AS `f_store_id`,`b`.`f_name` AS `f_store_name` from (`t_order` `a` left join `t_store` `b` on((`a`.`f_store_id` = `b`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_order_item
-- ----------------------------
DROP VIEW IF EXISTS `v_order_item`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_order_item` AS (select `a`.`f_id` AS `f_id`,`a`.`f_order_id` AS `f_order_id`,`a`.`f_prod_id` AS `f_prod_id`,`a`.`f_price` AS `f_price`,`a`.`f_price_yh` AS `f_price_yh`,`a`.`f_point` AS `f_point`,`a`.`f_count` AS `f_count`,`a`.`f_price_type` AS `f_price_type`,`a`.`f_spec1` AS `f_spec1`,`a`.`f_spec2` AS `f_spec2`,`b`.`f_name` AS `f_prod_name`,`b`.`f_code` AS `f_code`,`b`.`f_stock_count` AS `f_stock_count`,`b`.`f_img` AS `f_prod_img`,`b`.`f_spec` AS `f_spec`,`b`.`f_product_type` AS `f_product_type` from (`t_order_item` `a` left join `t_product` `b` on((`a`.`f_prod_id` = `b`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_product_class
-- ----------------------------
DROP VIEW IF EXISTS `v_product_class`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_product_class` AS (select `b`.`f_id` AS `f_id`,`b`.`f_uid` AS `f_uid`,`b`.`f_name` AS `f_name`,`b`.`f_img` AS `f_img`,`b`.`f_imgs` AS `f_imgs`,`b`.`f_state` AS `f_state`,`b`.`f_type` AS `f_type`,`b`.`f_stock_count` AS `f_stock_count`,`b`.`f_price` AS `f_price`,`b`.`f_price_type` AS `f_price_type`,`b`.`f_price_yh` AS `f_price_yh`,`b`.`f_point` AS `f_point`,`a`.`f_class` AS `f_class_id`,`a`.`f_ctime` AS `f_ctime`,`a`.`f_utime` AS `f_utime`,`b`.`f_desc` AS `f_desc`,`b`.`f_spec` AS `f_spec`,`b`.`f_config` AS `f_config`,`b`.`f_heart` AS `f_heart`,`b`.`f_tag` AS `f_tag` from (`t_product_class` `a` join `t_product` `b` on((`a`.`f_product` = `b`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_product_class_s
-- ----------------------------
DROP VIEW IF EXISTS `v_product_class_s`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_product_class_s` AS (select `b`.`f_id` AS `f_id`,`b`.`f_uid` AS `f_uid`,`c`.`f_id` AS `f_class_id`,`c`.`f_name` AS `f_class_name`,`a`.`f_ctime` AS `f_ctime`,`a`.`f_utime` AS `f_utime` from ((`t_product_class` `a` join `t_product` `b` on((`a`.`f_product` = `b`.`f_id`))) join `t_class` `c` on((`a`.`f_class` = `c`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_staff
-- ----------------------------
DROP VIEW IF EXISTS `v_staff`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_staff` AS (select `a`.`f_id` AS `f_id`,`a`.`f_ctime` AS `f_ctime`,`a`.`f_utime` AS `f_utime`,`a`.`f_user` AS `f_user`,`a`.`f_uid` AS `f_uid`,`a`.`f_name` AS `f_name`,`a`.`f_zhiwu` AS `f_zhiwu`,`a`.`f_sex` AS `f_sex`,`a`.`f_phone` AS `f_phone`,`a`.`f_email` AS `f_email`,`a`.`f_acc` AS `f_acc`,`a`.`f_type` AS `f_type`,`b`.`f_id` AS `f_store_id`,`b`.`f_name` AS `f_store_name`,`c`.`f_id` AS `f_dept_id`,`c`.`f_name` AS `f_dept_name` from ((`t_staff` `a` left join `t_store` `b` on((`a`.`f_store` = `b`.`f_id`))) left join `t_dept` `c` on((`a`.`f_dept` = `c`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_user_buy
-- ----------------------------
DROP VIEW IF EXISTS `v_user_buy`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_user_buy` AS (select `a`.`f_id` AS `f_id`,`a`.`f_ctime` AS `f_ctime`,`a`.`f_buy_time` AS `f_buy_time`,`a`.`f_money` AS `f_money`,`a`.`f_source` AS `f_source`,`a`.`f_source_type` AS `f_source_type`,`b`.`f_id` AS `f_user_id`,`b`.`f_acc` AS `f_acc`,`b`.`f_uid` AS `f_uid`,`b`.`f_name` AS `f_user_name`,`c`.`f_id` AS `f_store_id`,`c`.`f_name` AS `f_store_name` from ((`t_user_buy` `a` left join `t_user` `b` on((`a`.`f_user_id` = `b`.`f_id`))) left join `t_store` `c` on((`a`.`f_store_id` = `c`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_user_buy_use
-- ----------------------------
DROP VIEW IF EXISTS `v_user_buy_use`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_user_buy_use` AS (select `a`.`f_id` AS `f_id`,`a`.`f_ctime` AS `f_ctime`,`a`.`f_use_time` AS `f_use_time`,`a`.`f_money` AS `f_money`,`a`.`f_order_id` AS `f_order_id`,`b`.`f_id` AS `f_user_id`,`b`.`f_uid` AS `f_uid`,`b`.`f_name` AS `f_user_name`,`b`.`f_acc` AS `f_acc`,`c`.`f_id` AS `f_store_id`,`c`.`f_name` AS `f_store_name` from ((`t_user_buy_use` `a` left join `t_user` `b` on((`a`.`f_user_id` = `b`.`f_id`))) left join `t_store` `c` on((`a`.`f_store_id` = `c`.`f_id`)))) ;

-- ----------------------------
-- View structure for v_user_card
-- ----------------------------
DROP VIEW IF EXISTS `v_user_card`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_user_card` AS (select `a`.`f_id` AS `f_id`,`a`.`f_acc` AS `f_acc`,`a`.`f_uid` AS `f_uid`,`a`.`f_name` AS `f_name`,`a`.`f_nickname` AS `f_nickname`,`a`.`f_phone` AS `f_phone`,`a`.`f_img` AS `f_img`,`a`.`f_config` AS `f_config`,`a`.`f_address` AS `f_address`,`a`.`f_state` AS `f_user_state`,`b`.`f_store_id` AS `f_store_id`,`b`.`f_card_num` AS `f_card_num`,`b`.`f_get_time` AS `f_get_time`,`b`.`f_level_time` AS `f_level_time`,`b`.`f_state` AS `f_state`,`b`.`f_desc` AS `f_desc`,`c`.`f_id` AS `f_card_id`,`c`.`f_name` AS `f_card_name`,`c`.`f_img` AS `f_card_img`,`c`.`f_level` AS `f_card_level`,`c`.`f_from` AS `f_from`,`c`.`f_to` AS `f_to`,`c`.`f_discount` AS `f_card_discount`,`c`.`f_end_time` AS `f_end_time`,`c`.`f_desc` AS `f_card_desc`,`a`.`f_ctime` AS `f_ctime` from ((`t_user` `a` left join `t_card_user` `b` on((`a`.`f_id` = `b`.`f_user_id`))) left join `t_card` `c` on((`b`.`f_card_id` = `c`.`f_id`)))) ;
