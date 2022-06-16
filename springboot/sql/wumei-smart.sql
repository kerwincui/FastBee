/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云RDS
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : kerwincui.mysql.rds.aliyuncs.com:3306
 Source Schema         : wumei-smart-dev

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 16/06/2022 23:42:26
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
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

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
INSERT INTO `gen_table` VALUES (25, 'iot_device_job', '设备定时', NULL, NULL, 'DeviceJob', 'crud', 'com.ruoyi.iot', 'iot', 'job', '设备定时', 'kerwincui', '0', '/', NULL, 'admin', '2022-01-17 16:18:25', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (26, 'iot_device_group', '设备分组', NULL, NULL, 'DeviceGroup', 'crud', 'com.ruoyi.iot', 'iot', 'group', '设备分组', 'kerwincui', '0', '/', NULL, 'admin', '2022-01-24 00:29:24', '', NULL, NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 501 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'category_id', '产品分类ID', 'bigint(20)', 'Long', 'categoryId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:01');
INSERT INTO `gen_table_column` VALUES (2, '1', 'category_name', '产品分类名称', 'varchar(64)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (3, '1', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (4, '1', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (5, '1', 'is_sys', '是否系统通用（0-否，1-是）', 'tinyint(1)', 'Integer', 'isSys', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', 'iot_yes_no', 5, 'admin', '2021-12-15 22:56:19', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (6, '1', 'parent_id', '父级ID', 'bigint(20)', 'Long', 'parentId', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 6, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (7, '1', 'order_num', '显示顺序', 'int(4)', 'Integer', 'orderNum', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (8, '1', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:02');
INSERT INTO `gen_table_column` VALUES (9, '1', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (10, '1', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 10, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (11, '1', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2021-12-15 22:56:20', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (12, '1', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2021-12-15 22:56:21', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (13, '1', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2021-12-15 22:56:21', '', '2021-12-20 14:35:03');
INSERT INTO `gen_table_column` VALUES (14, '2', 'device_id', '产品分类ID', 'bigint(20)', 'Long', 'deviceId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:21', '', '2021-12-16 00:23:18');
INSERT INTO `gen_table_column` VALUES (15, '2', 'device_name', '产品分类名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:21', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (16, '2', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:21', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (17, '2', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:22', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (18, '2', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:22', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (19, '2', 'user_name', '用户昵称', 'varchar(30)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:22', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (20, '2', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:22', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (21, '2', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 8, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:19');
INSERT INTO `gen_table_column` VALUES (22, '2', 'serial_number', '设备编号', 'varchar(64)', 'String', 'serialNumber', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (23, '2', 'firmware_version', '固件版本', 'float(11,2)', 'BigDecimal', 'firmwareVersion', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 10, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (24, '2', 'status', '设备状态（1-未激活，2-禁用，3-在线，4-离线）', 'tinyint(1)', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'iot_yes_no', 11, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (26, '2', 'rssi', 'wifi信号强度（\r\n信号极好4格[-55— 0]，\r\n信号好3格[-70— -55]，\r\n信号一般2格[-85— -70]，\r\n信号差1格[-100— -85]）', 'varchar(255)', 'Integer', 'rssi', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (27, '2', 'network_address', '设备所在地址', 'varchar(255)', 'String', 'networkAddress', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 14, 'admin', '2021-12-15 22:56:23', '', '2021-12-16 00:23:20');
INSERT INTO `gen_table_column` VALUES (28, '2', 'network_ip', '设备入网IP', 'varchar(32)', 'String', 'networkIp', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 15, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (29, '2', 'longitude', '设备经度', 'double(11,0)', 'Long', 'longitude', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 16, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (30, '2', 'latitude', '设备纬度', 'double(11,0)', 'Long', 'latitude', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 17, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (31, '2', 'active_time', '激活时间', 'datetime', 'Date', 'activeTime', '0', '0', NULL, '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 18, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (32, '2', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 19, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (33, '2', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 20, 'admin', '2021-12-15 22:56:24', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (34, '2', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 21, 'admin', '2021-12-15 22:56:25', '', '2021-12-16 00:23:21');
INSERT INTO `gen_table_column` VALUES (35, '2', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 22, 'admin', '2021-12-15 22:56:25', '', '2021-12-16 00:23:22');
INSERT INTO `gen_table_column` VALUES (36, '2', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 23, 'admin', '2021-12-15 22:56:25', '', '2021-12-16 00:23:22');
INSERT INTO `gen_table_column` VALUES (37, '2', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 24, 'admin', '2021-12-15 22:56:25', '', '2021-12-16 00:23:22');
INSERT INTO `gen_table_column` VALUES (70, '5', 'device_id', '固件ID', 'bigint(20)', 'Long', 'deviceId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47');
INSERT INTO `gen_table_column` VALUES (71, '5', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 2, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47');
INSERT INTO `gen_table_column` VALUES (73, '5', 'device_name', '设备名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47');
INSERT INTO `gen_table_column` VALUES (75, '5', 'user_name', '用户昵称', 'varchar(30)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:47');
INSERT INTO `gen_table_column` VALUES (77, '5', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:29', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (79, '5', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (81, '5', 'is_owner', '是否为设备所有者', 'tinyint(11)', 'Long', 'isOwner', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', 'iot_yes_no', 7, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (85, '5', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (87, '5', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:48');
INSERT INTO `gen_table_column` VALUES (89, '5', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 11, 'admin', '2021-12-15 22:56:30', '', '2021-12-16 01:16:49');
INSERT INTO `gen_table_column` VALUES (91, '5', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2021-12-15 22:56:31', '', '2021-12-16 01:16:49');
INSERT INTO `gen_table_column` VALUES (93, '5', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2021-12-15 22:56:31', '', '2021-12-16 01:16:49');
INSERT INTO `gen_table_column` VALUES (95, '5', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 14, 'admin', '2021-12-15 22:56:31', '', '2021-12-16 01:16:49');
INSERT INTO `gen_table_column` VALUES (99, '7', 'firmware_id', '固件ID', 'bigint(20)', 'Long', 'firmwareId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:31', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (101, '7', 'firmware_name', '固件名称', 'varchar(64)', 'String', 'firmwareName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (103, '7', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (105, '7', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (107, '7', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (109, '7', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:32', '', '2021-12-16 00:18:09');
INSERT INTO `gen_table_column` VALUES (111, '7', 'is_sys', '是否系统通用（0-否，1-是）', 'tinyint(1)', 'Integer', 'isSys', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', 'iot_yes_no', 7, 'admin', '2021-12-15 22:56:33', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (113, '7', 'version', '固件版本', 'float(11,2)', 'BigDecimal', 'version', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 8, 'admin', '2021-12-15 22:56:33', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (115, '7', 'file_path', '文件路径', 'varchar(255)', 'String', 'filePath', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:33', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (117, '7', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2021-12-15 22:56:33', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (118, '7', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (119, '7', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 12, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (121, '7', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (123, '7', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:10');
INSERT INTO `gen_table_column` VALUES (125, '7', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 15, 'admin', '2021-12-15 22:56:34', '', '2021-12-16 00:18:11');
INSERT INTO `gen_table_column` VALUES (129, '9', 'group_id', '分组ID', 'bigint(20)', 'Long', 'groupId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:15');
INSERT INTO `gen_table_column` VALUES (131, '9', 'group_name', '分组名称', 'varchar(64)', 'String', 'groupName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:15');
INSERT INTO `gen_table_column` VALUES (133, '9', 'group_order', '分组排序', 'tinyint(11)', 'Long', 'groupOrder', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:16');
INSERT INTO `gen_table_column` VALUES (135, '9', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 4, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:16');
INSERT INTO `gen_table_column` VALUES (137, '9', 'user_name', '用户昵称', 'varchar(30)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2021-12-15 22:56:35', '', '2021-12-16 00:31:16');
INSERT INTO `gen_table_column` VALUES (143, '9', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2021-12-15 22:56:36', '', '2021-12-16 00:31:17');
INSERT INTO `gen_table_column` VALUES (145, '9', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2021-12-15 22:56:36', '', '2021-12-16 00:31:17');
INSERT INTO `gen_table_column` VALUES (147, '9', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 10, 'admin', '2021-12-15 22:56:36', '', '2021-12-16 00:31:17');
INSERT INTO `gen_table_column` VALUES (149, '9', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2021-12-15 22:56:36', '', '2021-12-16 00:31:17');
INSERT INTO `gen_table_column` VALUES (152, '9', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:31:18');
INSERT INTO `gen_table_column` VALUES (154, '9', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:31:18');
INSERT INTO `gen_table_column` VALUES (155, '11', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (158, '11', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:37', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (160, '11', 'category_id', '产品分类ID', 'bigint(20)', 'Long', 'categoryId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (162, '11', 'category_name', '产品分类名称', 'varchar(64)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (164, '11', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (166, '11', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (168, '11', 'is_sys', '是否系统通用（0-否，1-是）', 'tinyint(1)', 'Integer', 'isSys', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:12');
INSERT INTO `gen_table_column` VALUES (169, '11', 'status', '状态（1-未发布，2-已发布，不能修改）', 'tinyint(1)', 'Integer', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'iot_yes_no', 8, 'admin', '2021-12-15 22:56:38', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (173, '11', 'device_type', '设备类型（1-直连设备、2-网关子设备、3-网关设备）', 'tinyint(1)', 'Integer', 'deviceType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 10, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (176, '11', 'network_method', '联网方式（1-wifi、2-蓝牙、3-wifi+蓝牙）', 'tinyint(1)', 'Integer', 'networkMethod', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', 'iot_yes_no', 11, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (177, '11', 'vertificate_method', '认证方式（1-账号密码、2-证书、3-Http）', 'tinyint(1)', 'Integer', 'vertificateMethod', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 12, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (179, '11', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (181, '11', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2021-12-15 22:56:39', '', '2021-12-16 00:22:13');
INSERT INTO `gen_table_column` VALUES (183, '11', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 15, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:22:14');
INSERT INTO `gen_table_column` VALUES (184, '11', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:22:14');
INSERT INTO `gen_table_column` VALUES (186, '11', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:22:14');
INSERT INTO `gen_table_column` VALUES (188, '11', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 18, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:22:14');
INSERT INTO `gen_table_column` VALUES (191, '13', 'model_id', '物模型ID', 'bigint(20)', 'Long', 'modelId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:40', '', '2021-12-16 00:29:39');
INSERT INTO `gen_table_column` VALUES (193, '13', 'model_name', '物模型名称', 'varchar(64)', 'String', 'modelName', '0', '0', '1', '1', '1', '1', NULL, 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:39');
INSERT INTO `gen_table_column` VALUES (195, '13', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:39');
INSERT INTO `gen_table_column` VALUES (197, '13', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', NULL, 'LIKE', 'input', '', 4, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:39');
INSERT INTO `gen_table_column` VALUES (199, '13', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (201, '13', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', NULL, 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (203, '13', 'identifier', '标识符，产品下唯一', 'varchar(32)', 'String', 'identifier', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:41', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (205, '13', 'type', '模型类别（1-属性，2-功能，3-事件）', 'tinyint(1)', 'Integer', 'type', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'select', 'iot_things_type', 8, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (207, '13', 'datatype', '数据类型（integer、decimal、string、bool、array、enum）', 'varchar(64)', 'String', 'datatype', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'select', 'iot_data_type', 9, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (209, '13', 'specs', '数据定义', 'json', 'String', 'specs', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 10, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:40');
INSERT INTO `gen_table_column` VALUES (211, '13', 'is_Top', '是否首页显示（0-否，1-是）', 'tinyint(1)', 'Integer', 'isTop', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', 'iot_yes_no', 11, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (213, '13', 'is_Monitor', '是否实时监测（0-否，1-是）', 'tinyint(1)', 'Integer', 'isMonitor', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', 'iot_yes_no', 12, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (214, '13', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:42', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (215, '13', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (217, '13', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 15, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (220, '13', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:41');
INSERT INTO `gen_table_column` VALUES (222, '13', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:42');
INSERT INTO `gen_table_column` VALUES (224, '13', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 18, 'admin', '2021-12-15 22:56:43', '', '2021-12-16 00:29:42');
INSERT INTO `gen_table_column` VALUES (227, '15', 'template_id', '物模型ID', 'bigint(20)', 'Long', 'templateId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-12-15 22:56:44', '', '2021-12-16 00:26:56');
INSERT INTO `gen_table_column` VALUES (229, '15', 'template_name', '物模型名称', 'varchar(64)', 'String', 'templateName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-12-15 22:56:44', '', '2021-12-16 00:26:57');
INSERT INTO `gen_table_column` VALUES (235, '15', 'tenant_id', '租户ID', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2021-12-15 22:56:44', '', '2021-12-16 00:26:57');
INSERT INTO `gen_table_column` VALUES (237, '15', 'tenant_name', '租户名称', 'varchar(30)', 'String', 'tenantName', '0', '0', '1', '1', '1', '1', NULL, 'LIKE', 'input', '', 6, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:57');
INSERT INTO `gen_table_column` VALUES (239, '15', 'identifier', '标识符，产品下唯一', 'varchar(32)', 'String', 'identifier', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:58');
INSERT INTO `gen_table_column` VALUES (240, '15', 'type', '模型类别（1-属性，2-功能，3-事件）', 'tinyint(1)', 'Integer', 'type', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_things_type', 8, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:58');
INSERT INTO `gen_table_column` VALUES (241, '15', 'datatype', '数据类型（integer、decimal、string、bool、array、enum）', 'varchar(64)', 'String', 'datatype', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'select', 'iot_data_type', 9, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:58');
INSERT INTO `gen_table_column` VALUES (243, '15', 'specs', '数据定义', 'json', 'String', 'specs', '0', '0', '1', '1', '1', '1', '1', 'EQ', NULL, '', 10, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:58');
INSERT INTO `gen_table_column` VALUES (245, '15', 'is_sys', '是否系统通用（0-否，1-是）', 'tinyint(1)', 'Integer', 'isSys', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 11, 'admin', '2021-12-15 22:56:45', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (247, '15', 'is_Top', '是否首页显示（0-否，1-是）', 'tinyint(1)', 'Integer', 'isTop', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 12, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (249, '15', 'is_Monitor', '是否实时监测（0-否，1-是）', 'tinyint(1)', 'Integer', 'isMonitor', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 13, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (251, '15', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (253, '15', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 15, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (255, '15', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 16, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (257, '15', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 17, 'admin', '2021-12-15 22:56:46', '', '2021-12-16 00:26:59');
INSERT INTO `gen_table_column` VALUES (259, '15', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 18, 'admin', '2021-12-15 22:56:47', '', '2021-12-16 00:27:00');
INSERT INTO `gen_table_column` VALUES (261, '15', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 19, 'admin', '2021-12-15 22:56:47', '', '2021-12-16 00:27:00');
INSERT INTO `gen_table_column` VALUES (309, '20', 'alert_id', '告警ID', 'bigint(20)', 'Long', 'alertId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-13 14:53:24', '', '2022-01-13 15:16:02');
INSERT INTO `gen_table_column` VALUES (310, '20', 'alert_name', '告警名称', 'varchar(64)', 'String', 'alertName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-01-13 14:53:24', '', '2022-01-13 15:16:02');
INSERT INTO `gen_table_column` VALUES (311, '20', 'alert_level', '告警级别（1=提醒通知，2=轻微问题，3=严重警告）', 'tinyint(11)', 'Long', 'alertLevel', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_alert_level', 3, 'admin', '2022-01-13 14:53:24', '', '2022-01-13 15:16:02');
INSERT INTO `gen_table_column` VALUES (312, '20', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-01-13 14:53:25', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (313, '20', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2022-01-13 14:53:25', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (314, '20', 'triggers', '触发器', 'json', 'String', 'triggers', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 6, 'admin', '2022-01-13 14:53:25', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (315, '20', 'actions', '执行动作', 'json', 'String', 'actions', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 7, 'admin', '2022-01-13 14:53:25', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (316, '20', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:03');
INSERT INTO `gen_table_column` VALUES (317, '20', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 9, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:04');
INSERT INTO `gen_table_column` VALUES (318, '20', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:04');
INSERT INTO `gen_table_column` VALUES (319, '20', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:04');
INSERT INTO `gen_table_column` VALUES (320, '20', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 12, 'admin', '2022-01-13 14:53:26', '', '2022-01-13 15:16:04');
INSERT INTO `gen_table_column` VALUES (321, '21', 'alert_log__id', '告警ID', 'bigint(20)', 'Long', 'alertLogId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-13 14:53:27', '', '2022-01-13 15:16:32');
INSERT INTO `gen_table_column` VALUES (323, '21', 'alert_level', '告警级别（1=提醒通知，2=轻微问题，3=严重警告，4=场景联动）', 'tinyint(11)', 'Long', 'alertLevel', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_alert_level', 3, 'admin', '2022-01-13 14:53:27', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (324, '21', 'status', '处理状态(0=不需要处理,1=未处理,2=已处理)', 'tinyint(11)', 'Long', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_process_status', 4, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (325, '21', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (326, '21', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (327, '21', 'device_id', '设备ID', 'bigint(20)', 'Long', 'deviceId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:33');
INSERT INTO `gen_table_column` VALUES (328, '21', 'device_name', '设备名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 8, 'admin', '2022-01-13 14:53:28', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (329, '21', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (330, '21', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (331, '21', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (332, '21', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:34');
INSERT INTO `gen_table_column` VALUES (333, '21', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2022-01-13 14:53:29', '', '2022-01-13 15:16:35');
INSERT INTO `gen_table_column` VALUES (334, '22', 'log_id', '设备日志ID', 'bigint(20)', 'Long', 'logId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-13 14:53:30', '', '2022-01-13 15:17:15');
INSERT INTO `gen_table_column` VALUES (335, '22', 'log_name', '日志名称', 'varchar(64)', 'String', 'logName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-01-13 14:53:30', '', '2022-01-13 15:17:15');
INSERT INTO `gen_table_column` VALUES (336, '22', 'log_type', '类型（1=属性上报，2=事件上报，3=调用功能，4=设备升级，5=设备上线，6=设备离线）', 'tinyint(1)', 'Integer', 'logType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'iot_device_log_type', 3, 'admin', '2022-01-13 14:53:30', '', '2022-01-13 15:17:15');
INSERT INTO `gen_table_column` VALUES (337, '22', 'log_value', '日志值', 'varchar(64)', 'String', 'logValue', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-01-13 14:53:31', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (338, '22', 'device_id', '设备ID', 'bigint(20)', 'Long', 'deviceId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-01-13 14:53:31', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (339, '22', 'device_name', '设备名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2022-01-13 14:53:31', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (340, '22', 'identity', '标识符', 'varchar(64)', 'String', 'identity', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2022-01-13 14:53:31', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (341, '22', 'datatype', '数据类型', 'varchar(32)', 'String', 'datatype', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'select', '', 8, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:16');
INSERT INTO `gen_table_column` VALUES (342, '22', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:17');
INSERT INTO `gen_table_column` VALUES (343, '22', 'is_monitor', '是否监测数据（1=是，0=否）', 'tinyint(1)', 'Integer', 'isMonitor', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:17');
INSERT INTO `gen_table_column` VALUES (344, '22', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 11, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:17');
INSERT INTO `gen_table_column` VALUES (345, '22', 'remark', '备注', 'varchar(200)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 12, 'admin', '2022-01-13 14:53:32', '', '2022-01-13 15:17:17');
INSERT INTO `gen_table_column` VALUES (346, '23', 'scene_id', '场景ID', 'bigint(20)', 'Long', 'sceneId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-13 14:53:33', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (347, '23', 'scene_name', '场景名称', 'varchar(64)', 'String', 'sceneName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-01-13 14:53:33', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (348, '23', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-01-13 14:53:33', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (349, '23', 'user_name', '用户名称', 'varchar(64)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (350, '23', 'triggers', '触发器', 'json', 'String', 'triggers', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 5, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:38');
INSERT INTO `gen_table_column` VALUES (351, '23', 'actions', '执行动作', 'json', 'String', 'actions', '0', '0', '1', '1', '1', '1', NULL, 'EQ', NULL, '', 6, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (352, '23', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (353, '23', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 8, 'admin', '2022-01-13 14:53:34', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (354, '23', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-01-13 14:53:35', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (355, '23', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-01-13 14:53:35', '', '2022-01-13 15:17:39');
INSERT INTO `gen_table_column` VALUES (356, '23', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 11, 'admin', '2022-01-13 14:53:35', '', '2022-01-13 15:17:40');
INSERT INTO `gen_table_column` VALUES (374, '25', 'job_id', '任务ID', 'bigint(20)', 'Long', 'jobId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (375, '25', 'job_name', '任务名称', 'varchar(64)', 'String', 'jobName', '1', '0', NULL, '1', NULL, NULL, NULL, 'LIKE', 'input', '', 2, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (376, '25', 'job_group', '任务组名', 'varchar(64)', 'String', 'jobGroup', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 3, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (378, '25', 'cron_expression', 'cron执行表达式', 'varchar(255)', 'String', 'cronExpression', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (379, '25', 'misfire_policy', '计划执行错误策略（1立即执行 2执行一次 3放弃执行）', 'varchar(20)', 'String', 'misfirePolicy', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (380, '25', 'concurrent', '是否并发执行（0允许 1禁止）', 'char(1)', 'String', 'concurrent', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (381, '25', 'status', '状态（0正常 1暂停）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 8, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (382, '25', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (383, '25', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (384, '25', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (385, '25', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (386, '25', 'remark', '备注信息', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (387, '25', 'device_id', '设备ID', 'bigint(11)', 'Long', 'deviceId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (388, '25', 'device_name', '设备名称', 'varchar(64)', 'String', 'deviceName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 15, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (389, '25', 'is_advance', '是否详细corn表达式（1=是，0=否）', 'tinyint(1)', 'Integer', 'isAdvance', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 16, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (390, '25', 'actions', '执行的动作集合', 'json', 'String', 'actions', '0', '0', NULL, '1', '1', '1', '1', 'EQ', NULL, '', 17, 'admin', '2022-01-17 16:18:25', '', NULL);
INSERT INTO `gen_table_column` VALUES (391, '26', 'device_id', '设备ID', 'bigint(20)', 'Long', 'deviceId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-01-24 00:29:24', '', NULL);
INSERT INTO `gen_table_column` VALUES (392, '26', 'group_id', '分组ID', 'bigint(20)', 'Long', 'groupId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 2, 'admin', '2022-01-24 00:29:24', '', NULL);
INSERT INTO `gen_table_column` VALUES (393, '25', 'is_repeat', '是否重复（0=否，1=是）', 'tinyint(11)', 'Long', 'isRepeat', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 17, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (394, '25', 'job_type', '定时类型（1=设备定时，2=设备告警，3=场景联动）', 'tinyint(11)', 'Long', 'jobType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 18, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (395, '25', 'product_id', '产品ID', 'bigint(20)', 'Long', 'productId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 19, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (396, '25', 'product_name', '产品名称', 'varchar(64)', 'String', 'productName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 20, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (397, '25', 'scene_id', '场景联动ID', 'bigint(20)', 'Long', 'sceneId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 21, '', '2022-01-24 00:30:59', '', NULL);
INSERT INTO `gen_table_column` VALUES (398, '25', 'alert_id', '告警ID', 'bigint(20)', 'Long', 'alertId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 22, '', '2022-01-24 00:31:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (399, '2', 'is_shadow', '是否启用设备影子(0=禁用，1=启用)', 'tinyint(1)', 'Integer', 'isShadow', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 13, '', '2022-01-27 15:39:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (400, '2', 'is_customer_location', '是否自定义位置（0=否，1=是）', 'tinyint(1)', 'Integer', 'isCustomerLocation', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, '', '2022-01-27 15:39:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (401, '2', 'things_model_value', '物模型值', 'json', 'String', 'thingsModelValue', '0', '0', NULL, '1', '1', '1', '1', 'EQ', NULL, '', 15, '', '2022-01-27 15:39:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (402, '2', 'img_url', '图片地址', 'varchar(255)', 'String', 'imgUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 21, '', '2022-01-27 15:39:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (403, '5', 'phonenumber', '手机号码', 'varchar(11)', 'String', 'phonenumber', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, '', '2022-01-27 15:39:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (404, '11', 'mqtt_account', 'mqtt账号', 'varchar(64)', 'String', 'mqttAccount', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, '', '2022-01-27 15:40:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (405, '11', 'mqtt_password', 'mqtt密码', 'varchar(64)', 'String', 'mqttPassword', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, '', '2022-01-27 15:40:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (406, '11', 'things_models_json', '物模型JSON（属性、功能、事件）', 'json', 'String', 'thingsModelsJson', '0', '0', NULL, '1', '1', '1', '1', 'EQ', NULL, '', 11, '', '2022-01-27 15:40:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (407, '11', 'img_url', '图片地址', 'varchar(255)', 'String', 'imgUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 15, '', '2022-01-27 15:40:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (408, '20', 'status', '告警状态（1-启动，2-停止）', 'tinyint(1)', 'Integer', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 8, '', '2022-01-27 15:40:08', '', NULL);
INSERT INTO `gen_table_column` VALUES (409, '21', 'alert_name', '告警名称', 'varchar(64)', 'String', 'alertName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, '', '2022-01-27 15:40:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (410, '21', 'user_id', '用户ID', 'bigint(20)', 'Long', 'userId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, '', '2022-01-27 15:40:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (411, '21', 'user_name', '用户昵称', 'varchar(30)', 'String', 'userName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 10, '', '2022-01-27 15:40:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (412, '21', 'type', '类型（1=告警，2=场景联动）', 'tinyint(11)', 'Long', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 16, '', '2022-01-27 15:40:10', '', NULL);
INSERT INTO `gen_table_column` VALUES (413, '27', 'client_id', '客户端ID', 'varchar(255)', 'String', 'clientId', '1', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 1, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (414, '27', 'resource_ids', '资源', 'varchar(255)', 'String', 'resourceIds', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 2, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (415, '27', 'client_secret', '客户端秘钥', 'varchar(255)', 'String', 'clientSecret', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 3, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (416, '27', 'scope', '权限范围', 'varchar(255)', 'String', 'scope', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'select', '', 4, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (417, '27', 'authorized_grant_types', '授权模式', 'varchar(255)', 'String', 'authorizedGrantTypes', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (418, '27', 'web_server_redirect_uri', '回调地址', 'varchar(255)', 'String', 'webServerRedirectUri', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 6, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (419, '27', 'authorities', '权限', 'varchar(255)', 'String', 'authorities', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (420, '27', 'access_token_validity', 'access token有效时间', 'int(11)', 'Long', 'accessTokenValidity', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 8, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (421, '27', 'refresh_token_validity', 'refresh token有效时间', 'int(11)', 'Long', 'refreshTokenValidity', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 9, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (422, '27', 'additional_information', '预留的字段', 'text', 'String', 'additionalInformation', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (423, '27', 'autoapprove', '自动授权', 'varchar(255)', 'String', 'autoapprove', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 11, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (424, '27', 'type', '平台', 'tinyint(1)', 'Integer', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'oauth_platform', 12, 'admin', '2022-02-07 20:24:16', '', '2022-02-07 20:38:11');
INSERT INTO `gen_table_column` VALUES (476, '33', 'news_id', '新闻ID', 'bigint(20)', 'Long', 'newsId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-04-09 19:15:19', '', '2022-04-09 19:20:56');
INSERT INTO `gen_table_column` VALUES (477, '33', 'title', '标题', 'varchar(64)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:56');
INSERT INTO `gen_table_column` VALUES (478, '33', 'content', '内容', 'text', 'String', 'content', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'editor', '', 3, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:56');
INSERT INTO `gen_table_column` VALUES (479, '33', 'img_url', '图片', 'varchar(128)', 'String', 'imgUrl', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'imageUpload', '', 4, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:56');
INSERT INTO `gen_table_column` VALUES (480, '33', 'is_top', '置顶', 'tinyint(1)', 'Integer', 'isTop', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_yes_no', 5, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (481, '33', 'is_banner', '广告', 'tinyint(1)', 'Integer', 'isBanner', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_yes_no', 6, 'admin', '2022-04-09 19:15:20', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (482, '33', 'category_id', '分类ID', 'bigint(20)', 'Long', 'categoryId', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (483, '33', 'catgory_name', '分类名称', 'varchar(32)', 'String', 'catgoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 8, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (484, '33', 'status', '发布', 'tinyint(1)', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_yes_no', 9, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:57');
INSERT INTO `gen_table_column` VALUES (485, '33', 'author', '作者', 'varchar(50)', 'String', 'author', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 10, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (486, '33', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2022-04-09 19:15:21', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (487, '33', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (488, '33', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 13, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (489, '33', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:58');
INSERT INTO `gen_table_column` VALUES (490, '33', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 15, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:59');
INSERT INTO `gen_table_column` VALUES (491, '33', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 16, 'admin', '2022-04-09 19:15:22', '', '2022-04-09 19:20:59');
INSERT INTO `gen_table_column` VALUES (492, '34', 'category_id', '分类ID', 'bigint(20)', 'Long', 'categoryId', '1', '1', NULL, '1', NULL, '1', NULL, 'EQ', 'input', '', 1, 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45');
INSERT INTO `gen_table_column` VALUES (493, '34', 'category_name', '分类名字', 'varchar(64)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45');
INSERT INTO `gen_table_column` VALUES (494, '34', 'order_num', '显示顺序', 'int(2)', 'Integer', 'orderNum', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 3, 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45');
INSERT INTO `gen_table_column` VALUES (495, '34', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 4, 'admin', '2022-04-09 19:15:23', '', '2022-04-09 19:23:45');
INSERT INTO `gen_table_column` VALUES (496, '34', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 5, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');
INSERT INTO `gen_table_column` VALUES (497, '34', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'datetime', '', 6, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');
INSERT INTO `gen_table_column` VALUES (498, '34', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');
INSERT INTO `gen_table_column` VALUES (499, '34', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');
INSERT INTO `gen_table_column` VALUES (500, '34', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 9, 'admin', '2022-04-09 19:15:24', '', '2022-04-09 19:23:46');

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
  `triggers` json NOT NULL COMMENT '触发器',
  `actions` json NOT NULL COMMENT '执行动作',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '告警状态（1-启动，2-停止）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`alert_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备告警' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_alert
-- ----------------------------

-- ----------------------------
-- Table structure for iot_alert_log
-- ----------------------------
DROP TABLE IF EXISTS `iot_alert_log`;
CREATE TABLE `iot_alert_log`  (
  `alert_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '告警ID',
  `alert_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警名称',
  `alert_level` tinyint(11) NOT NULL COMMENT '告警级别（1=提醒通知，2=轻微问题，3=严重警告）',
  `status` tinyint(11) NOT NULL COMMENT '处理状态(1=不需要处理,2=未处理,3=已处理)',
  `product_id` bigint(20) NULL DEFAULT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `device_id` bigint(20) NULL DEFAULT NULL COMMENT '设备ID',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `type` tinyint(11) NULL DEFAULT NULL COMMENT '类型（1=告警，2=场景联动）',
  PRIMARY KEY (`alert_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备告警日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_alert_log
-- ----------------------------

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
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品分类' ROW_FORMAT = Dynamic;

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
INSERT INTO `iot_category` VALUES (13, '医疗器械(Admin)', 1, 'admin', 1, NULL, 8, '0', '', '2022-06-09 17:19:33', '', '2022-06-09 23:05:41', '管理员测试数据');
INSERT INTO `iot_category` VALUES (14, '医疗器械(T1)', 2, 'wumei-t1', 0, NULL, 9, '0', '', '2022-06-10 00:38:11', '', NULL, '租户T1测试数据');
INSERT INTO `iot_category` VALUES (15, '医疗器械(T2)', 3, 'wumei-t2', 0, NULL, 9, '0', '', '2022-06-11 00:24:01', '', NULL, '租户T2测试数据');

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
  PRIMARY KEY (`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device
-- ----------------------------
INSERT INTO `iot_device` VALUES (24, '体温检测设备(admin)', 13, '体温检测仪(管理员)', 1, 'admin', 1, 'admin', 'D1FL8B1Z37UM', 1.00, 3, 0, 1, 1, '[{\"id\": \"temp_admin\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"switch\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"message\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"report_monitor\", \"value\": \"\", \"shadow\": \"\"}]', '中国', '127.0.0.1', 103.411381, 27.387742, NULL, NULL, NULL, '0', '', '2022-06-09 22:48:52', '', '2022-06-09 23:10:47', NULL);
INSERT INTO `iot_device` VALUES (25, '体温检测设备(T1)', 14, '体温检测仪(T1)', 2, 'wumei-t1', 2, 'wumei-t1', 'D2E498HG82P7', 1.00, 1, 0, 0, 1, '[{\"id\": \"temperature\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"humidity\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"temp_t1\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"switch\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"gear\", \"value\": \"\", \"shadow\": \"\"}]', '中国', '127.0.0.1', 112.496093, 35.498394, NULL, NULL, '/profile/iot/2/2022-0610-003915.jpg', '0', '', '2022-06-10 00:49:23', '', '2022-06-12 00:52:20', '租户T1测试数据');
INSERT INTO `iot_device` VALUES (26, '体温检测设备(U1)', 14, '体温检测仪(T1)', 4, 'wumei-u1', 2, 'wumei-t1', 'D41FTPHZYKOX', 1.00, 1, 0, 1, 1, '[{\"id\": \"temperature\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"humidity\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"temp_t1\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"switch\", \"value\": \"\", \"shadow\": \"1\"}, {\"id\": \"gear\", \"value\": \"\", \"shadow\": \"\"}]', '中国', '127.0.0.1', 110.657642, 27.293884, NULL, NULL, '/profile/iot/2/2022-0610-003915.jpg', '0', '', '2022-06-10 01:28:49', '', '2022-06-10 14:05:30', '用户U1测试数据');
INSERT INTO `iot_device` VALUES (27, '体温检测设备(T2)', 15, '温度监测仪(T2)', 3, 'wumei-t2', 3, 'wumei-t2', 'D302GN39PLN5', 1.00, 1, 0, 0, 1, '[{\"id\": \"temperature\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"humidity\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"co2\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"brightness\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"temp_admin\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"temp_t2\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"switch\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"gear\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"light_color\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"message\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"report_monitor\", \"value\": \"\", \"shadow\": \"\"}]', '中国', '127.0.0.1', 109.416191, 37.890611, NULL, NULL, NULL, '0', '', '2022-06-11 01:18:37', '', NULL, '租户T2测试数据');
INSERT INTO `iot_device` VALUES (28, '体温检测仪(U2)', 15, '温度监测仪(T2)', 5, 'wumei-u2', 3, 'wumei-t2', 'D5IN2B08QN01', 1.00, 1, 0, 1, 1, '[{\"id\": \"temperature\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"humidity\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"co2\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"brightness\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"temp_admin\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"temp_t2\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"switch\", \"value\": \"\", \"shadow\": \"1\"}, {\"id\": \"gear\", \"value\": \"\", \"shadow\": \"3\"}, {\"id\": \"light_color\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"message\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"report_monitor\", \"value\": \"\", \"shadow\": \"\"}]', '中国', '127.0.0.1', 113.520027, 34.907662, NULL, NULL, NULL, '0', '', '2022-06-11 02:26:01', '', NULL, '用户U2测试数据');
INSERT INTO `iot_device` VALUES (29, '智能开关(T1)', 16, '智能开关(T1)', 2, 'wumei-t1', 2, 'wumei-t1', 'D2P4IU4E50HJ', 1.00, 1, 0, 1, 3, '[{\"id\": \"light_color\", \"value\": \"\", \"shadow\": \"11\"}, {\"id\": \"switch\", \"value\": \"\", \"shadow\": \"1\"}]', '中国', '127.0.0.1', 116.388171, 39.870869, NULL, NULL, NULL, '0', '', '2022-06-12 00:44:15', '', NULL, NULL);
INSERT INTO `iot_device` VALUES (30, '智能开关(U2)', 16, '智能开关(T1)', 5, 'wumei-u2', 2, 'wumei-t1', 'D5BE0D756D24', 1.00, 1, 0, 1, 1, '[{\"id\": \"light_color\", \"value\": \"\", \"shadow\": \"\"}, {\"id\": \"switch\", \"value\": \"\", \"shadow\": \"0\"}]', '中国', '127.0.0.1', 103.792440, 32.176495, NULL, NULL, NULL, '0', '', '2022-06-12 01:06:06', '', NULL, NULL);
INSERT INTO `iot_device` VALUES (31, '智能开关(U1)', 16, '智能开关(T1)', 4, 'wumei-u1', 2, 'wumei-t1', 'D43MU367RLU7', 1.10, 1, 0, 1, 1, '[{\"id\": \"light_color\", \"value\": \"\", \"shadow\": \"1\"}, {\"id\": \"switch\", \"value\": \"\", \"shadow\": \"0\"}]', '中国', '127.0.0.1', 105.270904, 27.100544, NULL, NULL, NULL, '0', '', '2022-06-12 01:36:33', '', '2022-06-12 01:37:31', NULL);

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
INSERT INTO `iot_device_group` VALUES (24, 16);
INSERT INTO `iot_device_group` VALUES (25, 17);
INSERT INTO `iot_device_group` VALUES (26, 18);
INSERT INTO `iot_device_group` VALUES (28, 18);
INSERT INTO `iot_device_group` VALUES (30, 22);
INSERT INTO `iot_device_group` VALUES (31, 22);

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
  `device_id` bigint(11) NOT NULL COMMENT '设备ID',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编号',
  `device_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `is_advance` tinyint(1) NULL DEFAULT NULL COMMENT '是否详细corn表达式（1=是，0=否）',
  `actions` json NULL COMMENT '执行的动作集合',
  `job_type` tinyint(1) NULL DEFAULT NULL COMMENT '任务类型（1=设备定时，2=设备告警，3=场景联动）',
  `product_id` bigint(20) NOT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `scene_id` bigint(20) NULL DEFAULT NULL COMMENT '场景联动ID',
  `alert_id` bigint(20) NULL DEFAULT NULL COMMENT '告警ID',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备定时' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_job
-- ----------------------------
INSERT INTO `iot_device_job` VALUES (6, '上报体温(admin)', 'DEFAULT', '0 50 22 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'admin', '2022-06-09 22:51:14', 'admin', '2022-06-09 23:11:00', '', 24, 'D1FL8B1Z37UM', '门口监测仪(admin)', 0, '[{\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 24, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"门口监测仪(admin)\"}]', 1, 13, '智能体温检测仪(管理员)', NULL, NULL);
INSERT INTO `iot_device_job` VALUES (7, '定时打开设备(T1)', 'DEFAULT', '0 20 01 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'wumei-t1', '2022-06-10 01:21:25', 'wumei-t1', '2022-06-10 01:21:42', '', 25, 'D2E498HG82P7', '室内检测仪(T1)', 0, '[{\"id\": \"switch\", \"name\": \"设备开关\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 25, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"室内检测仪(T1)\"}, {\"id\": \"gear\", \"name\": \"运行档位\", \"type\": 2, \"value\": \"0\", \"source\": 2, \"deviceId\": 25, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"室内检测仪(T1)\"}]', 1, 14, '体温检测仪(T1)', NULL, NULL);
INSERT INTO `iot_device_job` VALUES (8, '定时打开设备(U1)', 'DEFAULT', '0 29 01 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'wumei-u1', '2022-06-10 01:29:24', '', NULL, '', 26, 'D41FTPHZYKOX', '体温检测仪(U1)', 0, '[{\"id\": \"switch\", \"name\": \"设备开关\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 26, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"体温检测仪(U1)\"}]', 1, 14, '体温检测仪(T1)', NULL, NULL);
INSERT INTO `iot_device_job` VALUES (9, '定时上报数据(U2)', 'DEFAULT', '0 27 02 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'wumei-u2', '2022-06-11 02:27:52', 'wumei-u2', '2022-06-11 02:28:12', '', 28, 'D5IN2B08QN01', '体温检测仪(U2)', 0, '[{\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 28, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"体温检测仪(U2)\"}]', 1, 15, '温度监测仪(T2)', NULL, NULL);
INSERT INTO `iot_device_job` VALUES (10, '定时调整档位(U2)', 'DEFAULT', '0 30 02 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'wumei-t2', '2022-06-11 02:30:46', '', NULL, '', 27, 'D302GN39PLN5', '体温检测设备(T2)', 0, '[{\"id\": \"gear\", \"name\": \"运行档位\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 27, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"体温检测设备(T2)\"}, {\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 27, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"体温检测设备(T2)\"}]', 1, 15, '温度监测仪(T2)', NULL, NULL);
INSERT INTO `iot_device_job` VALUES (11, '智能开关打开(T1)', 'DEFAULT', '0 00 19 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'wumei-t1', '2022-06-12 00:44:59', '', NULL, '', 29, 'D2P4IU4E50HJ', '智能开关(T1)', 0, '[{\"id\": \"switch\", \"name\": \"设备开关\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 29, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"智能开关(T1)\"}]', 1, 16, '智能开关(T1)', NULL, NULL);
INSERT INTO `iot_device_job` VALUES (12, '定时打开开关', 'DEFAULT', '0 36 19 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'wumei-u1', '2022-06-12 01:37:04', '', NULL, '', 31, 'D43MU367RLU7', '智能开关', 0, '[{\"id\": \"switch\", \"name\": \"设备开关\", \"type\": 2, \"value\": \"1\", \"source\": 2, \"deviceId\": 31, \"alertName\": \"\", \"alertLevel\": 1, \"deviceName\": \"智能开关\"}]', 1, 16, '智能开关(T1)', NULL, NULL);

-- ----------------------------
-- Table structure for iot_device_log
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_log`;
CREATE TABLE `iot_device_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备日志ID',
  `identity` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符',
  `log_type` tinyint(1) NOT NULL COMMENT '类型（1=属性上报，2=调用功能，3=事件上报，4=设备升级，5=设备上线，6=设备离线）',
  `log_value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日志值',
  `device_id` bigint(20) NOT NULL COMMENT '设备ID',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编号',
  `is_monitor` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否监测数据（1=是，0=否）',
  `mode` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '模式(1=影子模式，2=在线模式，3=其他)',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2909 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_log
-- ----------------------------
INSERT INTO `iot_device_log` VALUES (2869, 'switch', 2, '1', 25, '室内检测仪(T1)', 'D2E498HG82P7', 0, 1, 2, 'wumei-t1', 2, 'wumei-t1', '', '2022-06-10 21:26:05', NULL);
INSERT INTO `iot_device_log` VALUES (2870, 'switch', 2, '0', 25, '体温检测设备(T1)', 'D2E498HG82P7', 0, 2, 2, 'wumei-t1', 2, 'wumei-t1', '', '2022-06-11 15:04:22', NULL);
INSERT INTO `iot_device_log` VALUES (2871, 'switch', 2, '1', 25, '体温检测设备(T1)', 'D2E498HG82P7', 0, 1, 2, 'wumei-t1', 2, 'wumei-t1', '', '2022-06-11 15:04:26', NULL);
INSERT INTO `iot_device_log` VALUES (2872, 'switch', 2, '0', 25, '体温检测设备(T1)', 'D2E498HG82P7', 0, 2, 2, 'wumei-t1', 2, 'wumei-t1', '', '2022-06-11 15:05:47', NULL);
INSERT INTO `iot_device_log` VALUES (2873, 'gear', 2, '1', 25, '体温检测设备(T1)', 'D2E498HG82P7', 0, 1, 2, 'wumei-t1', 2, 'wumei-t1', '', '2022-06-11 15:06:14', NULL);
INSERT INTO `iot_device_log` VALUES (2874, 'switch', 2, '1', 28, '体温检测仪(U2)', 'D5IN2B08QN01', 0, 1, 5, 'wumei-u2', 3, 'wumei-t2', '', '2022-06-12 00:15:48', NULL);
INSERT INTO `iot_device_log` VALUES (2875, 'light_color', 2, '11', 29, '智能开关(T1)', 'D2P4IU4E50HJ', 0, 1, 2, 'wumei-t1', 2, 'wumei-t1', '', '2022-06-12 00:52:48', NULL);
INSERT INTO `iot_device_log` VALUES (2876, 'switch', 2, '1', 29, '智能开关(T1)', 'D2P4IU4E50HJ', 0, 1, 2, 'wumei-t1', 2, 'wumei-t1', '', '2022-06-12 00:53:06', NULL);
INSERT INTO `iot_device_log` VALUES (2877, 'switch', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-12 02:06:58', NULL);
INSERT INTO `iot_device_log` VALUES (2878, 'switch', 2, '0', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-12 02:06:59', NULL);
INSERT INTO `iot_device_log` VALUES (2879, 'light_color', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-12 02:07:01', NULL);
INSERT INTO `iot_device_log` VALUES (2880, 'light_color', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-12 02:07:03', NULL);
INSERT INTO `iot_device_log` VALUES (2881, 'switch', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-12 02:07:04', NULL);
INSERT INTO `iot_device_log` VALUES (2882, 'switch', 2, '1', 30, '智能开关(U2)', 'D5BE0D756D24', 0, 1, 5, 'wumei-u2', 2, 'wumei-t1', '', '2022-06-12 02:07:27', NULL);
INSERT INTO `iot_device_log` VALUES (2883, 'switch', 2, '0', 30, '智能开关(U2)', 'D5BE0D756D24', 0, 1, 5, 'wumei-u2', 2, 'wumei-t1', '', '2022-06-12 02:07:30', NULL);
INSERT INTO `iot_device_log` VALUES (2884, 'switch', 2, '1', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-12 02:07:35', NULL);
INSERT INTO `iot_device_log` VALUES (2885, 'switch', 2, '1', 30, '智能开关(U2)', 'D5BE0D756D24', 0, 1, 5, 'wumei-u2', 2, 'wumei-t1', '', '2022-06-12 02:08:23', NULL);
INSERT INTO `iot_device_log` VALUES (2886, 'switch', 2, '0', 30, '智能开关(U2)', 'D5BE0D756D24', 0, 1, 5, 'wumei-u2', 2, 'wumei-t1', '', '2022-06-12 02:08:24', NULL);
INSERT INTO `iot_device_log` VALUES (2887, 'gear', 2, '1', 28, '体温检测仪(U2)', 'D5IN2B08QN01', 0, 1, 5, 'wumei-u2', 3, 'wumei-t2', '', '2022-06-12 02:08:31', NULL);
INSERT INTO `iot_device_log` VALUES (2888, 'gear', 2, '3', 28, '体温检测仪(U2)', 'D5IN2B08QN01', 0, 1, 5, 'wumei-u2', 3, 'wumei-t2', '', '2022-06-12 02:08:32', NULL);
INSERT INTO `iot_device_log` VALUES (2889, 'switch', 2, '0', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-12 02:09:13', NULL);
INSERT INTO `iot_device_log` VALUES (2890, 'switch', 2, '1', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-12 02:09:14', NULL);
INSERT INTO `iot_device_log` VALUES (2891, 'switch', 2, '0', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:00:04', NULL);
INSERT INTO `iot_device_log` VALUES (2892, 'switch', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:00:05', NULL);
INSERT INTO `iot_device_log` VALUES (2893, 'switch', 2, '0', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:00:07', NULL);
INSERT INTO `iot_device_log` VALUES (2894, 'light_color', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:00:08', NULL);
INSERT INTO `iot_device_log` VALUES (2895, 'switch', 2, '0', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:03:12', NULL);
INSERT INTO `iot_device_log` VALUES (2896, 'switch', 2, '1', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:03:14', NULL);
INSERT INTO `iot_device_log` VALUES (2897, 'switch', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:29:46', NULL);
INSERT INTO `iot_device_log` VALUES (2898, 'switch', 2, '0', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:29:50', NULL);
INSERT INTO `iot_device_log` VALUES (2899, 'light_color', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:29:52', NULL);
INSERT INTO `iot_device_log` VALUES (2900, 'switch', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:30:10', NULL);
INSERT INTO `iot_device_log` VALUES (2901, 'switch', 2, '0', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:30:12', NULL);
INSERT INTO `iot_device_log` VALUES (2902, 'light_color', 2, '1', 31, '智能开关(U1)', 'D43MU367RLU7', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:30:13', NULL);
INSERT INTO `iot_device_log` VALUES (2903, 'switch', 2, '0', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:35:43', NULL);
INSERT INTO `iot_device_log` VALUES (2904, 'switch', 2, '1', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:35:44', NULL);
INSERT INTO `iot_device_log` VALUES (2905, 'switch', 2, '0', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:36:22', NULL);
INSERT INTO `iot_device_log` VALUES (2906, 'switch', 2, '1', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:36:23', NULL);
INSERT INTO `iot_device_log` VALUES (2907, 'switch', 2, '0', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:36:29', NULL);
INSERT INTO `iot_device_log` VALUES (2908, 'switch', 2, '1', 26, '体温检测设备(U1)', 'D41FTPHZYKOX', 0, 1, 4, 'wumei-u1', 2, 'wumei-t1', '', '2022-06-14 16:36:30', NULL);

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
  PRIMARY KEY (`device_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_user
-- ----------------------------
INSERT INTO `iot_device_user` VALUES (24, 1, 1, 'admin', '门口监测仪', '15888888888', 'admin', 1, '0', '', NULL, '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (25, 2, 2, 'wumei-t1', '室内检测仪(T1)', '15288888880', 'wumei-t1', 1, '0', '', NULL, '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (26, 4, 2, 'wumei-t1', '体温检测仪(U1)', '13988888880', 'wumei-u1', 1, '0', '', NULL, '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (26, 5, 2, 'wumei-t1', '体温检测仪(U1)', '15888888883', 'wumei-u2', 0, '0', '', '2022-06-11 01:03:21', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (27, 3, 3, 'wumei-t2', '体温检测设备(T2)', '15888888881', 'wumei-t2', 1, '0', '', NULL, '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (28, 4, 5, 'wumei-u2', '体温检测仪(U2)', '15888888882', 'wumei-u1', 0, '0', '', '2022-06-12 01:17:30', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (28, 5, 3, 'wumei-t2', '体温检测仪(U2)', '15888888883', 'wumei-u2', 1, '0', '', NULL, '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (29, 2, 2, 'wumei-t1', '智能开关(T1)', '15888888880', 'wumei-t1', 1, '0', '', NULL, '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (30, 4, 5, 'wumei-u2', '智能开关(U2)', '15888888882', 'wumei-u1', 0, '0', '', '2022-06-12 01:17:11', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (30, 5, 2, 'wumei-t1', '智能开关(U2)', '15888888883', 'wumei-u2', 1, '0', '', NULL, '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (31, 4, 2, 'wumei-t1', '智能开关', '15888888882', 'wumei-u1', 1, '0', '', NULL, '', NULL, NULL);

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
  PRIMARY KEY (`firmware_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品固件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_firmware
-- ----------------------------
INSERT INTO `iot_firmware` VALUES (10, '体温检测仪出厂固件(admin)', 13, '体温检测仪(admin)', 1, 'admin', 1, 0, 1.00, '/profile/iot/1/2022-0609-172438.bin', '0', '', '2022-06-09 17:24:41', '', '2022-06-09 23:07:48', NULL);
INSERT INTO `iot_firmware` VALUES (11, '体温检测仪出厂固件(T1)', 14, '体温检测仪(T1)', 2, 'wumei-t1', 0, 0, 1.10, '/profile/iot/2/2022-0610-004259.bin', '0', '', '2022-06-10 00:43:17', '', '2022-06-10 00:43:38', '租户T1测试数据');
INSERT INTO `iot_firmware` VALUES (12, '温度检测仪出厂固件(T2)', 15, '温度监测仪(T2)', 3, 'wumei-t2', 0, 0, 1.10, '/profile/iot/3/2022-0611-003131.bin', '0', '', '2022-06-11 00:31:44', '', '2022-06-11 00:31:50', '租户T2测试数据');
INSERT INTO `iot_firmware` VALUES (13, '智能开关(T1)', 16, '智能开关(T1)', 2, 'wumei-t1', 0, 0, 1.00, '/profile/iot/2/2022-0612-004129.bin', '0', '', '2022-06-12 00:41:32', '', NULL, NULL);

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
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_group
-- ----------------------------
INSERT INTO `iot_group` VALUES (2, '卧室', 2, 1, 'admin', '0', '', '2021-12-29 13:12:42', '', '2021-12-29 13:13:40', '卧室设备');
INSERT INTO `iot_group` VALUES (3, '厨房', 3, 1, 'admin', '0', '', '2021-12-29 13:12:59', '', '2021-12-29 13:13:48', '厨房设备');
INSERT INTO `iot_group` VALUES (4, '书房', 4, 1, 'admin', '0', '', '2021-12-29 13:13:10', '', '2021-12-29 13:13:54', '书房设备');
INSERT INTO `iot_group` VALUES (5, '卫生间', 5, 1, 'admin', '0', '', '2021-12-29 13:13:18', '', '2021-12-29 13:14:03', '卫生间设备');
INSERT INTO `iot_group` VALUES (6, '走道', 6, 1, 'admin', '0', '', '2021-12-29 13:13:26', '', '2021-12-29 13:14:11', '走道设备');
INSERT INTO `iot_group` VALUES (16, '医疗(admin)', 10, 1, 'admin', '0', '', '2022-06-09 22:47:07', '', '2022-06-09 23:10:33', '管理员分组，用于测试');
INSERT INTO `iot_group` VALUES (17, '医疗(T1)', 1, 2, 'wumei-t1', '0', '', '2022-06-10 00:46:48', '', NULL, '租户T1测试数据');
INSERT INTO `iot_group` VALUES (18, '医疗(U1)', 1, 4, 'wumei-u1', '0', '', '2022-06-10 01:24:24', '', NULL, '用户U1测试数据');
INSERT INTO `iot_group` VALUES (19, '医疗(T2)', 1, 3, 'wumei-t2', '0', '', '2022-06-11 01:16:08', '', NULL, '租户T2测试数据');
INSERT INTO `iot_group` VALUES (20, '医疗(U2)', 1, 5, 'wumei-u2', '0', '', '2022-06-11 01:29:20', '', NULL, '用户U2测试数据');
INSERT INTO `iot_group` VALUES (21, '电工照明', 2, 5, 'wumei-u2', '0', '', '2022-06-12 00:56:57', '', '2022-06-12 00:57:12', '用户U2测试数据');
INSERT INTO `iot_group` VALUES (22, '电工照明(U1)', 2, 4, 'wumei-u1', '0', '', '2022-06-12 01:34:59', '', NULL, NULL);

-- ----------------------------
-- Table structure for iot_product
-- ----------------------------
DROP TABLE IF EXISTS `iot_product`;
CREATE TABLE `iot_product`  (
  `product_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
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
  `device_type` tinyint(1) NULL DEFAULT 1 COMMENT '设备类型（1-直连设备、2-网关子设备、3-网关设备）',
  `network_method` tinyint(1) NULL DEFAULT 1 COMMENT '联网方式（1=wifi、2=蜂窝(2G/3G/4G/5G)、3=以太网、4=其他）',
  `vertificate_method` tinyint(1) NULL DEFAULT 1 COMMENT '认证方式（1-简单认证、2-加密认证、3-简单+加密）',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_product
-- ----------------------------
INSERT INTO `iot_product` VALUES (13, '体温检测仪(admin)', 13, '医疗器械(admin)', 1, 'admin', 1, 1, 'wumei-smart', 'PWZXWP8LELV0336A', 'KM5Y70E0T1234QT8', 2, '{\"events\": [{\"id\": \"high_temp\", \"name\": \"体温过高\", \"datatype\": {\"max\": 50, \"min\": 20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}}, {\"id\": \"exception\", \"name\": \"设备发生异常\", \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}], \"functions\": [{\"id\": \"switch\", \"name\": \"设备开关\", \"isTop\": 1, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}}, {\"id\": \"message\", \"name\": \"屏显消息\", \"isTop\": 0, \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}, {\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}}], \"properties\": [{\"id\": \"temp_admin\", \"name\": \"体温(管理员)\", \"isTop\": 1, \"datatype\": {\"max\": 46.5, \"min\": 14.2, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 1}]}', 1, 2, 3, NULL, '0', '', '2022-06-09 17:20:48', '', NULL, '管理员测试数据');
INSERT INTO `iot_product` VALUES (14, '体温检测仪(T1)', 14, '医疗器械(T1)', 2, 'wumei-t1', 0, 1, 'wumei-smart', 'P3B1L9561M46MB5O', 'K374DVRC5PVT9823', 2, '{\"events\": [{\"id\": \"height_temp\", \"name\": \"体温过高(T1)\", \"datatype\": {\"max\": 50, \"min\": 10, \"step\": 0.1, \"type\": \"integer\", \"unit\": \"℃\"}}, {\"id\": \"exception\", \"name\": \"设备发生异常\", \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}], \"functions\": [{\"id\": \"switch\", \"name\": \"设备开关\", \"isTop\": 1, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}}, {\"id\": \"gear\", \"name\": \"运行档位\", \"isTop\": 1, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}}], \"properties\": [{\"id\": \"temperature\", \"name\": \"空气温度\", \"isTop\": 1, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 1}, {\"id\": \"humidity\", \"name\": \"空气湿度\", \"isTop\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isMonitor\": 1}, {\"id\": \"temp_t1\", \"name\": \"体温(T1)\", \"isTop\": 1, \"datatype\": {\"max\": 46.5, \"min\": 14.2, \"step\": 0.1, \"type\": \"integer\", \"unit\": \"℃\"}, \"isMonitor\": 1}]}', 1, 1, 3, '/profile/iot/2/2022-0610-003915.jpg', '0', '', '2022-06-10 00:39:18', '', NULL, '租户T1测试数据');
INSERT INTO `iot_product` VALUES (15, '温度监测仪(T2)', 15, '医疗器械(T2)', 3, 'wumei-t2', 0, 0, 'wumei-smart', 'PA7Z926LX4LU93YE', 'K6LDJ88701BXWC8Z', 2, '{\"events\": [{\"id\": \"exception\", \"name\": \"设备发生异常\", \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}], \"functions\": [{\"id\": \"switch\", \"name\": \"设备开关\", \"isTop\": 1, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}}, {\"id\": \"gear\", \"name\": \"运行档位\", \"isTop\": 1, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}}, {\"id\": \"light_color\", \"name\": \"灯光颜色\", \"isTop\": 0, \"datatype\": {\"type\": \"array\", \"arrayType\": \"int\"}}, {\"id\": \"message\", \"name\": \"屏显消息\", \"isTop\": 0, \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}, {\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}}], \"properties\": [{\"id\": \"temperature\", \"name\": \"空气温度\", \"isTop\": 1, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 1}, {\"id\": \"humidity\", \"name\": \"空气湿度\", \"isTop\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isMonitor\": 1}, {\"id\": \"co2\", \"name\": \"二氧化碳\", \"isTop\": 0, \"datatype\": {\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}, \"isMonitor\": 1}, {\"id\": \"brightness\", \"name\": \"室内亮度\", \"isTop\": 0, \"datatype\": {\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}, \"isMonitor\": 1}, {\"id\": \"temp_admin\", \"name\": \"体温(admin)\", \"isTop\": 1, \"datatype\": {\"max\": 46.5, \"min\": 14.2, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 1}, {\"id\": \"temp_t2\", \"name\": \"体温(T2)\", \"isTop\": 1, \"datatype\": {\"max\": 40, \"min\": 20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 1}]}', 1, 3, 1, NULL, '0', '', '2022-06-11 00:30:56', '', NULL, '租户T2测试数据');
INSERT INTO `iot_product` VALUES (16, '智能开关(T1)', 1, '电工照明', 2, 'wumei-t1', 0, 0, 'wumei-smart', 'PT8314A02U3B41R9', 'K5J6CVL77S5AOA8X', 2, '{\"events\": [{\"id\": \"exception\", \"name\": \"设备发生异常\", \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}], \"functions\": [{\"id\": \"light_color\", \"name\": \"灯光颜色\", \"isTop\": 1, \"datatype\": {\"type\": \"array\", \"arrayType\": \"int\"}}, {\"id\": \"switch\", \"name\": \"设备开关\", \"isTop\": 1, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}}], \"properties\": []}', 1, 1, 1, NULL, '0', '', '2022-06-12 00:40:53', '', NULL, NULL);
INSERT INTO `iot_product` VALUES (17, '调色七彩灯(T1)', 1, '电工照明', 2, 'wumei-t1', 0, 1, 'wumei-smart', 'PJ32XIETI24YM924', 'K3BIV4Q56A053E6G', 1, '{\"events\": [{\"id\": \"height_temperature\", \"name\": \"环境温度过高\", \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}}, {\"id\": \"exception\", \"name\": \"设备发生异常\", \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}}], \"functions\": [{\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"isTop\": 0, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}}, {\"id\": \"switch\", \"name\": \"设备开关\", \"isTop\": 1, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}}, {\"id\": \"light_color\", \"name\": \"灯光颜色\", \"isTop\": 0, \"datatype\": {\"type\": \"array\", \"arrayType\": \"int\"}}], \"properties\": [{\"id\": \"temperature\", \"name\": \"空气温度\", \"isTop\": 1, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 1}, {\"id\": \"humidity\", \"name\": \"空气湿度\", \"isTop\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isMonitor\": 1}, {\"id\": \"brightness\", \"name\": \"室内亮度\", \"isTop\": 0, \"datatype\": {\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}, \"isMonitor\": 1}]}', 1, 1, 3, '/profile/iot/2/2022-0612-115417.jpg', '0', '', '2022-06-12 11:54:19', '', '2022-06-12 11:55:36', NULL);

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
  PRIMARY KEY (`authorize_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 186 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品授权码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_product_authorize
-- ----------------------------
INSERT INTO `iot_product_authorize` VALUES (166, 'ADBFCC8934864B26B55658C66F562AC5', 13, 24, 'D1FL8B1Z37UM', 1, 'admin', 2, '0', 'admin', '2022-06-09 17:24:53', '', '2022-06-10 13:22:21', NULL);
INSERT INTO `iot_product_authorize` VALUES (167, '6220E010EC1345B4A2FFDA27949EC037', 13, NULL, NULL, NULL, NULL, 1, '0', 'admin', '2022-06-09 17:24:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (168, '20574B2DC1AA4609B954218269FE3F17', 13, NULL, NULL, NULL, NULL, 1, '0', 'admin', '2022-06-09 17:24:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (169, '1F6F034BAF3C4DEE9E0E3BA6546E1B2F', 13, NULL, NULL, NULL, NULL, 1, '0', 'admin', '2022-06-09 17:24:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (170, 'E6C46F18A4EF4460BAAFE6154B206DDF', 13, NULL, NULL, NULL, NULL, 1, '0', 'admin', '2022-06-09 17:24:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (171, 'EBAE5BEA91F449C6BE3C703E738D2297', 13, NULL, NULL, NULL, NULL, 1, '0', 'admin', '2022-06-09 17:24:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (172, 'F2827AB73689415FACDD3E0D173513E8', 13, NULL, NULL, NULL, NULL, 1, '0', 'admin', '2022-06-09 17:24:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (173, '4D9841681C7749C883914447A3FB8DA2', 13, NULL, NULL, NULL, NULL, 1, '0', 'admin', '2022-06-09 17:24:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (174, '34B9578B27BB4675AE41621E47BA9BA0', 13, NULL, NULL, NULL, NULL, 1, '0', 'admin', '2022-06-09 17:24:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (175, 'FE41333D223A469092CF7DEAD2BEE195', 13, NULL, NULL, NULL, NULL, 1, '0', 'admin', '2022-06-09 17:24:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (176, '3114555F5C9740E2A5234D365FA52E87', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (177, '905781AA3E0B4794B33F8E3571461D2B', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (178, '42F5E638837448DE81F1F9A6A103DCC0', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (179, '79D02C3D7C6F43ABA240A513B128394F', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (180, '56D900473253411EABA5C62BAF578F19', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (181, '1DFE4F751EEF4CEE957582CED19ACAAF', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (182, 'C5F35FF2D3B040F5840505DCC96F797E', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (183, 'B5E515730A154329ACD881862E0C7860', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (184, 'EABC55D5BE1C4C3F86376AA0F25EDFF4', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);
INSERT INTO `iot_product_authorize` VALUES (185, '5E4A06AB2B524AD7BC62B60F7828CCE8', 14, NULL, NULL, NULL, NULL, 1, '0', 'wumei-t1', '2022-06-10 00:43:53', '', NULL, NULL);

-- ----------------------------
-- Table structure for iot_scene
-- ----------------------------
DROP TABLE IF EXISTS `iot_scene`;
CREATE TABLE `iot_scene`  (
  `scene_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '场景ID',
  `scene_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '场景名称',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `triggers` json NOT NULL COMMENT '触发器',
  `actions` json NOT NULL COMMENT '执行动作',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`scene_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场景联动' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_scene
-- ----------------------------

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
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`model_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物模型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_things_model
-- ----------------------------
INSERT INTO `iot_things_model` VALUES (51, '体温(admin)', 13, '智能体温检测仪(admin)', 1, 'admin', 'temp_admin', 1, 'decimal', '{\"max\": 46.5, \"min\": 14.2, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, '0', NULL, '2022-06-09 17:22:09', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (52, '设备开关', 13, '智能体温检测仪(admin)', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 0, '0', NULL, '2022-06-09 17:22:43', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (53, '屏显消息', 13, '智能体温检测仪(admin)', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, '0', NULL, '2022-06-09 17:22:43', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (54, '上报监测数据', 13, '智能体温检测仪(admin)', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 0, 0, '0', NULL, '2022-06-09 17:22:43', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (55, '设备发生异常', 13, '智能体温检测仪(admin)', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, '0', NULL, '2022-06-09 17:22:55', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (56, '体温过高(admin)', 13, '智能体温检测仪(admin)', 1, 'admin', 'high_temp', 3, 'decimal', '{\"max\": 50, \"min\": 20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 0, 0, '0', '', '2022-06-09 17:23:59', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (57, '体温(T1)', 14, '体温检测仪(T1)', 2, 'wumei-t1', 'temp_t1', 1, 'integer', '{\"max\": 46.5, \"min\": 14.2, \"step\": 0.1, \"type\": \"integer\", \"unit\": \"℃\"}', 1, 1, '0', NULL, '2022-06-10 00:39:37', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (58, '空气温度', 14, '体温检测仪(T1)', 2, 'wumei-t1', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, '0', NULL, '2022-06-10 00:39:55', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (59, '空气湿度', 14, '体温检测仪(T1)', 2, 'wumei-t1', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, '0', NULL, '2022-06-10 00:39:55', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (60, '设备开关', 14, '体温检测仪(T1)', 2, 'wumei-t1', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 0, '0', NULL, '2022-06-10 00:39:55', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (61, '运行档位', 14, '体温检测仪(T1)', 2, 'wumei-t1', 'gear', 2, 'enum', '{\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 1, 0, '0', NULL, '2022-06-10 00:39:55', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (62, '设备发生异常', 14, '体温检测仪(T1)', 2, 'wumei-t1', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, '0', NULL, '2022-06-10 00:40:11', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (63, '体温过高(T1)', 14, '体温检测仪(T1)', 2, 'wumei-t1', 'height_temp', 3, 'integer', '{\"max\": 50, \"min\": 10, \"step\": 0.1, \"type\": \"integer\", \"unit\": \"℃\"}', 0, 0, '0', '', '2022-06-10 00:41:53', '', '2022-06-10 00:42:16', NULL);
INSERT INTO `iot_things_model` VALUES (64, '上报监测数据', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 0, 0, '0', NULL, '2022-06-11 00:33:17', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (65, '设备发生异常', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, '0', NULL, '2022-06-11 00:33:17', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (66, '空气温度', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (67, '空气湿度', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (68, '二氧化碳', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'co2', 1, 'integer', '{\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}', 0, 1, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (69, '室内亮度', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 0, 1, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (70, '设备开关', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 0, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (71, '运行档位', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'gear', 2, 'enum', '{\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 1, 0, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (72, '灯光颜色', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"int\"}', 0, 0, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (73, '屏显消息', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (74, '体温(admin)', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'temp_admin', 1, 'decimal', '{\"max\": 46.5, \"min\": 14.2, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (75, '体温(T2)', 15, '温度监测仪(T2)', 3, 'wumei-t2', 'temp_t2', 1, 'decimal', '{\"max\": 40, \"min\": 20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, '0', NULL, '2022-06-11 00:33:26', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (76, '设备开关', 16, '智能开关(T1)', 2, 'wumei-t1', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 0, '0', NULL, '2022-06-12 00:41:03', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (77, '设备发生异常', 16, '智能开关(T1)', 2, 'wumei-t1', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, '0', NULL, '2022-06-12 00:41:51', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (78, '灯光颜色', 16, '智能开关(T1)', 2, 'wumei-t1', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"int\"}', 1, 0, '0', NULL, '2022-06-12 00:42:14', '', '2022-06-12 00:42:28', NULL);
INSERT INTO `iot_things_model` VALUES (79, '空气温度', 17, '七彩灯(T1)', 2, 'wumei-t1', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, '0', NULL, '2022-06-12 11:54:43', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (80, '空气湿度', 17, '七彩灯(T1)', 2, 'wumei-t1', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, '0', NULL, '2022-06-12 11:54:43', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (81, '室内亮度', 17, '七彩灯(T1)', 2, 'wumei-t1', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 0, 1, '0', NULL, '2022-06-12 11:54:43', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (82, '设备开关', 17, '七彩灯(T1)', 2, 'wumei-t1', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 0, '0', NULL, '2022-06-12 11:54:43', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (83, '灯光颜色', 17, '七彩灯(T1)', 2, 'wumei-t1', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"int\"}', 0, 0, '0', NULL, '2022-06-12 11:54:43', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (84, '上报监测数据', 17, '七彩灯(T1)', 2, 'wumei-t1', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 0, 0, '0', NULL, '2022-06-12 11:55:00', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (85, '环境温度过高', 17, '七彩灯(T1)', 2, 'wumei-t1', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 0, 0, '0', NULL, '2022-06-12 11:55:00', '', NULL, NULL);
INSERT INTO `iot_things_model` VALUES (86, '设备发生异常', 17, '七彩灯(T1)', 2, 'wumei-t1', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, '0', NULL, '2022-06-12 11:55:00', '', NULL, NULL);

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
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`template_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物模型模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_things_model_template
-- ----------------------------
INSERT INTO `iot_things_model_template` VALUES (1, '空气温度', 1, 'admin', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, 1, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 20:58:06', NULL);
INSERT INTO `iot_things_model_template` VALUES (2, '空气湿度', 1, 'admin', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, 1, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:11:08', NULL);
INSERT INTO `iot_things_model_template` VALUES (3, '二氧化碳', 1, 'admin', 'co2', 1, 'integer', '{\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}', 1, 0, 1, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:10:09', NULL);
INSERT INTO `iot_things_model_template` VALUES (4, '室内亮度', 1, 'admin', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 1, 0, 1, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:10:17', NULL);
INSERT INTO `iot_things_model_template` VALUES (5, '设备开关', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 1, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);
INSERT INTO `iot_things_model_template` VALUES (6, '运行档位', 1, 'admin', 'gear', 2, 'enum', '{\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 1, 1, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);
INSERT INTO `iot_things_model_template` VALUES (7, '灯光颜色', 1, 'admin', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"int\"}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 00:54:11', NULL);
INSERT INTO `iot_things_model_template` VALUES (8, '屏显消息', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);
INSERT INTO `iot_things_model_template` VALUES (9, '上报监测数据', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);
INSERT INTO `iot_things_model_template` VALUES (10, '环境温度过高', 1, 'admin', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-11 14:48:21', NULL);
INSERT INTO `iot_things_model_template` VALUES (11, '设备发生异常', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', '', '2022-03-09 17:41:49', NULL);
INSERT INTO `iot_things_model_template` VALUES (12, '光照', 1, 'admin', 'light', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}', 0, 0, 1, '0', 'wumei', '2022-05-07 09:41:17', '', '2022-06-06 19:09:21', NULL);
INSERT INTO `iot_things_model_template` VALUES (27, '体温(admin)', 1, 'admin', 'temp_admin', 1, 'decimal', '{\"max\": 46.5, \"min\": 14.2, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, 1, '0', 'admin', '2022-06-09 17:18:03', 'admin', '2022-06-09 23:05:26', NULL);
INSERT INTO `iot_things_model_template` VALUES (28, '体温(T1)', 2, 'wumei-t1', 'temp_t1', 1, 'integer', '{\"max\": 46.5, \"min\": 14.2, \"step\": 0.1, \"type\": \"integer\", \"unit\": \"℃\"}', 0, 1, 1, '0', 'wumei-t1', '2022-06-10 00:37:18', '', NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (29, '体温(T2)', 3, 'wumei-t2', 'temp_t2', 1, 'decimal', '{\"max\": 40, \"min\": 20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 0, 1, 1, '0', 'wumei-t2', '2022-06-11 00:23:21', '', NULL, NULL);

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
  PRIMARY KEY (`news_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '新闻资讯' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '新闻分类' ROW_FORMAT = Dynamic;

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
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME10', 'DEFAULT', '0 30 02 ? * 1,2,3,4,5,6,7', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME11', 'DEFAULT', '0 00 19 ? * 1,2,3,4,5,6,7', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME12', 'DEFAULT', '0 36 19 ? * 1,2,3,4,5,6,7', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME6', 'DEFAULT', '0 50 22 ? * 1,2,3,4,5,6,7', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME7', 'DEFAULT', '0 20 01 ? * 1,2,3,4,5,6,7', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME8', 'DEFAULT', '0 29 01 ? * 1,2,3,4,5,6,7', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME9', 'DEFAULT', '0 27 02 ? * 1,2,3,4,5,6,7', 'Asia/Shanghai');

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
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME10', 'DEFAULT', NULL, 'com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E696F742E646F6D61696E2E4465766963654A6F6200000000000000010200114C0007616374696F6E737400124C6A6176612F6C616E672F537472696E673B4C0007616C65727449647400104C6A6176612F6C616E672F4C6F6E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C0008646576696365496471007E000A4C000A6465766963654E616D6571007E00094C00096973416476616E63657400134C6A6176612F6C616E672F496E74656765723B4C00086A6F6247726F757071007E00094C00056A6F62496471007E000A4C00076A6F624E616D6571007E00094C00076A6F625479706571007E000B4C000D6D697366697265506F6C69637971007E00094C000970726F64756374496471007E000A4C000B70726F647563744E616D6571007E00094C00077363656E65496471007E000A4C000C73657269616C4E756D62657271007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000D787074000877756D65692D74327372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001814EE20BF078707400007070707401605B7B226964223A202267656172222C20226E616D65223A2022E8BF90E8A18CE6A1A3E4BD8D222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A2032372C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A2022E4BD93E6B8A9E6A380E6B58BE8AEBEE5A48728543229227D2C207B226964223A20227265706F72745F6D6F6E69746F72222C20226E616D65223A2022E4B88AE68AA5E79B91E6B58BE695B0E68DAE222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A2032372C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A2022E4BD93E6B8A9E6A380E6B58BE8AEBEE5A48728543229227D5D707400013174001930203330203032203F202A20312C322C332C342C352C362C377372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001B740016E4BD93E6B8A9E6A380E6B58BE8AEBEE5A48728543229737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00170000000074000744454641554C547371007E0016000000000000000A740016E5AE9AE697B6E8B083E695B4E6A1A3E4BD8D285532297371007E001A00000001740001327371007E0016000000000000000F740013E6B8A9E5BAA6E79B91E6B58BE4BBAA285432297074000C44333032474E3339504C4E35740001307800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME11', 'DEFAULT', NULL, 'com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E696F742E646F6D61696E2E4465766963654A6F6200000000000000010200114C0007616374696F6E737400124C6A6176612F6C616E672F537472696E673B4C0007616C65727449647400104C6A6176612F6C616E672F4C6F6E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C0008646576696365496471007E000A4C000A6465766963654E616D6571007E00094C00096973416476616E63657400134C6A6176612F6C616E672F496E74656765723B4C00086A6F6247726F757071007E00094C00056A6F62496471007E000A4C00076A6F624E616D6571007E00094C00076A6F625479706571007E000B4C000D6D697366697265506F6C69637971007E00094C000970726F64756374496471007E000A4C000B70726F647563744E616D6571007E00094C00077363656E65496471007E000A4C000C73657269616C4E756D62657271007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000D787074000877756D65692D74317372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018153A78EF878707400007070707400A45B7B226964223A2022737769746368222C20226E616D65223A2022E8AEBEE5A487E5BC80E585B3222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A2032392C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A2022E699BAE883BDE5BC80E585B328543129227D5D707400013174001930203030203139203F202A20312C322C332C342C352C362C377372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001D740010E699BAE883BDE5BC80E585B328543129737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00170000000074000744454641554C547371007E0016000000000000000B740016E699BAE883BDE5BC80E585B3E68993E5BC80285431297371007E001A00000001740001327371007E00160000000000000010740010E699BAE883BDE5BC80E585B3285431297074000C44325034495534453530484A740001307800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME12', 'DEFAULT', NULL, 'com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E696F742E646F6D61696E2E4465766963654A6F6200000000000000010200114C0007616374696F6E737400124C6A6176612F6C616E672F537472696E673B4C0007616C65727449647400104C6A6176612F6C616E672F4C6F6E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C0008646576696365496471007E000A4C000A6465766963654E616D6571007E00094C00096973416476616E63657400134C6A6176612F6C616E672F496E74656765723B4C00086A6F6247726F757071007E00094C00056A6F62496471007E000A4C00076A6F624E616D6571007E00094C00076A6F625479706571007E000B4C000D6D697366697265506F6C69637971007E00094C000970726F64756374496471007E000A4C000B70726F647563744E616D6571007E00094C00077363656E65496471007E000A4C000C73657269616C4E756D62657271007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000D787074000877756D65692D75317372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018153D73E0078707400007070707400A05B7B226964223A2022737769746368222C20226E616D65223A2022E8AEBEE5A487E5BC80E585B3222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A2033312C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A2022E699BAE883BDE5BC80E585B3227D5D707400013174001930203336203139203F202A20312C322C332C342C352C362C377372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001F74000CE699BAE883BDE5BC80E585B3737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00170000000074000744454641554C547371007E0016000000000000000C740012E5AE9AE697B6E68993E5BC80E5BC80E585B37371007E001A00000001740001327371007E00160000000000000010740010E699BAE883BDE5BC80E585B3285431297074000C4434334D55333637524C5537740001307800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME6', 'DEFAULT', NULL, 'com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E696F742E646F6D61696E2E4465766963654A6F6200000000000000010200114C0007616374696F6E737400124C6A6176612F6C616E672F537472696E673B4C0007616C65727449647400104C6A6176612F6C616E672F4C6F6E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C0008646576696365496471007E000A4C000A6465766963654E616D6571007E00094C00096973416476616E63657400134C6A6176612F6C616E672F496E74656765723B4C00086A6F6247726F757071007E00094C00056A6F62496471007E000A4C00076A6F624E616D6571007E00094C00076A6F625479706571007E000B4C000D6D697366697265506F6C69637971007E00094C000970726F64756374496471007E000A4C000B70726F647563744E616D6571007E00094C00077363656E65496471007E000A4C000C73657269616C4E756D62657271007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000D787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018148F2B2D078707400007070707400B85B7B226964223A20227265706F72745F6D6F6E69746F72222C20226E616D65223A2022E4B88AE68AA5E79B91E6B58BE695B0E68DAE222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A2032342C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A2022E997A8E58FA3E79B91E6B58BE4BBAA2861646D696E29227D5D707400013174001930203530203232203F202A20312C322C332C342C352C362C377372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000018740016E997A8E58FA3E79B91E6B58BE4BBAA2861646D696E29737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00170000000074000744454641554C547371007E00160000000000000006740013E4B88AE68AA5E4BD93E6B8A92861646D696E297371007E001A00000001740001327371007E0016000000000000000D740020E699BAE883BDE4BD93E6B8A9E6A380E6B58BE4BBAA28E7AEA1E79086E59198297074000C4431464C3842315A3337554D740001307800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME7', 'DEFAULT', NULL, 'com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E696F742E646F6D61696E2E4465766963654A6F6200000000000000010200114C0007616374696F6E737400124C6A6176612F6C616E672F537472696E673B4C0007616C65727449647400104C6A6176612F6C616E672F4C6F6E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C0008646576696365496471007E000A4C000A6465766963654E616D6571007E00094C00096973416476616E63657400134C6A6176612F6C616E672F496E74656765723B4C00086A6F6247726F757071007E00094C00056A6F62496471007E000A4C00076A6F624E616D6571007E00094C00076A6F625479706571007E000B4C000D6D697366697265506F6C69637971007E00094C000970726F64756374496471007E000A4C000B70726F647563744E616D6571007E00094C00077363656E65496471007E000A4C000C73657269616C4E756D62657271007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000D787074000877756D65692D74317372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000181497C3208787074000070707074014C5B7B226964223A2022737769746368222C20226E616D65223A2022E8AEBEE5A487E5BC80E585B3222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A2032352C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A2022E5AEA4E58685E6A380E6B58BE4BBAA28543129227D2C207B226964223A202267656172222C20226E616D65223A2022E8BF90E8A18CE6A1A3E4BD8D222C202274797065223A20322C202276616C7565223A202230222C2022736F75726365223A20322C20226465766963654964223A2032352C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A2022E5AEA4E58685E6A380E6B58BE4BBAA28543129227D5D707400013174001930203230203031203F202A20312C322C332C342C352C362C377372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000019740013E5AEA4E58685E6A380E6B58BE4BBAA28543129737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00170000000074000744454641554C547371007E00160000000000000007740016E5AE9AE697B6E68993E5BC80E8AEBEE5A487285431297371007E001A00000001740001327371007E0016000000000000000E740013E4BD93E6B8A9E6A380E6B58BE4BBAA285431297074000C443245343938484738325037740001307800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME8', 'DEFAULT', NULL, 'com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E696F742E646F6D61696E2E4465766963654A6F6200000000000000010200114C0007616374696F6E737400124C6A6176612F6C616E672F537472696E673B4C0007616C65727449647400104C6A6176612F6C616E672F4C6F6E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C0008646576696365496471007E000A4C000A6465766963654E616D6571007E00094C00096973416476616E63657400134C6A6176612F6C616E672F496E74656765723B4C00086A6F6247726F757071007E00094C00056A6F62496471007E000A4C00076A6F624E616D6571007E00094C00076A6F625479706571007E000B4C000D6D697366697265506F6C69637971007E00094C000970726F64756374496471007E000A4C000B70726F647563744E616D6571007E00094C00077363656E65496471007E000A4C000C73657269616C4E756D62657271007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000D787074000877756D65692D75317372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001814983812078707400007070707400A75B7B226964223A2022737769746368222C20226E616D65223A2022E8AEBEE5A487E5BC80E585B3222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A2032362C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A2022E4BD93E6B8A9E6A380E6B58BE4BBAA28553129227D5D707400013174001930203239203031203F202A20312C322C332C342C352C362C377372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001A740013E4BD93E6B8A9E6A380E6B58BE4BBAA28553129737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00170000000074000744454641554C547371007E00160000000000000008740016E5AE9AE697B6E68993E5BC80E8AEBEE5A487285531297371007E001A00000001740001327371007E0016000000000000000E740013E4BD93E6B8A9E6A380E6B58BE4BBAA285431297074000C443431465450485A594B4F58740001307800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME9', 'DEFAULT', NULL, 'com.ruoyi.iot.util.quartz.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E696F742E646F6D61696E2E4465766963654A6F6200000000000000010200114C0007616374696F6E737400124C6A6176612F6C616E672F537472696E673B4C0007616C65727449647400104C6A6176612F6C616E672F4C6F6E673B4C000A636F6E63757272656E7471007E00094C000E63726F6E45787072657373696F6E71007E00094C0008646576696365496471007E000A4C000A6465766963654E616D6571007E00094C00096973416476616E63657400134C6A6176612F6C616E672F496E74656765723B4C00086A6F6247726F757071007E00094C00056A6F62496471007E000A4C00076A6F624E616D6571007E00094C00076A6F625479706571007E000B4C000D6D697366697265506F6C69637971007E00094C000970726F64756374496471007E000A4C000B70726F647563744E616D6571007E00094C00077363656E65496471007E000A4C000C73657269616C4E756D62657271007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000D787074000877756D65692D75327372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001814EDF644078707400007070707400B55B7B226964223A20227265706F72745F6D6F6E69746F72222C20226E616D65223A2022E4B88AE68AA5E79B91E6B58BE695B0E68DAE222C202274797065223A20322C202276616C7565223A202231222C2022736F75726365223A20322C20226465766963654964223A2032382C2022616C6572744E616D65223A2022222C2022616C6572744C6576656C223A20312C20226465766963654E616D65223A2022E4BD93E6B8A9E6A380E6B58BE4BBAA28553229227D5D707400013174001930203237203032203F202A20312C322C332C342C352C362C377372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000001C740013E4BD93E6B8A9E6A380E6B58BE4BBAA28553229737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00170000000074000744454641554C547371007E00160000000000000009740016E5AE9AE697B6E4B88AE68AA5E695B0E68DAE285532297371007E001A00000001740001327371007E0016000000000000000F740013E6B8A9E5BAA6E79B91E6B58BE4BBAA285432297074000C4435494E32423038514E3031740001307800);

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
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'DESKTOP-KKH3KAT1655190465370', 1655195832384, 15000);

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
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME10', 'DEFAULT', 'TASK_CLASS_NAME10', 'DEFAULT', NULL, 1655231400000, -1, 5, 'WAITING', 'CRON', 1655190480000, 0, NULL, 1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME11', 'DEFAULT', 'TASK_CLASS_NAME11', 'DEFAULT', NULL, 1655204400000, -1, 5, 'WAITING', 'CRON', 1655190481000, 0, NULL, 1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME12', 'DEFAULT', 'TASK_CLASS_NAME12', 'DEFAULT', NULL, 1655206560000, -1, 5, 'WAITING', 'CRON', 1655190483000, 0, NULL, 1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME6', 'DEFAULT', 'TASK_CLASS_NAME6', 'DEFAULT', NULL, 1655218200000, -1, 5, 'WAITING', 'CRON', 1655190474000, 0, NULL, 1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME7', 'DEFAULT', 'TASK_CLASS_NAME7', 'DEFAULT', NULL, 1655227200000, -1, 5, 'WAITING', 'CRON', 1655190476000, 0, NULL, 1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME8', 'DEFAULT', 'TASK_CLASS_NAME8', 'DEFAULT', NULL, 1655227740000, -1, 5, 'WAITING', 'CRON', 1655190477000, 0, NULL, 1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME9', 'DEFAULT', 'TASK_CLASS_NAME9', 'DEFAULT', NULL, 1655231220000, -1, 5, 'WAITING', 'CRON', 1655190478000, 0, NULL, 1, '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方授权表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '物美智能', 0, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '北京总公司', 1, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-03-09 16:49:53');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '昆明分公司', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 165 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

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
INSERT INTO `sys_dict_data` VALUES (114, 3, '网关设备', '3', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:04:28', 'admin', '2021-12-19 15:10:30', NULL);
INSERT INTO `sys_dict_data` VALUES (115, 2, '网关子设备', '2', 'iot_device_type', NULL, 'default', 'N', '1', 'admin', '2021-12-19 15:05:52', 'admin', '2021-12-19 15:10:23', NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2006 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 395 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-12 12:06:46');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-12 12:07:00');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-12 12:07:07');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-12 12:07:48');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-12 14:10:55');
INSERT INTO `sys_logininfor` VALUES (116, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-12 14:26:40');
INSERT INTO `sys_logininfor` VALUES (117, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-12 16:23:45');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-12 16:23:55');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-12 17:23:24');
INSERT INTO `sys_logininfor` VALUES (120, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-12 17:23:35');
INSERT INTO `sys_logininfor` VALUES (121, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-12 17:25:39');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-12 17:25:49');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-12 22:15:01');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-12 22:15:33');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-12 22:23:11');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-12 22:30:07');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-13 12:29:53');
INSERT INTO `sys_logininfor` VALUES (128, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-13 12:30:05');
INSERT INTO `sys_logininfor` VALUES (129, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-13 14:12:46');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-13 14:14:33');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-13 14:14:43');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-15 13:00:33');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-15 13:00:46');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-15 13:00:52');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-18 12:53:31');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-18 12:53:41');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-18 15:16:08');
INSERT INTO `sys_logininfor` VALUES (138, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-18 15:16:35');
INSERT INTO `sys_logininfor` VALUES (139, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-18 16:20:26');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-18 16:20:37');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-19 17:19:14');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-19 17:25:13');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-20 14:47:26');
INSERT INTO `sys_logininfor` VALUES (144, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-20 14:47:41');
INSERT INTO `sys_logininfor` VALUES (145, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-20 14:48:13');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-20 14:48:36');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-20 15:12:40');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-20 15:12:53');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 22:50:31');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-21 23:07:45');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 23:07:59');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-21 23:15:44');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-21 23:17:02');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-22 00:52:25');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-22 00:52:46');
INSERT INTO `sys_logininfor` VALUES (156, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-31 22:48:16');
INSERT INTO `sys_logininfor` VALUES (157, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-31 22:48:50');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-31 22:49:37');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-31 22:49:47');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-31 22:49:59');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-31 22:50:40');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-01 14:37:57');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 10:54:47');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 11:17:45');
INSERT INTO `sys_logininfor` VALUES (165, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 11:17:56');
INSERT INTO `sys_logininfor` VALUES (166, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 11:24:52');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 11:25:06');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 11:30:23');
INSERT INTO `sys_logininfor` VALUES (169, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 11:30:35');
INSERT INTO `sys_logininfor` VALUES (170, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 11:32:31');
INSERT INTO `sys_logininfor` VALUES (171, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 11:32:42');
INSERT INTO `sys_logininfor` VALUES (172, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 11:32:58');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 11:33:11');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 14:14:53');
INSERT INTO `sys_logininfor` VALUES (175, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 14:15:05');
INSERT INTO `sys_logininfor` VALUES (176, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 14:16:05');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 14:16:15');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 14:26:47');
INSERT INTO `sys_logininfor` VALUES (179, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 14:26:57');
INSERT INTO `sys_logininfor` VALUES (180, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 14:28:27');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 14:28:36');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 15:00:23');
INSERT INTO `sys_logininfor` VALUES (183, 'wumei-tenant-one', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 15:00:40');
INSERT INTO `sys_logininfor` VALUES (184, 'wumei-tenant-one', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-03 15:04:04');
INSERT INTO `sys_logininfor` VALUES (185, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-03 15:04:17');
INSERT INTO `sys_logininfor` VALUES (186, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 13:22:39');
INSERT INTO `sys_logininfor` VALUES (187, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-06-04 13:28:06');
INSERT INTO `sys_logininfor` VALUES (188, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-06-04 13:28:11');
INSERT INTO `sys_logininfor` VALUES (189, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 13:28:15');
INSERT INTO `sys_logininfor` VALUES (190, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 14:28:34');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 14:28:43');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:11:34');
INSERT INTO `sys_logininfor` VALUES (193, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:11:57');
INSERT INTO `sys_logininfor` VALUES (194, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:12:59');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:13:18');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:16:40');
INSERT INTO `sys_logininfor` VALUES (197, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:16:52');
INSERT INTO `sys_logininfor` VALUES (198, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:17:01');
INSERT INTO `sys_logininfor` VALUES (199, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:17:16');
INSERT INTO `sys_logininfor` VALUES (200, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:18:10');
INSERT INTO `sys_logininfor` VALUES (201, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:18:22');
INSERT INTO `sys_logininfor` VALUES (202, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:20:47');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-06-04 17:20:56');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-06-04 17:21:05');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:21:10');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:22:07');
INSERT INTO `sys_logininfor` VALUES (207, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:22:23');
INSERT INTO `sys_logininfor` VALUES (208, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:24:20');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-06-04 17:24:31');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:24:37');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:26:13');
INSERT INTO `sys_logininfor` VALUES (212, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:26:33');
INSERT INTO `sys_logininfor` VALUES (213, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:29:07');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:29:19');
INSERT INTO `sys_logininfor` VALUES (215, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 17:31:42');
INSERT INTO `sys_logininfor` VALUES (216, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 17:32:06');
INSERT INTO `sys_logininfor` VALUES (217, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 19:37:45');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 19:38:00');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 19:38:49');
INSERT INTO `sys_logininfor` VALUES (220, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 19:39:06');
INSERT INTO `sys_logininfor` VALUES (221, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 21:18:25');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 21:18:43');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 21:25:23');
INSERT INTO `sys_logininfor` VALUES (224, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 21:25:46');
INSERT INTO `sys_logininfor` VALUES (225, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-04 22:10:16');
INSERT INTO `sys_logininfor` VALUES (226, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-04 22:10:38');
INSERT INTO `sys_logininfor` VALUES (227, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 00:13:27');
INSERT INTO `sys_logininfor` VALUES (228, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-06-05 00:13:40');
INSERT INTO `sys_logininfor` VALUES (229, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 00:13:50');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 00:20:30');
INSERT INTO `sys_logininfor` VALUES (231, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-06-05 12:49:57');
INSERT INTO `sys_logininfor` VALUES (232, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 12:50:03');
INSERT INTO `sys_logininfor` VALUES (233, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 12:55:35');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-06-05 12:55:46');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 12:55:57');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 13:09:24');
INSERT INTO `sys_logininfor` VALUES (237, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 13:09:41');
INSERT INTO `sys_logininfor` VALUES (238, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 13:34:08');
INSERT INTO `sys_logininfor` VALUES (239, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 13:34:25');
INSERT INTO `sys_logininfor` VALUES (240, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 13:54:07');
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 13:54:18');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 14:47:28');
INSERT INTO `sys_logininfor` VALUES (243, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 14:47:46');
INSERT INTO `sys_logininfor` VALUES (244, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 14:57:20');
INSERT INTO `sys_logininfor` VALUES (245, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 14:57:37');
INSERT INTO `sys_logininfor` VALUES (246, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 17:19:24');
INSERT INTO `sys_logininfor` VALUES (247, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 17:19:39');
INSERT INTO `sys_logininfor` VALUES (248, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 17:20:20');
INSERT INTO `sys_logininfor` VALUES (249, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 17:21:08');
INSERT INTO `sys_logininfor` VALUES (250, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 17:24:47');
INSERT INTO `sys_logininfor` VALUES (251, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 17:25:00');
INSERT INTO `sys_logininfor` VALUES (252, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 17:28:14');
INSERT INTO `sys_logininfor` VALUES (253, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 17:28:52');
INSERT INTO `sys_logininfor` VALUES (254, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-05 17:30:34');
INSERT INTO `sys_logininfor` VALUES (255, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-05 17:30:46');
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-06 11:53:00');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-06-06 11:53:23');
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-06 11:53:35');
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-06 15:44:36');
INSERT INTO `sys_logininfor` VALUES (260, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-06 15:44:51');
INSERT INTO `sys_logininfor` VALUES (261, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-06 15:46:13');
INSERT INTO `sys_logininfor` VALUES (262, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-06 15:46:30');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-08 11:00:44');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-08 11:09:54');
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-09 12:59:33');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-09 22:57:54');
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-09 22:58:08');
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-09 23:04:18');
INSERT INTO `sys_logininfor` VALUES (269, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-09 23:04:57');
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-09 23:13:39');
INSERT INTO `sys_logininfor` VALUES (271, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-09 23:13:58');
INSERT INTO `sys_logininfor` VALUES (272, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-09 23:16:00');
INSERT INTO `sys_logininfor` VALUES (273, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-09 23:16:14');
INSERT INTO `sys_logininfor` VALUES (274, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-06-09 23:25:37');
INSERT INTO `sys_logininfor` VALUES (275, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-09 23:25:41');
INSERT INTO `sys_logininfor` VALUES (276, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 00:07:15');
INSERT INTO `sys_logininfor` VALUES (277, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 00:07:36');
INSERT INTO `sys_logininfor` VALUES (278, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 00:35:19');
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 00:35:30');
INSERT INTO `sys_logininfor` VALUES (280, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 00:35:52');
INSERT INTO `sys_logininfor` VALUES (281, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 00:36:05');
INSERT INTO `sys_logininfor` VALUES (282, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 00:58:19');
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 00:58:39');
INSERT INTO `sys_logininfor` VALUES (284, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 01:19:50');
INSERT INTO `sys_logininfor` VALUES (285, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 01:20:04');
INSERT INTO `sys_logininfor` VALUES (286, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 01:23:33');
INSERT INTO `sys_logininfor` VALUES (287, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 01:23:50');
INSERT INTO `sys_logininfor` VALUES (288, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 13:18:35');
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 13:18:48');
INSERT INTO `sys_logininfor` VALUES (290, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 13:27:48');
INSERT INTO `sys_logininfor` VALUES (291, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 13:28:02');
INSERT INTO `sys_logininfor` VALUES (292, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 13:29:34');
INSERT INTO `sys_logininfor` VALUES (293, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 13:29:48');
INSERT INTO `sys_logininfor` VALUES (294, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 13:33:36');
INSERT INTO `sys_logininfor` VALUES (295, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 13:34:02');
INSERT INTO `sys_logininfor` VALUES (296, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 13:53:01');
INSERT INTO `sys_logininfor` VALUES (297, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 13:53:12');
INSERT INTO `sys_logininfor` VALUES (298, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 13:54:53');
INSERT INTO `sys_logininfor` VALUES (299, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 13:55:27');
INSERT INTO `sys_logininfor` VALUES (300, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 14:53:24');
INSERT INTO `sys_logininfor` VALUES (301, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-06-10 15:22:20');
INSERT INTO `sys_logininfor` VALUES (302, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 15:22:27');
INSERT INTO `sys_logininfor` VALUES (303, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 21:18:56');
INSERT INTO `sys_logininfor` VALUES (304, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 21:19:08');
INSERT INTO `sys_logininfor` VALUES (305, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 21:20:17');
INSERT INTO `sys_logininfor` VALUES (306, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 21:20:31');
INSERT INTO `sys_logininfor` VALUES (307, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-10 21:20:47');
INSERT INTO `sys_logininfor` VALUES (308, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-10 21:20:58');
INSERT INTO `sys_logininfor` VALUES (309, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 00:21:42');
INSERT INTO `sys_logininfor` VALUES (310, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 00:22:12');
INSERT INTO `sys_logininfor` VALUES (311, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 00:34:44');
INSERT INTO `sys_logininfor` VALUES (312, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 00:35:17');
INSERT INTO `sys_logininfor` VALUES (313, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 00:42:00');
INSERT INTO `sys_logininfor` VALUES (314, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 00:42:13');
INSERT INTO `sys_logininfor` VALUES (315, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 00:42:29');
INSERT INTO `sys_logininfor` VALUES (316, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 00:42:51');
INSERT INTO `sys_logininfor` VALUES (317, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 01:04:11');
INSERT INTO `sys_logininfor` VALUES (318, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 01:04:24');
INSERT INTO `sys_logininfor` VALUES (319, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 01:07:47');
INSERT INTO `sys_logininfor` VALUES (320, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 01:08:10');
INSERT INTO `sys_logininfor` VALUES (321, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 01:10:50');
INSERT INTO `sys_logininfor` VALUES (322, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 01:11:01');
INSERT INTO `sys_logininfor` VALUES (323, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 01:12:42');
INSERT INTO `sys_logininfor` VALUES (324, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 01:12:57');
INSERT INTO `sys_logininfor` VALUES (325, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 01:13:21');
INSERT INTO `sys_logininfor` VALUES (326, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 01:13:40');
INSERT INTO `sys_logininfor` VALUES (327, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 01:25:38');
INSERT INTO `sys_logininfor` VALUES (328, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 01:25:55');
INSERT INTO `sys_logininfor` VALUES (329, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 01:28:18');
INSERT INTO `sys_logininfor` VALUES (330, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 01:28:30');
INSERT INTO `sys_logininfor` VALUES (331, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 02:23:22');
INSERT INTO `sys_logininfor` VALUES (332, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 02:23:34');
INSERT INTO `sys_logininfor` VALUES (333, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 02:24:40');
INSERT INTO `sys_logininfor` VALUES (334, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 02:24:53');
INSERT INTO `sys_logininfor` VALUES (335, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 02:28:48');
INSERT INTO `sys_logininfor` VALUES (336, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 02:29:00');
INSERT INTO `sys_logininfor` VALUES (337, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 02:29:25');
INSERT INTO `sys_logininfor` VALUES (338, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 02:29:36');
INSERT INTO `sys_logininfor` VALUES (339, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 02:30:53');
INSERT INTO `sys_logininfor` VALUES (340, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 02:31:06');
INSERT INTO `sys_logininfor` VALUES (341, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 02:32:21');
INSERT INTO `sys_logininfor` VALUES (342, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 13:28:47');
INSERT INTO `sys_logininfor` VALUES (343, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 14:52:05');
INSERT INTO `sys_logininfor` VALUES (344, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 14:52:17');
INSERT INTO `sys_logininfor` VALUES (345, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 14:52:41');
INSERT INTO `sys_logininfor` VALUES (346, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 14:52:54');
INSERT INTO `sys_logininfor` VALUES (347, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-11 14:54:51');
INSERT INTO `sys_logininfor` VALUES (348, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-11 14:55:02');
INSERT INTO `sys_logininfor` VALUES (349, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 00:38:00');
INSERT INTO `sys_logininfor` VALUES (350, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 00:38:19');
INSERT INTO `sys_logininfor` VALUES (351, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 00:39:14');
INSERT INTO `sys_logininfor` VALUES (352, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 00:39:28');
INSERT INTO `sys_logininfor` VALUES (353, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 00:54:08');
INSERT INTO `sys_logininfor` VALUES (354, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 00:54:29');
INSERT INTO `sys_logininfor` VALUES (355, 'wumei-t2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 00:55:28');
INSERT INTO `sys_logininfor` VALUES (356, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 00:55:46');
INSERT INTO `sys_logininfor` VALUES (357, 'wumei-u2', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 01:33:23');
INSERT INTO `sys_logininfor` VALUES (358, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 01:33:37');
INSERT INTO `sys_logininfor` VALUES (359, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 02:09:31');
INSERT INTO `sys_logininfor` VALUES (360, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 02:09:43');
INSERT INTO `sys_logininfor` VALUES (361, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 02:20:27');
INSERT INTO `sys_logininfor` VALUES (362, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 02:20:45');
INSERT INTO `sys_logininfor` VALUES (363, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 02:21:03');
INSERT INTO `sys_logininfor` VALUES (364, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 02:21:19');
INSERT INTO `sys_logininfor` VALUES (365, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 02:26:45');
INSERT INTO `sys_logininfor` VALUES (366, 'test', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '注册成功', '2022-06-12 02:27:10');
INSERT INTO `sys_logininfor` VALUES (367, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 02:27:24');
INSERT INTO `sys_logininfor` VALUES (368, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 02:28:11');
INSERT INTO `sys_logininfor` VALUES (369, 'test', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 02:28:25');
INSERT INTO `sys_logininfor` VALUES (370, 'test', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 02:28:45');
INSERT INTO `sys_logininfor` VALUES (371, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 02:28:55');
INSERT INTO `sys_logininfor` VALUES (372, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 11:52:17');
INSERT INTO `sys_logininfor` VALUES (373, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 11:52:31');
INSERT INTO `sys_logininfor` VALUES (374, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 14:28:54');
INSERT INTO `sys_logininfor` VALUES (375, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 14:29:21');
INSERT INTO `sys_logininfor` VALUES (376, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 14:32:48');
INSERT INTO `sys_logininfor` VALUES (377, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 14:33:03');
INSERT INTO `sys_logininfor` VALUES (378, 'wumei-t1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 14:56:30');
INSERT INTO `sys_logininfor` VALUES (379, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 14:56:49');
INSERT INTO `sys_logininfor` VALUES (380, 'wumei', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 14:57:45');
INSERT INTO `sys_logininfor` VALUES (381, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 14:57:59');
INSERT INTO `sys_logininfor` VALUES (382, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 14:58:22');
INSERT INTO `sys_logininfor` VALUES (383, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-06-12 14:58:37');
INSERT INTO `sys_logininfor` VALUES (384, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-06-12 14:58:46');
INSERT INTO `sys_logininfor` VALUES (385, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-12 14:59:00');
INSERT INTO `sys_logininfor` VALUES (386, 'wumei-u1', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-12 15:03:10');
INSERT INTO `sys_logininfor` VALUES (387, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-06-14 15:15:31');
INSERT INTO `sys_logininfor` VALUES (388, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-06-14 15:15:36');
INSERT INTO `sys_logininfor` VALUES (389, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-06-14 15:15:53');
INSERT INTO `sys_logininfor` VALUES (390, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-06-14 15:16:05');
INSERT INTO `sys_logininfor` VALUES (391, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-14 15:16:24');
INSERT INTO `sys_logininfor` VALUES (392, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-14 15:54:14');
INSERT INTO `sys_logininfor` VALUES (393, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-06-14 15:56:24');
INSERT INTO `sys_logininfor` VALUES (394, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-14 15:56:30');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2149 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 2, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:46:20', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 3, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:43:05', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 4, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:42:59', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '物美智能', 0, 5, 'http://wumei.live', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-26 00:42:48', '若依官网地址');
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
INSERT INTO `sys_menu` VALUES (2085, '场景联动', 2000, 8, 'scene', 'iot/scene/index', NULL, 1, 0, 'C', '1', '0', 'iot:scene:list', 'scene', 'admin', '2022-01-13 17:16:45', 'admin', '2022-03-25 22:30:50', '场景联动菜单');
INSERT INTO `sys_menu` VALUES (2086, '场景联动查询', 2085, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:query', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2087, '场景联动新增', 2085, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:add', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2088, '场景联动修改', 2085, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:edit', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '场景联动删除', 2085, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:remove', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2090, '场景联动导出', 2085, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:scene:export', '#', 'admin', '2022-01-13 17:16:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2098, '云云对接', 2000, 9, 'clientDetails', 'iot/clientDetails/index', NULL, 1, 0, 'C', '0', '0', 'iot:clientDetails:list', 'cloud', 'admin', '2022-02-07 22:08:58', 'admin', '2022-05-12 17:22:07', '云云对接菜单');
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
INSERT INTO `sys_menu` VALUES (2141, '三方登录', 1, 12, 'platform', 'iot/platform/index', NULL, 1, 1, 'C', '0', '0', 'iot:platform:list', 'cloud', 'admin', '2022-04-11 18:55:34', 'admin', '2022-05-12 17:21:39', '');
INSERT INTO `sys_menu` VALUES (2142, '平台查询', 2142, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:platform:query', '#', 'admin', '2022-04-11 19:10:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2143, 'EMQ查询', 2104, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:emqx:query', '#', 'admin', '2022-03-09 16:58:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2144, 'EMQ新增', 2104, 9, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:emqx:add', '#', 'admin', '2022-03-09 16:58:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2145, 'EMQ编辑', 2104, 10, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:emqx:edit', '#', 'admin', '2022-03-09 16:58:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2146, 'EMQ删除', 2104, 11, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:emqx:remove', '#', 'admin', '2022-03-09 16:58:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2147, '设备分享', 2007, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:device:share', '#', 'admin', '2022-06-10 01:08:40', 'admin', '2022-06-10 01:10:46', '');
INSERT INTO `sys_menu` VALUES (2148, '设备定时', 2007, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:device:timer', '#', 'admin', '2022-06-10 01:10:30', '', NULL, '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 643 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (234, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'admin', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888888\",\"params\":{},\"userName\":\"admin\",\"deviceId\":1,\"deviceName\":\"ESP8266开发板\",\"userId\":1,\"tenantName\":\"admin\",\"createTime\":1650598915703,\"isOwner\":0,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-22 11:41:55');
INSERT INTO `sys_oper_log` VALUES (235, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'admin', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"params\":{},\"deviceId\":3,\"deviceName\":\"ESP8266开发板\",\"tenantName\":\"admin\",\"createTime\":1650598955937,\"isOwner\":0,\"tenantId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\project\\gitee\\wumei-smart\\springboot\\wumei-iot\\target\\classes\\mapper\\iot\\DeviceUserMapper.xml]\r\n### The error may involve com.ruoyi.iot.mapper.DeviceUserMapper.insertDeviceUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into iot_device_user          ( device_name,                          is_owner,             tenant_id,             tenant_name,                                                    create_time )           values ( ?,                          ?,             ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\n; Field \'user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'user_id\' doesn\'t have a default value', '2022-04-22 11:42:36');
INSERT INTO `sys_oper_log` VALUES (236, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"category\",\"orderNum\":\"10\",\"menuName\":\"新闻分类\",\"params\":{},\"parentId\":1,\"isCache\":\"0\",\"path\":\"newsCategory\",\"component\":\"iot/newsCategory/index\",\"children\":[],\"createTime\":1649666847000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2123,\"menuType\":\"C\",\"perms\":\"iot:newsCategory:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:20:51');
INSERT INTO `sys_oper_log` VALUES (237, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"documentation\",\"orderNum\":\"11\",\"menuName\":\"新闻资讯\",\"params\":{},\"parentId\":1,\"isCache\":\"0\",\"path\":\"news\",\"component\":\"iot/news/index\",\"children\":[],\"createTime\":1649666866000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2129,\"menuType\":\"C\",\"perms\":\"iot:news:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:20:58');
INSERT INTO `sys_oper_log` VALUES (238, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"cloud\",\"orderNum\":\"12\",\"menuName\":\"三方登录\",\"params\":{},\"parentId\":1,\"isCache\":\"1\",\"path\":\"platform\",\"component\":\"iot/platform/index\",\"children\":[],\"createTime\":1649674534000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2141,\"menuType\":\"C\",\"perms\":\"iot:platform:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:21:39');
INSERT INTO `sys_oper_log` VALUES (239, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"cloud\",\"orderNum\":\"9\",\"menuName\":\"云云对接\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"clientDetails\",\"component\":\"iot/clientDetails/index\",\"children\":[],\"createTime\":1644242938000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2098,\"menuType\":\"C\",\"perms\":\"iot:clientDetails:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:22:07');
INSERT INTO `sys_oper_log` VALUES (240, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"menuIds\":[2000,2049,2001,2043,2013,2019,2007,2067,2085,2098,2104,1,100,101,102,103,104,105,106,107,108,500,501,2123,2129,2,109,110,3,115,2050,2051,2052,2002,2003,2004,2044,2045,2046,2014,2015,2016,2020,2021,2022,2008,2009,2010,2068,2069,2070,2086,2087,2088,2099,2100,2101,2105,2109,2106,2107,2108,1001,1008,1013,1017,1021,1026,1031,1036,1040,1043,2124,2125,2126,2130,2131,2132,2141,1046,1049,111,112,113,114,1055,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:23:16');
INSERT INTO `sys_oper_log` VALUES (241, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"menuIds\":[2000,2049,2001,2043,2013,2019,2007,2067,2085,2098,2104,1,100,101,102,103,104,105,106,107,108,500,501,2123,2129,2,109,110,3,115,2050,2051,2052,2002,2003,2004,2044,2045,2046,2014,2015,2016,2020,2021,2022,2008,2009,2010,2068,2069,2070,2086,2087,2088,2099,2100,2101,2105,2109,2106,2107,2108,1001,1008,1013,1017,1021,1026,1031,1036,1040,1043,2124,2125,2126,2130,2131,2132,2141,1046,1049,111,112,113,114,1055,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:26:35');
INSERT INTO `sys_oper_log` VALUES (242, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"0\",\"listClass\":\"default\",\"dictSort\":0,\"remark\":\"启用\",\"params\":{},\"dictType\":\"iot_social_platform_status\",\"dictLabel\":\"启用\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1650445368000,\"dictCode\":156,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:38:33');
INSERT INTO `sys_oper_log` VALUES (243, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"1\",\"listClass\":\"default\",\"dictSort\":1,\"remark\":\"禁用\",\"params\":{},\"dictType\":\"iot_social_platform_status\",\"dictLabel\":\"未启用\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1650445395000,\"dictCode\":157,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:38:42');
INSERT INTO `sys_oper_log` VALUES (244, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"0\",\"listClass\":\"success\",\"dictSort\":0,\"remark\":\"启用\",\"params\":{},\"dictType\":\"iot_social_platform_status\",\"dictLabel\":\"启用\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1650445368000,\"dictCode\":156,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:39:40');
INSERT INTO `sys_oper_log` VALUES (245, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"QQ\",\"listClass\":\"default\",\"dictSort\":0,\"params\":{},\"dictType\":\"iot_social_platform\",\"dictLabel\":\"QQ登录\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1650444166000,\"dictCode\":155,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:40:27');
INSERT INTO `sys_oper_log` VALUES (246, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"WECHAT\",\"listClass\":\"default\",\"dictSort\":0,\"params\":{},\"dictType\":\"iot_social_platform\",\"dictLabel\":\"微信登录\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1650444093000,\"dictCode\":154,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:40:38');
INSERT INTO `sys_oper_log` VALUES (247, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"zhifubao\",\"listClass\":\"primary\",\"dictSort\":3,\"params\":{},\"dictType\":\"iot_social_platform\",\"dictLabel\":\"支付宝\",\"createBy\":\"admin\",\"default\":false,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:49:24');
INSERT INTO `sys_oper_log` VALUES (248, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"zhifubao\",\"listClass\":\"default\",\"dictSort\":3,\"params\":{},\"dictType\":\"iot_social_platform\",\"dictLabel\":\"支付宝\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1652348964000,\"dictCode\":158,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:49:34');
INSERT INTO `sys_oper_log` VALUES (249, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"WECHAT\",\"listClass\":\"default\",\"dictSort\":1,\"params\":{},\"dictType\":\"iot_social_platform\",\"dictLabel\":\"微信登录\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1650444093000,\"dictCode\":154,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:49:45');
INSERT INTO `sys_oper_log` VALUES (250, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"QQ\",\"listClass\":\"default\",\"dictSort\":2,\"params\":{},\"dictType\":\"iot_social_platform\",\"dictLabel\":\"QQ登录\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1650444166000,\"dictCode\":155,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:49:54');
INSERT INTO `sys_oper_log` VALUES (251, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"ALIPAY\",\"listClass\":\"default\",\"dictSort\":3,\"params\":{},\"dictType\":\"iot_social_platform\",\"dictLabel\":\"支付宝\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1652348964000,\"dictCode\":158,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 17:50:21');
INSERT INTO `sys_oper_log` VALUES (252, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"build\",\"orderNum\":\"9\",\"menuName\":\"规则资源\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"resource\",\"component\":\"iot/emqx/resource\",\"children\":[],\"createTime\":1649312213000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2111,\"menuType\":\"C\",\"perms\":\"monitor:online:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-13 00:26:12');
INSERT INTO `sys_oper_log` VALUES (253, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'admin', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":2,\"status\":1}', '{\"msg\":\"取消发布失败，请先删除产品下的设备\",\"code\":500}', 0, NULL, '2022-05-18 14:06:11');
INSERT INTO `sys_oper_log` VALUES (254, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'admin', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":10,\"productId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-18 14:08:33');
INSERT INTO `sys_oper_log` VALUES (255, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'admin', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":10,\"productId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-19 17:37:53');
INSERT INTO `sys_oper_log` VALUES (256, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2022/05/20/aefe4194-c262-44d1-ba4d-07108508e65a.jpeg\",\"code\":200}', 0, NULL, '2022-05-20 14:46:47');
INSERT INTO `sys_oper_log` VALUES (257, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":1,\"admin\":true,\"dataScope\":\"1\",\"params\":{},\"roleSort\":\"1\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"status\":\"0\"}],\"phonenumber\":\"15888888888\",\"admin\":true,\"loginDate\":1652862038000,\"remark\":\"管理员\",\"delFlag\":\"0\",\"loginIp\":\"127.0.0.1\",\"email\":\"164770707@qq.com\",\"nickName\":\"物美智能管理员\",\"sex\":\"0\",\"deptId\":103,\"avatar\":\"\",\"dept\":{\"deptName\":\"研发部门\",\"leader\":\"物美\",\"deptId\":103,\"orderNum\":\"1\",\"params\":{},\"parentId\":101,\"children\":[],\"status\":\"1\"},\"params\":{},\"userName\":\"admin\",\"userId\":1,\"createBy\":\"admin\",\"createTime\":1639575378000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-20 14:47:08');
INSERT INTO `sys_oper_log` VALUES (258, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'wumei', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2022/05/20/2b9a23c0-73a4-4b00-aabc-13c74900f0d0.jpeg\",\"code\":200}', 0, NULL, '2022-05-20 14:48:08');
INSERT INTO `sys_oper_log` VALUES (259, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2022/05/20/5b04be2b-e744-4fa1-a4ea-5f1f7c82d1eb.jpeg\",\"code\":200}', 0, NULL, '2022-05-20 15:01:47');
INSERT INTO `sys_oper_log` VALUES (260, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/9', '127.0.0.1', '内网IP', '{deviceIds=9}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 10:11:49');
INSERT INTO `sys_oper_log` VALUES (261, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/8', '127.0.0.1', '内网IP', '{deviceIds=8}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 10:11:56');
INSERT INTO `sys_oper_log` VALUES (262, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"1\",\"listClass\":\"info\",\"dictSort\":1,\"remark\":\"禁用\",\"params\":{},\"dictType\":\"iot_social_platform_status\",\"dictLabel\":\"未启用\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1650445395000,\"dictCode\":157,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:44:14');
INSERT INTO `sys_oper_log` VALUES (263, '字典类型', 2, 'com.ruoyi.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":1644236868000,\"updateBy\":\"admin\",\"dictName\":\"Oauth开放平台\",\"remark\":\"1=小度，2=天猫精灵，3=小爱，4=其他\",\"dictId\":114,\"params\":{},\"dictType\":\"oauth_platform\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:44:51');
INSERT INTO `sys_oper_log` VALUES (264, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"设备定位方式\",\"params\":{},\"dictType\":\"iot_location_way\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:45:17');
INSERT INTO `sys_oper_log` VALUES (265, '字典类型', 2, 'com.ruoyi.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":1653111916000,\"updateBy\":\"admin\",\"dictName\":\"设备定位方式\",\"remark\":\"1=IP自动定位，2=设备定位，3=自定义\",\"dictId\":117,\"params\":{},\"dictType\":\"iot_location_way\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:46:06');
INSERT INTO `sys_oper_log` VALUES (266, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"1\",\"listClass\":\"success\",\"dictSort\":1,\"remark\":\"精确到城市\",\"params\":{},\"dictType\":\"iot_location_way\",\"dictLabel\":\"IP自动定位\",\"createBy\":\"admin\",\"default\":false,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:46:51');
INSERT INTO `sys_oper_log` VALUES (267, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"1\",\"listClass\":\"success\",\"dictSort\":1,\"remark\":\"精确到城市\",\"params\":{},\"dictType\":\"iot_location_way\",\"dictLabel\":\"IP自动定位\",\"createBy\":\"admin\",\"default\":false,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:46:51');
INSERT INTO `sys_oper_log` VALUES (268, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"2\",\"listClass\":\"primary\",\"dictSort\":2,\"remark\":\"最精确定位\",\"params\":{},\"dictType\":\"iot_location_way\",\"dictLabel\":\"设备定位\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1653112011000,\"dictCode\":160,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:48:07');
INSERT INTO `sys_oper_log` VALUES (269, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"3\",\"listClass\":\"primary\",\"dictSort\":0,\"remark\":\"位置自定义\",\"params\":{},\"dictType\":\"iot_location_way\",\"dictLabel\":\"自定义\",\"createBy\":\"admin\",\"default\":false,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:48:50');
INSERT INTO `sys_oper_log` VALUES (270, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"3\",\"listClass\":\"primary\",\"dictSort\":3,\"remark\":\"位置自定义\",\"params\":{},\"dictType\":\"iot_location_way\",\"dictLabel\":\"自定义\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1653112130000,\"dictCode\":161,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:49:08');
INSERT INTO `sys_oper_log` VALUES (271, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"2\",\"listClass\":\"warning\",\"dictSort\":2,\"remark\":\"最精确定位\",\"params\":{},\"dictType\":\"iot_location_way\",\"dictLabel\":\"设备定位\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1653112011000,\"dictCode\":160,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:49:21');
INSERT INTO `sys_oper_log` VALUES (272, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"1\",\"listClass\":\"success\",\"dictSort\":1,\"remark\":\"IP定位，精确到城市\",\"params\":{},\"dictType\":\"iot_location_way\",\"dictLabel\":\"自动定位\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1653112011000,\"dictCode\":159,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:53:25');
INSERT INTO `sys_oper_log` VALUES (273, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"3\",\"listClass\":\"primary\",\"dictSort\":3,\"remark\":\"位置自定义\",\"params\":{},\"dictType\":\"iot_location_way\",\"dictLabel\":\"自定义位置\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1653112130000,\"dictCode\":161,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-21 13:55:46');
INSERT INTO `sys_oper_log` VALUES (274, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":2,\"admin\":false,\"dataScope\":\"5\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"status\":\"0\"}],\"phonenumber\":\"15288888880\",\"admin\":false,\"loginDate\":1650083870000,\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[],\"loginIp\":\"127.0.0.1\",\"email\":\"\",\"nickName\":\"物美租户壹\",\"sex\":\"0\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"物美智能\",\"leader\":\"物美\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"wumei-tenant-one\",\"userId\":121,\"createBy\":\"admin\",\"roleIds\":[2],\"createTime\":1650010885000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-01 14:40:53');
INSERT INTO `sys_oper_log` VALUES (275, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":2,\"admin\":false,\"dataScope\":\"5\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"status\":\"0\"}],\"phonenumber\":\"15388888880\",\"admin\":false,\"loginDate\":1650084537000,\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[],\"loginIp\":\"127.0.0.1\",\"email\":\"\",\"nickName\":\"物美租户贰\",\"sex\":\"0\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"物美智能\",\"leader\":\"物美\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"wumei-tenant-two\",\"userId\":122,\"createBy\":\"admin\",\"roleIds\":[2],\"createTime\":1650010928000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-01 14:41:03');
INSERT INTO `sys_oper_log` VALUES (276, '角色管理', 3, 'com.ruoyi.web.controller.system.SysRoleController.remove()', 'DELETE', 1, 'admin', NULL, '/system/role/1', '127.0.0.1', '内网IP', '{roleIds=1}', NULL, 1, '不允许操作超级管理员角色', '2022-06-02 13:10:44');
INSERT INTO `sys_oper_log` VALUES (277, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"不能删除，管理产品和设备的用户分配该权限\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1639644090000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"menuIds\":[2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2136,2044,2137,2045,2138,2046,2139,2047,2048,2140,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:10:12');
INSERT INTO `sys_oper_log` VALUES (278, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":3,\"admin\":false,\"remark\":\"普通角色，不能删除，设备的最终用户，只能管理设备\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"3\",\"deptCheckStrictly\":true,\"createTime\":1639575378000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"common\",\"roleName\":\"普通用户\",\"menuIds\":[2000,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:10:53');
INSERT INTO `sys_oper_log` VALUES (279, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"menuIds\":[2000,2049,2001,2043,2013,2019,2007,2067,2085,2098,2104,1,100,101,102,103,104,105,106,107,108,500,501,2123,2129,2,109,110,3,115,2050,2051,2052,2002,2003,2004,2136,2044,2137,2045,2138,2046,2014,2015,2016,2020,2021,2022,2008,2009,2010,2068,2069,2070,2086,2087,2088,2099,2100,2101,2105,2109,2106,2107,2108,2112,2111,1001,1008,1013,1017,1021,1026,1031,1036,1040,1043,2124,2125,2126,2130,2131,2132,2141,1046,1049,111,112,113,114,1055,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:14:35');
INSERT INTO `sys_oper_log` VALUES (280, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[],\"phonenumber\":\"15288888880\",\"admin\":false,\"loginDate\":1650083870000,\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[],\"loginIp\":\"127.0.0.1\",\"email\":\"\",\"nickName\":\"物美租户壹\",\"sex\":\"0\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"物美智能\",\"leader\":\"物美\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"wumei-tenant-one\",\"userId\":2,\"createBy\":\"admin\",\"roleIds\":[2],\"createTime\":1650010885000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:15:49');
INSERT INTO `sys_oper_log` VALUES (281, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[],\"phonenumber\":\"15388888880\",\"admin\":false,\"loginDate\":1650084537000,\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[],\"loginIp\":\"127.0.0.1\",\"email\":\"\",\"nickName\":\"物美租户贰\",\"sex\":\"0\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"物美智能\",\"leader\":\"物美\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"wumei-tenant-two\",\"userId\":3,\"createBy\":\"admin\",\"roleIds\":[2],\"createTime\":1650010928000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:16:01');
INSERT INTO `sys_oper_log` VALUES (282, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[],\"phonenumber\":\"13988888880\",\"admin\":false,\"loginDate\":1650084149000,\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[],\"loginIp\":\"127.0.0.1\",\"email\":\"\",\"nickName\":\"物美用户壹\",\"sex\":\"0\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"物美智能\",\"leader\":\"物美\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"wumei-user-one\",\"userId\":4,\"createBy\":\"admin\",\"roleIds\":[3],\"createTime\":1650010957000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:16:31');
INSERT INTO `sys_oper_log` VALUES (283, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[],\"phonenumber\":\"13866666660\",\"admin\":false,\"loginDate\":1650013345000,\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[],\"loginIp\":\"127.0.0.1\",\"email\":\"\",\"nickName\":\"物美用户贰\",\"sex\":\"0\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"物美智能\",\"leader\":\"物美\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"wumei-user-two\",\"userId\":5,\"createBy\":\"admin\",\"roleIds\":[3],\"createTime\":1650010993000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:16:41');
INSERT INTO `sys_oper_log` VALUES (284, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[],\"phonenumber\":\"\",\"admin\":false,\"loginDate\":1654008496000,\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[],\"loginIp\":\"127.0.0.1\",\"email\":\"\",\"nickName\":\"游客账号\",\"sex\":\"0\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"物美智能\",\"leader\":\"物美\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"wumei\",\"userId\":6,\"createBy\":\"admin\",\"roleIds\":[4],\"createTime\":1646815759000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:16:51');
INSERT INTO `sys_oper_log` VALUES (285, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":4,\"admin\":false,\"dataScope\":\"5\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"status\":\"0\"}],\"phonenumber\":\"13988866666\",\"admin\":false,\"loginDate\":1654226279000,\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[4],\"loginIp\":\"127.0.0.1\",\"email\":\"\",\"nickName\":\"游客账号\",\"sex\":\"0\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"物美智能\",\"leader\":\"物美\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"wumei\",\"userId\":6,\"createBy\":\"admin\",\"roleIds\":[4],\"createTime\":1646815759000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:27:10');
INSERT INTO `sys_oper_log` VALUES (286, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', NULL, '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"deptIds\":[],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:29:41');
INSERT INTO `sys_oper_log` VALUES (287, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', NULL, '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"deptIds\":[],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 11:30:19');
INSERT INTO `sys_oper_log` VALUES (288, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"client\",\"orderNum\":\"1\",\"menuName\":\"客户端\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"client\",\"component\":\"iot/emqx/client\",\"children\":[],\"createTime\":1645807539000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2105,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 13:45:18');
INSERT INTO `sys_oper_log` VALUES (289, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"listener\",\"orderNum\":\"2\",\"menuName\":\"监听器\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"listener\",\"component\":\"iot/emqx/listener\",\"children\":[],\"createTime\":1645962728000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2109,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 13:45:28');
INSERT INTO `sys_oper_log` VALUES (290, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"topic\",\"orderNum\":\"3\",\"menuName\":\"消息主题\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"topic\",\"component\":\"iot/emqx/topic\",\"children\":[],\"createTime\":1645950677000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2106,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 13:45:35');
INSERT INTO `sys_oper_log` VALUES (291, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"subscribe\",\"orderNum\":\"4\",\"menuName\":\"消息订阅\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"subscribe\",\"component\":\"iot/emqx/subscribe\",\"children\":[],\"createTime\":1645950741000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2107,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 13:45:42');
INSERT INTO `sys_oper_log` VALUES (292, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"plugin\",\"orderNum\":\"5\",\"menuName\":\"插件管理\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"plugin\",\"component\":\"iot/emqx/plugin\",\"children\":[],\"createTime\":1645960240000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2108,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 13:45:49');
INSERT INTO `sys_oper_log` VALUES (293, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"build\",\"orderNum\":\"6\",\"menuName\":\"规则资源\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"resource\",\"component\":\"iot/emqx/resource\",\"children\":[],\"createTime\":1649312213000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2111,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 13:45:55');
INSERT INTO `sys_oper_log` VALUES (294, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"build\",\"orderNum\":\"7\",\"menuName\":\"规则引擎\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"rule\",\"component\":\"iot/emqx/rule\",\"children\":[],\"createTime\":1649312377000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2112,\"menuType\":\"C\",\"perms\":\"\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 13:46:02');
INSERT INTO `sys_oper_log` VALUES (295, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"client\",\"orderNum\":\"1\",\"menuName\":\"客户端\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"client\",\"component\":\"iot/emqx/client\",\"children\":[],\"createTime\":1645807539000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2105,\"menuType\":\"C\",\"perms\":\"iot:emqx:client\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 14:11:22');
INSERT INTO `sys_oper_log` VALUES (296, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"listener\",\"orderNum\":\"2\",\"menuName\":\"监听器\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"listener\",\"component\":\"iot/emqx/listener\",\"children\":[],\"createTime\":1645962728000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2109,\"menuType\":\"C\",\"perms\":\"iot:emqx:listener\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 14:11:45');
INSERT INTO `sys_oper_log` VALUES (297, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"topic\",\"orderNum\":\"3\",\"menuName\":\"消息主题\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"topic\",\"component\":\"iot/emqx/topic\",\"children\":[],\"createTime\":1645950677000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2106,\"menuType\":\"C\",\"perms\":\"iot:emqx:topic\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 14:11:59');
INSERT INTO `sys_oper_log` VALUES (298, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"subscribe\",\"orderNum\":\"4\",\"menuName\":\"消息订阅\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"subscribe\",\"component\":\"iot/emqx/subscribe\",\"children\":[],\"createTime\":1645950741000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2107,\"menuType\":\"C\",\"perms\":\"iot:emqx:subscribe\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 14:12:11');
INSERT INTO `sys_oper_log` VALUES (299, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"plugin\",\"orderNum\":\"5\",\"menuName\":\"插件管理\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"plugin\",\"component\":\"iot/emqx/plugin\",\"children\":[],\"createTime\":1645960240000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2108,\"menuType\":\"C\",\"perms\":\"iot:emqx:plugin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 14:12:24');
INSERT INTO `sys_oper_log` VALUES (300, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"build\",\"orderNum\":\"6\",\"menuName\":\"规则资源\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"resource\",\"component\":\"iot/emqx/resource\",\"children\":[],\"createTime\":1649312213000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2111,\"menuType\":\"C\",\"perms\":\"iot:emqx:resource\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 14:12:35');
INSERT INTO `sys_oper_log` VALUES (301, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"build\",\"orderNum\":\"7\",\"menuName\":\"规则引擎\",\"params\":{},\"parentId\":2104,\"isCache\":\"0\",\"path\":\"rule\",\"component\":\"iot/emqx/rule\",\"children\":[],\"createTime\":1649312377000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2112,\"menuType\":\"C\",\"perms\":\"iot:emqx:rule\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 14:12:48');
INSERT INTO `sys_oper_log` VALUES (302, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"menuIds\":[2000,2049,2001,2043,2013,2019,2007,2067,2085,2098,2104,1,100,101,102,103,104,105,106,107,108,500,501,2123,2129,2,109,110,3,115,2050,2051,2052,2002,2003,2004,2136,2044,2137,2045,2138,2046,2014,2015,2016,2020,2021,2022,2008,2009,2010,2068,2069,2070,2086,2087,2088,2099,2100,2101,2105,2109,2106,2107,2108,2111,2112,2143,2144,1001,1008,1013,1017,1021,1026,1031,1036,1040,1043,2124,2125,2126,2130,2131,2132,2141,1046,1049,111,112,113,114,1055,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 14:13:49');
INSERT INTO `sys_oper_log` VALUES (303, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', NULL, '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"deptIds\":[],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-03 14:55:07');
INSERT INTO `sys_oper_log` VALUES (304, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"noticeContent\":\"维护内容\",\"createBy\":\"admin\",\"createTime\":1639575378000,\"updateBy\":\"admin\",\"noticeType\":\"1\",\"remark\":\"管理员\",\"params\":{},\"noticeId\":2,\"noticeTitle\":\"维护通知：2021-03151 wumei-smart系统凌晨2点-4点维护\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 15:51:21');
INSERT INTO `sys_oper_log` VALUES (305, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"noticeContent\":\"<p><img src=\\\"/dev-api/profile/upload/2022/04/13/8558ba06-270a-469c-bb9b-f651eff15a5c.png\\\">新版本内容</p>\",\"createBy\":\"admin\",\"createTime\":1639575378000,\"updateBy\":\"admin\",\"noticeType\":\"2\",\"remark\":\"管理员\",\"updateTime\":1649864900000,\"params\":{},\"noticeId\":1,\"noticeTitle\":\"物美智能V1.2版本发布\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:03:41');
INSERT INTO `sys_oper_log` VALUES (306, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"noticeContent\":\"<p>维护内容</p>\",\"createBy\":\"admin\",\"createTime\":1639575378000,\"updateBy\":\"admin\",\"noticeType\":\"1\",\"remark\":\"管理员\",\"updateTime\":1654329080000,\"params\":{},\"noticeId\":2,\"noticeTitle\":\"维护：物美智能凌晨2-5点进行项目维护\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:04:27');
INSERT INTO `sys_oper_log` VALUES (307, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"noticeContent\":\"<p>维护内容</p>\",\"createBy\":\"admin\",\"createTime\":1639575378000,\"updateBy\":\"admin\",\"noticeType\":\"1\",\"remark\":\"管理员\",\"updateTime\":1654333467000,\"params\":{},\"noticeId\":2,\"noticeTitle\":\"物美智能凌晨2-5点进行项目维护\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:04:57');
INSERT INTO `sys_oper_log` VALUES (308, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"noticeContent\":\"<p>维护内容</p>\",\"createBy\":\"admin\",\"createTime\":1639575378000,\"updateBy\":\"admin\",\"noticeType\":\"1\",\"remark\":\"管理员\",\"updateTime\":1654333496000,\"params\":{},\"noticeId\":2,\"noticeTitle\":\"物美智能sdk支持树莓派\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:05:13');
INSERT INTO `sys_oper_log` VALUES (309, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"noticeContent\":\"<p>目前sdk支持的版本:</p><ol><li>Arduino esp8266</li><li>Arduino esp32</li><li>esp-idf</li><li>raspberry 树莓派</li></ol>\",\"createBy\":\"admin\",\"createTime\":1639575378000,\"updateBy\":\"admin\",\"noticeType\":\"1\",\"remark\":\"管理员\",\"updateTime\":1654333513000,\"params\":{},\"noticeId\":2,\"noticeTitle\":\"物美智能sdk支持树莓派\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:06:16');
INSERT INTO `sys_oper_log` VALUES (310, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"noticeContent\":\"<p>这是测试内容，新版本功能：</p><ol><li>支持多租户</li><li>支持设备分享</li><li>支持时序数据库</li><li>简单认证和加密认证统一</li></ol>\",\"createBy\":\"admin\",\"createTime\":1639575378000,\"updateBy\":\"admin\",\"noticeType\":\"2\",\"remark\":\"管理员\",\"updateTime\":1654333420000,\"params\":{},\"noticeId\":1,\"noticeTitle\":\"物美智能V1.2版本发布\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:07:25');
INSERT INTO `sys_oper_log` VALUES (311, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"noticeContent\":\"<p>这是测试内容，目前sdk支持的版本:</p><p><br></p><ol><li>Arduino esp8266</li><li>Arduino esp32</li><li>esp-idf</li><li>raspberry 树莓派</li></ol>\",\"createBy\":\"admin\",\"createTime\":1639575378000,\"updateBy\":\"admin\",\"noticeType\":\"1\",\"remark\":\"管理员\",\"updateTime\":1654333576000,\"params\":{},\"noticeId\":2,\"noticeTitle\":\"物美智能sdk支持树莓派\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:07:35');
INSERT INTO `sys_oper_log` VALUES (312, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"noticeContent\":\"<p>这是测试内容，目前sdk支持的版本:</p><p><br></p><ol><li>Arduino esp8266</li><li>Arduino esp32</li><li>esp-idf</li><li>raspberry 树莓派</li></ol>\",\"createBy\":\"admin\",\"createTime\":1639575378000,\"updateBy\":\"admin\",\"noticeType\":\"1\",\"remark\":\"管理员\",\"updateTime\":1654333576000,\"params\":{},\"noticeId\":2,\"noticeTitle\":\"物美智能sdk支持树莓派\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:07:36');
INSERT INTO `sys_oper_log` VALUES (313, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":5,\"admin\":false,\"remark\":\"普通管理员\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"5\",\"deptCheckStrictly\":true,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"manager\",\"roleName\":\"管理员\",\"menuIds\":[],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:14:03');
INSERT INTO `sys_oper_log` VALUES (314, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"不能删除，管理产品和设备的用户分配该权限\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1639644090000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"menuIds\":[1,107,2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2136,2044,2137,2045,2138,2046,2139,2047,2048,2140,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,1036,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:15:33');
INSERT INTO `sys_oper_log` VALUES (315, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"管理产品和设备的用户分配该权限\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1639644090000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"menuIds\":[1,107,2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2136,2044,2137,2045,2138,2046,2139,2047,2048,2140,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,1036,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:16:12');
INSERT INTO `sys_oper_log` VALUES (316, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":3,\"admin\":false,\"remark\":\"设备的最终用户，只能管理设备\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"3\",\"deptCheckStrictly\":true,\"createTime\":1639575378000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"general\",\"roleName\":\"普通用户\",\"menuIds\":[2000,1,107,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,1036,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:16:34');
INSERT INTO `sys_oper_log` VALUES (317, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":5,\"admin\":false,\"remark\":\"普通管理员\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"5\",\"deptCheckStrictly\":true,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"manager\",\"roleName\":\"管理员\",\"menuIds\":[],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:21:33');
INSERT INTO `sys_oper_log` VALUES (318, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"管理产品和设备的用户分配该权限\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1639644090000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"menuIds\":[1,107,2129,2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2136,2044,2137,2045,2138,2046,2139,2047,2048,2140,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:25:39');
INSERT INTO `sys_oper_log` VALUES (319, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":3,\"admin\":false,\"remark\":\"设备的最终用户，只能管理设备\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"3\",\"deptCheckStrictly\":true,\"createTime\":1639575378000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"general\",\"roleName\":\"普通用户\",\"menuIds\":[2000,1,107,2129,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 17:25:51');
INSERT INTO `sys_oper_log` VALUES (320, '通用物模型', 1, 'com.ruoyi.iot.controller.ThingsModelTemplateController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"tenant-one\",\"params\":{},\"templateId\":21,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"integer\\\",\\\"min\\\":1,\\\"max\\\":100,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":1}\",\"createBy\":\"wumei-t1\",\"isMonitor\":1,\"tenantName\":\"wumei-t1\",\"createTime\":1654346967040,\"datatype\":\"integer\",\"templateName\":\"租户一的物模型\",\"isTop\":1,\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 20:49:27');
INSERT INTO `sys_oper_log` VALUES (321, '产品分类', 1, 'com.ruoyi.iot.controller.CategoryController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/category', '127.0.0.1', '内网IP', '{\"orderNum\":8,\"params\":{},\"categoryName\":\"租户一分类\",\"tenantName\":\"wumei-t1\",\"createTime\":1654346997988,\"tenantId\":2,\"categoryId\":11}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 20:49:58');
INSERT INTO `sys_oper_log` VALUES (322, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K88EA20R4RY9P74W\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"租户一分类\",\"productName\":\"租户一产品\",\"networkMethod\":1,\"tenantName\":\"wumei-t1\",\"vertificateMethod\":3,\"mqttPassword\":\"P7L07EE939F0153O\",\"deviceType\":1,\"productId\":8,\"params\":{},\"isAuthorize\":0,\"createTime\":1654348579532,\"tenantId\":2,\"categoryId\":11,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":11,\"categoryName\":\"租户一分类\",\"createTime\":1654348579532,\"deviceType\":1,\"isAuthorize\":0,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"P7L07EE939F0153O\",\"mqttSecret\":\"K88EA20R4RY9P74W\",\"networkMethod\":1,\"params\":{},\"productId\":8,\"productName\":\"租户一产品\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"vertificateMethod\":3}}', 0, NULL, '2022-06-04 21:16:19');
INSERT INTO `sys_oper_log` VALUES (323, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"6\",\"menuName\":\"产品授权码查询\",\"params\":{},\"parentId\":2043,\"isCache\":\"0\",\"path\":\"#\",\"component\":\"\",\"children\":[],\"createTime\":1649668673000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2136,\"menuType\":\"F\",\"perms\":\"iot:authorize:query\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 21:21:40');
INSERT INTO `sys_oper_log` VALUES (324, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"7\",\"menuName\":\"产品授权码新增\",\"params\":{},\"parentId\":2043,\"isCache\":\"0\",\"path\":\"#\",\"component\":\"\",\"children\":[],\"createTime\":1649668673000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2137,\"menuType\":\"F\",\"perms\":\"iot:authorize:add\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 21:22:00');
INSERT INTO `sys_oper_log` VALUES (325, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"8\",\"menuName\":\"产品授权码修改\",\"params\":{},\"parentId\":2043,\"isCache\":\"0\",\"path\":\"#\",\"component\":\"\",\"children\":[],\"createTime\":1649668673000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2138,\"menuType\":\"F\",\"perms\":\"iot:authorize:edit\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 21:22:08');
INSERT INTO `sys_oper_log` VALUES (326, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"9\",\"menuName\":\"产品授权码删除\",\"params\":{},\"parentId\":2043,\"isCache\":\"0\",\"path\":\"#\",\"component\":\"\",\"children\":[],\"createTime\":1649668673000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2139,\"menuType\":\"F\",\"perms\":\"iot:authorize:remove\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 21:22:26');
INSERT INTO `sys_oper_log` VALUES (327, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'wumei-t1', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":8,\"status\":2}', '{\"msg\":\"发布失败，请先添加产品的物模型\",\"code\":500}', 0, NULL, '2022-06-04 21:26:56');
INSERT INTO `sys_oper_log` VALUES (328, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t1', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":8,\"templateIds\":[21,2,3,5,6],\"productName\":\"租户一产品\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-04 21:27:24');
INSERT INTO `sys_oper_log` VALUES (329, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'wumei-t1', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":8,\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 21:27:45');
INSERT INTO `sys_oper_log` VALUES (330, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":8,\"filePath\":\"/profile/iot/2/2022-0604-213727.bin\",\"firmwareId\":5,\"remark\":\"租户一固件\",\"params\":{},\"version\":0.1,\"productName\":\"租户一产品\",\"tenantName\":\"wumei-t1\",\"createTime\":1654349857776,\"firmwareName\":\"租户一产品固件\",\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 21:37:37');
INSERT INTO `sys_oper_log` VALUES (331, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":1,\"groupId\":12,\"params\":{},\"userName\":\"wumei-t1\",\"userId\":2,\"groupName\":\"租户一设备分组\",\"createTime\":1654349883560}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 21:38:03');
INSERT INTO `sys_oper_log` VALUES (332, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"remark\":\"租户一设备\",\"deviceId\":10,\"deviceName\":\"租户一设备\",\"productName\":\"租户一产品\",\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1.0,\"rssi\":0,\"serialNumber\":\"D970EJ1ZT5HO37ML\",\"productId\":8,\"params\":{},\"userName\":\"wumei-t1\",\"userId\":2,\"createTime\":1654349960020,\"isCustomLocation\":1,\"tenantId\":2,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654349960020,\"deviceId\":10,\"deviceName\":\"租户一设备\",\"firmwareVersion\":1.0,\"isCustomLocation\":1,\"isShadow\":1,\"params\":{},\"productId\":8,\"productName\":\"租户一产品\",\"remark\":\"租户一设备\",\"rssi\":0,\"serialNumber\":\"D970EJ1ZT5HO37ML\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":2,\"userName\":\"wumei-t1\"}}', 0, NULL, '2022-06-04 21:39:20');
INSERT INTO `sys_oper_log` VALUES (333, '通用物模型', 1, 'com.ruoyi.iot.controller.ThingsModelTemplateController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"tenant-t2\",\"params\":{},\"templateId\":22,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"integer\\\",\\\"min\\\":1,\\\"max\\\":100,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":1}\",\"createBy\":\"wumei-t2\",\"isMonitor\":1,\"tenantName\":\"wumei-t2\",\"createTime\":1654351931820,\"datatype\":\"integer\",\"templateName\":\"租户二物模型\",\"isTop\":1,\"tenantId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 22:12:11');
INSERT INTO `sys_oper_log` VALUES (334, '产品分类', 1, 'com.ruoyi.iot.controller.CategoryController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/category', '127.0.0.1', '内网IP', '{\"orderNum\":8,\"params\":{},\"categoryName\":\"租户二分类\",\"tenantName\":\"wumei-t2\",\"createTime\":1654351955355,\"tenantId\":3,\"categoryId\":12}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 22:12:35');
INSERT INTO `sys_oper_log` VALUES (335, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"KV1BNXCTTE7R3K73\",\"mqttAccount\":\"wumei-smart\",\"remark\":\"租户二产品\",\"categoryName\":\"租户二分类\",\"productName\":\"租户二产品\",\"networkMethod\":1,\"tenantName\":\"wumei-t2\",\"vertificateMethod\":3,\"mqttPassword\":\"PK1ANYHCD6E2YDL1\",\"deviceType\":3,\"productId\":9,\"params\":{},\"isAuthorize\":1,\"createTime\":1654351998996,\"tenantId\":3,\"categoryId\":12,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":12,\"categoryName\":\"租户二分类\",\"createTime\":1654351998996,\"deviceType\":3,\"isAuthorize\":1,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"PK1ANYHCD6E2YDL1\",\"mqttSecret\":\"KV1BNXCTTE7R3K73\",\"networkMethod\":1,\"params\":{},\"productId\":9,\"productName\":\"租户二产品\",\"remark\":\"租户二产品\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"vertificateMethod\":3}}', 0, NULL, '2022-06-04 22:13:19');
INSERT INTO `sys_oper_log` VALUES (336, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'wumei-t2', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":10,\"productId\":9}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 22:13:28');
INSERT INTO `sys_oper_log` VALUES (337, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t2', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":9,\"templateIds\":[22,1,8,7,6],\"productName\":\"租户二产品\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-04 22:14:54');
INSERT INTO `sys_oper_log` VALUES (338, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'wumei-t2', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":9,\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 22:15:14');
INSERT INTO `sys_oper_log` VALUES (339, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":9,\"filePath\":\"/profile/iot/3/2022-0604-221638.bin\",\"firmwareId\":6,\"params\":{},\"version\":1.0,\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"createTime\":1654352200753,\"firmwareName\":\"租户二固件\",\"tenantId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 22:16:40');
INSERT INTO `sys_oper_log` VALUES (340, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'wumei-t2', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":9,\"filePath\":\"/profile/iot/3/2022-0604-221946.bin\",\"firmwareId\":6,\"updateTime\":1654352388469,\"params\":{},\"version\":1,\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"createTime\":1654352201000,\"firmwareName\":\"租户二固件\",\"tenantId\":3,\"isSys\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 22:19:48');
INSERT INTO `sys_oper_log` VALUES (341, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":1,\"groupId\":13,\"params\":{},\"userName\":\"wumei-t2\",\"userId\":3,\"groupName\":\"租户二分组\",\"createTime\":1654352556767}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 22:22:36');
INSERT INTO `sys_oper_log` VALUES (342, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"remark\":\"租户二设备\",\"deviceId\":11,\"deviceName\":\"租户二设备\",\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1.0,\"rssi\":0,\"serialNumber\":\"DT5N99G36W4OI27J\",\"productId\":9,\"params\":{},\"userName\":\"wumei-t2\",\"userId\":3,\"createTime\":1654352609035,\"isCustomLocation\":1,\"tenantId\":3,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654352609035,\"deviceId\":11,\"deviceName\":\"租户二设备\",\"firmwareVersion\":1.0,\"isCustomLocation\":1,\"isShadow\":1,\"params\":{},\"productId\":9,\"productName\":\"租户二产品\",\"remark\":\"租户二设备\",\"rssi\":0,\"serialNumber\":\"DT5N99G36W4OI27J\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":3,\"userName\":\"wumei-t2\"}}', 0, NULL, '2022-06-04 22:23:29');
INSERT INTO `sys_oper_log` VALUES (343, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-t2', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[11],\"groupId\":13}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-04 22:24:21');
INSERT INTO `sys_oper_log` VALUES (344, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"deviceId\":12,\"deviceName\":\"租户二设备B\",\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1.0,\"rssi\":0,\"serialNumber\":\"D212UZD6M5IQ6V7U\",\"productId\":9,\"params\":{},\"userName\":\"wumei-t2\",\"userId\":3,\"createTime\":1654355816955,\"isCustomLocation\":1,\"tenantId\":3,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654355816955,\"deviceId\":12,\"deviceName\":\"租户二设备B\",\"firmwareVersion\":1.0,\"isCustomLocation\":1,\"isShadow\":0,\"params\":{},\"productId\":9,\"productName\":\"租户二产品\",\"rssi\":0,\"serialNumber\":\"D212UZD6M5IQ6V7U\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":3,\"userName\":\"wumei-t2\"}}', 0, NULL, '2022-06-04 23:16:57');
INSERT INTO `sys_oper_log` VALUES (345, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"latitude\":39.54,\"deviceId\":13,\"deviceName\":\"租户二设备B\",\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":116.23,\"rssi\":0,\"serialNumber\":\"D6S83886S5Z64EC8\",\"productId\":9,\"params\":{},\"userName\":\"wumei-t2\",\"userId\":3,\"createTime\":1654355998210,\"isCustomLocation\":1,\"tenantId\":3,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654355998210,\"deviceId\":13,\"deviceName\":\"租户二设备B\",\"firmwareVersion\":1,\"isCustomLocation\":1,\"isShadow\":1,\"latitude\":39.54,\"longitude\":116.23,\"params\":{},\"productId\":9,\"productName\":\"租户二产品\",\"rssi\":0,\"serialNumber\":\"D6S83886S5Z64EC8\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":3,\"userName\":\"wumei-t2\"}}', 0, NULL, '2022-06-04 23:19:58');
INSERT INTO `sys_oper_log` VALUES (346, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"latitude\":36.30525321759615,\"deviceId\":14,\"deviceName\":\"租户二设备B\",\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":120.08644833876961,\"rssi\":0,\"serialNumber\":\"DAN2X14D5NTZ9QB5\",\"productId\":9,\"params\":{},\"userName\":\"wumei-t2\",\"userId\":3,\"createTime\":1654356448050,\"isCustomLocation\":1,\"tenantId\":3,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654356448050,\"deviceId\":14,\"deviceName\":\"租户二设备B\",\"firmwareVersion\":1,\"isCustomLocation\":1,\"isShadow\":1,\"latitude\":36.30525321759615,\"longitude\":120.08644833876961,\"params\":{},\"productId\":9,\"productName\":\"租户二产品\",\"rssi\":0,\"serialNumber\":\"DAN2X14D5NTZ9QB5\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":3,\"userName\":\"wumei-t2\"}}', 0, NULL, '2022-06-04 23:27:28');
INSERT INTO `sys_oper_log` VALUES (347, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'wumei-t2', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":9,\"filePath\":\"/dev-api/iot/tool/download?fileName=/profile/iot/3/2022-0605-000458.bin\",\"firmwareId\":6,\"updateTime\":1654358701602,\"params\":{},\"version\":1,\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"createTime\":1654352201000,\"firmwareName\":\"租户二固件\",\"tenantId\":3,\"isSys\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 00:05:01');
INSERT INTO `sys_oper_log` VALUES (348, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'wumei-t2', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":9,\"filePath\":\"/profile/iot/3/2022-0605-000620.bin\",\"firmwareId\":6,\"updateTime\":1654358781505,\"params\":{},\"version\":1,\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"createTime\":1654352201000,\"firmwareName\":\"租户二固件\",\"tenantId\":3,\"isSys\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 00:06:21');
INSERT INTO `sys_oper_log` VALUES (349, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"KZQ34SN41UW10LYB\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"8\",\"networkMethod\":1,\"tenantName\":\"wumei-t2\",\"vertificateMethod\":3,\"mqttPassword\":\"P3K376XOZDCFK9HC\",\"deviceType\":1,\"productId\":10,\"params\":{},\"isAuthorize\":0,\"imgUrl\":\"/iot/tool/download?fileName=/profile/iot/3/2022-0605-000707.jpg\",\"createTime\":1654358829219,\"tenantId\":3,\"categoryId\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":1,\"categoryName\":\"电工照明\",\"createTime\":1654358829219,\"deviceType\":1,\"imgUrl\":\"/iot/tool/download?fileName=/profile/iot/3/2022-0605-000707.jpg\",\"isAuthorize\":0,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"P3K376XOZDCFK9HC\",\"mqttSecret\":\"KZQ34SN41UW10LYB\",\"networkMethod\":1,\"params\":{},\"productId\":10,\"productName\":\"8\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"vertificateMethod\":3}}', 0, NULL, '2022-06-05 00:07:09');
INSERT INTO `sys_oper_log` VALUES (350, '字典类型', 3, 'com.ruoyi.web.controller.system.SysDictDataController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dict/data/121', '127.0.0.1', '内网IP', '{dictCodes=121}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 00:14:30');
INSERT INTO `sys_oper_log` VALUES (351, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"1\",\"listClass\":\"default\",\"dictSort\":1,\"params\":{},\"dictType\":\"iot_vertificate_method\",\"dictLabel\":\"简单认证\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1639897996000,\"dictCode\":119,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 00:14:48');
INSERT INTO `sys_oper_log` VALUES (352, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"2\",\"listClass\":\"default\",\"dictSort\":2,\"params\":{},\"dictType\":\"iot_vertificate_method\",\"dictLabel\":\"加密认证\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1639898006000,\"dictCode\":120,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 00:14:57');
INSERT INTO `sys_oper_log` VALUES (353, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"3\",\"listClass\":\"default\",\"dictSort\":3,\"params\":{},\"dictType\":\"iot_vertificate_method\",\"dictLabel\":\"简单+加密\",\"createBy\":\"admin\",\"default\":false,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 00:15:46');
INSERT INTO `sys_oper_log` VALUES (354, '字典类型', 2, 'com.ruoyi.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":1639897908000,\"updateBy\":\"admin\",\"dictName\":\"认证方式\",\"remark\":\"1=简单认证、2=加密认证、3=简单+加密\",\"dictId\":106,\"params\":{},\"dictType\":\"iot_vertificate_method\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 12:57:02');
INSERT INTO `sys_oper_log` VALUES (355, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"KZQ34SN41UW10LYB\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"8\",\"networkMethod\":1,\"tenantName\":\"wumei-t2\",\"vertificateMethod\":3,\"mqttPassword\":\"P3K376XOZDCFK9HC\",\"deviceType\":1,\"productId\":10,\"updateTime\":1654410636179,\"params\":{},\"isAuthorize\":0,\"imgUrl\":\"/profile/iot/1/2022-0605-143032.jpg\",\"createTime\":1654358829000,\"tenantId\":3,\"categoryId\":1,\"isSys\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 14:30:35');
INSERT INTO `sys_oper_log` VALUES (356, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":2,\"filePath\":\"/profile/iot/1/2022-0605-143507.bin\",\"firmwareId\":4,\"remark\":\"1\",\"updateTime\":1654410910386,\"params\":{},\"version\":1,\"productName\":\"ESP8266产品示例\",\"tenantName\":\"admin\",\"createTime\":1650012921000,\"firmwareName\":\"11\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 14:35:09');
INSERT INTO `sys_oper_log` VALUES (357, '产品固件', 3, 'com.ruoyi.iot.controller.FirmwareController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/firmware/6', '127.0.0.1', '内网IP', '{firmwareIds=6}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 14:46:59');
INSERT INTO `sys_oper_log` VALUES (358, '产品固件', 3, 'com.ruoyi.iot.controller.FirmwareController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/firmware/5', '127.0.0.1', '内网IP', '{firmwareIds=5}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 14:47:02');
INSERT INTO `sys_oper_log` VALUES (359, '产品固件', 3, 'com.ruoyi.iot.controller.FirmwareController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/firmware/4', '127.0.0.1', '内网IP', '{firmwareIds=4}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 14:47:05');
INSERT INTO `sys_oper_log` VALUES (360, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'wumei-t2', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"KZQ34SN41UW10LYB\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"8\",\"networkMethod\":1,\"tenantName\":\"wumei-t2\",\"vertificateMethod\":3,\"mqttPassword\":\"P3K376XOZDCFK9HC\",\"deviceType\":1,\"productId\":10,\"updateTime\":1654411694358,\"params\":{},\"isAuthorize\":0,\"imgUrl\":\"/profile/iot/3/2022-0605-144812.jpg\",\"createTime\":1654358829000,\"tenantId\":3,\"categoryId\":1,\"isSys\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 14:48:13');
INSERT INTO `sys_oper_log` VALUES (361, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":9,\"filePath\":\"/profile/iot/3/2022-0605-144858.bin\",\"firmwareId\":7,\"params\":{},\"version\":1.0,\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"createTime\":1654411743657,\"firmwareName\":\"租户一固件\",\"tenantId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 14:49:02');
INSERT INTO `sys_oper_log` VALUES (362, '产品', 3, 'com.ruoyi.iot.controller.ProductController.remove()', 'DELETE', 1, 'wumei-t2', NULL, '/iot/product/10', '127.0.0.1', '内网IP', '{productIds=10}', '{\"msg\":\"删除成功\",\"code\":200}', 0, NULL, '2022-06-05 14:49:14');
INSERT INTO `sys_oper_log` VALUES (363, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-u1', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":1,\"groupId\":14,\"params\":{},\"userName\":\"wumei-u1\",\"userId\":4,\"groupName\":\"用户一分组\",\"createTime\":1654415865911}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 15:57:45');
INSERT INTO `sys_oper_log` VALUES (364, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-u1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":31.295895591260056,\"deviceId\":15,\"deviceName\":\"用户一设备\",\"productName\":\"租户一产品\",\"tenantName\":\"wumei-u1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":102.56077360708284,\"rssi\":0,\"serialNumber\":\"DGQN1159GSW745BA\",\"productId\":8,\"params\":{},\"userName\":\"wumei-u1\",\"networkAddress\":\"中国\",\"userId\":4,\"createTime\":1654418398983,\"isCustomLocation\":1,\"tenantId\":4,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654418398983,\"deviceId\":15,\"deviceName\":\"用户一设备\",\"firmwareVersion\":1,\"isCustomLocation\":1,\"isShadow\":1,\"latitude\":31.295895591260056,\"longitude\":102.56077360708284,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":8,\"productName\":\"租户一产品\",\"rssi\":0,\"serialNumber\":\"DGQN1159GSW745BA\",\"status\":1,\"tenantId\":4,\"tenantName\":\"wumei-u1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":4,\"userName\":\"wumei-u1\"}}', 0, NULL, '2022-06-05 16:39:58');
INSERT INTO `sys_oper_log` VALUES (365, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-u1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":31.2195120392892,\"deviceId\":16,\"deviceName\":\"用户一设备\",\"productName\":\"租户一产品\",\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":114.02396028323918,\"rssi\":0,\"serialNumber\":\"DP3S664G1E5666C6\",\"productId\":8,\"params\":{},\"userName\":\"wumei-u1\",\"networkAddress\":\"中国\",\"userId\":4,\"createTime\":1654420448574,\"isCustomLocation\":1,\"tenantId\":2,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654420448574,\"deviceId\":16,\"deviceName\":\"用户一设备\",\"firmwareVersion\":1,\"isCustomLocation\":1,\"isShadow\":1,\"latitude\":31.2195120392892,\"longitude\":114.02396028323918,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":8,\"productName\":\"租户一产品\",\"rssi\":0,\"serialNumber\":\"DP3S664G1E5666C6\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":4,\"userName\":\"wumei-u1\"}}', 0, NULL, '2022-06-05 17:14:08');
INSERT INTO `sys_oper_log` VALUES (366, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[16],\"groupId\":14}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 17:18:09');
INSERT INTO `sys_oper_log` VALUES (367, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":1,\"groupId\":15,\"params\":{},\"userName\":\"wumei-u2\",\"userId\":5,\"groupName\":\"用户U2分组\",\"createTime\":1654420927932}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 17:22:07');
INSERT INTO `sys_oper_log` VALUES (368, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":33.652577342624205,\"deviceId\":17,\"deviceName\":\"用户U2设备\",\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":103.97339062320704,\"rssi\":0,\"serialNumber\":\"DD75V947J3G5883T\",\"productId\":9,\"params\":{},\"userName\":\"wumei-u2\",\"networkAddress\":\"中国\",\"userId\":5,\"createTime\":1654420968242,\"isCustomLocation\":1,\"tenantId\":3,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654420968242,\"deviceId\":17,\"deviceName\":\"用户U2设备\",\"firmwareVersion\":1,\"isCustomLocation\":1,\"isShadow\":1,\"latitude\":33.652577342624205,\"longitude\":103.97339062320704,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":9,\"productName\":\"租户二产品\",\"rssi\":0,\"serialNumber\":\"DD75V947J3G5883T\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":5,\"userName\":\"wumei-u2\"}}', 0, NULL, '2022-06-05 17:22:47');
INSERT INTO `sys_oper_log` VALUES (369, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u2', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[17],\"groupId\":15}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-05 17:24:11');
INSERT INTO `sys_oper_log` VALUES (370, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":30.241390223646626,\"deviceId\":18,\"deviceName\":\"租户T1设备\",\"productName\":\"租户一产品\",\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":102.90677960839741,\"rssi\":0,\"serialNumber\":\"D65L52QSY78OCDN0\",\"productId\":8,\"params\":{},\"userName\":\"wumei-t1\",\"networkAddress\":\"中国\",\"userId\":2,\"createTime\":1654421261070,\"isCustomLocation\":1,\"tenantId\":2,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654421261070,\"deviceId\":18,\"deviceName\":\"租户T1设备\",\"firmwareVersion\":1,\"isCustomLocation\":1,\"isShadow\":0,\"latitude\":30.241390223646626,\"longitude\":102.90677960839741,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":8,\"productName\":\"租户一产品\",\"rssi\":0,\"serialNumber\":\"D65L52QSY78OCDN0\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":2,\"userName\":\"wumei-t1\"}}', 0, NULL, '2022-06-05 17:27:40');
INSERT INTO `sys_oper_log` VALUES (371, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":32.742869764774554,\"deviceId\":19,\"deviceName\":\"租户U2设备\",\"productName\":\"租户二产品\",\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":114.15663166742073,\"rssi\":0,\"serialNumber\":\"D8WUQ5CP661836E5\",\"productId\":9,\"params\":{},\"userName\":\"wumei-t2\",\"networkAddress\":\"中国\",\"userId\":3,\"createTime\":1654421367986,\"isCustomLocation\":1,\"tenantId\":3,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654421367986,\"deviceId\":19,\"deviceName\":\"租户U2设备\",\"firmwareVersion\":1,\"isCustomLocation\":1,\"isShadow\":1,\"latitude\":32.742869764774554,\"longitude\":114.15663166742073,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":9,\"productName\":\"租户二产品\",\"rssi\":0,\"serialNumber\":\"D8WUQ5CP661836E5\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":3,\"userName\":\"wumei-t2\"}}', 0, NULL, '2022-06-05 17:29:27');
INSERT INTO `sys_oper_log` VALUES (372, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'admin', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[19],\"groupId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-06 14:30:28');
INSERT INTO `sys_oper_log` VALUES (373, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'admin', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[19,18],\"groupId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-06 14:58:56');
INSERT INTO `sys_oper_log` VALUES (374, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":33.49306858300675,\"deviceId\":20,\"deviceName\":\"租户U1设备B\",\"productName\":\"租户一产品\",\"locationWay\":1,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":110.98895783890025,\"rssi\":0,\"serialNumber\":\"D2339ZW23DF96EX7\",\"productId\":8,\"params\":{},\"userName\":\"wumei-t1\",\"networkAddress\":\"中国\",\"userId\":2,\"createTime\":1654501548987,\"tenantId\":2,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654501548987,\"deviceId\":20,\"deviceName\":\"租户U1设备B\",\"firmwareVersion\":1,\"isShadow\":1,\"latitude\":33.49306858300675,\"locationWay\":1,\"longitude\":110.98895783890025,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":8,\"productName\":\"租户一产品\",\"rssi\":0,\"serialNumber\":\"D2339ZW23DF96EX7\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"tenant-one\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":2,\"userName\":\"wumei-t1\"}}', 0, NULL, '2022-06-06 15:45:49');
INSERT INTO `sys_oper_log` VALUES (375, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'admin', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[20,18],\"groupId\":12}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-06 15:47:14');
INSERT INTO `sys_oper_log` VALUES (376, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'admin', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[20,18],\"groupId\":12}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-06 15:51:17');
INSERT INTO `sys_oper_log` VALUES (377, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'admin', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[19],\"groupId\":13}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-06 15:51:34');
INSERT INTO `sys_oper_log` VALUES (378, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/20', '127.0.0.1', '内网IP', '{deviceIds=20}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:35:57');
INSERT INTO `sys_oper_log` VALUES (379, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/19', '127.0.0.1', '内网IP', '{deviceIds=19}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:36:03');
INSERT INTO `sys_oper_log` VALUES (380, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/18', '127.0.0.1', '内网IP', '{deviceIds=18}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:36:07');
INSERT INTO `sys_oper_log` VALUES (381, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/17', '127.0.0.1', '内网IP', '{deviceIds=17}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:36:12');
INSERT INTO `sys_oper_log` VALUES (382, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/16', '127.0.0.1', '内网IP', '{deviceIds=16}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:36:17');
INSERT INTO `sys_oper_log` VALUES (383, '分组', 3, 'com.ruoyi.iot.controller.GroupController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/group/1', '127.0.0.1', '内网IP', '{groupIds=1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:52:07');
INSERT INTO `sys_oper_log` VALUES (384, '分组', 3, 'com.ruoyi.iot.controller.GroupController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/group/12', '127.0.0.1', '内网IP', '{groupIds=12}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:52:11');
INSERT INTO `sys_oper_log` VALUES (385, '分组', 3, 'com.ruoyi.iot.controller.GroupController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/group/13', '127.0.0.1', '内网IP', '{groupIds=13}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:52:15');
INSERT INTO `sys_oper_log` VALUES (386, '分组', 3, 'com.ruoyi.iot.controller.GroupController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/group/14', '127.0.0.1', '内网IP', '{groupIds=14}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:52:19');
INSERT INTO `sys_oper_log` VALUES (387, '分组', 3, 'com.ruoyi.iot.controller.GroupController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/group/15', '127.0.0.1', '内网IP', '{groupIds=15}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:52:23');
INSERT INTO `sys_oper_log` VALUES (388, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'admin', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":9,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:52:47');
INSERT INTO `sys_oper_log` VALUES (389, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'admin', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":8,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:52:51');
INSERT INTO `sys_oper_log` VALUES (390, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'admin', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":2,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:52:56');
INSERT INTO `sys_oper_log` VALUES (391, '产品', 3, 'com.ruoyi.iot.controller.ProductController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/product/9', '127.0.0.1', '内网IP', '{productIds=9}', '{\"msg\":\"删除成功\",\"code\":200}', 0, NULL, '2022-06-07 12:53:20');
INSERT INTO `sys_oper_log` VALUES (392, '产品', 3, 'com.ruoyi.iot.controller.ProductController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/product/8', '127.0.0.1', '内网IP', '{productIds=8}', '{\"msg\":\"删除成功\",\"code\":200}', 0, NULL, '2022-06-07 12:54:05');
INSERT INTO `sys_oper_log` VALUES (393, '产品', 3, 'com.ruoyi.iot.controller.ProductController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/product/2', '127.0.0.1', '内网IP', '{productIds=2}', '{\"msg\":\"删除成功\",\"code\":200}', 0, NULL, '2022-06-07 12:54:09');
INSERT INTO `sys_oper_log` VALUES (394, '产品分类', 3, 'com.ruoyi.iot.controller.CategoryController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/category/11', '127.0.0.1', '内网IP', '{categoryIds=11}', '{\"msg\":\"删除成功\",\"code\":200}', 0, NULL, '2022-06-07 12:54:27');
INSERT INTO `sys_oper_log` VALUES (395, '产品分类', 3, 'com.ruoyi.iot.controller.CategoryController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/category/12', '127.0.0.1', '内网IP', '{categoryIds=12}', '{\"msg\":\"删除成功\",\"code\":200}', 0, NULL, '2022-06-07 12:54:31');
INSERT INTO `sys_oper_log` VALUES (396, '通用物模型', 3, 'com.ruoyi.iot.controller.ThingsModelTemplateController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/template/22', '127.0.0.1', '内网IP', '{templateIds=22}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:54:40');
INSERT INTO `sys_oper_log` VALUES (397, '通用物模型', 3, 'com.ruoyi.iot.controller.ThingsModelTemplateController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/template/21', '127.0.0.1', '内网IP', '{templateIds=21}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 12:54:43');
INSERT INTO `sys_oper_log` VALUES (398, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K4DJ9656JZFHT404\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"管理员产品\",\"networkMethod\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"PA53X801Q3381832\",\"deviceType\":1,\"productId\":11,\"params\":{},\"isAuthorize\":0,\"createTime\":1654579329180,\"tenantId\":1,\"categoryId\":1,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":1,\"categoryName\":\"电工照明\",\"createTime\":1654579329180,\"deviceType\":1,\"isAuthorize\":0,\"isSys\":1,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"PA53X801Q3381832\",\"mqttSecret\":\"K4DJ9656JZFHT404\",\"networkMethod\":1,\"params\":{},\"productId\":11,\"productName\":\"管理员产品\",\"status\":1,\"tenantId\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3}}', 0, NULL, '2022-06-07 13:22:09');
INSERT INTO `sys_oper_log` VALUES (399, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K4DJ9656JZFHT404\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"管理员产品\",\"networkMethod\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"PA53X801Q3381832\",\"deviceType\":1,\"productId\":11,\"updateTime\":1654582849010,\"params\":{},\"isAuthorize\":1,\"createTime\":1654579329000,\"tenantId\":1,\"categoryId\":1,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 14:20:49');
INSERT INTO `sys_oper_log` VALUES (400, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K4DJ9656JZFHT404\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"管理员产品\",\"networkMethod\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"PA53X801Q3381832\",\"deviceType\":1,\"productId\":11,\"updateTime\":1654582859168,\"params\":{},\"isAuthorize\":0,\"createTime\":1654579329000,\"tenantId\":1,\"categoryId\":1,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 14:20:59');
INSERT INTO `sys_oper_log` VALUES (401, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K4DJ9656JZFHT404\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"管理员产品\",\"networkMethod\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"PA53X801Q3381832\",\"deviceType\":1,\"productId\":11,\"updateTime\":1654582892776,\"params\":{},\"isAuthorize\":1,\"createTime\":1654579329000,\"tenantId\":1,\"categoryId\":1,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 14:21:32');
INSERT INTO `sys_oper_log` VALUES (402, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K4DJ9656JZFHT404\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"管理员产品\",\"networkMethod\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"PA53X801Q3381832\",\"deviceType\":1,\"productId\":11,\"updateTime\":1654582902000,\"params\":{},\"isAuthorize\":0,\"createTime\":1654579329000,\"tenantId\":1,\"categoryId\":1,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 14:21:42');
INSERT INTO `sys_oper_log` VALUES (403, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'admin', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":11,\"templateIds\":[12,1,2,5,6],\"productName\":\"管理员产品\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-07 14:24:26');
INSERT INTO `sys_oper_log` VALUES (404, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K4DJ9656JZFHT404\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"管理员产品\",\"networkMethod\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"PA53X801Q3381832\",\"deviceType\":1,\"productId\":11,\"updateTime\":1654583145486,\"params\":{},\"isAuthorize\":1,\"createTime\":1654579329000,\"tenantId\":1,\"categoryId\":1,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 14:25:45');
INSERT INTO `sys_oper_log` VALUES (405, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'admin', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":10,\"productId\":11}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 14:26:56');
INSERT INTO `sys_oper_log` VALUES (406, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":11,\"filePath\":\"/profile/iot/1/2022-0607-151028.bin\",\"firmwareId\":8,\"params\":{},\"version\":1,\"productName\":\"管理员产品\",\"tenantName\":\"admin\",\"createTime\":1654585829338,\"firmwareName\":\"测试固件\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 15:10:29');
INSERT INTO `sys_oper_log` VALUES (407, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"alert\",\"orderNum\":\"7\",\"menuName\":\"设备告警\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"alertLog\",\"component\":\"iot/alertLog/index\",\"children\":[],\"createTime\":1642065375000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2067,\"menuType\":\"C\",\"perms\":\"iot:alertLog:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 16:46:10');
INSERT INTO `sys_oper_log` VALUES (408, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"授权码状态\",\"remark\":\"1=未分配，2=使用中\",\"params\":{},\"dictType\":\"iot_auth_status\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 17:38:57');
INSERT INTO `sys_oper_log` VALUES (409, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"1\",\"listClass\":\"info\",\"dictSort\":1,\"params\":{},\"dictType\":\"iot_auth_status\",\"dictLabel\":\"未分配\",\"createBy\":\"admin\",\"default\":false,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 17:39:22');
INSERT INTO `sys_oper_log` VALUES (410, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"2\",\"listClass\":\"success\",\"dictSort\":2,\"params\":{},\"dictType\":\"iot_auth_status\",\"dictLabel\":\"使用中\",\"createBy\":\"admin\",\"default\":false,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 17:40:01');
INSERT INTO `sys_oper_log` VALUES (411, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"1\",\"listClass\":\"info\",\"dictSort\":1,\"params\":{},\"dictType\":\"iot_auth_status\",\"dictLabel\":\"未使用\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1654594762000,\"dictCode\":163,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 17:40:10');
INSERT INTO `sys_oper_log` VALUES (412, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"1\",\"productId\":11,\"remark\":\"1\",\"updateTime\":1654595251661,\"delFlag\":\"0\",\"params\":{},\"userName\":\"1\",\"deviceId\":1,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":134,\"createTime\":1654583217000,\"updateBy\":\"\",\"authorizeCode\":\"5E4D4720B15046FE96C27ACC42FC5151\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 17:47:32');
INSERT INTO `sys_oper_log` VALUES (413, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'admin', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":1,\"productId\":11}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 17:47:47');
INSERT INTO `sys_oper_log` VALUES (414, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'admin', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":1,\"productId\":11}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 17:49:28');
INSERT INTO `sys_oper_log` VALUES (415, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'admin', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":10,\"productId\":11}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Column count doesn\'t match value count at row 1\r\n### The error may exist in file [D:\\project\\gitee\\wumei-smart\\springboot\\wumei-iot\\target\\classes\\mapper\\iot\\ProductAuthorizeMapper.xml]\r\n### The error may involve com.ruoyi.iot.mapper.ProductAuthorizeMapper.insertBatchAuthorize-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into iot_product_authorize (authorize_code,product_id,create_by,create_time,status)         values                         ( ?,?,?,? )                         , ( ?,?,?,? )                         , ( ?,?,?,? )                         , ( ?,?,?,? )                         , ( ?,?,?,? )                         , ( ?,?,?,? )                         , ( ?,?,?,? )                         , ( ?,?,?,? )                         , ( ?,?,?,? )                         , ( ?,?,?,? )\r\n### Cause: java.sql.SQLException: Column count doesn\'t match value count at row 1\n; bad SQL grammar []; nested exception is java.sql.SQLException: Column count doesn\'t match value count at row 1', '2022-06-07 17:53:16');
INSERT INTO `sys_oper_log` VALUES (416, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'admin', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":10,\"productId\":11}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 17:55:21');
INSERT INTO `sys_oper_log` VALUES (417, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"1\",\"productId\":11,\"remark\":\"1\",\"updateTime\":1654595730007,\"delFlag\":\"0\",\"params\":{},\"userName\":\"1\",\"deviceId\":1,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":146,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"5A7A6FE3019F4349A4EB1FD53258B594\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 17:55:30');
INSERT INTO `sys_oper_log` VALUES (418, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"dictValue\":\"2\",\"listClass\":\"success\",\"dictSort\":2,\"params\":{},\"dictType\":\"iot_auth_status\",\"dictLabel\":\"已使用\",\"createBy\":\"admin\",\"default\":false,\"isDefault\":\"N\",\"createTime\":1654594801000,\"dictCode\":164,\"updateBy\":\"admin\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 23:21:50');
INSERT INTO `sys_oper_log` VALUES (419, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":11,\"filePath\":\"/profile/iot/1/2022-0607-151028.bin\",\"firmwareId\":8,\"updateTime\":1654616431413,\"params\":{},\"version\":1.0,\"productName\":\"管理员产品\",\"tenantName\":\"admin\",\"createTime\":1654585829000,\"firmwareName\":\"测试固件\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 23:40:32');
INSERT INTO `sys_oper_log` VALUES (420, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":11,\"filePath\":\"/profile/iot/1/2022-0607-151028.bin\",\"firmwareId\":8,\"updateTime\":1654616481624,\"params\":{},\"version\":1.3,\"productName\":\"管理员产品\",\"tenantName\":\"admin\",\"createTime\":1654585829000,\"firmwareName\":\"测试固件\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-07 23:41:22');
INSERT INTO `sys_oper_log` VALUES (421, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":11,\"filePath\":\"/profile/iot/1/2022-0607-151028.bin\",\"firmwareId\":8,\"remark\":\"测试\",\"updateTime\":1654618959409,\"params\":{},\"version\":1.3,\"productName\":\"管理员产品\",\"tenantName\":\"admin\",\"createTime\":1654585829000,\"firmwareName\":\"测试固件\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 00:22:40');
INSERT INTO `sys_oper_log` VALUES (422, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"filePath\":\"/profile/iot/1/2022-0608-002258.bin\",\"remark\":\"测试固件2\",\"params\":{},\"version\":1,\"tenantName\":\"admin\",\"createTime\":1654618986594,\"firmwareName\":\"测试固件2\",\"tenantId\":1,\"isSys\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'product_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\project\\gitee\\wumei-smart\\springboot\\wumei-iot\\target\\classes\\mapper\\iot\\FirmwareMapper.xml]\r\n### The error may involve com.ruoyi.iot.mapper.FirmwareMapper.insertFirmware-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into iot_firmware          ( firmware_name,                                       tenant_id,             tenant_name,             is_sys,             version,             file_path,                                       create_time,                                       remark )           values ( ?,                                       ?,             ?,             ?,             ?,             ?,                                       ?,                                       ? )\r\n### Cause: java.sql.SQLException: Field \'product_id\' doesn\'t have a default value\n; Field \'product_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'product_id\' doesn\'t have a default value', '2022-06-08 00:23:07');
INSERT INTO `sys_oper_log` VALUES (423, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"filePath\":\"/profile/iot/1/2022-0608-002512.bin\",\"remark\":\"1\",\"params\":{},\"version\":1,\"tenantName\":\"admin\",\"createTime\":1654619115196,\"firmwareName\":\"1\",\"tenantId\":1,\"isSys\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'product_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\project\\gitee\\wumei-smart\\springboot\\wumei-iot\\target\\classes\\mapper\\iot\\FirmwareMapper.xml]\r\n### The error may involve com.ruoyi.iot.mapper.FirmwareMapper.insertFirmware-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into iot_firmware          ( firmware_name,                                       tenant_id,             tenant_name,             is_sys,             version,             file_path,                                       create_time,                                       remark )           values ( ?,                                       ?,             ?,             ?,             ?,             ?,                                       ?,                                       ? )\r\n### Cause: java.sql.SQLException: Field \'product_id\' doesn\'t have a default value\n; Field \'product_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'product_id\' doesn\'t have a default value', '2022-06-08 00:25:15');
INSERT INTO `sys_oper_log` VALUES (424, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":11,\"filePath\":\"/profile/iot/1/2022-0608-002729.bin\",\"firmwareId\":9,\"remark\":\"1\",\"params\":{},\"version\":1,\"productName\":\"管理员产品\",\"tenantName\":\"admin\",\"createTime\":1654619251532,\"firmwareName\":\"1\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 00:27:32');
INSERT INTO `sys_oper_log` VALUES (425, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":11,\"filePath\":\"/profile/iot/1/2022-0608-002729.bin\",\"firmwareId\":9,\"remark\":\"测试固件2\",\"updateTime\":1654619274439,\"params\":{},\"version\":1.2,\"productName\":\"管理员产品\",\"tenantName\":\"admin\",\"createTime\":1654619252000,\"firmwareName\":\"测试固件2\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 00:27:55');
INSERT INTO `sys_oper_log` VALUES (426, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K4DJ9656JZFHT404\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"管理员产品\",\"networkMethod\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"PA53X801Q3381832\",\"deviceType\":1,\"productId\":11,\"updateTime\":1654619927302,\"params\":{},\"isAuthorize\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654579329000,\"tenantId\":1,\"categoryId\":1,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 00:38:48');
INSERT INTO `sys_oper_log` VALUES (427, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'admin', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":11,\"status\":2}', '{\"msg\":\"发布失败，产品物模型的标识符必须唯一\",\"code\":500}', 0, NULL, '2022-06-08 00:47:34');
INSERT INTO `sys_oper_log` VALUES (428, '物模型', 3, 'com.ruoyi.iot.controller.ThingsModelController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/model/40', '127.0.0.1', '内网IP', '{modelIds=40}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 00:47:49');
INSERT INTO `sys_oper_log` VALUES (429, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'admin', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":11,\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 00:47:53');
INSERT INTO `sys_oper_log` VALUES (430, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":24.6542732907426,\"deviceId\":21,\"deviceName\":\"测试设备\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":110.21412818687712,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654620556819,\"tenantId\":1,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654620556819,\"deviceId\":21,\"deviceName\":\"测试设备\",\"firmwareVersion\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"isShadow\":1,\"latitude\":24.6542732907426,\"locationWay\":1,\"longitude\":110.21412818687712,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":11,\"productName\":\"管理员产品\",\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"status\":1,\"tenantId\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":1,\"userName\":\"admin\"}}', 0, NULL, '2022-06-08 00:49:18');
INSERT INTO `sys_oper_log` VALUES (431, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"deviceId\":0,\"deviceName\":\"测试重复设备编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"firmwareVersion\":1,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"params\":{},\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceId\":0,\"deviceName\":\"测试重复设备编号\",\"firmwareVersion\":1,\"isShadow\":1,\"locationWay\":1,\"params\":{},\"productId\":11,\"productName\":\"管理员产品\",\"serialNumber\":\"D6329VL54419L1Y0\",\"status\":1}}', 0, NULL, '2022-06-08 01:06:45');
INSERT INTO `sys_oper_log` VALUES (432, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"deviceId\":0,\"deviceName\":\"测试设备编号重复\",\"productName\":\"管理员产品\",\"locationWay\":1,\"firmwareVersion\":1,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"params\":{},\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceId\":0,\"deviceName\":\"测试设备编号重复\",\"firmwareVersion\":1,\"isShadow\":1,\"locationWay\":1,\"params\":{},\"productId\":11,\"productName\":\"管理员产品\",\"serialNumber\":\"D6329VL54419L1Y0\",\"status\":1}}', 0, NULL, '2022-06-08 01:07:23');
INSERT INTO `sys_oper_log` VALUES (433, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":24.654273,\"deviceId\":21,\"deviceName\":\"测试设备\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":110.214128,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654622780935,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654620557000,\"tenantId\":1,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 01:26:21');
INSERT INTO `sys_oper_log` VALUES (434, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.1925803523374,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.49965119082013,\"rssi\":0,\"serialNumber\":\"D1HN3KT67WJH\",\"productId\":11,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622947588,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654622947588,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"firmwareVersion\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"isShadow\":0,\"latitude\":36.1925803523374,\"locationWay\":1,\"longitude\":109.49965119082013,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":11,\"productName\":\"管理员产品\",\"rssi\":0,\"serialNumber\":\"D1HN3KT67WJH\",\"status\":1,\"tenantId\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":1,\"userName\":\"admin\"}}', 0, NULL, '2022-06-08 01:29:08');
INSERT INTO `sys_oper_log` VALUES (435, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D1HN3KT67WJH\",\"productId\":11,\"updateTime\":1654622963666,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 01:29:24');
INSERT INTO `sys_oper_log` VALUES (436, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654622970549,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 01:29:31');
INSERT INTO `sys_oper_log` VALUES (437, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654622974054,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 01:29:34');
INSERT INTO `sys_oper_log` VALUES (438, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D17YN9O5I800\",\"productId\":11,\"updateTime\":1654623083310,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 01:31:24');
INSERT INTO `sys_oper_log` VALUES (439, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D17YN9O5I800\",\"productId\":11,\"updateTime\":1654623119025,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 01:31:59');
INSERT INTO `sys_oper_log` VALUES (440, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\": \\\"temperature\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"humidity\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"light\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"switch\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654623083000,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2022-06-08 01:32:05');
INSERT INTO `sys_oper_log` VALUES (441, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\": \\\"temperature\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"humidity\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"light\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"switch\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654623083000,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2022-06-08 01:32:53');
INSERT INTO `sys_oper_log` VALUES (442, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\": \\\"temperature\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"humidity\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"light\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"switch\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654623119000,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"设备编号：D6329VL54419L1Y0已经存在了，新增设备失败\",\"code\":200,\"data\":0}', 0, NULL, '2022-06-08 01:46:00');
INSERT INTO `sys_oper_log` VALUES (443, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\": \\\"temperature\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"humidity\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"light\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"switch\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654623119000,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"设备编号：D6329VL54419L1Y0已经存在了，新增设备失败\",\"code\":200,\"data\":0}', 0, NULL, '2022-06-08 01:48:22');
INSERT INTO `sys_oper_log` VALUES (444, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\": \\\"temperature\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"humidity\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"light\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"switch\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654623119000,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"设备编号：D6329VL54419L1Y0已经存在了，新增设备失败\",\"code\":200,\"data\":0}', 0, NULL, '2022-06-08 01:48:59');
INSERT INTO `sys_oper_log` VALUES (445, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":36.19258,\"deviceId\":22,\"deviceName\":\"测试重复编号\",\"productName\":\"管理员产品\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\": \\\"temperature\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"humidity\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"light\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"switch\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"gear\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.499651,\"rssi\":0,\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654623119000,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"imgUrl\":\"/profile/iot/1/2022-0608-003839.jpg\",\"createTime\":1654622948000,\"tenantId\":1,\"isShadow\":0,\"status\":1}', '{\"msg\":\"设备编号：D6329VL54419L1Y0已经存在了，新增设备失败\",\"code\":200,\"data\":0}', 0, NULL, '2022-06-08 01:49:18');
INSERT INTO `sys_oper_log` VALUES (446, '定时任务', 1, 'com.ruoyi.iot.controller.DeviceJobController.add()', 'POST', 1, 'admin', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"deviceId\":21,\"deviceName\":\"测试设备\",\"productName\":\"管理员产品\",\"nextValidTime\":1654711020000,\"sceneId\":0,\"alertId\":0,\"jobType\":1,\"jobName\":\"测试定时\",\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 57 01 ? * 1,2,3,4,5,6,7\",\"jobId\":4,\"createBy\":\"admin\",\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"switch\\\",\\\"name\\\":\\\"设备开关\\\",\\\"value\\\":\\\"1\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":21,\\\"deviceName\\\":\\\"测试设备\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 01:57:27');
INSERT INTO `sys_oper_log` VALUES (447, '通用物模型', 1, 'com.ruoyi.iot.controller.ThingsModelTemplateController.add()', 'POST', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"params\":{},\"templateId\":23,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"enum\\\",\\\"enumList\\\":[{\\\"value\\\":\\\"1\\\",\\\"text\\\":\\\"1\\\"},{\\\"value\\\":\\\"2\\\",\\\"text\\\":\\\"2\\\"}]}\",\"createBy\":\"admin\",\"isMonitor\":0,\"tenantName\":\"admin\",\"createTime\":1654665377250,\"datatype\":\"enum\",\"templateName\":\"1\",\"isTop\":0,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 13:16:17');
INSERT INTO `sys_oper_log` VALUES (448, '通用物模型', 3, 'com.ruoyi.iot.controller.ThingsModelTemplateController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/template/23', '127.0.0.1', '内网IP', '{templateIds=23}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 13:16:22');
INSERT INTO `sys_oper_log` VALUES (449, '通用物模型', 1, 'com.ruoyi.iot.controller.ThingsModelTemplateController.add()', 'POST', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"2\",\"params\":{},\"templateId\":24,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"array\\\",\\\"arrayType\\\":\\\"int\\\"}\",\"createBy\":\"admin\",\"tenantName\":\"admin\",\"createTime\":1654665396325,\"datatype\":\"array\",\"templateName\":\"2\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 13:16:36');
INSERT INTO `sys_oper_log` VALUES (450, '通用物模型', 1, 'com.ruoyi.iot.controller.ThingsModelTemplateController.add()', 'POST', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"params\":{},\"templateId\":25,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"enum\\\",\\\"enumList\\\":[{\\\"value\\\":\\\"1\\\",\\\"text\\\":\\\"1\\\"},{\\\"value\\\":\\\"2\\\",\\\"text\\\":\\\"2\\\"},{\\\"value\\\":\\\"3\\\",\\\"text\\\":\\\"3\\\"}]}\",\"createBy\":\"admin\",\"isMonitor\":0,\"tenantName\":\"admin\",\"createTime\":1654665777875,\"datatype\":\"enum\",\"templateName\":\"1\",\"isTop\":0,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 13:22:58');
INSERT INTO `sys_oper_log` VALUES (451, '通用物模型', 3, 'com.ruoyi.iot.controller.ThingsModelTemplateController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/template/25', '127.0.0.1', '内网IP', '{templateIds=25}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:05:19');
INSERT INTO `sys_oper_log` VALUES (452, '通用物模型', 3, 'com.ruoyi.iot.controller.ThingsModelTemplateController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/template/24', '127.0.0.1', '内网IP', '{templateIds=24}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:05:22');
INSERT INTO `sys_oper_log` VALUES (453, '通用物模型', 1, 'com.ruoyi.iot.controller.ThingsModelTemplateController.add()', 'POST', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"params\":{},\"templateId\":26,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"integer\\\",\\\"min\\\":1,\\\"max\\\":111,\\\"unit\\\":\\\"1\\\",\\\"step\\\":1}\",\"createBy\":\"admin\",\"isMonitor\":1,\"tenantName\":\"admin\",\"createTime\":1654668333474,\"datatype\":\"integer\",\"templateName\":\"1\",\"isTop\":0,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:05:34');
INSERT INTO `sys_oper_log` VALUES (454, '通用物模型', 2, 'com.ruoyi.iot.controller.ThingsModelTemplateController.edit()', 'PUT', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"updateTime\":1654668341547,\"params\":{},\"templateId\":26,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"decimal\\\",\\\"min\\\":1,\\\"max\\\":111,\\\"unit\\\":\\\"1\\\",\\\"step\\\":1}\",\"isMonitor\":1,\"tenantName\":\"admin\",\"createTime\":1654668333000,\"datatype\":\"decimal\",\"templateName\":\"1\",\"updateBy\":\"admin\",\"isTop\":0,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:05:42');
INSERT INTO `sys_oper_log` VALUES (455, '通用物模型', 2, 'com.ruoyi.iot.controller.ThingsModelTemplateController.edit()', 'PUT', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"updateTime\":1654668358737,\"params\":{},\"templateId\":26,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"enum\\\",\\\"enumList\\\":[{\\\"value\\\":\\\"1\\\",\\\"text\\\":\\\"1\\\"},{\\\"value\\\":\\\"2\\\",\\\"text\\\":\\\"2\\\"},{\\\"value\\\":\\\"3\\\",\\\"text\\\":\\\"3\\\"}]}\",\"isMonitor\":0,\"tenantName\":\"admin\",\"createTime\":1654668333000,\"datatype\":\"enum\",\"templateName\":\"1\",\"updateBy\":\"admin\",\"isTop\":0,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:05:59');
INSERT INTO `sys_oper_log` VALUES (456, '通用物模型', 2, 'com.ruoyi.iot.controller.ThingsModelTemplateController.edit()', 'PUT', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"updateTime\":1654668367556,\"params\":{},\"templateId\":26,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"array\\\",\\\"arrayType\\\":\\\"double\\\"}\",\"isMonitor\":0,\"tenantName\":\"admin\",\"createTime\":1654668333000,\"datatype\":\"array\",\"templateName\":\"1\",\"updateBy\":\"admin\",\"isTop\":0,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:06:08');
INSERT INTO `sys_oper_log` VALUES (457, '通用物模型', 2, 'com.ruoyi.iot.controller.ThingsModelTemplateController.edit()', 'PUT', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"updateTime\":1654668378800,\"params\":{},\"templateId\":26,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"enum\\\",\\\"enumList\\\":[{\\\"value\\\":\\\"1\\\",\\\"text\\\":\\\"1\\\"},{\\\"value\\\":\\\"2\\\",\\\"text\\\":\\\"2\\\"}]}\",\"isMonitor\":0,\"tenantName\":\"admin\",\"createTime\":1654668333000,\"datatype\":\"enum\",\"templateName\":\"1\",\"updateBy\":\"admin\",\"isTop\":0,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:06:19');
INSERT INTO `sys_oper_log` VALUES (458, '通用物模型', 2, 'com.ruoyi.iot.controller.ThingsModelTemplateController.edit()', 'PUT', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"updateTime\":1654668397770,\"params\":{},\"templateId\":26,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"integer\\\",\\\"min\\\":1,\\\"max\\\":11,\\\"unit\\\":\\\"1\\\",\\\"step\\\":1}\",\"isMonitor\":1,\"tenantName\":\"admin\",\"createTime\":1654668333000,\"datatype\":\"integer\",\"templateName\":\"1\",\"updateBy\":\"admin\",\"isTop\":1,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:06:38');
INSERT INTO `sys_oper_log` VALUES (459, '通用物模型', 2, 'com.ruoyi.iot.controller.ThingsModelTemplateController.edit()', 'PUT', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"updateTime\":1654668406115,\"params\":{},\"templateId\":26,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"decimal\\\",\\\"min\\\":1,\\\"max\\\":11,\\\"unit\\\":\\\"1\\\",\\\"step\\\":1}\",\"isMonitor\":1,\"tenantName\":\"admin\",\"createTime\":1654668333000,\"datatype\":\"decimal\",\"templateName\":\"1\",\"updateBy\":\"admin\",\"isTop\":1,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:06:46');
INSERT INTO `sys_oper_log` VALUES (460, '通用物模型', 2, 'com.ruoyi.iot.controller.ThingsModelTemplateController.edit()', 'PUT', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"updateTime\":1654668414654,\"params\":{},\"templateId\":26,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"enum\\\",\\\"enumList\\\":[{\\\"value\\\":\\\"1\\\",\\\"text\\\":\\\"1\\\"},{\\\"value\\\":\\\"2\\\",\\\"text\\\":\\\"2\\\"}]}\",\"isMonitor\":0,\"tenantName\":\"admin\",\"createTime\":1654668333000,\"datatype\":\"enum\",\"templateName\":\"1\",\"updateBy\":\"admin\",\"isTop\":1,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:06:55');
INSERT INTO `sys_oper_log` VALUES (461, '通用物模型', 3, 'com.ruoyi.iot.controller.ThingsModelTemplateController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/template/26', '127.0.0.1', '内网IP', '{templateIds=26}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:06:58');
INSERT INTO `sys_oper_log` VALUES (462, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"KY0K6CVI0ZRC5Q70\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"测试物模型\",\"networkMethod\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"POS958Q27X7126Z8\",\"deviceType\":1,\"productId\":12,\"params\":{},\"isAuthorize\":0,\"createTime\":1654668997584,\"tenantId\":1,\"categoryId\":1,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":1,\"categoryName\":\"电工照明\",\"createTime\":1654668997584,\"deviceType\":1,\"isAuthorize\":0,\"isSys\":1,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"POS958Q27X7126Z8\",\"mqttSecret\":\"KY0K6CVI0ZRC5Q70\",\"networkMethod\":1,\"params\":{},\"productId\":12,\"productName\":\"测试物模型\",\"status\":1,\"tenantId\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3}}', 0, NULL, '2022-06-08 14:16:38');
INSERT INTO `sys_oper_log` VALUES (463, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'admin', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":12,\"templateIds\":[12,1,2,3,8,7,6],\"productName\":\"测试物模型\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-08 14:16:48');
INSERT INTO `sys_oper_log` VALUES (464, '物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.add()', 'POST', 1, 'admin', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"productId\":12,\"modelId\":49,\"params\":{},\"type\":1,\"productName\":\"测试物模型\",\"modelName\":\"1\",\"specs\":\"{\\\"type\\\":\\\"integer\\\",\\\"min\\\":1,\\\"max\\\":11,\\\"unit\\\":\\\"1\\\",\\\"step\\\":1}\",\"isMonitor\":1,\"tenantName\":\"admin\",\"createTime\":1654669040125,\"datatype\":\"integer\",\"isTop\":0,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:17:21');
INSERT INTO `sys_oper_log` VALUES (465, '物模型', 2, 'com.ruoyi.iot.controller.ThingsModelController.edit()', 'PUT', 1, 'admin', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"productId\":12,\"modelId\":49,\"updateTime\":1654669056958,\"params\":{},\"type\":1,\"productName\":\"测试物模型\",\"modelName\":\"1\",\"specs\":\"{\\\"type\\\":\\\"enum\\\",\\\"enumList\\\":[{\\\"value\\\":\\\"1\\\",\\\"text\\\":\\\"1\\\"},{\\\"value\\\":\\\"2\\\",\\\"text\\\":\\\"2\\\"}]}\",\"isMonitor\":0,\"tenantName\":\"admin\",\"datatype\":\"enum\",\"isTop\":0,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:17:37');
INSERT INTO `sys_oper_log` VALUES (466, '物模型', 2, 'com.ruoyi.iot.controller.ThingsModelController.edit()', 'PUT', 1, 'admin', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"productId\":12,\"modelId\":49,\"updateTime\":1654669065237,\"params\":{},\"type\":1,\"productName\":\"测试物模型\",\"modelName\":\"1\",\"specs\":\"{\\\"type\\\":\\\"array\\\",\\\"arrayType\\\":\\\"double\\\"}\",\"isMonitor\":0,\"tenantName\":\"admin\",\"datatype\":\"array\",\"isTop\":0,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:17:46');
INSERT INTO `sys_oper_log` VALUES (467, '物模型', 2, 'com.ruoyi.iot.controller.ThingsModelController.edit()', 'PUT', 1, 'admin', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"productId\":12,\"modelId\":49,\"updateTime\":1654669075875,\"params\":{},\"type\":1,\"productName\":\"测试物模型\",\"modelName\":\"1\",\"specs\":\"{\\\"type\\\":\\\"decimal\\\",\\\"min\\\":1,\\\"max\\\":11,\\\"unit\\\":\\\"1\\\",\\\"step\\\":1}\",\"isMonitor\":1,\"tenantName\":\"admin\",\"datatype\":\"decimal\",\"isTop\":0,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:17:56');
INSERT INTO `sys_oper_log` VALUES (468, '物模型', 3, 'com.ruoyi.iot.controller.ThingsModelController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/model/49', '127.0.0.1', '内网IP', '{modelIds=49}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 14:18:01');
INSERT INTO `sys_oper_log` VALUES (469, '物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.add()', 'POST', 1, 'admin', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"productId\":12,\"modelId\":50,\"params\":{},\"type\":1,\"productName\":\"测试物模型\",\"modelName\":\"1\",\"specs\":\"{\\\"type\\\":\\\"integer\\\",\\\"min\\\":1,\\\"max\\\":11,\\\"unit\\\":\\\"1\\\",\\\"step\\\":1}\",\"isMonitor\":1,\"tenantName\":\"admin\",\"createTime\":1654672173220,\"datatype\":\"integer\",\"isTop\":1,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 15:09:34');
INSERT INTO `sys_oper_log` VALUES (470, '物模型', 2, 'com.ruoyi.iot.controller.ThingsModelController.edit()', 'PUT', 1, 'admin', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"productId\":12,\"modelId\":50,\"updateTime\":1654672180542,\"params\":{},\"type\":1,\"productName\":\"测试物模型\",\"modelName\":\"1\",\"specs\":\"{\\\"type\\\":\\\"decimal\\\",\\\"min\\\":1,\\\"max\\\":11,\\\"unit\\\":\\\"1\\\",\\\"step\\\":1}\",\"isMonitor\":1,\"tenantName\":\"admin\",\"datatype\":\"decimal\",\"isTop\":1,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 15:09:41');
INSERT INTO `sys_oper_log` VALUES (471, '物模型', 2, 'com.ruoyi.iot.controller.ThingsModelController.edit()', 'PUT', 1, 'admin', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"1\",\"productId\":12,\"modelId\":50,\"updateTime\":1654672193114,\"params\":{},\"type\":1,\"productName\":\"测试物模型\",\"modelName\":\"1\",\"specs\":\"{\\\"type\\\":\\\"enum\\\",\\\"enumList\\\":[{\\\"value\\\":\\\"1\\\",\\\"text\\\":\\\"1\\\"},{\\\"value\\\":\\\"2\\\",\\\"text\\\":\\\"2\\\"}]}\",\"isMonitor\":0,\"tenantName\":\"admin\",\"datatype\":\"enum\",\"isTop\":1,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 15:09:54');
INSERT INTO `sys_oper_log` VALUES (472, '物模型', 3, 'com.ruoyi.iot.controller.ThingsModelController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/model/50', '127.0.0.1', '内网IP', '{modelIds=50}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 15:09:58');
INSERT INTO `sys_oper_log` VALUES (473, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"KY0K6CVI0ZRC5Q70\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"测试物模型\",\"networkMethod\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"POS958Q27X7126Z8\",\"deviceType\":1,\"productId\":12,\"updateTime\":1654677771652,\"params\":{},\"isAuthorize\":1,\"createTime\":1654668998000,\"tenantId\":1,\"categoryId\":1,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 16:42:52');
INSERT INTO `sys_oper_log` VALUES (474, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'admin', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":10,\"productId\":12}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 16:43:26');
INSERT INTO `sys_oper_log` VALUES (475, '产品授权码', 5, 'com.ruoyi.iot.controller.ProductAuthorizeController.export()', 'POST', 1, 'admin', NULL, '/iot/authorize/export', '127.0.0.1', '内网IP', '{\"productId\":12,\"params\":{}}', NULL, 0, NULL, '2022-06-08 16:58:21');
INSERT INTO `sys_oper_log` VALUES (476, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"1\",\"productId\":11,\"remark\":\"1\",\"updateTime\":1654690939027,\"delFlag\":\"0\",\"params\":{},\"userName\":\"1\",\"deviceId\":1,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":146,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"5A7A6FE3019F4349A4EB1FD53258B594\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 20:22:19');
INSERT INTO `sys_oper_log` VALUES (477, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"1\",\"productId\":11,\"remark\":\"10000000\",\"updateTime\":1654690946443,\"delFlag\":\"0\",\"params\":{},\"userName\":\"1\",\"deviceId\":1,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":146,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"5A7A6FE3019F4349A4EB1FD53258B594\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 20:22:27');
INSERT INTO `sys_oper_log` VALUES (478, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"1\",\"productId\":11,\"remark\":\"福晶科技疯了\",\"updateTime\":1654690953999,\"delFlag\":\"0\",\"params\":{},\"userName\":\"1\",\"deviceId\":1,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":146,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"5A7A6FE3019F4349A4EB1FD53258B594\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 20:22:34');
INSERT INTO `sys_oper_log` VALUES (479, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"D17YN9O5I800\",\"productId\":11,\"remark\":\"福晶科技疯了\",\"updateTime\":1654693409659,\"delFlag\":\"0\",\"params\":{},\"userName\":\"admin\",\"deviceId\":22,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":146,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"5A7A6FE3019F4349A4EB1FD53258B594\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 21:03:30');
INSERT INTO `sys_oper_log` VALUES (480, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654693448573,\"delFlag\":\"0\",\"params\":{},\"userName\":\"admin\",\"deviceId\":21,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":147,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"092EAF042593435C8CF35E1EFE3A439A\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 21:04:09');
INSERT INTO `sys_oper_log` VALUES (481, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"D6329VL54419L1Y0\",\"productId\":11,\"updateTime\":1654693826718,\"delFlag\":\"0\",\"params\":{},\"userName\":\"admin\",\"deviceId\":21,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":150,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"55CDEE10107E4D5BAE696C1215660BCE\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 21:10:27');
INSERT INTO `sys_oper_log` VALUES (482, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"productId\":11,\"updateTime\":1654699454918,\"delFlag\":\"0\",\"params\":{},\"createBy\":\"admin\",\"authorizeId\":148,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"24B3AFBD97D04D579165C7C419C7B6F8\",\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 22:44:15');
INSERT INTO `sys_oper_log` VALUES (483, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"productId\":11,\"delFlag\":\"0\",\"params\":{},\"createBy\":\"admin\",\"authorizeId\":148,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"24B3AFBD97D04D579165C7C419C7B6F8\",\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 22:56:00');
INSERT INTO `sys_oper_log` VALUES (484, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"D17YN9O5I800\",\"productId\":11,\"remark\":\"福晶科技疯了\",\"updateTime\":1654700786318,\"delFlag\":\"0\",\"params\":{},\"userName\":\"admin\",\"deviceId\":22,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":146,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"5A7A6FE3019F4349A4EB1FD53258B594\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 23:06:27');
INSERT INTO `sys_oper_log` VALUES (485, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"D17YN9O5I800\",\"productId\":11,\"remark\":\"福晶科技疯了1111\",\"updateTime\":1654700793121,\"delFlag\":\"0\",\"params\":{},\"userName\":\"admin\",\"deviceId\":22,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":146,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"5A7A6FE3019F4349A4EB1FD53258B594\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 23:06:34');
INSERT INTO `sys_oper_log` VALUES (486, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"productId\":11,\"delFlag\":\"0\",\"params\":{},\"createBy\":\"admin\",\"authorizeId\":155,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"A6DD0FBB8C384B94AA3EF0C86BFD0A7D\",\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 23:16:04');
INSERT INTO `sys_oper_log` VALUES (487, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"D17YN9O5I800\",\"productId\":11,\"updateTime\":1654703497866,\"delFlag\":\"0\",\"params\":{},\"userName\":\"admin\",\"deviceId\":23,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":155,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"A6DD0FBB8C384B94AA3EF0C86BFD0A7D\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 23:51:38');
INSERT INTO `sys_oper_log` VALUES (488, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"D17YN9O5I800\",\"productId\":11,\"remark\":\"999\",\"updateTime\":1654703510500,\"delFlag\":\"0\",\"params\":{},\"userName\":\"admin\",\"deviceId\":23,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":155,\"createTime\":1654595721000,\"updateBy\":\"\",\"authorizeCode\":\"A6DD0FBB8C384B94AA3EF0C86BFD0A7D\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-08 23:51:51');
INSERT INTO `sys_oper_log` VALUES (489, '产品授权码', 5, 'com.ruoyi.iot.controller.ProductAuthorizeController.export()', 'POST', 1, 'admin', NULL, '/iot/authorize/export', '127.0.0.1', '内网IP', '{\"productId\":11,\"params\":{}}', NULL, 0, NULL, '2022-06-08 23:59:11');
INSERT INTO `sys_oper_log` VALUES (490, '产品授权码', 5, 'com.ruoyi.iot.controller.ProductAuthorizeController.export()', 'POST', 1, 'admin', NULL, '/iot/authorize/export', '127.0.0.1', '内网IP', '{\"productId\":11,\"params\":{}}', NULL, 0, NULL, '2022-06-09 00:00:42');
INSERT INTO `sys_oper_log` VALUES (491, '产品授权码', 5, 'com.ruoyi.iot.controller.ProductAuthorizeController.export()', 'POST', 1, 'admin', NULL, '/iot/authorize/export', '127.0.0.1', '内网IP', '{\"productId\":11,\"params\":{}}', NULL, 0, NULL, '2022-06-09 00:04:03');
INSERT INTO `sys_oper_log` VALUES (492, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'admin', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[22],\"groupId\":6}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 00:05:57');
INSERT INTO `sys_oper_log` VALUES (493, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'admin', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[21,22],\"groupId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 00:06:04');
INSERT INTO `sys_oper_log` VALUES (494, '定时任务', 1, 'com.ruoyi.iot.controller.DeviceJobController.add()', 'POST', 1, 'admin', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"deviceId\":23,\"deviceName\":\"测试重复编号1\",\"productName\":\"管理员产品\",\"nextValidTime\":1654840140000,\"sceneId\":0,\"alertId\":0,\"jobType\":1,\"jobName\":\"11\",\"serialNumber\":\"D17YN9O5I800\",\"productId\":11,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 49 13 ? * 1,2,3,4,5,6,7\",\"jobId\":5,\"createBy\":\"admin\",\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"gear\\\",\\\"name\\\":\\\"运行档位\\\",\\\"value\\\":\\\"0\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":23,\\\"deviceName\\\":\\\"测试重复编号1\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 13:49:47');
INSERT INTO `sys_oper_log` VALUES (495, '定时任务', 3, 'com.ruoyi.iot.controller.DeviceJobController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/job/5', '127.0.0.1', '内网IP', '{jobIds=5}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 13:49:54');
INSERT INTO `sys_oper_log` VALUES (496, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/22', '127.0.0.1', '内网IP', '{deviceIds=22}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:06:11');
INSERT INTO `sys_oper_log` VALUES (497, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/21', '127.0.0.1', '内网IP', '{deviceIds=21}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:06:21');
INSERT INTO `sys_oper_log` VALUES (498, '设备', 3, 'com.ruoyi.iot.controller.DeviceController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/device/23', '127.0.0.1', '内网IP', '{deviceIds=23}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:06:38');
INSERT INTO `sys_oper_log` VALUES (499, '产品', 3, 'com.ruoyi.iot.controller.ProductController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/product/12', '127.0.0.1', '内网IP', '{productIds=12}', '{\"msg\":\"删除成功\",\"code\":200}', 0, NULL, '2022-06-09 17:11:11');
INSERT INTO `sys_oper_log` VALUES (500, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'admin', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":11,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:11:23');
INSERT INTO `sys_oper_log` VALUES (501, '产品', 3, 'com.ruoyi.iot.controller.ProductController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/product/11', '127.0.0.1', '内网IP', '{productIds=11}', '{\"msg\":\"删除失败，请先删除对应产品下的固件\",\"code\":500}', 0, NULL, '2022-06-09 17:11:30');
INSERT INTO `sys_oper_log` VALUES (502, '产品固件', 3, 'com.ruoyi.iot.controller.FirmwareController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/firmware/9', '127.0.0.1', '内网IP', '{firmwareIds=9}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:11:38');
INSERT INTO `sys_oper_log` VALUES (503, '产品固件', 3, 'com.ruoyi.iot.controller.FirmwareController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/firmware/8', '127.0.0.1', '内网IP', '{firmwareIds=8}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:11:41');
INSERT INTO `sys_oper_log` VALUES (504, '产品', 3, 'com.ruoyi.iot.controller.ProductController.remove()', 'DELETE', 1, 'admin', NULL, '/iot/product/11', '127.0.0.1', '内网IP', '{productIds=11}', '{\"msg\":\"删除成功\",\"code\":200}', 0, NULL, '2022-06-09 17:11:48');
INSERT INTO `sys_oper_log` VALUES (505, '通用物模型', 1, 'com.ruoyi.iot.controller.ThingsModelTemplateController.add()', 'POST', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"temp_admin\",\"params\":{},\"templateId\":27,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"decimal\\\",\\\"min\\\":14.2,\\\"max\\\":46.5,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":0.1}\",\"createBy\":\"admin\",\"isMonitor\":1,\"tenantName\":\"admin\",\"createTime\":1654766282716,\"datatype\":\"decimal\",\"templateName\":\"体温-管理员\",\"isTop\":1,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:18:03');
INSERT INTO `sys_oper_log` VALUES (506, '通用物模型', 2, 'com.ruoyi.iot.controller.ThingsModelTemplateController.edit()', 'PUT', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"temp_admin\",\"updateTime\":1654766304162,\"params\":{},\"templateId\":27,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"decimal\\\",\\\"min\\\":14.2,\\\"max\\\":46.5,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":0.1}\",\"isMonitor\":1,\"tenantName\":\"admin\",\"createTime\":1654766283000,\"datatype\":\"decimal\",\"templateName\":\"体温(管理员)\",\"updateBy\":\"admin\",\"isTop\":1,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:18:25');
INSERT INTO `sys_oper_log` VALUES (507, '产品分类', 1, 'com.ruoyi.iot.controller.CategoryController.add()', 'POST', 1, 'admin', NULL, '/iot/category', '127.0.0.1', '内网IP', '{\"orderNum\":8,\"remark\":\"管理员测试数据\",\"params\":{},\"categoryName\":\"医疗器械(管理员)\",\"tenantName\":\"admin\",\"createTime\":1654766373320,\"tenantId\":1,\"categoryId\":13,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:19:34');
INSERT INTO `sys_oper_log` VALUES (508, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'admin', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"KM5Y70E0T1234QT8\",\"mqttAccount\":\"wumei-smart\",\"remark\":\"管理员测试数据\",\"categoryName\":\"医疗器械(管理员)\",\"productName\":\"智能体温检测仪(管理员)\",\"networkMethod\":2,\"tenantName\":\"admin\",\"vertificateMethod\":3,\"mqttPassword\":\"PWZXWP8LELV0336A\",\"deviceType\":1,\"productId\":13,\"params\":{},\"isAuthorize\":1,\"createTime\":1654766447931,\"tenantId\":1,\"categoryId\":13,\"isSys\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":13,\"categoryName\":\"医疗器械(管理员)\",\"createTime\":1654766447931,\"deviceType\":1,\"isAuthorize\":1,\"isSys\":1,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"PWZXWP8LELV0336A\",\"mqttSecret\":\"KM5Y70E0T1234QT8\",\"networkMethod\":2,\"params\":{},\"productId\":13,\"productName\":\"智能体温检测仪(管理员)\",\"remark\":\"管理员测试数据\",\"status\":1,\"tenantId\":1,\"tenantName\":\"admin\",\"vertificateMethod\":3}}', 0, NULL, '2022-06-09 17:20:48');
INSERT INTO `sys_oper_log` VALUES (509, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'admin', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":13,\"templateIds\":[27],\"productName\":\"智能体温检测仪(管理员)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-09 17:22:10');
INSERT INTO `sys_oper_log` VALUES (510, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'admin', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":13,\"templateIds\":[5,9,8],\"productName\":\"智能体温检测仪(管理员)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-09 17:22:43');
INSERT INTO `sys_oper_log` VALUES (511, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'admin', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":13,\"templateIds\":[11],\"productName\":\"智能体温检测仪(管理员)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-09 17:22:56');
INSERT INTO `sys_oper_log` VALUES (512, '物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.add()', 'POST', 1, 'admin', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"high_temp\",\"productId\":13,\"modelId\":56,\"params\":{},\"type\":3,\"productName\":\"智能体温检测仪(管理员)\",\"modelName\":\"体温过高\",\"specs\":\"{\\\"type\\\":\\\"decimal\\\",\\\"min\\\":20,\\\"max\\\":50,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":0.1}\",\"isMonitor\":0,\"tenantName\":\"admin\",\"createTime\":1654766638523,\"datatype\":\"decimal\",\"isTop\":0,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:23:59');
INSERT INTO `sys_oper_log` VALUES (513, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":13,\"filePath\":\"/profile/iot/1/2022-0609-172438.bin\",\"firmwareId\":10,\"params\":{},\"version\":1,\"productName\":\"智能体温检测仪(管理员)\",\"tenantName\":\"admin\",\"createTime\":1654766681195,\"firmwareName\":\"出厂固件\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:24:41');
INSERT INTO `sys_oper_log` VALUES (514, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'admin', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":10,\"productId\":13}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:24:53');
INSERT INTO `sys_oper_log` VALUES (515, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'admin', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":13,\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 17:32:36');
INSERT INTO `sys_oper_log` VALUES (516, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'admin', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":10,\"groupId\":16,\"remark\":\"管理员分组，用于测试\",\"params\":{},\"userName\":\"admin\",\"userId\":1,\"groupName\":\"管理员分组\",\"createTime\":1654786027046}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 22:47:07');
INSERT INTO `sys_oper_log` VALUES (517, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":27.387742287849193,\"deviceId\":24,\"deviceName\":\"门口监测仪\",\"productName\":\"智能体温检测仪(管理员)\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temp_admin\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"report_monitor\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":103.4113808240265,\"rssi\":0,\"serialNumber\":\"D1FL8B1Z37UM\",\"productId\":13,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"createTime\":1654786131611,\"tenantId\":1,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654786131611,\"deviceId\":24,\"deviceName\":\"门口监测仪\",\"firmwareVersion\":1,\"isShadow\":1,\"latitude\":27.387742287849193,\"locationWay\":1,\"longitude\":103.4113808240265,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":13,\"productName\":\"智能体温检测仪(管理员)\",\"rssi\":0,\"serialNumber\":\"D1FL8B1Z37UM\",\"status\":1,\"tenantId\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temp_admin\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"report_monitor\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":1,\"userName\":\"admin\"}}', 0, NULL, '2022-06-09 22:48:52');
INSERT INTO `sys_oper_log` VALUES (518, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":27.387742,\"deviceId\":24,\"deviceName\":\"门口监测仪(管理员)\",\"productName\":\"智能体温检测仪(管理员)\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temp_admin\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"report_monitor\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":103.411381,\"rssi\":0,\"serialNumber\":\"D1FL8B1Z37UM\",\"productId\":13,\"updateTime\":1654786218362,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"createTime\":1654786132000,\"tenantId\":1,\"isShadow\":1,\"status\":1}', '{\"msg\":\"修改成功\",\"code\":200,\"data\":1}', 0, NULL, '2022-06-09 22:50:19');
INSERT INTO `sys_oper_log` VALUES (519, '定时任务', 1, 'com.ruoyi.iot.controller.DeviceJobController.add()', 'POST', 1, 'admin', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"deviceId\":24,\"deviceName\":\"门口监测仪(管理员)\",\"productName\":\"智能体温检测仪(管理员)\",\"nextValidTime\":1654872600000,\"sceneId\":0,\"alertId\":0,\"jobType\":1,\"jobName\":\"上报体温(管理员)\",\"serialNumber\":\"D1FL8B1Z37UM\",\"productId\":13,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 50 22 ? * 1,2,3,4,5,6,7\",\"jobId\":6,\"createBy\":\"admin\",\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"report_monitor\\\",\\\"name\\\":\\\"上报监测数据\\\",\\\"value\\\":\\\"1\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":24,\\\"deviceName\\\":\\\"门口监测仪(管理员)\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 22:51:17');
INSERT INTO `sys_oper_log` VALUES (520, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'admin', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[24],\"groupId\":16}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 23:03:49');
INSERT INTO `sys_oper_log` VALUES (521, '通用物模型', 2, 'com.ruoyi.iot.controller.ThingsModelTemplateController.edit()', 'PUT', 1, 'admin', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"temp_admin\",\"updateTime\":1654787125677,\"params\":{},\"templateId\":27,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"decimal\\\",\\\"min\\\":14.2,\\\"max\\\":46.5,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":0.1}\",\"isMonitor\":1,\"tenantName\":\"admin\",\"createTime\":1654766283000,\"datatype\":\"decimal\",\"templateName\":\"体温(admin)\",\"updateBy\":\"admin\",\"isTop\":1,\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 23:05:26');
INSERT INTO `sys_oper_log` VALUES (522, '产品分类', 2, 'com.ruoyi.iot.controller.CategoryController.edit()', 'PUT', 1, 'admin', NULL, '/iot/category', '127.0.0.1', '内网IP', '{\"orderNum\":8,\"remark\":\"管理员测试数据\",\"updateTime\":1654787140977,\"params\":{},\"categoryName\":\"医疗器械(admin)\",\"tenantName\":\"admin\",\"createTime\":1654766373000,\"tenantId\":1,\"categoryId\":13,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 23:05:41');
INSERT INTO `sys_oper_log` VALUES (523, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'admin', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":13,\"filePath\":\"/profile/iot/1/2022-0609-172438.bin\",\"firmwareId\":10,\"updateTime\":1654787267603,\"params\":{},\"version\":1,\"productName\":\"智能体温检测仪(管理员)\",\"tenantName\":\"admin\",\"createTime\":1654766681000,\"firmwareName\":\"出厂固件(admin)\",\"tenantId\":1,\"isSys\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 23:07:48');
INSERT INTO `sys_oper_log` VALUES (524, '分组', 2, 'com.ruoyi.iot.controller.GroupController.edit()', 'PUT', 1, 'admin', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":11,\"groupId\":16,\"remark\":\"管理员分组，用于测试\",\"updateTime\":1654787330539,\"params\":{},\"userName\":\"admin\",\"userId\":1,\"groupName\":\"医疗(admin)\",\"createTime\":1654786027000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 23:08:51');
INSERT INTO `sys_oper_log` VALUES (525, '分组', 2, 'com.ruoyi.iot.controller.GroupController.edit()', 'PUT', 1, 'admin', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":11,\"groupId\":16,\"remark\":\"管理员分组，用于测试\",\"updateTime\":1654787420708,\"params\":{},\"userName\":\"admin\",\"userId\":1,\"groupName\":\"医疗(admin)\",\"createTime\":1654786027000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 23:10:21');
INSERT INTO `sys_oper_log` VALUES (526, '分组', 2, 'com.ruoyi.iot.controller.GroupController.edit()', 'PUT', 1, 'admin', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":10,\"groupId\":16,\"remark\":\"管理员分组，用于测试\",\"updateTime\":1654787432776,\"params\":{},\"userName\":\"admin\",\"userId\":1,\"groupName\":\"医疗(admin)\",\"createTime\":1654786027000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 23:10:33');
INSERT INTO `sys_oper_log` VALUES (527, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'admin', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":27.387742,\"deviceId\":24,\"deviceName\":\"门口监测仪(admin)\",\"locationWay\":1,\"tenantName\":\"admin\",\"thingsModelValue\":\"[{\\\"id\\\": \\\"temp_admin\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"switch\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"message\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}, {\\\"id\\\": \\\"report_monitor\\\", \\\"value\\\": \\\"\\\", \\\"shadow\\\": \\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":103.411381,\"rssi\":0,\"serialNumber\":\"D1FL8B1Z37UM\",\"updateTime\":1654787446840,\"params\":{},\"userName\":\"admin\",\"networkAddress\":\"中国\",\"userId\":1,\"createTime\":1654786132000,\"tenantId\":1,\"isShadow\":1,\"status\":3}', '{\"msg\":\"修改成功\",\"code\":200,\"data\":1}', 0, NULL, '2022-06-09 23:10:47');
INSERT INTO `sys_oper_log` VALUES (528, '定时任务', 2, 'com.ruoyi.iot.controller.DeviceJobController.edit()', 'PUT', 1, 'admin', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"remark\":\"\",\"deviceId\":24,\"deviceName\":\"门口监测仪(admin)\",\"productName\":\"智能体温检测仪(管理员)\",\"nextValidTime\":1654872600000,\"updateBy\":\"admin\",\"jobType\":1,\"jobName\":\"上报体温(admin)\",\"serialNumber\":\"D1FL8B1Z37UM\",\"productId\":13,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 50 22 ? * 1,2,3,4,5,6,7\",\"jobId\":6,\"createBy\":\"admin\",\"createTime\":1654786274000,\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"report_monitor\\\",\\\"name\\\":\\\"上报监测数据\\\",\\\"type\\\":2,\\\"value\\\":\\\"1\\\",\\\"source\\\":2,\\\"deviceId\\\":24,\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1,\\\"deviceName\\\":\\\"门口监测仪(admin)\\\"}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-09 23:11:02');
INSERT INTO `sys_oper_log` VALUES (529, '通用物模型', 1, 'com.ruoyi.iot.controller.ThingsModelTemplateController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"temp_t1\",\"params\":{},\"templateId\":28,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"integer\\\",\\\"min\\\":14.2,\\\"max\\\":46.5,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":0.1}\",\"createBy\":\"wumei-t1\",\"isMonitor\":1,\"tenantName\":\"wumei-t1\",\"createTime\":1654792638455,\"datatype\":\"integer\",\"templateName\":\"体温(T1)\",\"isTop\":1,\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:37:19');
INSERT INTO `sys_oper_log` VALUES (530, '产品分类', 1, 'com.ruoyi.iot.controller.CategoryController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/category', '127.0.0.1', '内网IP', '{\"orderNum\":9,\"remark\":\"租户T1测试数据\",\"params\":{},\"categoryName\":\"医疗器械(T1)\",\"tenantName\":\"wumei-t1\",\"createTime\":1654792691110,\"tenantId\":2,\"categoryId\":14}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:38:12');
INSERT INTO `sys_oper_log` VALUES (531, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K374DVRC5PVT9823\",\"mqttAccount\":\"wumei-smart\",\"remark\":\"租户T1测试数据\",\"categoryName\":\"医疗器械(T1)\",\"productName\":\"体温检测仪(T1)\",\"networkMethod\":1,\"tenantName\":\"wumei-t1\",\"vertificateMethod\":3,\"mqttPassword\":\"P3B1L9561M46MB5O\",\"deviceType\":1,\"productId\":14,\"params\":{},\"isAuthorize\":1,\"imgUrl\":\"/profile/iot/2/2022-0610-003915.jpg\",\"createTime\":1654792758103,\"tenantId\":2,\"categoryId\":14,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":14,\"categoryName\":\"医疗器械(T1)\",\"createTime\":1654792758103,\"deviceType\":1,\"imgUrl\":\"/profile/iot/2/2022-0610-003915.jpg\",\"isAuthorize\":1,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"P3B1L9561M46MB5O\",\"mqttSecret\":\"K374DVRC5PVT9823\",\"networkMethod\":1,\"params\":{},\"productId\":14,\"productName\":\"体温检测仪(T1)\",\"remark\":\"租户T1测试数据\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"vertificateMethod\":3}}', 0, NULL, '2022-06-10 00:39:19');
INSERT INTO `sys_oper_log` VALUES (532, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t1', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":14,\"templateIds\":[28],\"productName\":\"体温检测仪(T1)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-10 00:39:38');
INSERT INTO `sys_oper_log` VALUES (533, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t1', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":14,\"templateIds\":[6,5,1,2],\"productName\":\"体温检测仪(T1)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-10 00:39:55');
INSERT INTO `sys_oper_log` VALUES (534, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t1', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":14,\"templateIds\":[11],\"productName\":\"体温检测仪(T1)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-10 00:40:11');
INSERT INTO `sys_oper_log` VALUES (535, '物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"height_temp\",\"productId\":14,\"modelId\":63,\"params\":{},\"type\":3,\"productName\":\"体温检测仪(T1)\",\"modelName\":\"体温过高\",\"specs\":\"{\\\"type\\\":\\\"integer\\\",\\\"min\\\":10,\\\"max\\\":50,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":0.1}\",\"isMonitor\":0,\"tenantName\":\"wumei-t1\",\"createTime\":1654792913014,\"datatype\":\"integer\",\"isTop\":0,\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:41:54');
INSERT INTO `sys_oper_log` VALUES (536, '物模型', 2, 'com.ruoyi.iot.controller.ThingsModelController.edit()', 'PUT', 1, 'wumei-t1', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"height_temp\",\"productId\":14,\"modelId\":63,\"updateTime\":1654792935686,\"params\":{},\"type\":3,\"productName\":\"体温检测仪(T1)\",\"modelName\":\"体温过高(T1)\",\"specs\":\"{\\\"type\\\":\\\"integer\\\",\\\"min\\\":10,\\\"max\\\":50,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":0.1}\",\"isMonitor\":0,\"tenantName\":\"wumei-t1\",\"datatype\":\"integer\",\"isTop\":0,\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:42:16');
INSERT INTO `sys_oper_log` VALUES (537, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":14,\"filePath\":\"/profile/iot/2/2022-0610-004259.bin\",\"firmwareId\":11,\"remark\":\"租户T1测试数据\",\"params\":{},\"version\":1.1,\"productName\":\"体温检测仪(T1)\",\"tenantName\":\"wumei-t1\",\"createTime\":1654792997013,\"firmwareName\":\"温度检测仪出厂固件(T1)\",\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:43:17');
INSERT INTO `sys_oper_log` VALUES (538, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'wumei-t1', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":14,\"filePath\":\"/profile/iot/2/2022-0610-004259.bin\",\"firmwareId\":11,\"remark\":\"租户T1测试数据\",\"updateTime\":1654793018140,\"params\":{},\"version\":1.1,\"productName\":\"体温检测仪(T1)\",\"tenantName\":\"wumei-t1\",\"createTime\":1654792997000,\"firmwareName\":\"温度检测仪出厂固件(T1)\",\"tenantId\":2,\"isSys\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:43:38');
INSERT INTO `sys_oper_log` VALUES (539, '根据数量批量新增产品授权码', 1, 'com.ruoyi.iot.controller.ProductAuthorizeController.addProductAuthorizeByNum()', 'POST', 1, 'wumei-t1', NULL, '/iot/authorize/addProductAuthorizeByNum', '127.0.0.1', '内网IP', '{\"createNum\":10,\"productId\":14}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:43:53');
INSERT INTO `sys_oper_log` VALUES (540, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'wumei-t1', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":14,\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:44:24');
INSERT INTO `sys_oper_log` VALUES (541, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":1,\"groupId\":17,\"remark\":\"租户T1测试数据\",\"params\":{},\"userName\":\"wumei-t1\",\"userId\":2,\"groupName\":\"医疗(T1)\",\"createTime\":1654793208221}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:46:48');
INSERT INTO `sys_oper_log` VALUES (542, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":35.4983942689764,\"remark\":\"租户T1测试数据\",\"deviceId\":25,\"deviceName\":\"室内检测仪(T1)\",\"productName\":\"体温检测仪(T1)\",\"locationWay\":1,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t1\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":112.4960926852894,\"rssi\":0,\"serialNumber\":\"D2E498HG82P7\",\"productId\":14,\"params\":{},\"userName\":\"wumei-t1\",\"networkAddress\":\"中国\",\"userId\":2,\"imgUrl\":\"/profile/iot/2/2022-0610-003915.jpg\",\"createTime\":1654793362698,\"tenantId\":2,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654793362698,\"deviceId\":25,\"deviceName\":\"室内检测仪(T1)\",\"firmwareVersion\":1,\"imgUrl\":\"/profile/iot/2/2022-0610-003915.jpg\",\"isShadow\":1,\"latitude\":35.4983942689764,\"locationWay\":1,\"longitude\":112.4960926852894,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":14,\"productName\":\"体温检测仪(T1)\",\"remark\":\"租户T1测试数据\",\"rssi\":0,\"serialNumber\":\"D2E498HG82P7\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t1\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":2,\"userName\":\"wumei-t1\"}}', 0, NULL, '2022-06-10 00:49:23');
INSERT INTO `sys_oper_log` VALUES (543, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-t1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[25],\"groupId\":17}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 00:54:41');
INSERT INTO `sys_oper_log` VALUES (544, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"6\",\"menuName\":\"设备分享\",\"params\":{},\"parentId\":2007,\"isCache\":\"0\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"F\",\"perms\":\"iot:deviceUser:share\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:08:40');
INSERT INTO `sys_oper_log` VALUES (545, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"orderNum\":\"7\",\"menuName\":\"设备定时\",\"params\":{},\"parentId\":2007,\"isCache\":\"0\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"F\",\"perms\":\"iot:device:timer\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:10:30');
INSERT INTO `sys_oper_log` VALUES (546, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"6\",\"menuName\":\"设备分享\",\"params\":{},\"parentId\":2007,\"isCache\":\"0\",\"path\":\"\",\"children\":[],\"createTime\":1654794520000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2147,\"menuType\":\"F\",\"perms\":\"iot:device:share\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:10:46');
INSERT INTO `sys_oper_log` VALUES (547, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"管理产品和设备的用户分配该权限\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1639644090000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"menuIds\":[1,107,2129,2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2044,2045,2046,2047,2048,2140,2136,2137,2138,2139,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:12:57');
INSERT INTO `sys_oper_log` VALUES (548, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":3,\"admin\":false,\"remark\":\"设备的最终用户，只能管理设备\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"3\",\"deptCheckStrictly\":true,\"createTime\":1639575378000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"general\",\"roleName\":\"普通用户\",\"menuIds\":[2000,1,107,2129,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:13:13');
INSERT INTO `sys_oper_log` VALUES (549, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":3,\"admin\":false,\"remark\":\"设备的最终用户，只能管理设备和分组\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"3\",\"deptCheckStrictly\":true,\"createTime\":1639575378000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"general\",\"roleName\":\"普通用户\",\"menuIds\":[2000,1,107,2129,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:13:37');
INSERT INTO `sys_oper_log` VALUES (550, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"管理产品和设备\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1639644090000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"menuIds\":[1,107,2129,2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2044,2045,2046,2047,2048,2140,2136,2137,2138,2139,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:13:56');
INSERT INTO `sys_oper_log` VALUES (551, '定时任务', 1, 'com.ruoyi.iot.controller.DeviceJobController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"deviceId\":25,\"deviceName\":\"室内检测仪(T1)\",\"productName\":\"体温检测仪(T1)\",\"nextValidTime\":1654881600000,\"sceneId\":0,\"alertId\":0,\"jobType\":1,\"jobName\":\"定时打开\",\"serialNumber\":\"D2E498HG82P7\",\"productId\":14,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 20 01 ? * 1,2,3,4,5,6,7\",\"jobId\":7,\"createBy\":\"wumei-t1\",\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"switch\\\",\\\"name\\\":\\\"设备开关\\\",\\\"value\\\":\\\"1\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":25,\\\"deviceName\\\":\\\"室内检测仪(T1)\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1},{\\\"id\\\":\\\"gear\\\",\\\"name\\\":\\\"运行档位\\\",\\\"value\\\":\\\"0\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":25,\\\"deviceName\\\":\\\"室内检测仪(T1)\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:21:26');
INSERT INTO `sys_oper_log` VALUES (552, '定时任务', 2, 'com.ruoyi.iot.controller.DeviceJobController.edit()', 'PUT', 1, 'wumei-t1', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"remark\":\"\",\"deviceId\":25,\"deviceName\":\"室内检测仪(T1)\",\"productName\":\"体温检测仪(T1)\",\"nextValidTime\":1654881600000,\"updateBy\":\"wumei-t1\",\"jobType\":1,\"jobName\":\"定时打开设备(T1)\",\"serialNumber\":\"D2E498HG82P7\",\"productId\":14,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 20 01 ? * 1,2,3,4,5,6,7\",\"jobId\":7,\"createBy\":\"wumei-t1\",\"createTime\":1654795285000,\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"switch\\\",\\\"name\\\":\\\"设备开关\\\",\\\"type\\\":2,\\\"value\\\":\\\"1\\\",\\\"source\\\":2,\\\"deviceId\\\":25,\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1,\\\"deviceName\\\":\\\"室内检测仪(T1)\\\"},{\\\"id\\\":\\\"gear\\\",\\\"name\\\":\\\"运行档位\\\",\\\"type\\\":2,\\\"value\\\":\\\"0\\\",\\\"source\\\":2,\\\"deviceId\\\":25,\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1,\\\"deviceName\\\":\\\"室内检测仪(T1)\\\"}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:21:45');
INSERT INTO `sys_oper_log` VALUES (553, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-u1', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":1,\"groupId\":18,\"remark\":\"用户U1测试数据\",\"params\":{},\"userName\":\"wumei-u1\",\"userId\":4,\"groupName\":\"医疗(U1)\",\"createTime\":1654795463844}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:24:24');
INSERT INTO `sys_oper_log` VALUES (554, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-u1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":27.293884328803593,\"remark\":\"用户U1测试数据\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"productName\":\"体温检测仪(T1)\",\"locationWay\":1,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t1\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":110.65764243603059,\"rssi\":0,\"serialNumber\":\"D41FTPHZYKOX\",\"productId\":14,\"params\":{},\"userName\":\"wumei-u1\",\"networkAddress\":\"中国\",\"userId\":4,\"imgUrl\":\"/profile/iot/2/2022-0610-003915.jpg\",\"createTime\":1654795728593,\"tenantId\":2,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654795728593,\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"firmwareVersion\":1,\"imgUrl\":\"/profile/iot/2/2022-0610-003915.jpg\",\"isShadow\":0,\"latitude\":27.293884328803593,\"locationWay\":1,\"longitude\":110.65764243603059,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":14,\"productName\":\"体温检测仪(T1)\",\"remark\":\"用户U1测试数据\",\"rssi\":0,\"serialNumber\":\"D41FTPHZYKOX\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t1\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":4,\"userName\":\"wumei-u1\"}}', 0, NULL, '2022-06-10 01:28:49');
INSERT INTO `sys_oper_log` VALUES (555, '定时任务', 1, 'com.ruoyi.iot.controller.DeviceJobController.add()', 'POST', 1, 'wumei-u1', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"productName\":\"体温检测仪(T1)\",\"nextValidTime\":1654882140000,\"sceneId\":0,\"alertId\":0,\"jobType\":1,\"jobName\":\"定时打开设备(U1)\",\"serialNumber\":\"D41FTPHZYKOX\",\"productId\":14,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 29 01 ? * 1,2,3,4,5,6,7\",\"jobId\":8,\"createBy\":\"wumei-u1\",\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"switch\\\",\\\"name\\\":\\\"设备开关\\\",\\\"value\\\":\\\"1\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":26,\\\"deviceName\\\":\\\"体温检测仪(U1)\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 01:29:25');
INSERT INTO `sys_oper_log` VALUES (556, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[26],\"groupId\":18}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 13:17:07');
INSERT INTO `sys_oper_log` VALUES (557, '产品授权码', 2, 'com.ruoyi.iot.controller.ProductAuthorizeController.edit()', 'PUT', 1, 'admin', NULL, '/iot/authorize', '127.0.0.1', '内网IP', '{\"serialNumber\":\"D1FL8B1Z37UM\",\"productId\":13,\"updateTime\":1654838540541,\"delFlag\":\"0\",\"params\":{},\"userName\":\"admin\",\"deviceId\":24,\"userId\":1,\"createBy\":\"admin\",\"authorizeId\":166,\"createTime\":1654766693000,\"updateBy\":\"\",\"authorizeCode\":\"ADBFCC8934864B26B55658C66F562AC5\",\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 13:22:20');
INSERT INTO `sys_oper_log` VALUES (558, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"menuIds\":[2000,2049,2001,2043,2013,2019,2007,2067,2085,2098,2104,1,100,101,102,103,104,105,106,107,108,500,501,2123,2129,2,109,110,3,115,2050,2051,2052,2002,2003,2004,2044,2045,2046,2136,2137,2138,2014,2015,2016,2020,2021,2022,2008,2009,2010,2147,2148,2068,2069,2070,2086,2087,2088,2099,2100,2101,2105,2109,2106,2107,2108,2111,2112,2143,2144,1001,1008,1013,1017,1021,1026,1031,1036,1040,1043,2124,2125,2126,2130,2131,2132,2141,1046,1049,111,112,113,114,1055,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 13:53:48');
INSERT INTO `sys_oper_log` VALUES (559, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":5,\"admin\":false,\"remark\":\"普通管理员\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"5\",\"deptCheckStrictly\":true,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"manager\",\"roleName\":\"管理员\",\"menuIds\":[2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2044,2045,2046,2047,2048,2140,2136,2137,2138,2139,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,2104,2105,2109,2106,2107,2108,2111,2112,2143,2144,2145,2146,1,100,1001,1002,1003,1004,1005,1006,1007,101,1008,1009,1010,1011,1012,102,1013,1014,1015,1016,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,105,1026,1027,1028,1029,1030,106,1031,1032,1033,1034,1035,107,1036,1037,1038,1039,108,500,1040,1041,1042,501,1043,1044,1045,2123,2124,2125,2126,2127,2128,2129,2130,2131,2132,2133,2134,2141,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1056,1058,1057,1059,1060,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 13:54:05');
INSERT INTO `sys_oper_log` VALUES (560, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'wumei-u1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":27.293884,\"remark\":\"用户U1测试数据\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"productName\":\"体温检测仪(T1)\",\"locationWay\":1,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t1\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":110.657642,\"rssi\":0,\"serialNumber\":\"D41FTPHZYKOX\",\"productId\":14,\"updateTime\":1654841130204,\"params\":{},\"userName\":\"wumei-u1\",\"networkAddress\":\"中国\",\"userId\":4,\"imgUrl\":\"/profile/iot/2/2022-0610-003915.jpg\",\"createTime\":1654795729000,\"tenantId\":2,\"isShadow\":1,\"status\":1}', '{\"msg\":\"修改成功\",\"code\":200,\"data\":1}', 0, NULL, '2022-06-10 14:05:30');
INSERT INTO `sys_oper_log` VALUES (561, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'admin', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888884\",\"params\":{},\"userName\":\"wumei\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"userId\":6}', NULL, 1, '该用户已添加, 禁止重复添加', '2022-06-10 16:47:18');
INSERT INTO `sys_oper_log` VALUES (562, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'admin', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888883\",\"params\":{},\"userName\":\"wumei-u2\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"userId\":5,\"tenantName\":\"admin\",\"createTime\":1654850901190,\"isOwner\":0,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 16:48:21');
INSERT INTO `sys_oper_log` VALUES (563, '设备用户', 2, 'com.ruoyi.iot.controller.DeviceUserController.edit()', 'PUT', 1, 'admin', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888883\",\"remark\":\"备注信息\",\"updateTime\":1654851002572,\"params\":{},\"userName\":\"wumei-u2\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"userId\":5,\"tenantName\":\"admin\",\"createTime\":1654850901000,\"isOwner\":0,\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-10 16:50:03');
INSERT INTO `sys_oper_log` VALUES (564, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'admin', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888883\",\"params\":{},\"userName\":\"wumei-u2\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"userId\":5}', NULL, 1, '该用户已添加, 禁止重复添加', '2022-06-10 17:05:18');
INSERT INTO `sys_oper_log` VALUES (565, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'admin', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888883\",\"params\":{},\"userName\":\"wumei-u2\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"userId\":5}', NULL, 1, '该用户已添加, 禁止重复添加', '2022-06-10 19:31:07');
INSERT INTO `sys_oper_log` VALUES (566, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'admin', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888883\",\"params\":{},\"userName\":\"wumei-u2\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"userId\":5}', NULL, 1, '该用户已添加, 禁止重复添加', '2022-06-10 19:33:12');
INSERT INTO `sys_oper_log` VALUES (567, '通用物模型', 1, 'com.ruoyi.iot.controller.ThingsModelTemplateController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/template', '127.0.0.1', '内网IP', '{\"identifier\":\"temp_t2\",\"params\":{},\"templateId\":29,\"type\":1,\"specs\":\"{\\\"type\\\":\\\"decimal\\\",\\\"min\\\":20,\\\"max\\\":40,\\\"unit\\\":\\\"℃\\\",\\\"step\\\":0.1}\",\"createBy\":\"wumei-t2\",\"isMonitor\":1,\"tenantName\":\"wumei-t2\",\"createTime\":1654878201394,\"datatype\":\"decimal\",\"templateName\":\"体温(T2)\",\"isTop\":1,\"tenantId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:23:22');
INSERT INTO `sys_oper_log` VALUES (568, '产品分类', 1, 'com.ruoyi.iot.controller.CategoryController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/category', '127.0.0.1', '内网IP', '{\"orderNum\":9,\"remark\":\"租户T2测试数据\",\"params\":{},\"categoryName\":\"医疗器械(T2)\",\"tenantName\":\"wumei-t2\",\"createTime\":1654878241112,\"tenantId\":3,\"categoryId\":15}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:24:02');
INSERT INTO `sys_oper_log` VALUES (569, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K6LDJ88701BXWC8Z\",\"mqttAccount\":\"wumei-smart\",\"remark\":\"租户T2测试数据\",\"categoryName\":\"医疗器械(T2)\",\"productName\":\"温度监测仪(T2)\",\"networkMethod\":3,\"tenantName\":\"wumei-t2\",\"vertificateMethod\":1,\"mqttPassword\":\"PA7Z926LX4LU93YE\",\"deviceType\":1,\"productId\":15,\"params\":{},\"isAuthorize\":0,\"createTime\":1654878655968,\"tenantId\":3,\"categoryId\":15,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":15,\"categoryName\":\"医疗器械(T2)\",\"createTime\":1654878655968,\"deviceType\":1,\"isAuthorize\":0,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"PA7Z926LX4LU93YE\",\"mqttSecret\":\"K6LDJ88701BXWC8Z\",\"networkMethod\":3,\"params\":{},\"productId\":15,\"productName\":\"温度监测仪(T2)\",\"remark\":\"租户T2测试数据\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"vertificateMethod\":1}}', 0, NULL, '2022-06-11 00:30:57');
INSERT INTO `sys_oper_log` VALUES (570, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":15,\"filePath\":\"/profile/iot/3/2022-0611-003131.bin\",\"firmwareId\":12,\"remark\":\"租户T2测试数据\",\"params\":{},\"version\":1.1,\"productName\":\"温度监测仪(T2)\",\"tenantName\":\"wumei-t2\",\"createTime\":1654878704012,\"firmwareName\":\"温度检测仪出厂固件(T2)\",\"tenantId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:31:45');
INSERT INTO `sys_oper_log` VALUES (571, '产品固件', 2, 'com.ruoyi.iot.controller.FirmwareController.edit()', 'PUT', 1, 'wumei-t2', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":15,\"filePath\":\"/profile/iot/3/2022-0611-003131.bin\",\"firmwareId\":12,\"remark\":\"租户T2测试数据\",\"updateTime\":1654878710370,\"params\":{},\"version\":1.1,\"productName\":\"温度监测仪(T2)\",\"tenantName\":\"wumei-t2\",\"createTime\":1654878704000,\"firmwareName\":\"温度检测仪出厂固件(T2)\",\"tenantId\":3,\"isSys\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:31:51');
INSERT INTO `sys_oper_log` VALUES (572, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t2', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":15,\"templateIds\":[9,11],\"productName\":\"温度监测仪(T2)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-11 00:33:18');
INSERT INTO `sys_oper_log` VALUES (573, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t2', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":15,\"templateIds\":[29,27,1,2,3,4,5,6,7,8],\"productName\":\"温度监测仪(T2)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-11 00:33:27');
INSERT INTO `sys_oper_log` VALUES (574, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"1\",\"menuName\":\"设备告警查询\",\"params\":{},\"parentId\":2067,\"isCache\":\"0\",\"path\":\"#\",\"component\":\"\",\"children\":[],\"createTime\":1642065375000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2068,\"menuType\":\"F\",\"perms\":\"iot:alert:query\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:38:10');
INSERT INTO `sys_oper_log` VALUES (575, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"2\",\"menuName\":\"设备告警新增\",\"params\":{},\"parentId\":2067,\"isCache\":\"0\",\"path\":\"#\",\"component\":\"\",\"children\":[],\"createTime\":1642065375000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2069,\"menuType\":\"F\",\"perms\":\"iot:alert:add\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:38:20');
INSERT INTO `sys_oper_log` VALUES (576, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"3\",\"menuName\":\"设备告警修改\",\"params\":{},\"parentId\":2067,\"isCache\":\"0\",\"path\":\"#\",\"component\":\"\",\"children\":[],\"createTime\":1642065375000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2070,\"menuType\":\"F\",\"perms\":\"iot:alert:edit\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:38:29');
INSERT INTO `sys_oper_log` VALUES (577, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"4\",\"menuName\":\"设备告警删除\",\"params\":{},\"parentId\":2067,\"isCache\":\"0\",\"path\":\"#\",\"component\":\"\",\"children\":[],\"createTime\":1642065375000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2071,\"menuType\":\"F\",\"perms\":\"iot:alert:remove\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:38:39');
INSERT INTO `sys_oper_log` VALUES (578, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"#\",\"orderNum\":\"5\",\"menuName\":\"设备告警导出\",\"params\":{},\"parentId\":2067,\"isCache\":\"0\",\"path\":\"#\",\"component\":\"\",\"children\":[],\"createTime\":1642065375000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2072,\"menuType\":\"F\",\"perms\":\"iot:alert:export\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:38:46');
INSERT INTO `sys_oper_log` VALUES (579, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"管理产品和设备\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1639644090000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"menuIds\":[1,107,2129,2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2044,2045,2046,2047,2048,2140,2136,2137,2138,2139,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:39:19');
INSERT INTO `sys_oper_log` VALUES (580, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":3,\"admin\":false,\"remark\":\"设备的最终用户，只能管理设备和分组\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"3\",\"deptCheckStrictly\":true,\"createTime\":1639575378000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"general\",\"roleName\":\"普通用户\",\"menuIds\":[2000,1,107,2129,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:39:30');
INSERT INTO `sys_oper_log` VALUES (581, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"menuIds\":[2000,2049,2001,2043,2013,2019,2007,2067,2085,2098,2104,1,100,101,102,103,104,105,106,107,108,500,501,2123,2129,2,109,110,3,115,2050,2051,2052,2002,2003,2004,2044,2045,2046,2136,2137,2138,2014,2015,2016,2020,2021,2022,2008,2009,2010,2147,2148,2068,2069,2070,2086,2087,2088,2099,2100,2101,2105,2109,2106,2107,2108,2111,2112,2143,2144,1001,1008,1013,1017,1021,1026,1031,1036,1040,1043,2124,2125,2126,2130,2131,2132,2141,1046,1049,111,112,113,114,1055,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:39:50');
INSERT INTO `sys_oper_log` VALUES (582, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":5,\"admin\":false,\"remark\":\"普通管理员\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"5\",\"deptCheckStrictly\":true,\"createTime\":1654840469000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"manager\",\"roleName\":\"管理员\",\"menuIds\":[2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2044,2045,2046,2047,2048,2140,2136,2137,2138,2139,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,2104,2105,2109,2106,2107,2108,2111,2112,2143,2144,2145,2146,1,100,1001,1002,1003,1004,1005,1006,1007,101,1008,1009,1010,1011,1012,102,1013,1014,1015,1016,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,105,1026,1027,1028,1029,1030,106,1031,1032,1033,1034,1035,107,1036,1037,1038,1039,108,500,1040,1041,1042,501,1043,1044,1045,2123,2124,2125,2126,2127,2128,2129,2130,2131,2132,2133,2134,2141,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1056,1058,1057,1059,1060,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:40:01');
INSERT INTO `sys_oper_log` VALUES (583, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":3,\"admin\":false,\"remark\":\"设备的最终用户，只能管理设备和分组\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"3\",\"deptCheckStrictly\":true,\"createTime\":1639575378000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"general\",\"roleName\":\"普通用户\",\"menuIds\":[2000,2067,1,107,2129,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2068,2085,2086,2087,2088,2089,2090,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:40:29');
INSERT INTO `sys_oper_log` VALUES (584, '设备用户', 3, 'com.ruoyi.iot.controller.DeviceUserController.remove()', 'DELETE', 1, 'wumei-t1', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 00:43:36');
INSERT INTO `sys_oper_log` VALUES (585, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888883\",\"params\":{},\"userName\":\"wumei-u2\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"userId\":5,\"tenantName\":\"wumei-t1\",\"createTime\":1654880566643,\"isOwner\":0,\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:02:47');
INSERT INTO `sys_oper_log` VALUES (586, '设备用户', 3, 'com.ruoyi.iot.controller.DeviceUserController.remove()', 'DELETE', 1, 'wumei-t1', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:03:08');
INSERT INTO `sys_oper_log` VALUES (587, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888883\",\"params\":{},\"userName\":\"wumei-u2\",\"deviceId\":26,\"deviceName\":\"体温检测仪(U1)\",\"userId\":5,\"tenantName\":\"wumei-t1\",\"createTime\":1654880600831,\"isOwner\":0,\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:03:21');
INSERT INTO `sys_oper_log` VALUES (588, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"alert\",\"orderNum\":\"7\",\"menuName\":\"设备告警\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"alertLog\",\"component\":\"iot/alertLog/index\",\"children\":[],\"createTime\":1642065375000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2067,\"menuType\":\"C\",\"perms\":\"iot:alert:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:11:47');
INSERT INTO `sys_oper_log` VALUES (589, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":2,\"admin\":false,\"remark\":\"管理产品和设备\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":true,\"createTime\":1639644090000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"tenant\",\"roleName\":\"设备租户\",\"menuIds\":[1,107,2129,2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2044,2045,2046,2047,2048,2140,2136,2137,2138,2139,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:12:09');
INSERT INTO `sys_oper_log` VALUES (590, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":3,\"admin\":false,\"remark\":\"设备的最终用户，只能管理设备和分组\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"3\",\"deptCheckStrictly\":true,\"createTime\":1639575378000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"general\",\"roleName\":\"普通用户\",\"menuIds\":[2000,2067,1,107,2129,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2068,2085,2086,2087,2088,2089,2090,1036,2130,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:12:29');
INSERT INTO `sys_oper_log` VALUES (591, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":4,\"admin\":false,\"remark\":\"只能查询系统数据\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"4\",\"deptCheckStrictly\":true,\"createTime\":1639644270000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客\",\"menuIds\":[2000,2049,2001,2043,2013,2019,2007,2067,2085,2098,2104,1,100,101,102,103,104,105,106,107,108,500,501,2123,2129,2,109,110,3,115,2050,2051,2052,2002,2003,2004,2044,2045,2046,2136,2137,2138,2014,2015,2016,2020,2021,2022,2008,2009,2010,2147,2148,2068,2069,2070,2086,2087,2088,2099,2100,2101,2105,2109,2106,2107,2108,2111,2112,2143,2144,1001,1008,1013,1017,1021,1026,1031,1036,1040,1043,2124,2125,2126,2130,2131,2132,2141,1046,1049,111,112,113,114,1055,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:12:33');
INSERT INTO `sys_oper_log` VALUES (592, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"flag\":false,\"roleId\":5,\"admin\":false,\"remark\":\"普通管理员\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"5\",\"deptCheckStrictly\":true,\"createTime\":1654840469000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"manager\",\"roleName\":\"管理员\",\"menuIds\":[2000,2049,2050,2051,2052,2053,2054,2001,2002,2003,2004,2005,2006,2043,2044,2045,2046,2047,2048,2140,2136,2137,2138,2139,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2007,2008,2009,2010,2011,2012,2147,2148,2067,2068,2069,2070,2071,2072,2085,2086,2087,2088,2089,2090,2098,2099,2100,2101,2102,2103,2104,2105,2109,2106,2107,2108,2111,2112,2143,2144,2145,2146,1,100,1001,1002,1003,1004,1005,1006,1007,101,1008,1009,1010,1011,1012,102,1013,1014,1015,1016,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,105,1026,1027,1028,1029,1030,106,1031,1032,1033,1034,1035,107,1036,1037,1038,1039,108,500,1040,1041,1042,501,1043,1044,1045,2123,2124,2125,2126,2127,2128,2129,2130,2131,2132,2133,2134,2141,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,3,114,115,1055,1056,1058,1057,1059,1060,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:12:38');
INSERT INTO `sys_oper_log` VALUES (593, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'wumei-t2', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":15,\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:14:30');
INSERT INTO `sys_oper_log` VALUES (594, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":1,\"groupId\":19,\"remark\":\"租户T2测试数据\",\"params\":{},\"userName\":\"wumei-t2\",\"userId\":3,\"groupName\":\"医疗(T2)\",\"createTime\":1654881368097}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:16:09');
INSERT INTO `sys_oper_log` VALUES (595, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":37.89061116129481,\"remark\":\"租户T2测试数据\",\"deviceId\":27,\"deviceName\":\"体温检测设备(T2)\",\"productName\":\"温度监测仪(T2)\",\"locationWay\":1,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"brightness\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_admin\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"report_monitor\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":109.41619130847573,\"rssi\":0,\"serialNumber\":\"D302GN39PLN5\",\"productId\":15,\"params\":{},\"userName\":\"wumei-t2\",\"networkAddress\":\"中国\",\"userId\":3,\"createTime\":1654881516820,\"tenantId\":3,\"isShadow\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654881516820,\"deviceId\":27,\"deviceName\":\"体温检测设备(T2)\",\"firmwareVersion\":1,\"isShadow\":0,\"latitude\":37.89061116129481,\"locationWay\":1,\"longitude\":109.41619130847573,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":15,\"productName\":\"温度监测仪(T2)\",\"remark\":\"租户T2测试数据\",\"rssi\":0,\"serialNumber\":\"D302GN39PLN5\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"brightness\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_admin\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"report_monitor\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":3,\"userName\":\"wumei-t2\"}}', 0, NULL, '2022-06-11 01:18:38');
INSERT INTO `sys_oper_log` VALUES (596, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":1,\"groupId\":20,\"remark\":\"用户U2测试数据\",\"params\":{},\"userName\":\"wumei-u2\",\"userId\":5,\"groupName\":\"医疗(U2)\",\"createTime\":1654882160442}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 01:29:21');
INSERT INTO `sys_oper_log` VALUES (597, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":34.90766241709679,\"remark\":\"用户U2测试数据\",\"deviceId\":28,\"deviceName\":\"体温检测仪(U2)\",\"productName\":\"温度监测仪(T2)\",\"locationWay\":1,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"brightness\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_admin\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"report_monitor\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":113.52002720518203,\"rssi\":0,\"serialNumber\":\"D5IN2B08QN01\",\"productId\":15,\"params\":{},\"userName\":\"wumei-u2\",\"networkAddress\":\"中国\",\"userId\":5,\"createTime\":1654885560506,\"tenantId\":3,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654885560506,\"deviceId\":28,\"deviceName\":\"体温检测仪(U2)\",\"firmwareVersion\":1,\"isShadow\":1,\"latitude\":34.90766241709679,\"locationWay\":1,\"longitude\":113.52002720518203,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":15,\"productName\":\"温度监测仪(T2)\",\"remark\":\"用户U2测试数据\",\"rssi\":0,\"serialNumber\":\"D5IN2B08QN01\",\"status\":1,\"tenantId\":3,\"tenantName\":\"wumei-t2\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"co2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"brightness\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_admin\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t2\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"message\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"report_monitor\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":5,\"userName\":\"wumei-u2\"}}', 0, NULL, '2022-06-11 02:26:02');
INSERT INTO `sys_oper_log` VALUES (598, '定时任务', 1, 'com.ruoyi.iot.controller.DeviceJobController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"deviceId\":28,\"deviceName\":\"体温检测仪(U2)\",\"productName\":\"温度监测仪(T2)\",\"nextValidTime\":1654972020000,\"sceneId\":0,\"alertId\":0,\"jobType\":1,\"jobName\":\"定时上报数据\",\"serialNumber\":\"D5IN2B08QN01\",\"productId\":15,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 27 02 ? * 1,2,3,4,5,6,7\",\"jobId\":9,\"createBy\":\"wumei-u2\",\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"report_monitor\\\",\\\"name\\\":\\\"上报监测数据\\\",\\\"value\\\":\\\"1\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":28,\\\"deviceName\\\":\\\"体温检测仪(U2)\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 02:27:53');
INSERT INTO `sys_oper_log` VALUES (599, '定时任务', 2, 'com.ruoyi.iot.controller.DeviceJobController.edit()', 'PUT', 1, 'wumei-u2', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"remark\":\"\",\"deviceId\":28,\"deviceName\":\"体温检测仪(U2)\",\"productName\":\"温度监测仪(T2)\",\"nextValidTime\":1654972020000,\"updateBy\":\"wumei-u2\",\"jobType\":1,\"jobName\":\"定时上报数据(U2)\",\"serialNumber\":\"D5IN2B08QN01\",\"productId\":15,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 27 02 ? * 1,2,3,4,5,6,7\",\"jobId\":9,\"createBy\":\"wumei-u2\",\"createTime\":1654885672000,\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"report_monitor\\\",\\\"name\\\":\\\"上报监测数据\\\",\\\"type\\\":2,\\\"value\\\":\\\"1\\\",\\\"source\\\":2,\\\"deviceId\\\":28,\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1,\\\"deviceName\\\":\\\"体温检测仪(U2)\\\"}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 02:28:16');
INSERT INTO `sys_oper_log` VALUES (600, '定时任务', 1, 'com.ruoyi.iot.controller.DeviceJobController.add()', 'POST', 1, 'wumei-t2', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"deviceId\":27,\"deviceName\":\"体温检测设备(T2)\",\"productName\":\"温度监测仪(T2)\",\"nextValidTime\":1654972200000,\"sceneId\":0,\"alertId\":0,\"jobType\":1,\"jobName\":\"定时调整档位(U2)\",\"serialNumber\":\"D302GN39PLN5\",\"productId\":15,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 30 02 ? * 1,2,3,4,5,6,7\",\"jobId\":10,\"createBy\":\"wumei-t2\",\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"gear\\\",\\\"name\\\":\\\"运行档位\\\",\\\"value\\\":\\\"1\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":27,\\\"deviceName\\\":\\\"体温检测设备(T2)\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1},{\\\"id\\\":\\\"report_monitor\\\",\\\"name\\\":\\\"上报监测数据\\\",\\\"value\\\":\\\"1\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":27,\\\"deviceName\\\":\\\"体温检测设备(T2)\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-11 02:30:48');
INSERT INTO `sys_oper_log` VALUES (601, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K5J6CVL77S5AOA8X\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"智能开关(T1)\",\"networkMethod\":1,\"tenantName\":\"wumei-t1\",\"vertificateMethod\":1,\"mqttPassword\":\"PT8314A02U3B41R9\",\"deviceType\":1,\"productId\":16,\"params\":{},\"isAuthorize\":0,\"createTime\":1654965653223,\"tenantId\":2,\"categoryId\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":1,\"categoryName\":\"电工照明\",\"createTime\":1654965653223,\"deviceType\":1,\"isAuthorize\":0,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"PT8314A02U3B41R9\",\"mqttSecret\":\"K5J6CVL77S5AOA8X\",\"networkMethod\":1,\"params\":{},\"productId\":16,\"productName\":\"智能开关(T1)\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"vertificateMethod\":1}}', 0, NULL, '2022-06-12 00:40:55');
INSERT INTO `sys_oper_log` VALUES (602, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t1', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":16,\"templateIds\":[5],\"productName\":\"智能开关(T1)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-12 00:41:04');
INSERT INTO `sys_oper_log` VALUES (603, '产品固件', 1, 'com.ruoyi.iot.controller.FirmwareController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/firmware', '127.0.0.1', '内网IP', '{\"productId\":16,\"filePath\":\"/profile/iot/2/2022-0612-004129.bin\",\"firmwareId\":13,\"params\":{},\"version\":1,\"productName\":\"智能开关(T1)\",\"tenantName\":\"wumei-t1\",\"createTime\":1654965691699,\"firmwareName\":\"智能开关(T1)\",\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 00:41:33');
INSERT INTO `sys_oper_log` VALUES (604, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t1', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":16,\"templateIds\":[11],\"productName\":\"智能开关(T1)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-12 00:41:53');
INSERT INTO `sys_oper_log` VALUES (605, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t1', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":16,\"templateIds\":[7],\"productName\":\"智能开关(T1)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-12 00:42:16');
INSERT INTO `sys_oper_log` VALUES (606, '物模型', 2, 'com.ruoyi.iot.controller.ThingsModelController.edit()', 'PUT', 1, 'wumei-t1', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"light_color\",\"productId\":16,\"modelId\":78,\"updateTime\":1654965741635,\"params\":{},\"type\":2,\"productName\":\"智能开关(T1)\",\"modelName\":\"灯光颜色\",\"specs\":\"{\\\"type\\\":\\\"array\\\",\\\"arrayType\\\":\\\"int\\\"}\",\"isMonitor\":0,\"tenantName\":\"wumei-t1\",\"datatype\":\"array\",\"isTop\":1,\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 00:42:23');
INSERT INTO `sys_oper_log` VALUES (607, '物模型', 2, 'com.ruoyi.iot.controller.ThingsModelController.edit()', 'PUT', 1, 'wumei-t1', NULL, '/iot/model', '127.0.0.1', '内网IP', '{\"identifier\":\"light_color\",\"productId\":16,\"modelId\":78,\"updateTime\":1654965747675,\"params\":{},\"type\":2,\"productName\":\"智能开关(T1)\",\"modelName\":\"灯光颜色\",\"specs\":\"{\\\"type\\\":\\\"array\\\",\\\"arrayType\\\":\\\"int\\\"}\",\"isMonitor\":0,\"tenantName\":\"wumei-t1\",\"datatype\":\"array\",\"isTop\":1,\"tenantId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 00:42:30');
INSERT INTO `sys_oper_log` VALUES (608, '更新产品状态', 2, 'com.ruoyi.iot.controller.ProductController.changeProductStatus()', 'PUT', 1, 'wumei-t1', NULL, '/iot/product/status/', '127.0.0.1', '内网IP', '{\"productId\":16,\"status\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 00:42:39');
INSERT INTO `sys_oper_log` VALUES (609, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":39.870869,\"deviceId\":29,\"deviceName\":\"智能开关(T1)\",\"productName\":\"智能开关(T1)\",\"locationWay\":3,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":116.388171,\"rssi\":0,\"serialNumber\":\"D2P4IU4E50HJ\",\"productId\":16,\"params\":{},\"userName\":\"wumei-t1\",\"networkAddress\":\"中国\",\"userId\":2,\"createTime\":1654965855121,\"tenantId\":2,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654965855121,\"deviceId\":29,\"deviceName\":\"智能开关(T1)\",\"firmwareVersion\":1,\"isShadow\":1,\"latitude\":39.870869,\"locationWay\":3,\"longitude\":116.388171,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":16,\"productName\":\"智能开关(T1)\",\"rssi\":0,\"serialNumber\":\"D2P4IU4E50HJ\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":2,\"userName\":\"wumei-t1\"}}', 0, NULL, '2022-06-12 00:44:17');
INSERT INTO `sys_oper_log` VALUES (610, '定时任务', 1, 'com.ruoyi.iot.controller.DeviceJobController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"deviceId\":29,\"deviceName\":\"智能开关(T1)\",\"productName\":\"智能开关(T1)\",\"nextValidTime\":1655031600000,\"sceneId\":0,\"alertId\":0,\"jobType\":1,\"jobName\":\"智能开关打开(T1)\",\"serialNumber\":\"D2P4IU4E50HJ\",\"productId\":16,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 00 19 ? * 1,2,3,4,5,6,7\",\"jobId\":11,\"createBy\":\"wumei-t1\",\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"switch\\\",\\\"name\\\":\\\"设备开关\\\",\\\"value\\\":\\\"1\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":29,\\\"deviceName\\\":\\\"智能开关(T1)\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 00:45:02');
INSERT INTO `sys_oper_log` VALUES (611, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'wumei-t1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":35.498394,\"remark\":\"租户T1测试数据\",\"deviceId\":25,\"deviceName\":\"体温检测设备(T1)\",\"productName\":\"体温检测仪(T1)\",\"locationWay\":1,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"temperature\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"humidity\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"temp_t1\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"gear\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":112.496093,\"rssi\":0,\"serialNumber\":\"D2E498HG82P7\",\"productId\":14,\"updateTime\":1654966339633,\"params\":{},\"userName\":\"wumei-t1\",\"networkAddress\":\"中国\",\"userId\":2,\"imgUrl\":\"/profile/iot/2/2022-0610-003915.jpg\",\"createTime\":1654793363000,\"tenantId\":2,\"isShadow\":0,\"status\":1}', '{\"msg\":\"修改成功\",\"code\":200,\"data\":1}', 0, NULL, '2022-06-12 00:52:21');
INSERT INTO `sys_oper_log` VALUES (612, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":2,\"groupId\":21,\"params\":{},\"userName\":\"wumei-u2\",\"userId\":5,\"groupName\":\"电工照明\",\"createTime\":1654966617234}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 00:56:59');
INSERT INTO `sys_oper_log` VALUES (613, '分组', 2, 'com.ruoyi.iot.controller.GroupController.edit()', 'PUT', 1, 'wumei-u2', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":2,\"groupId\":21,\"remark\":\"用户U2测试数据\",\"updateTime\":1654966631650,\"params\":{},\"userName\":\"wumei-u2\",\"userId\":5,\"groupName\":\"电工照明\",\"createTime\":1654966617000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 00:57:13');
INSERT INTO `sys_oper_log` VALUES (614, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":32.17649530477937,\"deviceId\":30,\"deviceName\":\"智能开关(U2)\",\"productName\":\"智能开关(T1)\",\"locationWay\":1,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1,\"longitude\":103.79244014209445,\"rssi\":0,\"serialNumber\":\"D5BE0D756D24\",\"productId\":16,\"params\":{},\"userName\":\"wumei-u2\",\"networkAddress\":\"中国\",\"userId\":5,\"createTime\":1654967165877,\"tenantId\":2,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654967165877,\"deviceId\":30,\"deviceName\":\"智能开关(U2)\",\"firmwareVersion\":1,\"isShadow\":1,\"latitude\":32.17649530477937,\"locationWay\":1,\"longitude\":103.79244014209445,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":16,\"productName\":\"智能开关(T1)\",\"rssi\":0,\"serialNumber\":\"D5BE0D756D24\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":5,\"userName\":\"wumei-u2\"}}', 0, NULL, '2022-06-12 01:06:08');
INSERT INTO `sys_oper_log` VALUES (615, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888882\",\"params\":{},\"userName\":\"wumei-u1\",\"deviceId\":30,\"deviceName\":\"智能开关(U2)\",\"userId\":4,\"tenantName\":\"wumei-u2\",\"createTime\":1654967830788,\"isOwner\":0,\"tenantId\":5}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 01:17:12');
INSERT INTO `sys_oper_log` VALUES (616, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888882\",\"params\":{},\"userName\":\"wumei-u1\",\"deviceId\":28,\"deviceName\":\"体温检测仪(U2)\",\"userId\":4,\"tenantName\":\"wumei-u2\",\"createTime\":1654967849585,\"isOwner\":0,\"tenantId\":5}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 01:17:31');
INSERT INTO `sys_oper_log` VALUES (617, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888882\",\"params\":{},\"userName\":\"wumei-u1\",\"deviceId\":26,\"deviceName\":\"体温检测设备(U1)\",\"userId\":4,\"tenantName\":\"wumei-u2\",\"createTime\":1654967874568,\"isOwner\":0,\"tenantId\":5}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'26-4\' for key \'PRIMARY\'\r\n### The error may exist in file [D:\\project\\gitee\\wumei-smart\\springboot\\wumei-iot\\target\\classes\\mapper\\iot\\DeviceUserMapper.xml]\r\n### The error may involve com.ruoyi.iot.mapper.DeviceUserMapper.insertDeviceUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into iot_device_user          ( device_id,             user_id,             device_name,             user_name,             is_owner,             tenant_id,             tenant_name,             phonenumber,                                       create_time )           values ( ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,                                       ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'26-4\' for key \'PRIMARY\'\n; Duplicate entry \'26-4\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'26-4\' for key \'PRIMARY\'', '2022-06-12 01:17:56');
INSERT INTO `sys_oper_log` VALUES (618, '设备用户', 1, 'com.ruoyi.iot.controller.DeviceUserController.add()', 'POST', 1, 'wumei-u2', NULL, '/iot/deviceUser', '127.0.0.1', '内网IP', '{\"phonenumber\":\"15888888882\",\"params\":{},\"userName\":\"wumei-u1\",\"deviceId\":26,\"deviceName\":\"体温检测设备(U1)\",\"userId\":4}', NULL, 1, '该用户已添加, 禁止重复添加', '2022-06-12 01:29:19');
INSERT INTO `sys_oper_log` VALUES (619, '分组', 1, 'com.ruoyi.iot.controller.GroupController.add()', 'POST', 1, 'wumei-u1', NULL, '/iot/group', '127.0.0.1', '内网IP', '{\"groupOrder\":2,\"groupId\":22,\"params\":{},\"userName\":\"wumei-u1\",\"userId\":4,\"groupName\":\"电工照明(U1)\",\"createTime\":1654968899014}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 01:35:00');
INSERT INTO `sys_oper_log` VALUES (620, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[30],\"groupId\":22}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 01:35:25');
INSERT INTO `sys_oper_log` VALUES (621, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[26,28],\"groupId\":18}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 01:35:32');
INSERT INTO `sys_oper_log` VALUES (622, '设备', 1, 'com.ruoyi.iot.controller.DeviceController.add()', 'POST', 1, 'wumei-u1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":27.100544217974445,\"deviceId\":31,\"deviceName\":\"智能开关\",\"productName\":\"智能开关(T1)\",\"locationWay\":1,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1.1,\"longitude\":105.27090423329324,\"rssi\":0,\"serialNumber\":\"D43MU367RLU7\",\"productId\":16,\"params\":{},\"userName\":\"wumei-u1\",\"networkAddress\":\"中国\",\"userId\":4,\"createTime\":1654968993416,\"tenantId\":2,\"isShadow\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"createTime\":1654968993416,\"deviceId\":31,\"deviceName\":\"智能开关\",\"firmwareVersion\":1.1,\"isShadow\":1,\"latitude\":27.100544217974445,\"locationWay\":1,\"longitude\":105.27090423329324,\"networkAddress\":\"中国\",\"networkIp\":\"127.0.0.1\",\"params\":{},\"productId\":16,\"productName\":\"智能开关(T1)\",\"rssi\":0,\"serialNumber\":\"D43MU367RLU7\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"userId\":4,\"userName\":\"wumei-u1\"}}', 0, NULL, '2022-06-12 01:36:35');
INSERT INTO `sys_oper_log` VALUES (623, '定时任务', 1, 'com.ruoyi.iot.controller.DeviceJobController.add()', 'POST', 1, 'wumei-u1', NULL, '/iot/job', '127.0.0.1', '内网IP', '{\"isAdvance\":0,\"concurrent\":\"1\",\"deviceId\":31,\"deviceName\":\"智能开关\",\"productName\":\"智能开关(T1)\",\"nextValidTime\":1655033760000,\"sceneId\":0,\"alertId\":0,\"jobType\":1,\"jobName\":\"定时打开开关\",\"serialNumber\":\"D43MU367RLU7\",\"productId\":16,\"jobGroup\":\"DEFAULT\",\"params\":{},\"cronExpression\":\"0 36 19 ? * 1,2,3,4,5,6,7\",\"jobId\":12,\"createBy\":\"wumei-u1\",\"misfirePolicy\":\"2\",\"actions\":\"[{\\\"id\\\":\\\"switch\\\",\\\"name\\\":\\\"设备开关\\\",\\\"value\\\":\\\"1\\\",\\\"type\\\":2,\\\"source\\\":2,\\\"deviceId\\\":31,\\\"deviceName\\\":\\\"智能开关\\\",\\\"alertName\\\":\\\"\\\",\\\"alertLevel\\\":1}]\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 01:37:05');
INSERT INTO `sys_oper_log` VALUES (624, '设备', 2, 'com.ruoyi.iot.controller.DeviceController.edit()', 'PUT', 1, 'wumei-u1', NULL, '/iot/device', '127.0.0.1', '内网IP', '{\"networkIp\":\"127.0.0.1\",\"latitude\":27.100544,\"deviceId\":31,\"deviceName\":\"智能开关(U1)\",\"productName\":\"智能开关(T1)\",\"locationWay\":1,\"tenantName\":\"wumei-t1\",\"thingsModelValue\":\"[{\\\"id\\\":\\\"light_color\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"},{\\\"id\\\":\\\"switch\\\",\\\"shadow\\\":\\\"\\\",\\\"value\\\":\\\"\\\"}]\",\"firmwareVersion\":1.1,\"longitude\":105.270904,\"rssi\":0,\"serialNumber\":\"D43MU367RLU7\",\"productId\":16,\"updateTime\":1654969051286,\"params\":{},\"userName\":\"wumei-u1\",\"networkAddress\":\"中国\",\"userId\":4,\"createTime\":1654968993000,\"tenantId\":2,\"isShadow\":1,\"status\":1}', '{\"msg\":\"修改成功\",\"code\":200,\"data\":1}', 0, NULL, '2022-06-12 01:37:32');
INSERT INTO `sys_oper_log` VALUES (625, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"groupId\":18}', NULL, 1, '', '2022-06-12 01:38:29');
INSERT INTO `sys_oper_log` VALUES (626, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[30,31],\"groupId\":22}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 01:38:42');
INSERT INTO `sys_oper_log` VALUES (627, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"groupId\":18}', NULL, 1, '', '2022-06-12 01:38:50');
INSERT INTO `sys_oper_log` VALUES (628, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"groupId\":18}', NULL, 1, '', '2022-06-12 01:40:03');
INSERT INTO `sys_oper_log` VALUES (629, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[28,26],\"groupId\":18}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 01:42:20');
INSERT INTO `sys_oper_log` VALUES (630, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"groupId\":18}', NULL, 1, '', '2022-06-12 01:44:56');
INSERT INTO `sys_oper_log` VALUES (631, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"groupId\":18}', NULL, 1, '', '2022-06-12 01:51:59');
INSERT INTO `sys_oper_log` VALUES (632, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"groupId\":18}', NULL, 1, '', '2022-06-12 01:52:06');
INSERT INTO `sys_oper_log` VALUES (633, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"groupId\":18}', NULL, 1, '', '2022-06-12 01:53:47');
INSERT INTO `sys_oper_log` VALUES (634, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[26],\"groupId\":18}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 01:54:52');
INSERT INTO `sys_oper_log` VALUES (635, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[26,26],\"groupId\":18}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'26-18\' for key \'PRIMARY\'\r\n### The error may exist in file [D:\\project\\gitee\\wumei-smart\\springboot\\wumei-iot\\target\\classes\\mapper\\iot\\GroupMapper.xml]\r\n### The error may involve com.ruoyi.iot.mapper.GroupMapper.insertDeviceGroups-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into iot_device_group (device_id,group_id)         values                         ( ?,? )                         , ( ?,? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'26-18\' for key \'PRIMARY\'\n; Duplicate entry \'26-18\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'26-18\' for key \'PRIMARY\'', '2022-06-12 02:01:02');
INSERT INTO `sys_oper_log` VALUES (636, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[26],\"groupId\":18}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 02:05:37');
INSERT INTO `sys_oper_log` VALUES (637, '设备分组', 2, 'com.ruoyi.iot.controller.GroupController.updateDeviceGroups()', 'PUT', 1, 'wumei-u1', NULL, '/iot/group/updateDeviceGroups', '127.0.0.1', '内网IP', '{\"deviceIds\":[26,28],\"groupId\":18}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 02:05:44');
INSERT INTO `sys_oper_log` VALUES (638, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', NULL, '/system/user/125', '127.0.0.1', '内网IP', '{userIds=125}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 02:29:05');
INSERT INTO `sys_oper_log` VALUES (639, '产品', 1, 'com.ruoyi.iot.controller.ProductController.add()', 'POST', 1, 'wumei-t1', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K3BIV4Q56A053E6G\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"七彩灯(T1)\",\"networkMethod\":1,\"tenantName\":\"wumei-t1\",\"vertificateMethod\":3,\"mqttPassword\":\"PJ32XIETI24YM924\",\"deviceType\":1,\"productId\":17,\"params\":{},\"isAuthorize\":1,\"imgUrl\":\"/profile/iot/2/2022-0612-115417.jpg\",\"createTime\":1655006059397,\"tenantId\":2,\"categoryId\":1,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"categoryId\":1,\"categoryName\":\"电工照明\",\"createTime\":1655006059397,\"deviceType\":1,\"imgUrl\":\"/profile/iot/2/2022-0612-115417.jpg\",\"isAuthorize\":1,\"mqttAccount\":\"wumei-smart\",\"mqttPassword\":\"PJ32XIETI24YM924\",\"mqttSecret\":\"K3BIV4Q56A053E6G\",\"networkMethod\":1,\"params\":{},\"productId\":17,\"productName\":\"七彩灯(T1)\",\"status\":1,\"tenantId\":2,\"tenantName\":\"wumei-t1\",\"vertificateMethod\":3}}', 0, NULL, '2022-06-12 11:54:21');
INSERT INTO `sys_oper_log` VALUES (640, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t1', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":17,\"templateIds\":[1,2,4,5,7],\"productName\":\"七彩灯(T1)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-12 11:54:45');
INSERT INTO `sys_oper_log` VALUES (641, '导入物模型', 1, 'com.ruoyi.iot.controller.ThingsModelController.ImportByTemplateIds()', 'POST', 1, 'wumei-t1', NULL, '/iot/model/import', '127.0.0.1', '内网IP', '{\"productId\":17,\"templateIds\":[11,10,9],\"productName\":\"七彩灯(T1)\"}', '{\"msg\":\"数据导入成功\",\"code\":200}', 0, NULL, '2022-06-12 11:55:02');
INSERT INTO `sys_oper_log` VALUES (642, '产品', 2, 'com.ruoyi.iot.controller.ProductController.edit()', 'PUT', 1, 'wumei-t1', NULL, '/iot/product', '127.0.0.1', '内网IP', '{\"mqttSecret\":\"K3BIV4Q56A053E6G\",\"mqttAccount\":\"wumei-smart\",\"categoryName\":\"电工照明\",\"productName\":\"调色七彩灯(T1)\",\"networkMethod\":1,\"tenantName\":\"wumei-t1\",\"vertificateMethod\":3,\"mqttPassword\":\"PJ32XIETI24YM924\",\"deviceType\":1,\"productId\":17,\"updateTime\":1655006135878,\"params\":{},\"isAuthorize\":1,\"imgUrl\":\"/profile/iot/2/2022-0612-115417.jpg\",\"createTime\":1655006059000,\"tenantId\":2,\"categoryId\":1,\"isSys\":0,\"status\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-12 11:55:37');

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
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '设备租户', 'tenant', 2, '5', 1, 1, '0', '0', 'admin', '2021-12-16 16:41:30', 'admin', '2022-06-11 01:12:08', '管理产品和设备');
INSERT INTO `sys_role` VALUES (3, '普通用户', 'general', 3, '5', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-06-11 01:12:28', '设备的最终用户，只能管理设备和分组');
INSERT INTO `sys_role` VALUES (4, '游客', 'visitor', 4, '1', 1, 1, '0', '0', 'admin', '2021-12-16 16:44:30', 'admin', '2022-06-11 01:12:32', '只能查询系统数据');
INSERT INTO `sys_role` VALUES (5, '管理员', 'manager', 5, '1', 1, 1, '0', '0', 'admin', '2022-06-10 13:54:29', 'admin', '2022-06-11 01:12:37', '普通管理员');

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
INSERT INTO `sys_role_menu` VALUES (4, 2004);
INSERT INTO `sys_role_menu` VALUES (4, 2007);
INSERT INTO `sys_role_menu` VALUES (4, 2008);
INSERT INTO `sys_role_menu` VALUES (4, 2009);
INSERT INTO `sys_role_menu` VALUES (4, 2010);
INSERT INTO `sys_role_menu` VALUES (4, 2013);
INSERT INTO `sys_role_menu` VALUES (4, 2014);
INSERT INTO `sys_role_menu` VALUES (4, 2015);
INSERT INTO `sys_role_menu` VALUES (4, 2016);
INSERT INTO `sys_role_menu` VALUES (4, 2019);
INSERT INTO `sys_role_menu` VALUES (4, 2020);
INSERT INTO `sys_role_menu` VALUES (4, 2021);
INSERT INTO `sys_role_menu` VALUES (4, 2022);
INSERT INTO `sys_role_menu` VALUES (4, 2043);
INSERT INTO `sys_role_menu` VALUES (4, 2044);
INSERT INTO `sys_role_menu` VALUES (4, 2045);
INSERT INTO `sys_role_menu` VALUES (4, 2046);
INSERT INTO `sys_role_menu` VALUES (4, 2049);
INSERT INTO `sys_role_menu` VALUES (4, 2050);
INSERT INTO `sys_role_menu` VALUES (4, 2051);
INSERT INTO `sys_role_menu` VALUES (4, 2052);
INSERT INTO `sys_role_menu` VALUES (4, 2067);
INSERT INTO `sys_role_menu` VALUES (4, 2068);
INSERT INTO `sys_role_menu` VALUES (4, 2069);
INSERT INTO `sys_role_menu` VALUES (4, 2070);
INSERT INTO `sys_role_menu` VALUES (4, 2085);
INSERT INTO `sys_role_menu` VALUES (4, 2086);
INSERT INTO `sys_role_menu` VALUES (4, 2087);
INSERT INTO `sys_role_menu` VALUES (4, 2088);
INSERT INTO `sys_role_menu` VALUES (4, 2098);
INSERT INTO `sys_role_menu` VALUES (4, 2099);
INSERT INTO `sys_role_menu` VALUES (4, 2100);
INSERT INTO `sys_role_menu` VALUES (4, 2101);
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
INSERT INTO `sys_role_menu` VALUES (4, 2126);
INSERT INTO `sys_role_menu` VALUES (4, 2129);
INSERT INTO `sys_role_menu` VALUES (4, 2130);
INSERT INTO `sys_role_menu` VALUES (4, 2131);
INSERT INTO `sys_role_menu` VALUES (4, 2132);
INSERT INTO `sys_role_menu` VALUES (4, 2136);
INSERT INTO `sys_role_menu` VALUES (4, 2137);
INSERT INTO `sys_role_menu` VALUES (4, 2138);
INSERT INTO `sys_role_menu` VALUES (4, 2141);
INSERT INTO `sys_role_menu` VALUES (4, 2143);
INSERT INTO `sys_role_menu` VALUES (4, 2144);
INSERT INTO `sys_role_menu` VALUES (4, 2147);
INSERT INTO `sys_role_menu` VALUES (4, 2148);
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
) ENGINE = InnoDB AUTO_INCREMENT = 126 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '物美智能管理员', '00', '164770707@qq.com', '15888888888', '0', '', '$2a$10$0Duw0QB6s7YnQEaNSdSVWeXHMmSa090pG15ZXpf.CQEzEhgxyr7IO', '0', '0', '127.0.0.1', '2022-06-14 15:56:31', 'admin', '2021-12-15 21:36:18', '', '2022-06-14 15:56:30', '管理员');
INSERT INTO `sys_user` VALUES (2, 100, 'wumei-t1', '物美租户壹', '00', '', '15888888880', '0', '', '$2a$10$BAWId9C2Nrcwklzl1Ikoau4iqL8XRGvfRjq6Wl.PXWpzwAw0sXMdK', '0', '0', '127.0.0.1', '2022-06-12 14:33:02', 'admin', '2022-04-15 16:21:25', 'admin', '2022-06-12 14:33:03', NULL);
INSERT INTO `sys_user` VALUES (3, 100, 'wumei-t2', '物美租户贰', '00', '', '15888888881', '0', '', '$2a$10$1zMlbW7hGpzA59gpzWGO/ObeASziQ296evjMjHrYdZnxKBLU4WUum', '0', '0', '127.0.0.1', '2022-06-12 00:54:28', 'admin', '2022-04-15 16:22:08', 'admin', '2022-06-12 00:54:30', NULL);
INSERT INTO `sys_user` VALUES (4, 100, 'wumei-u1', '物美用户壹', '00', '', '15888888882', '0', '', '$2a$10$691RJMXZ9HM4sgNTExLPfO5Nw6J6cWgCvcoF9V.jKMnPk5o/8c9VS', '0', '0', '127.0.0.1', '2022-06-12 14:58:59', 'admin', '2022-04-15 16:22:37', 'admin', '2022-06-12 14:59:00', NULL);
INSERT INTO `sys_user` VALUES (5, 100, 'wumei-u2', '物美用户贰', '00', '', '15888888883', '0', '', '$2a$10$x3rM39rewwbi7ayvriGMEOKUHoPCqcL2CYXPLTJRCWYPVvykFIYJq', '0', '0', '127.0.0.1', '2022-06-12 00:55:45', 'admin', '2022-04-15 16:23:13', 'admin', '2022-06-12 00:55:46', NULL);
INSERT INTO `sys_user` VALUES (6, 100, 'wumei', '游客账号', '00', '', '15888888884', '0', '', '$2a$10$kKeZptrTnSlm0fencX4U2eq.QiaukDs.DckiUsMCwVTxh0IS2LRQ.', '0', '0', '127.0.0.1', '2022-06-12 14:56:47', 'admin', '2022-03-09 16:49:19', 'admin', '2022-06-12 14:56:49', NULL);

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
