/*
 Navicat Premium Data Transfer

 Source Server         : 51xy.xyz8.0
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : 51xy.xyz:3316
 Source Schema         : develop_xiaoyi_wumei

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 02/09/2021 10:03:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (12, 'iot_category', '设备分类', '', '', 'IotCategory', 'crud', 'com.ruoyi.system', 'system', 'category', '设备分类', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58', NULL);
INSERT INTO `gen_table` VALUES (14, 'iot_device_set', '设备配置', NULL, NULL, 'IotDeviceSet', 'crud', 'com.ruoyi.system', 'system', 'set', '设备配置', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45', NULL);
INSERT INTO `gen_table` VALUES (15, 'iot_device_status', '设备状态', NULL, NULL, 'IotDeviceStatus', 'crud', 'com.ruoyi.system', 'system', 'status', '设备状态', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:15:04', NULL);
INSERT INTO `gen_table` VALUES (17, 'iot_group', '设备分组', NULL, NULL, 'IotGroup', 'crud', 'com.ruoyi.system', 'system', 'group', '分组', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-05-18 08:04:15', '', '2021-05-18 08:13:40', NULL);
INSERT INTO `gen_table` VALUES (18, 't_user_account_info', '小程序用户表', NULL, NULL, 'TUserAccountInfo', 'crud', 'com.ruoyi.system', 'system', 'info', '小程序用户', 'wxy', '0', '/', NULL, 'admin', '2021-08-26 14:45:28', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (19, 't_user_login_log', '', NULL, NULL, 'TUserLoginLog', 'crud', 'com.ruoyi.system', 'system', 'log', NULL, 'wxy', '0', '/', NULL, 'admin', '2021-08-26 14:45:29', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (20, 'sys_user', '用户信息表', NULL, NULL, 'SysUser', 'crud', 'com.ruoyi.system', 'system', 'user', '用户信息', 'wxy', '0', '/', NULL, 'admin', '2021-08-26 17:07:44', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (21, 'iot_device_user_relation', '', NULL, NULL, 'IotDeviceUserRelation', 'crud', 'com.ruoyi.system', 'system', 'relation', NULL, 'wxy', '0', '/', NULL, 'admin', '2021-08-27 11:55:05', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (22, 'iot_device', '', NULL, NULL, 'IotDevice', 'crud', 'com.ruoyi.system', 'system', 'device', NULL, 'wxy', '0', '/', NULL, 'admin', '2021-08-27 13:45:40', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 371 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (217, '12', 'category_id', '序号', 'bigint(20)', 'Long', 'categoryId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES (218, '12', 'category_name', '分类名称', 'varchar(100)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES (219, '12', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 3, 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES (220, '12', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 4, 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES (221, '12', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 5, 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES (222, '12', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES (223, '12', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2021-05-06 13:31:30', '', '2021-05-07 08:22:59');
INSERT INTO `gen_table_column` VALUES (224, '12', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 8, 'admin', '2021-05-06 13:31:30', '', '2021-05-07 08:22:59');
INSERT INTO `gen_table_column` VALUES (237, '14', 'device_config_id', '序号', 'bigint(20)', 'Long', 'deviceConfigId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES (238, '14', 'device_id', '设备', 'bigint(20)', 'Long', 'deviceId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES (239, '14', 'device_num', '设备编号', 'varchar(64)', 'String', 'deviceNum', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES (240, '14', 'is_alarm', '报警', 'tinyint(1)', 'Integer', 'isAlarm', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', 4, 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES (241, '14', 'is_radar', '雷达感应', 'tinyint(1)', 'Integer', 'isRadar', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', 5, 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES (242, '14', 'is_host', '托管', 'tinyint(1)', 'Integer', 'isHost', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', 6, 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES (243, '14', 'is_reset', '重启', 'tinyint(1)', 'Integer', 'isReset', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'radio', 'sys_yes_no', 7, 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES (244, '14', 'is_ap', '打开AP', 'tinyint(1)', 'Integer', 'isAp', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'radio', 'sys_yes_no', 8, 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES (245, '14', 'is_rf_control', '射频遥控', 'tinyint(1)', 'Integer', 'isRfControl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', 9, 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES (246, '14', 'is_rf_learn', '遥控配对', 'tinyint(1)', 'Integer', 'isRfLearn', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'radio', 'sys_yes_no', 10, 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES (247, '14', 'is_rf_clear', '遥控清码', 'tinyint(1)', 'Integer', 'isRfClear', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'radio', 'sys_yes_no', 11, 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES (248, '14', 'rf_one_func', '按键一', 'tinyint(10)', 'Integer', 'rfOneFunc', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'select', 'rf_function', 12, 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES (249, '14', 'rf_two_func', '按键二', 'tinyint(10)', 'Integer', 'rfTwoFunc', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'select', 'rf_function', 13, 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES (250, '14', 'rf_three_func', '按键三', 'tinyint(10)', 'Integer', 'rfThreeFunc', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'select', 'rf_function', 14, 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES (251, '14', 'rf_four_func', '按键四', 'tinyint(10)', 'Integer', 'rfFourFunc', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'select', 'rf_function', 15, 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES (252, '14', 'owner_id', '用户', 'varchar(64)', 'String', 'ownerId', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 16, 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES (253, '14', 'network_address', '配网地址', 'varchar(255)', 'String', 'networkAddress', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 17, 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES (254, '14', 'network_ip', '配网IP', 'varchar(32)', 'String', 'networkIp', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 18, 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES (255, '14', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 19, 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES (256, '14', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 20, 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES (257, '14', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, '1', 'BETWEEN', 'datetime', '', 21, 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES (258, '14', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 22, 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:14:48');
INSERT INTO `gen_table_column` VALUES (259, '14', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '1', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 23, 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:14:48');
INSERT INTO `gen_table_column` VALUES (260, '14', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 24, 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:14:48');
INSERT INTO `gen_table_column` VALUES (261, '15', 'device_status_id', '序号', 'bigint(20)', 'Long', 'deviceStatusId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:15:04');
INSERT INTO `gen_table_column` VALUES (262, '15', 'device_id', '设备', 'bigint(20)', 'Long', 'deviceId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:15:04');
INSERT INTO `gen_table_column` VALUES (263, '15', 'device_num', '设备编号', 'varchar(64)', 'String', 'deviceNum', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:15:04');
INSERT INTO `gen_table_column` VALUES (264, '15', 'relay_status', '继电器', 'tinyint(1)', 'Integer', 'relayStatus', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', 4, 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES (265, '15', 'light_status', '灯状态', 'tinyint(1)', 'Integer', 'lightStatus', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', 5, 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES (266, '15', 'is_online', '在线', 'tinyint(1)', 'Integer', 'isOnline', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', 6, 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES (267, '15', 'device_temperature', '设备温度', 'float(6,2)', 'BigDecimal', 'deviceTemperature', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 7, 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES (268, '15', 'device_humidity', '设备湿度', 'float(6,2)', 'BigDecimal', 'deviceHumidity', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 8, 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES (269, '15', 'air_temperature', '空气温度', 'float(6,2)', 'BigDecimal', 'airTemperature', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 9, 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES (270, '15', 'air_humidity', '空气湿度', 'float(6,2)', 'BigDecimal', 'airHumidity', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 10, 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES (271, '15', 'trigger_source', '触发源', 'tinyint(10)', 'Integer', 'triggerSource', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'iot_trigger_source', 11, 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES (272, '15', 'brightness', '彩灯亮度', 'tinyint(10) unsigned', 'Integer', 'brightness', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 12, 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES (273, '15', 'light_interval', '渐变间隔', 'smallint(10)', 'Integer', 'lightInterval', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 13, 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES (274, '15', 'light_mode', '彩灯模式', 'tinyint(10)', 'Integer', 'lightMode', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'select', 'light_mode', 14, 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES (275, '15', 'red', '红灯', 'tinyint(255) unsigned', 'Long', 'red', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 15, 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES (276, '15', 'green', '绿灯', 'tinyint(255) unsigned', 'Long', 'green', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 16, 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES (277, '15', 'blue', '蓝灯', 'tinyint(255) unsigned', 'Long', 'blue', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 17, 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES (278, '15', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 18, 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES (279, '15', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 19, 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES (280, '15', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, '1', 'BETWEEN', 'datetime', '', 20, 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES (281, '15', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 21, 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:07');
INSERT INTO `gen_table_column` VALUES (282, '15', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '1', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 22, 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:07');
INSERT INTO `gen_table_column` VALUES (283, '15', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 23, 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:07');
INSERT INTO `gen_table_column` VALUES (294, '17', 'group_id', '设备分组', 'bigint(20)', 'Long', 'groupId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-05-18 08:04:15', '', '2021-05-18 08:13:40');
INSERT INTO `gen_table_column` VALUES (295, '17', 'user_id', '用户', 'bigint(20)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:40');
INSERT INTO `gen_table_column` VALUES (296, '17', 'group_name', '分组名称', 'varchar(100)', 'String', 'groupName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:40');
INSERT INTO `gen_table_column` VALUES (297, '17', 'group_order', '排序', 'smallint(5) unsigned zerofill', 'Integer', 'groupOrder', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'input', '', 4, 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES (298, '17', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 5, 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES (299, '17', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES (300, '17', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, '1', '1', 'BETWEEN', 'datetime', '', 7, 'admin', '2021-05-18 08:04:17', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES (301, '17', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2021-05-18 08:04:17', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES (302, '17', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2021-05-18 08:04:17', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES (303, '17', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 'admin', '2021-05-18 08:04:17', '', '2021-05-18 08:13:42');
INSERT INTO `gen_table_column` VALUES (304, '18', 'id', NULL, 'int', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (305, '18', 'sessionKey', 'sessionKey', 'varchar(255)', 'String', 'sessionkey', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (306, '18', 'access_token', 'accessToken', 'varchar(255)', 'String', 'accessToken', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (307, '18', 'open_id', NULL, 'varchar(50)', 'String', 'openId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (308, '18', 'union_id', NULL, 'varchar(50)', 'String', 'unionId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (309, '18', 'nick_name', '昵称', 'varchar(255)', 'String', 'nickName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 6, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (310, '18', 'avatar', '头像', 'varchar(255)', 'String', 'avatar', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (311, '18', 'phone', '手机号', 'varchar(255)', 'String', 'phone', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (312, '18', 'birthday', '生日', 'varchar(255)', 'String', 'birthday', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (313, '18', 'status', '用户状态：0-冻结，1-正常', 'int', 'Long', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2021-08-26 14:45:28', '', NULL);
INSERT INTO `gen_table_column` VALUES (314, '18', 'country', '国家', 'varchar(255)', 'String', 'country', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (315, '18', 'province', '省份', 'varchar(255)', 'String', 'province', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (316, '18', 'city', '城市', 'varchar(255)', 'String', 'city', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (317, '18', 'address', '地址', 'varchar(255)', 'String', 'address', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (318, '18', 'user_type', '用户类型：0-未授权用户，1-消费者，2-商家', 'int', 'Long', 'userType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 15, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (319, '18', 'admin_id', '绑定的管理员编号', 'int', 'Long', 'adminId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 16, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (320, '18', 'last_login_time', NULL, 'timestamp', 'Date', 'lastLoginTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 17, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (321, '18', 'last_login_ip', NULL, 'varchar(255)', 'String', 'lastLoginIp', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 18, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (322, '18', 'gmt_time', NULL, 'timestamp', 'Date', 'gmtTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 19, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (323, '18', 'gmt_update', NULL, 'timestamp', 'Date', 'gmtUpdate', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 20, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (324, '19', 'id', NULL, 'int', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (325, '19', 'user_type', '用户类型', 'varchar(255)', 'String', 'userType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 2, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (326, '19', 'user_id', NULL, 'int', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (327, '19', 'code', NULL, 'varchar(50)', 'String', 'code', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (328, '19', 'open_id', NULL, 'varchar(50)', 'String', 'openId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (329, '19', 'ip', 'IP地址', 'varchar(30)', 'String', 'ip', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (330, '19', 'gmt_time', NULL, 'timestamp', 'Date', 'gmtTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 7, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (331, '19', 'gmt_update', NULL, 'timestamp', 'Date', 'gmtUpdate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 8, 'admin', '2021-08-26 14:45:29', '', NULL);
INSERT INTO `gen_table_column` VALUES (332, '20', 'user_id', '用户ID', 'bigint', 'Long', 'userId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (333, '20', 'dept_id', '部门ID', 'bigint', 'Long', 'deptId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (334, '20', 'open_id', '用户OpenId', 'varchar(40)', 'String', 'openId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (335, '20', 'user_name', '用户账号', 'varchar(30)', 'String', 'userName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (336, '20', 'nick_name', '用户昵称', 'varchar(30)', 'String', 'nickName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (337, '20', 'user_type', '用户类型（00系统用户）', 'varchar(2)', 'String', 'userType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 6, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (338, '20', 'email', '用户邮箱', 'varchar(50)', 'String', 'email', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (339, '20', 'phonenumber', '手机号码', 'varchar(11)', 'String', 'phonenumber', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (340, '20', 'sex', '用户性别（0男 1女 2未知）', 'char(1)', 'String', 'sex', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 9, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (341, '20', 'avatar', '头像地址', 'varchar(100)', 'String', 'avatar', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (342, '20', 'password', '密码', 'varchar(100)', 'String', 'password', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (343, '20', 'status', '帐号状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 12, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (344, '20', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 13, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (345, '20', 'login_ip', '最后登录IP', 'varchar(128)', 'String', 'loginIp', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (346, '20', 'login_date', '最后登录时间', 'datetime', 'Date', 'loginDate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 15, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (347, '20', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 16, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (348, '20', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (349, '20', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 18, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (350, '20', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 19, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (351, '20', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 20, 'admin', '2021-08-26 17:07:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (352, '21', 'id', NULL, 'int', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-08-27 11:55:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (353, '21', 'user_id', NULL, 'int', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-08-27 11:55:05', '', NULL);
INSERT INTO `gen_table_column` VALUES (354, '21', 'device_id', NULL, 'int', 'Long', 'deviceId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-08-27 11:55:06', '', NULL);
INSERT INTO `gen_table_column` VALUES (355, '21', 'device_num', NULL, 'varchar(60)', 'String', 'deviceNum', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2021-08-27 11:55:06', '', NULL);
INSERT INTO `gen_table_column` VALUES (356, '21', 'gmt_time', NULL, 'timestamp', 'Date', 'gmtTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2021-08-27 11:55:06', '', NULL);
INSERT INTO `gen_table_column` VALUES (357, '21', 'gmt_update', NULL, 'timestamp', 'Date', 'gmtUpdate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2021-08-27 11:55:06', '', NULL);
INSERT INTO `gen_table_column` VALUES (358, '22', 'device_id', '设备ID', 'bigint', 'Long', 'deviceId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (359, '22', 'device_num', '设备编号', 'varchar(64)', 'String', 'deviceNum', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (360, '22', 'category_id', '设备分类', 'bigint', 'Long', 'categoryId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (361, '22', 'device_name', '设备名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (362, '22', 'firmware_version', '固件版本', 'varchar(32)', 'String', 'firmwareVersion', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (363, '22', 'owner_id', '设备用户ID', 'varchar(64)', 'String', 'ownerId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (364, '22', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (365, '22', 'status', '设备状态：未激活，未绑定，已绑定', 'varchar(255)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 8, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (366, '22', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (367, '22', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (368, '22', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (369, '22', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2021-08-27 13:45:40', '', NULL);
INSERT INTO `gen_table_column` VALUES (370, '22', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2021-08-27 13:45:40', '', NULL);

-- ----------------------------
-- Table structure for iot_category
-- ----------------------------
DROP TABLE IF EXISTS `iot_category`;
CREATE TABLE `iot_category`  (
  `category_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '设备分类ID',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备分类名称',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_category
-- ----------------------------
INSERT INTO `iot_category` VALUES (1, 'wifi通断器', '0', '', '2021-05-06 01:00:04', '', '2021-05-06 01:05:08', '智能开关，带温湿度传感器，支持手机和射频遥控控制。应用于传统家电设备的控制等。');
INSERT INTO `iot_category` VALUES (2, '智能灯', '0', '', '2021-05-06 01:01:39', '', '2021-05-06 01:05:32', '智能七彩灯，支持雷达感应、报警，手机和射频遥控控制。应用于环境灯、感应灯和传统灯的控制等。');
INSERT INTO `iot_category` VALUES (3, '智能门锁', '0', '', '2021-05-06 01:02:34', '', '2021-05-06 01:04:22', '支持手机和射频遥控控制。');
INSERT INTO `iot_category` VALUES (4, '智能水阀', '0', '', '2021-05-06 01:03:57', '', NULL, '手机和射频遥控控制，应用于浇灌系统。');
INSERT INTO `iot_category` VALUES (5, '其他', '0', '', '2021-05-28 19:31:05', '', NULL, '其他硬件设备的接入');

-- ----------------------------
-- Table structure for iot_device
-- ----------------------------
DROP TABLE IF EXISTS `iot_device`;
CREATE TABLE `iot_device`  (
  `device_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `device_num` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备编号',
  `category_id` bigint(0) NULL DEFAULT NULL COMMENT '设备分类',
  `device_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备名称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `firmware_version` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '固件版本',
  `owner_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备用户ID',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '未激活' COMMENT '设备状态：未激活，未绑定，已绑定',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`device_id`) USING BTREE,
  INDEX `iot_device_category`(`category_id`) USING BTREE,
  CONSTRAINT `iot_device_category` FOREIGN KEY (`category_id`) REFERENCES `iot_category` (`category_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device
-- ----------------------------

INSERT INTO `iot_device` VALUES (1, '7CDFA1049ADA', 1, '智能开关-测试', '暂无', '1.0', NULL, '0', '未绑定', '', '2021-05-23 14:26:38', '', '2021-06-15 02:47:52');
INSERT INTO `iot_device` VALUES (2, '7CDFA1049ADB', 1, '设备名称', 'remark', '1.0', NULL, '0', '未绑定', '', '2021-05-23 14:26:38', '', '2021-06-15 02:47:52');
INSERT INTO `iot_device` VALUES (3, '7CDFA1049ADC', 2, '4G开关', '灯等等灯', '1.0', '1', '0', '未绑定', '', '2021-05-23 14:26:38', '', '2021-08-31 20:11:17');
INSERT INTO `iot_device` VALUES (4, '7CDFA1049ADD', 2, '阿拉丁神灯', '阿拉丁灯', '1.0', '1', '0', '未绑定', '', '2021-05-23 14:26:38', '', '2021-06-26 20:25:09');

-- ----------------------------
-- Table structure for iot_device_group
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_group`;
CREATE TABLE `iot_device_group`  (
  `device_group_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '设备分组ID',
  `group_id` bigint(0) NOT NULL COMMENT '分组ID',
  `device_id` bigint(0) NOT NULL COMMENT '设备ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`device_group_id`) USING BTREE,
  INDEX `iot_device_group_group_id`(`group_id`) USING BTREE,
  INDEX `iot_device_group_device_id`(`device_id`) USING BTREE,
  CONSTRAINT `iot_device_group_device_id` FOREIGN KEY (`device_id`) REFERENCES `iot_device` (`device_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `iot_device_group_group_id` FOREIGN KEY (`group_id`) REFERENCES `iot_group` (`group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_group
-- ----------------------------
INSERT INTO `iot_device_group` VALUES (1, 1, 1, '2021-06-11 23:25:49');
INSERT INTO `iot_device_group` VALUES (2, 2, 1, '2021-06-11 23:25:49');
INSERT INTO `iot_device_group` VALUES (6, 1, 2, '2021-06-11 23:25:49');
INSERT INTO `iot_device_group` VALUES (7, 2, 2, '2021-06-11 23:25:49');

-- ----------------------------
-- Table structure for iot_device_set
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_set`;
CREATE TABLE `iot_device_set`  (
  `device_set_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '配置id',
  `device_id` bigint(0) NULL DEFAULT NULL COMMENT '设备ID',
  `device_num` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备编号',
  `is_alarm` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用报警',
  `is_radar` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用雷达感应',
  `is_host` tinyint(1) NULL DEFAULT NULL COMMENT '是否托管',
  `is_reset` tinyint(1) NULL DEFAULT NULL COMMENT '是否重启',
  `is_ap` tinyint(1) NULL DEFAULT NULL COMMENT '是否打开AP',
  `is_smart_config` tinyint(1) NULL DEFAULT NULL COMMENT '是否智能配网',
  `is_wifi_offline` tinyint(1) NULL DEFAULT NULL COMMENT '是否离线模式',
  `is_open_certifi` tinyint(1) NULL DEFAULT NULL COMMENT '是否使用证书',
  `is_rf_control` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用射频遥控',
  `is_rf_learn` tinyint(1) NULL DEFAULT NULL COMMENT '是否遥控配对',
  `is_rf_clear` tinyint(1) NULL DEFAULT NULL COMMENT '是否遥控清码',
  `rf_one_func` tinyint(0) NULL DEFAULT NULL COMMENT 'RF遥控第一个按键功能',
  `rf_two_func` tinyint(0) NULL DEFAULT NULL COMMENT 'RF遥控第二个按键功能',
  `rf_three_func` tinyint(0) NULL DEFAULT NULL COMMENT 'RF遥控第三个按键功能',
  `rf_four_func` tinyint(0) NULL DEFAULT NULL COMMENT 'RF遥控第四个按键功能',
  `owner_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备用户ID，用于记录配网后用户的变更',
  `network_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配网地址',
  `network_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配网IP',
  `radar_interval` smallint(0) NULL DEFAULT NULL COMMENT '雷达感应间隔，单位秒',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_set_id`) USING BTREE,
  INDEX `iot_device_config`(`device_id`) USING BTREE,
  CONSTRAINT `iot_device_config` FOREIGN KEY (`device_id`) REFERENCES `iot_device` (`device_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 300 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_set
-- ----------------------------
INSERT INTO `iot_device_set` VALUES (1, 1, '7CDFA1049ADA', 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 2, 3, 4, '1', '内网', '127.0.0.1', 5, '0', '', '2021-06-26 20:25:10', '', NULL, NULL);
INSERT INTO `iot_device_set` VALUES (2, 2, '7CDFA1049ADB', 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 2, 3, 4, '1', '内网', '127.0.0.1', 5, '0', '', '2021-06-01 00:12:26', '', '2021-06-23 20:59:33', NULL);
INSERT INTO `iot_device_set` VALUES (3, 4, '863488052352472', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', NULL, '', NULL, NULL);

-- ----------------------------
-- Table structure for iot_device_status
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_status`;
CREATE TABLE `iot_device_status`  (
  `device_status_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '设备状态ID',
  `device_id` bigint(0) NULL DEFAULT NULL COMMENT '设备ID',
  `device_num` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备编号',
  `relay_status` tinyint(1) NULL DEFAULT NULL COMMENT '继电器状态:0-关，1-开',
  `light_status` tinyint(1) NULL DEFAULT NULL COMMENT '灯状态:0-关，1-开',
  `is_online` tinyint(1) NULL DEFAULT NULL COMMENT '设备是否在线',
  `rssi` tinyint(0) NULL DEFAULT NULL COMMENT 'wifi信号强度',
  `device_temperature` float(6, 2) NULL DEFAULT NULL COMMENT '设备温度',
  `air_temperature` float(6, 2) NULL DEFAULT NULL COMMENT '空气温度',
  `air_humidity` float(6, 2) NULL DEFAULT NULL COMMENT '空气湿度',
  `trigger_source` tinyint(0) NULL DEFAULT NULL COMMENT '触发源：0-无、1-按键、2.手机、3-浏览器、4-射频遥控、5-雷达、6-报警、7-定时',
  `brightness` tinyint(0) UNSIGNED NULL DEFAULT NULL COMMENT '灯的亮度：0-100',
  `light_interval` int(0) NULL DEFAULT NULL COMMENT '渐变、动感模式闪烁间隔，单位秒',
  `light_mode` tinyint(0) NULL DEFAULT NULL COMMENT '灯模式：1-、2-、3-、4-、5-、6-',
  `fade_time` int(0) NULL DEFAULT NULL COMMENT '灯渐变时间',
  `red` tinyint(0) UNSIGNED NULL DEFAULT NULL COMMENT '红灯值：0-255',
  `green` tinyint(0) UNSIGNED NULL DEFAULT NULL COMMENT '绿灯值：0-255',
  `blue` tinyint(0) UNSIGNED NULL DEFAULT NULL COMMENT '蓝灯值：0-255',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_status_id`) USING BTREE,
  INDEX `iot_device_status`(`device_id`) USING BTREE,
  CONSTRAINT `iot_device_status` FOREIGN KEY (`device_id`) REFERENCES `iot_device` (`device_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2879 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_status
-- ----------------------------
INSERT INTO `iot_device_status` VALUES (1, 1, '7CDFA1049ADA', 1, 1, 1, -80, 36.52, 0.00, 0.00, 0, 100, 432, 0, 259, 255, 254, 241, '0', '', '2021-06-26 20:27:17', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2, 2, '7CDFA1049ADB', 0, 1, 0, -46, 23.78, 0.00, 0.00, 0, 100, 100, 0, 100, 255, 255, 255, '0', '', '2021-06-01 00:13:38', '', '2021-06-23 21:00:37', NULL);
INSERT INTO `iot_device_status` VALUES (2846, 1, '7CDFA1049ADA', 1, 0, 1, -80, 36.52, 0.00, 0.00, 0, 100, 432, 0, 259, 255, 254, 241, '0', '', '2021-08-26 18:38:11', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2847, 1, '7CDFA1049ADA', 1, 1, 1, -80, 36.52, 0.00, 0.00, 0, 100, 432, 0, 259, 255, 254, 241, '0', '', '2021-08-26 18:38:12', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2848, 1, '7CDFA1049ADA', 1, 0, 1, -80, 36.52, 0.00, 0.00, 0, 100, 432, 0, 259, 255, 254, 241, '0', '', '2021-08-26 18:38:13', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2849, 1, '7CDFA1049ADA', 1, 1, 1, -80, 36.52, 0.00, 0.00, 0, 100, 432, 0, 259, 255, 254, 241, '0', '', '2021-08-26 18:38:17', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2850, 4, '863488052352472', 1, 1, 1, -80, 36.52, 0.00, 0.00, 0, 100, 432, 0, 259, 255, 254, 241, '0', '', '2021-08-26 18:38:17', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2851, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:11:20', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2852, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:11:22', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2853, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:11:23', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2854, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:14:13', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2855, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:14:13', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2856, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:19:29', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2857, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:19:31', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2858, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:20:02', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2859, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:20:03', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2860, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:23:34', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2861, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:23:40', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2862, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:24:37', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2863, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:24:39', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2864, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:24:41', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2865, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:24:43', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2866, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:24:47', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2867, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:24:50', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2868, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:24:51', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2869, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:08', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2870, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:10', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2871, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:10', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2872, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:11', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2873, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:12', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2874, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:13', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2875, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:14', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2876, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:14', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2877, 4, '863488052352472', 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:15', '', NULL, NULL);
INSERT INTO `iot_device_status` VALUES (2878, 4, '863488052352472', 0, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '', '2021-08-31 20:25:15', '', NULL, NULL);

-- ----------------------------
-- Table structure for iot_device_user_relation
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_user_relation`;
CREATE TABLE `iot_device_user_relation`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL,
  `device_id` int(0) NOT NULL,
  `device_num` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '设备名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '设备备注',
  `gmt_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_update` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`, `device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户-设备关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_device_user_relation
-- ----------------------------
INSERT INTO `iot_device_user_relation` VALUES (8, 115, 4, '863488052352472', 'wxy测试开关', NULL, '2021-08-28 13:35:23', NULL);
INSERT INTO `iot_device_user_relation` VALUES (10, 114, 4, '863488052352472', '阿拉丁神灯', '灯等等灯', '2021-08-30 10:57:14', '2021-08-30 15:28:25');
INSERT INTO `iot_device_user_relation` VALUES (13, 116, 4, '863488052352472', '阿拉丁神灯', NULL, '2021-08-31 20:24:31', NULL);

-- ----------------------------
-- Table structure for iot_group
-- ----------------------------
DROP TABLE IF EXISTS `iot_group`;
CREATE TABLE `iot_group`  (
  `group_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '设备分组ID',
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `group_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备分组名称',
  `group_order` smallint(5) UNSIGNED ZEROFILL NULL DEFAULT 00000 COMMENT '分组的排序',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iot_group
-- ----------------------------
INSERT INTO `iot_group` VALUES (1, 114, '一楼', 00001, '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');
INSERT INTO `iot_group` VALUES (2, 114, '二楼', 00002, '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');
INSERT INTO `iot_group` VALUES (3, 114, '三楼', 00003, '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');
INSERT INTO `iot_group` VALUES (4, 114, '四楼', 00004, '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');
INSERT INTO `iot_group` VALUES (5, 114, '五楼', 00005, '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `blob_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fired_time` bigint(0) NOT NULL,
  `sched_time` bigint(0) NOT NULL,
  `priority` int(0) NOT NULL,
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001797B913EF878707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001797B913EF878707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001797B913EF878707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_checkin_time` bigint(0) NOT NULL,
  `checkin_interval` bigint(0) NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'Admin1630461270994', 1630548198218, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repeat_count` bigint(0) NOT NULL,
  `repeat_interval` bigint(0) NOT NULL,
  `times_triggered` bigint(0) NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `int_prop_1` int(0) NULL DEFAULT NULL,
  `int_prop_2` int(0) NULL DEFAULT NULL,
  `long_prop_1` bigint(0) NULL DEFAULT NULL,
  `long_prop_2` bigint(0) NULL DEFAULT NULL,
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_fire_time` bigint(0) NULL DEFAULT NULL,
  `prev_fire_time` bigint(0) NULL DEFAULT NULL,
  `priority` int(0) NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` bigint(0) NOT NULL,
  `end_time` bigint(0) NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint(0) NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1630461280000, -1, 5, 'PAUSED', 'CRON', 1630461271000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1630461285000, -1, 5, 'PAUSED', 'CRON', 1630461271000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1630461280000, -1, 5, 'PAUSED', 'CRON', 1630461271000, 0, NULL, 2, '');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-05-18 02:23:07', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-05-18 02:23:07', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-05-18 02:23:07', '', NULL, '深色主题theme-dark，浅色主题theme-light');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(0) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(0) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '按键', '1', 'iot_trigger_source', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:53:34', 'admin', '2021-05-05 15:54:17', '按键操作');
INSERT INTO `sys_dict_data` VALUES (101, 0, '手机', '2', 'iot_trigger_source', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:53:50', '', NULL, '手机操作');
INSERT INTO `sys_dict_data` VALUES (102, 0, '浏览器', '3', 'iot_trigger_source', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:54:09', '', NULL, '浏览器操作');
INSERT INTO `sys_dict_data` VALUES (103, 0, '射频遥控', '4', 'iot_trigger_source', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:54:44', '', NULL, '433M遥控操作');
INSERT INTO `sys_dict_data` VALUES (104, 0, '雷达', '5', 'iot_trigger_source', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:55:03', '', NULL, '雷达触发');
INSERT INTO `sys_dict_data` VALUES (105, 0, '报警', '6', 'iot_trigger_source', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:55:44', '', NULL, '报警触发');
INSERT INTO `sys_dict_data` VALUES (106, 0, '定时', '7', 'iot_trigger_source', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:56:03', '', NULL, '定时触发');
INSERT INTO `sys_dict_data` VALUES (107, 1, '继电器开关', '1', 'rf_function', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:58:36', 'admin', '2021-06-23 22:50:32', '继电器通断');
INSERT INTO `sys_dict_data` VALUES (108, 2, '七彩灯开关', '2', 'rf_function', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:58:57', 'admin', '2021-06-23 22:50:44', '开关灯');
INSERT INTO `sys_dict_data` VALUES (109, 3, '雷达开关', '3', 'rf_function', NULL, NULL, 'N', '0', 'admin', '2021-05-05 15:59:34', 'admin', '2021-06-23 22:50:21', '开关雷达');
INSERT INTO `sys_dict_data` VALUES (110, 4, '报警开关', '4', 'rf_function', NULL, NULL, 'N', '0', 'admin', '2021-05-05 16:00:01', 'admin', '2021-06-01 15:44:44', '报警开关');
INSERT INTO `sys_dict_data` VALUES (111, 5, '智能配网', '5', 'rf_function', NULL, NULL, 'N', '0', 'admin', '2021-05-05 16:00:16', 'admin', '2021-06-01 15:44:51', '智能配网');
INSERT INTO `sys_dict_data` VALUES (112, 0, '固定颜色', '0', 'light_mode', NULL, NULL, 'N', '0', 'admin', '2021-05-05 16:07:22', '', NULL, '固定颜色');
INSERT INTO `sys_dict_data` VALUES (113, 0, '七彩渐变', '1', 'light_mode', NULL, NULL, 'N', '0', 'admin', '2021-05-05 16:07:41', '', NULL, '七彩渐变');
INSERT INTO `sys_dict_data` VALUES (114, 0, '动感模式', '2', 'light_mode', NULL, NULL, 'N', '0', 'admin', '2021-05-05 16:08:44', '', NULL, '动感模式');
INSERT INTO `sys_dict_data` VALUES (115, 0, '单色渐变', '3', 'light_mode', NULL, NULL, 'N', '0', 'admin', '2021-05-05 16:09:12', '', NULL, '单色渐变');
INSERT INTO `sys_dict_data` VALUES (116, 0, '白光', '4', 'light_mode', NULL, NULL, 'N', '0', 'admin', '2021-05-05 16:09:46', '', NULL, '白光');
INSERT INTO `sys_dict_data` VALUES (117, 0, '暖光', '5', 'light_mode', NULL, NULL, 'N', '0', 'admin', '2021-05-05 16:10:07', '', NULL, '暖光');
INSERT INTO `sys_dict_data` VALUES (118, 0, '无', '0', 'rf_function', NULL, NULL, 'N', '0', 'admin', '2021-06-01 15:43:44', 'admin', '2021-06-01 15:44:21', '不进行任何操作');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2021-05-18 02:23:07', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '设备触发源', 'iot_trigger_source', '0', 'admin', '2021-05-05 15:51:26', '', NULL, '设备操作的触发源');
INSERT INTO `sys_dict_type` VALUES (101, '射频遥控按键功能', 'rf_function', '0', 'admin', '2021-05-05 15:58:05', '', NULL, '射频遥控按键功能列表');
INSERT INTO `sys_dict_type` VALUES (102, '彩灯模式', 'light_mode', '0', 'admin', '2021-05-05 16:04:53', '', NULL, '彩灯模式，单色、七彩、渐变、动感');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2021-05-18 02:23:07', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES (1, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '系统默认（有参） 总共耗时：1毫秒', '0', '', '2021-06-11 09:23:45');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 435 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (385, 'admin', '172.17.0.1', '内网IP', 'Mobile Safari', 'Android 1.x', '1', '用户不存在/密码错误', '2021-06-30 17:13:17');
INSERT INTO `sys_logininfor` VALUES (386, 'admin', '172.17.0.1', '内网IP', 'Mobile Safari', 'Android 1.x', '1', '验证码已失效', '2021-06-30 17:13:34');
INSERT INTO `sys_logininfor` VALUES (387, 'admin', '172.17.0.1', '内网IP', 'Mobile Safari', 'Android 1.x', '0', '登录成功', '2021-06-30 17:14:13');
INSERT INTO `sys_logininfor` VALUES (388, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-08-26 14:44:02');
INSERT INTO `sys_logininfor` VALUES (389, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-08-26 14:44:08');
INSERT INTO `sys_logininfor` VALUES (390, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-08-26 14:44:59');
INSERT INTO `sys_logininfor` VALUES (391, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:35:01');
INSERT INTO `sys_logininfor` VALUES (392, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:37:13');
INSERT INTO `sys_logininfor` VALUES (393, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:37:24');
INSERT INTO `sys_logininfor` VALUES (394, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:37:36');
INSERT INTO `sys_logininfor` VALUES (395, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:38:40');
INSERT INTO `sys_logininfor` VALUES (396, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:38:56');
INSERT INTO `sys_logininfor` VALUES (397, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:39:53');
INSERT INTO `sys_logininfor` VALUES (398, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:39:56');
INSERT INTO `sys_logininfor` VALUES (399, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:40:10');
INSERT INTO `sys_logininfor` VALUES (400, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:40:19');
INSERT INTO `sys_logininfor` VALUES (401, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:40:49');
INSERT INTO `sys_logininfor` VALUES (402, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:41:42');
INSERT INTO `sys_logininfor` VALUES (403, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:42:10');
INSERT INTO `sys_logininfor` VALUES (404, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:42:26');
INSERT INTO `sys_logininfor` VALUES (405, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:42:56');
INSERT INTO `sys_logininfor` VALUES (406, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:43:05');
INSERT INTO `sys_logininfor` VALUES (407, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:44:38');
INSERT INTO `sys_logininfor` VALUES (408, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:44:48');
INSERT INTO `sys_logininfor` VALUES (409, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:45:01');
INSERT INTO `sys_logininfor` VALUES (410, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:51:20');
INSERT INTO `sys_logininfor` VALUES (411, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:51:40');
INSERT INTO `sys_logininfor` VALUES (412, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:51:54');
INSERT INTO `sys_logininfor` VALUES (413, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:55:17');
INSERT INTO `sys_logininfor` VALUES (414, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 15:58:28');
INSERT INTO `sys_logininfor` VALUES (415, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 16:11:13');
INSERT INTO `sys_logininfor` VALUES (416, 'ozCz80FhaFo6rij0YLwz1aXTzKok', '180.111.206.137', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 16:16:40');
INSERT INTO `sys_logininfor` VALUES (417, 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '222.95.162.245', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '1', '用户不存在/密码错误', '2021-08-26 16:23:04');
INSERT INTO `sys_logininfor` VALUES (418, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-08-26 16:24:11');
INSERT INTO `sys_logininfor` VALUES (419, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-08-26 16:24:11');
INSERT INTO `sys_logininfor` VALUES (420, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-08-26 16:30:13');
INSERT INTO `sys_logininfor` VALUES (421, 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '222.95.162.245', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '0', '登录成功', '2021-08-26 16:30:59');
INSERT INTO `sys_logininfor` VALUES (422, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-08-26 16:54:25');
INSERT INTO `sys_logininfor` VALUES (423, 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '222.95.162.245', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '0', '登录成功', '2021-08-26 16:56:12');
INSERT INTO `sys_logininfor` VALUES (424, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-08-26 16:58:05');
INSERT INTO `sys_logininfor` VALUES (425, 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '222.95.162.245', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '0', '登录成功', '2021-08-26 16:59:32');
INSERT INTO `sys_logininfor` VALUES (426, 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '222.95.162.245', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '0', '登录成功', '2021-08-26 16:59:48');
INSERT INTO `sys_logininfor` VALUES (427, 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '222.95.162.245', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '0', '登录成功', '2021-08-26 17:00:19');
INSERT INTO `sys_logininfor` VALUES (428, 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '222.95.162.245', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '0', '登录成功', '2021-08-26 17:01:36');
INSERT INTO `sys_logininfor` VALUES (429, 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '222.95.162.245', 'XX XX', 'Mobile Safari', 'iOS 11 (iPhone)', '0', '登录成功', '2021-08-26 17:02:12');
INSERT INTO `sys_logininfor` VALUES (430, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-08-26 17:06:05');
INSERT INTO `sys_logininfor` VALUES (431, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-08-27 11:53:54');
INSERT INTO `sys_logininfor` VALUES (432, 'admin', '222.95.162.245', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-08-27 11:54:00');
INSERT INTO `sys_logininfor` VALUES (433, 'admin', '58.212.134.111', 'XX XX', 'Mobile Safari', 'Android 1.x', '0', '登录成功', '2021-08-27 19:20:43');
INSERT INTO `sys_logininfor` VALUES (434, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-08-28 13:59:02');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(0) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(0) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(0) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2074 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-05-18 02:23:06', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-05-18 02:23:06', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2021-05-18 02:23:06', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '物美官网', 0, 4, 'http://wumei.live', NULL, 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2021-05-18 02:23:06', 'admin', '2021-05-24 14:17:14', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2021-05-18 02:23:06', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2021-05-18 02:23:06', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2021-05-18 02:23:06', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2021-05-18 02:23:06', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2021-05-18 02:23:06', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2021-05-18 02:23:06', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2021-05-18 02:23:06', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2021-05-18 02:23:06', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2021-05-18 02:23:06', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2021-05-18 02:23:06', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2021-05-18 02:23:06', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2021-05-18 02:23:06', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2021-05-18 02:23:06', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2021-05-18 02:23:06', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2021-05-18 02:23:06', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2021-05-18 02:23:06', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2021-05-18 02:23:06', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-05-18 02:23:06', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2021-05-18 02:23:06', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2021-05-18 02:23:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '物联网', 0, 0, 'iot', NULL, 1, 0, 'M', '0', '0', '', 'iot', 'admin', '2021-05-03 17:20:27', 'admin', '2021-05-18 09:32:14', '');
INSERT INTO `sys_menu` VALUES (2043, '设备分类', 2000, 10, 'category', 'system/category/index', 1, 0, 'C', '0', '0', 'system:category:list', 'category', 'admin', '2021-05-06 15:10:35', 'admin', '2021-05-18 09:32:58', '设备分类菜单');
INSERT INTO `sys_menu` VALUES (2044, '设备分类查询', 2043, 1, '#', '', 1, 0, 'F', '0', '0', 'system:category:query', '#', 'admin', '2021-05-06 15:10:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '设备分类新增', 2043, 2, '#', '', 1, 0, 'F', '0', '0', 'system:category:add', '#', 'admin', '2021-05-06 15:10:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '设备分类修改', 2043, 3, '#', '', 1, 0, 'F', '0', '0', 'system:category:edit', '#', 'admin', '2021-05-06 15:10:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '设备分类删除', 2043, 4, '#', '', 1, 0, 'F', '0', '0', 'system:category:remove', '#', 'admin', '2021-05-06 15:10:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '设备分类导出', 2043, 5, '#', '', 1, 0, 'F', '0', '0', 'system:category:export', '#', 'admin', '2021-05-06 15:10:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2049, '设备列表', 2000, 11, 'device', 'system/device/index', 1, 0, 'C', '0', '0', 'system:device:list', 'device', 'admin', '2021-05-06 15:10:50', 'admin', '2021-05-18 09:33:08', '设备菜单');
INSERT INTO `sys_menu` VALUES (2050, '设备查询', 2049, 1, '#', '', 1, 0, 'F', '0', '0', 'system:device:query', '#', 'admin', '2021-05-06 15:10:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '设备新增', 2049, 2, '#', '', 1, 0, 'F', '0', '0', 'system:device:add', '#', 'admin', '2021-05-06 15:10:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '设备修改', 2049, 3, '#', '', 1, 0, 'F', '0', '0', 'system:device:edit', '#', 'admin', '2021-05-06 15:10:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '设备删除', 2049, 4, '#', '', 1, 0, 'F', '0', '0', 'system:device:remove', '#', 'admin', '2021-05-06 15:10:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '设备导出', 2049, 5, '#', '', 1, 0, 'F', '0', '0', 'system:device:export', '#', 'admin', '2021-05-06 15:10:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2055, '配置日志', 2000, 13, 'set', 'system/set/index', 1, 0, 'C', '0', '0', 'system:set:list', 'config', 'admin', '2021-05-06 15:11:09', 'admin', '2021-05-26 14:54:24', '设备配置菜单');
INSERT INTO `sys_menu` VALUES (2056, '设备配置查询', 2055, 1, '#', '', 1, 0, 'F', '0', '0', 'system:set:query', '#', 'admin', '2021-05-06 15:11:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '设备配置新增', 2055, 2, '#', '', 1, 0, 'F', '0', '0', 'system:set:add', '#', 'admin', '2021-05-06 15:11:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2058, '设备配置修改', 2055, 3, '#', '', 1, 0, 'F', '0', '0', 'system:set:edit', '#', 'admin', '2021-05-06 15:11:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '设备配置删除', 2055, 4, '#', '', 1, 0, 'F', '0', '0', 'system:set:remove', '#', 'admin', '2021-05-06 15:11:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '设备配置导出', 2055, 5, '#', '', 1, 0, 'F', '0', '0', 'system:set:export', '#', 'admin', '2021-05-06 15:11:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2061, '状态日志', 2000, 12, 'status', 'system/status/index', 1, 0, 'C', '0', '0', 'system:status:list', 'status', 'admin', '2021-05-06 15:11:19', 'admin', '2021-05-26 14:54:38', '设备状态菜单');
INSERT INTO `sys_menu` VALUES (2062, '设备状态查询', 2061, 1, '#', '', 1, 0, 'F', '0', '0', 'system:status:query', '#', 'admin', '2021-05-06 15:11:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2063, '设备状态新增', 2061, 2, '#', '', 1, 0, 'F', '0', '0', 'system:status:add', '#', 'admin', '2021-05-06 15:11:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2064, '设备状态修改', 2061, 3, '#', '', 1, 0, 'F', '0', '0', 'system:status:edit', '#', 'admin', '2021-05-06 15:11:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2065, '设备状态删除', 2061, 4, '#', '', 1, 0, 'F', '0', '0', 'system:status:remove', '#', 'admin', '2021-05-06 15:11:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2066, '设备状态导出', 2061, 5, '#', '', 1, 0, 'F', '0', '0', 'system:status:export', '#', 'admin', '2021-05-06 15:11:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2067, '设备分组', 2000, 1, 'group', 'system/group/index', 1, 0, 'C', '0', '0', 'system:group:list', 'group', 'admin', '2021-05-18 08:15:31', 'admin', '2021-05-18 09:40:59', '分组菜单');
INSERT INTO `sys_menu` VALUES (2068, '分组查询', 2067, 1, '#', '', 1, 0, 'F', '0', '0', 'system:group:query', '#', 'admin', '2021-05-18 08:15:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2069, '分组新增', 2067, 2, '#', '', 1, 0, 'F', '0', '0', 'system:group:add', '#', 'admin', '2021-05-18 08:15:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2070, '分组修改', 2067, 3, '#', '', 1, 0, 'F', '0', '0', 'system:group:edit', '#', 'admin', '2021-05-18 08:15:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2071, '分组删除', 2067, 4, '#', '', 1, 0, 'F', '0', '0', 'system:group:remove', '#', 'admin', '2021-05-18 08:15:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2072, '分组导出', 2067, 5, '#', '', 1, 0, 'F', '0', '0', 'system:group:export', '#', 'admin', '2021-05-18 08:15:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2073, 'EMQ管理', 2000, 14, 'http://localhost:18083/#/login?redirect=%2F', NULL, 0, 0, 'C', '0', '0', '', 'mqtt', 'admin', '2021-05-26 14:53:48', 'admin', '2021-05-27 16:11:27', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2021-05-18 02:23:07', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2021-05-18 02:23:07', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (3, '111', '2', 0x3C703E3131313131313C2F703E, '0', 'admin', '2021-08-27 19:24:12', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(0) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(0) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(0) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2663 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1873, '设备状态', 2, 'com.ruoyi.system.controller.IotDeviceStatusController.edit()', 'PUT', 1, 'admin', NULL, '/system/status', '172.17.0.1', '内网IP', '{\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"triggerSource\":1,\"relayStatus\":0,\"updateTime\":1625044821428,\"params\":{}}', '{\"msg\":\"mqtt 发布成功\",\"code\":200}', 0, NULL, '2021-06-30 17:20:21');
INSERT INTO `sys_oper_log` VALUES (1874, '设备状态', 2, 'com.ruoyi.system.controller.IotDeviceStatusController.edit()', 'PUT', 1, 'admin', NULL, '/system/status', '172.17.0.1', '内网IP', '{\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"triggerSource\":1,\"relayStatus\":1,\"updateTime\":1625044822177,\"params\":{}}', '{\"msg\":\"mqtt 发布成功\",\"code\":200}', 0, NULL, '2021-06-30 17:20:22');
INSERT INTO `sys_oper_log` VALUES (1875, '设备状态', 2, 'com.ruoyi.system.controller.IotDeviceStatusController.edit()', 'PUT', 1, 'admin', NULL, '/system/status', '172.17.0.1', '内网IP', '{\"lightStatus\":0,\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"triggerSource\":1,\"updateTime\":1625044822998,\"params\":{}}', '{\"msg\":\"mqtt 发布成功\",\"code\":200}', 0, NULL, '2021-06-30 17:20:23');
INSERT INTO `sys_oper_log` VALUES (1876, '设备状态', 2, 'com.ruoyi.system.controller.IotDeviceStatusController.edit()', 'PUT', 1, 'admin', NULL, '/system/status', '172.17.0.1', '内网IP', '{\"lightStatus\":1,\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"triggerSource\":1,\"updateTime\":1625044823902,\"params\":{}}', '{\"msg\":\"mqtt 发布成功\",\"code\":200}', 0, NULL, '2021-06-30 17:20:23');
INSERT INTO `sys_oper_log` VALUES (1877, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '222.95.162.245', 'XX XX', 't_user_account_info,t_user_login_log', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 14:45:29');
INSERT INTO `sys_oper_log` VALUES (1878, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '222.95.162.245', 'XX XX', '{}', 'null', 0, NULL, '2021-08-26 14:45:39');
INSERT INTO `sys_oper_log` VALUES (1879, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '222.95.162.245', 'XX XX', 'sys_user', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 17:07:45');
INSERT INTO `sys_oper_log` VALUES (1880, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', NULL, '/system/role', '222.95.162.245', 'XX XX', '{\"flag\":false,\"roleId\":101,\"admin\":false,\"params\":{},\"roleSort\":\"3\",\"deptCheckStrictly\":true,\"createBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"mp\",\"roleName\":\"小程序用户\",\"deptIds\":[],\"menuIds\":[2000,2067,2068,2069,2070,2071,2072,2043,2044,2045,2046,2047,2048,2049,2050,2051,2052,2053,2054,2061,2062,2063,2064,2065,2066,2055,2056,2057,2058,2059,2060,2073],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 17:26:52');
INSERT INTO `sys_oper_log` VALUES (1881, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '222.95.162.245', 'XX XX', '{\"flag\":false,\"roleId\":100,\"admin\":false,\"dataScope\":\"1\",\"delFlag\":\"0\",\"params\":{},\"roleSort\":\"8\",\"deptCheckStrictly\":true,\"createTime\":1622248952000,\"updateBy\":\"admin\",\"menuCheckStrictly\":true,\"roleKey\":\"visitor\",\"roleName\":\"游客角色\",\"menuIds\":[2000,2067,2043,2049,2061,2055,1,100,101,102,103,104,105,106,107,108,500,501,2,109,110,3,115,2068,2044,2050,2062,2056,2073,1001,1008,1013,1017,1021,1026,1031,1036,1040,1043,1046,1049,1055,116,4],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 17:27:06');
INSERT INTO `sys_oper_log` VALUES (1882, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', NULL, '/system/user', '222.95.162.245', 'XX XX', '{\"admin\":false,\"password\":\"$2a$10$f.KtWGpaUsdvl2E427/H4OnPi2dYx8HetxnBs1uasSNwCBBUDSwjO\",\"postIds\":[],\"nickName\":\"xxx\",\"params\":{},\"userName\":\"aaa\",\"userId\":101,\"createBy\":\"admin\",\"roleIds\":[101],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 17:28:35');
INSERT INTO `sys_oper_log` VALUES (1883, '设备状态', 1, 'com.ruoyi.system.controller.IotDeviceStatusController.add()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/status', '180.111.206.137', 'XX XX', '{\"params\":{},\"createTime\":1629974211324}', 'null', 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'device_num\' doesn\'t have a default value\r\n### The error may exist in file [D:\\codes\\IdeaProjects\\wumei-smart-master\\spring-boot\\ruoyi-system\\target\\classes\\mapper\\system\\IotDeviceStatusMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.IotDeviceStatusMapper.insertIotDeviceStatus-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into iot_device_status          ( create_time )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'device_num\' doesn\'t have a default value\n; Field \'device_num\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'device_num\' doesn\'t have a default value', '2021-08-26 18:36:50');
INSERT INTO `sys_oper_log` VALUES (1884, '设备状态', 1, 'com.ruoyi.system.controller.IotDeviceStatusController.add()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/status', '180.111.206.137', 'XX XX', '{\"lightMode\":0,\"isOnline\":1,\"lightStatus\":0,\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"red\":255,\"updateBy\":\"\",\"airHumidity\":0,\"triggerSource\":0,\"lightInterval\":432,\"rssi\":-80,\"green\":254,\"deviceTemperature\":36.52,\"relayStatus\":1,\"fadeTime\":259,\"params\":{},\"createBy\":\"\",\"airTemperature\":0,\"brightness\":100,\"blue\":241,\"createTime\":1629974291015,\"deviceStatusId\":2846}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 18:38:09');
INSERT INTO `sys_oper_log` VALUES (1885, '设备状态', 1, 'com.ruoyi.system.controller.IotDeviceStatusController.add()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/status', '180.111.206.137', 'XX XX', '{\"lightMode\":0,\"isOnline\":1,\"lightStatus\":1,\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"red\":255,\"updateBy\":\"\",\"airHumidity\":0,\"triggerSource\":0,\"lightInterval\":432,\"rssi\":-80,\"green\":254,\"deviceTemperature\":36.52,\"relayStatus\":1,\"fadeTime\":259,\"params\":{},\"createBy\":\"\",\"airTemperature\":0,\"brightness\":100,\"blue\":241,\"createTime\":1629974292396,\"deviceStatusId\":2847}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 18:38:11');
INSERT INTO `sys_oper_log` VALUES (1886, '设备状态', 1, 'com.ruoyi.system.controller.IotDeviceStatusController.add()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/status', '180.111.206.137', 'XX XX', '{\"lightMode\":0,\"isOnline\":1,\"lightStatus\":0,\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"red\":255,\"updateBy\":\"\",\"airHumidity\":0,\"triggerSource\":0,\"lightInterval\":432,\"rssi\":-80,\"green\":254,\"deviceTemperature\":36.52,\"relayStatus\":1,\"fadeTime\":259,\"params\":{},\"createBy\":\"\",\"airTemperature\":0,\"brightness\":100,\"blue\":241,\"createTime\":1629974293231,\"deviceStatusId\":2848}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 18:38:12');
INSERT INTO `sys_oper_log` VALUES (1887, '设备状态', 1, 'com.ruoyi.system.controller.IotDeviceStatusController.add()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/status', '180.111.206.137', 'XX XX', '{\"lightMode\":0,\"isOnline\":1,\"lightStatus\":1,\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"red\":255,\"updateBy\":\"\",\"airHumidity\":0,\"triggerSource\":0,\"lightInterval\":432,\"rssi\":-80,\"green\":254,\"deviceTemperature\":36.52,\"relayStatus\":1,\"fadeTime\":259,\"params\":{},\"createBy\":\"\",\"airTemperature\":0,\"brightness\":100,\"blue\":241,\"createTime\":1629974297356,\"deviceStatusId\":2849}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 18:38:16');
INSERT INTO `sys_oper_log` VALUES (1888, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '222.95.162.245', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADC\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 18:56:26');
INSERT INTO `sys_oper_log` VALUES (1889, '设备状态', 1, 'com.ruoyi.system.controller.IotDeviceStatusController.add()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/status', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"params\":{},\"createTime\":1629976059277,\"deviceStatusId\":2850}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:07:38');
INSERT INTO `sys_oper_log` VALUES (1890, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:16:49');
INSERT INTO `sys_oper_log` VALUES (1891, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:08');
INSERT INTO `sys_oper_log` VALUES (1892, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:09');
INSERT INTO `sys_oper_log` VALUES (1893, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:09');
INSERT INTO `sys_oper_log` VALUES (1894, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:10');
INSERT INTO `sys_oper_log` VALUES (1895, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:10');
INSERT INTO `sys_oper_log` VALUES (1896, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:11');
INSERT INTO `sys_oper_log` VALUES (1897, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:12');
INSERT INTO `sys_oper_log` VALUES (1898, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:13');
INSERT INTO `sys_oper_log` VALUES (1899, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:14');
INSERT INTO `sys_oper_log` VALUES (1900, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:14');
INSERT INTO `sys_oper_log` VALUES (1901, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:15');
INSERT INTO `sys_oper_log` VALUES (1902, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:16');
INSERT INTO `sys_oper_log` VALUES (1903, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:17');
INSERT INTO `sys_oper_log` VALUES (1904, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:17');
INSERT INTO `sys_oper_log` VALUES (1905, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:17:18');
INSERT INTO `sys_oper_log` VALUES (1906, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-26 19:18:38');
INSERT INTO `sys_oper_log` VALUES (1907, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', 'null', 1, '设备不存在', '2021-08-26 19:25:16');
INSERT INTO `sys_oper_log` VALUES (1908, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', 'null', 1, '设备不存在', '2021-08-26 19:25:19');
INSERT INTO `sys_oper_log` VALUES (1909, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', 'null', 1, '设备不存在', '2021-08-27 10:23:46');
INSERT INTO `sys_oper_log` VALUES (1910, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', 'null', 1, '设备不存在', '2021-08-27 10:23:59');
INSERT INTO `sys_oper_log` VALUES (1911, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', 'null', 1, '设备不存在', '2021-08-27 10:24:32');
INSERT INTO `sys_oper_log` VALUES (1912, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', 'null', 1, '设备不存在', '2021-08-27 10:25:53');
INSERT INTO `sys_oper_log` VALUES (1913, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:30:18');
INSERT INTO `sys_oper_log` VALUES (1914, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:30:22');
INSERT INTO `sys_oper_log` VALUES (1915, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:30:23');
INSERT INTO `sys_oper_log` VALUES (1916, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:30:30');
INSERT INTO `sys_oper_log` VALUES (1917, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:33:53');
INSERT INTO `sys_oper_log` VALUES (1918, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:33:56');
INSERT INTO `sys_oper_log` VALUES (1919, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:33:57');
INSERT INTO `sys_oper_log` VALUES (1920, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:33:58');
INSERT INTO `sys_oper_log` VALUES (1921, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:35:34');
INSERT INTO `sys_oper_log` VALUES (1922, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:35:35');
INSERT INTO `sys_oper_log` VALUES (1923, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:35:36');
INSERT INTO `sys_oper_log` VALUES (1924, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:36:33');
INSERT INTO `sys_oper_log` VALUES (1925, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:36:34');
INSERT INTO `sys_oper_log` VALUES (1926, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:36:35');
INSERT INTO `sys_oper_log` VALUES (1927, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:36:35');
INSERT INTO `sys_oper_log` VALUES (1928, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:36:36');
INSERT INTO `sys_oper_log` VALUES (1929, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:40:04');
INSERT INTO `sys_oper_log` VALUES (1930, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:40:06');
INSERT INTO `sys_oper_log` VALUES (1931, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:40:10');
INSERT INTO `sys_oper_log` VALUES (1932, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:40:10');
INSERT INTO `sys_oper_log` VALUES (1933, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:40:21');
INSERT INTO `sys_oper_log` VALUES (1934, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:40:21');
INSERT INTO `sys_oper_log` VALUES (1935, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:41:55');
INSERT INTO `sys_oper_log` VALUES (1936, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:41:55');
INSERT INTO `sys_oper_log` VALUES (1937, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:41:56');
INSERT INTO `sys_oper_log` VALUES (1938, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:41:57');
INSERT INTO `sys_oper_log` VALUES (1939, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:44:07');
INSERT INTO `sys_oper_log` VALUES (1940, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:44:08');
INSERT INTO `sys_oper_log` VALUES (1941, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:44:09');
INSERT INTO `sys_oper_log` VALUES (1942, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 10:44:09');
INSERT INTO `sys_oper_log` VALUES (1943, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 11:38:52');
INSERT INTO `sys_oper_log` VALUES (1944, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 11:38:54');
INSERT INTO `sys_oper_log` VALUES (1945, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 11:53:43');
INSERT INTO `sys_oper_log` VALUES (1946, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 11:53:44');
INSERT INTO `sys_oper_log` VALUES (1947, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 11:53:54');
INSERT INTO `sys_oper_log` VALUES (1948, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '222.95.162.245', 'XX XX', 'iot_device_user_relation', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 11:55:06');
INSERT INTO `sys_oper_log` VALUES (1949, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '222.95.162.245', 'XX XX', '{}', 'null', 0, NULL, '2021-08-27 11:55:34');
INSERT INTO `sys_oper_log` VALUES (1950, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceName\":\"设备名称\",\"deviceNum\":\"7CDFA1049ADC\",\"categoryId\":1}', 'null', 1, '', '2021-08-27 13:36:40');
INSERT INTO `sys_oper_log` VALUES (1951, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceName\":\"设备名称\",\"deviceNum\":\"7CDFA1049ADC\",\"categoryId\":1}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2021-08-27 13:40:21');
INSERT INTO `sys_oper_log` VALUES (1952, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '222.95.162.245', 'XX XX', '{}', 'null', 0, NULL, '2021-08-27 13:44:37');
INSERT INTO `sys_oper_log` VALUES (1953, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/13', '222.95.162.245', 'XX XX', '{tableIds=13}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 13:45:30');
INSERT INTO `sys_oper_log` VALUES (1954, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '222.95.162.245', 'XX XX', 'iot_device', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 13:45:40');
INSERT INTO `sys_oper_log` VALUES (1955, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceName\":\"设备名称\",\"deviceNum\":\"7CDFA1049ADC\",\"categoryId\":1}', 'null', 1, 'Invalid bound statement (not found): com.ruoyi.system.mapper.IotDeviceMapper.selectIotDeviceByNum', '2021-08-27 13:47:50');
INSERT INTO `sys_oper_log` VALUES (1956, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceName\":\"设备名称\",\"deviceNum\":\"7CDFA1049ADC\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 13:50:33');
INSERT INTO `sys_oper_log` VALUES (1957, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceName\":\"设备名称\",\"deviceNum\":\"7CDFA1049ADC\",\"categoryId\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":0}', 0, NULL, '2021-08-27 13:50:43');
INSERT INTO `sys_oper_log` VALUES (1958, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"我的灯。\",\"params\":{},\"deviceName\":\"灯灯灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":0}', 0, NULL, '2021-08-27 14:05:05');
INSERT INTO `sys_oper_log` VALUES (1959, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"我的灯。\",\"params\":{},\"deviceName\":\"灯灯灯\",\"deviceNum\":\"7CDFA1049AD2\",\"categoryId\":2}', 'null', 1, '设备【7CDFA1049AD2】不存在', '2021-08-27 14:07:01');
INSERT INTO `sys_oper_log` VALUES (1960, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"qg34tq\",\"params\":{},\"deviceName\":\"eq3g3\",\"deviceNum\":\"2133r4r\",\"categoryId\":1}', 'null', 1, '设备【2133r4r】不存在', '2021-08-27 14:11:13');
INSERT INTO `sys_oper_log` VALUES (1961, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"stu6ru\",\"params\":{},\"deviceName\":\"rtjsht\",\"deviceNum\":\"strjtj\",\"categoryId\":1}', 'null', 1, '设备【strjtj】不存在', '2021-08-27 14:14:40');
INSERT INTO `sys_oper_log` VALUES (1962, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"stu6ru\",\"params\":{},\"deviceName\":\"rtjsht\",\"deviceNum\":\"strjtj\",\"categoryId\":1}', 'null', 1, '设备【strjtj】不存在', '2021-08-27 14:14:43');
INSERT INTO `sys_oper_log` VALUES (1963, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"我的灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":0}', 0, NULL, '2021-08-27 14:27:15');
INSERT INTO `sys_oper_log` VALUES (1964, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 14:31:26');
INSERT INTO `sys_oper_log` VALUES (1965, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 14:31:49');
INSERT INTO `sys_oper_log` VALUES (1966, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 14:31:50');
INSERT INTO `sys_oper_log` VALUES (1967, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 14:31:51');
INSERT INTO `sys_oper_log` VALUES (1968, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 14:31:52');
INSERT INTO `sys_oper_log` VALUES (1969, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 14:31:53');
INSERT INTO `sys_oper_log` VALUES (1970, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 14:31:54');
INSERT INTO `sys_oper_log` VALUES (1971, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:42');
INSERT INTO `sys_oper_log` VALUES (1972, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:43');
INSERT INTO `sys_oper_log` VALUES (1973, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:44');
INSERT INTO `sys_oper_log` VALUES (1974, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:47');
INSERT INTO `sys_oper_log` VALUES (1975, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:48');
INSERT INTO `sys_oper_log` VALUES (1976, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:48');
INSERT INTO `sys_oper_log` VALUES (1977, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:49');
INSERT INTO `sys_oper_log` VALUES (1978, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:50');
INSERT INTO `sys_oper_log` VALUES (1979, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:50');
INSERT INTO `sys_oper_log` VALUES (1980, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:51');
INSERT INTO `sys_oper_log` VALUES (1981, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:52');
INSERT INTO `sys_oper_log` VALUES (1982, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:52');
INSERT INTO `sys_oper_log` VALUES (1983, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:54');
INSERT INTO `sys_oper_log` VALUES (1984, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:55');
INSERT INTO `sys_oper_log` VALUES (1985, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:32:55');
INSERT INTO `sys_oper_log` VALUES (1986, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"\",\"params\":{},\"deviceName\":\"srts\",\"deviceNum\":\"sh\",\"categoryId\":1}', 'null', 1, '设备【sh】不存在', '2021-08-27 14:34:31');
INSERT INTO `sys_oper_log` VALUES (1987, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"\",\"params\":{},\"deviceName\":\"srts\",\"deviceNum\":\"sh\",\"categoryId\":1}', 'null', 1, '设备【sh】不存在', '2021-08-27 14:34:32');
INSERT INTO `sys_oper_log` VALUES (1988, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"\",\"params\":{},\"deviceName\":\"trwhb4n\",\"deviceNum\":\"wt\",\"categoryId\":1}', 'null', 1, '设备【wt】不存在', '2021-08-27 14:34:59');
INSERT INTO `sys_oper_log` VALUES (1989, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:22');
INSERT INTO `sys_oper_log` VALUES (1990, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:23');
INSERT INTO `sys_oper_log` VALUES (1991, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:23');
INSERT INTO `sys_oper_log` VALUES (1992, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:24');
INSERT INTO `sys_oper_log` VALUES (1993, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:24');
INSERT INTO `sys_oper_log` VALUES (1994, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:25');
INSERT INTO `sys_oper_log` VALUES (1995, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:25');
INSERT INTO `sys_oper_log` VALUES (1996, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:25');
INSERT INTO `sys_oper_log` VALUES (1997, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:25');
INSERT INTO `sys_oper_log` VALUES (1998, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:26');
INSERT INTO `sys_oper_log` VALUES (1999, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:26');
INSERT INTO `sys_oper_log` VALUES (2000, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:26');
INSERT INTO `sys_oper_log` VALUES (2001, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:26');
INSERT INTO `sys_oper_log` VALUES (2002, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:26');
INSERT INTO `sys_oper_log` VALUES (2003, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:27');
INSERT INTO `sys_oper_log` VALUES (2004, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁\",\"params\":{},\"deviceName\":\"灯神\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-27 14:35:27');
INSERT INTO `sys_oper_log` VALUES (2005, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁灯灯灯灯灯。\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":0}', 0, NULL, '2021-08-27 15:00:17');
INSERT INTO `sys_oper_log` VALUES (2006, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 15:05:11');
INSERT INTO `sys_oper_log` VALUES (2007, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 15:06:01');
INSERT INTO `sys_oper_log` VALUES (2008, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 15:06:11');
INSERT INTO `sys_oper_log` VALUES (2009, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 15:06:20');
INSERT INTO `sys_oper_log` VALUES (2010, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 15:07:41');
INSERT INTO `sys_oper_log` VALUES (2011, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 15:09:18');
INSERT INTO `sys_oper_log` VALUES (2012, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 15:09:28');
INSERT INTO `sys_oper_log` VALUES (2013, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":0}', 0, NULL, '2021-08-27 15:17:38');
INSERT INTO `sys_oper_log` VALUES (2014, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 15:17:41');
INSERT INTO `sys_oper_log` VALUES (2015, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":0}', 0, NULL, '2021-08-27 15:18:35');
INSERT INTO `sys_oper_log` VALUES (2016, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":1,\"deviceName\":\"设备名称\"}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2021-08-27 15:44:27');
INSERT INTO `sys_oper_log` VALUES (2017, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":1,\"deviceName\":\"设备名称\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":0}', 0, NULL, '2021-08-27 15:45:52');
INSERT INTO `sys_oper_log` VALUES (2018, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":51,\"deviceName\":\"设备名称\"}', 'null', 1, '设备不存在', '2021-08-27 15:46:30');
INSERT INTO `sys_oper_log` VALUES (2019, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":5,\"deviceName\":\"设备名称\"}', 'null', 1, '设备不存在', '2021-08-27 15:46:53');
INSERT INTO `sys_oper_log` VALUES (2020, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":5,\"deviceName\":\"设备名称\"}', 'null', 1, '设备不存在', '2021-08-27 15:46:59');
INSERT INTO `sys_oper_log` VALUES (2021, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":7,\"deviceName\":\"设备名称\"}', 'null', 1, '设备不存在', '2021-08-27 15:47:18');
INSERT INTO `sys_oper_log` VALUES (2022, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":7,\"deviceName\":\"设备名称\"}', 'null', 1, '设备不存在', '2021-08-27 15:47:46');
INSERT INTO `sys_oper_log` VALUES (2023, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":1,\"deviceName\":\"设备名称\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":0}', 0, NULL, '2021-08-27 15:48:03');
INSERT INTO `sys_oper_log` VALUES (2024, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":1,\"deviceName\":\"设备名称\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":0}', 0, NULL, '2021-08-27 15:49:24');
INSERT INTO `sys_oper_log` VALUES (2025, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark\",\"params\":{},\"deviceId\":1,\"deviceName\":\"设备名称\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 15:51:57');
INSERT INTO `sys_oper_log` VALUES (2026, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '222.95.162.245', 'XX XX', '{\"remark\":\"remark2\",\"params\":{},\"deviceId\":1,\"deviceName\":\"设备名称\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 15:52:38');
INSERT INTO `sys_oper_log` VALUES (2027, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:39');
INSERT INTO `sys_oper_log` VALUES (2028, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:40');
INSERT INTO `sys_oper_log` VALUES (2029, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:42');
INSERT INTO `sys_oper_log` VALUES (2030, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:42');
INSERT INTO `sys_oper_log` VALUES (2031, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:43');
INSERT INTO `sys_oper_log` VALUES (2032, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:43');
INSERT INTO `sys_oper_log` VALUES (2033, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:44');
INSERT INTO `sys_oper_log` VALUES (2034, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:45');
INSERT INTO `sys_oper_log` VALUES (2035, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:45');
INSERT INTO `sys_oper_log` VALUES (2036, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:45');
INSERT INTO `sys_oper_log` VALUES (2037, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:45');
INSERT INTO `sys_oper_log` VALUES (2038, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:45');
INSERT INTO `sys_oper_log` VALUES (2039, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:46');
INSERT INTO `sys_oper_log` VALUES (2040, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:46');
INSERT INTO `sys_oper_log` VALUES (2041, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:46');
INSERT INTO `sys_oper_log` VALUES (2042, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:47');
INSERT INTO `sys_oper_log` VALUES (2043, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:47');
INSERT INTO `sys_oper_log` VALUES (2044, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:47');
INSERT INTO `sys_oper_log` VALUES (2045, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:47');
INSERT INTO `sys_oper_log` VALUES (2046, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:48');
INSERT INTO `sys_oper_log` VALUES (2047, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:48');
INSERT INTO `sys_oper_log` VALUES (2048, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:48');
INSERT INTO `sys_oper_log` VALUES (2049, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:49');
INSERT INTO `sys_oper_log` VALUES (2050, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:49');
INSERT INTO `sys_oper_log` VALUES (2051, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:51');
INSERT INTO `sys_oper_log` VALUES (2052, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:52');
INSERT INTO `sys_oper_log` VALUES (2053, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:52');
INSERT INTO `sys_oper_log` VALUES (2054, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:52');
INSERT INTO `sys_oper_log` VALUES (2055, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:52');
INSERT INTO `sys_oper_log` VALUES (2056, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:53');
INSERT INTO `sys_oper_log` VALUES (2057, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:54');
INSERT INTO `sys_oper_log` VALUES (2058, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:55');
INSERT INTO `sys_oper_log` VALUES (2059, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:56');
INSERT INTO `sys_oper_log` VALUES (2060, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:57');
INSERT INTO `sys_oper_log` VALUES (2061, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:57');
INSERT INTO `sys_oper_log` VALUES (2062, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:57');
INSERT INTO `sys_oper_log` VALUES (2063, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:58');
INSERT INTO `sys_oper_log` VALUES (2064, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:58');
INSERT INTO `sys_oper_log` VALUES (2065, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:58');
INSERT INTO `sys_oper_log` VALUES (2066, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:58');
INSERT INTO `sys_oper_log` VALUES (2067, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:59');
INSERT INTO `sys_oper_log` VALUES (2068, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:59');
INSERT INTO `sys_oper_log` VALUES (2069, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:59');
INSERT INTO `sys_oper_log` VALUES (2070, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:55:59');
INSERT INTO `sys_oper_log` VALUES (2071, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:00');
INSERT INTO `sys_oper_log` VALUES (2072, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:00');
INSERT INTO `sys_oper_log` VALUES (2073, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:00');
INSERT INTO `sys_oper_log` VALUES (2074, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:00');
INSERT INTO `sys_oper_log` VALUES (2075, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:01');
INSERT INTO `sys_oper_log` VALUES (2076, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:01');
INSERT INTO `sys_oper_log` VALUES (2077, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:01');
INSERT INTO `sys_oper_log` VALUES (2078, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:01');
INSERT INTO `sys_oper_log` VALUES (2079, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:01');
INSERT INTO `sys_oper_log` VALUES (2080, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:02');
INSERT INTO `sys_oper_log` VALUES (2081, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:02');
INSERT INTO `sys_oper_log` VALUES (2082, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:02');
INSERT INTO `sys_oper_log` VALUES (2083, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:02');
INSERT INTO `sys_oper_log` VALUES (2084, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:03');
INSERT INTO `sys_oper_log` VALUES (2085, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:04');
INSERT INTO `sys_oper_log` VALUES (2086, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:04');
INSERT INTO `sys_oper_log` VALUES (2087, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:04');
INSERT INTO `sys_oper_log` VALUES (2088, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:04');
INSERT INTO `sys_oper_log` VALUES (2089, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:04');
INSERT INTO `sys_oper_log` VALUES (2090, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:05');
INSERT INTO `sys_oper_log` VALUES (2091, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 15:56:05');
INSERT INTO `sys_oper_log` VALUES (2092, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":1,\"deviceName\":\"阿拉丁神灯\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 16:07:26');
INSERT INTO `sys_oper_log` VALUES (2093, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":1,\"deviceName\":\"阿拉丁神灯\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 16:08:03');
INSERT INTO `sys_oper_log` VALUES (2094, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":1,\"deviceName\":\"阿拉丁神灯\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 16:11:32');
INSERT INTO `sys_oper_log` VALUES (2095, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":1234,\"deviceName\":\"阿拉丁神灯\"}', 'null', 1, '设备不存在', '2021-08-27 16:12:50');
INSERT INTO `sys_oper_log` VALUES (2096, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":1234,\"deviceName\":\"阿拉丁神灯\"}', 'null', 1, '设备不存在', '2021-08-27 16:12:54');
INSERT INTO `sys_oper_log` VALUES (2097, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":1,\"deviceName\":\"阿拉丁神灯\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 16:13:42');
INSERT INTO `sys_oper_log` VALUES (2098, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":1,\"deviceName\":\"阿拉丁神灯\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 16:14:01');
INSERT INTO `sys_oper_log` VALUES (2099, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:14:13');
INSERT INTO `sys_oper_log` VALUES (2100, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:14:14');
INSERT INTO `sys_oper_log` VALUES (2101, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":12133,\"deviceName\":\"阿拉丁神灯\"}', 'null', 1, '设备不存在', '2021-08-27 16:16:03');
INSERT INTO `sys_oper_log` VALUES (2102, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":12133,\"deviceName\":\"阿拉丁神灯\"}', 'null', 1, '设备不存在', '2021-08-27 16:16:06');
INSERT INTO `sys_oper_log` VALUES (2103, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":12133,\"deviceName\":\"阿拉丁神灯\"}', 'null', 1, '设备不存在', '2021-08-27 16:16:15');
INSERT INTO `sys_oper_log` VALUES (2104, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":12133,\"deviceName\":\"阿拉丁神灯\"}', 'null', 1, '设备不存在', '2021-08-27 16:16:18');
INSERT INTO `sys_oper_log` VALUES (2105, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceId\":1,\"deviceName\":\"阿拉丁神灯\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 16:18:05');
INSERT INTO `sys_oper_log` VALUES (2106, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:22:53');
INSERT INTO `sys_oper_log` VALUES (2107, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:23:24');
INSERT INTO `sys_oper_log` VALUES (2108, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:23:41');
INSERT INTO `sys_oper_log` VALUES (2109, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:23:43');
INSERT INTO `sys_oper_log` VALUES (2110, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:26:33');
INSERT INTO `sys_oper_log` VALUES (2111, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:27:37');
INSERT INTO `sys_oper_log` VALUES (2112, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:27:54');
INSERT INTO `sys_oper_log` VALUES (2113, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:28:12');
INSERT INTO `sys_oper_log` VALUES (2114, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:30:10');
INSERT INTO `sys_oper_log` VALUES (2115, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:30:32');
INSERT INTO `sys_oper_log` VALUES (2116, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:30:35');
INSERT INTO `sys_oper_log` VALUES (2117, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:34:21');
INSERT INTO `sys_oper_log` VALUES (2118, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:35:01');
INSERT INTO `sys_oper_log` VALUES (2119, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:39:15');
INSERT INTO `sys_oper_log` VALUES (2120, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:40:56');
INSERT INTO `sys_oper_log` VALUES (2121, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:42:53');
INSERT INTO `sys_oper_log` VALUES (2122, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:45:04');
INSERT INTO `sys_oper_log` VALUES (2123, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:45:18');
INSERT INTO `sys_oper_log` VALUES (2124, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:45:29');
INSERT INTO `sys_oper_log` VALUES (2125, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:46:52');
INSERT INTO `sys_oper_log` VALUES (2126, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:47:39');
INSERT INTO `sys_oper_log` VALUES (2127, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:55:23');
INSERT INTO `sys_oper_log` VALUES (2128, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:55:41');
INSERT INTO `sys_oper_log` VALUES (2129, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:55:50');
INSERT INTO `sys_oper_log` VALUES (2130, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:55:50');
INSERT INTO `sys_oper_log` VALUES (2131, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:56:08');
INSERT INTO `sys_oper_log` VALUES (2132, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:56:11');
INSERT INTO `sys_oper_log` VALUES (2133, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:56:21');
INSERT INTO `sys_oper_log` VALUES (2134, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:23');
INSERT INTO `sys_oper_log` VALUES (2135, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:24');
INSERT INTO `sys_oper_log` VALUES (2136, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:25');
INSERT INTO `sys_oper_log` VALUES (2137, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:25');
INSERT INTO `sys_oper_log` VALUES (2138, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:27');
INSERT INTO `sys_oper_log` VALUES (2139, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:28');
INSERT INTO `sys_oper_log` VALUES (2140, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:28');
INSERT INTO `sys_oper_log` VALUES (2141, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:29');
INSERT INTO `sys_oper_log` VALUES (2142, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:29');
INSERT INTO `sys_oper_log` VALUES (2143, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:56:30');
INSERT INTO `sys_oper_log` VALUES (2144, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:56:55');
INSERT INTO `sys_oper_log` VALUES (2145, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:57:00');
INSERT INTO `sys_oper_log` VALUES (2146, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:57:15');
INSERT INTO `sys_oper_log` VALUES (2147, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '49.93.129.115', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 16:57:19');
INSERT INTO `sys_oper_log` VALUES (2148, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:57:22');
INSERT INTO `sys_oper_log` VALUES (2149, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:57:23');
INSERT INTO `sys_oper_log` VALUES (2150, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:57:23');
INSERT INTO `sys_oper_log` VALUES (2151, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:57:24');
INSERT INTO `sys_oper_log` VALUES (2152, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/updateDeviceInfo', '49.93.129.115', 'XX XX', '{\"remark\":\"12\",\"params\":{},\"deviceId\":1,\"deviceName\":\"remark\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 16:59:38');
INSERT INTO `sys_oper_log` VALUES (2153, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:59:45');
INSERT INTO `sys_oper_log` VALUES (2154, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '49.93.129.115', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 16:59:46');
INSERT INTO `sys_oper_log` VALUES (2155, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"122345678\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"7CDFA1049ADA\",\"categoryId\":2}', 'null', 1, '该设备已被绑定！', '2021-08-27 17:00:56');
INSERT INTO `sys_oper_log` VALUES (2156, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"cmd\":\"off\"}', 'null', 1, '设备编号不能为空', '2021-08-27 17:27:02');
INSERT INTO `sys_oper_log` VALUES (2157, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"cmd\":\"off\"}', 'null', 1, '设备编号不能为空', '2021-08-27 17:27:54');
INSERT INTO `sys_oper_log` VALUES (2158, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"cmd\":\"off\"}', 'null', 1, '设备编号不能为空', '2021-08-27 17:27:56');
INSERT INTO `sys_oper_log` VALUES (2159, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"cmd\":\"off\"}', 'null', 1, '设备编号不能为空', '2021-08-27 17:27:57');
INSERT INTO `sys_oper_log` VALUES (2160, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"cmd\":\"off\"}', 'null', 1, '设备编号不能为空', '2021-08-27 17:27:57');
INSERT INTO `sys_oper_log` VALUES (2161, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"cmd\":\"off\"}', 'null', 1, '设备编号不能为空', '2021-08-27 17:28:00');
INSERT INTO `sys_oper_log` VALUES (2162, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceNum()', 'GET', 1, 'A1BB9722086A', NULL, '/system/device/getDeviceInfoByDeviceNum', '222.95.162.245', 'XX XX', '{}', 'null', 1, 'nested exception is org.apache.ibatis.type.TypeException: Could not set parameters for mapping: ParameterMapping{property=\'userId\', mode=IN, javaType=class java.lang.String, jdbcType=null, numericScale=null, resultMapId=\'null\', jdbcTypeName=\'null\', expression=\'null\'}. Cause: org.apache.ibatis.type.TypeException: Error setting non null for parameter #1 with JdbcType null . Try setting a different JdbcType for this parameter or a different configuration property. Cause: java.lang.ClassCastException: java.lang.Long cannot be cast to java.lang.String', '2021-08-27 17:58:25');
INSERT INTO `sys_oper_log` VALUES (2163, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceNum()', 'GET', 1, 'A1BB9722086A', NULL, '/system/device/getDeviceInfoByDeviceNum', '222.95.162.245', 'XX XX', '{}', 'null', 1, 'nested exception is org.apache.ibatis.type.TypeException: Could not set parameters for mapping: ParameterMapping{property=\'userId\', mode=IN, javaType=class java.lang.String, jdbcType=null, numericScale=null, resultMapId=\'null\', jdbcTypeName=\'null\', expression=\'null\'}. Cause: org.apache.ibatis.type.TypeException: Error setting non null for parameter #1 with JdbcType null . Try setting a different JdbcType for this parameter or a different configuration property. Cause: java.lang.ClassCastException: java.lang.Long cannot be cast to java.lang.String', '2021-08-27 17:59:54');
INSERT INTO `sys_oper_log` VALUES (2164, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceNum()', 'GET', 1, 'A1BB9722086A', NULL, '/system/device/getDeviceInfoByDeviceNum', '222.95.162.245', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"7CDFA1049ADA\",\"remark\":\"12\",\"isOnline\":true,\"deviceName\":\"remark\",\"deviceId\":1}}', 0, NULL, '2021-08-27 18:01:18');
INSERT INTO `sys_oper_log` VALUES (2165, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.unBindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/unBindDevice', '222.95.162.245', 'XX XX', '{\"params\":{},\"deviceId\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 18:02:38');
INSERT INTO `sys_oper_log` VALUES (2166, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"7CDFA1049ADA\",\"remark\":\"122345678\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":1}}', 0, NULL, '2021-08-27 18:15:10');
INSERT INTO `sys_oper_log` VALUES (2167, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"7CDFA1049ADA\",\"remark\":\"122345678\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":1}}', 0, NULL, '2021-08-27 18:16:30');
INSERT INTO `sys_oper_log` VALUES (2168, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"7CDFA1049ADA\",\"category_name\":\"智能灯\",\"remark\":\"122345678\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":1}}', 0, NULL, '2021-08-27 18:22:10');
INSERT INTO `sys_oper_log` VALUES (2169, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"7CDFA1049ADA\",\"remark\":\"122345678\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":1,\"categoryName\":\"智能灯\",\"categoryId\":2}}', 0, NULL, '2021-08-27 18:25:00');
INSERT INTO `sys_oper_log` VALUES (2170, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"7CDFA1049ADA\",\"remark\":\"122345678\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":1,\"categoryName\":\"智能灯\",\"categoryId\":2}}', 0, NULL, '2021-08-27 18:26:08');
INSERT INTO `sys_oper_log` VALUES (2171, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceNum()', 'GET', 1, 'A1BB9722086A', NULL, '/system/device/getDeviceInfoByDeviceNum', '222.95.162.245', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"7CDFA1049ADA\",\"isOnline\":true,\"lightStatus\":true,\"deviceId\":1,\"categoryName\":\"智能灯\",\"categoryId\":2}}', 0, NULL, '2021-08-27 18:27:17');
INSERT INTO `sys_oper_log` VALUES (2172, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"7CDFA1049ADA\",\"remark\":\"122345678\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":1,\"categoryName\":\"智能灯\",\"categoryId\":2}}', 0, NULL, '2021-08-27 18:27:36');
INSERT INTO `sys_oper_log` VALUES (2173, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"7CDFA1049ADA\",\"remark\":\"122345678\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":1,\"categoryName\":\"智能灯\",\"categoryId\":2}}', 0, NULL, '2021-08-27 18:28:40');
INSERT INTO `sys_oper_log` VALUES (2174, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 18:28:42');
INSERT INTO `sys_oper_log` VALUES (2175, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 18:28:43');
INSERT INTO `sys_oper_log` VALUES (2176, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 18:28:44');
INSERT INTO `sys_oper_log` VALUES (2177, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"7CDFA1049ADA\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 18:28:44');
INSERT INTO `sys_oper_log` VALUES (2178, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.unBindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/unBindDevice', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceId\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-27 18:28:51');
INSERT INTO `sys_oper_log` VALUES (2179, '通知公告', 1, 'com.ruoyi.web.controller.system.SysNoticeController.add()', 'POST', 1, 'admin', NULL, '/system/notice', '222.95.162.245', 'XX XX', '{\"noticeContent\":\"<p>111111</p>\",\"createBy\":\"admin\",\"noticeType\":\"2\",\"params\":{},\"noticeTitle\":\"111\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-27 19:24:12');
INSERT INTO `sys_oper_log` VALUES (2180, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/bindDevice', '58.212.134.111', 'XX XX', '{\"remark\":\"\",\"params\":{},\"deviceName\":\"wxy测试开关\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-28 13:35:23');
INSERT INTO `sys_oper_log` VALUES (2181, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:39:38');
INSERT INTO `sys_oper_log` VALUES (2182, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:39:40');
INSERT INTO `sys_oper_log` VALUES (2183, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:39:50');
INSERT INTO `sys_oper_log` VALUES (2184, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:39:51');
INSERT INTO `sys_oper_log` VALUES (2185, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:39:57');
INSERT INTO `sys_oper_log` VALUES (2186, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:39:58');
INSERT INTO `sys_oper_log` VALUES (2187, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:40:00');
INSERT INTO `sys_oper_log` VALUES (2188, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:40:01');
INSERT INTO `sys_oper_log` VALUES (2189, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:40:01');
INSERT INTO `sys_oper_log` VALUES (2190, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:40:02');
INSERT INTO `sys_oper_log` VALUES (2191, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:43:55');
INSERT INTO `sys_oper_log` VALUES (2192, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:43:56');
INSERT INTO `sys_oper_log` VALUES (2193, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:44:03');
INSERT INTO `sys_oper_log` VALUES (2194, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:44:03');
INSERT INTO `sys_oper_log` VALUES (2195, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:48:43');
INSERT INTO `sys_oper_log` VALUES (2196, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:50:44');
INSERT INTO `sys_oper_log` VALUES (2197, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:50:56');
INSERT INTO `sys_oper_log` VALUES (2198, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:51:02');
INSERT INTO `sys_oper_log` VALUES (2199, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'A1BB9722086A', NULL, '/system/device/control', '58.212.134.111', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-28 13:51:11');
INSERT INTO `sys_oper_log` VALUES (2200, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"阿拉丁等等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-30 10:17:55');
INSERT INTO `sys_oper_log` VALUES (2201, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:18:41');
INSERT INTO `sys_oper_log` VALUES (2202, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:18:47');
INSERT INTO `sys_oper_log` VALUES (2203, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:18:54');
INSERT INTO `sys_oper_log` VALUES (2204, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:19:08');
INSERT INTO `sys_oper_log` VALUES (2205, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:19:12');
INSERT INTO `sys_oper_log` VALUES (2206, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:19:35');
INSERT INTO `sys_oper_log` VALUES (2207, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:19:37');
INSERT INTO `sys_oper_log` VALUES (2208, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:20:09');
INSERT INTO `sys_oper_log` VALUES (2209, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:24:30');
INSERT INTO `sys_oper_log` VALUES (2210, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:25:17');
INSERT INTO `sys_oper_log` VALUES (2211, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:25:19');
INSERT INTO `sys_oper_log` VALUES (2212, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:25:23');
INSERT INTO `sys_oper_log` VALUES (2213, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:25:27');
INSERT INTO `sys_oper_log` VALUES (2214, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:25:36');
INSERT INTO `sys_oper_log` VALUES (2215, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:26:00');
INSERT INTO `sys_oper_log` VALUES (2216, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:26:18');
INSERT INTO `sys_oper_log` VALUES (2217, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:26:20');
INSERT INTO `sys_oper_log` VALUES (2218, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:26:21');
INSERT INTO `sys_oper_log` VALUES (2219, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:29:11');
INSERT INTO `sys_oper_log` VALUES (2220, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:31:31');
INSERT INTO `sys_oper_log` VALUES (2221, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:33:12');
INSERT INTO `sys_oper_log` VALUES (2222, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:33:20');
INSERT INTO `sys_oper_log` VALUES (2223, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:38:44');
INSERT INTO `sys_oper_log` VALUES (2224, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:38:58');
INSERT INTO `sys_oper_log` VALUES (2225, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:39:41');
INSERT INTO `sys_oper_log` VALUES (2226, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:40:32');
INSERT INTO `sys_oper_log` VALUES (2227, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:42:12');
INSERT INTO `sys_oper_log` VALUES (2228, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:45:49');
INSERT INTO `sys_oper_log` VALUES (2229, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:45:54');
INSERT INTO `sys_oper_log` VALUES (2230, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:46:27');
INSERT INTO `sys_oper_log` VALUES (2231, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:46:32');
INSERT INTO `sys_oper_log` VALUES (2232, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:48:18');
INSERT INTO `sys_oper_log` VALUES (2233, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:50:12');
INSERT INTO `sys_oper_log` VALUES (2234, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:53:58');
INSERT INTO `sys_oper_log` VALUES (2235, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:54:13');
INSERT INTO `sys_oper_log` VALUES (2236, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:54:35');
INSERT INTO `sys_oper_log` VALUES (2237, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:54:40');
INSERT INTO `sys_oper_log` VALUES (2238, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:55:08');
INSERT INTO `sys_oper_log` VALUES (2239, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:55:11');
INSERT INTO `sys_oper_log` VALUES (2240, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:55:34');
INSERT INTO `sys_oper_log` VALUES (2241, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:55:46');
INSERT INTO `sys_oper_log` VALUES (2242, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.unBindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/unBindDevice', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceId\":4}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-30 10:55:59');
INSERT INTO `sys_oper_log` VALUES (2243, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '180.111.206.137', 'XX XX', '{\"remark\":\"\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":2}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-30 10:57:14');
INSERT INTO `sys_oper_log` VALUES (2244, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:57:19');
INSERT INTO `sys_oper_log` VALUES (2245, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:57:22');
INSERT INTO `sys_oper_log` VALUES (2246, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 10:57:25');
INSERT INTO `sys_oper_log` VALUES (2247, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"params\":{},\"deviceId\":4,\"deviceName\":\"阿拉丁\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-30 10:57:35');
INSERT INTO `sys_oper_log` VALUES (2248, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 10:57:39');
INSERT INTO `sys_oper_log` VALUES (2249, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 15:27:39');
INSERT INTO `sys_oper_log` VALUES (2250, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 15:27:44');
INSERT INTO `sys_oper_log` VALUES (2251, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceId\":4,\"deviceName\":\"阿拉丁\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-30 15:28:03');
INSERT INTO `sys_oper_log` VALUES (2252, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 15:28:05');
INSERT INTO `sys_oper_log` VALUES (2253, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.updateDeviceInfo()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/updateDeviceInfo', '180.111.206.137', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceId\":4,\"deviceName\":\"阿拉丁神灯\"}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-30 15:28:25');
INSERT INTO `sys_oper_log` VALUES (2254, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 15:28:27');
INSERT INTO `sys_oper_log` VALUES (2255, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 15:28:33');
INSERT INTO `sys_oper_log` VALUES (2256, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.137', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 15:28:35');
INSERT INTO `sys_oper_log` VALUES (2257, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 15:28:55');
INSERT INTO `sys_oper_log` VALUES (2258, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 15:30:29');
INSERT INTO `sys_oper_log` VALUES (2259, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 15:30:46');
INSERT INTO `sys_oper_log` VALUES (2260, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.137', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 15:31:12');
INSERT INTO `sys_oper_log` VALUES (2261, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:53:02');
INSERT INTO `sys_oper_log` VALUES (2262, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:54:39');
INSERT INTO `sys_oper_log` VALUES (2263, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:54:46');
INSERT INTO `sys_oper_log` VALUES (2264, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:57:11');
INSERT INTO `sys_oper_log` VALUES (2265, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:57:19');
INSERT INTO `sys_oper_log` VALUES (2266, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:57:22');
INSERT INTO `sys_oper_log` VALUES (2267, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:57:30');
INSERT INTO `sys_oper_log` VALUES (2268, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:57:34');
INSERT INTO `sys_oper_log` VALUES (2269, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:57:56');
INSERT INTO `sys_oper_log` VALUES (2270, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 18:58:26');
INSERT INTO `sys_oper_log` VALUES (2271, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 19:00:11');
INSERT INTO `sys_oper_log` VALUES (2272, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 19:08:36');
INSERT INTO `sys_oper_log` VALUES (2273, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 19:17:25');
INSERT INTO `sys_oper_log` VALUES (2274, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 19:17:30');
INSERT INTO `sys_oper_log` VALUES (2275, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 19:19:06');
INSERT INTO `sys_oper_log` VALUES (2276, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-30 19:50:40');
INSERT INTO `sys_oper_log` VALUES (2277, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:41');
INSERT INTO `sys_oper_log` VALUES (2278, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:42');
INSERT INTO `sys_oper_log` VALUES (2279, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:43');
INSERT INTO `sys_oper_log` VALUES (2280, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:44');
INSERT INTO `sys_oper_log` VALUES (2281, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:45');
INSERT INTO `sys_oper_log` VALUES (2282, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:45');
INSERT INTO `sys_oper_log` VALUES (2283, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:46');
INSERT INTO `sys_oper_log` VALUES (2284, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:46');
INSERT INTO `sys_oper_log` VALUES (2285, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:47');
INSERT INTO `sys_oper_log` VALUES (2286, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:47');
INSERT INTO `sys_oper_log` VALUES (2287, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:48');
INSERT INTO `sys_oper_log` VALUES (2288, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:49');
INSERT INTO `sys_oper_log` VALUES (2289, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:49');
INSERT INTO `sys_oper_log` VALUES (2290, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:53');
INSERT INTO `sys_oper_log` VALUES (2291, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:54');
INSERT INTO `sys_oper_log` VALUES (2292, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:55');
INSERT INTO `sys_oper_log` VALUES (2293, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:55');
INSERT INTO `sys_oper_log` VALUES (2294, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-30 19:50:55');
INSERT INTO `sys_oper_log` VALUES (2295, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 10:35:17');
INSERT INTO `sys_oper_log` VALUES (2296, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:46:28');
INSERT INTO `sys_oper_log` VALUES (2297, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:48:05');
INSERT INTO `sys_oper_log` VALUES (2298, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:48:10');
INSERT INTO `sys_oper_log` VALUES (2299, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/bindDevice', '180.111.206.122', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-31 14:48:23');
INSERT INTO `sys_oper_log` VALUES (2300, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:48:32');
INSERT INTO `sys_oper_log` VALUES (2301, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:48:34');
INSERT INTO `sys_oper_log` VALUES (2302, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:48:39');
INSERT INTO `sys_oper_log` VALUES (2303, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:48:40');
INSERT INTO `sys_oper_log` VALUES (2304, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:48:49');
INSERT INTO `sys_oper_log` VALUES (2305, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:48:50');
INSERT INTO `sys_oper_log` VALUES (2306, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:48:50');
INSERT INTO `sys_oper_log` VALUES (2307, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:03');
INSERT INTO `sys_oper_log` VALUES (2308, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:04');
INSERT INTO `sys_oper_log` VALUES (2309, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:05');
INSERT INTO `sys_oper_log` VALUES (2310, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:06');
INSERT INTO `sys_oper_log` VALUES (2311, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:06');
INSERT INTO `sys_oper_log` VALUES (2312, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:07');
INSERT INTO `sys_oper_log` VALUES (2313, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:08');
INSERT INTO `sys_oper_log` VALUES (2314, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:08');
INSERT INTO `sys_oper_log` VALUES (2315, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:15');
INSERT INTO `sys_oper_log` VALUES (2316, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:16');
INSERT INTO `sys_oper_log` VALUES (2317, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:49:34');
INSERT INTO `sys_oper_log` VALUES (2318, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:49:42');
INSERT INTO `sys_oper_log` VALUES (2319, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:49:48');
INSERT INTO `sys_oper_log` VALUES (2320, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.unBindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/unBindDevice', '180.111.206.122', 'XX XX', '{\"params\":{},\"deviceId\":4}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-31 14:49:54');
INSERT INTO `sys_oper_log` VALUES (2321, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:50:01');
INSERT INTO `sys_oper_log` VALUES (2322, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/bindDevice', '180.111.206.122', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-31 14:50:07');
INSERT INTO `sys_oper_log` VALUES (2323, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:50:09');
INSERT INTO `sys_oper_log` VALUES (2324, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:50:10');
INSERT INTO `sys_oper_log` VALUES (2325, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/bindDevice', '180.111.206.122', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-31 14:50:14');
INSERT INTO `sys_oper_log` VALUES (2326, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:50:17');
INSERT INTO `sys_oper_log` VALUES (2327, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:50:18');
INSERT INTO `sys_oper_log` VALUES (2328, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/bindDevice', '180.111.206.122', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-31 14:50:22');
INSERT INTO `sys_oper_log` VALUES (2329, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:50:25');
INSERT INTO `sys_oper_log` VALUES (2330, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:50:26');
INSERT INTO `sys_oper_log` VALUES (2331, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:50:34');
INSERT INTO `sys_oper_log` VALUES (2332, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:50:38');
INSERT INTO `sys_oper_log` VALUES (2333, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:50:59');
INSERT INTO `sys_oper_log` VALUES (2334, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:00');
INSERT INTO `sys_oper_log` VALUES (2335, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:01');
INSERT INTO `sys_oper_log` VALUES (2336, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:02');
INSERT INTO `sys_oper_log` VALUES (2337, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:03');
INSERT INTO `sys_oper_log` VALUES (2338, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:04');
INSERT INTO `sys_oper_log` VALUES (2339, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:05');
INSERT INTO `sys_oper_log` VALUES (2340, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:05');
INSERT INTO `sys_oper_log` VALUES (2341, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:06');
INSERT INTO `sys_oper_log` VALUES (2342, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:06');
INSERT INTO `sys_oper_log` VALUES (2343, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:07');
INSERT INTO `sys_oper_log` VALUES (2344, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:08');
INSERT INTO `sys_oper_log` VALUES (2345, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:08');
INSERT INTO `sys_oper_log` VALUES (2346, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:09');
INSERT INTO `sys_oper_log` VALUES (2347, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:10');
INSERT INTO `sys_oper_log` VALUES (2348, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:51:29');
INSERT INTO `sys_oper_log` VALUES (2349, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:31');
INSERT INTO `sys_oper_log` VALUES (2350, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:32');
INSERT INTO `sys_oper_log` VALUES (2351, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:32');
INSERT INTO `sys_oper_log` VALUES (2352, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:33');
INSERT INTO `sys_oper_log` VALUES (2353, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:33');
INSERT INTO `sys_oper_log` VALUES (2354, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:34');
INSERT INTO `sys_oper_log` VALUES (2355, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:34');
INSERT INTO `sys_oper_log` VALUES (2356, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:51:35');
INSERT INTO `sys_oper_log` VALUES (2357, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:52:57');
INSERT INTO `sys_oper_log` VALUES (2358, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:52:59');
INSERT INTO `sys_oper_log` VALUES (2359, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:52:59');
INSERT INTO `sys_oper_log` VALUES (2360, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:01');
INSERT INTO `sys_oper_log` VALUES (2361, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:02');
INSERT INTO `sys_oper_log` VALUES (2362, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:02');
INSERT INTO `sys_oper_log` VALUES (2363, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:02');
INSERT INTO `sys_oper_log` VALUES (2364, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:02');
INSERT INTO `sys_oper_log` VALUES (2365, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:03');
INSERT INTO `sys_oper_log` VALUES (2366, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:03');
INSERT INTO `sys_oper_log` VALUES (2367, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:03');
INSERT INTO `sys_oper_log` VALUES (2368, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:03');
INSERT INTO `sys_oper_log` VALUES (2369, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:03');
INSERT INTO `sys_oper_log` VALUES (2370, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:04');
INSERT INTO `sys_oper_log` VALUES (2371, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:04');
INSERT INTO `sys_oper_log` VALUES (2372, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:04');
INSERT INTO `sys_oper_log` VALUES (2373, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:04');
INSERT INTO `sys_oper_log` VALUES (2374, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:05');
INSERT INTO `sys_oper_log` VALUES (2375, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:05');
INSERT INTO `sys_oper_log` VALUES (2376, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:05');
INSERT INTO `sys_oper_log` VALUES (2377, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:05');
INSERT INTO `sys_oper_log` VALUES (2378, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:05');
INSERT INTO `sys_oper_log` VALUES (2379, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:06');
INSERT INTO `sys_oper_log` VALUES (2380, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:06');
INSERT INTO `sys_oper_log` VALUES (2381, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:07');
INSERT INTO `sys_oper_log` VALUES (2382, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:07');
INSERT INTO `sys_oper_log` VALUES (2383, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:07');
INSERT INTO `sys_oper_log` VALUES (2384, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:07');
INSERT INTO `sys_oper_log` VALUES (2385, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:07');
INSERT INTO `sys_oper_log` VALUES (2386, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:08');
INSERT INTO `sys_oper_log` VALUES (2387, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:08');
INSERT INTO `sys_oper_log` VALUES (2388, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:08');
INSERT INTO `sys_oper_log` VALUES (2389, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:08');
INSERT INTO `sys_oper_log` VALUES (2390, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:09');
INSERT INTO `sys_oper_log` VALUES (2391, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:09');
INSERT INTO `sys_oper_log` VALUES (2392, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:17');
INSERT INTO `sys_oper_log` VALUES (2393, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:18');
INSERT INTO `sys_oper_log` VALUES (2394, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:18');
INSERT INTO `sys_oper_log` VALUES (2395, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:18');
INSERT INTO `sys_oper_log` VALUES (2396, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:18');
INSERT INTO `sys_oper_log` VALUES (2397, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:53:23');
INSERT INTO `sys_oper_log` VALUES (2398, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:24');
INSERT INTO `sys_oper_log` VALUES (2399, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:25');
INSERT INTO `sys_oper_log` VALUES (2400, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:53:30');
INSERT INTO `sys_oper_log` VALUES (2401, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:31');
INSERT INTO `sys_oper_log` VALUES (2402, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:32');
INSERT INTO `sys_oper_log` VALUES (2403, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:32');
INSERT INTO `sys_oper_log` VALUES (2404, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:32');
INSERT INTO `sys_oper_log` VALUES (2405, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:32');
INSERT INTO `sys_oper_log` VALUES (2406, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:33');
INSERT INTO `sys_oper_log` VALUES (2407, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:33');
INSERT INTO `sys_oper_log` VALUES (2408, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:33');
INSERT INTO `sys_oper_log` VALUES (2409, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:33');
INSERT INTO `sys_oper_log` VALUES (2410, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:33');
INSERT INTO `sys_oper_log` VALUES (2411, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:33');
INSERT INTO `sys_oper_log` VALUES (2412, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:34');
INSERT INTO `sys_oper_log` VALUES (2413, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:34');
INSERT INTO `sys_oper_log` VALUES (2414, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:34');
INSERT INTO `sys_oper_log` VALUES (2415, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:34');
INSERT INTO `sys_oper_log` VALUES (2416, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:34');
INSERT INTO `sys_oper_log` VALUES (2417, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:35');
INSERT INTO `sys_oper_log` VALUES (2418, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:35');
INSERT INTO `sys_oper_log` VALUES (2419, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:35');
INSERT INTO `sys_oper_log` VALUES (2420, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:35');
INSERT INTO `sys_oper_log` VALUES (2421, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:35');
INSERT INTO `sys_oper_log` VALUES (2422, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:36');
INSERT INTO `sys_oper_log` VALUES (2423, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:36');
INSERT INTO `sys_oper_log` VALUES (2424, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:44');
INSERT INTO `sys_oper_log` VALUES (2425, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:45');
INSERT INTO `sys_oper_log` VALUES (2426, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:45');
INSERT INTO `sys_oper_log` VALUES (2427, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:45');
INSERT INTO `sys_oper_log` VALUES (2428, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:45');
INSERT INTO `sys_oper_log` VALUES (2429, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:46');
INSERT INTO `sys_oper_log` VALUES (2430, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:47');
INSERT INTO `sys_oper_log` VALUES (2431, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:53:48');
INSERT INTO `sys_oper_log` VALUES (2432, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:54:03');
INSERT INTO `sys_oper_log` VALUES (2433, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:54:09');
INSERT INTO `sys_oper_log` VALUES (2434, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:54:32');
INSERT INTO `sys_oper_log` VALUES (2435, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:34');
INSERT INTO `sys_oper_log` VALUES (2436, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:35');
INSERT INTO `sys_oper_log` VALUES (2437, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:36');
INSERT INTO `sys_oper_log` VALUES (2438, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:37');
INSERT INTO `sys_oper_log` VALUES (2439, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:37');
INSERT INTO `sys_oper_log` VALUES (2440, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:38');
INSERT INTO `sys_oper_log` VALUES (2441, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:39');
INSERT INTO `sys_oper_log` VALUES (2442, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:40');
INSERT INTO `sys_oper_log` VALUES (2443, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:41');
INSERT INTO `sys_oper_log` VALUES (2444, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:42');
INSERT INTO `sys_oper_log` VALUES (2445, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:43');
INSERT INTO `sys_oper_log` VALUES (2446, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:44');
INSERT INTO `sys_oper_log` VALUES (2447, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:45');
INSERT INTO `sys_oper_log` VALUES (2448, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:46');
INSERT INTO `sys_oper_log` VALUES (2449, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:47');
INSERT INTO `sys_oper_log` VALUES (2450, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:48');
INSERT INTO `sys_oper_log` VALUES (2451, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:48');
INSERT INTO `sys_oper_log` VALUES (2452, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:49');
INSERT INTO `sys_oper_log` VALUES (2453, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:50');
INSERT INTO `sys_oper_log` VALUES (2454, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:51');
INSERT INTO `sys_oper_log` VALUES (2455, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:54:52');
INSERT INTO `sys_oper_log` VALUES (2456, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:52');
INSERT INTO `sys_oper_log` VALUES (2457, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:53');
INSERT INTO `sys_oper_log` VALUES (2458, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:53');
INSERT INTO `sys_oper_log` VALUES (2459, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:54');
INSERT INTO `sys_oper_log` VALUES (2460, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:54');
INSERT INTO `sys_oper_log` VALUES (2461, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:54:55');
INSERT INTO `sys_oper_log` VALUES (2462, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:54:56');
INSERT INTO `sys_oper_log` VALUES (2463, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:54:59');
INSERT INTO `sys_oper_log` VALUES (2464, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/bindDevice', '180.111.206.122', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-31 14:58:05');
INSERT INTO `sys_oper_log` VALUES (2465, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/bindDevice', '180.111.206.122', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-31 14:58:11');
INSERT INTO `sys_oper_log` VALUES (2466, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:16');
INSERT INTO `sys_oper_log` VALUES (2467, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:17');
INSERT INTO `sys_oper_log` VALUES (2468, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:19');
INSERT INTO `sys_oper_log` VALUES (2469, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:20');
INSERT INTO `sys_oper_log` VALUES (2470, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:21');
INSERT INTO `sys_oper_log` VALUES (2471, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:21');
INSERT INTO `sys_oper_log` VALUES (2472, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:23');
INSERT INTO `sys_oper_log` VALUES (2473, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:23');
INSERT INTO `sys_oper_log` VALUES (2474, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:58:33');
INSERT INTO `sys_oper_log` VALUES (2475, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:35');
INSERT INTO `sys_oper_log` VALUES (2476, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:35');
INSERT INTO `sys_oper_log` VALUES (2477, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:58:49');
INSERT INTO `sys_oper_log` VALUES (2478, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:58:54');
INSERT INTO `sys_oper_log` VALUES (2479, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:58:58');
INSERT INTO `sys_oper_log` VALUES (2480, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:59:01');
INSERT INTO `sys_oper_log` VALUES (2481, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:05');
INSERT INTO `sys_oper_log` VALUES (2482, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:06');
INSERT INTO `sys_oper_log` VALUES (2483, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:07');
INSERT INTO `sys_oper_log` VALUES (2484, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:08');
INSERT INTO `sys_oper_log` VALUES (2485, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:59:14');
INSERT INTO `sys_oper_log` VALUES (2486, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:59:16');
INSERT INTO `sys_oper_log` VALUES (2487, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:18');
INSERT INTO `sys_oper_log` VALUES (2488, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:21');
INSERT INTO `sys_oper_log` VALUES (2489, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:22');
INSERT INTO `sys_oper_log` VALUES (2490, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:23');
INSERT INTO `sys_oper_log` VALUES (2491, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:24');
INSERT INTO `sys_oper_log` VALUES (2492, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:25');
INSERT INTO `sys_oper_log` VALUES (2493, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:59:36');
INSERT INTO `sys_oper_log` VALUES (2494, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:38');
INSERT INTO `sys_oper_log` VALUES (2495, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:39');
INSERT INTO `sys_oper_log` VALUES (2496, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:40');
INSERT INTO `sys_oper_log` VALUES (2497, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:41');
INSERT INTO `sys_oper_log` VALUES (2498, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:43');
INSERT INTO `sys_oper_log` VALUES (2499, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:44');
INSERT INTO `sys_oper_log` VALUES (2500, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:45');
INSERT INTO `sys_oper_log` VALUES (2501, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:45');
INSERT INTO `sys_oper_log` VALUES (2502, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:46');
INSERT INTO `sys_oper_log` VALUES (2503, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 14:59:46');
INSERT INTO `sys_oper_log` VALUES (2504, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 14:59:52');
INSERT INTO `sys_oper_log` VALUES (2505, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 15:54:30');
INSERT INTO `sys_oper_log` VALUES (2506, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:54:32');
INSERT INTO `sys_oper_log` VALUES (2507, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:54:33');
INSERT INTO `sys_oper_log` VALUES (2508, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:54:34');
INSERT INTO `sys_oper_log` VALUES (2509, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:54:35');
INSERT INTO `sys_oper_log` VALUES (2510, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:54:35');
INSERT INTO `sys_oper_log` VALUES (2511, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:54:36');
INSERT INTO `sys_oper_log` VALUES (2512, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 15:58:06');
INSERT INTO `sys_oper_log` VALUES (2513, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:08');
INSERT INTO `sys_oper_log` VALUES (2514, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:09');
INSERT INTO `sys_oper_log` VALUES (2515, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:10');
INSERT INTO `sys_oper_log` VALUES (2516, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:12');
INSERT INTO `sys_oper_log` VALUES (2517, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:13');
INSERT INTO `sys_oper_log` VALUES (2518, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:13');
INSERT INTO `sys_oper_log` VALUES (2519, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:14');
INSERT INTO `sys_oper_log` VALUES (2520, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:15');
INSERT INTO `sys_oper_log` VALUES (2521, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:15');
INSERT INTO `sys_oper_log` VALUES (2522, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:58:17');
INSERT INTO `sys_oper_log` VALUES (2523, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 15:59:07');
INSERT INTO `sys_oper_log` VALUES (2524, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 15:59:25');
INSERT INTO `sys_oper_log` VALUES (2525, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:59:32');
INSERT INTO `sys_oper_log` VALUES (2526, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 15:59:33');
INSERT INTO `sys_oper_log` VALUES (2527, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 15:59:46');
INSERT INTO `sys_oper_log` VALUES (2528, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 15:59:51');
INSERT INTO `sys_oper_log` VALUES (2529, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:00:05');
INSERT INTO `sys_oper_log` VALUES (2530, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:00:08');
INSERT INTO `sys_oper_log` VALUES (2531, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:00:13');
INSERT INTO `sys_oper_log` VALUES (2532, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 16:00:14');
INSERT INTO `sys_oper_log` VALUES (2533, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 16:00:15');
INSERT INTO `sys_oper_log` VALUES (2534, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:01:01');
INSERT INTO `sys_oper_log` VALUES (2535, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 16:01:07');
INSERT INTO `sys_oper_log` VALUES (2536, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:01:14');
INSERT INTO `sys_oper_log` VALUES (2537, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 16:01:30');
INSERT INTO `sys_oper_log` VALUES (2538, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:01:33');
INSERT INTO `sys_oper_log` VALUES (2539, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:02:15');
INSERT INTO `sys_oper_log` VALUES (2540, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 16:02:19');
INSERT INTO `sys_oper_log` VALUES (2541, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:02:43');
INSERT INTO `sys_oper_log` VALUES (2542, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 16:02:46');
INSERT INTO `sys_oper_log` VALUES (2543, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:02:48');
INSERT INTO `sys_oper_log` VALUES (2544, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 16:02:53');
INSERT INTO `sys_oper_log` VALUES (2545, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:29:05');
INSERT INTO `sys_oper_log` VALUES (2546, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:29:05');
INSERT INTO `sys_oper_log` VALUES (2547, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:29:05');
INSERT INTO `sys_oper_log` VALUES (2548, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '117.136.45.101', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-31 19:29:05');
INSERT INTO `sys_oper_log` VALUES (2549, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:30:16');
INSERT INTO `sys_oper_log` VALUES (2550, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:30:30');
INSERT INTO `sys_oper_log` VALUES (2551, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:31:21');
INSERT INTO `sys_oper_log` VALUES (2552, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:31:56');
INSERT INTO `sys_oper_log` VALUES (2553, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:32:02');
INSERT INTO `sys_oper_log` VALUES (2554, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:32:03');
INSERT INTO `sys_oper_log` VALUES (2555, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:32:08');
INSERT INTO `sys_oper_log` VALUES (2556, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:32:20');
INSERT INTO `sys_oper_log` VALUES (2557, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:32:39');
INSERT INTO `sys_oper_log` VALUES (2558, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:32:47');
INSERT INTO `sys_oper_log` VALUES (2559, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '117.136.45.101', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-31 19:32:52');
INSERT INTO `sys_oper_log` VALUES (2560, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:32:52');
INSERT INTO `sys_oper_log` VALUES (2561, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:32:57');
INSERT INTO `sys_oper_log` VALUES (2562, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:33:01');
INSERT INTO `sys_oper_log` VALUES (2563, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/bindDevice', '117.136.45.101', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":1}', 'null', 1, '该设备已被绑定！', '2021-08-31 19:33:05');
INSERT INTO `sys_oper_log` VALUES (2564, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:33:05');
INSERT INTO `sys_oper_log` VALUES (2565, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:33:11');
INSERT INTO `sys_oper_log` VALUES (2566, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:33:18');
INSERT INTO `sys_oper_log` VALUES (2567, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:33:20');
INSERT INTO `sys_oper_log` VALUES (2568, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:33:22');
INSERT INTO `sys_oper_log` VALUES (2569, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:38:01');
INSERT INTO `sys_oper_log` VALUES (2570, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:38:07');
INSERT INTO `sys_oper_log` VALUES (2571, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:40:39');
INSERT INTO `sys_oper_log` VALUES (2572, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:40:42');
INSERT INTO `sys_oper_log` VALUES (2573, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:41:12');
INSERT INTO `sys_oper_log` VALUES (2574, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:41:20');
INSERT INTO `sys_oper_log` VALUES (2575, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:41:21');
INSERT INTO `sys_oper_log` VALUES (2576, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:41:23');
INSERT INTO `sys_oper_log` VALUES (2577, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:41:27');
INSERT INTO `sys_oper_log` VALUES (2578, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:41:31');
INSERT INTO `sys_oper_log` VALUES (2579, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:41:35');
INSERT INTO `sys_oper_log` VALUES (2580, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:41:37');
INSERT INTO `sys_oper_log` VALUES (2581, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:41:41');
INSERT INTO `sys_oper_log` VALUES (2582, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:41:54');
INSERT INTO `sys_oper_log` VALUES (2583, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:41:55');
INSERT INTO `sys_oper_log` VALUES (2584, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:41:57');
INSERT INTO `sys_oper_log` VALUES (2585, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:43:27');
INSERT INTO `sys_oper_log` VALUES (2586, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:43:30');
INSERT INTO `sys_oper_log` VALUES (2587, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:43:35');
INSERT INTO `sys_oper_log` VALUES (2588, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:43:38');
INSERT INTO `sys_oper_log` VALUES (2589, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:43:42');
INSERT INTO `sys_oper_log` VALUES (2590, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:43:43');
INSERT INTO `sys_oper_log` VALUES (2591, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:43:45');
INSERT INTO `sys_oper_log` VALUES (2592, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:43:47');
INSERT INTO `sys_oper_log` VALUES (2593, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:52:01');
INSERT INTO `sys_oper_log` VALUES (2594, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:52:06');
INSERT INTO `sys_oper_log` VALUES (2595, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:53:21');
INSERT INTO `sys_oper_log` VALUES (2596, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:53:25');
INSERT INTO `sys_oper_log` VALUES (2597, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:53:41');
INSERT INTO `sys_oper_log` VALUES (2598, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:59:40');
INSERT INTO `sys_oper_log` VALUES (2599, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:59:42');
INSERT INTO `sys_oper_log` VALUES (2600, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:59:45');
INSERT INTO `sys_oper_log` VALUES (2601, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 19:59:46');
INSERT INTO `sys_oper_log` VALUES (2602, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 19:59:50');
INSERT INTO `sys_oper_log` VALUES (2603, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 20:02:10');
INSERT INTO `sys_oper_log` VALUES (2604, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:02:30');
INSERT INTO `sys_oper_log` VALUES (2605, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 20:02:33');
INSERT INTO `sys_oper_log` VALUES (2606, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"lightStatus\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"wifi通断器\",\"categoryId\":1}}', 0, NULL, '2021-08-31 20:02:36');
INSERT INTO `sys_oper_log` VALUES (2607, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:02:37');
INSERT INTO `sys_oper_log` VALUES (2608, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:02:40');
INSERT INTO `sys_oper_log` VALUES (2609, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:02:43');
INSERT INTO `sys_oper_log` VALUES (2610, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:02:45');
INSERT INTO `sys_oper_log` VALUES (2611, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:02:46');
INSERT INTO `sys_oper_log` VALUES (2612, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:02:55');
INSERT INTO `sys_oper_log` VALUES (2613, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:02:55');
INSERT INTO `sys_oper_log` VALUES (2614, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:02:55');
INSERT INTO `sys_oper_log` VALUES (2615, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:11:29');
INSERT INTO `sys_oper_log` VALUES (2616, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:14:10');
INSERT INTO `sys_oper_log` VALUES (2617, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:14:11');
INSERT INTO `sys_oper_log` VALUES (2618, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:14:12');
INSERT INTO `sys_oper_log` VALUES (2619, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:14:18');
INSERT INTO `sys_oper_log` VALUES (2620, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:18:14');
INSERT INTO `sys_oper_log` VALUES (2621, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:19:27');
INSERT INTO `sys_oper_log` VALUES (2622, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:19:28');
INSERT INTO `sys_oper_log` VALUES (2623, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '180.111.206.122', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:19:30');
INSERT INTO `sys_oper_log` VALUES (2624, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '180.111.206.122', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:19:32');
INSERT INTO `sys_oper_log` VALUES (2625, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:20:00');
INSERT INTO `sys_oper_log` VALUES (2626, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:20:01');
INSERT INTO `sys_oper_log` VALUES (2627, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:20:02');
INSERT INTO `sys_oper_log` VALUES (2628, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:20:12');
INSERT INTO `sys_oper_log` VALUES (2629, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:20:16');
INSERT INTO `sys_oper_log` VALUES (2630, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:23:25');
INSERT INTO `sys_oper_log` VALUES (2631, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:23:28');
INSERT INTO `sys_oper_log` VALUES (2632, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:23:32');
INSERT INTO `sys_oper_log` VALUES (2633, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":true,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:23:35');
INSERT INTO `sys_oper_log` VALUES (2634, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, 'EB5312FB4A26', NULL, '/system/device/control', '117.136.45.101', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:23:38');
INSERT INTO `sys_oper_log` VALUES (2635, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:23:43');
INSERT INTO `sys_oper_log` VALUES (2636, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:23:48');
INSERT INTO `sys_oper_log` VALUES (2637, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:23:55');
INSERT INTO `sys_oper_log` VALUES (2638, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:23:55');
INSERT INTO `sys_oper_log` VALUES (2639, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.unBindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/unBindDevice', '117.136.45.72', 'XX XX', '{\"params\":{},\"deviceId\":4}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-31 20:23:58');
INSERT INTO `sys_oper_log` VALUES (2640, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, 'EB5312FB4A26', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.101', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"deviceNum\":\"863488052352472\",\"relayStatus\":false,\"remark\":\"灯等等灯\",\"isOnline\":true,\"deviceName\":\"阿拉丁神灯\",\"deviceId\":4,\"categoryName\":\"智能水阀\",\"categoryId\":4}}', 0, NULL, '2021-08-31 20:24:04');
INSERT INTO `sys_oper_log` VALUES (2641, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/bindDevice', '117.136.45.72', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":4}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":1}', 0, NULL, '2021-08-31 20:24:31');
INSERT INTO `sys_oper_log` VALUES (2642, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:24:31');
INSERT INTO `sys_oper_log` VALUES (2643, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:24:35');
INSERT INTO `sys_oper_log` VALUES (2644, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:24:38');
INSERT INTO `sys_oper_log` VALUES (2645, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:24:40');
INSERT INTO `sys_oper_log` VALUES (2646, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:24:41');
INSERT INTO `sys_oper_log` VALUES (2647, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:24:46');
INSERT INTO `sys_oper_log` VALUES (2648, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:24:49');
INSERT INTO `sys_oper_log` VALUES (2649, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:24:50');
INSERT INTO `sys_oper_log` VALUES (2650, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:24:55');
INSERT INTO `sys_oper_log` VALUES (2651, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.bindDevice()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/bindDevice', '117.136.45.72', 'XX XX', '{\"remark\":\"灯等等灯\",\"params\":{},\"deviceName\":\"阿拉丁神灯\",\"deviceNum\":\"863488052352472\",\"categoryId\":4}', 'null', 1, '该设备已被绑定！', '2021-08-31 20:25:05');
INSERT INTO `sys_oper_log` VALUES (2652, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.getDeviceInfoByDeviceId()', 'GET', 1, '6F1B3F33DD38', NULL, '/system/device/getDeviceInfoByDeviceId', '117.136.45.72', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:05');
INSERT INTO `sys_oper_log` VALUES (2653, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:07');
INSERT INTO `sys_oper_log` VALUES (2654, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:08');
INSERT INTO `sys_oper_log` VALUES (2655, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:09');
INSERT INTO `sys_oper_log` VALUES (2656, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:10');
INSERT INTO `sys_oper_log` VALUES (2657, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:11');
INSERT INTO `sys_oper_log` VALUES (2658, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:12');
INSERT INTO `sys_oper_log` VALUES (2659, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:12');
INSERT INTO `sys_oper_log` VALUES (2660, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:13');
INSERT INTO `sys_oper_log` VALUES (2661, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"on\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:14');
INSERT INTO `sys_oper_log` VALUES (2662, '设备', 2, 'com.ruoyi.system.controller.IotDeviceController.control()', 'POST', 1, '6F1B3F33DD38', NULL, '/system/device/control', '117.136.45.72', 'XX XX', '{\"deviceNum\":\"863488052352472\",\"cmd\":\"off\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2021-08-31 20:25:14');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(0) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2021-05-18 02:23:06', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2021-05-18 02:23:06', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(0) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2021-05-18 02:23:06', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (100, '游客角色', 'visitor', 8, '1', 1, 1, '0', '0', 'admin', '2021-05-29 08:42:32', 'admin', '2021-08-26 17:27:05', NULL);
INSERT INTO `sys_role` VALUES (101, '小程序用户', 'mp', 3, '1', 1, 1, '0', '0', 'admin', '2021-08-26 17:26:52', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(0) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(0) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (100, 1);
INSERT INTO `sys_role_menu` VALUES (100, 2);
INSERT INTO `sys_role_menu` VALUES (100, 3);
INSERT INTO `sys_role_menu` VALUES (100, 4);
INSERT INTO `sys_role_menu` VALUES (100, 100);
INSERT INTO `sys_role_menu` VALUES (100, 101);
INSERT INTO `sys_role_menu` VALUES (100, 102);
INSERT INTO `sys_role_menu` VALUES (100, 103);
INSERT INTO `sys_role_menu` VALUES (100, 104);
INSERT INTO `sys_role_menu` VALUES (100, 105);
INSERT INTO `sys_role_menu` VALUES (100, 106);
INSERT INTO `sys_role_menu` VALUES (100, 107);
INSERT INTO `sys_role_menu` VALUES (100, 108);
INSERT INTO `sys_role_menu` VALUES (100, 109);
INSERT INTO `sys_role_menu` VALUES (100, 110);
INSERT INTO `sys_role_menu` VALUES (100, 115);
INSERT INTO `sys_role_menu` VALUES (100, 116);
INSERT INTO `sys_role_menu` VALUES (100, 500);
INSERT INTO `sys_role_menu` VALUES (100, 501);
INSERT INTO `sys_role_menu` VALUES (100, 1001);
INSERT INTO `sys_role_menu` VALUES (100, 1008);
INSERT INTO `sys_role_menu` VALUES (100, 1013);
INSERT INTO `sys_role_menu` VALUES (100, 1017);
INSERT INTO `sys_role_menu` VALUES (100, 1021);
INSERT INTO `sys_role_menu` VALUES (100, 1026);
INSERT INTO `sys_role_menu` VALUES (100, 1031);
INSERT INTO `sys_role_menu` VALUES (100, 1036);
INSERT INTO `sys_role_menu` VALUES (100, 1040);
INSERT INTO `sys_role_menu` VALUES (100, 1043);
INSERT INTO `sys_role_menu` VALUES (100, 1046);
INSERT INTO `sys_role_menu` VALUES (100, 1049);
INSERT INTO `sys_role_menu` VALUES (100, 1055);
INSERT INTO `sys_role_menu` VALUES (100, 2000);
INSERT INTO `sys_role_menu` VALUES (100, 2043);
INSERT INTO `sys_role_menu` VALUES (100, 2044);
INSERT INTO `sys_role_menu` VALUES (100, 2049);
INSERT INTO `sys_role_menu` VALUES (100, 2050);
INSERT INTO `sys_role_menu` VALUES (100, 2055);
INSERT INTO `sys_role_menu` VALUES (100, 2056);
INSERT INTO `sys_role_menu` VALUES (100, 2061);
INSERT INTO `sys_role_menu` VALUES (100, 2062);
INSERT INTO `sys_role_menu` VALUES (100, 2067);
INSERT INTO `sys_role_menu` VALUES (100, 2068);
INSERT INTO `sys_role_menu` VALUES (100, 2073);
INSERT INTO `sys_role_menu` VALUES (101, 2000);
INSERT INTO `sys_role_menu` VALUES (101, 2043);
INSERT INTO `sys_role_menu` VALUES (101, 2044);
INSERT INTO `sys_role_menu` VALUES (101, 2045);
INSERT INTO `sys_role_menu` VALUES (101, 2046);
INSERT INTO `sys_role_menu` VALUES (101, 2047);
INSERT INTO `sys_role_menu` VALUES (101, 2048);
INSERT INTO `sys_role_menu` VALUES (101, 2049);
INSERT INTO `sys_role_menu` VALUES (101, 2050);
INSERT INTO `sys_role_menu` VALUES (101, 2051);
INSERT INTO `sys_role_menu` VALUES (101, 2052);
INSERT INTO `sys_role_menu` VALUES (101, 2053);
INSERT INTO `sys_role_menu` VALUES (101, 2054);
INSERT INTO `sys_role_menu` VALUES (101, 2055);
INSERT INTO `sys_role_menu` VALUES (101, 2056);
INSERT INTO `sys_role_menu` VALUES (101, 2057);
INSERT INTO `sys_role_menu` VALUES (101, 2058);
INSERT INTO `sys_role_menu` VALUES (101, 2059);
INSERT INTO `sys_role_menu` VALUES (101, 2060);
INSERT INTO `sys_role_menu` VALUES (101, 2061);
INSERT INTO `sys_role_menu` VALUES (101, 2062);
INSERT INTO `sys_role_menu` VALUES (101, 2063);
INSERT INTO `sys_role_menu` VALUES (101, 2064);
INSERT INTO `sys_role_menu` VALUES (101, 2065);
INSERT INTO `sys_role_menu` VALUES (101, 2066);
INSERT INTO `sys_role_menu` VALUES (101, 2067);
INSERT INTO `sys_role_menu` VALUES (101, 2068);
INSERT INTO `sys_role_menu` VALUES (101, 2069);
INSERT INTO `sys_role_menu` VALUES (101, 2070);
INSERT INTO `sys_role_menu` VALUES (101, 2071);
INSERT INTO `sys_role_menu` VALUES (101, 2072);
INSERT INTO `sys_role_menu` VALUES (101, 2073);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(0) NULL DEFAULT NULL COMMENT '部门ID',
  `open_id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户OpenId',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `open_id`(`open_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, NULL, 'admin', '物美智能', '00', '164770707@qq.com', '15888888888', '1', '', '$2a$10$PXtk.97BgFUAK/7lpmxZ4eNPS6zL0VVHR7g.sjrdG5XUiX7pfGaRa', '0', '0', '127.0.0.1', '2021-05-18 02:23:06', 'admin', '2021-05-18 02:23:06', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, NULL, 'wumei', '物美智能', '00', 'admin@wumei.com', '15666666666', '1', '', '$2a$10$uLlHqgW4b5oAqoS81Rhkk.7Tf6wnGvh9FE9V160Dv2Kn9doOrB4qe', '0', '0', '127.0.0.1', '2021-05-18 02:23:06', 'admin', '2021-05-18 02:23:06', 'admin', '2021-06-19 09:31:14', '测试员');
INSERT INTO `sys_user` VALUES (100, NULL, NULL, 'public', '访客', '00', '', '', '0', '', '$2a$10$E8d4gZ3.QQzDE7LBfY7XpuuGX.LvWFcA982AAdAzk24u91bQ1nete', '0', '0', '', NULL, 'admin', '2021-05-29 08:37:36', 'admin', '2021-06-19 09:31:20', NULL);
INSERT INTO `sys_user` VALUES (101, NULL, NULL, 'aaa', 'xxx', '00', '', '', '0', '', '$2a$10$f.KtWGpaUsdvl2E427/H4OnPi2dYx8HetxnBs1uasSNwCBBUDSwjO', '0', '0', '', NULL, 'admin', '2021-08-26 17:28:34', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (114, NULL, 'oRHbg4lwGVJYu7GjfVwRv6pYygzQ', 'EB5312FB4A26', '微信注册用户', '00', '', '', '0', '', '$2a$10$iWySi4cYQ.0DFSMFCzofbu1H13Dd03WW7h/0OZPzQcBd.7f1fWjV.', '0', '0', '', NULL, '微信小程序', '2021-08-26 18:06:16', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (115, NULL, 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', 'A1BB9722086A', '微信注册用户', '00', '', '', '0', '', '$2a$10$rAoFt5nuPw/2CXhRsa/uoOjExW0XH3xM009kcWWo12rzFiSgIK.n2', '0', '0', '', NULL, '微信小程序', '2021-08-26 18:41:21', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (116, NULL, 'oRHbg4kHhyFV8DPX-wpGREyjfQsM', '6F1B3F33DD38', '微信注册用户', '00', '', '', '0', '', '$2a$10$SUR7vd7YIiMkFBFSTKba7uTc5FdpAdwyMuzUsUpMjkgTC0NfiRpqK', '0', '0', '', NULL, '微信小程序', '2021-08-31 14:47:58', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `post_id` bigint(0) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 100);
INSERT INTO `sys_user_role` VALUES (100, 100);
INSERT INTO `sys_user_role` VALUES (101, 101);

-- ----------------------------
-- Table structure for t_user_account_info
-- ----------------------------
DROP TABLE IF EXISTS `t_user_account_info`;
CREATE TABLE `t_user_account_info`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `sessionKey` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT 'sessionKey',
  `access_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT 'accessToken',
  `open_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `union_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '生日',
  `status` int(0) NOT NULL DEFAULT 1 COMMENT '用户状态：0-冻结，1-正常',
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '国家',
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '城市',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `user_type` int(0) NOT NULL DEFAULT 0 COMMENT '用户类型：0-未授权用户，1-消费者，2-商家',
  `admin_id` int(0) NULL DEFAULT NULL COMMENT '绑定的管理员编号',
  `last_login_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `last_login_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `gmt_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `open_id`(`open_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200030 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '小程序用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_account_info
-- ----------------------------
INSERT INTO `t_user_account_info` VALUES (200029, 'wd4/hPuBQ+ummo/NOv1Rsw==', 'ced50c3733424484becfa6a68e4066fc', 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', NULL, '新注册用户', 'https://c-ssl.duitang.com/uploads/item/201912/27/20191227145714_rtHRc.thumb.1000_0.jpeg', NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, NULL, '2021-08-26 17:02:10', '127.0.0.1', '2021-08-26 16:30:57', '2021-08-26 17:02:08');

-- ----------------------------
-- Table structure for t_user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `t_user_login_log`;
CREATE TABLE `t_user_login_log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户类型',
  `user_id` int(0) NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `open_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `gmt_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `gmt_update` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1725 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_login_log
-- ----------------------------
INSERT INTO `t_user_login_log` VALUES (1718, '未授权用户', 200029, '023mpv0w3w8VXW22mg2w34Vlyj3mpv01', 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '127.0.0.1', '2021-08-26 16:30:57', NULL);
INSERT INTO `t_user_login_log` VALUES (1719, '未授权用户', 200029, '083hBWkl269zD74Ioxol2Rqaaq0hBWkA', 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '127.0.0.1', '2021-08-26 16:56:12', NULL);
INSERT INTO `t_user_login_log` VALUES (1720, '未授权用户', 200029, '073d93000npdjM15qS100TtVyj3d930s', 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '127.0.0.1', '2021-08-26 16:59:18', NULL);
INSERT INTO `t_user_login_log` VALUES (1721, '未授权用户', 200029, '053NjS000cfoiM1siM300P1HhV1NjS0W', 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '127.0.0.1', '2021-08-26 16:59:42', NULL);
INSERT INTO `t_user_login_log` VALUES (1722, '未授权用户', 200029, '043nlS000U9niM1a6I0007YZCb3nlS0u', 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '127.0.0.1', '2021-08-26 17:00:07', NULL);
INSERT INTO `t_user_login_log` VALUES (1723, '未授权用户', 200029, '0039Zull2tOZC74R3Pnl2Hpg8l49Zul1', 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '127.0.0.1', '2021-08-26 17:00:51', NULL);
INSERT INTO `t_user_login_log` VALUES (1724, '未授权用户', 200029, '013pCmFa1E5TDB0fpIIa138qab2pCmFl', 'oRHbg4mTdANmQwDhuQAD8vBbkNG0', '127.0.0.1', '2021-08-26 17:02:08', NULL);

SET FOREIGN_KEY_CHECKS = 1;
