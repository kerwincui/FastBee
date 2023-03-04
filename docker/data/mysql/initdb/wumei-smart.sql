/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云数据库
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : kerwincui.mysql.rds.aliyuncs.com:3306
 Source Schema         : fastbee131

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 26/02/2023 23:36:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'iot_category', '产品分类', '', '', 'Category', 'crud', 'com.ruoyi.iot', 'iot', 'category', '产品分类', 'kerwincui', '0', '/', '{\"treeCode\":\"category_id\",\"treeName\":\"category_name\",\"treeParentCode\":\"parent_id\",\"parentMenuId\":\"2000\"}', 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:01', NULL);
INSERT INTO `gen_table` VALUES (2, 'iot_device', '设备', NULL, NULL, 'Device', 'crud', 'com.ruoyi.iot', 'iot', 'device', '设备', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-12-15 22:56:21', '', '2021-12-16 00:23:18', NULL);
INSERT INTO `gen_table` VALUES (5, 'iot_device_user', '设备用户', NULL, NULL, 'DeviceUser', 'crud', 'com.ruoyi.iot', 'iot', 'deviceuser', '设备用户', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47', NULL);
INSERT INTO `gen_table` VALUES (7, 'iot_firmware', '产品固件', NULL, NULL, 'Firmware', 'crud', 'com.ruoyi.iot', 'iot', 'firmware', '产品固件', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:31', '', '2021-12-16 00:18:09', NULL);
INSERT INTO `gen_table` VALUES (9, 'iot_group', '设备分组', NULL, NULL, 'Group', 'crud', 'com.ruoyi.iot', 'iot', 'group', '设备分组', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:31:15', NULL);
INSERT INTO `gen_table` VALUES (11, 'iot_product', '产品', NULL, NULL, 'Product', 'crud', 'com.ruoyi.iot', 'iot', 'product', '产品', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:22:11', NULL);
INSERT INTO `gen_table` VALUES (13, 'iot_things_model', '物模型', NULL, NULL, 'ThingsModel', 'crud', 'com.ruoyi.iot', 'iot', 'model', '物模型', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:29:39', NULL);
INSERT INTO `gen_table` VALUES (15, 'iot_things_model_template', '通用物模型', NULL, NULL, 'ThingsModelTemplate', 'crud', 'com.ruoyi.iot', 'iot', 'template', '通用物模型', 'kerwincui', '0', '/', '{\"parentMenuId\":2000}', 'admin', '2021-12-15 22:56:44', '', '2021-12-16 00:26:56', NULL);
INSERT INTO `gen_table` VALUES (20, 'iot_alert', '设备告警', NULL, NULL, 'Alert', 'crud', 'com.ruoyi.iot', 'iot', 'alert', '设备告警', 'kerwincui', '0', '/', '{}', 'admin', '2022-01-13 14:53:24', '', '2022-01-13 15:16:02', NULL);
INSERT INTO `gen_table` VALUES (21, 'iot_alert_log', '设备告警日志', NULL, NULL, 'AlertLog', 'crud', 'com.ruoyi.iot', 'iot', 'alertLog', '设备告警', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2022-01-13 14:53:27', '', '2022-01-13 15:16:32', NULL);
INSERT INTO `gen_table` VALUES (22, 'iot_device_log', '设备日志', NULL, NULL, 'DeviceLog', 'crud', 'com.ruoyi.iot', 'iot', 'deviceLog', '设备日志', 'kerwincui', '0', '/', '{}', 'admin', '2022-01-13 14:53:30', '', '2022-01-13 15:17:15', NULL);
INSERT INTO `gen_table` VALUES (23, 'iot_scene', '场景联动', NULL, NULL, 'Scene', 'crud', 'com.ruoyi.iot', 'iot', 'scene', '场景联动', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2022-01-13 14:53:33', '', '2022-01-13 15:17:37', NULL);
INSERT INTO `gen_table` VALUES (27, 'oauth_client_details', '云云对接', NULL, NULL, 'OauthClientDetails', 'crud', 'com.ruoyi.iot', 'iot', 'clientDetails', '云云对接', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11', NULL);
INSERT INTO `gen_table` VALUES (33, 'news', '新闻资讯', NULL, NULL, 'News', 'crud', 'com.ruoyi.iot', 'iot', 'news', '新闻资讯', 'kerwincui', '0', '/', '{\"parentMenuId\":1}', 'admin', '2022-04-09 19:15:19', '', '2022-04-09 19:20:56', NULL);
INSERT INTO `gen_table` VALUES (34, 'news_category', '新闻分类', NULL, NULL, 'NewsCategory', 'crud', 'com.ruoyi.iot', 'iot', 'category', '新闻分类', 'kerwincui', '0', '/', '{\"parentMenuId\":1}', 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 711 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'category_id', '产品分类ID', 'bigint(20)', 'Long', 'categoryId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:01');
INSERT INTO `gen_table_column` VALUES (2, '1', 'category_name', '产品分类名称', 'varchar(64)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:02');

-- ----------------------------
-- Table structure for iot_alert
-- ----------------------------
DROP TABLE IF EXISTS `iot_alert`;
CREATE TABLE `iot_alert`  (
  `alert_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '告警ID',
  `alert_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警名称',
  `alert_level` tinyint(11) NOT NULL COMMENT '告警级别（1=提醒通知，2=轻微问题，3=严重警告）',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `actions` json NOT NULL COMMENT '执行动作',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '告警状态（1-启动，2-停止）',
  `message_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息通知类型[1,2,3]，1=设备告警，2=短信通知，3=移动端推送',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`alert_id`) USING BTREE,
  INDEX `iot_alert_index_product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备告警' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_alert
-- ----------------------------
INSERT INTO `iot_alert` VALUES (49, '设备告警测试', 1, 41, '温湿度智能开关', '[{\"id\": \"switch\", \"name\": \"设备开关\", \"type\": 2, \"value\": \"1\", \"productId\": 41, \"productName\": \"温湿度智能开关\"}, {\"id\": \"gear\", \"name\": \"运行档位\", \"type\": 2, \"value\": \"1\", \"productId\": 41, \"productName\": \"温湿度智能开关\"}]', 1, '1,2,3', '', '2022-11-03 13:26:53', '', NULL, NULL);

-- ----------------------------
-- Table structure for iot_alert_log
-- ----------------------------
DROP TABLE IF EXISTS `iot_alert_log`;
CREATE TABLE `iot_alert_log`  (
  `alert_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '告警ID',
  `alert_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警名称',
  `alert_level` tinyint(11) NOT NULL COMMENT '告警级别（1=提醒通知，2=轻微问题，3=严重警告）',
  `status` tinyint(11) NOT NULL COMMENT '处理状态(1=不需要处理,2=未处理,3=已处理)',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备编号',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `detail` json NULL COMMENT '告警详情（对应物模型）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`alert_log_id`) USING BTREE,
  INDEX `iot_alert_log_index_serial_number`(`serial_number`) USING BTREE,
  INDEX `iot_alert_log_index_product_id`(`product_id`) USING BTREE,
  INDEX `iot_alert_log_index_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备告警日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_alert_log
-- ----------------------------

-- ----------------------------
-- Table structure for iot_alert_trigger
-- ----------------------------
DROP TABLE IF EXISTS `iot_alert_trigger`;
CREATE TABLE `iot_alert_trigger`  (
  `alert_trigger_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '告警触发器ID',
  `alert_id` bigint(20) NOT NULL COMMENT '场景ID',
  `status` tinyint(1) NOT NULL COMMENT '告警状态（1-启动，2-停止）',
  `source` tinyint(1) NOT NULL COMMENT '触发源（1=设备触发，2=定时触发）',
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型标识符',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型名称',
  `value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型值',
  `operator` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作符',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '物模型类别（1=属性，2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线）',
  `product_id` bigint(20) NULL DEFAULT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `job_id` bigint(20) NULL DEFAULT NULL COMMENT '任务ID',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `is_advance` tinyint(1) NULL DEFAULT NULL COMMENT '是否详细corn表达式（1=是，0=否）',
  PRIMARY KEY (`alert_trigger_id`) USING BTREE,
  INDEX `iot_alert_trigger_index_alert_id`(`alert_id`) USING BTREE,
  INDEX `iot_alert_trigger_index_product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 198 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '告警触发器' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_alert_trigger
-- ----------------------------
INSERT INTO `iot_alert_trigger` VALUES (193, 49, 1, 1, 'temperature', '空气温度', '60', '>', 1, 41, '温湿度智能开关', 0, '', 0);
INSERT INTO `iot_alert_trigger` VALUES (194, 49, 1, 1, 'humidity', '空气湿度', '70', '>=', 1, 41, '温湿度智能开关', 0, '', 0);

-- ----------------------------
-- Table structure for iot_category
-- ----------------------------
DROP TABLE IF EXISTS `iot_category`;
CREATE TABLE `iot_category`  (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '产品分类ID',
  `category_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品分类名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否系统通用（0-否，1-是）',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父级ID',
  `order_num` int(4) NULL DEFAULT NULL COMMENT '显示顺序',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `iot_category_index_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_category_index_parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_category
-- ----------------------------
INSERT INTO `iot_category` VALUES (1, '电工照明', 1, 'admin', 1, 0, 1, '0', '', '2022-03-01 11:44:37', '', '2022-06-07 12:56:37', '例如：通断器、开关、插座、窗帘、灯');
INSERT INTO `iot_category` VALUES (2, '家居安防', 1, 'admin', 1, 0, 2, '0', '', '2021-12-18 14:46:52', '', '2021-12-18 14:49:48', '例如：智能门锁、摄像头、智能窗帘');
INSERT INTO `iot_category` VALUES (3, '环境电器', 1, 'admin', 1, 0, 3, '0', '', '2021-12-18 14:50:24', '', '2022-06-07 12:56:34', '例如：加湿器、风扇、扫地机器人');
INSERT INTO `iot_category` VALUES (4, '大家电', 1, 'admin', 1, 0, 4, '0', '', '2021-12-18 14:50:58', '', '2021-12-18 14:52:30', '例如：冰箱、热水器、电视');
INSERT INTO `iot_category` VALUES (5, '厨房电器', 1, 'admin', 1, 0, 5, '0', '', '2021-12-18 14:51:42', '', '2021-12-18 14:52:35', '例如：油烟机、烤箱、电饭煲');
INSERT INTO `iot_category` VALUES (6, '个护健康', 1, 'admin', 1, 0, 6, '0', '', '2021-12-18 14:52:15', '', '2021-12-18 14:52:40', '例如：洗衣机、按摩椅');
INSERT INTO `iot_category` VALUES (7, '其他', 1, 'admin', 1, 0, 7, '0', '', '2021-12-18 14:52:54', '', '2021-12-20 15:04:33', '其他');

-- ----------------------------
-- Table structure for iot_device
-- ----------------------------
DROP TABLE IF EXISTS `iot_device`;
CREATE TABLE `iot_device`  (
  `device_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备编号',
  `firmware_version` float(11, 2) NOT NULL COMMENT '固件版本',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '设备状态（1-未激活，2-禁用，3-在线，4-离线）',
  `rssi` tinyint(11) NULL DEFAULT NULL COMMENT '信号强度（\r\n信号极好4格[-55— 0]，\r\n信号好3格[-70— -55]，\r\n信号一般2格[-85— -70]，\r\n信号差1格[-100— -85]）',
  `is_shadow` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用设备影子(0=禁用，1=启用)',
  `location_way` tinyint(1) NULL DEFAULT NULL COMMENT '定位方式(1=ip自动定位，2=设备定位，3=自定义)',
  `things_model_value` json NULL COMMENT '物模型值',
  `network_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备所在地址',
  `network_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备入网IP',
  `longitude` double(11, 6) NULL DEFAULT NULL COMMENT '设备经度',
  `latitude` double(11, 6) NULL DEFAULT NULL COMMENT '设备纬度',
  `active_time` datetime(0) NULL DEFAULT NULL COMMENT '激活时间',
  `summary` json NULL COMMENT '设备摘要，格式[{\"name\":\"device\"},{\"chip\":\"esp8266\"}]',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_id`) USING BTREE,
  UNIQUE INDEX `iot_device_index_serial_number`(`serial_number`) USING BTREE,
  INDEX `iot_device_index_product_id`(`product_id`) USING BTREE,
  INDEX `iot_device_index_tanant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_device_index_user_id`(`user_id`) USING BTREE,
  INDEX `iot_device_index_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device
-- ----------------------------
INSERT INTO `iot_device` VALUES (100, '★监控设备', 94, 'DH-3H3205-ADW', 1, 'admin', 1, 'admin', '13030300001170000008', 1.00, 3, 0, 0, 1, '[]', ' 本机地址', '183.225.206.92', NULL, NULL, '2023-02-25 00:00:00', '{\"port\": 9862, \"firmware\": \"2.810.0000027.0.R,2022-08-26\", \"transport\": \"UDP\", \"streammode\": \"UDP\", \"hostaddress\": \"183.225.206.92:9862\", \"manufacturer\": \"Dahua\"}', NULL, '0', '', '2025-02-25 17:59:44', '', '2023-02-26 23:35:49', NULL);
INSERT INTO `iot_device` VALUES (108, '★温湿度开关', 41, '智能开关', 1, 'admin', 1, 'admin', 'D1ELV3A5TOJS', 1.00, 3, -51, 1, 1, NULL, '云南省曲靖市 移通', '183.225.206.92', 103.802435, 25.496407, '2023-02-26 01:11:17', '{\"chip\": \"esp8266\", \"name\": \"wumei-smart\", \"author\": \"kerwincui\", \"create\": \"2022-06-06\", \"version\": 1.6}', NULL, '0', '', '2025-02-25 23:15:56', '', '2023-02-26 12:32:48', NULL);
INSERT INTO `iot_device` VALUES (109, '★网关设备', 96, '网关产品', 1, 'admin', 1, 'admin', 'D1PGLPG58KZ2', 1.00, 3, -52, 1, 3, '[{\"id\": \"temperature\", \"name\": \"空气温度\", \"value\": \"18.05\", \"shadow\": \"18.05\", \"isMonitor\": 1}, {\"id\": \"device_co2\", \"name\": \"二氧化碳\", \"value\": \"3913,3012,4964,5098,3275\", \"shadow\": \"3913,3012,4964,5098,3275\", \"isMonitor\": 1}, {\"id\": \"category_switch\", \"name\": \"设备开关\", \"value\": \"1\", \"shadow\": \"1\", \"isMonitor\": 0}, {\"id\": \"category_temperature\", \"name\": \"空气温度-只读\", \"value\": \"20\", \"shadow\": \"20\", \"isMonitor\": 0}, {\"id\": \"light_color\", \"name\": \"灯光色值\", \"value\": \" 100, 50, 80\", \"shadow\": \" 100, 50, 80\", \"isMonitor\": 0}, {\"id\": \"category_report_monitor\", \"name\": \"上报监测数据\", \"value\": \"5\", \"shadow\": \"5\", \"isMonitor\": 0}, {\"id\": \"switch\", \"name\": \"设备开关\", \"value\": \"1\", \"shadow\": \"1\", \"isMonitor\": 0}, {\"id\": \"device_report_monitor\", \"name\": \"上报监测数据\", \"value\": \" 5, 3, 3, 5, 5\", \"shadow\": \" 5, 3, 3, 5, 5\", \"isMonitor\": 0}, {\"id\": \"category_humidity\", \"name\": \"空气湿度\", \"value\": \"32\", \"shadow\": \"32\", \"isMonitor\": 1}, {\"id\": \"device_switch\", \"name\": \"设备开关\", \"value\": \"1, ,1, , \", \"shadow\": \"1, ,1, , \", \"isMonitor\": 0}, {\"id\": \"category_light\", \"name\": \"光照\", \"value\": \"64\", \"shadow\": \"64\", \"isMonitor\": 1}, {\"id\": \"category_gear\", \"name\": \"运行档位\", \"value\": \"1\", \"shadow\": \"1\", \"isMonitor\": 0}, {\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"value\": \"3\", \"shadow\": \"3\", \"isMonitor\": 0}, {\"id\": \"gear\", \"name\": \"运行档位\", \"value\": \"3\", \"shadow\": \"3\", \"isMonitor\": 0}, {\"id\": \"device_gear\", \"name\": \"运行档位\", \"value\": \"1,0,0, ,1\", \"shadow\": \"1,0,0,1,1\", \"isMonitor\": 0}, {\"id\": \"device_temperature\", \"name\": \"空气温度-只读\", \"value\": \"56,68,33,26,27\", \"shadow\": \"56,68,33,26,27\", \"isMonitor\": 0}, {\"id\": \"brightness\", \"name\": \"室内亮度\", \"value\": \"5430\", \"shadow\": \"5430\", \"isMonitor\": 1}, {\"id\": \"reset\", \"name\": \"设备重启\", \"value\": \"restart\", \"shadow\": \"restart\", \"isMonitor\": 0}, {\"id\": \"message\", \"name\": \"屏显消息\", \"value\": \"FastBee\", \"shadow\": \"FastBee\", \"isMonitor\": 0}]', '云南省曲靖市 移通', '183.225.206.92', 104.802435, 26.496407, '2023-02-26 00:00:00', '{\"chip\": \"esp8266\", \"name\": \"wumei-smart\", \"author\": \"kerwincui\", \"create\": \"2022-06-06\", \"version\": 1.6}', NULL, '0', '', '2025-02-25 23:17:31', '', '2023-02-26 21:51:26', NULL);

-- ----------------------------
-- Table structure for iot_device_group
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_group`;
CREATE TABLE `iot_device_group`  (
  `device_id` bigint(20) NOT NULL COMMENT '设备ID',
  `group_id` bigint(20) NOT NULL COMMENT '分组ID',
  PRIMARY KEY (`device_id`, `group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_group
-- ----------------------------

-- ----------------------------
-- Table structure for iot_device_job
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_job`;
CREATE TABLE `iot_device_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  `device_id` bigint(20) NULL DEFAULT NULL COMMENT '设备ID',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编号',
  `device_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `is_advance` tinyint(1) NULL DEFAULT NULL COMMENT '是否详细corn表达式（1=是，0=否）',
  `actions` json NULL COMMENT '执行的动作集合',
  `job_type` tinyint(1) NULL DEFAULT NULL COMMENT '任务类型（1=设备定时，2=设备告警，3=场景联动）',
  `product_id` bigint(20) NULL DEFAULT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `scene_id` bigint(20) NULL DEFAULT NULL COMMENT '场景联动ID',
  `alert_id` bigint(20) NULL DEFAULT NULL COMMENT '告警ID',
  `alert_trigger` json NULL COMMENT '定时告警触发器',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE,
  INDEX `iot_device_job_index_device_id`(`device_id`) USING BTREE,
  INDEX `iot_device_job_index_product_id`(`product_id`) USING BTREE,
  INDEX `iot_device_job_index_scene_id`(`scene_id`) USING BTREE,
  INDEX `iot_device_job_index_alert_id`(`alert_id`) USING BTREE,
  INDEX `iot_device_job_index_serial_number`(`serial_number`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备定时' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_job
-- ----------------------------

-- ----------------------------
-- Table structure for iot_device_log
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_log`;
CREATE TABLE `iot_device_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备日志ID',
  `identity` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符',
  `log_type` tinyint(1) NOT NULL COMMENT '类型（1=属性上报，2=调用功能，3=事件上报，4=设备升级，5=设备上线，6=设备离线）',
  `log_value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日志值',
  `device_id` bigint(20) NULL DEFAULT NULL COMMENT '设备ID',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编号',
  `is_monitor` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否监测数据（1=是，0=否）',
  `mode` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '模式(1=影子模式，2=在线模式，3=其他)',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `tenant_id` bigint(20) NULL DEFAULT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '租户名称',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `iot_device_log_index_serial_number`(`serial_number`) USING BTREE,
  INDEX `iot_device_log_index_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_device_log_index_user_id`(`user_id`) USING BTREE,
  INDEX `iot_device_log_index_device_id`(`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 342016 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_log
-- ----------------------------
INSERT INTO `iot_device_log` VALUES (341491, 'height_temperature', 3, '40', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:41', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341492, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:41', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341493, 'height_temperature', 3, '40', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:57', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341494, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:57', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341495, 'temperature', 1, '19.85', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:57', '68914245');
INSERT INTO `iot_device_log` VALUES (341496, 'humidity', 1, '33.23', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:57', '68914245');
INSERT INTO `iot_device_log` VALUES (341497, 'co2', 1, '880', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:57', '68914245');
INSERT INTO `iot_device_log` VALUES (341498, 'brightness', 1, '8511', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:57', '68914245');
INSERT INTO `iot_device_log` VALUES (341499, 'height_temperature', 3, '40', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341500, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341501, 'temperature', 1, '12.22', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370858');
INSERT INTO `iot_device_log` VALUES (341502, 'brightness', 1, '4587', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370858');
INSERT INTO `iot_device_log` VALUES (341503, 'category_light', 1, '21', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370858');
INSERT INTO `iot_device_log` VALUES (341504, 'category_humidity', 1, '29', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370858');
INSERT INTO `iot_device_log` VALUES (341505, 'category_temperature', 1, '57', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370858');
INSERT INTO `iot_device_log` VALUES (341506, 'array_00_device_co2', 1, '1797', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370858');
INSERT INTO `iot_device_log` VALUES (341507, 'array_00_device_temperature', 1, '73', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370858');
INSERT INTO `iot_device_log` VALUES (341508, 'array_01_device_co2', 1, '3222', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370858');
INSERT INTO `iot_device_log` VALUES (341509, 'array_01_device_temperature', 1, '89', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370858');
INSERT INTO `iot_device_log` VALUES (341510, 'array_02_device_co2', 1, '4895', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370859');
INSERT INTO `iot_device_log` VALUES (341511, 'array_02_device_temperature', 1, '41', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370859');
INSERT INTO `iot_device_log` VALUES (341512, 'array_03_device_co2', 1, '4160', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370859');
INSERT INTO `iot_device_log` VALUES (341513, 'array_03_device_temperature', 1, '20', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370859');
INSERT INTO `iot_device_log` VALUES (341514, 'array_04_device_co2', 1, '1479', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', '68370859');
INSERT INTO `iot_device_log` VALUES (341515, 'array_04_device_temperature', 1, '35', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:21:58', NULL);
INSERT INTO `iot_device_log` VALUES (341516, 'height_temperature', 3, '40', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:41', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341517, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:41', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341518, 'height_temperature', 3, '40', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:57', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341519, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:57', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341520, 'temperature', 1, '17.48', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:57', '68974246');
INSERT INTO `iot_device_log` VALUES (341521, 'humidity', 1, '47.89', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:57', '68974246');
INSERT INTO `iot_device_log` VALUES (341522, 'co2', 1, '583', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:57', '68974246');
INSERT INTO `iot_device_log` VALUES (341523, 'brightness', 1, '2014', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:57', '68974246');
INSERT INTO `iot_device_log` VALUES (341524, 'height_temperature', 3, '40', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341525, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341526, 'temperature', 1, '10.01', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430859');
INSERT INTO `iot_device_log` VALUES (341527, 'brightness', 1, '6760', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430859');
INSERT INTO `iot_device_log` VALUES (341528, 'category_light', 1, '51', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430859');
INSERT INTO `iot_device_log` VALUES (341529, 'category_humidity', 1, '83', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430859');
INSERT INTO `iot_device_log` VALUES (341530, 'category_temperature', 1, '50', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430859');
INSERT INTO `iot_device_log` VALUES (341531, 'array_00_device_co2', 1, '2954', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430859');
INSERT INTO `iot_device_log` VALUES (341532, 'array_00_device_temperature', 1, '29', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430859');
INSERT INTO `iot_device_log` VALUES (341533, 'array_01_device_co2', 1, '1657', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430859');
INSERT INTO `iot_device_log` VALUES (341534, 'array_01_device_temperature', 1, '3', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430859');
INSERT INTO `iot_device_log` VALUES (341535, 'array_02_device_co2', 1, '772', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430860');
INSERT INTO `iot_device_log` VALUES (341536, 'array_02_device_temperature', 1, '82', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430860');
INSERT INTO `iot_device_log` VALUES (341537, 'array_03_device_co2', 1, '1980', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430860');
INSERT INTO `iot_device_log` VALUES (341538, 'array_03_device_temperature', 1, '3', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430860');
INSERT INTO `iot_device_log` VALUES (341539, 'array_04_device_co2', 1, '3951', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', '68430860');
INSERT INTO `iot_device_log` VALUES (341540, 'array_04_device_temperature', 1, '76', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:22:58', NULL);
INSERT INTO `iot_device_log` VALUES (341541, 'height_temperature', 3, '40', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:41', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341542, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:41', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341543, 'height_temperature', 3, '40', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:57', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341544, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:57', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341545, 'temperature', 1, '22.43', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:57', '69034247');
INSERT INTO `iot_device_log` VALUES (341546, 'humidity', 1, '47.66', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:57', '69034247');
INSERT INTO `iot_device_log` VALUES (341547, 'co2', 1, '500', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:57', '69034247');
INSERT INTO `iot_device_log` VALUES (341548, 'brightness', 1, '8646', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:57', '69034247');
INSERT INTO `iot_device_log` VALUES (341549, 'height_temperature', 3, '40', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341550, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341551, 'temperature', 1, '16.51', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490860');
INSERT INTO `iot_device_log` VALUES (341552, 'brightness', 1, '4947', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490860');
INSERT INTO `iot_device_log` VALUES (341553, 'category_light', 1, '53', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490860');
INSERT INTO `iot_device_log` VALUES (341554, 'category_humidity', 1, '95', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490860');
INSERT INTO `iot_device_log` VALUES (341555, 'category_temperature', 1, '79', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490860');
INSERT INTO `iot_device_log` VALUES (341556, 'array_00_device_co2', 1, '5069', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490860');
INSERT INTO `iot_device_log` VALUES (341557, 'array_00_device_temperature', 1, '97', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490860');
INSERT INTO `iot_device_log` VALUES (341558, 'array_01_device_co2', 1, '3221', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490860');
INSERT INTO `iot_device_log` VALUES (341559, 'array_01_device_temperature', 1, '99', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490861');
INSERT INTO `iot_device_log` VALUES (341560, 'array_02_device_co2', 1, '5537', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490861');
INSERT INTO `iot_device_log` VALUES (341561, 'array_02_device_temperature', 1, '81', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490861');
INSERT INTO `iot_device_log` VALUES (341562, 'array_03_device_co2', 1, '4389', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490861');
INSERT INTO `iot_device_log` VALUES (341563, 'array_03_device_temperature', 1, '68', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490861');
INSERT INTO `iot_device_log` VALUES (341564, 'array_04_device_co2', 1, '5371', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', '68490861');
INSERT INTO `iot_device_log` VALUES (341565, 'array_04_device_temperature', 1, '7', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:23:58', NULL);
INSERT INTO `iot_device_log` VALUES (341566, 'height_temperature', 3, '40', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:41', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341567, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:41', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341568, 'height_temperature', 3, '40', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:57', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341569, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:57', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341570, 'temperature', 1, '22.75', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:57', '69094248');
INSERT INTO `iot_device_log` VALUES (341571, 'humidity', 1, '49.99', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:57', '69094248');
INSERT INTO `iot_device_log` VALUES (341572, 'co2', 1, '595', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:57', '69094248');
INSERT INTO `iot_device_log` VALUES (341573, 'brightness', 1, '6875', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:57', '69094248');
INSERT INTO `iot_device_log` VALUES (341574, 'height_temperature', 3, '40', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341575, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341576, 'temperature', 1, '14.71', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550861');
INSERT INTO `iot_device_log` VALUES (341577, 'brightness', 1, '1558', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550861');
INSERT INTO `iot_device_log` VALUES (341578, 'category_light', 1, '37', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550861');
INSERT INTO `iot_device_log` VALUES (341579, 'category_humidity', 1, '41', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550861');
INSERT INTO `iot_device_log` VALUES (341580, 'category_temperature', 1, '62', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550861');
INSERT INTO `iot_device_log` VALUES (341581, 'array_00_device_co2', 1, '2726', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550861');
INSERT INTO `iot_device_log` VALUES (341582, 'array_00_device_temperature', 1, '14', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550861');
INSERT INTO `iot_device_log` VALUES (341583, 'array_01_device_co2', 1, '445', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550861');
INSERT INTO `iot_device_log` VALUES (341584, 'array_01_device_temperature', 1, '17', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550861');
INSERT INTO `iot_device_log` VALUES (341585, 'array_02_device_co2', 1, '5280', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550862');
INSERT INTO `iot_device_log` VALUES (341586, 'array_02_device_temperature', 1, '84', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550862');
INSERT INTO `iot_device_log` VALUES (341587, 'array_03_device_co2', 1, '3996', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550862');
INSERT INTO `iot_device_log` VALUES (341588, 'array_03_device_temperature', 1, '76', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550862');
INSERT INTO `iot_device_log` VALUES (341589, 'array_04_device_co2', 1, '2541', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', '68550862');
INSERT INTO `iot_device_log` VALUES (341590, 'array_04_device_temperature', 1, '13', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:24:58', NULL);
INSERT INTO `iot_device_log` VALUES (341591, 'height_temperature', 3, '40', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:41', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341592, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:41', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341593, 'height_temperature', 3, '40', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:57', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341594, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:57', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341595, 'temperature', 1, '14.58', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:57', '69154249');
INSERT INTO `iot_device_log` VALUES (341596, 'humidity', 1, '54.91', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:57', '69154249');
INSERT INTO `iot_device_log` VALUES (341597, 'co2', 1, '414', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:57', '69154249');
INSERT INTO `iot_device_log` VALUES (341598, 'brightness', 1, '6321', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:57', '69154249');
INSERT INTO `iot_device_log` VALUES (341599, 'height_temperature', 3, '40', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341600, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341601, 'temperature', 1, '23.91', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610862');
INSERT INTO `iot_device_log` VALUES (341602, 'brightness', 1, '1430', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610862');
INSERT INTO `iot_device_log` VALUES (341603, 'category_light', 1, '29', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610862');
INSERT INTO `iot_device_log` VALUES (341604, 'category_humidity', 1, '29', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610862');
INSERT INTO `iot_device_log` VALUES (341605, 'category_temperature', 1, '34', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610862');
INSERT INTO `iot_device_log` VALUES (341606, 'array_00_device_co2', 1, '3346', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610862');
INSERT INTO `iot_device_log` VALUES (341607, 'array_00_device_temperature', 1, '74', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610862');
INSERT INTO `iot_device_log` VALUES (341608, 'array_01_device_co2', 1, '3038', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610862');
INSERT INTO `iot_device_log` VALUES (341609, 'array_01_device_temperature', 1, '17', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610863');
INSERT INTO `iot_device_log` VALUES (341610, 'array_02_device_co2', 1, '5815', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610863');
INSERT INTO `iot_device_log` VALUES (341611, 'array_02_device_temperature', 1, '88', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610863');
INSERT INTO `iot_device_log` VALUES (341612, 'array_03_device_co2', 1, '3706', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610863');
INSERT INTO `iot_device_log` VALUES (341613, 'array_03_device_temperature', 1, '11', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610863');
INSERT INTO `iot_device_log` VALUES (341614, 'array_04_device_co2', 1, '2659', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', '68610863');
INSERT INTO `iot_device_log` VALUES (341615, 'array_04_device_temperature', 1, '81', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:25:58', NULL);
INSERT INTO `iot_device_log` VALUES (341616, 'height_temperature', 3, '40', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:41', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341617, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:41', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341618, 'height_temperature', 3, '40', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:57', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341619, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1ELV3A5TOJS', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:57', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341620, 'temperature', 1, '25.40', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:57', '69214250');
INSERT INTO `iot_device_log` VALUES (341621, 'humidity', 1, '53.82', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:57', '69214250');
INSERT INTO `iot_device_log` VALUES (341622, 'co2', 1, '425', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:57', '69214250');
INSERT INTO `iot_device_log` VALUES (341623, 'brightness', 1, '3153', NULL, NULL, 'D1ELV3A5TOJS', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:57', '69214250');
INSERT INTO `iot_device_log` VALUES (341624, 'height_temperature', 3, '40', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '温度过高警告');
INSERT INTO `iot_device_log` VALUES (341625, 'exception', 3, '异常消息，消息内容XXXXXXXX', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '设备发生错误');
INSERT INTO `iot_device_log` VALUES (341626, 'temperature', 1, '10.16', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670863');
INSERT INTO `iot_device_log` VALUES (341627, 'brightness', 1, '5156', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670863');
INSERT INTO `iot_device_log` VALUES (341628, 'category_light', 1, '92', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670863');
INSERT INTO `iot_device_log` VALUES (341629, 'category_humidity', 1, '59', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670863');
INSERT INTO `iot_device_log` VALUES (341630, 'category_temperature', 1, '57', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670863');
INSERT INTO `iot_device_log` VALUES (341631, 'array_00_device_co2', 1, '3604', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670863');
INSERT INTO `iot_device_log` VALUES (341632, 'array_00_device_temperature', 1, '89', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670863');
INSERT INTO `iot_device_log` VALUES (341633, 'array_01_device_co2', 1, '2656', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670864');
INSERT INTO `iot_device_log` VALUES (341634, 'array_01_device_temperature', 1, '66', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670864');
INSERT INTO `iot_device_log` VALUES (341635, 'array_02_device_co2', 1, '1271', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670864');
INSERT INTO `iot_device_log` VALUES (341636, 'array_02_device_temperature', 1, '51', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670864');
INSERT INTO `iot_device_log` VALUES (341637, 'array_03_device_co2', 1, '1034', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670864');
INSERT INTO `iot_device_log` VALUES (341638, 'array_03_device_temperature', 1, '64', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670864');
INSERT INTO `iot_device_log` VALUES (341639, 'array_04_device_co2', 1, '1231', NULL, NULL, 'D1PGLPG58KZ2', 1, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', '68670864');
INSERT INTO `iot_device_log` VALUES (341640, 'array_04_device_temperature', 1, '18', NULL, NULL, 'D1PGLPG58KZ2', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:26:58', NULL);
INSERT INTO `iot_device_log` VALUES (341641, 'height_temperature', 3, '40', NULL, NULL, 'D9329VL54419L1Y0', 0, 2, NULL, '', NULL, '', '', '2023-02-26 23:27:41', '温度过高警告');

-- ----------------------------
-- Table structure for iot_device_user
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_user`;
CREATE TABLE `iot_device_user`  (
  `device_id` bigint(20) NOT NULL COMMENT '设备ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `is_owner` tinyint(11) NOT NULL COMMENT '是否为设备所有者（0=否，1=是）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_id`, `user_id`) USING BTREE,
  INDEX `iot_device_user_index_user_id`(`user_id`) USING BTREE,
  INDEX `iot_device_user_index_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_user
-- ----------------------------
INSERT INTO `iot_device_user` VALUES (100, 1, 1, 'admin', '监控设备', '15888888888', 'admin', 1, '0', '', '2023-02-25 17:59:45', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (108, 1, 1, 'admin', '温湿度开关', '15888888888', 'admin', 1, '0', '', '2023-02-25 23:15:57', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (109, 1, 1, 'admin', '网关设备', '15888888888', 'admin', 1, '0', '', '2023-02-25 23:17:32', '', NULL, NULL);

-- ----------------------------
-- Table structure for iot_firmware
-- ----------------------------
DROP TABLE IF EXISTS `iot_firmware`;
CREATE TABLE `iot_firmware`  (
  `firmware_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '固件ID',
  `firmware_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '固件名称',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否系统通用（0-否，1-是）',
  `is_latest` tinyint(1) NOT NULL COMMENT '是否最新版本（0-否，1-是）',
  `version` float(11, 2) NOT NULL DEFAULT 0.10 COMMENT '固件版本',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件路径',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`firmware_id`) USING BTREE,
  INDEX `iot_firmware_index_product_id`(`product_id`) USING BTREE,
  INDEX `iot_firmware_index_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品固件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_firmware
-- ----------------------------
INSERT INTO `iot_firmware` VALUES (1, '智能开关固件', 41, '温湿度智能开关', 6, 'wumei', 1, 1, 1.00, '/profile/iot/1/2023-0226-143855.bin', '0', '', '2023-02-24 00:38:26', '', '2023-02-26 23:14:52', '测试固件');

-- ----------------------------
-- Table structure for iot_firmware_task
-- ----------------------------
DROP TABLE IF EXISTS `iot_firmware_task`;
CREATE TABLE `iot_firmware_task`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `task_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `firmware_id` bigint(20) UNSIGNED NOT NULL COMMENT '关联固件ID',
  `upgrade_type` int(11) NOT NULL DEFAULT 1 COMMENT '1:指定设备 2:产品级别',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `task_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `device_amount` int(11) NOT NULL DEFAULT 0 COMMENT '选中的设备总数',
  `del_flag` int(11) NOT NULL DEFAULT 0,
  `book_time` timestamp(0) NULL DEFAULT NULL COMMENT '预定时间升级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_firmware_task
-- ----------------------------

-- ----------------------------
-- Table structure for iot_firmware_task_detail
-- ----------------------------
DROP TABLE IF EXISTS `iot_firmware_task_detail`;
CREATE TABLE `iot_firmware_task_detail`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `serial_number` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '设备编码',
  `upgrade_status` int(11) NOT NULL DEFAULT 0 COMMENT '0:等待升级 1:已发送设备 2:设备收到  3:升级成功 4:升级失败',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `detail_msg` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `message_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '消息ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UNI`(`message_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_firmware_task_detail
-- ----------------------------

-- ----------------------------
-- Table structure for iot_goview_project
-- ----------------------------
DROP TABLE IF EXISTS `iot_goview_project`;
CREATE TABLE `iot_goview_project`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `project_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目名称',
  `state` int(1) NOT NULL DEFAULT 0 COMMENT '项目状态[0未发布,1发布]',
  `index_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首页图片',
  `del_flag` int(11) NOT NULL DEFAULT 0 COMMENT '删除状态[1删除,-1未删除]',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目介绍',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_goview_project
-- ----------------------------
INSERT INTO `iot_goview_project` VALUES ('114ab733f2b94d44898919a96abe583b', '4rmddu4osas000', 1, '/profile/goview/1/114ab733f2b94d44898919a96abe583b_index_preview.png', 0, '2023-02-26 14:07:36', '6', '2023-02-26 23:11:41', NULL);
INSERT INTO `iot_goview_project` VALUES ('f112e56eee4a4a0fae3e9ec9b3083eab', '3oa3qdszoug000', 0, NULL, 1, '2023-02-26 12:12:34', '6', '2023-02-26 12:12:34', NULL);

-- ----------------------------
-- Table structure for iot_goview_project_data
-- ----------------------------
DROP TABLE IF EXISTS `iot_goview_project_data`;
CREATE TABLE `iot_goview_project_data`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `project_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目id',
  `content` longblob NULL COMMENT '存储数据',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目数据关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_goview_project_data
-- ----------------------------
INSERT INTO `iot_goview_project_data` VALUES ('a2a1cbd6a1944aa4a6f332b58650dc5c', '114ab733f2b94d44898919a96abe583b', 0x7B226564697443616E766173436F6E666967223A7B227769647468223A313932302C22686569676874223A313038302C2266696C74657253686F77223A66616C73652C22687565526F74617465223A302C227361747572617465223A312C22636F6E7472617374223A312C226272696768746E657373223A312C226F706163697479223A312C22726F746174655A223A302C22726F7461746558223A302C22726F7461746559223A302C22736B657758223A302C22736B657759223A302C22626C656E644D6F6465223A226E6F726D616C222C2273656C656374436F6C6F72223A747275652C2263686172745468656D65436F6C6F72223A226461726B222C2263686172745468656D6553657474696E67223A7B227469746C65223A7B2273686F77223A747275652C22746578745374796C65223A7B22636F6C6F72223A2223424642464246222C22666F6E7453697A65223A31387D2C22737562746578745374796C65223A7B22636F6C6F72223A2223413241324132222C22666F6E7453697A65223A31347D7D2C227841786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A22626F74746F6D222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A66616C73652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22736F6C6964227D7D7D2C227941786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A226C656674222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22736F6C6964227D7D7D2C226C6567656E64223A7B2273686F77223A747275652C22746F70223A223525222C22746578745374796C65223A7B22636F6C6F72223A2223423942384345227D7D2C2267726964223A7B2273686F77223A66616C73652C226C656674223A22313025222C22746F70223A223630222C227269676874223A22313025222C22626F74746F6D223A223630227D2C2264617461736574223A6E756C6C7D2C22707265766965775363616C6554797065223A22666974227D2C22636F6D706F6E656E744C697374223A5B7B226964223A2231643673376D35746B6170733030222C22697347726F7570223A66616C73652C2261747472223A7B2278223A36302C2279223A36312C2277223A3530302C2268223A3330302C226F666673657458223A302C226F666673657459223A302C227A496E646578223A2D317D2C227374796C6573223A7B2266696C74657253686F77223A66616C73652C22687565526F74617465223A302C227361747572617465223A312C22636F6E7472617374223A312C226272696768746E657373223A312C226F706163697479223A312C22726F746174655A223A302C22726F7461746558223A302C22726F7461746559223A302C22736B657758223A302C22736B657759223A302C22626C656E644D6F6465223A226E6F726D616C222C22616E696D6174696F6E73223A5B5D7D2C22737461747573223A7B226C6F636B223A66616C73652C2268696465223A66616C73657D2C2272657175657374223A7B22726571756573744461746154797065223A302C22726571756573744874747054797065223A22676574222C227265717565737455726C223A22222C2272657175657374496E74657276616C556E6974223A227365636F6E64222C2272657175657374436F6E74656E7454797065223A302C2272657175657374506172616D73426F647954797065223A226E6F6E65222C227265717565737453514C436F6E74656E74223A7B2273716C223A2273656C656374202A2066726F6D20207768657265227D2C2272657175657374506172616D73223A7B22426F6479223A7B22666F726D2D64617461223A7B7D2C22782D7777772D666F726D2D75726C656E636F646564223A7B7D2C226A736F6E223A22222C22786D6C223A22227D2C22486561646572223A7B7D2C22506172616D73223A7B7D7D7D2C226B6579223A22426172436F6D6D6F6E222C226368617274436F6E666967223A7B226B6579223A22426172436F6D6D6F6E222C2263686172744B6579223A2256426172436F6D6D6F6E222C22636F6E4B6579223A225643426172436F6D6D6F6E222C227469746C65223A22E69FB1E78AB6E59BBE222C2263617465676F7279223A2242617273222C2263617465676F72794E616D65223A22E69FB1E78AB6E59BBE222C227061636B616765223A22436861727473222C2263686172744672616D65223A2265636861727473222C22696D616765223A222E2F7374617469632F706E672F6261725F782D36656332386536392E706E67227D2C226F7074696F6E223A7B226C6567656E64223A7B2273686F77223A747275652C22746F70223A223525222C22746578745374796C65223A7B22636F6C6F72223A2223423942384345227D7D2C227841786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A22626F74746F6D222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A66616C73652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22736F6C6964227D7D2C2274797065223A2263617465676F7279227D2C227941786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A226C656674222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22736F6C6964227D7D2C2274797065223A2276616C7565227D2C2267726964223A7B2273686F77223A66616C73652C226C656674223A22313025222C22746F70223A223630222C227269676874223A22313025222C22626F74746F6D223A223630227D2C22746F6F6C746970223A7B2273686F77223A747275652C2274726967676572223A2261786973222C2261786973506F696E746572223A7B2273686F77223A747275652C2274797065223A22736861646F77227D7D2C2264617461736574223A7B2264696D656E73696F6E73223A5B2270726F64756374222C226461746131222C226461746132225D2C22736F75726365223A5B7B2270726F64756374223A224D6F6E222C226461746131223A3132302C226461746132223A3133307D2C7B2270726F64756374223A22547565222C226461746131223A3230302C226461746132223A3133307D2C7B2270726F64756374223A22576564222C226461746131223A3135302C226461746132223A3331327D2C7B2270726F64756374223A22546875222C226461746131223A38302C226461746132223A3236387D2C7B2270726F64756374223A22467269222C226461746131223A37302C226461746132223A3135357D2C7B2270726F64756374223A22536174222C226461746131223A3131302C226461746132223A3131377D2C7B2270726F64756374223A2253756E222C226461746131223A3133302C226461746132223A3136307D5D7D2C22736572696573223A5B7B2274797065223A22626172222C226261725769647468223A31352C226C6162656C223A7B2273686F77223A747275652C22706F736974696F6E223A22746F70222C22636F6C6F72223A2223666666222C22666F6E7453697A65223A31327D2C226974656D5374796C65223A7B22636F6C6F72223A6E756C6C2C22626F72646572526164697573223A327D7D2C7B2274797065223A22626172222C226261725769647468223A31352C226C6162656C223A7B2273686F77223A747275652C22706F736974696F6E223A22746F70222C22636F6C6F72223A2223666666222C22666F6E7453697A65223A31327D2C226974656D5374796C65223A7B22636F6C6F72223A6E756C6C2C22626F72646572526164697573223A327D7D5D2C226261636B67726F756E64436F6C6F72223A227267626128302C302C302C3029227D7D2C7B226964223A22346266626A376A73346F77303030222C22697347726F7570223A66616C73652C2261747472223A7B2278223A3537352E352C2279223A2D3336332C2277223A3830362C2268223A313538332C226F666673657458223A302C226F666673657459223A302C227A496E646578223A2D317D2C227374796C6573223A7B2266696C74657253686F77223A66616C73652C22687565526F74617465223A302C227361747572617465223A312C22636F6E7472617374223A312C226272696768746E657373223A312C226F706163697479223A312C22726F746174655A223A302C22726F7461746558223A302C22726F7461746559223A302C22736B657758223A302C22736B657759223A302C22626C656E644D6F6465223A226E6F726D616C222C22616E696D6174696F6E73223A5B5D7D2C22737461747573223A7B226C6F636B223A66616C73652C2268696465223A66616C73657D2C2272657175657374223A7B22726571756573744461746154797065223A302C22726571756573744874747054797065223A22676574222C227265717565737455726C223A22222C2272657175657374496E74657276616C556E6974223A227365636F6E64222C2272657175657374436F6E74656E7454797065223A302C2272657175657374506172616D73426F647954797065223A226E6F6E65222C227265717565737453514C436F6E74656E74223A7B2273716C223A2273656C656374202A2066726F6D20207768657265227D2C2272657175657374506172616D73223A7B22426F6479223A7B22666F726D2D64617461223A7B7D2C22782D7777772D666F726D2D75726C656E636F646564223A7B7D2C226A736F6E223A22222C22786D6C223A22227D2C22486561646572223A7B7D2C22506172616D73223A7B7D7D7D2C226B6579223A224D617042617365222C226368617274436F6E666967223A7B226B6579223A224D617042617365222C2263686172744B6579223A22564D617042617365222C22636F6E4B6579223A2256434D617042617365222C227469746C65223A22E59CB0E59BBE28E58FAFE98089E79C81E4BBBD29222C2263617465676F7279223A224D617073222C2263617465676F72794E616D65223A22E59CB0E59BBE222C227061636B616765223A22436861727473222C2263686172744672616D65223A22636F6D6D6F6E222C22696D616765223A222E2F7374617469632F706E672F6D61702D66353464636430652E706E67227D2C226F7074696F6E223A7B2264617461736574223A7B22706F696E74223A5B7B226E616D65223A22E58C97E4BAAC222C2276616C7565223A5B3131362E3430353238352C33392E3930343938392C3230305D7D2C7B226E616D65223A22E98391E5B79E222C2276616C7565223A5B3131332E3636353431322C33342E3735373937352C3838385D7D2C7B226E616D65223A22E99D92E6B5B7222C2276616C7565223A5B3130312E3737383931362C33362E3632333137382C3636365D7D2C7B226E616D65223A22E5AE81E5A48FE59B9EE6978FE887AAE6B2BBE58CBA222C2276616C7565223A5B3130362E3237383137392C33382E34363633372C36365D7D2C7B226E616D65223A22E59388E5B094E6BBA8E5B882222C2276616C7565223A5B3132362E3634323436342C34352E3735363936372C3130315D7D5D2C226D6170223A5B7B226E616D65223A22E58C97E4BAACE5B882222C2276616C7565223A3636367D2C7B226E616D65223A22E6B2B3E58C97E79C81222C2276616C7565223A39387D2C7B226E616D65223A22E6B19FE88B8FE79C81222C2276616C7565223A3330307D2C7B226E616D65223A22E7A68FE5BBBAE79C81222C2276616C7565223A313139397D2C7B226E616D65223A22E5B1B1E4B89CE79C81222C2276616C7565223A38367D2C7B226E616D65223A22E6B2B3E58D97E79C81222C2276616C7565223A3835307D2C7B226E616D65223A22E6B996E58C97E79C81222C2276616C7565223A38347D2C7B226E616D65223A22E5B9BFE8A5BFE5A3AEE6978FE887AAE6B2BBE58CBA222C2276616C7565223A38317D2C7B226E616D65223A22E6B5B7E58D97E79C81222C2276616C7565223A3930307D2C7B226E616D65223A22E99D92E6B5B7E79C81222C2276616C7565223A3830307D2C7B226E616D65223A22E696B0E79686E7BBB4E590BEE5B094E887AAE6B2BBE58CBA222C2276616C7565223A377D5D2C22706965636573223A5B7B22677465223A313030302C226C6162656C223A223E31303030227D2C7B22677465223A3630302C226C7465223A3939392C226C6162656C223A223630302D393939227D2C7B22677465223A3230302C226C7465223A3539392C226C6162656C223A223230302D353939227D2C7B22677465223A35302C226C7465223A3139392C226C6162656C223A2234392D313939227D2C7B22677465223A31302C226C7465223A34392C226C6162656C223A2231302D3439227D2C7B226C7465223A392C226C6162656C223A223C39227D5D7D2C226D6170526567696F6E223A7B226164636F6465223A226368696E61222C2273686F774861696E616E49734C616E6473223A747275657D2C22746F6F6C746970223A7B2273686F77223A747275652C2274726967676572223A226974656D227D2C2276697375616C4D6170223A7B2273686F77223A747275652C226F7269656E74223A22766572746963616C222C22706965636573223A5B7B22677465223A313030302C226C6162656C223A223E31303030227D2C7B22677465223A3630302C226C7465223A3939392C226C6162656C223A223630302D393939227D2C7B22677465223A3230302C226C7465223A3539392C226C6162656C223A223230302D353939227D2C7B22677465223A35302C226C7465223A3139392C226C6162656C223A2234392D313939227D2C7B22677465223A31302C226C7465223A34392C226C6162656C223A2231302D3439227D2C7B226C7465223A392C226C6162656C223A223C39227D5D2C22696E52616E6765223A7B22636F6C6F72223A5B2223633364376466222C2223356362336363222C2223386162636431222C2223363661396339222C2223326639306239222C2223313738316235225D7D2C22746578745374796C65223A7B22636F6C6F72223A2223666666227D7D2C2267656F223A7B2273686F77223A66616C73652C2274797065223A226D6170222C22726F616D223A66616C73652C226D6170223A226368696E61222C2273656C65637465644D6F6465223A66616C73652C227A6F6F6D223A317D2C22736572696573223A5B7B226E616D65223A22222C2274797065223A2265666665637453636174746572222C22636F6F7264696E61746553797374656D223A2267656F222C2273796D626F6C53697A65223A342C226C6567656E64486F7665724C696E6B223A747275652C2273686F774566666563744F6E223A2272656E646572222C22726970706C65456666656374223A7B227363616C65223A362C22636F6C6F72223A2223464646464646222C22627275736854797065223A2266696C6C227D2C22746F6F6C746970223A7B2273686F77223A747275652C226261636B67726F756E64436F6C6F72223A227267626128302C302C302C2E3629222C22626F72646572436F6C6F72223A2272676261283134372C203233352C203234382C202E3829222C22746578745374796C65223A7B22636F6C6F72223A2223464646227D7D2C226C6162656C223A7B22666F726D6174746572223A227B627D222C22666F6E7453697A65223A31312C226F6666736574223A5B302C325D2C22706F736974696F6E223A22626F74746F6D222C2274657874426F72646572436F6C6F72223A2223666666222C2274657874536861646F77436F6C6F72223A2223303030222C2274657874536861646F77426C7572223A31302C2274657874426F726465725769647468223A302C22636F6C6F72223A2223464646464646222C2273686F77223A747275657D2C226974656D5374796C65223A7B22636F6C6F72223A2223464646464646222C22626F72646572436F6C6F72223A2272676261283232352C3235352C3235352C3229222C22626F726465725769647468223A342C22736861646F77436F6C6F72223A2223453146464646222C22736861646F77426C7572223A31307D2C2264617461223A5B7B226E616D65223A22E58C97E4BAAC222C2276616C7565223A5B3131362E3430353238352C33392E3930343938392C3230305D7D2C7B226E616D65223A22E98391E5B79E222C2276616C7565223A5B3131332E3636353431322C33342E3735373937352C3838385D7D2C7B226E616D65223A22E99D92E6B5B7222C2276616C7565223A5B3130312E3737383931362C33362E3632333137382C3636365D7D2C7B226E616D65223A22E5AE81E5A48FE59B9EE6978FE887AAE6B2BBE58CBA222C2276616C7565223A5B3130362E3237383137392C33382E34363633372C36365D7D2C7B226E616D65223A22E59388E5B094E6BBA8E5B882222C2276616C7565223A5B3132362E3634323436342C34352E3735363936372C3130315D7D5D7D2C7B226E616D65223A22E58CBAE59F9F222C2274797065223A226D6170222C226D6170223A226368696E61222C2264617461223A5B7B226E616D65223A22E58C97E4BAACE5B882222C2276616C7565223A3636367D2C7B226E616D65223A22E6B2B3E58C97E79C81222C2276616C7565223A39387D2C7B226E616D65223A22E6B19FE88B8FE79C81222C2276616C7565223A3330307D2C7B226E616D65223A22E7A68FE5BBBAE79C81222C2276616C7565223A313139397D2C7B226E616D65223A22E5B1B1E4B89CE79C81222C2276616C7565223A38367D2C7B226E616D65223A22E6B2B3E58D97E79C81222C2276616C7565223A3835307D2C7B226E616D65223A22E6B996E58C97E79C81222C2276616C7565223A38347D2C7B226E616D65223A22E5B9BFE8A5BFE5A3AEE6978FE887AAE6B2BBE58CBA222C2276616C7565223A38317D2C7B226E616D65223A22E6B5B7E58D97E79C81222C2276616C7565223A3930307D2C7B226E616D65223A22E99D92E6B5B7E79C81222C2276616C7565223A3830307D2C7B226E616D65223A22E696B0E79686E7BBB4E590BEE5B094E887AAE6B2BBE58CBA222C2276616C7565223A377D5D2C2273656C65637465644D6F6465223A66616C73652C227A6F6F6D223A312C2267656F496E646578223A312C22746F6F6C746970223A7B2273686F77223A747275652C226261636B67726F756E64436F6C6F72223A22233030303030303630222C22626F72646572436F6C6F72223A2272676261283134372C203233352C203234382C20302E3829222C22746578745374796C65223A7B22636F6C6F72223A2223464646464646222C22666F6E7453697A65223A31327D7D2C226C6162656C223A7B2273686F77223A66616C73652C22636F6C6F72223A2223464646464646222C22666F6E7453697A65223A31327D2C22656D706861736973223A7B2264697361626C6564223A66616C73652C226C6162656C223A7B22636F6C6F72223A2223464646464646222C22666F6E7453697A65223A31327D2C226974656D5374796C65223A7B2261726561436F6C6F72223A2223333839424237222C22736861646F77436F6C6F72223A2223333839424237222C22626F726465725769647468223A317D7D2C226974656D5374796C65223A7B22626F72646572436F6C6F72223A2223393345424638222C22626F726465725769647468223A312C2261726561436F6C6F72223A7B2274797065223A2272616469616C222C2278223A302E352C2279223A302E352C2272223A302E382C22636F6C6F7253746F7073223A5B7B226F6666736574223A302C22636F6C6F72223A22233933656266383030227D2C7B226F6666736574223A312C22636F6C6F72223A22233933656266383230227D5D2C22676C6F62616C436F6F7264223A66616C73657D2C22736861646F77436F6C6F72223A22233830443946383432222C22736861646F774F666673657458223A2D322C22736861646F774F666673657459223A322C22736861646F77426C7572223A31307D7D5D2C226261636B67726F756E64436F6C6F72223A227267626128302C302C302C3029227D7D2C7B226964223A2234666963326C6F77337238303030222C22697347726F7570223A66616C73652C2261747472223A7B2278223A36302C2279223A3431352C2277223A3530302C2268223A3330302C226F666673657458223A302C226F666673657459223A302C227A496E646578223A2D317D2C227374796C6573223A7B2266696C74657253686F77223A66616C73652C22687565526F74617465223A302C227361747572617465223A312C22636F6E7472617374223A312C226272696768746E657373223A312C226F706163697479223A312C22726F746174655A223A302C22726F7461746558223A302C22726F7461746559223A302C22736B657758223A302C22736B657759223A302C22626C656E644D6F6465223A226E6F726D616C222C22616E696D6174696F6E73223A5B5D7D2C22737461747573223A7B226C6F636B223A66616C73652C2268696465223A66616C73657D2C2272657175657374223A7B22726571756573744461746154797065223A302C22726571756573744874747054797065223A22676574222C227265717565737455726C223A22222C2272657175657374496E74657276616C556E6974223A227365636F6E64222C2272657175657374436F6E74656E7454797065223A302C2272657175657374506172616D73426F647954797065223A226E6F6E65222C227265717565737453514C436F6E74656E74223A7B2273716C223A2273656C656374202A2066726F6D20207768657265227D2C2272657175657374506172616D73223A7B22426F6479223A7B22666F726D2D64617461223A7B7D2C22782D7777772D666F726D2D75726C656E636F646564223A7B7D2C226A736F6E223A22222C22786D6C223A22227D2C22486561646572223A7B7D2C22506172616D73223A7B7D7D7D2C226B6579223A2242617243726F737372616E6765222C226368617274436F6E666967223A7B226B6579223A2242617243726F737372616E6765222C2263686172744B6579223A225642617243726F737372616E6765222C22636F6E4B6579223A22564342617243726F737372616E6765222C227469746C65223A22E6A8AAE59091E69FB1E78AB6E59BBE222C2263617465676F7279223A2242617273222C2263617465676F72794E616D65223A22E69FB1E78AB6E59BBE222C227061636B616765223A22436861727473222C2263686172744672616D65223A2265636861727473222C22696D616765223A222E2F7374617469632F706E672F6261725F792D30353036373136392E706E67227D2C226F7074696F6E223A7B226C6567656E64223A7B2273686F77223A747275652C22746F70223A223525222C22746578745374796C65223A7B22636F6C6F72223A2223423942384345227D7D2C227841786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A22626F74746F6D222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A66616C73652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22736F6C6964227D7D2C2274797065223A2276616C7565227D2C227941786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A226C656674222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22736F6C6964227D7D2C2274797065223A2263617465676F7279227D2C2267726964223A7B2273686F77223A66616C73652C226C656674223A22313025222C22746F70223A223630222C227269676874223A22313025222C22626F74746F6D223A223630227D2C22746F6F6C746970223A7B2273686F77223A747275652C2274726967676572223A2261786973222C2261786973506F696E746572223A7B2273686F77223A747275652C2274797065223A22736861646F77227D7D2C2264617461736574223A7B2264696D656E73696F6E73223A5B2270726F64756374222C226461746131222C226461746132225D2C22736F75726365223A5B7B2270726F64756374223A224D6F6E222C226461746131223A3132302C226461746132223A3133307D2C7B2270726F64756374223A22547565222C226461746131223A3230302C226461746132223A3133307D2C7B2270726F64756374223A22576564222C226461746131223A3135302C226461746132223A3331327D2C7B2270726F64756374223A22546875222C226461746131223A38302C226461746132223A3236387D2C7B2270726F64756374223A22467269222C226461746131223A37302C226461746132223A3135357D2C7B2270726F64756374223A22536174222C226461746131223A3131302C226461746132223A3131377D2C7B2270726F64756374223A2253756E222C226461746131223A3133302C226461746132223A3136307D5D7D2C22736572696573223A5B7B2274797065223A22626172222C226261725769647468223A6E756C6C2C226C6162656C223A7B2273686F77223A747275652C22706F736974696F6E223A227269676874222C22636F6C6F72223A2223666666222C22666F6E7453697A65223A31327D2C226974656D5374796C65223A7B22636F6C6F72223A6E756C6C2C22626F72646572526164697573223A307D7D2C7B2274797065223A22626172222C226261725769647468223A6E756C6C2C226C6162656C223A7B2273686F77223A747275652C22706F736974696F6E223A227269676874222C22636F6C6F72223A2223666666222C22666F6E7453697A65223A31327D2C226974656D5374796C65223A7B22636F6C6F72223A6E756C6C2C22626F72646572526164697573223A307D7D5D2C226261636B67726F756E64436F6C6F72223A227267626128302C302C302C3029227D7D2C7B226964223A22323037636675696C6A6766343030222C22697347726F7570223A66616C73652C2261747472223A7B2278223A36302C2279223A3734392C2277223A3530302C2268223A3330302C226F666673657458223A302C226F666673657459223A302C227A496E646578223A2D317D2C227374796C6573223A7B2266696C74657253686F77223A66616C73652C22687565526F74617465223A302C227361747572617465223A312C22636F6E7472617374223A312C226272696768746E657373223A312C226F706163697479223A312C22726F746174655A223A302C22726F7461746558223A302C22726F7461746559223A302C22736B657758223A302C22736B657759223A302C22626C656E644D6F6465223A226E6F726D616C222C22616E696D6174696F6E73223A5B5D7D2C22737461747573223A7B226C6F636B223A66616C73652C2268696465223A66616C73657D2C2272657175657374223A7B22726571756573744461746154797065223A302C22726571756573744874747054797065223A22676574222C227265717565737455726C223A22222C2272657175657374496E74657276616C556E6974223A227365636F6E64222C2272657175657374436F6E74656E7454797065223A302C2272657175657374506172616D73426F647954797065223A226E6F6E65222C227265717565737453514C436F6E74656E74223A7B2273716C223A2273656C656374202A2066726F6D20207768657265227D2C2272657175657374506172616D73223A7B22426F6479223A7B22666F726D2D64617461223A7B7D2C22782D7777772D666F726D2D75726C656E636F646564223A7B7D2C226A736F6E223A22222C22786D6C223A22227D2C22486561646572223A7B7D2C22506172616D73223A7B7D7D7D2C226B6579223A2243617073756C654368617274222C226368617274436F6E666967223A7B226B6579223A2243617073756C654368617274222C2263686172744B6579223A225643617073756C654368617274222C22636F6E4B6579223A22564343617073756C654368617274222C227469746C65223A22E883B6E59B8AE69FB1E59BBE222C2263617465676F7279223A2242617273222C2263617465676F72794E616D65223A22E69FB1E78AB6E59BBE222C227061636B616765223A22436861727473222C2263686172744672616D65223A22636F6D6D6F6E222C22696D616765223A222E2F7374617469632F706E672F63617073756C652D63356432663532312E706E67227D2C226F7074696F6E223A7B2264617461736574223A7B2264696D656E73696F6E73223A5B226E616D65222C2276616C7565225D2C22736F75726365223A5B7B226E616D65223A22E58EA6E997A8222C2276616C7565223A32307D2C7B226E616D65223A22E58D97E998B3222C2276616C7565223A34307D2C7B226E616D65223A22E58C97E4BAAC222C2276616C7565223A36307D2C7B226E616D65223A22E4B88AE6B5B7222C2276616C7565223A38307D2C7B226E616D65223A22E696B0E79686222C2276616C7565223A3130307D5D7D2C22636F6C6F7273223A5B2223633465626164222C2223366265366331222C2223613061376536222C2223393664656538222C2223336662316533225D2C22756E6974223A22222C226974656D486569676874223A31302C2276616C7565466F6E7453697A65223A31362C2270616464696E675269676874223A35302C2270616464696E674C656674223A35302C2273686F7756616C7565223A747275657D7D2C7B226964223A22316764753078716C73736B673030222C22697347726F7570223A66616C73652C2261747472223A7B2278223A313430352C2279223A35322C2277223A3530302C2268223A3330302C226F666673657458223A302C226F666673657459223A302C227A496E646578223A2D317D2C227374796C6573223A7B2266696C74657253686F77223A66616C73652C22687565526F74617465223A302C227361747572617465223A312C22636F6E7472617374223A312C226272696768746E657373223A312C226F706163697479223A312C22726F746174655A223A302C22726F7461746558223A302C22726F7461746559223A302C22736B657758223A302C22736B657759223A302C22626C656E644D6F6465223A226E6F726D616C222C22616E696D6174696F6E73223A5B5D7D2C22737461747573223A7B226C6F636B223A66616C73652C2268696465223A66616C73657D2C2272657175657374223A7B22726571756573744461746154797065223A302C22726571756573744874747054797065223A22676574222C227265717565737455726C223A22222C2272657175657374496E74657276616C556E6974223A227365636F6E64222C2272657175657374436F6E74656E7454797065223A302C2272657175657374506172616D73426F647954797065223A226E6F6E65222C227265717565737453514C436F6E74656E74223A7B2273716C223A2273656C656374202A2066726F6D20207768657265227D2C2272657175657374506172616D73223A7B22426F6479223A7B22666F726D2D64617461223A7B7D2C22782D7777772D666F726D2D75726C656E636F646564223A7B7D2C226A736F6E223A22222C22786D6C223A22227D2C22486561646572223A7B7D2C22506172616D73223A7B7D7D7D2C226B6579223A224C696E65436F6D6D6F6E222C226368617274436F6E666967223A7B226B6579223A224C696E65436F6D6D6F6E222C2263686172744B6579223A22564C696E65436F6D6D6F6E222C22636F6E4B6579223A2256434C696E65436F6D6D6F6E222C227469746C65223A22E68A98E7BABFE59BBE222C2263617465676F7279223A224C696E6573222C2263617465676F72794E616D65223A22E68A98E7BABFE59BBE222C227061636B616765223A22436861727473222C2263686172744672616D65223A2265636861727473222C22696D616765223A222E2F7374617469632F706E672F6C696E652D65373134626337342E706E67227D2C226F7074696F6E223A7B226C6567656E64223A7B2273686F77223A747275652C22746F70223A223525222C22746578745374796C65223A7B22636F6C6F72223A2223423942384345227D7D2C227841786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A22626F74746F6D222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A66616C73652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22736F6C6964227D7D2C2274797065223A2263617465676F7279227D2C227941786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A226C656674222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22736F6C6964227D7D2C2274797065223A2276616C7565227D2C2267726964223A7B2273686F77223A66616C73652C226C656674223A22313025222C22746F70223A223630222C227269676874223A22313025222C22626F74746F6D223A223630227D2C22746F6F6C746970223A7B2273686F77223A747275652C2274726967676572223A2261786973222C2261786973506F696E746572223A7B2274797065223A226C696E65227D7D2C2264617461736574223A7B2264696D656E73696F6E73223A5B2270726F64756374222C226461746131222C226461746132225D2C22736F75726365223A5B7B2270726F64756374223A224D6F6E222C226461746131223A3132302C226461746132223A3133307D2C7B2270726F64756374223A22547565222C226461746131223A3230302C226461746132223A3133307D2C7B2270726F64756374223A22576564222C226461746131223A3135302C226461746132223A3331327D2C7B2270726F64756374223A22546875222C226461746131223A38302C226461746132223A3236387D2C7B2270726F64756374223A22467269222C226461746131223A37302C226461746132223A3135357D2C7B2270726F64756374223A22536174222C226461746131223A3131302C226461746132223A3131377D2C7B2270726F64756374223A2253756E222C226461746131223A3133302C226461746132223A3136307D5D7D2C22736572696573223A5B7B2274797065223A226C696E65222C226C6162656C223A7B2273686F77223A747275652C22706F736974696F6E223A22746F70222C22636F6C6F72223A2223666666222C22666F6E7453697A65223A31327D2C2273796D626F6C53697A65223A352C226974656D5374796C65223A7B22636F6C6F72223A6E756C6C2C22626F72646572526164697573223A307D2C226C696E655374796C65223A7B2274797065223A22736F6C6964222C227769647468223A332C22636F6C6F72223A6E756C6C7D7D2C7B2274797065223A226C696E65222C226C6162656C223A7B2273686F77223A747275652C22706F736974696F6E223A22746F70222C22636F6C6F72223A2223666666222C22666F6E7453697A65223A31327D2C2273796D626F6C53697A65223A352C226974656D5374796C65223A7B22636F6C6F72223A6E756C6C2C22626F72646572526164697573223A307D2C226C696E655374796C65223A7B2274797065223A22736F6C6964222C227769647468223A332C22636F6C6F72223A6E756C6C7D7D5D2C226261636B67726F756E64436F6C6F72223A227267626128302C302C302C3029227D7D2C7B226964223A22347A73376E6E36756A6463303030222C22697347726F7570223A66616C73652C2261747472223A7B2278223A313338352C2279223A3336312C2277223A3530302C2268223A3330302C226F666673657458223A302C226F666673657459223A302C227A496E646578223A2D317D2C227374796C6573223A7B2266696C74657253686F77223A66616C73652C22687565526F74617465223A302C227361747572617465223A312C22636F6E7472617374223A312C226272696768746E657373223A312C226F706163697479223A312C22726F746174655A223A302C22726F7461746558223A302C22726F7461746559223A302C22736B657758223A302C22736B657759223A302C22626C656E644D6F6465223A226E6F726D616C222C22616E696D6174696F6E73223A5B5D7D2C22737461747573223A7B226C6F636B223A66616C73652C2268696465223A66616C73657D2C2272657175657374223A7B22726571756573744461746154797065223A302C22726571756573744874747054797065223A22676574222C227265717565737455726C223A22222C2272657175657374496E74657276616C556E6974223A227365636F6E64222C2272657175657374436F6E74656E7454797065223A302C2272657175657374506172616D73426F647954797065223A226E6F6E65222C227265717565737453514C436F6E74656E74223A7B2273716C223A2273656C656374202A2066726F6D20207768657265227D2C2272657175657374506172616D73223A7B22426F6479223A7B22666F726D2D64617461223A7B7D2C22782D7777772D666F726D2D75726C656E636F646564223A7B7D2C226A736F6E223A22222C22786D6C223A22227D2C22486561646572223A7B7D2C22506172616D73223A7B7D7D7D2C226B6579223A22506965436F6D6D6F6E222C226368617274436F6E666967223A7B226B6579223A22506965436F6D6D6F6E222C2263686172744B6579223A2256506965436F6D6D6F6E222C22636F6E4B6579223A225643506965436F6D6D6F6E222C227469746C65223A22E9A5BCE59BBE222C2263617465676F7279223A2250696573222C2263617465676F72794E616D65223A22E9A5BCE59BBE222C227061636B616765223A22436861727473222C2263686172744672616D65223A2265636861727473222C22696D616765223A222E2F7374617469632F706E672F7069652D39363230663139312E706E67227D2C226F7074696F6E223A7B226C6567656E64223A7B2273686F77223A747275652C22746F70223A223525222C22746578745374796C65223A7B22636F6C6F72223A2223423942384345227D7D2C2274797065223A2272696E67222C22746F6F6C746970223A7B2273686F77223A747275652C2274726967676572223A226974656D227D2C2264617461736574223A7B2264696D656E73696F6E73223A5B2270726F64756374222C226461746131225D2C22736F75726365223A5B7B2270726F64756374223A224D6F6E222C226461746131223A3132307D2C7B2270726F64756374223A22547565222C226461746131223A3230307D2C7B2270726F64756374223A22576564222C226461746131223A3135307D2C7B2270726F64756374223A22546875222C226461746131223A38307D2C7B2270726F64756374223A22467269222C226461746131223A37307D2C7B2270726F64756374223A22536174222C226461746131223A3131307D2C7B2270726F64756374223A2253756E222C226461746131223A3133307D5D7D2C22736572696573223A5B7B2274797065223A22706965222C22726164697573223A5B22343025222C22363525225D2C2263656E746572223A5B22353025222C22363025225D2C22726F736554797065223A66616C73652C2261766F69644C6162656C4F7665726C6170223A66616C73652C226974656D5374796C65223A7B2273686F77223A747275652C22626F72646572526164697573223A31302C22626F72646572436F6C6F72223A2223666666222C22626F726465725769647468223A327D2C226C6162656C223A7B2273686F77223A66616C73652C22706F736974696F6E223A2263656E746572227D2C22656D706861736973223A7B226C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A223430222C22666F6E74576569676874223A22626F6C64227D7D2C226C6162656C4C696E65223A7B2273686F77223A66616C73657D7D5D2C226261636B67726F756E64436F6C6F72223A227267626128302C302C302C3029227D7D2C7B226964223A22353669656D706379696230303030222C22697347726F7570223A66616C73652C2261747472223A7B2278223A313338352C2279223A3732322C2277223A3530302C2268223A3330302C226F666673657458223A302C226F666673657459223A302C227A496E646578223A2D317D2C227374796C6573223A7B2266696C74657253686F77223A66616C73652C22687565526F74617465223A302C227361747572617465223A312C22636F6E7472617374223A312C226272696768746E657373223A312C226F706163697479223A312C22726F746174655A223A302C22726F7461746558223A302C22726F7461746559223A302C22736B657758223A302C22736B657759223A302C22626C656E644D6F6465223A226E6F726D616C222C22616E696D6174696F6E73223A5B5D7D2C22737461747573223A7B226C6F636B223A66616C73652C2268696465223A66616C73657D2C2272657175657374223A7B22726571756573744461746154797065223A302C22726571756573744874747054797065223A22676574222C227265717565737455726C223A22222C2272657175657374496E74657276616C556E6974223A227365636F6E64222C2272657175657374436F6E74656E7454797065223A302C2272657175657374506172616D73426F647954797065223A226E6F6E65222C227265717565737453514C436F6E74656E74223A7B2273716C223A2273656C656374202A2066726F6D20207768657265227D2C2272657175657374506172616D73223A7B22426F6479223A7B22666F726D2D64617461223A7B7D2C22782D7777772D666F726D2D75726C656E636F646564223A7B7D2C226A736F6E223A22222C22786D6C223A22227D2C22486561646572223A7B7D2C22506172616D73223A7B7D7D7D2C226B6579223A22536361747465724C6F6761726974686D696352656772657373696F6E222C226368617274436F6E666967223A7B226B6579223A22536361747465724C6F6761726974686D696352656772657373696F6E222C2263686172744B6579223A2256536361747465724C6F6761726974686D696352656772657373696F6E222C22636F6E4B6579223A225643536361747465724C6F6761726974686D696352656772657373696F6E222C227469746C65223A22E5AFB9E695B0E59B9EE5BD92E695A3E782B9E59BBE222C2263617465676F7279223A225363617474657273222C2263617465676F72794E616D65223A22E695A3E782B9E59BBE222C227061636B616765223A22436861727473222C2263686172744672616D65223A2265636861727473222C22696D616765223A222E2F7374617469632F706E672F736361747465722D6C6F6761726974686D69632D72656772657373696F6E2D38376665366564312E706E67227D2C226F7074696F6E223A7B226C6567656E64223A7B2273686F77223A747275652C22746F70223A223525222C22746578745374796C65223A7B22636F6C6F72223A2223423942384345227D2C2264617461223A5B2231393930222C2232303135225D7D2C227841786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A22626F74746F6D222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A66616C73652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22646173686564227D7D2C2274797065223A2276616C7565227D2C227941786973223A7B2273686F77223A747275652C226E616D65223A22222C226E616D65476170223A31352C226E616D65546578745374796C65223A7B22636F6C6F72223A2223423942384345222C22666F6E7453697A65223A31327D2C22696E7665727365223A66616C73652C22617869734C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31322C22636F6C6F72223A2223423942384345222C22726F74617465223A307D2C22706F736974696F6E223A226C656674222C22617869734C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223423942384345222C227769647468223A317D2C226F6E5A65726F223A747275657D2C22617869735469636B223A7B2273686F77223A747275652C226C656E677468223A357D2C2273706C69744C696E65223A7B2273686F77223A747275652C226C696E655374796C65223A7B22636F6C6F72223A2223343834373533222C227769647468223A312C2274797065223A22646173686564227D7D2C2274797065223A2276616C7565227D2C2267726964223A7B2273686F77223A66616C73652C226C656674223A22313025222C22746F70223A223630222C227269676874223A22313025222C22626F74746F6D223A223630227D2C2264617461736574223A5B7B22736F75726365223A5B5B32383630342C37372C31373039363836392C224175737472616C6961222C313939305D2C5B33313136332C37372E342C32373636323434302C2243616E616461222C313939305D2C5B313531362C36382C313135343630353737332C224368696E61222C313939305D2C5B31333637302C37342E372C31303538323038322C2243756261222C313939305D2C5B32383539392C37352C343938363730352C2246696E6C616E64222C313939305D2C5B32393437362C37372E312C35363934333239392C224672616E6365222C313939305D2C5B33313437362C37352E342C37383935383233372C224765726D616E79222C313939305D2C5B32383636362C37382E312C3235343833302C224963656C616E64222C313939305D2C5B313737372C35372E372C3837303630313737362C22496E646961222C313939305D2C5B32393535302C37392E312C3132323234393238352C224A6170616E222C313939305D2C5B323037362C36372E392C32303139343335342C224E6F727468204B6F726561222C313939305D2C5B31323038372C37322C34323937323235342C22536F757468204B6F726561222C313939305D2C5B32343032312C37352E342C333339373533342C224E6577205A65616C616E64222C313939305D2C5B34333239362C37362E382C343234303337352C224E6F72776179222C313939305D2C5B31303038382C37302E382C33383139353235382C22506F6C616E64222C313939305D2C5B31393334392C36392E362C3134373536383535322C22527573736961222C313939305D2C5B31303637302C36372E332C35333939343630352C225475726B6579222C313939305D2C5B32363432342C37352E372C35373131303131372C22556E69746564204B696E67646F6D222C313939305D2C5B33373036322C37352E342C3235323834373831302C22556E6974656420537461746573222C313939305D2C5B34343035362C38312E382C32333936383937332C224175737472616C6961222C323031355D2C5B34333239342C38312E372C33353933393932372C2243616E616461222C323031355D2C5B31333333342C37362E392C313337363034383934332C224368696E61222C323031355D2C5B32313239312C37382E352C31313338393536322C2243756261222C323031355D2C5B33383932332C38302E382C353530333435372C2246696E6C616E64222C323031355D2C5B33373539392C38312E392C36343339353334352C224672616E6365222C323031355D2C5B34343035332C38312E312C38303638383534352C224765726D616E79222C323031355D2C5B34323138322C38322E382C3332393432352C224963656C616E64222C323031355D2C5B353930332C36362E382C313331313035303532372C22496E646961222C323031355D2C5B33363136322C38332E352C3132363537333438312C224A6170616E222C323031355D2C5B313339302C37312E342C32353135353331372C224E6F727468204B6F726561222C323031355D2C5B33343634342C38302E372C35303239333433392C22536F757468204B6F726561222C323031355D2C5B33343138362C38302E362C343532383532362C224E6577205A65616C616E64222C323031355D2C5B36343330342C38312E362C353231303936372C224E6F72776179222C323031355D2C5B32343738372C37372E332C33383631313739342C22506F6C616E64222C323031355D2C5B32333033382C37332E31332C3134333435363931382C22527573736961222C323031355D2C5B31393336302C37362E352C37383636353833302C225475726B6579222C323031355D2C5B33383232352C38312E342C36343731353831302C22556E69746564204B696E67646F6D222C323031355D2C5B35333335342C37392E312C3332313737333633312C22556E6974656420537461746573222C323031355D5D7D2C7B227472616E73666F726D223A7B2274797065223A2266696C746572222C22636F6E666967223A7B2264696D656E73696F6E223A342C226571223A313939307D7D7D2C7B227472616E73666F726D223A7B2274797065223A2266696C746572222C22636F6E666967223A7B2264696D656E73696F6E223A342C226571223A323031357D7D7D2C7B227472616E73666F726D223A7B2274797065223A226563537461743A72656772657373696F6E222C22636F6E666967223A7B226D6574686F64223A226C6F6761726974686D6963227D7D7D5D2C22746F6F6C746970223A7B2273686F7744656C6179223A302C2261786973506F696E746572223A7B2273686F77223A747275652C2274797065223A2263726F7373222C226C696E655374796C65223A7B2274797065223A22646173686564222C227769647468223A317D7D7D2C2276697375616C4D6170223A7B2273686F77223A66616C73652C2264696D656E73696F6E223A322C226D696E223A32303030302C226D6178223A313530303030303030302C22736572696573496E646578223A5B302C315D2C22696E52616E6765223A7B2273796D626F6C53697A65223A5B31302C37305D7D7D2C22736572696573223A5B7B2274797065223A2273636174746572222C2264617461736574496E646578223A317D2C7B2274797065223A2273636174746572222C2264617461736574496E646578223A327D2C7B2274797065223A226C696E65222C22736D6F6F7468223A747275652C2264617461736574496E646578223A332C2273796D626F6C53697A65223A302E312C2273796D626F6C223A22636972636C65222C226C6162656C223A7B2273686F77223A747275652C22666F6E7453697A65223A31367D2C226C6162656C4C61796F7574223A7B226478223A2D32307D2C22656E636F6465223A7B226C6162656C223A322C22746F6F6C746970223A317D7D5D2C226261636B67726F756E64436F6C6F72223A227267626128302C302C302C3029227D7D2C7B226964223A223263636A6B376177737234303030222C22697347726F7570223A66616C73652C2261747472223A7B2278223A3630392E352C2279223A3736352C2277223A3730392C2268223A3236312C226F666673657458223A302C226F666673657459223A302C227A496E646578223A2D317D2C227374796C6573223A7B2266696C74657253686F77223A66616C73652C22687565526F74617465223A302C227361747572617465223A312C22636F6E7472617374223A312C226272696768746E657373223A312C226F706163697479223A312C22726F746174655A223A302C22726F7461746558223A302C22726F7461746559223A302C22736B657758223A302C22736B657759223A302C22626C656E644D6F6465223A226E6F726D616C222C22616E696D6174696F6E73223A5B5D7D2C22737461747573223A7B226C6F636B223A66616C73652C2268696465223A66616C73657D2C2272657175657374223A7B22726571756573744461746154797065223A302C22726571756573744874747054797065223A22676574222C227265717565737455726C223A22222C2272657175657374496E74657276616C556E6974223A227365636F6E64222C2272657175657374436F6E74656E7454797065223A302C2272657175657374506172616D73426F647954797065223A226E6F6E65222C227265717565737453514C436F6E74656E74223A7B2273716C223A2273656C656374202A2066726F6D20207768657265227D2C2272657175657374506172616D73223A7B22426F6479223A7B22666F726D2D64617461223A7B7D2C22782D7777772D666F726D2D75726C656E636F646564223A7B7D2C226A736F6E223A22222C22786D6C223A22227D2C22486561646572223A7B7D2C22506172616D73223A7B7D7D7D2C226B6579223A225461626C655363726F6C6C426F617264222C226368617274436F6E666967223A7B226B6579223A225461626C655363726F6C6C426F617264222C2263686172744B6579223A22565461626C655363726F6C6C426F617264222C22636F6E4B6579223A2256435461626C655363726F6C6C426F617264222C227469746C65223A22E8BDAEE692ADE58897E8A1A8222C2263617465676F7279223A225461626C6573222C2263617465676F72794E616D65223A22E8A1A8E6A0BC222C227061636B616765223A225461626C6573222C2263686172744672616D65223A22636F6D6D6F6E222C22696D616765223A222E2F7374617469632F706E672F7461626C655F7363726F6C6C626F6172642D66623634326537382E706E67227D2C226F7074696F6E223A7B22686561646572223A5B22E5889731222C22E5889732222C22E5889733225D2C2264617461736574223A5B5B22E8A18C31E5889731222C22E8A18C31E5889732222C22E8A18C31E5889733225D2C5B22E8A18C32E5889731222C22E8A18C32E5889732222C22E8A18C32E5889733225D2C5B22E8A18C33E5889731222C22E8A18C33E5889732222C22E8A18C33E5889733225D2C5B22E8A18C34E5889731222C22E8A18C34E5889732222C22E8A18C34E5889733225D2C5B22E8A18C35E5889731222C22E8A18C35E5889732222C22E8A18C35E5889733225D2C5B22E8A18C36E5889731222C22E8A18C36E5889732222C22E8A18C36E5889733225D2C5B22E8A18C37E5889731222C22E8A18C37E5889732222C22E8A18C37E5889733225D2C5B22E8A18C38E5889731222C22E8A18C38E5889732222C22E8A18C38E5889733225D2C5B22E8A18C39E5889731222C22E8A18C39E5889732222C22E8A18C39E5889733225D2C5B22E8A18C3130E5889731222C22E8A18C3130E5889732222C22E8A18C3130E5889733225D5D2C22696E646578223A747275652C22636F6C756D6E5769647468223A5B33302C3130302C3130305D2C22616C69676E223A5B2263656E746572222C227269676874222C227269676874222C227269676874225D2C22726F774E756D223A352C227761697454696D65223A322C22686561646572486569676874223A33352C226361726F7573656C223A2273696E676C65222C22686561646572424743223A2223303042414646222C226F6464526F77424743223A2223303033423531222C226576656E526F77424743223A2223304132373332227D7D5D2C2272657175657374476C6F62616C436F6E666967223A7B22726571756573744F726967696E55726C223A22222C2272657175657374496E74657276616C223A33302C2272657175657374496E74657276616C556E6974223A227365636F6E64222C2272657175657374506172616D73223A7B22426F6479223A7B22666F726D2D64617461223A7B7D2C22782D7777772D666F726D2D75726C656E636F646564223A7B7D2C226A736F6E223A22222C22786D6C223A22227D2C22486561646572223A7B7D2C22506172616D73223A7B7D7D7D7D, '2023-02-26 23:08:40', '1', '2023-02-26 23:11:41');

-- ----------------------------
-- Table structure for iot_group
-- ----------------------------
DROP TABLE IF EXISTS `iot_group`;
CREATE TABLE `iot_group`  (
  `group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分组ID',
  `group_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组名称',
  `group_order` tinyint(11) NOT NULL DEFAULT 0 COMMENT '分组排序',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`group_id`) USING BTREE,
  INDEX `iot_group_index_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_group
-- ----------------------------
INSERT INTO `iot_group` VALUES (2, '卧室', 2, 1, 'admin', '0', '', '2021-12-29 13:12:42', '', '2021-12-29 13:13:40', '卧室设备');
INSERT INTO `iot_group` VALUES (3, '厨房', 3, 1, 'admin', '0', '', '2021-12-29 13:12:59', '', '2021-12-29 13:13:48', '厨房设备');
INSERT INTO `iot_group` VALUES (4, '书房', 4, 1, 'admin', '0', '', '2021-12-29 13:13:10', '', '2021-12-29 13:13:54', '书房设备');
INSERT INTO `iot_group` VALUES (5, '卫生间', 5, 1, 'admin', '0', '', '2021-12-29 13:13:18', '', '2021-12-29 13:14:03', '卫生间设备');
INSERT INTO `iot_group` VALUES (6, '走道', 6, 1, 'admin', '0', '', '2021-12-29 13:13:26', '', '2021-12-29 13:14:11', '走道设备');

-- ----------------------------
-- Table structure for iot_product
-- ----------------------------
DROP TABLE IF EXISTS `iot_product`;
CREATE TABLE `iot_product`  (
  `product_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `protocol_code` int(11) NULL DEFAULT NULL COMMENT '协议编号',
  `category_id` bigint(20) NOT NULL COMMENT '产品分类ID',
  `category_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品分类名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否系统通用（0-否，1-是）',
  `is_authorize` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用授权码（0-否，1-是）',
  `mqtt_account` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mqtt账号',
  `mqtt_password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mqtt密码',
  `mqtt_secret` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品秘钥',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态（1-未发布，2-已发布）',
  `things_models_json` json NULL COMMENT '物模型JSON（属性、功能、事件）',
  `device_type` tinyint(1) NULL DEFAULT 1 COMMENT '设备类型（1-直连设备、2-网关设备、3-监控设备）',
  `network_method` tinyint(1) NULL DEFAULT 1 COMMENT '联网方式（1=wifi、2=蜂窝(2G/3G/4G/5G)、3=以太网、4=其他）',
  `vertificate_method` tinyint(1) NULL DEFAULT 1 COMMENT '认证方式（1-简单认证、2-加密认证、3-简单+加密）',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `iot_product_index_category_id`(`category_id`) USING BTREE,
  INDEX `iot_product_index_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_product
-- ----------------------------
INSERT INTO `iot_product` VALUES (41, '★智能开关', 0, 1, '电工照明', 1, 'admin', 1, 0, 'FastBee', 'P47T6OD5IPFWHUM6', 'KX3TSH4Q4OS835DO', 2, '{\"events\": [{\"id\": \"height_temperature\", \"name\": \"环境温度过高\", \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}}, {\"id\": \"exception\", \"name\": \"设备发生异常\", \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}], \"functions\": [{\"id\": \"report_monitor\", \"name\": \"上报数据\", \"isTop\": 0, \"order\": 10, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isReadonly\": 0}, {\"id\": \"switch\", \"name\": \"设备开关\", \"isTop\": 1, \"order\": 9, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isReadonly\": 0}, {\"id\": \"gear\", \"name\": \"运行档位\", \"isTop\": 1, \"order\": 8, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isReadonly\": 0}, {\"id\": \"message\", \"name\": \"屏显消息\", \"isTop\": 0, \"order\": 7, \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}, \"isReadonly\": 0}, {\"id\": \"reset\", \"name\": \"设备重启\", \"isTop\": 1, \"order\": 6, \"datatype\": {\"type\": \"string\", \"maxLength\": 64}, \"isReadonly\": 0}, {\"id\": \"light_color\", \"name\": \"灯光色值\", \"isTop\": 0, \"order\": 5, \"datatype\": {\"type\": \"array\", \"arrayType\": \"integer\", \"arrayCount\": \"3\"}, \"isReadonly\": 0}], \"properties\": [{\"id\": \"brightness\", \"name\": \"室内亮度\", \"isTop\": 0, \"order\": 4, \"datatype\": {\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"humidity\", \"name\": \"空气湿度\", \"isTop\": 1, \"order\": 3, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"co2\", \"name\": \"二氧化碳\", \"isTop\": 0, \"order\": 2, \"datatype\": {\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"temperature\", \"name\": \"空气温度\", \"isTop\": 1, \"order\": 1, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 1, \"isReadonly\": 0}]}', 1, 1, 3, NULL, '0', '', '2025-08-14 00:06:33', '', '2023-02-26 01:08:18', NULL);
INSERT INTO `iot_product` VALUES (94, '★监控产品', NULL, 2, '家居安防', 1, 'admin', 1, 0, 'wumei-smart', 'P6M2QPK2OG201YFY', 'KJ5P0TB8ONJ8Q6J5', 2, '{\"events\": [], \"functions\": [], \"properties\": []}', 3, 1, 3, NULL, '0', '', '2025-02-25 15:43:55', '', '2023-02-25 22:55:59', NULL);
INSERT INTO `iot_product` VALUES (96, '★网关产品', NULL, 1, '电工照明', 1, 'admin', 1, 0, 'FastBee', 'P467433O1MT8MXS2', 'KWF32S3H95LH14LO', 2, '{\"events\": [{\"id\": \"height_temperature\", \"name\": \"环境温度过高\", \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}}, {\"id\": \"exception\", \"name\": \"设备发生异常\", \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}], \"functions\": [{\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"order\": 11, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isReadonly\": 0}, {\"id\": \"switch\", \"name\": \"设备开关\", \"isTop\": 1, \"order\": 8, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isReadonly\": 0}, {\"id\": \"gear\", \"name\": \"运行档位\", \"isTop\": 1, \"order\": 7, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isReadonly\": 0}, {\"id\": \"message\", \"name\": \"屏显消息\", \"isTop\": 0, \"order\": 0, \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}, \"isReadonly\": 0}, {\"id\": \"reset\", \"name\": \"设备重启\", \"isTop\": 1, \"order\": 0, \"datatype\": {\"type\": \"string\", \"maxLength\": 64}, \"isReadonly\": 0}, {\"id\": \"light_color\", \"name\": \"灯光色值\", \"isTop\": 0, \"order\": 0, \"datatype\": {\"type\": \"array\", \"arrayType\": \"integer\", \"arrayCount\": \"3\"}, \"isReadonly\": 0}], \"properties\": [{\"id\": \"device\", \"name\": \"子设备\", \"isTop\": 1, \"order\": 10, \"datatype\": {\"type\": \"array\", \"params\": [{\"id\": \"device_co2\", \"name\": \"二氧化碳\", \"isTop\": 0, \"order\": 0, \"datatype\": {\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"device_temperature\", \"name\": \"空气温度-只读\", \"isTop\": 1, \"order\": 4, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"device_gear\", \"name\": \"运行档位\", \"isTop\": 1, \"order\": 6, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_switch\", \"name\": \"设备开关\", \"isTop\": 1, \"order\": 5, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"order\": 9, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isMonitor\": 0, \"isReadonly\": 0}], \"arrayType\": \"object\", \"arrayCount\": 5}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category\", \"name\": \"功能分组\", \"isTop\": 1, \"order\": 9, \"datatype\": {\"type\": \"object\", \"params\": [{\"id\": \"category_light\", \"name\": \"光照\", \"isTop\": 0, \"order\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"category_humidity\", \"name\": \"空气湿度\", \"isTop\": 1, \"order\": 2, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"category_temperature\", \"name\": \"空气温度-只读\", \"isTop\": 1, \"order\": 3, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"category_report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"order\": 6, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_gear\", \"name\": \"运行档位\", \"isTop\": 1, \"order\": 5, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_switch\", \"name\": \"设备开关\", \"isTop\": 1, \"order\": 4, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isMonitor\": 0, \"isReadonly\": 0}]}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"brightness\", \"name\": \"室内亮度\", \"isTop\": 0, \"order\": 0, \"datatype\": {\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"temperature\", \"name\": \"空气温度\", \"isTop\": 1, \"order\": 0, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 1, \"isReadonly\": 0}]}', 2, 1, 3, NULL, '0', '', '2025-02-25 22:51:39', '', '2023-02-26 00:35:53', NULL);

-- ----------------------------
-- Table structure for iot_product_authorize
-- ----------------------------
DROP TABLE IF EXISTS `iot_product_authorize`;
CREATE TABLE `iot_product_authorize`  (
  `authorize_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '授权码ID',
  `authorize_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权码',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `device_id` bigint(20) NULL DEFAULT NULL COMMENT '设备ID',
  `serial_number` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备编号',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态（1-未使用，2-使用中）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`authorize_id`) USING BTREE,
  INDEX `iot_product_authorize_index_product_id`(`product_id`) USING BTREE,
  INDEX `iot_product_authorize_index_device_id`(`device_id`) USING BTREE,
  INDEX `iot_product_authorize_index_serial_number`(`serial_number`) USING BTREE,
  INDEX `iot_product_authorize_index_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品授权码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_product_authorize
-- ----------------------------

-- ----------------------------
-- Table structure for iot_protocol
-- ----------------------------
DROP TABLE IF EXISTS `iot_protocol`;
CREATE TABLE `iot_protocol`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `protocol_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '协议编码',
  `protocol_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '协议名称',
  `protocol_file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '协议jar包,js包，c程序上传地址',
  `protocol_type` int(11) NOT NULL DEFAULT 0 COMMENT '协议类型 0:未知 1:jar，2.js,3.c',
  `jar_sign` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '协议文件摘要(文件的md5)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `protocol_status` int(11) NOT NULL DEFAULT 0 COMMENT '0:草稿 1:启用 2:停用',
  `del_flag` int(11) NOT NULL DEFAULT 0 COMMENT '0:正常 1:删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UNIQUE_CODE`(`protocol_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '协议表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_protocol
-- ----------------------------

-- ----------------------------
-- Table structure for iot_scene
-- ----------------------------
DROP TABLE IF EXISTS `iot_scene`;
CREATE TABLE `iot_scene`  (
  `scene_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '场景ID',
  `scene_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '场景名称',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `actions` json NOT NULL COMMENT '执行动作',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '场景状态（1-启动，2-停止）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`scene_id`) USING BTREE,
  INDEX `iot_scene_index_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场景联动' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_scene
-- ----------------------------
INSERT INTO `iot_scene` VALUES (71, '温度过高关闭设备', 1, 'admin', '[{\"id\": \"switch\", \"name\": \"设备开关\", \"type\": 2, \"value\": \"0\", \"deviceId\": 39, \"productId\": 41, \"deviceName\": \"演示设备\", \"productName\": \"温湿度智能开关\", \"serialNumber\": \"D1H2584G22Q2\"}]', 1, '', '2022-11-03 13:27:50', '', NULL, NULL);

-- ----------------------------
-- Table structure for iot_scene_trigger
-- ----------------------------
DROP TABLE IF EXISTS `iot_scene_trigger`;
CREATE TABLE `iot_scene_trigger`  (
  `scene_trigger_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '场景触发器ID',
  `scene_id` bigint(20) NOT NULL COMMENT '所属场景ID',
  `status` tinyint(1) NOT NULL COMMENT '告警状态（1-启动，2-停止）',
  `source` tinyint(1) NOT NULL COMMENT '触发源（1=设备触发，2=定时触发）',
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型标识符',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型名称',
  `value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型值',
  `operator` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作符',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '物模型类别（1=属性，2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线）',
  `device_id` bigint(20) NULL DEFAULT NULL COMMENT '设备ID',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编号',
  `product_id` bigint(20) NULL DEFAULT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `job_id` bigint(20) NULL DEFAULT NULL COMMENT '任务ID',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `is_advance` tinyint(1) NULL DEFAULT NULL COMMENT '是否详细corn表达式（1=是，0=否）',
  PRIMARY KEY (`scene_trigger_id`) USING BTREE,
  INDEX `iot_scene_trigger_index_scene_id`(`scene_id`) USING BTREE,
  INDEX `iot_scene_trigger_index_device_id`(`device_id`) USING BTREE,
  INDEX `iot_scene_trigger_index_serial_number`(`serial_number`) USING BTREE,
  INDEX `iot_scene_trigger_index_product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 222 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '场景联动触发器' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_scene_trigger
-- ----------------------------
INSERT INTO `iot_scene_trigger` VALUES (220, 71, 1, 1, 'temperature', '空气温度', '40', '>', 1, 39, '演示设备', 'D1H2584G22Q2', 41, '温湿度智能开关', 0, '', 0);

-- ----------------------------
-- Table structure for iot_social_platform
-- ----------------------------
DROP TABLE IF EXISTS `iot_social_platform`;
CREATE TABLE `iot_social_platform`  (
  `social_platform_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '第三方登录平台主键',
  `platform` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方登录平台',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT ' 0:启用 ,1:禁用',
  `client_id` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方平台申请Id',
  `secret_key` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方平台密钥',
  `redirect_uri` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户认证后跳转地址',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记位(0代表存在，1代表删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bind_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '绑定注册登录uri,http://localhost/login?bindId=',
  `redirect_login_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '跳转登录uri,http://localhost/login?loginId=',
  `error_msg_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '错误提示uri,http://localhost/login?errorId=',
  PRIMARY KEY (`social_platform_id`) USING BTREE,
  UNIQUE INDEX `iot_social_platform_platform_uindex`(`platform`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方登录平台控制' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_social_platform
-- ----------------------------
INSERT INTO `iot_social_platform` VALUES (1, 'QQ', '0', '102005066', 'PhkaBYgZ99999', 'https://iot.wumei.live/auth/callback/qq', '0', 'admin', '2022-04-18 11:21:28', '2022-04-20 16:29:23', 'admin', NULL, 'http://localhost/login?bindId=', 'http://localhost/login?loginId=', 'http://localhost/login?errorId=');

-- ----------------------------
-- Table structure for iot_social_user
-- ----------------------------
DROP TABLE IF EXISTS `iot_social_user`;
CREATE TABLE `iot_social_user`  (
  `social_user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '第三方系统用户表主键',
  `uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方系统的唯一ID',
  `source` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方用户来源',
  `access_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户的授权令牌',
  `expire_in` int(11) NULL DEFAULT NULL COMMENT '第三方用户的授权令牌的有效期（部分平台可能没有）',
  `refresh_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '刷新令牌(部分平台可能没有)',
  `open_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户的 open id（部分平台可能没有）',
  `uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户的 ID(部分平台可能没有)',
  `access_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息（部分平台可能没有）',
  `union_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户的 union id(部分平台可能没有)',
  `scope` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户授予的权限(部分平台可能没有)',
  `token_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息（部分平台可能没有）',
  `id_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'id token（部分平台可能没有）',
  `mac_algorithm` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性（部分平台可能没有）',
  `mac_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性(部分平台可能没有)',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户的授权code（部分平台可能没有）',
  `oauth_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性(部分平台可能没有)',
  `oauth_token_secret` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性(部分平台可能没有)',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记位(0代表存在,2代表删除)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '绑定状态(0:未绑定,1:绑定)',
  `sys_user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `gender` tinyint(4) NULL DEFAULT NULL COMMENT '用户性别',
  UNIQUE INDEX `iot_social_user_pk`(`social_user_id`) USING BTREE,
  UNIQUE INDEX `iot_social_user_unique_key`(`uuid`, `source`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方登录用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_social_user
-- ----------------------------

-- ----------------------------
-- Table structure for iot_things_model
-- ----------------------------
DROP TABLE IF EXISTS `iot_things_model`;
CREATE TABLE `iot_things_model`  (
  `model_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物模型ID',
  `model_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物模型名称',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `identifier` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符，产品下唯一',
  `type` tinyint(1) NOT NULL COMMENT '模型类别（1-属性，2-功能，3-事件）',
  `datatype` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据类型（integer、decimal、string、bool、array、enum）',
  `specs` json NOT NULL COMMENT '数据定义',
  `is_Top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否首页显示（0-否，1-是）',
  `is_Monitor` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否实时监测（0-否，1-是）',
  `is_readonly` tinyint(1) NULL DEFAULT 0 COMMENT '是否只读数据(0-否，1-是)',
  `model_order` int(10) NULL DEFAULT 0 COMMENT '排序，值越大，排序越靠前',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`model_id`) USING BTREE,
  INDEX `iot_things_model_index_product_id`(`product_id`) USING BTREE,
  INDEX `iot_things_model_index_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_things_model_index_model_order`(`model_order`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 179 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物模型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_things_model
-- ----------------------------
INSERT INTO `iot_things_model` VALUES (113, '设备开关', 41, '温湿度智能开关', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 0, 0, 9, '0', NULL, '2022-08-14 00:06:53', '', '2023-02-26 02:20:10', NULL);
INSERT INTO `iot_things_model` VALUES (125, '空气温度', 41, '温湿度智能开关', 1, 'admin', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, 0, 1, '0', NULL, '2022-11-05 23:56:21', '', '2023-02-12 20:52:14', NULL);
INSERT INTO `iot_things_model` VALUES (126, '空气湿度', 41, '温湿度智能开关', 1, 'admin', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, 0, 3, '0', NULL, '2022-11-05 23:56:21', '', '2023-02-12 20:52:36', NULL);
INSERT INTO `iot_things_model` VALUES (127, '二氧化碳', 41, '温湿度智能开关', 1, 'admin', 'co2', 1, 'integer', '{\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}', 0, 1, 0, 2, '0', NULL, '2022-11-05 23:56:21', '', '2023-02-12 20:52:23', NULL);
INSERT INTO `iot_things_model` VALUES (128, '室内亮度', 41, '温湿度智能开关', 1, 'admin', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 0, 1, 0, 4, '0', NULL, '2022-11-05 23:56:21', '', '2023-02-12 20:52:47', NULL);
INSERT INTO `iot_things_model` VALUES (129, '运行档位', 41, '温湿度智能开关', 1, 'admin', 'gear', 2, 'enum', '{\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 1, 0, 0, 8, '0', NULL, '2022-11-05 23:56:21', '', '2023-02-26 02:20:20', NULL);
INSERT INTO `iot_things_model` VALUES (130, '灯光色值', 41, '温湿度智能开关', 1, 'admin', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"integer\", \"arrayCount\": \"3\"}', 0, 0, 0, 5, '0', NULL, '2022-11-05 23:56:21', '', '2023-02-26 02:21:19', NULL);
INSERT INTO `iot_things_model` VALUES (131, '屏显消息', 41, '温湿度智能开关', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, 0, 7, '0', NULL, '2022-11-05 23:56:21', '', '2023-02-26 02:20:54', NULL);
INSERT INTO `iot_things_model` VALUES (132, '上报数据', 41, '温湿度智能开关', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 0, 0, 0, 10, '0', NULL, '2022-11-05 23:56:21', '', '2023-02-26 02:19:59', NULL);
INSERT INTO `iot_things_model` VALUES (134, '环境温度过高', 41, '温湿度智能开关', 1, 'admin', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 0, 0, 0, 0, '0', NULL, '2022-11-05 23:56:29', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (135, '设备发生异常', 41, '温湿度智能开关', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, 0, 0, '0', NULL, '2022-11-05 23:56:29', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (161, '子设备', 96, '网关产品', 1, 'admin', 'device', 1, 'array', '{\"type\": \"array\", \"params\": [{\"id\": \"device_co2\", \"name\": \"二氧化碳\", \"isTop\": 0, \"order\": 0, \"datatype\": {\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"device_temperature\", \"name\": \"空气温度-只读\", \"isTop\": 1, \"order\": 4, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"device_gear\", \"name\": \"运行档位\", \"isTop\": 1, \"order\": 6, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_switch\", \"name\": \"设备开关\", \"isTop\": 1, \"order\": 5, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"order\": 9, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isMonitor\": 0, \"isReadonly\": 0}], \"arrayType\": \"object\", \"arrayCount\": 5}', 1, 0, 0, 10, '0', NULL, '2023-02-25 22:51:53', '', '2023-02-26 00:59:09', NULL);
INSERT INTO `iot_things_model` VALUES (162, '功能分组', 96, '网关产品', 1, 'admin', 'category', 1, 'object', '{\"type\": \"object\", \"params\": [{\"id\": \"category_light\", \"name\": \"光照\", \"isTop\": 0, \"order\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"category_humidity\", \"name\": \"空气湿度\", \"isTop\": 1, \"order\": 2, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"category_temperature\", \"name\": \"空气温度-只读\", \"isTop\": 1, \"order\": 3, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"category_report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"order\": 6, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_gear\", \"name\": \"运行档位\", \"isTop\": 1, \"order\": 5, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_switch\", \"name\": \"设备开关\", \"isTop\": 1, \"order\": 4, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isMonitor\": 0, \"isReadonly\": 0}]}', 1, 0, 0, 9, '0', NULL, '2023-02-25 22:51:53', '', '2023-02-26 00:59:25', NULL);
INSERT INTO `iot_things_model` VALUES (163, '空气温度', 96, '网关产品', 1, 'admin', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (164, '设备开关', 96, '网关产品', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 0, 0, 8, '0', NULL, '2023-02-25 22:52:16', '', '2023-02-26 00:50:44', NULL);
INSERT INTO `iot_things_model` VALUES (165, '运行档位', 96, '网关产品', 1, 'admin', 'gear', 2, 'enum', '{\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 1, 0, 0, 7, '0', NULL, '2023-02-25 22:52:16', '', '2023-02-25 22:54:27', NULL);
INSERT INTO `iot_things_model` VALUES (166, '灯光色值', 96, '网关产品', 1, 'admin', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"integer\", \"arrayCount\": \"3\"}', 0, 0, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (167, '上报监测数据', 96, '网关产品', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 0, 0, 0, 11, '0', NULL, '2023-02-25 22:52:16', '', '2023-02-26 00:50:26', NULL);
INSERT INTO `iot_things_model` VALUES (168, '环境温度过高', 96, '网关产品', 1, 'admin', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 0, 0, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (169, '设备发生异常', 96, '网关产品', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (170, '屏显消息', 96, '网关产品', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, 0, 0, '0', NULL, '2023-02-25 22:52:35', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (171, '设备重启', 96, '网关产品', 1, 'admin', 'reset', 2, 'string', '{\"type\": \"string\", \"maxLength\": 64}', 1, 0, 0, 0, '0', NULL, '2023-02-25 22:52:35', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (174, '室内亮度', 96, '网关产品', 1, 'admin', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 0, 1, 0, 0, '0', NULL, '2023-02-26 00:56:39', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (175, '设备重启', 41, '智能开关', 1, 'admin', 'reset', 2, 'string', '{\"type\": \"string\", \"maxLength\": 64}', 1, 0, 0, 6, '0', NULL, '2023-02-26 02:20:40', '', '2023-02-26 02:21:07', NULL);

-- ----------------------------
-- Table structure for iot_things_model_template
-- ----------------------------
DROP TABLE IF EXISTS `iot_things_model_template`;
CREATE TABLE `iot_things_model_template`  (
  `template_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物模型ID',
  `template_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物模型名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `identifier` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符，产品下唯一',
  `type` tinyint(1) NOT NULL COMMENT '模型类别（1-属性，2-功能，3-事件）',
  `datatype` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据类型（integer、decimal、string、bool、array、enum）',
  `specs` json NOT NULL COMMENT '数据定义',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否系统通用（0-否，1-是）',
  `is_Top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否首页显示（0-否，1-是）',
  `is_Monitor` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否实时监测（0-否，1-是）',
  `is_readonly` tinyint(1) NULL DEFAULT 0 COMMENT '是否只读数据(0-否，1-是)',
  `model_order` int(10) NULL DEFAULT 0 COMMENT '排序，值越大，排序越靠前',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`template_id`) USING BTREE,
  INDEX `iot_things_model_template_index_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_things_model_template_index_model_order`(`model_order`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物模型模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_things_model_template
-- ----------------------------
INSERT INTO `iot_things_model_template` VALUES (1, '空气温度', 1, 'admin', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, 1, 0, 4, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-02-25 22:44:25', NULL);
INSERT INTO `iot_things_model_template` VALUES (2, '空气湿度', 1, 'admin', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, 1, 0, 3, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-02-25 22:44:31', NULL);
INSERT INTO `iot_things_model_template` VALUES (3, '二氧化碳', 1, 'admin', 'co2', 1, 'integer', '{\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}', 1, 0, 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:10:09', NULL);
INSERT INTO `iot_things_model_template` VALUES (4, '室内亮度', 1, 'admin', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 1, 0, 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:10:17', NULL);
INSERT INTO `iot_things_model_template` VALUES (5, '设备开关', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 1, 0, 0, 5, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-02-25 22:44:04', NULL);
INSERT INTO `iot_things_model_template` VALUES (6, '运行档位', 1, 'admin', 'gear', 2, 'enum', '{\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 1, 1, 0, 0, 6, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-02-25 22:43:59', NULL);
INSERT INTO `iot_things_model_template` VALUES (7, '灯光色值', 1, 'admin', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"integer\", \"arrayCount\": \"3\"}', 1, 0, 0, 0, 2, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-02-25 22:44:59', NULL);
INSERT INTO `iot_things_model_template` VALUES (8, '屏显消息', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 1, 0, 0, 0, 1, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-02-25 22:45:04', NULL);
INSERT INTO `iot_things_model_template` VALUES (9, '上报监测数据', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 1, 0, 0, 0, 9, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-02-25 22:43:37', NULL);
INSERT INTO `iot_things_model_template` VALUES (10, '环境温度过高', 1, 'admin', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 0, 0, 0, 8, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-02-25 22:43:46', NULL);
INSERT INTO `iot_things_model_template` VALUES (11, '设备发生异常', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 1, 0, 0, 0, 7, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-02-25 22:43:51', NULL);
INSERT INTO `iot_things_model_template` VALUES (12, '光照', 1, 'admin', 'light', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}', 0, 0, 1, 0, 0, '0', 'wumei', '2022-05-07 09:41:17', 'admin', '2023-02-20 23:22:21', NULL);
INSERT INTO `iot_things_model_template` VALUES (13, '压力', 1, 'admin', 'pressure', 1, 'decimal', '{\"max\": 200, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"帕斯卡\"}', 1, 1, 1, 1, 0, '0', 'admin', '2023-02-20 22:39:18', '', NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (14, '设备重启', 1, 'admin', 'reset', 2, 'string', '{\"type\": \"string\", \"maxLength\": 64}', 1, 1, 0, 0, 0, '0', 'admin', '2023-02-20 23:15:25', '', NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (15, '电池电压', 1, 'admin', 'voltage', 1, 'decimal', '{\"max\": 5, \"min\": 0, \"step\": 0.001, \"type\": \"decimal\", \"unit\": \"V\"}', 1, 1, 1, 1, 0, '0', 'admin', '2023-02-20 23:17:43', 'admin', '2023-02-20 23:22:36', NULL);
INSERT INTO `iot_things_model_template` VALUES (16, '饮水量', 1, 'admin', 'shuiliang', 1, 'integer', '{\"max\": 500, \"min\": 80, \"step\": 1, \"type\": \"integer\", \"unit\": \"ML\"}', 1, 1, 1, 1, 0, '0', 'admin', '2023-02-20 23:18:39', '', NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (17, '灯光', 1, 'admin', 'light', 1, 'integer', '{\"max\": 1000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"Lux\"}', 1, 1, 1, 1, 0, '0', 'admin', '2023-02-20 23:19:23', '', NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (18, '长度', 1, 'admin', 'length', 1, 'integer', '{\"max\": 2000, \"min\": 1, \"step\": 5, \"type\": \"integer\", \"unit\": \"M\"}', 1, 1, 1, 1, 0, '0', 'admin', '2023-02-20 23:20:03', '', NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (19, '心率', 1, 'admin', 'heart-rate', 1, 'integer', '{\"max\": 250, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 1, 1, 1, 1, 0, '0', 'admin', '2023-02-20 23:21:46', '', NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (20, '光照强度', 1, 'admin', 'light_level', 1, 'integer', '{\"max\": 89.2, \"min\": 2.5, \"step\": 0.1, \"type\": \"integer\", \"unit\": \"L/g\"}', 1, 1, 1, 1, 0, '0', 'admin', '2023-02-20 23:24:36', '', NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (21, '状态灯色', 1, 'admin', 'color', 2, 'enum', '{\"type\": \"enum\", \"enumList\": [{\"text\": \"红色\", \"value\": \"0\"}, {\"text\": \"绿色\", \"value\": \"1\"}, {\"text\": \"蓝色\", \"value\": \"2\"}, {\"text\": \"黄色\", \"value\": \"3\"}]}', 1, 1, 0, 0, 0, '0', 'admin', '2023-02-20 23:26:24', '', NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (22, '子设备', 1, 'admin', 'device', 2, 'array', '{\"type\": \"array\", \"params\": [{\"id\": \"device_co2\", \"name\": \"二氧化碳\", \"isTop\": 0, \"order\": 0, \"datatype\": {\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\", \"enumList\": [{\"text\": \"\", \"value\": \"\"}], \"arrayType\": \"int\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"device_temperature\", \"name\": \"空气温度-只读\", \"isTop\": 1, \"order\": 4, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"device_gear\", \"name\": \"运行档位\", \"isTop\": 1, \"order\": 6, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}], \"arrayType\": \"int\"}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_switch\", \"name\": \"设备开关\", \"isTop\": 1, \"order\": 5, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"order\": 9, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\", \"enumList\": [{\"text\": \"\", \"value\": \"\"}], \"arrayType\": \"int\"}, \"isMonitor\": 0, \"isReadonly\": 0}], \"arrayType\": \"object\", \"arrayCount\": 5}', 1, 1, 0, 0, 10, '0', 'admin', '2023-02-24 01:10:43', 'admin', '2023-02-26 00:58:40', NULL);
INSERT INTO `iot_things_model_template` VALUES (23, '功能分组', 1, 'admin', 'category', 2, 'object', '{\"type\": \"object\", \"params\": [{\"id\": \"category_light\", \"name\": \"光照\", \"isTop\": 0, \"order\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"category_humidity\", \"name\": \"空气湿度\", \"isTop\": 1, \"order\": 2, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isMonitor\": 1, \"isReadonly\": 0}, {\"id\": \"category_temperature\", \"name\": \"空气温度-只读\", \"isTop\": 1, \"order\": 3, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"category_report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"order\": 6, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_gear\", \"name\": \"运行档位\", \"isTop\": 1, \"order\": 5, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_switch\", \"name\": \"设备开关\", \"isTop\": 1, \"order\": 4, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isMonitor\": 0, \"isReadonly\": 0}]}', 1, 1, 0, 0, 11, '0', 'admin', '2023-02-25 22:41:43', 'admin', '2023-02-26 00:58:28', NULL);

-- ----------------------------
-- Table structure for media_server
-- ----------------------------
DROP TABLE IF EXISTS `media_server`;
CREATE TABLE `media_server`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '流媒体配置ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `enabled` tinyint(1) NULL DEFAULT NULL COMMENT '使能开关',
  `protocol` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '默认播放协议',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务器ip',
  `domain` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务器域名',
  `secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '流媒体密钥',
  `port_http` int(11) NOT NULL DEFAULT 0 COMMENT 'http端口',
  `port_ws` int(11) NOT NULL DEFAULT 0 COMMENT 'ws端口',
  `port_rtmp` int(11) NOT NULL DEFAULT 0 COMMENT 'rtmp端口',
  `port_rtsp` int(11) NOT NULL DEFAULT 0 COMMENT 'rtsp端口',
  `rtp_port_range` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'rtp端口范围',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流媒体服务器配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of media_server
-- ----------------------------
INSERT INTO `media_server` VALUES (1, 1, 'admin', 1, 'https', '1.1.1.1', 'fastbee', '035c73f7-bb6b-4889-a715-d9eb2d192xxx', 8082, 8082, 1935, 554, '30000,30500', '0', '', '2021-12-29 13:12:42', '', '2023-02-26 22:35:09', 'admin');
-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `news_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '新闻ID',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `img_url` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '封面',
  `is_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶(0-置顶 1-置顶)',
  `is_banner` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否banner(0-是banner 1-不是banner)',
  `category_id` bigint(20) NOT NULL COMMENT '分类ID',
  `category_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '新闻状态（0-未发布，1-已发布）',
  `author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`news_id`) USING BTREE,
  INDEX `news_index_category_id`(`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '新闻资讯' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, '广告图一', '<p>请后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-215805.png', 0, 1, 2, '相关产品', 1, '物美智能', '0', '', '2022-05-12 12:13:40', '', '2022-05-12 12:13:40', '物美智能');
INSERT INTO `news` VALUES (2, '广告图二', '<p>请后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-215852.png', 0, 1, 1, '新闻资讯', 1, '物美智能', '0', '', '2022-05-12 12:13:42', '', '2022-05-12 12:13:42', '物美智能');
INSERT INTO `news` VALUES (3, '广告图三', '<p>后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-224553.png', 0, 1, 2, '相关产品', 1, '物美智能', '0', '', '2022-05-12 12:13:44', '', '2022-05-12 12:13:44', '物美智能');
INSERT INTO `news` VALUES (4, '物美智能-快速搭建物联网和智能家居平台', '<p class=\"ql-align-justify\">物美智能 wumei-smart 是一个简单易用的生活物联网平台。可用于搭建物联网平台以及二次开发和学习。设备接入使用EMQX消息服务器，加密认证；后端采用Spring boot；前端采用Vue；移动端采用Uniapp；数据库采用Mysql和Redis；设备端支持ESP32、ESP8266、树莓派等；</p><p class=\"ql-align-justify\"><img src=\"/prod-api/profile/upload/2022/05/11/5f479f25-b85d-4c9f-b6a7-deadd2cdec76.png\"></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong>系统功能介绍</strong></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">1.权限管理： 用户管理、部门管理、岗位管理、菜单管理、角色管理、字典和参数管理等</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">2.系统监控： 操作日志、登录日志、系统日志、在线用户、服务监控、连接池监控、缓存监控等</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">3.产品管理： 产品、产品物模型、产品分类、产品固件、授权码等</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">4.设备管理： 控制、分组、定时、日志、统计、定位、OTA升级、影子模式、实时监测、加密认证等</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">5.EMQ管理： Mqtt客户端、监听器、消息主题、消息订阅、插件管理、规则引擎、资源</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">6.硬件 SDK： 支持WIFI和MQTT连接、物模型响应、实时监测、定时上报监测数据、AES加密、NTP时间等</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">7.物模型管理： 属性（设备状态和监测数据），功能（执行特定任务），事件（设备主动上报给云端）</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">8.其他（开发中）：第三方登录，设备分享、设备告警、场景联动（进度50%），智能音箱、多租户、APP界面自定义（进度40%），时序数据库、分布式集群部署、Granfa监控（进度30%），视频流处理、桌面端模拟器/监控、安卓端模拟器/监控（进度20%）</p><p class=\"ql-align-justify\"><strong>﻿</strong></p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\"><strong>硬件设备接入流程</strong></p><p><br></p><p>1.设备认证：加密认证、简单认证和emqx支持的多种认证方式。</p><p class=\"ql-align-justify\">2.设备交互：发布和订阅物模型、设备信息、设备升级和时钟同步等mqtt主题</p>', '/iot/tool/download?fileName=/profile/iot/1/2022-0508-133031.png', 1, 0, 2, '相关产品', 1, '物美智能', '0', '', '2022-05-12 12:13:46', '', '2022-05-12 12:13:46', '物美智能');
INSERT INTO `news` VALUES (5, '2022年中国物联网全景图产业链上中下游市场及企业剖析', '<p>后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-224151.png', 1, 0, 1, '新闻资讯', 1, '物美智能', '0', '', '2022-05-12 12:13:48', '', '2022-05-12 12:13:48', '物美智能');
INSERT INTO `news` VALUES (6, 'Arm打造物联网全面解决方案 携手合作伙伴共探智能未来', '<p>后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-224352.png', 1, 0, 1, '新闻资讯', 1, '物美智能', '0', '', '2022-05-12 12:13:50', '', '2022-05-12 12:13:50', '物美智能');
INSERT INTO `news` VALUES (7, '使用ESP32开发板，快速学习物联网开发', '<p>请后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0428-130824.jpg', 1, 0, 2, '相关产品', 1, '物美智能', '0', '', '2022-05-12 12:13:53', '', '2022-05-12 12:13:53', '物美智能');
INSERT INTO `news` VALUES (8, '物联网赛道观察之无源物联网', '<p>无源物联网，即终端无外接能量源，采用获取环境能量的方式进行供能的物联网技术。在当前物联网技术发展条件下，终端覆盖率是一个亟待解决的问题，而无源物联网凭借其极低的部署和维护成本、灵活多变的应用场景成为解决更广范围内终端供能需求问题、实现“千亿级互联”愿景的关键。</p><p><br></p><p>无源物联网技术的发展最终有赖于环境能量采集、低功耗计算与反向散射等低功耗通讯技术的进步。目前无源物联网应用较为成熟的路线主要包括射频识别技术（RFID）与近场通信技术（NFC）两类，覆盖仓储物流、智能制造、智慧零售、资产管理、物业服务等多元应用场景。未来，随着物联网行业的碎片化整合以及以Bluetooth、5G、LoRa等为媒介进行能量采集与信息传输的技术路线的逐渐成熟，当前困扰行业的诸多问题将会逐步得到解决，随之而来的是更包罗多样的无源终端需求与极具潜力的应用场景。</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-215643.png', 1, 0, 1, '新闻资讯', 1, '物美智能', '0', '', '2022-05-12 12:13:55', '', '2022-05-12 12:13:55', '物美智能');

-- ----------------------------
-- Table structure for news_category
-- ----------------------------
DROP TABLE IF EXISTS `news_category`;
CREATE TABLE `news_category`  (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `order_num` int(2) NOT NULL COMMENT '显示顺序',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '新闻分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news_category
-- ----------------------------
INSERT INTO `news_category` VALUES (1, '新闻资讯', 3, '0', '', '2022-04-11 20:53:55', '', '2022-04-13 15:30:22', '新闻资讯信息');
INSERT INTO `news_category` VALUES (2, '相关产品', 2, '0', '', '2022-04-11 20:54:16', '', '2022-04-13 15:30:15', '相关产品推荐');

-- ----------------------------
-- Table structure for oauth_access_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_token`;
CREATE TABLE `oauth_access_token`  (
  `token_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` blob NULL,
  `authentication_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `authentication` blob NULL,
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_access_token
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_approvals
-- ----------------------------
DROP TABLE IF EXISTS `oauth_approvals`;
CREATE TABLE `oauth_approvals`  (
  `userId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `clientId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `expiresAt` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `lastModifiedAt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_approvals
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
CREATE TABLE `oauth_client_details`  (
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端ID',
  `resource_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端所能访问的资源id集合,多个资源时用逗号(,)分隔',
  `client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端秘钥',
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限范围,可选值包括read,write,trust;若有多个权限范围用逗号(,)分隔',
  `authorized_grant_types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权模式，可选值包括authorization_code,password,refresh_token,implicit,client_credentials, 若支持多个grant_type用逗号(,)分隔',
  `web_server_redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回调地址',
  `authorities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限',
  `access_token_validity` int(11) NULL DEFAULT NULL COMMENT '设定客户端的access_token的有效时间值(单位:秒)',
  `refresh_token_validity` int(11) NULL DEFAULT NULL COMMENT '设定客户端的refresh_token的有效时间值(单位:秒)',
  `additional_information` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '预留的字段,在Oauth的流程中没有实际的使用,可选,但若设置值,必须是JSON格式的数据',
  `autoapprove` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设置用户是否自动Approval操作, 默认值为 \'false\', 可选值包括 \'true\',\'false\', \'read\',\'write\'. \n该字段只适用于grant_type=\"authorization_code\"的情况,当用户登录成功后,若该值为\'true\'或支持的scope值,则会跳过用户Approve的页面, 直接授权. ',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '1=小度(DuerOS),2=天猫精灵(ALiGenie),3=小米小爱',
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
INSERT INTO `oauth_client_details` VALUES ('speaker', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'client_credentials,password,authorization_code,implicit,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 1);
INSERT INTO `oauth_client_details` VALUES ('tianmao', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', '\r\nhttps://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'true', 2);
INSERT INTO `oauth_client_details` VALUES ('xiaoai', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'true', 3);
INSERT INTO `oauth_client_details` VALUES ('xiaoyi', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 4);

-- ----------------------------
-- Table structure for oauth_client_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_token`;
CREATE TABLE `oauth_client_token`  (
  `token_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` blob NULL,
  `authentication_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_client_token
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_code
-- ----------------------------
DROP TABLE IF EXISTS `oauth_code`;
CREATE TABLE `oauth_code`  (
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `authentication` blob NULL
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_code
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_token`;
CREATE TABLE `oauth_refresh_token`  (
  `token_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` blob NULL,
  `authentication` blob NULL
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_refresh_token
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', '757800fac9dc1677411902596', 1677425796906, 15000);
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', '蜂信1677425325745', 1677425798475, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sip_config
-- ----------------------------
DROP TABLE IF EXISTS `sip_config`;
CREATE TABLE `sip_config`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品名称',
  `enabled` tinyint(1) NULL DEFAULT NULL COMMENT '使能开关',
  `isdefault` tinyint(1) NULL DEFAULT NULL COMMENT '系统默认配置',
  `seniorSdp` tinyint(1) NULL DEFAULT NULL COMMENT '拓展sdp',
  `domain` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务器域',
  `server_sipid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务器sipid',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'sip认证密码',
  `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sip接入IP',
  `port` bigint(10) NULL DEFAULT NULL COMMENT 'sip接入端口号',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'sip系统配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sip_config
-- ----------------------------
INSERT INTO `sip_config` VALUES (37, 1, 'admin', 94, '', 1, 1, NULL, '3402000000', '34020000002000000001', 'fastbee', '177.7.0.13', 5061, '0', '', '2023-02-26 03:44:34', '', '2023-02-26 14:48:17', NULL);

-- ----------------------------
-- Table structure for sip_device
-- ----------------------------
DROP TABLE IF EXISTS `sip_device`;
CREATE TABLE `sip_device`  (
  `device_id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `product_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品名称',
  `device_sip_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备SipID',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设备名称',
  `manufacturer` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '厂商名称',
  `model` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品型号',
  `firmware` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '固件版本',
  `transport` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'UDP' COMMENT '传输模式',
  `streamMode` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'UDP' COMMENT '流模式',
  `online` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '在线状态',
  `registerTime` datetime(0) NOT NULL COMMENT '注册时间',
  `lastConnectTime` datetime(0) NULL DEFAULT NULL COMMENT '最后上线时间',
  `active_time` datetime(0) NULL DEFAULT NULL COMMENT '激活时间',
  `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备入网IP',
  `port` bigint(10) NULL DEFAULT NULL COMMENT '设备接入端口号',
  `hostAddress` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备地址',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '监控设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sip_device
-- ----------------------------
INSERT INTO `sip_device` VALUES (9, 0, '', '13030300001170000008', '8E085C3RAJE156F', 'Dahua', 'DH-3H3205-ADW', '2.810.0000027.0.R,2022-08-26', 'UDP', 'UDP', '', '2023-02-26 22:52:06', '2023-02-26 23:36:45', NULL, '183.225.206.92', 9862, '183.225.206.92:9862', '0', '', NULL, '', NULL, NULL);
-- ----------------------------
-- Table structure for sip_device_channel
-- ----------------------------
DROP TABLE IF EXISTS `sip_device_channel`;
CREATE TABLE `sip_device_channel`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `product_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品名称',
  `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '产品ID',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品名称',
  `device_sip_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备SipID',
  `channel_sip_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通道SipID',
  `channel_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通道名称',
  `register_time` datetime(0) NULL DEFAULT NULL COMMENT '注册时间',
  `device_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备类型',
  `channel_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '通道类型',
  `cityCode` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市编码',
  `civilCode` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '行政区域',
  `manufacture` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '厂商名称',
  `model` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品型号',
  `owner` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设备归属',
  `block` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '警区',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '安装地址',
  `parentId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '父级id',
  `ipAddress` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '设备入网IP',
  `port` bigint(10) NULL DEFAULT 0 COMMENT '设备接入端口号',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `PTZType` bigint(20) NOT NULL DEFAULT 0 COMMENT 'PTZ类型',
  `PTZTypeText` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'PTZ类型描述字符串',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '设备状态（1-未激活，2-禁用，3-在线，4-离线）',
  `longitude` double(11, 6) NULL DEFAULT NULL COMMENT '设备经度',
  `latitude` double(11, 6) NULL DEFAULT NULL COMMENT '设备纬度',
  `streamId` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '流媒体ID',
  `subCount` bigint(20) NOT NULL DEFAULT 0 COMMENT '子设备数',
  `parental` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有子设备（1-有, 0-没有）',
  `hasAudio` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否含有音频（1-有, 0-没有）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`, `device_sip_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '监控设备通道信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sip_device_channel
-- ----------------------------
INSERT INTO `sip_device_channel` VALUES (71, 1, 'admin', 94, '测试监控产品', 1, 'admin', '13030300001170000008', '13030300001340000001', '大华-模糊处理', '2023-02-25 18:09:08', '117', '134', '河北省/秦皇岛市/山海关区', '340200', 'Dahua', 'DH-3H3205-ADW', '0', '', 'axy', '13030300001170000008', '', 0, '', 0, '', 2, 0.000000, 0.000000, 'gb_play_13030300001170000008_13030300001340000001', 0, 0, 1, '0', '', '2023-02-25 17:59:40', '', NULL, NULL);
INSERT INTO `sip_device_channel` VALUES (72, 1, 'admin', 94, '测试监控产品', 1, 'admin', '13030300001170000008', '13030300001340000002', '', NULL, '117', '134', '河北省/秦皇岛市/山海关区', '', '', '', '', '', '', '', '', 0, '', 0, '', 1, NULL, NULL, '', 0, 1, 1, '0', '', '2023-02-25 17:59:40', '', NULL, NULL);
INSERT INTO `sip_device_channel` VALUES (73, 1, 'admin', 94, '测试监控产品', 1, 'admin', '13030300001170000008', '13030300001340000003', '', NULL, '117', '134', '河北省/秦皇岛市/山海关区', '', '', '', '', '', '', '', '', 0, '', 0, '', 1, NULL, NULL, '', 0, 1, 1, '0', '', '2023-02-25 17:59:40', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_auth_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_user`;
CREATE TABLE `sys_auth_user`  (
  `auth_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '授权ID',
  `uuid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方平台用户唯一ID',
  `user_id` bigint(20) NOT NULL COMMENT '系统用户ID',
  `login_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户来源',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`auth_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方授权表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaOnOff', 'true', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2021-12-15 21:36:18', 'admin', '2021-12-24 22:43:33', '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '蜂信物联', 0, 'FastBee', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-02-26 23:06:24');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '北京总公司', 1, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-03-09 16:49:53');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '深圳分公司', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-02-26 23:06:07');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '物美', '15888888888', '164770707@qq.com', '1', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-01 23:12:40');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 191 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '属性', '1', 'iot_things_type', '', 'primary', 'Y', '0', 'admin', '2021-12-12 16:41:15', 'admin', '2021-12-15 22:49:37', '');
INSERT INTO `sys_dict_data` VALUES (101, 2, '功能', '2', 'iot_things_type', '', 'success', 'Y', '0', 'admin', '2021-12-12 16:43:33', 'admin', '2021-12-14 16:33:11', '');
INSERT INTO `sys_dict_data` VALUES (102, 3, '事件', '3', 'iot_things_type', NULL, 'warning', 'Y', '0', 'admin', '2021-12-12 16:46:04', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 1, '整数', 'integer', 'iot_data_type', '', '', 'Y', '0', 'admin', '2021-12-12 20:20:46', 'admin', '2021-12-14 16:09:56', '');
INSERT INTO `sys_dict_data` VALUES (104, 2, '小数', 'decimal', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:21:21', 'admin', '2021-12-15 22:51:07', NULL);
INSERT INTO `sys_dict_data` VALUES (105, 3, '布尔', 'bool', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:22:12', 'admin', '2021-12-15 22:51:02', NULL);
INSERT INTO `sys_dict_data` VALUES (106, 4, '枚举', 'enum', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:22:37', 'admin', '2021-12-15 22:50:57', NULL);
INSERT INTO `sys_dict_data` VALUES (107, 5, '字符串', 'string', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:22:54', 'admin', '2021-12-15 22:50:52', NULL);
INSERT INTO `sys_dict_data` VALUES (108, 1, '是', '1', 'iot_yes_no', '', 'default', 'Y', '0', 'admin', '2021-12-12 20:25:14', 'admin', '2022-01-02 13:39:09', '');
INSERT INTO `sys_dict_data` VALUES (109, 2, '否', '0', 'iot_yes_no', '', 'default', 'Y', '0', 'admin', '2021-12-12 20:25:25', 'admin', '2022-01-02 13:39:15', '');
INSERT INTO `sys_dict_data` VALUES (110, 6, '数组', 'array', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-13 18:18:04', 'admin', '2021-12-15 22:50:42', NULL);
INSERT INTO `sys_dict_data` VALUES (111, 1, '未发布', '1', 'iot_product_status', NULL, 'info', 'N', '0', 'admin', '2021-12-19 15:01:18', 'admin', '2021-12-19 15:01:55', NULL);
INSERT INTO `sys_dict_data` VALUES (112, 2, '已发布', '2', 'iot_product_status', NULL, 'success', 'N', '0', 'admin', '2021-12-19 15:01:43', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 1, '直连设备', '1', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:03:49', 'admin', '2021-12-19 15:10:13', NULL);
INSERT INTO `sys_dict_data` VALUES (114, 2, '网关设备', '2', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:04:28', 'admin', '2023-02-09 16:25:46', NULL);
INSERT INTO `sys_dict_data` VALUES (116, 1, 'WIFI', '1', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:07:35', 'admin', '2021-12-22 00:11:19', NULL);
INSERT INTO `sys_dict_data` VALUES (117, 2, '蜂窝(2G/3G/4G/5G)', '2', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:08:30', 'admin', '2022-01-14 02:12:27', NULL);
INSERT INTO `sys_dict_data` VALUES (118, 3, '以太网', '3', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:09:08', 'admin', '2022-01-14 02:12:39', NULL);
INSERT INTO `sys_dict_data` VALUES (119, 1, '简单认证', '1', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:13:16', 'admin', '2022-06-05 00:14:48', NULL);
INSERT INTO `sys_dict_data` VALUES (120, 2, '加密认证', '2', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:13:26', 'admin', '2022-06-05 00:14:57', NULL);
INSERT INTO `sys_dict_data` VALUES (122, 1, 'ESP8266/Arduino', '1', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 15:54:52', 'admin', '2021-12-24 16:07:31', NULL);
INSERT INTO `sys_dict_data` VALUES (123, 3, 'ESP32/Arduino', '2', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 15:55:04', 'admin', '2021-12-24 16:07:26', NULL);
INSERT INTO `sys_dict_data` VALUES (124, 2, 'ESP8266/RTOS', '3', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 15:56:08', 'admin', '2021-12-24 16:07:17', NULL);
INSERT INTO `sys_dict_data` VALUES (127, 4, 'ESP32/ESP-IDF', '4', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 16:07:54', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (128, 5, '树莓派/Python', '5', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 16:08:31', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (129, 0, '未激活', '1', 'iot_device_status', NULL, 'warning', 'N', '0', 'admin', '2021-12-27 22:21:04', 'admin', '2021-12-27 22:22:09', NULL);
INSERT INTO `sys_dict_data` VALUES (130, 0, '禁用', '2', 'iot_device_status', NULL, 'danger', 'N', '0', 'admin', '2021-12-27 22:21:22', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (131, 0, '在线', '3', 'iot_device_status', NULL, 'success', 'N', '0', 'admin', '2021-12-27 22:21:42', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (132, 0, '离线', '4', 'iot_device_status', NULL, 'info', 'N', '0', 'admin', '2021-12-27 22:22:01', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (133, 0, '启用', '1', 'iot_is_enable', NULL, 'success', 'N', '0', 'admin', '2022-01-12 23:25:08', 'admin', '2022-01-12 23:25:30', NULL);
INSERT INTO `sys_dict_data` VALUES (134, 0, '禁用', '0', 'iot_is_enable', NULL, 'info', 'N', '0', 'admin', '2022-01-12 23:25:19', 'admin', '2022-01-12 23:25:38', NULL);
INSERT INTO `sys_dict_data` VALUES (135, 0, '提醒通知', '1', 'iot_alert_level', NULL, 'success', 'N', '0', 'admin', '2022-01-13 14:58:10', 'admin', '2022-01-13 14:58:31', NULL);
INSERT INTO `sys_dict_data` VALUES (136, 0, '轻微问题', '2', 'iot_alert_level', NULL, 'warning', 'N', '0', 'admin', '2022-01-13 14:59:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (137, 0, '严重警告', '3', 'iot_alert_level', NULL, 'danger', 'N', '0', 'admin', '2022-01-13 14:59:16', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (138, 0, '不需要处理', '1', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', '2022-01-13 15:06:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (139, 0, '未处理', '2', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', '2022-01-13 15:06:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (140, 0, '已处理', '3', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', '2022-01-13 15:06:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (141, 1, '属性上报', '1', 'iot_device_log_type', NULL, 'primary', 'N', '0', 'admin', '2022-01-13 15:10:32', 'admin', '2022-03-13 00:20:25', NULL);
INSERT INTO `sys_dict_data` VALUES (142, 3, '事件上报', '3', 'iot_device_log_type', NULL, 'danger', 'N', '0', 'admin', '2022-01-13 15:10:43', 'admin', '2022-03-13 00:21:00', NULL);
INSERT INTO `sys_dict_data` VALUES (143, 2, '功能调用', '2', 'iot_device_log_type', NULL, 'warning', 'N', '0', 'admin', '2022-01-13 15:10:55', 'admin', '2022-03-13 00:20:32', NULL);
INSERT INTO `sys_dict_data` VALUES (144, 4, '设备升级', '4', 'iot_device_log_type', NULL, 'success', 'N', '0', 'admin', '2022-01-13 15:11:08', 'admin', '2022-03-13 00:21:06', NULL);
INSERT INTO `sys_dict_data` VALUES (145, 5, '设备上线', '5', 'iot_device_log_type', NULL, 'success', 'N', '0', 'admin', '2022-01-13 15:11:23', 'admin', '2022-03-13 00:21:26', NULL);
INSERT INTO `sys_dict_data` VALUES (146, 6, '设备离线', '6', 'iot_device_log_type', NULL, 'info', 'N', '0', 'admin', '2022-01-13 15:11:32', 'admin', '2022-03-13 00:21:13', NULL);
INSERT INTO `sys_dict_data` VALUES (147, 4, '其他', '4', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2022-01-14 02:12:49', 'admin', '2022-01-14 02:13:03', NULL);
INSERT INTO `sys_dict_data` VALUES (148, 6, '安卓/Android', '6', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2022-01-16 12:39:27', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (149, 7, '其他', '7', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2022-01-16 12:39:55', 'admin', '2022-01-16 12:40:13', NULL);
INSERT INTO `sys_dict_data` VALUES (150, 1, '小度平台', '1', 'oauth_platform', NULL, 'primary', 'N', '0', 'admin', '2022-02-07 20:29:23', 'admin', '2022-02-07 22:24:28', NULL);
INSERT INTO `sys_dict_data` VALUES (151, 2, '天猫精灵', '2', 'oauth_platform', NULL, 'danger', 'N', '0', 'admin', '2022-02-07 20:29:41', 'admin', '2022-02-07 22:23:14', NULL);
INSERT INTO `sys_dict_data` VALUES (152, 3, '小米小爱', '3', 'oauth_platform', NULL, 'success', 'N', '0', 'admin', '2022-02-07 20:30:07', 'admin', '2022-02-07 22:23:24', NULL);
INSERT INTO `sys_dict_data` VALUES (153, 4, '其他平台', '4', 'oauth_platform', NULL, 'warning', 'N', '0', 'admin', '2022-02-07 22:23:52', 'admin', '2022-02-07 22:24:02', NULL);
INSERT INTO `sys_dict_data` VALUES (154, 1, '微信登录', 'WECHAT', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2022-04-20 16:41:33', 'admin', '2022-05-12 17:49:45', NULL);
INSERT INTO `sys_dict_data` VALUES (155, 2, 'QQ登录', 'QQ', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2022-04-20 16:42:46', 'admin', '2022-05-12 17:49:54', NULL);
INSERT INTO `sys_dict_data` VALUES (156, 0, '启用', '0', 'iot_social_platform_status', NULL, 'success', 'N', '0', 'admin', '2022-04-20 17:02:48', 'admin', '2022-05-12 17:39:40', '启用');
INSERT INTO `sys_dict_data` VALUES (157, 1, '未启用', '1', 'iot_social_platform_status', NULL, 'info', 'N', '0', 'admin', '2022-04-20 17:03:15', 'admin', '2022-05-21 13:44:13', '禁用');
INSERT INTO `sys_dict_data` VALUES (158, 3, '支付宝', 'ALIPAY', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2022-05-12 17:49:24', 'admin', '2022-05-12 17:50:21', NULL);
INSERT INTO `sys_dict_data` VALUES (159, 1, '自动定位', '1', 'iot_location_way', NULL, 'success', 'N', '0', 'admin', '2022-05-21 13:46:51', 'admin', '2022-05-21 13:53:23', 'IP定位，精确到城市');
INSERT INTO `sys_dict_data` VALUES (160, 2, '设备定位', '2', 'iot_location_way', NULL, 'warning', 'N', '0', 'admin', '2022-05-21 13:46:51', 'admin', '2022-05-21 13:49:21', '最精确定位');
INSERT INTO `sys_dict_data` VALUES (161, 3, '自定义位置', '3', 'iot_location_way', NULL, 'primary', 'N', '0', 'admin', '2022-05-21 13:48:50', 'admin', '2022-05-21 13:55:45', '位置自定义');
INSERT INTO `sys_dict_data` VALUES (162, 3, '简单+加密', '3', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', '2022-06-05 00:15:46', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (163, 1, '未使用', '1', 'iot_auth_status', NULL, 'info', 'N', '0', 'admin', '2022-06-07 17:39:22', 'admin', '2022-06-07 17:40:10', NULL);
INSERT INTO `sys_dict_data` VALUES (164, 2, '已使用', '2', 'iot_auth_status', NULL, 'success', 'N', '0', 'admin', '2022-06-07 17:40:01', 'admin', '2022-06-07 23:21:49', NULL);
INSERT INTO `sys_dict_data` VALUES (165, 7, '对象', 'object', 'iot_data_type', NULL, 'default', 'N', '0', 'admin', '2023-02-09 16:20:57', 'admin', '2023-02-09 16:21:08', NULL);
INSERT INTO `sys_dict_data` VALUES (166, 3, '监控设备', '3', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2023-02-09 16:26:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (167, 1, '未使用', '1', 'sip_gen_status', NULL, 'info', 'N', '0', 'admin', '2023-02-19 15:49:04', 'admin', '2023-02-19 15:50:03', NULL);
INSERT INTO `sys_dict_data` VALUES (168, 2, '在线', '2', 'sip_gen_status', NULL, 'success', 'N', '0', 'admin', '2023-02-19 15:49:24', 'admin', '2023-02-24 21:36:29', NULL);
INSERT INTO `sys_dict_data` VALUES (169, 0, 'DVR', '111', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:07:06', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (170, 1, 'NVR', '118', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:07:59', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (171, 2, '报警控制器', '117', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:08:13', 'admin', '2023-02-22 01:08:35', NULL);
INSERT INTO `sys_dict_data` VALUES (172, 4, '摄像机', '131', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:08:52', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (173, 5, 'IPC', '132', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:09:11', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (174, 6, '显示器', '133', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:09:30', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (175, 7, '报警输入设备', '134', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:09:49', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (176, 8, '报警输出设备', '135', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:10:08', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (177, 9, '语音输入设备', '136', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:10:29', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (178, 10, '语音输出设备', '137', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:10:46', 'admin', '2023-02-22 01:10:51', NULL);
INSERT INTO `sys_dict_data` VALUES (179, 11, '移动传输设备', '138', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:11:09', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (180, 0, '报警控制器', '117', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:12:09', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (181, 1, '摄像机', '131', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:12:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (182, 2, 'IPC', '132', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:12:39', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (183, 3, '显示器', '133', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:12:57', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (184, 5, '报警输入设备', '134', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:13:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (185, 6, '报警输出设备', '135', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:13:29', 'admin', '2023-02-22 01:13:49', NULL);
INSERT INTO `sys_dict_data` VALUES (186, 7, '语音输入设备', '136', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:14:14', 'admin', '2023-02-22 01:14:24', NULL);
INSERT INTO `sys_dict_data` VALUES (187, 8, '语音输出设备', '137', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:14:50', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (188, 9, '移动传输设备', '138', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:15:11', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (189, 3, '离线', '3', 'sip_gen_status', NULL, 'warning', 'N', '0', 'admin', '2023-02-24 21:36:53', 'admin', '2023-02-24 21:37:11', NULL);
INSERT INTO `sys_dict_data` VALUES (190, 4, '禁用', '4', 'sip_gen_status', NULL, 'danger', 'N', '0', 'admin', '2023-02-24 21:37:39', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '物模型类别', 'iot_things_type', '0', 'admin', '2021-12-12 16:39:47', 'admin', '2021-12-15 22:49:19', '属性、动作、事件');
INSERT INTO `sys_dict_type` VALUES (101, '数据类型', 'iot_data_type', '0', 'admin', '2021-12-12 20:16:48', 'admin', '2021-12-12 20:17:54', 'integer、decimal、bool、string、enum');
INSERT INTO `sys_dict_type` VALUES (102, '是否', 'iot_yes_no', '0', 'admin', '2021-12-12 20:24:51', 'admin', '2021-12-19 15:12:35', '是、否');
INSERT INTO `sys_dict_type` VALUES (103, '产品状态', 'iot_product_status', '0', 'admin', '2021-12-19 15:00:13', '', NULL, '未发布、已发布（不能修改）');
INSERT INTO `sys_dict_type` VALUES (104, '设备类型', 'iot_device_type', '0', 'admin', '2021-12-19 15:03:06', '', NULL, '直连设备、网关子设备、网关设备');
INSERT INTO `sys_dict_type` VALUES (105, '联网方式', 'iot_network_method', '0', 'admin', '2021-12-19 15:07:12', 'admin', '2022-01-14 02:11:58', 'wifi、蜂窝(2G/3G/4G/5G)、以太网、其他');
INSERT INTO `sys_dict_type` VALUES (106, '认证方式', 'iot_vertificate_method', '0', 'admin', '2021-12-19 15:11:48', 'admin', '2022-06-05 12:57:02', '1=简单认证、2=加密认证、3=简单+加密');
INSERT INTO `sys_dict_type` VALUES (107, '设备芯片', 'iot_device_chip', '0', 'admin', '2021-12-24 15:53:27', 'admin', '2022-01-22 00:14:23', 'ESP8266、ESP32、树莓派');
INSERT INTO `sys_dict_type` VALUES (109, '设备状态', 'iot_device_status', '0', 'admin', '2021-12-27 22:19:55', 'admin', '2021-12-27 22:20:13', '未激活、禁用、在线、离线');
INSERT INTO `sys_dict_type` VALUES (110, '是否启用', 'iot_is_enable', '0', 'admin', '2022-01-12 23:24:01', 'admin', '2022-01-12 23:24:15', '启用、禁用');
INSERT INTO `sys_dict_type` VALUES (111, '告警类型', 'iot_alert_level', '0', 'admin', '2022-01-13 14:56:44', 'admin', '2022-01-13 15:04:46', '1=提醒通知，2=轻微问题，3=严重警告');
INSERT INTO `sys_dict_type` VALUES (112, '处理状态', 'iot_process_status', '0', 'admin', '2022-01-13 15:04:06', 'admin', '2022-01-13 15:06:39', '1=不需要处理,2=未处理,3=已处理');
INSERT INTO `sys_dict_type` VALUES (113, '设备日志类型', 'iot_device_log_type', '0', 'admin', '2022-01-13 15:09:49', 'admin', '2022-03-13 00:22:43', '1=属性上报，2=调用功能,3=事件上报，4=设备升级，5=设备上线，6=设备离线');
INSERT INTO `sys_dict_type` VALUES (114, 'Oauth开放平台', 'oauth_platform', '0', 'admin', '2022-02-07 20:27:48', 'admin', '2022-05-21 13:44:50', '1=小度，2=天猫精灵，3=小爱，4=其他');
INSERT INTO `sys_dict_type` VALUES (115, '第三方登录平台', 'iot_social_platform', '0', 'admin', '2022-04-12 15:28:13', 'admin', '2022-04-12 15:37:48', 'Wechat、QQ、');
INSERT INTO `sys_dict_type` VALUES (116, '第三方登录平台状态', 'iot_social_platform_status', '0', 'admin', '2022-04-20 17:02:13', 'admin', '2022-04-20 17:02:23', '第三方登录平台状态');
INSERT INTO `sys_dict_type` VALUES (117, '设备定位方式', 'iot_location_way', '0', 'admin', '2022-05-21 13:45:16', 'admin', '2022-05-21 13:46:06', '1=IP自动定位，2=设备定位，3=自定义');
INSERT INTO `sys_dict_type` VALUES (118, '授权码状态', 'iot_auth_status', '0', 'admin', '2022-06-07 17:38:56', '', NULL, '1=未分配，2=使用中');
INSERT INTO `sys_dict_type` VALUES (119, 'SipID状态', 'sip_gen_status', '0', 'admin', '2023-02-19 15:43:36', 'admin', '2023-02-19 15:45:54', '1=未使用，2=使用中');
INSERT INTO `sys_dict_type` VALUES (120, '监控设备类型', 'video_type', '0', 'admin', '2023-02-22 01:06:38', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (121, '通道类型', 'channel_type', '0', 'admin', '2023-02-22 01:11:51', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2021-12-15 21:36:18', 'admin', '2022-01-29 21:48:13', '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2021-12-15 21:36:18', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6674 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '系统默认（无参） 总共耗时：1毫秒', '0', '', '2022-03-11 17:22:20');
INSERT INTO `sys_job_log` VALUES (1999, '定时上报监测数据', 'DEFAULT', 'ESP8266开发板', '定时上报监测数据 总共耗时：142毫秒', '0', '', '2022-05-21 10:20:02');
INSERT INTO `sys_job_log` VALUES (2000, '定时打开设备(T1)', 'DEFAULT', '室内检测仪(T1)', '定时打开设备(T1) 总共耗时：128毫秒', '0', '', '2022-06-11 01:20:02');
INSERT INTO `sys_job_log` VALUES (2001, '定时打开设备(U1)', 'DEFAULT', '体温检测仪(U1)', '定时打开设备(U1) 总共耗时：138毫秒', '0', '', '2022-06-11 01:29:02');
INSERT INTO `sys_job_log` VALUES (2002, '上报体温(admin)', 'DEFAULT', '门口监测仪(admin)', '上报体温(admin) 总共耗时：226毫秒', '0', '', '2022-06-11 22:50:05');
INSERT INTO `sys_job_log` VALUES (2003, '定时打开设备(T1)', 'DEFAULT', '室内检测仪(T1)', '定时打开设备(T1) 总共耗时：100毫秒', '0', '', '2022-06-12 01:20:03');
INSERT INTO `sys_job_log` VALUES (2004, '定时打开设备(U1)', 'DEFAULT', '体温检测仪(U1)', '定时打开设备(U1) 总共耗时：116毫秒', '0', '', '2022-06-12 01:29:03');
INSERT INTO `sys_job_log` VALUES (2005, '定时上报数据(U2)', 'DEFAULT', '体温检测仪(U2)', '定时上报数据(U2) 总共耗时：105毫秒', '0', '', '2022-06-12 02:27:03');
INSERT INTO `sys_job_log` VALUES (2006, '定时打开开关', 'DEFAULT', '智能开关', '定时打开开关 总共耗时：18毫秒', '0', '', '2022-10-24 21:28:00');
INSERT INTO `sys_job_log` VALUES (2007, '定时打开开关', 'DEFAULT', '智能开关', '定时打开开关 总共耗时：46毫秒', '1', 'java.lang.NullPointerException\n	at com.ruoyi.iot.mqtt.EmqxClient.publish(EmqxClient.java:168)\n	at com.ruoyi.iot.mqtt.EmqxService.publishFunction(EmqxService.java:261)\n	at com.ruoyi.iot.mqtt.EmqxService$$FastClassBySpringCGLIB$$6912a57b.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:689)\n	at com.ruoyi.iot.mqtt.EmqxService$$EnhancerBySpringCGLIB$$ba7049a5.publishFunction(<generated>)\n	at com.ruoyi.iot.util.quartz.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:49)\n	at com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)\n	at com.ruoyi.iot.util.quartz.AbstractQuartzJob.execute(AbstractQuartzJob.java:44)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', '2022-10-25 21:28:00');
INSERT INTO `sys_job_log` VALUES (2008, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '系统默认（多参） 总共耗时：5毫秒', '0', '', '2022-10-26 18:46:41');
INSERT INTO `sys_job_log` VALUES (2009, '定时打开开关', 'DEFAULT', '智能开关', '定时打开开关 总共耗时：22毫秒', '1', 'java.lang.NullPointerException\n	at com.ruoyi.iot.mqtt.EmqxClient.publish(EmqxClient.java:168)\n	at com.ruoyi.iot.mqtt.EmqxService.publishFunction(EmqxService.java:261)\n	at com.ruoyi.iot.mqtt.EmqxService$$FastClassBySpringCGLIB$$6912a57b.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:689)\n	at com.ruoyi.iot.mqtt.EmqxService$$EnhancerBySpringCGLIB$$b2b25ed7.publishFunction(<generated>)\n	at com.ruoyi.iot.util.quartz.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:49)\n	at com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)\n	at com.ruoyi.iot.util.quartz.AbstractQuartzJob.execute(AbstractQuartzJob.java:44)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', '2022-10-26 21:28:00');
INSERT INTO `sys_job_log` VALUES (2010, '定时打开开关', 'DEFAULT', '智能开关', '定时打开开关 总共耗时：1毫秒', '1', 'java.lang.NullPointerException\n	at com.ruoyi.iot.mqtt.EmqxClient.publish(EmqxClient.java:168)\n	at com.ruoyi.iot.mqtt.EmqxService.publishFunction(EmqxService.java:261)\n	at com.ruoyi.iot.mqtt.EmqxService$$FastClassBySpringCGLIB$$6912a57b.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:689)\n	at com.ruoyi.iot.mqtt.EmqxService$$EnhancerBySpringCGLIB$$b2b25ed7.publishFunction(<generated>)\n	at com.ruoyi.iot.util.quartz.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:49)\n	at com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)\n	at com.ruoyi.iot.util.quartz.AbstractQuartzJob.execute(AbstractQuartzJob.java:44)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', '2022-10-27 21:28:00');
INSERT INTO `sys_job_log` VALUES (2011, '定时打开开关', 'DEFAULT', '智能开关', '定时打开开关 总共耗时：1毫秒', '1', 'java.lang.NullPointerException\n	at com.ruoyi.iot.mqtt.EmqxClient.publish(EmqxClient.java:168)\n	at com.ruoyi.iot.mqtt.EmqxService.publishFunction(EmqxService.java:261)\n	at com.ruoyi.iot.mqtt.EmqxService$$FastClassBySpringCGLIB$$6912a57b.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:689)\n	at com.ruoyi.iot.mqtt.EmqxService$$EnhancerBySpringCGLIB$$b2b25ed7.publishFunction(<generated>)\n	at com.ruoyi.iot.util.quartz.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:49)\n	at com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)\n	at com.ruoyi.iot.util.quartz.AbstractQuartzJob.execute(AbstractQuartzJob.java:44)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', '2022-10-30 21:28:00');
INSERT INTO `sys_job_log` VALUES (2012, '定时打开开关', 'DEFAULT', '智能开关', '定时打开开关 总共耗时：0毫秒', '1', 'java.lang.NullPointerException\n	at com.ruoyi.iot.mqtt.EmqxClient.publish(EmqxClient.java:168)\n	at com.ruoyi.iot.mqtt.EmqxService.publishFunction(EmqxService.java:261)\n	at com.ruoyi.iot.mqtt.EmqxService$$FastClassBySpringCGLIB$$6912a57b.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:689)\n	at com.ruoyi.iot.mqtt.EmqxService$$EnhancerBySpringCGLIB$$b2b25ed7.publishFunction(<generated>)\n	at com.ruoyi.iot.util.quartz.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:49)\n	at com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)\n	at com.ruoyi.iot.util.quartz.AbstractQuartzJob.execute(AbstractQuartzJob.java:44)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', '2022-10-31 21:28:00');
INSERT INTO `sys_job_log` VALUES (2013, '定时打开开关', 'DEFAULT', '智能开关', '定时打开开关 总共耗时：0毫秒', '1', 'java.lang.NullPointerException\n	at com.ruoyi.iot.mqtt.EmqxClient.publish(EmqxClient.java:168)\n	at com.ruoyi.iot.mqtt.EmqxService.publishFunction(EmqxService.java:261)\n	at com.ruoyi.iot.mqtt.EmqxService$$FastClassBySpringCGLIB$$6912a57b.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:689)\n	at com.ruoyi.iot.mqtt.EmqxService$$EnhancerBySpringCGLIB$$b2b25ed7.publishFunction(<generated>)\n	at com.ruoyi.iot.util.quartz.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:49)\n	at com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)\n	at com.ruoyi.iot.util.quartz.AbstractQuartzJob.execute(AbstractQuartzJob.java:44)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', '2022-11-01 21:28:00');
INSERT INTO `sys_job_log` VALUES (2014, '定时打开开关', 'DEFAULT', '智能开关', '定时打开开关 总共耗时：1毫秒', '1', 'java.lang.NullPointerException\n	at com.ruoyi.iot.mqtt.EmqxClient.publish(EmqxClient.java:168)\n	at com.ruoyi.iot.mqtt.EmqxService.publishFunction(EmqxService.java:261)\n	at com.ruoyi.iot.mqtt.EmqxService$$FastClassBySpringCGLIB$$6912a57b.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:689)\n	at com.ruoyi.iot.mqtt.EmqxService$$EnhancerBySpringCGLIB$$b2b25ed7.publishFunction(<generated>)\n	at com.ruoyi.iot.util.quartz.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:49)\n	at com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)\n	at com.ruoyi.iot.util.quartz.AbstractQuartzJob.execute(AbstractQuartzJob.java:44)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', '2022-11-02 21:28:00');
INSERT INTO `sys_job_log` VALUES (2015, '定时打开', 'DEFAULT', '演示设备', '定时打开 总共耗时：55毫秒', '0', '', '2023-02-12 16:20:01');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1, 'wumei', '223.210.17.244', '安徽省 合肥市', 'Chrome 9', 'Mac OS X', '0', '登录成功', '2023-02-26 23:16:12');
INSERT INTO `sys_logininfor` VALUES (2, 'wumei-u1', '223.147.227.64', '湖南省 衡阳市', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-02-26 23:26:17');
INSERT INTO `sys_logininfor` VALUES (3, 'wumei-u1', '223.147.227.64', '湖南省 衡阳市', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-02-26 23:27:21');
INSERT INTO `sys_logininfor` VALUES (4, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-02-26 23:35:16');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2173 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 2, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:46:20', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 3, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:43:05', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 4, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:42:59', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '蜂信物联', 0, 7, 'http://fastbee.cn', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2021-12-15 21:36:18', 'admin', '2023-02-22 07:26:09', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2021-12-15 21:36:18', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2021-12-15 21:36:18', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2021-12-15 21:36:18', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2021-12-15 21:36:18', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2021-12-15 21:36:18', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2021-12-15 21:36:18', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2021-12-15 21:36:18', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2021-12-15 21:36:18', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2021-12-15 21:36:18', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2021-12-15 21:36:18', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2021-12-15 21:36:18', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2021-12-15 21:36:18', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2021-12-15 21:36:18', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2021-12-15 21:36:18', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2021-12-15 21:36:18', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2021-12-15 21:36:18', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2021-12-15 21:36:18', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-12-15 21:36:18', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2021-12-15 21:36:18', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '设备管理', 0, 0, 'iot', NULL, NULL, 1, 0, 'M', '0', '0', '', 'iot', 'admin', '2021-12-15 23:57:06', 'admin', '2021-12-26 23:55:54', '');
INSERT INTO `sys_menu` VALUES (2001, '产品分类', 2000, 2, 'category', 'iot/category/index', NULL, 1, 0, 'C', '0', '0', 'iot:category:list', 'category', 'admin', '2021-12-16 00:40:02', 'admin', '2021-12-26 23:56:20', '产品分类菜单');
INSERT INTO `sys_menu` VALUES (2002, '产品分类查询', 2001, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:query', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '产品分类新增', 2001, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:add', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '产品分类修改', 2001, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:edit', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '产品分类删除', 2001, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:remove', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '产品分类导出', 2001, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:export', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '设备管理', 2000, 6, 'device', 'iot/device/index', NULL, 1, 0, 'C', '0', '0', 'iot:device:list', 'device', 'admin', '2021-12-16 00:40:12', 'admin', '2022-01-08 15:47:14', '设备菜单');
INSERT INTO `sys_menu` VALUES (2008, '设备查询', 2007, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:query', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '设备新增', 2007, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:add', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '设备修改', 2007, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:edit', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '设备删除', 2007, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:remove', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '设备导出', 2007, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:export', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '产品固件', 2000, 4, 'firmware', 'iot/firmware/index', NULL, 1, 0, 'C', '0', '0', 'iot:firmware:list', 'firmware', 'admin', '2021-12-16 00:40:20', 'admin', '2021-12-26 23:56:42', '产品固件菜单');
INSERT INTO `sys_menu` VALUES (2014, '产品固件查询', 2013, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:query', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '产品固件新增', 2013, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:add', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '产品固件修改', 2013, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:edit', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '产品固件删除', 2013, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:remove', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '产品固件导出', 2013, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:firmware:export', '#', 'admin', '2021-12-16 00:40:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '设备分组', 2000, 5, 'group', 'iot/group/index', NULL, 1, 0, 'C', '0', '0', 'iot:group:list', 'group', 'admin', '2021-12-16 00:40:31', 'admin', '2021-12-26 23:56:54', '设备分组菜单');
INSERT INTO `sys_menu` VALUES (2020, '设备分组查询', 2019, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:query', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '设备分组新增', 2019, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:add', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '设备分组修改', 2019, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:edit', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '设备分组删除', 2019, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:remove', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '设备分组导出', 2019, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:export', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '产品管理', 2000, 3, 'product', 'iot/product/index', NULL, 1, 0, 'C', '0', '0', 'iot:product:list', 'product', 'admin', '2021-12-16 00:41:18', 'admin', '2021-12-26 23:58:44', '产品菜单');
INSERT INTO `sys_menu` VALUES (2044, '产品查询', 2043, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:query', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '产品新增', 2043, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:add', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '产品修改', 2043, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:edit', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '产品删除', 2043, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:remove', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '产品导出', 2043, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:export', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2049, '通用物模型', 2000, 1, 'template', 'iot/template/index', NULL, 1, 0, 'C', '0', '0', 'iot:template:list', 'model', 'admin', '2021-12-16 00:41:28', 'admin', '2021-12-26 23:56:09', '通用物模型菜单');
INSERT INTO `sys_menu` VALUES (2050, '通用物模型查询', 2049, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:query', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '通用物模型新增', 2049, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:add', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '通用物模型修改', 2049, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:edit', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '通用物模型删除', 2049, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:remove', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '通用物模型导出', 2049, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:export', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2067, '设备告警', 2000, 7, 'alertLog', 'iot/alertLog/index', NULL, 1, 0, 'C', '0', '0', 'iot:alert:list', 'alert', 'admin', '2022-01-13 17:16:15', 'admin', '2022-06-11 01:11:47', '设备告警菜单');
INSERT INTO `sys_menu` VALUES (2068, '设备告警查询', 2067, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alert:query', '#', 'admin', '2022-01-13 17:16:15', 'admin', '2022-06-11 00:38:10', '');
INSERT INTO `sys_menu` VALUES (2069, '设备告警新增', 2067, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alert:add', '#', 'admin', '2022-01-13 17:16:15', 'admin', '2022-06-11 00:38:20', '');
INSERT INTO `sys_menu` VALUES (2070, '设备告警修改', 2067, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alert:edit', '#', 'admin', '2022-01-13 17:16:15', 'admin', '2022-06-11 00:38:29', '');
INSERT INTO `sys_menu` VALUES (2071, '设备告警删除', 2067, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alert:remove', '#', 'admin', '2022-01-13 17:16:15', 'admin', '2022-06-11 00:38:38', '');
INSERT INTO `sys_menu` VALUES (2072, '设备告警导出', 2067, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:alert:export', '#', 'admin', '2022-01-13 17:16:15', 'admin', '2022-06-11 00:38:46', '');
INSERT INTO `sys_menu` VALUES (2085, '场景联动', 2000, 8, 'scene', 'iot/scene/index', NULL, 1, 0, 'C', '0', '0', 'iot:scene:list', 'scene', 'admin', '2022-01-13 17:16:45', 'admin', '2022-11-02 22:01:32', '场景联动菜单');
INSERT INTO `sys_menu` VALUES (2086, '场景联动查询', 2085, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:query', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2087, '场景联动新增', 2085, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:add', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2088, '场景联动修改', 2085, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:edit', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '场景联动删除', 2085, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:remove', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2090, '场景联动导出', 2085, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:export', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2098, '云云对接', 2000, 9, 'clientDetails', 'iot/clientDetails/index', NULL, 1, 0, 'C', '1', '0', 'iot:clientDetails:list', 'cloud', 'admin', '2022-02-07 22:08:58', 'admin', '2023-02-09 16:10:22', '云云对接菜单');
INSERT INTO `sys_menu` VALUES (2099, '云云对接查询', 2098, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:query', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2100, '云云对接新增', 2098, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:add', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2101, '云云对接修改', 2098, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:edit', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2102, '云云对接删除', 2098, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:remove', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2103, '云云对接导出', 2098, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:clientDetails:export', '#', 'admin', '2022-02-07 22:08:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2104, 'EMQ管理', 0, 1, 'emqx', NULL, NULL, 1, 0, 'M', '0', '0', '', 'mq', 'admin', '2022-02-26 00:42:12', 'admin', '2022-03-04 14:08:55', '');
INSERT INTO `sys_menu` VALUES (2105, '客户端', 2104, 1, 'client', 'iot/emqx/client', NULL, 1, 0, 'C', '0', '0', 'iot:emqx:client', 'client', 'admin', '2022-02-26 00:45:39', 'admin', '2022-06-03 14:11:22', '');
INSERT INTO `sys_menu` VALUES (2106, '消息主题', 2104, 3, 'topic', 'iot/emqx/topic', NULL, 1, 0, 'C', '0', '0', 'iot:emqx:topic', 'topic', 'admin', '2022-02-27 16:31:17', 'admin', '2022-06-03 14:11:59', '');
INSERT INTO `sys_menu` VALUES (2107, '消息订阅', 2104, 4, 'subscribe', 'iot/emqx/subscribe', NULL, 1, 0, 'C', '0', '0', 'iot:emqx:subscribe', 'subscribe', 'admin', '2022-02-27 16:32:21', 'admin', '2022-06-03 14:12:11', '');
INSERT INTO `sys_menu` VALUES (2108, '插件管理', 2104, 5, 'plugin', 'iot/emqx/plugin', NULL, 1, 0, 'C', '0', '0', 'iot:emqx:plugin', 'plugin', 'admin', '2022-02-27 19:10:40', 'admin', '2022-06-03 14:12:23', '');
INSERT INTO `sys_menu` VALUES (2109, '监听器', 2104, 2, 'listener', 'iot/emqx/listener', NULL, 1, 0, 'C', '0', '0', 'iot:emqx:listener', 'listener', 'admin', '2022-02-27 19:52:08', 'admin', '2022-06-03 14:11:45', '');
INSERT INTO `sys_menu` VALUES (2111, '规则资源', 2104, 6, 'resource', 'iot/emqx/resource', NULL, 1, 0, 'C', '0', '0', 'iot:emqx:resource', 'build', 'admin', '2022-04-07 14:16:53', 'admin', '2022-06-03 14:12:35', '');
INSERT INTO `sys_menu` VALUES (2112, '规则引擎', 2104, 7, 'rule', 'iot/emqx/rule', NULL, 1, 0, 'C', '0', '0', 'iot:emqx:rule', 'build', 'admin', '2022-04-07 14:19:37', 'admin', '2022-06-03 14:12:48', '');
INSERT INTO `sys_menu` VALUES (2123, '新闻分类', 1, 10, 'newsCategory', 'iot/newsCategory/index', NULL, 1, 0, 'C', '0', '0', 'iot:newsCategory:list', 'category', 'admin', '2022-04-11 16:47:27', 'admin', '2022-05-12 17:20:51', '新闻分类菜单');
INSERT INTO `sys_menu` VALUES (2124, '新闻分类查询', 2123, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:query', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2125, '新闻分类新增', 2123, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:add', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2126, '新闻分类修改', 2123, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:edit', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2127, '新闻分类删除', 2123, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:remove', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2128, '新闻分类导出', 2123, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:export', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2129, '新闻资讯', 1, 11, 'news', 'iot/news/index', NULL, 1, 0, 'C', '0', '0', 'iot:news:list', 'documentation', 'admin', '2022-04-11 16:47:46', 'admin', '2022-05-12 17:20:58', '新闻资讯菜单');
INSERT INTO `sys_menu` VALUES (2130, '新闻资讯查询', 2129, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:query', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2131, '新闻资讯新增', 2129, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:add', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2132, '新闻资讯修改', 2129, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:edit', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2133, '新闻资讯删除', 2129, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:remove', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2134, '新闻资讯导出', 2129, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:export', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2136, '产品授权码查询', 2043, 6, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:query', '#', 'admin', '2022-04-11 17:17:53', 'admin', '2022-06-04 21:21:40', '');
INSERT INTO `sys_menu` VALUES (2137, '产品授权码新增', 2043, 7, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:add', '#', 'admin', '2022-04-11 17:17:53', 'admin', '2022-06-04 21:21:59', '');
INSERT INTO `sys_menu` VALUES (2138, '产品授权码修改', 2043, 8, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:edit', '#', 'admin', '2022-04-11 17:17:53', 'admin', '2022-06-04 21:22:08', '');
INSERT INTO `sys_menu` VALUES (2139, '产品授权码删除', 2043, 9, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:remove', '#', 'admin', '2022-04-11 17:17:53', 'admin', '2022-06-04 21:22:26', '');
INSERT INTO `sys_menu` VALUES (2140, '产品授权码导出', 2043, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:export', '#', 'admin', '2022-04-11 17:17:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2141, '三方登录', 1, 12, 'platform', 'iot/platform/index', NULL, 1, 1, 'C', '1', '0', 'iot:platform:list', 'cloud', 'admin', '2022-04-11 18:55:34', 'admin', '2023-02-09 16:11:21', '');
INSERT INTO `sys_menu` VALUES (2142, '平台查询', 2142, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:platform:query', '#', 'admin', '2022-04-11 19:10:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2143, 'EMQ查询', 2104, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:emqx:query', '#', 'admin', '2022-03-09 16:58:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2144, 'EMQ新增', 2104, 9, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:emqx:add', '#', 'admin', '2022-03-09 16:58:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2145, 'EMQ编辑', 2104, 10, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:emqx:edit', '#', 'admin', '2022-03-09 16:58:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2146, 'EMQ删除', 2104, 11, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:emqx:remove', '#', 'admin', '2022-03-09 16:58:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2147, '设备分享', 2007, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:device:share', '#', 'admin', '2022-06-10 01:08:40', 'admin', '2022-06-10 01:10:46', '');
INSERT INTO `sys_menu` VALUES (2148, '设备定时', 2007, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:device:timer', '#', 'admin', '2022-06-10 01:10:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2149, '大屏展示', 0, 5, 'https://iot.fastbee.cn/bigScreen', NULL, NULL, 0, 0, 'M', '0', '0', '', 'monitor-a', 'admin', '2022-08-13 22:32:11', 'admin', '2023-02-26 23:05:42', '');
INSERT INTO `sys_menu` VALUES (2167, '可视化平台', 0, 6, 'https://iot.fastbee.cn/smartView/#/project/items', NULL, NULL, 0, 0, 'C', '0', '0', '', 'eye-open', 'admin', '2022-11-06 21:44:50', 'admin', '2023-02-26 23:05:29', '');
INSERT INTO `sys_menu` VALUES (2168, '视频配置', 2000, 10, 'sip', 'iot/sip/index', NULL, 1, 0, 'C', '0', '0', 'iot:video:list', 'live', 'admin', '2023-02-21 00:21:39', 'admin', '2023-02-22 07:54:06', '');
INSERT INTO `sys_menu` VALUES (2169, '视频配置查询', 2168, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:video:query', '#', 'admin', '2023-02-22 07:55:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2170, '视频配置新增', 2168, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', ' iot:video:add', '#', 'admin', '2023-02-22 07:56:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2171, '视频配置修改', 2168, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:video:edit', '#', 'admin', '2023-02-22 07:57:26', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2172, '视频配置删除', 2168, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:video:remove', '#', 'admin', '2023-02-22 07:58:03', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '物美智能V1.2版本发布', '2', 0x3C703EE8BF99E698AFE6B58BE8AF95E58685E5AEB9EFBC8CE696B0E78988E69CACE58A9FE883BDEFBC9A3C2F703E3C6F6C3E3C6C693EE694AFE68C81E5A49AE7A79FE688B73C2F6C693E3C6C693EE694AFE68C81E8AEBEE5A487E58886E4BAAB3C2F6C693E3C6C693EE694AFE68C81E697B6E5BA8FE695B0E68DAEE5BA933C2F6C693E3C6C693EE7AE80E58D95E8AEA4E8AF81E5928CE58AA0E5AF86E8AEA4E8AF81E7BB9FE4B8803C2F6C693E3C2F6F6C3E, '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-06-04 17:07:25', '管理员');
INSERT INTO `sys_notice` VALUES (2, '物美智能sdk支持树莓派', '1', 0x3C703EE8BF99E698AFE6B58BE8AF95E58685E5AEB9EFBC8CE79BAEE5898D73646BE694AFE68C81E79A84E78988E69CAC3A3C2F703E3C703E3C62723E3C2F703E3C6F6C3E3C6C693E41726475696E6F20657370383236363C2F6C693E3C6C693E41726475696E6F2065737033323C2F6C693E3C6C693E6573702D6964663C2F6C693E3C6C693E72617370626572727920E6A091E88E93E6B4BE3C2F6C693E3C2F6F6C3E, '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-06-04 17:07:36', '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '操作日志', 9, 'com.ruoyi.web.controller.monitor.SysOperlogController.clean()', 'DELETE', 1, 'admin', NULL, '/monitor/operlog/clean', '183.225.206.92', '云南省 曲靖市', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-02-26 23:13:17');
INSERT INTO `sys_oper_log` VALUES (2, '产品授权码', 3, 'com.ruoyi.iot.controller.ProductAuthorizeController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/authorize/12,13,14,15,16,17,18,19,20,21', '183.225.206.92', '云南省 曲靖市', '{authorizeIds=12,13,14,15,16,17,18,19,20,21}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-02-26 23:14:24');
INSERT INTO `sys_oper_log` VALUES (3, '产品授权码', 3, 'com.ruoyi.iot.controller.ProductAuthorizeController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/authorize/1', '183.225.206.92', '云南省 曲靖市', '{authorizeIds=1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-02-26 23:14:27');
INSERT INTO `sys_oper_log` VALUES (4, '设备告警', 3, 'com.ruoyi.iot.controller.AlertController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/alert/50', '183.225.206.92', '云南省 曲靖市', '{alertIds=50}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-02-26 23:14:31');
INSERT INTO `sys_oper_log` VALUES (5, '设备告警', 3, 'com.ruoyi.iot.controller.AlertController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/alert/51', '183.225.206.92', '云南省 曲靖市', '{alertIds=51}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-02-26 23:14:33');
INSERT INTO `sys_oper_log` VALUES (6, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'admin', NULL, '/iot/firmware', '183.225.206.92', '云南省 曲靖市', '{\"productId\":41,\"filePath\":\"/profile/iot/1/2023-0226-143855.bin\",\"firmwareId\":1,\"remark\":\"测试固件\",\"updateTime\":1677424492318,\"params\":{},\"version\":1,\"productName\":\"温湿度智能开关\",\"isLatest\":1,\"tenantName\":\"wumei\",\"createTime\":1677170306000,\"firmwareName\":\"智能开关固件\",\"tenantId\":6,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-02-26 23:14:52');
INSERT INTO `sys_oper_log` VALUES (7, '产品授权码', 3, 'com.ruoyi.iot.controller.ProductAuthorizeController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/authorize/2,3,4,5,6,7,8,9,10,11', '183.225.206.92', '云南省 曲靖市', '{authorizeIds=2,3,4,5,6,7,8,9,10,11}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-02-26 23:15:09');
INSERT INTO `sys_oper_log` VALUES (8, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', NULL, '/system/user/profile/updatePwd', '183.225.206.92', '云南省 曲靖市', 'wumei-Tencent admin123', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-02-26 23:36:09');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '设备租户', 'tenant', 2, '5', 1, 1, '0', '0', 'admin', '2021-12-16 16:41:30', 'admin', '2023-02-22 08:17:50', '管理产品和设备');
INSERT INTO `sys_role` VALUES (3, '普通用户', 'general', 3, '5', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-02-22 08:17:37', '设备的最终用户，只能管理设备和分组');
INSERT INTO `sys_role` VALUES (4, '游客', 'visitor', 4, '1', 1, 1, '0', '0', 'admin', '2021-12-16 16:44:30', 'admin', '2023-02-22 08:17:27', '只能查询系统数据');
INSERT INTO `sys_role` VALUES (5, '管理员', 'manager', 5, '1', 1, 1, '0', '0', 'admin', '2022-06-10 13:54:29', 'admin', '2023-02-22 08:17:16', '普通管理员');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2011);
INSERT INTO `sys_role_menu` VALUES (2, 2012);
INSERT INTO `sys_role_menu` VALUES (2, 2013);
INSERT INTO `sys_role_menu` VALUES (2, 2014);
INSERT INTO `sys_role_menu` VALUES (2, 2015);
INSERT INTO `sys_role_menu` VALUES (2, 2016);
INSERT INTO `sys_role_menu` VALUES (2, 2017);
INSERT INTO `sys_role_menu` VALUES (2, 2018);
INSERT INTO `sys_role_menu` VALUES (2, 2019);
INSERT INTO `sys_role_menu` VALUES (2, 2020);
INSERT INTO `sys_role_menu` VALUES (2, 2021);
INSERT INTO `sys_role_menu` VALUES (2, 2022);
INSERT INTO `sys_role_menu` VALUES (2, 2023);
INSERT INTO `sys_role_menu` VALUES (2, 2024);
INSERT INTO `sys_role_menu` VALUES (2, 2043);
INSERT INTO `sys_role_menu` VALUES (2, 2044);
INSERT INTO `sys_role_menu` VALUES (2, 2045);
INSERT INTO `sys_role_menu` VALUES (2, 2046);
INSERT INTO `sys_role_menu` VALUES (2, 2047);
INSERT INTO `sys_role_menu` VALUES (2, 2048);
INSERT INTO `sys_role_menu` VALUES (2, 2049);
INSERT INTO `sys_role_menu` VALUES (2, 2050);
INSERT INTO `sys_role_menu` VALUES (2, 2051);
INSERT INTO `sys_role_menu` VALUES (2, 2052);
INSERT INTO `sys_role_menu` VALUES (2, 2053);
INSERT INTO `sys_role_menu` VALUES (2, 2054);
INSERT INTO `sys_role_menu` VALUES (2, 2067);
INSERT INTO `sys_role_menu` VALUES (2, 2068);
INSERT INTO `sys_role_menu` VALUES (2, 2069);
INSERT INTO `sys_role_menu` VALUES (2, 2070);
INSERT INTO `sys_role_menu` VALUES (2, 2071);
INSERT INTO `sys_role_menu` VALUES (2, 2072);
INSERT INTO `sys_role_menu` VALUES (2, 2085);
INSERT INTO `sys_role_menu` VALUES (2, 2086);
INSERT INTO `sys_role_menu` VALUES (2, 2087);
INSERT INTO `sys_role_menu` VALUES (2, 2088);
INSERT INTO `sys_role_menu` VALUES (2, 2089);
INSERT INTO `sys_role_menu` VALUES (2, 2090);
INSERT INTO `sys_role_menu` VALUES (2, 2098);
INSERT INTO `sys_role_menu` VALUES (2, 2099);
INSERT INTO `sys_role_menu` VALUES (2, 2100);
INSERT INTO `sys_role_menu` VALUES (2, 2101);
INSERT INTO `sys_role_menu` VALUES (2, 2102);
INSERT INTO `sys_role_menu` VALUES (2, 2103);
INSERT INTO `sys_role_menu` VALUES (2, 2129);
INSERT INTO `sys_role_menu` VALUES (2, 2130);
INSERT INTO `sys_role_menu` VALUES (2, 2136);
INSERT INTO `sys_role_menu` VALUES (2, 2137);
INSERT INTO `sys_role_menu` VALUES (2, 2138);
INSERT INTO `sys_role_menu` VALUES (2, 2139);
INSERT INTO `sys_role_menu` VALUES (2, 2140);
INSERT INTO `sys_role_menu` VALUES (2, 2147);
INSERT INTO `sys_role_menu` VALUES (2, 2148);
INSERT INTO `sys_role_menu` VALUES (2, 2168);
INSERT INTO `sys_role_menu` VALUES (2, 2169);
INSERT INTO `sys_role_menu` VALUES (2, 2170);
INSERT INTO `sys_role_menu` VALUES (2, 2171);
INSERT INTO `sys_role_menu` VALUES (2, 2172);
INSERT INTO `sys_role_menu` VALUES (3, 1);
INSERT INTO `sys_role_menu` VALUES (3, 4);
INSERT INTO `sys_role_menu` VALUES (3, 107);
INSERT INTO `sys_role_menu` VALUES (3, 1036);
INSERT INTO `sys_role_menu` VALUES (3, 2000);
INSERT INTO `sys_role_menu` VALUES (3, 2007);
INSERT INTO `sys_role_menu` VALUES (3, 2008);
INSERT INTO `sys_role_menu` VALUES (3, 2009);
INSERT INTO `sys_role_menu` VALUES (3, 2010);
INSERT INTO `sys_role_menu` VALUES (3, 2011);
INSERT INTO `sys_role_menu` VALUES (3, 2012);
INSERT INTO `sys_role_menu` VALUES (3, 2019);
INSERT INTO `sys_role_menu` VALUES (3, 2020);
INSERT INTO `sys_role_menu` VALUES (3, 2021);
INSERT INTO `sys_role_menu` VALUES (3, 2022);
INSERT INTO `sys_role_menu` VALUES (3, 2023);
INSERT INTO `sys_role_menu` VALUES (3, 2024);
INSERT INTO `sys_role_menu` VALUES (3, 2067);
INSERT INTO `sys_role_menu` VALUES (3, 2068);
INSERT INTO `sys_role_menu` VALUES (3, 2085);
INSERT INTO `sys_role_menu` VALUES (3, 2086);
INSERT INTO `sys_role_menu` VALUES (3, 2087);
INSERT INTO `sys_role_menu` VALUES (3, 2088);
INSERT INTO `sys_role_menu` VALUES (3, 2089);
INSERT INTO `sys_role_menu` VALUES (3, 2090);
INSERT INTO `sys_role_menu` VALUES (3, 2129);
INSERT INTO `sys_role_menu` VALUES (3, 2130);
INSERT INTO `sys_role_menu` VALUES (3, 2147);
INSERT INTO `sys_role_menu` VALUES (3, 2148);
INSERT INTO `sys_role_menu` VALUES (3, 2168);
INSERT INTO `sys_role_menu` VALUES (3, 2169);
INSERT INTO `sys_role_menu` VALUES (3, 2170);
INSERT INTO `sys_role_menu` VALUES (3, 2171);
INSERT INTO `sys_role_menu` VALUES (3, 2172);
INSERT INTO `sys_role_menu` VALUES (4, 1);
INSERT INTO `sys_role_menu` VALUES (4, 2);
INSERT INTO `sys_role_menu` VALUES (4, 3);
INSERT INTO `sys_role_menu` VALUES (4, 4);
INSERT INTO `sys_role_menu` VALUES (4, 100);
INSERT INTO `sys_role_menu` VALUES (4, 101);
INSERT INTO `sys_role_menu` VALUES (4, 102);
INSERT INTO `sys_role_menu` VALUES (4, 103);
INSERT INTO `sys_role_menu` VALUES (4, 104);
INSERT INTO `sys_role_menu` VALUES (4, 105);
INSERT INTO `sys_role_menu` VALUES (4, 106);
INSERT INTO `sys_role_menu` VALUES (4, 107);
INSERT INTO `sys_role_menu` VALUES (4, 108);
INSERT INTO `sys_role_menu` VALUES (4, 109);
INSERT INTO `sys_role_menu` VALUES (4, 110);
INSERT INTO `sys_role_menu` VALUES (4, 111);
INSERT INTO `sys_role_menu` VALUES (4, 112);
INSERT INTO `sys_role_menu` VALUES (4, 113);
INSERT INTO `sys_role_menu` VALUES (4, 114);
INSERT INTO `sys_role_menu` VALUES (4, 115);
INSERT INTO `sys_role_menu` VALUES (4, 116);
INSERT INTO `sys_role_menu` VALUES (4, 500);
INSERT INTO `sys_role_menu` VALUES (4, 501);
INSERT INTO `sys_role_menu` VALUES (4, 1001);
INSERT INTO `sys_role_menu` VALUES (4, 1008);
INSERT INTO `sys_role_menu` VALUES (4, 1013);
INSERT INTO `sys_role_menu` VALUES (4, 1017);
INSERT INTO `sys_role_menu` VALUES (4, 1021);
INSERT INTO `sys_role_menu` VALUES (4, 1026);
INSERT INTO `sys_role_menu` VALUES (4, 1031);
INSERT INTO `sys_role_menu` VALUES (4, 1036);
INSERT INTO `sys_role_menu` VALUES (4, 1040);
INSERT INTO `sys_role_menu` VALUES (4, 1043);
INSERT INTO `sys_role_menu` VALUES (4, 1046);
INSERT INTO `sys_role_menu` VALUES (4, 1049);
INSERT INTO `sys_role_menu` VALUES (4, 1055);
INSERT INTO `sys_role_menu` VALUES (4, 2000);
INSERT INTO `sys_role_menu` VALUES (4, 2001);
INSERT INTO `sys_role_menu` VALUES (4, 2002);
INSERT INTO `sys_role_menu` VALUES (4, 2003);
INSERT INTO `sys_role_menu` VALUES (4, 2007);
INSERT INTO `sys_role_menu` VALUES (4, 2008);
INSERT INTO `sys_role_menu` VALUES (4, 2009);
INSERT INTO `sys_role_menu` VALUES (4, 2013);
INSERT INTO `sys_role_menu` VALUES (4, 2014);
INSERT INTO `sys_role_menu` VALUES (4, 2015);
INSERT INTO `sys_role_menu` VALUES (4, 2019);
INSERT INTO `sys_role_menu` VALUES (4, 2020);
INSERT INTO `sys_role_menu` VALUES (4, 2021);
INSERT INTO `sys_role_menu` VALUES (4, 2043);
INSERT INTO `sys_role_menu` VALUES (4, 2044);
INSERT INTO `sys_role_menu` VALUES (4, 2045);
INSERT INTO `sys_role_menu` VALUES (4, 2049);
INSERT INTO `sys_role_menu` VALUES (4, 2050);
INSERT INTO `sys_role_menu` VALUES (4, 2051);
INSERT INTO `sys_role_menu` VALUES (4, 2067);
INSERT INTO `sys_role_menu` VALUES (4, 2068);
INSERT INTO `sys_role_menu` VALUES (4, 2069);
INSERT INTO `sys_role_menu` VALUES (4, 2085);
INSERT INTO `sys_role_menu` VALUES (4, 2086);
INSERT INTO `sys_role_menu` VALUES (4, 2087);
INSERT INTO `sys_role_menu` VALUES (4, 2098);
INSERT INTO `sys_role_menu` VALUES (4, 2099);
INSERT INTO `sys_role_menu` VALUES (4, 2100);
INSERT INTO `sys_role_menu` VALUES (4, 2104);
INSERT INTO `sys_role_menu` VALUES (4, 2105);
INSERT INTO `sys_role_menu` VALUES (4, 2106);
INSERT INTO `sys_role_menu` VALUES (4, 2107);
INSERT INTO `sys_role_menu` VALUES (4, 2108);
INSERT INTO `sys_role_menu` VALUES (4, 2109);
INSERT INTO `sys_role_menu` VALUES (4, 2111);
INSERT INTO `sys_role_menu` VALUES (4, 2112);
INSERT INTO `sys_role_menu` VALUES (4, 2123);
INSERT INTO `sys_role_menu` VALUES (4, 2124);
INSERT INTO `sys_role_menu` VALUES (4, 2125);
INSERT INTO `sys_role_menu` VALUES (4, 2129);
INSERT INTO `sys_role_menu` VALUES (4, 2130);
INSERT INTO `sys_role_menu` VALUES (4, 2131);
INSERT INTO `sys_role_menu` VALUES (4, 2136);
INSERT INTO `sys_role_menu` VALUES (4, 2137);
INSERT INTO `sys_role_menu` VALUES (4, 2141);
INSERT INTO `sys_role_menu` VALUES (4, 2143);
INSERT INTO `sys_role_menu` VALUES (4, 2144);
INSERT INTO `sys_role_menu` VALUES (4, 2147);
INSERT INTO `sys_role_menu` VALUES (4, 2148);
INSERT INTO `sys_role_menu` VALUES (4, 2149);
INSERT INTO `sys_role_menu` VALUES (4, 2167);
INSERT INTO `sys_role_menu` VALUES (4, 2168);
INSERT INTO `sys_role_menu` VALUES (4, 2169);
INSERT INTO `sys_role_menu` VALUES (4, 2170);
INSERT INTO `sys_role_menu` VALUES (5, 1);
INSERT INTO `sys_role_menu` VALUES (5, 2);
INSERT INTO `sys_role_menu` VALUES (5, 3);
INSERT INTO `sys_role_menu` VALUES (5, 4);
INSERT INTO `sys_role_menu` VALUES (5, 100);
INSERT INTO `sys_role_menu` VALUES (5, 101);
INSERT INTO `sys_role_menu` VALUES (5, 102);
INSERT INTO `sys_role_menu` VALUES (5, 103);
INSERT INTO `sys_role_menu` VALUES (5, 104);
INSERT INTO `sys_role_menu` VALUES (5, 105);
INSERT INTO `sys_role_menu` VALUES (5, 106);
INSERT INTO `sys_role_menu` VALUES (5, 107);
INSERT INTO `sys_role_menu` VALUES (5, 108);
INSERT INTO `sys_role_menu` VALUES (5, 109);
INSERT INTO `sys_role_menu` VALUES (5, 110);
INSERT INTO `sys_role_menu` VALUES (5, 111);
INSERT INTO `sys_role_menu` VALUES (5, 112);
INSERT INTO `sys_role_menu` VALUES (5, 113);
INSERT INTO `sys_role_menu` VALUES (5, 114);
INSERT INTO `sys_role_menu` VALUES (5, 115);
INSERT INTO `sys_role_menu` VALUES (5, 116);
INSERT INTO `sys_role_menu` VALUES (5, 500);
INSERT INTO `sys_role_menu` VALUES (5, 501);
INSERT INTO `sys_role_menu` VALUES (5, 1001);
INSERT INTO `sys_role_menu` VALUES (5, 1002);
INSERT INTO `sys_role_menu` VALUES (5, 1003);
INSERT INTO `sys_role_menu` VALUES (5, 1004);
INSERT INTO `sys_role_menu` VALUES (5, 1005);
INSERT INTO `sys_role_menu` VALUES (5, 1006);
INSERT INTO `sys_role_menu` VALUES (5, 1007);
INSERT INTO `sys_role_menu` VALUES (5, 1008);
INSERT INTO `sys_role_menu` VALUES (5, 1009);
INSERT INTO `sys_role_menu` VALUES (5, 1010);
INSERT INTO `sys_role_menu` VALUES (5, 1011);
INSERT INTO `sys_role_menu` VALUES (5, 1012);
INSERT INTO `sys_role_menu` VALUES (5, 1013);
INSERT INTO `sys_role_menu` VALUES (5, 1014);
INSERT INTO `sys_role_menu` VALUES (5, 1015);
INSERT INTO `sys_role_menu` VALUES (5, 1016);
INSERT INTO `sys_role_menu` VALUES (5, 1017);
INSERT INTO `sys_role_menu` VALUES (5, 1018);
INSERT INTO `sys_role_menu` VALUES (5, 1019);
INSERT INTO `sys_role_menu` VALUES (5, 1020);
INSERT INTO `sys_role_menu` VALUES (5, 1021);
INSERT INTO `sys_role_menu` VALUES (5, 1022);
INSERT INTO `sys_role_menu` VALUES (5, 1023);
INSERT INTO `sys_role_menu` VALUES (5, 1024);
INSERT INTO `sys_role_menu` VALUES (5, 1025);
INSERT INTO `sys_role_menu` VALUES (5, 1026);
INSERT INTO `sys_role_menu` VALUES (5, 1027);
INSERT INTO `sys_role_menu` VALUES (5, 1028);
INSERT INTO `sys_role_menu` VALUES (5, 1029);
INSERT INTO `sys_role_menu` VALUES (5, 1030);
INSERT INTO `sys_role_menu` VALUES (5, 1031);
INSERT INTO `sys_role_menu` VALUES (5, 1032);
INSERT INTO `sys_role_menu` VALUES (5, 1033);
INSERT INTO `sys_role_menu` VALUES (5, 1034);
INSERT INTO `sys_role_menu` VALUES (5, 1035);
INSERT INTO `sys_role_menu` VALUES (5, 1036);
INSERT INTO `sys_role_menu` VALUES (5, 1037);
INSERT INTO `sys_role_menu` VALUES (5, 1038);
INSERT INTO `sys_role_menu` VALUES (5, 1039);
INSERT INTO `sys_role_menu` VALUES (5, 1040);
INSERT INTO `sys_role_menu` VALUES (5, 1041);
INSERT INTO `sys_role_menu` VALUES (5, 1042);
INSERT INTO `sys_role_menu` VALUES (5, 1043);
INSERT INTO `sys_role_menu` VALUES (5, 1044);
INSERT INTO `sys_role_menu` VALUES (5, 1045);
INSERT INTO `sys_role_menu` VALUES (5, 1046);
INSERT INTO `sys_role_menu` VALUES (5, 1047);
INSERT INTO `sys_role_menu` VALUES (5, 1048);
INSERT INTO `sys_role_menu` VALUES (5, 1049);
INSERT INTO `sys_role_menu` VALUES (5, 1050);
INSERT INTO `sys_role_menu` VALUES (5, 1051);
INSERT INTO `sys_role_menu` VALUES (5, 1052);
INSERT INTO `sys_role_menu` VALUES (5, 1053);
INSERT INTO `sys_role_menu` VALUES (5, 1054);
INSERT INTO `sys_role_menu` VALUES (5, 1055);
INSERT INTO `sys_role_menu` VALUES (5, 1056);
INSERT INTO `sys_role_menu` VALUES (5, 1057);
INSERT INTO `sys_role_menu` VALUES (5, 1058);
INSERT INTO `sys_role_menu` VALUES (5, 1059);
INSERT INTO `sys_role_menu` VALUES (5, 1060);
INSERT INTO `sys_role_menu` VALUES (5, 2000);
INSERT INTO `sys_role_menu` VALUES (5, 2001);
INSERT INTO `sys_role_menu` VALUES (5, 2002);
INSERT INTO `sys_role_menu` VALUES (5, 2003);
INSERT INTO `sys_role_menu` VALUES (5, 2004);
INSERT INTO `sys_role_menu` VALUES (5, 2005);
INSERT INTO `sys_role_menu` VALUES (5, 2006);
INSERT INTO `sys_role_menu` VALUES (5, 2007);
INSERT INTO `sys_role_menu` VALUES (5, 2008);
INSERT INTO `sys_role_menu` VALUES (5, 2009);
INSERT INTO `sys_role_menu` VALUES (5, 2010);
INSERT INTO `sys_role_menu` VALUES (5, 2011);
INSERT INTO `sys_role_menu` VALUES (5, 2012);
INSERT INTO `sys_role_menu` VALUES (5, 2013);
INSERT INTO `sys_role_menu` VALUES (5, 2014);
INSERT INTO `sys_role_menu` VALUES (5, 2015);
INSERT INTO `sys_role_menu` VALUES (5, 2016);
INSERT INTO `sys_role_menu` VALUES (5, 2017);
INSERT INTO `sys_role_menu` VALUES (5, 2018);
INSERT INTO `sys_role_menu` VALUES (5, 2019);
INSERT INTO `sys_role_menu` VALUES (5, 2020);
INSERT INTO `sys_role_menu` VALUES (5, 2021);
INSERT INTO `sys_role_menu` VALUES (5, 2022);
INSERT INTO `sys_role_menu` VALUES (5, 2023);
INSERT INTO `sys_role_menu` VALUES (5, 2024);
INSERT INTO `sys_role_menu` VALUES (5, 2043);
INSERT INTO `sys_role_menu` VALUES (5, 2044);
INSERT INTO `sys_role_menu` VALUES (5, 2045);
INSERT INTO `sys_role_menu` VALUES (5, 2046);
INSERT INTO `sys_role_menu` VALUES (5, 2047);
INSERT INTO `sys_role_menu` VALUES (5, 2048);
INSERT INTO `sys_role_menu` VALUES (5, 2049);
INSERT INTO `sys_role_menu` VALUES (5, 2050);
INSERT INTO `sys_role_menu` VALUES (5, 2051);
INSERT INTO `sys_role_menu` VALUES (5, 2052);
INSERT INTO `sys_role_menu` VALUES (5, 2053);
INSERT INTO `sys_role_menu` VALUES (5, 2054);
INSERT INTO `sys_role_menu` VALUES (5, 2067);
INSERT INTO `sys_role_menu` VALUES (5, 2068);
INSERT INTO `sys_role_menu` VALUES (5, 2069);
INSERT INTO `sys_role_menu` VALUES (5, 2070);
INSERT INTO `sys_role_menu` VALUES (5, 2071);
INSERT INTO `sys_role_menu` VALUES (5, 2072);
INSERT INTO `sys_role_menu` VALUES (5, 2085);
INSERT INTO `sys_role_menu` VALUES (5, 2086);
INSERT INTO `sys_role_menu` VALUES (5, 2087);
INSERT INTO `sys_role_menu` VALUES (5, 2088);
INSERT INTO `sys_role_menu` VALUES (5, 2089);
INSERT INTO `sys_role_menu` VALUES (5, 2090);
INSERT INTO `sys_role_menu` VALUES (5, 2098);
INSERT INTO `sys_role_menu` VALUES (5, 2099);
INSERT INTO `sys_role_menu` VALUES (5, 2100);
INSERT INTO `sys_role_menu` VALUES (5, 2101);
INSERT INTO `sys_role_menu` VALUES (5, 2102);
INSERT INTO `sys_role_menu` VALUES (5, 2103);
INSERT INTO `sys_role_menu` VALUES (5, 2104);
INSERT INTO `sys_role_menu` VALUES (5, 2105);
INSERT INTO `sys_role_menu` VALUES (5, 2106);
INSERT INTO `sys_role_menu` VALUES (5, 2107);
INSERT INTO `sys_role_menu` VALUES (5, 2108);
INSERT INTO `sys_role_menu` VALUES (5, 2109);
INSERT INTO `sys_role_menu` VALUES (5, 2111);
INSERT INTO `sys_role_menu` VALUES (5, 2112);
INSERT INTO `sys_role_menu` VALUES (5, 2123);
INSERT INTO `sys_role_menu` VALUES (5, 2124);
INSERT INTO `sys_role_menu` VALUES (5, 2125);
INSERT INTO `sys_role_menu` VALUES (5, 2126);
INSERT INTO `sys_role_menu` VALUES (5, 2127);
INSERT INTO `sys_role_menu` VALUES (5, 2128);
INSERT INTO `sys_role_menu` VALUES (5, 2129);
INSERT INTO `sys_role_menu` VALUES (5, 2130);
INSERT INTO `sys_role_menu` VALUES (5, 2131);
INSERT INTO `sys_role_menu` VALUES (5, 2132);
INSERT INTO `sys_role_menu` VALUES (5, 2133);
INSERT INTO `sys_role_menu` VALUES (5, 2134);
INSERT INTO `sys_role_menu` VALUES (5, 2136);
INSERT INTO `sys_role_menu` VALUES (5, 2137);
INSERT INTO `sys_role_menu` VALUES (5, 2138);
INSERT INTO `sys_role_menu` VALUES (5, 2139);
INSERT INTO `sys_role_menu` VALUES (5, 2140);
INSERT INTO `sys_role_menu` VALUES (5, 2141);
INSERT INTO `sys_role_menu` VALUES (5, 2143);
INSERT INTO `sys_role_menu` VALUES (5, 2144);
INSERT INTO `sys_role_menu` VALUES (5, 2145);
INSERT INTO `sys_role_menu` VALUES (5, 2146);
INSERT INTO `sys_role_menu` VALUES (5, 2147);
INSERT INTO `sys_role_menu` VALUES (5, 2148);
INSERT INTO `sys_role_menu` VALUES (5, 2149);
INSERT INTO `sys_role_menu` VALUES (5, 2152);
INSERT INTO `sys_role_menu` VALUES (5, 2153);
INSERT INTO `sys_role_menu` VALUES (5, 2154);
INSERT INTO `sys_role_menu` VALUES (5, 2155);
INSERT INTO `sys_role_menu` VALUES (5, 2156);
INSERT INTO `sys_role_menu` VALUES (5, 2157);
INSERT INTO `sys_role_menu` VALUES (5, 2159);
INSERT INTO `sys_role_menu` VALUES (5, 2160);
INSERT INTO `sys_role_menu` VALUES (5, 2161);
INSERT INTO `sys_role_menu` VALUES (5, 2162);
INSERT INTO `sys_role_menu` VALUES (5, 2163);
INSERT INTO `sys_role_menu` VALUES (5, 2167);
INSERT INTO `sys_role_menu` VALUES (5, 2168);
INSERT INTO `sys_role_menu` VALUES (5, 2169);
INSERT INTO `sys_role_menu` VALUES (5, 2170);
INSERT INTO `sys_role_menu` VALUES (5, 2171);
INSERT INTO `sys_role_menu` VALUES (5, 2172);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '蜂信物联管理员', '00', '164770707@qq.com', '15888888888', '0', '', '$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUu', '0', '0', '223.73.5.196', '2023-02-26 14:45:44', 'admin', '2021-12-15 21:36:18', '', '2023-02-26 14:45:43', '管理员');
INSERT INTO `sys_user` VALUES (2, 100, 'wumei-t1', '物美租户壹', '00', '', '15888888880', '0', '', '$2a$10$BAWId9C2Nrcwklzl1Ikoau4iqL8XRGvfRjq6Wl.PXWpzwAw0sXMdK', '0', '0', '175.0.52.110', '2023-02-26 16:34:52', 'admin', '2022-04-15 16:21:25', 'admin', '2023-02-26 16:34:51', NULL);
INSERT INTO `sys_user` VALUES (3, 100, 'wumei-t2', '物美租户贰', '00', '', '15888888881', '0', '', '$2a$10$1zMlbW7hGpzA59gpzWGO/ObeASziQ296evjMjHrYdZnxKBLU4WUum', '0', '0', '127.0.0.1', '2022-06-12 00:54:28', 'admin', '2022-04-15 16:22:08', 'admin', '2022-06-12 00:54:30', NULL);
INSERT INTO `sys_user` VALUES (4, 100, 'wumei-u1', '物美用户壹', '00', '', '15888888882', '0', '', '$2a$10$691RJMXZ9HM4sgNTExLPfO5Nw6J6cWgCvcoF9V.jKMnPk5o/8c9VS', '0', '0', '223.147.227.64', '2023-02-26 23:26:17', 'admin', '2022-04-15 16:22:37', 'admin', '2023-02-26 23:26:17', NULL);
INSERT INTO `sys_user` VALUES (5, 100, 'wumei-u2', '物美用户贰', '00', '', '15888888883', '0', '', '$2a$10$x3rM39rewwbi7ayvriGMEOKUHoPCqcL2CYXPLTJRCWYPVvykFIYJq', '0', '0', '127.0.0.1', '2022-06-12 00:55:45', 'admin', '2022-04-15 16:23:13', 'admin', '2022-06-12 00:55:46', NULL);
INSERT INTO `sys_user` VALUES (6, 100, 'wumei', '游客账号', '00', '', '15888888884', '0', '', '$2a$10$kKeZptrTnSlm0fencX4U2eq.QiaukDs.DckiUsMCwVTxh0IS2LRQ.', '0', '0', '223.210.17.244', '2023-02-26 23:16:12', 'admin', '2022-03-09 16:49:19', 'admin', '2023-02-26 23:16:11', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (6, 4);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 2);
INSERT INTO `sys_user_role` VALUES (4, 3);
INSERT INTO `sys_user_role` VALUES (5, 3);
INSERT INTO `sys_user_role` VALUES (6, 4);

SET FOREIGN_KEY_CHECKS = 1;
