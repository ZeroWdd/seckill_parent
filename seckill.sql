/*
Navicat MySQL Data Transfer

Source Server         : seckill
Source Server Version : 50727
Source Host           : 192.168.2.105:3306
Source Database       : seckill

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2019-09-14 18:39:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_brand`
-- ----------------------------
DROP TABLE IF EXISTS `tb_brand`;
CREATE TABLE `tb_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '品牌id',
  `name` varchar(64) NOT NULL COMMENT '品牌名称',
  `image` varchar(256) DEFAULT '' COMMENT '品牌图片地址',
  `letter` char(1) DEFAULT '' COMMENT '品牌的首字母',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8558 DEFAULT CHARSET=utf8 COMMENT='品牌表，一个品牌下有多个商品（spu），一对多关系';

-- ----------------------------
-- Records of tb_brand
-- ----------------------------
INSERT INTO `tb_brand` VALUES ('8557', '华为（HUAWEI）', 'http://img10.360buyimg.com/popshop/jfs/t5662/36/8888655583/7806/1c629c01/598033b4Nd6055897.jpg', 'H', '2019-02-27 22:54:12', '2019-02-27 22:54:29');

-- ----------------------------
-- Table structure for `tb_category`
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '类目id',
  `name` varchar(32) NOT NULL COMMENT '类目名称',
  `parent_id` bigint(20) NOT NULL COMMENT '父类目id,顶级类目填0',
  `is_parent` tinyint(1) NOT NULL COMMENT '是否为父节点，0为否，1为是',
  `sort` tinyint(2) NOT NULL COMMENT '排序指数，越小越靠前',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  KEY `key_parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='商品类目表，类目和商品(spu)是一对多关系，类目与品牌是多对多关系';

-- ----------------------------
-- Records of tb_category
-- ----------------------------
INSERT INTO `tb_category` VALUES ('74', '手机', '0', '1', '2', '2019-05-07 10:46:41', '2019-05-07 10:46:41');
INSERT INTO `tb_category` VALUES ('75', '手机通讯', '74', '1', '1', '2019-05-07 10:46:41', '2019-05-07 10:46:41');
INSERT INTO `tb_category` VALUES ('76', '手机', '75', '0', '1', '2019-05-07 10:46:41', '2019-05-07 10:46:41');

-- ----------------------------
-- Table structure for `tb_category_brand`
-- ----------------------------
DROP TABLE IF EXISTS `tb_category_brand`;
CREATE TABLE `tb_category_brand` (
  `category_id` bigint(20) NOT NULL COMMENT '商品类目id',
  `brand_id` bigint(20) NOT NULL COMMENT '品牌id',
  PRIMARY KEY (`category_id`,`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品分类和品牌的中间表，两者是多对多关系';

-- ----------------------------
-- Records of tb_category_brand
-- ----------------------------
INSERT INTO `tb_category_brand` VALUES ('76', '8557');

-- ----------------------------
-- Table structure for `tb_limit_policy`
-- ----------------------------
DROP TABLE IF EXISTS `tb_limit_policy`;
CREATE TABLE `tb_limit_policy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) NOT NULL COMMENT 'skuid',
  `quanty` bigint(20) DEFAULT NULL COMMENT '数量',
  `price` bigint(20) DEFAULT NULL COMMENT '秒杀价格',
  `begin_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_limit_policy
-- ----------------------------
INSERT INTO `tb_limit_policy` VALUES ('13', '26816294479', '500', '100000', '2019-09-14 14:50:00', '2019-09-14 14:55:00');
INSERT INTO `tb_limit_policy` VALUES ('14', '26816294479', '500', '100000', '2019-09-14 16:10:00', '2019-09-14 16:15:00');
INSERT INTO `tb_limit_policy` VALUES ('15', '26816294479', '500', '100000', '2019-09-14 16:20:00', '2019-09-14 16:30:00');
INSERT INTO `tb_limit_policy` VALUES ('16', '26816294480', '500', '100000', '2019-09-14 16:20:00', '2019-09-14 16:30:00');
INSERT INTO `tb_limit_policy` VALUES ('17', '26816294479', '400', '100000', '2019-09-14 16:40:00', '2019-09-14 16:50:00');
INSERT INTO `tb_limit_policy` VALUES ('18', '26816294479', '400', '100000', '2019-09-14 16:40:00', '2019-09-14 16:50:00');
INSERT INTO `tb_limit_policy` VALUES ('19', '26816294479', '100', '10000', '2019-09-14 17:00:00', '2019-09-14 17:30:00');
INSERT INTO `tb_limit_policy` VALUES ('20', '26816294479', '100', '200000', '2019-09-14 17:45:00', '2019-09-14 18:00:00');
INSERT INTO `tb_limit_policy` VALUES ('21', '26816294479', '100', '400000', '2019-09-14 18:00:00', '2019-09-14 19:00:00');

-- ----------------------------
-- Table structure for `tb_order`
-- ----------------------------
DROP TABLE IF EXISTS `tb_order`;
CREATE TABLE `tb_order` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `total_fee` bigint(20) NOT NULL COMMENT '总金额，单位为分',
  `actual_fee` bigint(20) NOT NULL COMMENT '实付金额。单位:分。如:20007，表示:200元7分',
  `promotion_ids` varchar(256) COLLATE utf8_bin DEFAULT '' COMMENT '优惠活动id，多个以，隔开',
  `payment_type` tinyint(1) unsigned zerofill NOT NULL COMMENT '支付类型，1、在线支付，2、货到付款',
  `post_fee` bigint(20) NOT NULL COMMENT '邮费。单位:分。如:20007，表示:200元7分',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `invoice_type` int(1) DEFAULT '0' COMMENT '发票类型(0无发票1普通发票，2电子发票，3增值税发票)',
  `source_type` int(1) DEFAULT '2' COMMENT '订单来源：1:app端，2：pc端，3：微信端',
  `status` tinyint(1) DEFAULT NULL COMMENT '订单的状态，1、未付款 2、已付款,未发货 3、已发货,未确认 4、确认收货，交易成功 5、交易取消，订单关闭 6、交易结束，已评价',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `consign_time` timestamp NULL DEFAULT NULL COMMENT '发货时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '交易完成时间',
  `close_time` timestamp NULL DEFAULT NULL COMMENT '交易关闭时间',
  `comment_time` timestamp NULL DEFAULT NULL COMMENT '评价时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`order_id`),
  KEY `multi_key_status_time` (`status`,`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1172819872783007745 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tb_order
-- ----------------------------
INSERT INTO `tb_order` VALUES ('1568457225736', '428800', '400000', '', '0', '0', '29', '0', '2', '2', '2019-09-14 18:33:00', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `tb_order_detail`
-- ----------------------------
DROP TABLE IF EXISTS `tb_order_detail`;
CREATE TABLE `tb_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单详情id ',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `sku_id` bigint(20) NOT NULL COMMENT 'sku商品id',
  `num` int(4) NOT NULL COMMENT '购买数量',
  `title` varchar(256) NOT NULL COMMENT '商品标题',
  `own_spec` varchar(1024) DEFAULT '' COMMENT '商品动态属性键值集',
  `price` int(16) NOT NULL COMMENT '价格,单位：分',
  `image` varchar(256) DEFAULT '' COMMENT '商品图片',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `key_order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='订单详情表';

-- ----------------------------
-- Records of tb_order_detail
-- ----------------------------
INSERT INTO `tb_order_detail` VALUES ('26', '1568457225736', '26816294479', '1', '华为（HUAWEI） 华为P20 手机 宝石蓝 高配（6G+128G）', '{\"4\":\"宝石蓝\",\"12\":\"6GB\",\"13\":\"64GB\"}', '400000', 'https://img10.360buyimg.com/n1/s450x450_jfs/t1/30693/17/7599/332089/5c98cc1fE43eafa3c/3b3515c7537efeaf.jpg', '2019-09-14 18:33:00', null);

-- ----------------------------
-- Table structure for `tb_order_logistics`
-- ----------------------------
DROP TABLE IF EXISTS `tb_order_logistics`;
CREATE TABLE `tb_order_logistics` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单id，与订单表一对一',
  `logistics_number` varchar(18) DEFAULT '' COMMENT '物流单号',
  `logistics_company` varchar(18) DEFAULT '' COMMENT '物流公司名称',
  `addressee` varchar(32) NOT NULL COMMENT '收件人',
  `phone` varchar(11) NOT NULL COMMENT '收件人手机号码',
  `province` varchar(16) NOT NULL COMMENT '省',
  `city` varchar(32) NOT NULL COMMENT '市',
  `district` varchar(32) NOT NULL COMMENT '区',
  `street` varchar(256) NOT NULL COMMENT '街道',
  `postcode` int(6) DEFAULT '0' COMMENT '邮编',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_order_logistics
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_shoppingcart`
-- ----------------------------
DROP TABLE IF EXISTS `tb_shoppingcart`;
CREATE TABLE `tb_shoppingcart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) NOT NULL COMMENT 'skuid',
  `quanty` decimal(18,2) DEFAULT NULL COMMENT '数量',
  `price` decimal(18,2) DEFAULT NULL COMMENT '单价',
  `amount` decimal(18,2) DEFAULT NULL COMMENT '金额',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `canceled` int(11) DEFAULT NULL COMMENT '是否取消',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_shoppingcart
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_sku`
-- ----------------------------
DROP TABLE IF EXISTS `tb_sku`;
CREATE TABLE `tb_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'sku id',
  `spu_id` bigint(20) NOT NULL COMMENT 'spu id',
  `title` varchar(256) NOT NULL COMMENT '商品标题',
  `images` varchar(1024) DEFAULT '' COMMENT '商品的图片，多个图片以‘,’分割',
  `stock` int(8) unsigned DEFAULT '9999' COMMENT '库存',
  `price` bigint(16) NOT NULL DEFAULT '0' COMMENT '销售价格，单位为分',
  `indexes` varchar(32) DEFAULT '' COMMENT '特有规格属性在spu属性模板中的对应下标组合',
  `own_spec` varchar(1024) DEFAULT '' COMMENT 'sku的特有规格参数键值对，json格式，反序列化时请使用linkedHashMap，保证有序',
  `enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效，0无效，1有效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  KEY `key_spu_id` (`spu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27359021560 DEFAULT CHARSET=utf8 COMMENT='sku表,该表表示具体的商品实体,如黑色的 64g的iphone 8';

-- ----------------------------
-- Records of tb_sku
-- ----------------------------
INSERT INTO `tb_sku` VALUES ('26816294479', '94', '华为（HUAWEI） 华为P20 手机 宝石蓝 高配（6G+128G）', 'https://img10.360buyimg.com/n1/s450x450_jfs/t1/30693/17/7599/332089/5c98cc1fE43eafa3c/3b3515c7537efeaf.jpg', '9999', '428800', '1_0_0', '{\"4\":\"宝石蓝\",\"12\":\"6GB\",\"13\":\"64GB\"}', '1', '2018-04-21 15:58:21', '2018-04-21 15:58:21');
INSERT INTO `tb_sku` VALUES ('26816294480', '94', '华为（HUAWEI） 华为P20 手机 樱粉金 标配（6G+64G）', 'https://img10.360buyimg.com/n1/s450x450_jfs/t1/30693/17/7599/332089/5c98cc1fE43eafa3c/3b3515c7537efeaf.jpg', '9999', '378800', '3_0_0', '{\"4\":\"樱粉金\",\"12\":\"6GB\",\"13\":\"64GB\"}', '1', '2018-04-21 15:58:22', '2018-04-21 15:58:22');
INSERT INTO `tb_sku` VALUES ('26816294483', '94', '华为（HUAWEI） 华为P20 手机 香槟金 高配（6G+128G）', 'https://img10.360buyimg.com/n1/s450x450_jfs/t1/30693/17/7599/332089/5c98cc1fE43eafa3c/3b3515c7537efeaf.jpg', '9999', '428800', '2_0_0', '{\"4\":\"香槟金\",\"12\":\"6GB\",\"13\":\"64GB\"}', '1', '2018-04-21 15:58:21', '2018-04-21 15:58:21');
INSERT INTO `tb_sku` VALUES ('26881279026', '69', '华为（HUAWEI） 华为P20pro 手机 宝石蓝 6G+128G', 'https://img10.360buyimg.com/n1/s450x450_jfs/t17689/292/1247919821/159809/1c87eb05/5ac1eae4Nce7c8b00.jpg', '9999', '548800', '0_0_0', '{\"4\":\"宝石蓝\",\"12\":\"6GB\",\"13\":\"128GB\"}', '1', '2018-04-21 15:57:15', '2018-04-21 15:57:15');
INSERT INTO `tb_sku` VALUES ('26881279030', '69', '华为（HUAWEI） 华为P20pro 手机 樱粉金 6G+256G', 'https://img10.360buyimg.com/n1/s450x450_jfs/t17689/292/1247919821/159809/1c87eb05/5ac1eae4Nce7c8b00.jpg', '9999', '658800', '3_0_0', '{\"4\":\"樱粉金\",\"12\":\"6GB\",\"13\":\"128GB\"}', '1', '2018-04-21 15:57:17', '2018-04-21 15:57:17');
INSERT INTO `tb_sku` VALUES ('26881279032', '69', '华为（HUAWEI） 华为P20pro 手机 极光色 6G+128G', 'https://img10.360buyimg.com/n1/s450x450_jfs/t17689/292/1247919821/159809/1c87eb05/5ac1eae4Nce7c8b00.jpg', '9999', '618800', '2_0_0', '{\"4\":\"极光色\",\"12\":\"6GB\",\"13\":\"128GB\"}', '1', '2018-04-21 15:57:16', '2018-04-21 15:57:16');
INSERT INTO `tb_sku` VALUES ('26881279035', '69', '华为（HUAWEI） 华为P20pro 手机 亮黑色 6G+128G', 'https://img10.360buyimg.com/n1/s450x450_jfs/t17689/292/1247919821/159809/1c87eb05/5ac1eae4Nce7c8b00.jpg', '9999', '548800', '1_0_0', '{\"4\":\"亮黑色\",\"12\":\"6GB\",\"13\":\"128GB\"}', '1', '2018-04-21 15:57:16', '2018-04-21 15:57:16');
INSERT INTO `tb_sku` VALUES ('27359021557', '2', '华为 G9 青春版  白色 3GB 16GB', 'https://img12.360buyimg.com/n7/jfs/t1/24205/2/14862/179077/5cb6d175E92733807/46e7ace99f41dd41.jpg', '9999', '84900', '0_0_0', '{\"4\":\"白色\",\"12\":\"3GB\",\"13\":\"16GB\"}', '1', '2019-03-18 22:09:49', '2019-03-18 22:09:49');
INSERT INTO `tb_sku` VALUES ('27359021558', '2', '华为 G9 青春版  金色 3GB 16GB', 'https://img12.360buyimg.com/n7/jfs/t1/24205/2/14862/179077/5cb6d175E92733807/46e7ace99f41dd41.jpg', '9999', '84900', '1_0_0', '{\"4\":\"金色\",\"12\":\"3GB\",\"13\":\"16GB\"}', '1', '2019-03-18 22:09:49', '2019-03-18 22:09:49');
INSERT INTO `tb_sku` VALUES ('27359021559', '2', '华为 G9 青春版  玫瑰金 3GB 16GB', 'https://img12.360buyimg.com/n7/jfs/t1/24205/2/14862/179077/5cb6d175E92733807/46e7ace99f41dd41.jpg', '9999', '84900', '2_0_0', '{\"4\":\"玫瑰金\",\"12\":\"3GB\",\"13\":\"16GB\"}', '1', '2019-03-18 22:09:49', '2019-03-18 22:09:49');

-- ----------------------------
-- Table structure for `tb_spec_group`
-- ----------------------------
DROP TABLE IF EXISTS `tb_spec_group`;
CREATE TABLE `tb_spec_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cid` bigint(20) NOT NULL COMMENT '商品分类id，一个分类下有多个规格组',
  `name` varchar(32) NOT NULL COMMENT '规格组的名称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `key_category` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='规格参数的分组表，每个商品分类下有多个规格参数组';

-- ----------------------------
-- Records of tb_spec_group
-- ----------------------------
INSERT INTO `tb_spec_group` VALUES ('1', '76', '主体', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('2', '76', '基本信息', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('3', '76', '操作系统', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('4', '76', '主芯片', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('5', '76', '存储', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('6', '76', '摄像头', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('7', '76', '电池信息', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('11', '76', '屏幕', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('12', '90', '主体', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('13', '90', '规格尺寸', '2019-03-13 22:14:13', '2019-03-13 22:14:13');
INSERT INTO `tb_spec_group` VALUES ('14', '77', 'test', '2019-03-13 22:14:13', '2019-03-13 22:14:13');

-- ----------------------------
-- Table structure for `tb_spec_param`
-- ----------------------------
DROP TABLE IF EXISTS `tb_spec_param`;
CREATE TABLE `tb_spec_param` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cid` bigint(20) NOT NULL COMMENT '商品分类id',
  `group_id` bigint(20) NOT NULL,
  `name` varchar(128) NOT NULL COMMENT '参数名',
  `numeric` tinyint(1) NOT NULL COMMENT '是否是数字类型参数，true或false',
  `unit` varchar(64) DEFAULT '' COMMENT '数字类型参数的单位，非数字类型可以为空',
  `generic` tinyint(1) NOT NULL COMMENT '是否是sku通用属性，true或false',
  `searching` tinyint(1) NOT NULL COMMENT '是否用于搜索过滤，true或false',
  `segments` varchar(1024) DEFAULT '' COMMENT '数值类型参数，如果需要搜索，则添加分段间隔值，如CPU频率间隔：0.5-1.0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `key_group` (`group_id`),
  KEY `key_category` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='规格参数组下的参数名';

-- ----------------------------
-- Records of tb_spec_param
-- ----------------------------
INSERT INTO `tb_spec_param` VALUES ('1', '76', '1', '品牌', '0', '', '1', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('2', '76', '1', '型号', '0', '', '1', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('3', '76', '1', '上市年份', '1', '年', '1', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('4', '76', '2', '机身颜色', '0', '', '0', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('5', '76', '2', '机身重量（g）', '1', 'g', '1', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('6', '76', '2', '机身材质工艺', '0', '', '1', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('7', '76', '3', '操作系统', '0', '', '1', '1', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('8', '76', '4', 'CPU品牌', '0', '', '1', '1', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('9', '76', '4', 'CPU型号', '0', '', '1', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('10', '76', '4', 'CPU核数', '0', '', '1', '1', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('11', '76', '4', 'CPU频率', '1', 'GHz', '1', '1', '0-1.0,1.0-1.5,1.5-2.0,2.0-2.5,2.5-', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('12', '76', '5', '内存', '0', '', '0', '1', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('13', '76', '5', '机身存储', '0', '', '0', '1', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('14', '76', '11', '主屏幕尺寸（英寸）', '1', '英寸', '1', '1', '0-4.0,4.0-5.0,5.0-5.5,5.5-6.0,6.0-', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('15', '76', '11', '分辨率', '0', '', '1', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('16', '76', '6', '前置摄像头', '1', '万', '1', '1', '0-500,500-1000,1000-1500,1500-2000,2500-', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('17', '76', '6', '后置摄像头', '1', '万', '1', '1', '0-500,500-1000,1000-1500,1500-2000,2500-', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('18', '76', '7', '电池容量（mAh）', '1', 'mAh', '1', '1', '0-2000,2000-3000,3000-4000,4000-', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('19', '90', '12', '品牌', '0', '', '1', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('20', '90', '12', '适用机型', '0', '', '0', '0', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('21', '90', '13', '贴膜尺寸', '1', '英寸', '1', '1', '0-4.0,4.0-5.0,5.0-5.5,5.5-6.0,6.0-', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('22', '90', '13', '材质', '0', '', '1', '1', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');
INSERT INTO `tb_spec_param` VALUES ('23', '90', '13', '类型', '0', '', '1', '1', '', '2019-03-13 22:15:13', '2019-03-13 22:15:13');

-- ----------------------------
-- Table structure for `tb_spu`
-- ----------------------------
DROP TABLE IF EXISTS `tb_spu`;
CREATE TABLE `tb_spu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'spu id',
  `name` varchar(256) NOT NULL DEFAULT '' COMMENT '商品名称',
  `sub_title` varchar(256) DEFAULT '' COMMENT '副标题，一般是促销信息',
  `cid1` bigint(20) NOT NULL COMMENT '1级类目id',
  `cid2` bigint(20) NOT NULL COMMENT '2级类目id',
  `cid3` bigint(20) NOT NULL COMMENT '3级类目id',
  `brand_id` bigint(20) NOT NULL COMMENT '商品所属品牌id',
  `saleable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否上架，0下架，1上架',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COMMENT='spu表，该表描述的是一个抽象性的商品，比如 iphone8';

-- ----------------------------
-- Records of tb_spu
-- ----------------------------
INSERT INTO `tb_spu` VALUES ('2', '华为 G9 青春版 ', '骁龙芯片！3GB运行内存！索尼1300万摄像头！<a href=\'https://sale.jd.com/act/DhKrOjXnFcGL.html\' target=\'_blank\'>华为新品全面上线，更多优惠猛戳》》</a>', '74', '75', '76', '8557', '0', '2018-04-21 15:55:15', '2018-06-18 10:36:12');
INSERT INTO `tb_spu` VALUES ('69', '华为（HUAWEI） 华为P20pro 手机 ', '华为直供货源大量现货！【宝石蓝128G及极光色全系为预售请见详情】自带原装耳机 <a href=\"https://item.jd.com/26816294484.html\" target=\"_blank\">华为P20</a>', '74', '75', '76', '8557', '1', '2018-04-21 15:57:17', '2018-04-21 15:57:17');
INSERT INTO `tb_spu` VALUES ('94', '华为（HUAWEI） 华为P20 手机 ', '大量现货 华为直供货源！自带原装耳机 华为<a href=\"https://item.jd.com/26881279035.html\" target=\"_blank\">P20pro</a> 现货抢购！', '74', '75', '76', '8557', '1', '2018-04-21 15:58:22', '2018-04-21 15:58:22');

-- ----------------------------
-- Table structure for `tb_spu_detail`
-- ----------------------------
DROP TABLE IF EXISTS `tb_spu_detail`;
CREATE TABLE `tb_spu_detail` (
  `spu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` text COMMENT '商品描述信息',
  `generic_spec` varchar(2048) NOT NULL DEFAULT '' COMMENT '通用规格参数数据',
  `special_spec` varchar(1024) NOT NULL COMMENT '特有规格参数及可选值信息，json格式',
  `packing_list` varchar(1024) DEFAULT '' COMMENT '包装清单',
  `after_service` varchar(1024) DEFAULT '' COMMENT '售后服务',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`spu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_spu_detail
-- ----------------------------
INSERT INTO `tb_spu_detail` VALUES ('2', '<p><img src=\"//img20.360buyimg.com/vc/jfs/t5893/141/6838703316/1369626/15c9d88f/596c753aN075ee827.jpg\"></p>', '{\"1\":\"华为\",\"2\":\"G9青春版（全网通版）\",\"3\":2016,\"5\":143,\"6\":\"陶瓷\",\"7\":\"Android\",\"8\":\"骁龙（Snapdragon)\",\"9\":\"骁龙617（msm8952）\",\"10\":\"八核\",\"11\":1.5,\"14\":5.2,\"15\":\"1920*1080(FHD)\",\"16\":800,\"17\":1300,\"18\":3000}', '{\"4\":[\"白色\",\"金色\",\"玫瑰金\"],\"12\":[\"3GB\"],\"13\":[\"16GB\"]}', '手机（电池内置）*1，中式充电器*1，数据线*1，半入耳式线控耳机*1，华为手机凭证*1，快速指南*1，取卡针*1，屏幕保护膜（出厂已贴）*1', '本产品全国联保，享受三包服务，质保期为：一年质保', '2019-03-15 23:17:42', '2019-03-18 22:09:49');
INSERT INTO `tb_spu_detail` VALUES ('69', '<div style=\"text-align: center;\"><span style=\"font-size:x-large;\">128G宝石蓝预售15天，拍下付款后15天左右发货，请知晓</span></div><div style=\"text-align: center;\"><span style=\"font-size:x-large;\">极光色拍下付款后30天内发货&nbsp;</span></div><div style=\"text-align: center;\"><img src=\"//img20.360buyimg.com/imgzone/jfs/t17578/154/1310755004/43440/138e6778/5ac48068Na58019c5.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img11.360buyimg.com/imgzone/jfs/t17986/133/1325081134/28355/4c741aad/5ac48068Nedf70828.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img14.360buyimg.com/imgzone/jfs/t18394/248/1314986459/42680/dfafa1ca/5ac48067N9b60cc1f.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img13.360buyimg.com/imgzone/jfs/t18421/111/1303502337/77903/6321b83a/5ac48068Ne5a41f75.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/imgzone/jfs/t18406/132/1324715552/60119/906f62ab/5ac48068Ne7825771.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img10.360buyimg.com/imgzone/jfs/t17848/193/1293219897/47077/1fa09468/5ac48069N679f80bb.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img11.360buyimg.com/imgzone/jfs/t18943/325/1299433146/47751/274e466a/5ac48068N81e45a8c.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img12.360buyimg.com/imgzone/jfs/t18796/248/1324882294/80404/41066e97/5ac48069Nf5676304.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img14.360buyimg.com/imgzone/jfs/t17290/167/1296628966/56885/4126f8f9/5ac48069N570e253d.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img14.360buyimg.com/imgzone/jfs/t19267/49/1313101792/87746/27b59499/5ac48069N1b321842.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img11.360buyimg.com/imgzone/jfs/t17581/190/1270057661/75989/d49c35dd/5ac48069N5999f8b2.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img10.360buyimg.com/imgzone/jfs/t19657/148/1310812011/35391/3d0dadd2/5ac48069N4996cfa2.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img10.360buyimg.com/imgzone/jfs/t19498/317/1294838763/54479/e0d5fc60/5ac48069Nbe478a11.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img14.360buyimg.com/imgzone/jfs/t19606/352/1267572849/105458/1f373774/5ac4806aN4e5b0151.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img11.360buyimg.com/imgzone/jfs/t18433/281/1310128148/67540/d111de70/5ac4806aN0660127d.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/imgzone/jfs/t17530/63/1302786108/68573/a7332058/5ac4806aN6f97f844.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img12.360buyimg.com/imgzone/jfs/t17053/85/1359268675/58879/8f413d1e/5ac4806aN13049383.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img11.360buyimg.com/imgzone/jfs/t19654/272/1322987442/96269/3356b8df/5ac4806bN988e51f5.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img13.360buyimg.com/imgzone/jfs/t18532/43/1335105312/453521/267a866/5ac4806dNb92b015a.jpg\" alt=\"\" /></div><br/>', '{\"1\":\"华为（HUAWEI）\",\"2\":\"P20 plus\",\"3\":2018.0,\"5\":\"180\",\"6\":\"其它\",\"7\":\"Android\",\"8\":\"海思（Hisilicon）\",\"9\":\"Kirin 970\",\"10\":\"八核\",\"11\":\"1.4\",\"14\":6.1,\"15\":\"2240*1080\",\"16\":2400.0,\"17\":800.0,\"18\":4000}', '{\"4\":[\"宝石蓝\",\"亮黑色\",\"极光色\",\"樱粉金\"],\"12\":[\"6GB\"],\"13\":[\"128GB\"]}', '暂无', '本产品全国联保，享受三包服务，质保期为：一年质保', '2019-03-15 23:17:42', '2019-03-15 23:17:42');
INSERT INTO `tb_spu_detail` VALUES ('94', '<div style=\"text-align: center;\"><br /></div><div style=\"text-align: center;\"><img src=\"//img10.360buyimg.com/popWaterMark/jfs/t19462/124/1282508904/95484/4fc03213/5ac48dfeN643b8b79.jpg\" alt=\"\" /><img src=\"//img13.360buyimg.com/imgzone/jfs/t16972/248/1231102886/180890/c63f8d97/5ac1f411Nd6dfe723.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/imgzone/jfs/t18415/356/1192546862/121120/242035c8/5ac1f40fN2bafa81a.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/imgzone/jfs/t18364/141/1246441367/328625/384d8f20/5ac1f411N67a4c5d5.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img14.360buyimg.com/imgzone/jfs/t19261/298/1247830409/156248/d5174469/5ac1f410N65113549.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img11.360buyimg.com/imgzone/jfs/t16621/295/1231109982/305193/5c286127/5ac1f413N16bb090d.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img12.360buyimg.com/imgzone/jfs/t17350/282/1256601044/271740/bea0f53/5ac1f412N82119f2c.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/imgzone/jfs/t19318/220/1276109871/453721/144e4b4/5ac1f414N5c5955b7.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img12.360buyimg.com/imgzone/jfs/t16969/123/1236819070/420877/520c1a7d/5ac1f414N7e8d9913.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img14.360buyimg.com/imgzone/jfs/t18541/329/1194608430/485180/b0265e46/5ac1f416Nebbfa29e.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/imgzone/jfs/t17041/273/1221496326/369520/8a473618/5ac1f417N4f0008b0.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/imgzone/jfs/t18148/28/1171242642/476162/539c8d0d/5ac1f416N2e352ff3.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img11.360buyimg.com/imgzone/jfs/t16867/214/1215481898/401579/7f379db1/5ac1f418Naf4d0555.jpg\" alt=\"\" /></div><div style=\"text-align: center;\"><img src=\"//img30.360buyimg.com/imgzone/jfs/t18982/339/1254237985/373373/22a2edfe/5ac1f418Ne6341862.jpg\" alt=\"\" /></div><br/>', '{\"1\":\"华为（HUAWEI）\",\"2\":\"P20\",\"3\":2018.0,\"5\":\"165\",\"6\":\"其它\",\"7\":\"Android\",\"8\":\"海思（Hisilicon）\",\"9\":\"Kirin 970\",\"10\":\"八核\",\"11\":1.2,\"14\":5.8,\"15\":\"其他\",\"16\":2400.0,\"17\":1200.0,\"18\":\"3400\"}', '{\"4\":[\"亮黑色\",\"宝石蓝\",\"香槟金\",\"樱粉金\"],\"12\":[\"6GB\"],\"13\":[\"64GB\"]}', '暂无', '本产品全国联保，享受三包服务，质保期为：一年质保', '2019-03-15 23:17:42', '2019-03-15 23:17:42');

-- ----------------------------
-- Table structure for `tb_stock_storage`
-- ----------------------------
DROP TABLE IF EXISTS `tb_stock_storage`;
CREATE TABLE `tb_stock_storage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `warehouse_id` bigint(20) NOT NULL COMMENT '库房id',
  `sku_id` bigint(20) NOT NULL COMMENT 'skuid',
  `quanty` decimal(18,2) DEFAULT NULL COMMENT '剩余数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1172819355075952641 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_stock_storage
-- ----------------------------
INSERT INTO `tb_stock_storage` VALUES ('1172819355075952640', '1', '26816294479', '-1.00');

-- ----------------------------
-- Table structure for `tb_stock_storage_history`
-- ----------------------------
DROP TABLE IF EXISTS `tb_stock_storage_history`;
CREATE TABLE `tb_stock_storage_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_storage_id` bigint(20) NOT NULL COMMENT '库存主表id',
  `in_quanty` decimal(18,2) DEFAULT NULL COMMENT '入库数量',
  `out_quanty` decimal(18,2) DEFAULT NULL COMMENT '出库数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_stock_storage_history
-- ----------------------------
INSERT INTO `tb_stock_storage_history` VALUES ('1', '1172819355075952640', '0.00', '1.00');

-- ----------------------------
-- Table structure for `tb_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL COMMENT '用户名',
  `password` varchar(60) NOT NULL COMMENT '密码，加密存储',
  `phone` varchar(11) DEFAULT NULL COMMENT '注册手机号',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('28', 'zhangsan', 'e21d44f200365b57fab2641cd31226d4', '13600527633', '2019-04-04 22:58:26', '2019-04-04 22:58:26');
INSERT INTO `tb_user` VALUES ('29', '小白', '123456', null, '2019-09-12 07:55:16', null);
INSERT INTO `tb_user` VALUES ('31', '小黑', '123456', null, '2019-09-12 08:10:50', null);
INSERT INTO `tb_user` VALUES ('32', '小明', '123456', null, '2019-09-12 08:17:13', null);

-- ----------------------------
-- Table structure for `tb_warehouse`
-- ----------------------------
DROP TABLE IF EXISTS `tb_warehouse`;
CREATE TABLE `tb_warehouse` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '库房id',
  `name` varchar(64) NOT NULL COMMENT '库房名称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_warehouse
-- ----------------------------
INSERT INTO `tb_warehouse` VALUES ('1', '北京库', '2019-04-04 22:58:26', '2019-04-04 22:58:26');
