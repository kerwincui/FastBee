/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50734
Source Host           : localhost:3306
Source Database       : wumei-smart

Target Server Type    : MYSQL
Target Server Version : 50734
File Encoding         : 65001

Date: 2021-06-30 17:24:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES ('12', 'iot_category', '设备分类', '', '', 'IotCategory', 'crud', 'com.ruoyi.system', 'system', 'category', '设备分类', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58', null);
INSERT INTO `gen_table` VALUES ('13', 'iot_device', '设备', '', '', 'IotDevice', 'crud', 'com.ruoyi.system', 'system', 'device', '设备', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-05-06 13:31:30', '', '2021-05-06 14:34:08', null);
INSERT INTO `gen_table` VALUES ('14', 'iot_device_set', '设备配置', null, null, 'IotDeviceSet', 'crud', 'com.ruoyi.system', 'system', 'set', '设备配置', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45', null);
INSERT INTO `gen_table` VALUES ('15', 'iot_device_status', '设备状态', null, null, 'IotDeviceStatus', 'crud', 'com.ruoyi.system', 'system', 'status', '设备状态', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:15:04', null);
INSERT INTO `gen_table` VALUES ('17', 'iot_group', '设备分组', null, null, 'IotGroup', 'crud', 'com.ruoyi.system', 'system', 'group', '分组', 'kerwincui', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2021-05-18 08:04:15', '', '2021-05-18 08:13:40', null);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES ('217', '12', 'category_id', '序号', 'bigint(20)', 'Long', 'categoryId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES ('218', '12', 'category_name', '分类名称', 'varchar(100)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES ('219', '12', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '3', 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES ('220', '12', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '4', 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES ('221', '12', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, null, 'EQ', 'datetime', '', '5', 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES ('222', '12', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', null, '1', '1', null, null, 'EQ', 'input', '', '6', 'admin', '2021-05-06 13:31:29', '', '2021-05-07 08:22:58');
INSERT INTO `gen_table_column` VALUES ('223', '12', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', null, '1', '1', null, null, 'EQ', 'datetime', '', '7', 'admin', '2021-05-06 13:31:30', '', '2021-05-07 08:22:59');
INSERT INTO `gen_table_column` VALUES ('224', '12', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', null, '1', '1', '1', null, 'EQ', 'textarea', '', '8', 'admin', '2021-05-06 13:31:30', '', '2021-05-07 08:22:59');
INSERT INTO `gen_table_column` VALUES ('225', '13', 'device_id', '序号', 'bigint(20)', 'Long', 'deviceId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-05-06 13:31:30', '', '2021-05-06 14:34:08');
INSERT INTO `gen_table_column` VALUES ('226', '13', 'device_num', '编号', 'varchar(64)', 'String', 'deviceNum', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '2', 'admin', '2021-05-06 13:31:30', '', '2021-05-06 14:34:08');
INSERT INTO `gen_table_column` VALUES ('227', '13', 'category_id', '分类', 'bigint(20)', 'Long', 'categoryId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'select', '', '3', 'admin', '2021-05-06 13:31:30', '', '2021-05-06 14:34:08');
INSERT INTO `gen_table_column` VALUES ('228', '13', 'device_name', '名称', 'varchar(64)', 'String', 'deviceName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '4', 'admin', '2021-05-06 13:31:30', '', '2021-05-06 14:34:08');
INSERT INTO `gen_table_column` VALUES ('229', '13', 'firmware_version', '固件版本', 'varchar(32)', 'String', 'firmwareVersion', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '5', 'admin', '2021-05-06 13:31:31', '', '2021-05-06 14:34:09');
INSERT INTO `gen_table_column` VALUES ('230', '13', 'owner_id', '用户', 'varchar(64)', 'String', 'ownerId', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '6', 'admin', '2021-05-06 13:31:31', '', '2021-05-06 14:34:09');
INSERT INTO `gen_table_column` VALUES ('231', '13', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '7', 'admin', '2021-05-06 13:31:31', '', '2021-05-06 14:34:09');
INSERT INTO `gen_table_column` VALUES ('232', '13', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '8', 'admin', '2021-05-06 13:31:31', '', '2021-05-06 14:34:09');
INSERT INTO `gen_table_column` VALUES ('233', '13', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, '1', 'BETWEEN', 'datetime', '', '9', 'admin', '2021-05-06 13:31:31', '', '2021-05-06 14:34:09');
INSERT INTO `gen_table_column` VALUES ('234', '13', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', null, '1', '1', null, null, 'EQ', 'input', '', '10', 'admin', '2021-05-06 13:31:31', '', '2021-05-06 14:34:09');
INSERT INTO `gen_table_column` VALUES ('235', '13', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', null, '1', '1', null, null, 'EQ', 'datetime', '', '11', 'admin', '2021-05-06 13:31:31', '', '2021-05-06 14:34:09');
INSERT INTO `gen_table_column` VALUES ('236', '13', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', null, '1', '1', '1', null, 'EQ', 'textarea', '', '12', 'admin', '2021-05-06 13:31:32', '', '2021-05-06 14:34:09');
INSERT INTO `gen_table_column` VALUES ('237', '14', 'device_config_id', '序号', 'bigint(20)', 'Long', 'deviceConfigId', '1', '0', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES ('238', '14', 'device_id', '设备', 'bigint(20)', 'Long', 'deviceId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES ('239', '14', 'device_num', '设备编号', 'varchar(64)', 'String', 'deviceNum', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '3', 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES ('240', '14', 'is_alarm', '报警', 'tinyint(1)', 'Integer', 'isAlarm', '0', '0', null, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', '4', 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES ('241', '14', 'is_radar', '雷达感应', 'tinyint(1)', 'Integer', 'isRadar', '0', '0', null, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', '5', 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:45');
INSERT INTO `gen_table_column` VALUES ('242', '14', 'is_host', '托管', 'tinyint(1)', 'Integer', 'isHost', '0', '0', null, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', '6', 'admin', '2021-05-06 13:31:32', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES ('243', '14', 'is_reset', '重启', 'tinyint(1)', 'Integer', 'isReset', '0', '0', null, '1', '1', '1', null, 'EQ', 'radio', 'sys_yes_no', '7', 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES ('244', '14', 'is_ap', '打开AP', 'tinyint(1)', 'Integer', 'isAp', '0', '0', null, '1', '1', '1', null, 'EQ', 'radio', 'sys_yes_no', '8', 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES ('245', '14', 'is_rf_control', '射频遥控', 'tinyint(1)', 'Integer', 'isRfControl', '0', '0', null, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', '9', 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES ('246', '14', 'is_rf_learn', '遥控配对', 'tinyint(1)', 'Integer', 'isRfLearn', '0', '0', null, '1', '1', '1', null, 'EQ', 'radio', 'sys_yes_no', '10', 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES ('247', '14', 'is_rf_clear', '遥控清码', 'tinyint(1)', 'Integer', 'isRfClear', '0', '0', null, '1', '1', '1', null, 'EQ', 'radio', 'sys_yes_no', '11', 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES ('248', '14', 'rf_one_func', '按键一', 'tinyint(10)', 'Integer', 'rfOneFunc', '0', '0', null, '1', '1', '1', null, 'EQ', 'select', 'rf_function', '12', 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:46');
INSERT INTO `gen_table_column` VALUES ('249', '14', 'rf_two_func', '按键二', 'tinyint(10)', 'Integer', 'rfTwoFunc', '0', '0', null, '1', '1', '1', null, 'EQ', 'select', 'rf_function', '13', 'admin', '2021-05-06 13:31:33', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES ('250', '14', 'rf_three_func', '按键三', 'tinyint(10)', 'Integer', 'rfThreeFunc', '0', '0', null, '1', '1', '1', null, 'EQ', 'select', 'rf_function', '14', 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES ('251', '14', 'rf_four_func', '按键四', 'tinyint(10)', 'Integer', 'rfFourFunc', '0', '0', null, '1', '1', '1', null, 'EQ', 'select', 'rf_function', '15', 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES ('252', '14', 'owner_id', '用户', 'varchar(64)', 'String', 'ownerId', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '16', 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES ('253', '14', 'network_address', '配网地址', 'varchar(255)', 'String', 'networkAddress', '0', '0', null, '1', '1', '1', '1', 'LIKE', 'input', '', '17', 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES ('254', '14', 'network_ip', '配网IP', 'varchar(32)', 'String', 'networkIp', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '18', 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES ('255', '14', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '19', 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES ('256', '14', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '20', 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES ('257', '14', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, '1', 'BETWEEN', 'datetime', '', '21', 'admin', '2021-05-06 13:31:34', '', '2021-05-06 15:14:47');
INSERT INTO `gen_table_column` VALUES ('258', '14', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', null, '1', '1', null, null, 'EQ', 'input', '', '22', 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:14:48');
INSERT INTO `gen_table_column` VALUES ('259', '14', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '1', '1', '1', null, null, 'EQ', 'datetime', '', '23', 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:14:48');
INSERT INTO `gen_table_column` VALUES ('260', '14', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', null, '1', '1', '1', null, 'EQ', 'textarea', '', '24', 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:14:48');
INSERT INTO `gen_table_column` VALUES ('261', '15', 'device_status_id', '序号', 'bigint(20)', 'Long', 'deviceStatusId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:15:04');
INSERT INTO `gen_table_column` VALUES ('262', '15', 'device_id', '设备', 'bigint(20)', 'Long', 'deviceId', '0', '0', null, '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:15:04');
INSERT INTO `gen_table_column` VALUES ('263', '15', 'device_num', '设备编号', 'varchar(64)', 'String', 'deviceNum', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '3', 'admin', '2021-05-06 13:31:35', '', '2021-05-06 15:15:04');
INSERT INTO `gen_table_column` VALUES ('264', '15', 'relay_status', '继电器', 'tinyint(1)', 'Integer', 'relayStatus', '0', '0', null, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', '4', 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES ('265', '15', 'light_status', '灯状态', 'tinyint(1)', 'Integer', 'lightStatus', '0', '0', null, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', '5', 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES ('266', '15', 'is_online', '在线', 'tinyint(1)', 'Integer', 'isOnline', '0', '0', null, '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', '6', 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES ('267', '15', 'device_temperature', '设备温度', 'float(6,2)', 'BigDecimal', 'deviceTemperature', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '7', 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES ('268', '15', 'device_humidity', '设备湿度', 'float(6,2)', 'BigDecimal', 'deviceHumidity', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '8', 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES ('269', '15', 'air_temperature', '空气温度', 'float(6,2)', 'BigDecimal', 'airTemperature', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '9', 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES ('270', '15', 'air_humidity', '空气湿度', 'float(6,2)', 'BigDecimal', 'airHumidity', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '10', 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES ('271', '15', 'trigger_source', '触发源', 'tinyint(10)', 'Integer', 'triggerSource', '0', '0', null, '1', '1', '1', '1', 'EQ', 'select', 'iot_trigger_source', '11', 'admin', '2021-05-06 13:31:36', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES ('272', '15', 'brightness', '彩灯亮度', 'tinyint(10) unsigned', 'Integer', 'brightness', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '12', 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:05');
INSERT INTO `gen_table_column` VALUES ('273', '15', 'light_interval', '渐变间隔', 'smallint(10)', 'Integer', 'lightInterval', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '13', 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES ('274', '15', 'light_mode', '彩灯模式', 'tinyint(10)', 'Integer', 'lightMode', '0', '0', null, '1', '1', '1', null, 'EQ', 'select', 'light_mode', '14', 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES ('275', '15', 'red', '红灯', 'tinyint(255) unsigned', 'Long', 'red', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '15', 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES ('276', '15', 'green', '绿灯', 'tinyint(255) unsigned', 'Long', 'green', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '16', 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES ('277', '15', 'blue', '蓝灯', 'tinyint(255) unsigned', 'Long', 'blue', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '17', 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES ('278', '15', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '18', 'admin', '2021-05-06 13:31:37', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES ('279', '15', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '19', 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES ('280', '15', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, null, '1', 'BETWEEN', 'datetime', '', '20', 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:06');
INSERT INTO `gen_table_column` VALUES ('281', '15', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', null, '1', '1', null, null, 'EQ', 'input', '', '21', 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:07');
INSERT INTO `gen_table_column` VALUES ('282', '15', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '1', '1', '1', null, null, 'EQ', 'datetime', '', '22', 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:07');
INSERT INTO `gen_table_column` VALUES ('283', '15', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', null, '1', '1', '1', null, 'EQ', 'textarea', '', '23', 'admin', '2021-05-06 13:31:38', '', '2021-05-06 15:15:07');
INSERT INTO `gen_table_column` VALUES ('294', '17', 'group_id', '设备分组', 'bigint(20)', 'Long', 'groupId', '1', '1', null, '1', null, null, null, 'EQ', 'input', '', '1', 'admin', '2021-05-18 08:04:15', '', '2021-05-18 08:13:40');
INSERT INTO `gen_table_column` VALUES ('295', '17', 'user_id', '用户', 'bigint(20)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', '2', 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:40');
INSERT INTO `gen_table_column` VALUES ('296', '17', 'group_name', '分组名称', 'varchar(100)', 'String', 'groupName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', '3', 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:40');
INSERT INTO `gen_table_column` VALUES ('297', '17', 'group_order', '排序', 'smallint(5) unsigned zerofill', 'Integer', 'groupOrder', '0', '0', null, '1', '1', '1', null, 'EQ', 'input', '', '4', 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES ('298', '17', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', null, null, null, null, null, 'EQ', 'input', '', '5', 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES ('299', '17', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', null, '1', null, null, null, 'EQ', 'input', '', '6', 'admin', '2021-05-18 08:04:16', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES ('300', '17', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', null, '1', null, '1', '1', 'BETWEEN', 'datetime', '', '7', 'admin', '2021-05-18 08:04:17', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES ('301', '17', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', null, '1', '1', null, null, 'EQ', 'input', '', '8', 'admin', '2021-05-18 08:04:17', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES ('302', '17', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', null, '1', '1', null, null, 'EQ', 'datetime', '', '9', 'admin', '2021-05-18 08:04:17', '', '2021-05-18 08:13:41');
INSERT INTO `gen_table_column` VALUES ('303', '17', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', null, '1', '1', '1', null, 'EQ', 'textarea', '', '10', 'admin', '2021-05-18 08:04:17', '', '2021-05-18 08:13:42');

-- ----------------------------
-- Table structure for iot_category
-- ----------------------------
DROP TABLE IF EXISTS `iot_category`;
CREATE TABLE `iot_category` (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备分类ID',
  `category_name` varchar(100) NOT NULL COMMENT '设备分类名称',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of iot_category
-- ----------------------------
INSERT INTO `iot_category` VALUES ('1', 'wifi通断器', '0', '', '2021-05-06 01:00:04', '', '2021-05-06 01:05:08', '智能开关，带温湿度传感器，支持手机和射频遥控控制。应用于传统家电设备的控制等。');
INSERT INTO `iot_category` VALUES ('2', '智能灯', '0', '', '2021-05-06 01:01:39', '', '2021-05-06 01:05:32', '智能七彩灯，支持雷达感应、报警，手机和射频遥控控制。应用于环境灯、感应灯和传统灯的控制等。');
INSERT INTO `iot_category` VALUES ('3', '智能门锁', '0', '', '2021-05-06 01:02:34', '', '2021-05-06 01:04:22', '支持手机和射频遥控控制。');
INSERT INTO `iot_category` VALUES ('4', '智能水阀', '0', '', '2021-05-06 01:03:57', '', null, '手机和射频遥控控制，应用于浇灌系统。');
INSERT INTO `iot_category` VALUES ('5', '其他', '0', '', '2021-05-28 19:31:05', '', null, '其他硬件设备的接入');

-- ----------------------------
-- Table structure for iot_device
-- ----------------------------
DROP TABLE IF EXISTS `iot_device`;
CREATE TABLE `iot_device` (
  `device_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `device_num` varchar(64) NOT NULL COMMENT '设备编号',
  `category_id` bigint(20) DEFAULT NULL COMMENT '设备分类',
  `device_name` varchar(64) NOT NULL COMMENT '设备名称',
  `firmware_version` varchar(32) DEFAULT NULL COMMENT '固件版本',
  `owner_id` varchar(64) DEFAULT NULL COMMENT '设备用户ID',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_id`),
  KEY `iot_device_category` (`category_id`),
  CONSTRAINT `iot_device_category` FOREIGN KEY (`category_id`) REFERENCES `iot_category` (`category_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of iot_device
-- ----------------------------
INSERT INTO `iot_device` VALUES ('1', '7CDFA1049ADA', '2', '七彩灯-测试', '1.0', '1', '0', '', '2021-05-23 14:26:38', '', '2021-06-26 20:25:09', '暂无');
INSERT INTO `iot_device` VALUES ('2', '7CDFA1049ADB', '1', '智能开关-测试', '1.0', '1', '0', '', '2021-05-23 14:26:38', '', '2021-06-15 02:47:52', '暂无');

-- ----------------------------
-- Table structure for iot_device_group
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_group`;
CREATE TABLE `iot_device_group` (
  `device_group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备分组ID',
  `group_id` bigint(20) NOT NULL COMMENT '分组ID',
  `device_id` bigint(20) NOT NULL COMMENT '设备ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`device_group_id`),
  KEY `iot_device_group_group_id` (`group_id`),
  KEY `iot_device_group_device_id` (`device_id`),
  CONSTRAINT `iot_device_group_device_id` FOREIGN KEY (`device_id`) REFERENCES `iot_device` (`device_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `iot_device_group_group_id` FOREIGN KEY (`group_id`) REFERENCES `iot_group` (`group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of iot_device_group
-- ----------------------------
INSERT INTO `iot_device_group` VALUES ('1', '1', '1', '2021-06-11 23:25:49');
INSERT INTO `iot_device_group` VALUES ('2', '2', '1', '2021-06-11 23:25:49');
INSERT INTO `iot_device_group` VALUES ('6', '1', '2', '2021-06-11 23:25:49');
INSERT INTO `iot_device_group` VALUES ('7', '2', '2', '2021-06-11 23:25:49');

-- ----------------------------
-- Table structure for iot_device_set
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_set`;
CREATE TABLE `iot_device_set` (
  `device_set_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '配置id',
  `device_id` bigint(20) DEFAULT NULL COMMENT '设备ID',
  `device_num` varchar(64) NOT NULL COMMENT '设备编号',
  `is_alarm` tinyint(1) DEFAULT NULL COMMENT '是否启用报警',
  `is_radar` tinyint(1) DEFAULT NULL COMMENT '是否启用雷达感应',
  `is_host` tinyint(1) DEFAULT NULL COMMENT '是否托管',
  `is_reset` tinyint(1) DEFAULT NULL COMMENT '是否重启',
  `is_ap` tinyint(1) DEFAULT NULL COMMENT '是否打开AP',
  `is_smart_config` tinyint(1) DEFAULT NULL COMMENT '是否智能配网',
  `is_wifi_offline` tinyint(1) DEFAULT NULL COMMENT '是否离线模式',
  `is_open_certifi` tinyint(1) DEFAULT NULL COMMENT '是否使用证书',
  `is_rf_control` tinyint(1) DEFAULT NULL COMMENT '是否启用射频遥控',
  `is_rf_learn` tinyint(1) DEFAULT NULL COMMENT '是否遥控配对',
  `is_rf_clear` tinyint(1) DEFAULT NULL COMMENT '是否遥控清码',
  `rf_one_func` tinyint(10) DEFAULT NULL COMMENT 'RF遥控第一个按键功能',
  `rf_two_func` tinyint(10) DEFAULT NULL COMMENT 'RF遥控第二个按键功能',
  `rf_three_func` tinyint(10) DEFAULT NULL COMMENT 'RF遥控第三个按键功能',
  `rf_four_func` tinyint(10) DEFAULT NULL COMMENT 'RF遥控第四个按键功能',
  `owner_id` varchar(64) DEFAULT NULL COMMENT '设备用户ID，用于记录配网后用户的变更',
  `network_address` varchar(255) DEFAULT NULL COMMENT '配网地址',
  `network_ip` varchar(32) DEFAULT NULL COMMENT '配网IP',
  `radar_interval` smallint(10) DEFAULT NULL COMMENT '雷达感应间隔，单位秒',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_set_id`),
  KEY `iot_device_config` (`device_id`),
  CONSTRAINT `iot_device_config` FOREIGN KEY (`device_id`) REFERENCES `iot_device` (`device_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of iot_device_set
-- ----------------------------
INSERT INTO `iot_device_set` VALUES ('1', '1', '7CDFA1049ADA', '1', '1', '1', '0', '0', '0', '0', '0', '1', '0', '0', '1', '2', '3', '4', '1', '内网', '127.0.0.1', '5', '0', '', '2021-06-26 20:25:10', '', null, null);
INSERT INTO `iot_device_set` VALUES ('2', '2', '7CDFA1049ADB', '0', '0', '1', '0', '0', '0', '0', '0', '1', '0', '0', '1', '2', '3', '4', '1', '内网', '127.0.0.1', '5', '0', '', '2021-06-01 00:12:26', '', '2021-06-23 20:59:33', null);

-- ----------------------------
-- Table structure for iot_device_status
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_status`;
CREATE TABLE `iot_device_status` (
  `device_status_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备状态ID',
  `device_id` bigint(20) DEFAULT NULL COMMENT '设备ID',
  `device_num` varchar(64) NOT NULL COMMENT '设备编号',
  `relay_status` tinyint(1) DEFAULT NULL COMMENT '继电器状态:0-关，1-开',
  `light_status` tinyint(1) DEFAULT NULL COMMENT '灯状态:0-关，1-开',
  `is_online` tinyint(1) DEFAULT NULL COMMENT '设备是否在线',
  `rssi` tinyint(10) DEFAULT NULL COMMENT 'wifi信号强度',
  `device_temperature` float(6,2) DEFAULT NULL COMMENT '设备温度',
  `air_temperature` float(6,2) DEFAULT NULL COMMENT '空气温度',
  `air_humidity` float(6,2) DEFAULT NULL COMMENT '空气湿度',
  `trigger_source` tinyint(10) DEFAULT NULL COMMENT '触发源：0-无、1-按键、2.手机、3-浏览器、4-射频遥控、5-雷达、6-报警、7-定时',
  `brightness` tinyint(10) unsigned DEFAULT NULL COMMENT '灯的亮度：0-100',
  `light_interval` int(10) DEFAULT NULL COMMENT '渐变、动感模式闪烁间隔，单位秒',
  `light_mode` tinyint(10) DEFAULT NULL COMMENT '灯模式：1-、2-、3-、4-、5-、6-',
  `fade_time` int(10) DEFAULT NULL COMMENT '灯渐变时间',
  `red` tinyint(3) unsigned DEFAULT NULL COMMENT '红灯值：0-255',
  `green` tinyint(3) unsigned DEFAULT NULL COMMENT '绿灯值：0-255',
  `blue` tinyint(3) unsigned DEFAULT NULL COMMENT '蓝灯值：0-255',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_status_id`),
  KEY `iot_device_status` (`device_id`),
  CONSTRAINT `iot_device_status` FOREIGN KEY (`device_id`) REFERENCES `iot_device` (`device_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2846 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of iot_device_status
-- ----------------------------
INSERT INTO `iot_device_status` VALUES ('1', '1', '7CDFA1049ADA', '1', '1', '1', '-80', '36.52', '0.00', '0.00', '0', '100', '432', '0', '259', '255', '254', '241', '0', '', '2021-06-26 20:27:17', '', null, null);
INSERT INTO `iot_device_status` VALUES ('2', '2', '7CDFA1049ADB', '0', '1', '0', '-46', '23.78', '0.00', '0.00', '0', '100', '100', '0', '100', '255', '255', '255', '0', '', '2021-06-01 00:13:38', '', '2021-06-23 21:00:37', null);

-- ----------------------------
-- Table structure for iot_group
-- ----------------------------
DROP TABLE IF EXISTS `iot_group`;
CREATE TABLE `iot_group` (
  `group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备分组ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `group_name` varchar(100) NOT NULL COMMENT '设备分组名称',
  `group_order` smallint(5) unsigned zerofill DEFAULT '00000' COMMENT '分组的排序',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of iot_group
-- ----------------------------
INSERT INTO `iot_group` VALUES ('1', '1', '一楼', '00001', '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');
INSERT INTO `iot_group` VALUES ('2', '1', '二楼', '00002', '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');
INSERT INTO `iot_group` VALUES ('3', '1', '三楼', '00003', '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');
INSERT INTO `iot_group` VALUES ('4', '1', '四楼', '00004', '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');
INSERT INTO `iot_group` VALUES ('5', '1', '五楼', '00005', '0', '', '2021-05-18 16:35:03', '', '2021-05-18 16:35:32', '智能灯');

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(200) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Etc/UTC');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Etc/UTC');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Etc/UTC');

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_group` varchar(200) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', null, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001797B913EF878707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001317800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', null, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001797B913EF878707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', null, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001797B913EF878707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
INSERT INTO `QRTZ_LOCKS` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `QRTZ_LOCKS` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('RuoyiScheduler', '2106e0d108ce1625043261098', '1625045051552', '15000');

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint(13) DEFAULT NULL,
  `prev_fire_time` bigint(13) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) DEFAULT NULL,
  `calendar_name` varchar(200) DEFAULT NULL,
  `misfire_instr` smallint(2) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', null, '1625043270000', '-1', '5', 'PAUSED', 'CRON', '1625043261000', '0', null, '2', '');
INSERT INTO `QRTZ_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', null, '1625043270000', '-1', '5', 'PAUSED', 'CRON', '1625043261000', '0', null, '2', '');
INSERT INTO `QRTZ_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', null, '1625043280000', '-1', '5', 'PAUSED', 'CRON', '1625043261000', '0', null, '2', '');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-05-18 02:23:07', '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES ('2', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-05-18 02:23:07', '', null, '初始化密码 123456');
INSERT INTO `sys_config` VALUES ('3', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-05-18 02:23:07', '', null, '深色主题theme-dark，浅色主题theme-light');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '0', '0', '若依科技', '0', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);
INSERT INTO `sys_dept` VALUES ('101', '100', '0,100', '深圳总公司', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);
INSERT INTO `sys_dept` VALUES ('102', '100', '0,100', '长沙分公司', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);
INSERT INTO `sys_dept` VALUES ('103', '101', '0,100,101', '研发部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);
INSERT INTO `sys_dept` VALUES ('104', '101', '0,100,101', '市场部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);
INSERT INTO `sys_dept` VALUES ('105', '101', '0,100,101', '测试部门', '3', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);
INSERT INTO `sys_dept` VALUES ('106', '101', '0,100,101', '财务部门', '4', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);
INSERT INTO `sys_dept` VALUES ('107', '101', '0,100,101', '运维部门', '5', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);
INSERT INTO `sys_dept` VALUES ('108', '102', '0,100,102', '市场部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);
INSERT INTO `sys_dept` VALUES ('109', '102', '0,100,102', '财务部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2021-05-18 02:23:06', '', null);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('1', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', null, '性别男');
INSERT INTO `sys_dict_data` VALUES ('2', '2', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '性别女');
INSERT INTO `sys_dict_data` VALUES ('3', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '性别未知');
INSERT INTO `sys_dict_data` VALUES ('4', '1', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', null, '显示菜单');
INSERT INTO `sys_dict_data` VALUES ('5', '2', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES ('6', '1', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('7', '2', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('8', '1', '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('9', '2', '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('10', '1', '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', null, '默认分组');
INSERT INTO `sys_dict_data` VALUES ('11', '2', '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '系统分组');
INSERT INTO `sys_dict_data` VALUES ('12', '1', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', null, '系统默认是');
INSERT INTO `sys_dict_data` VALUES ('13', '2', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '系统默认否');
INSERT INTO `sys_dict_data` VALUES ('14', '1', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', null, '通知');
INSERT INTO `sys_dict_data` VALUES ('15', '2', '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '公告');
INSERT INTO `sys_dict_data` VALUES ('16', '1', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-05-18 02:23:07', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('17', '2', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '关闭状态');
INSERT INTO `sys_dict_data` VALUES ('18', '1', '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '新增操作');
INSERT INTO `sys_dict_data` VALUES ('19', '2', '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '修改操作');
INSERT INTO `sys_dict_data` VALUES ('20', '3', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '删除操作');
INSERT INTO `sys_dict_data` VALUES ('21', '4', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '授权操作');
INSERT INTO `sys_dict_data` VALUES ('22', '5', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '导出操作');
INSERT INTO `sys_dict_data` VALUES ('23', '6', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '导入操作');
INSERT INTO `sys_dict_data` VALUES ('24', '7', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '强退操作');
INSERT INTO `sys_dict_data` VALUES ('25', '8', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '生成操作');
INSERT INTO `sys_dict_data` VALUES ('26', '9', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '清空操作');
INSERT INTO `sys_dict_data` VALUES ('27', '1', '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('28', '2', '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-05-18 02:23:07', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('100', '0', '按键', '1', 'iot_trigger_source', null, null, 'N', '0', 'admin', '2021-05-05 15:53:34', 'admin', '2021-05-05 15:54:17', '按键操作');
INSERT INTO `sys_dict_data` VALUES ('101', '0', '手机', '2', 'iot_trigger_source', null, null, 'N', '0', 'admin', '2021-05-05 15:53:50', '', null, '手机操作');
INSERT INTO `sys_dict_data` VALUES ('102', '0', '浏览器', '3', 'iot_trigger_source', null, null, 'N', '0', 'admin', '2021-05-05 15:54:09', '', null, '浏览器操作');
INSERT INTO `sys_dict_data` VALUES ('103', '0', '射频遥控', '4', 'iot_trigger_source', null, null, 'N', '0', 'admin', '2021-05-05 15:54:44', '', null, '433M遥控操作');
INSERT INTO `sys_dict_data` VALUES ('104', '0', '雷达', '5', 'iot_trigger_source', null, null, 'N', '0', 'admin', '2021-05-05 15:55:03', '', null, '雷达触发');
INSERT INTO `sys_dict_data` VALUES ('105', '0', '报警', '6', 'iot_trigger_source', null, null, 'N', '0', 'admin', '2021-05-05 15:55:44', '', null, '报警触发');
INSERT INTO `sys_dict_data` VALUES ('106', '0', '定时', '7', 'iot_trigger_source', null, null, 'N', '0', 'admin', '2021-05-05 15:56:03', '', null, '定时触发');
INSERT INTO `sys_dict_data` VALUES ('107', '1', '继电器开关', '1', 'rf_function', null, null, 'N', '0', 'admin', '2021-05-05 15:58:36', 'admin', '2021-06-23 22:50:32', '继电器通断');
INSERT INTO `sys_dict_data` VALUES ('108', '2', '七彩灯开关', '2', 'rf_function', null, null, 'N', '0', 'admin', '2021-05-05 15:58:57', 'admin', '2021-06-23 22:50:44', '开关灯');
INSERT INTO `sys_dict_data` VALUES ('109', '3', '雷达开关', '3', 'rf_function', null, null, 'N', '0', 'admin', '2021-05-05 15:59:34', 'admin', '2021-06-23 22:50:21', '开关雷达');
INSERT INTO `sys_dict_data` VALUES ('110', '4', '报警开关', '4', 'rf_function', null, null, 'N', '0', 'admin', '2021-05-05 16:00:01', 'admin', '2021-06-01 15:44:44', '报警开关');
INSERT INTO `sys_dict_data` VALUES ('111', '5', '智能配网', '5', 'rf_function', null, null, 'N', '0', 'admin', '2021-05-05 16:00:16', 'admin', '2021-06-01 15:44:51', '智能配网');
INSERT INTO `sys_dict_data` VALUES ('112', '0', '固定颜色', '0', 'light_mode', null, null, 'N', '0', 'admin', '2021-05-05 16:07:22', '', null, '固定颜色');
INSERT INTO `sys_dict_data` VALUES ('113', '0', '七彩渐变', '1', 'light_mode', null, null, 'N', '0', 'admin', '2021-05-05 16:07:41', '', null, '七彩渐变');
INSERT INTO `sys_dict_data` VALUES ('114', '0', '动感模式', '2', 'light_mode', null, null, 'N', '0', 'admin', '2021-05-05 16:08:44', '', null, '动感模式');
INSERT INTO `sys_dict_data` VALUES ('115', '0', '单色渐变', '3', 'light_mode', null, null, 'N', '0', 'admin', '2021-05-05 16:09:12', '', null, '单色渐变');
INSERT INTO `sys_dict_data` VALUES ('116', '0', '白光', '4', 'light_mode', null, null, 'N', '0', 'admin', '2021-05-05 16:09:46', '', null, '白光');
INSERT INTO `sys_dict_data` VALUES ('117', '0', '暖光', '5', 'light_mode', null, null, 'N', '0', 'admin', '2021-05-05 16:10:07', '', null, '暖光');
INSERT INTO `sys_dict_data` VALUES ('118', '0', '无', '0', 'rf_function', null, null, 'N', '0', 'admin', '2021-06-01 15:43:44', 'admin', '2021-06-01 15:44:21', '不进行任何操作');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2021-05-18 02:23:07', '', null, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', '2021-05-18 02:23:07', '', null, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', '2021-05-18 02:23:07', '', null, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', '2021-05-18 02:23:07', '', null, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', '2021-05-18 02:23:07', '', null, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', '2021-05-18 02:23:07', '', null, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', '2021-05-18 02:23:07', '', null, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', '2021-05-18 02:23:07', '', null, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', '2021-05-18 02:23:07', '', null, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', '2021-05-18 02:23:07', '', null, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES ('100', '设备触发源', 'iot_trigger_source', '0', 'admin', '2021-05-05 15:51:26', '', null, '设备操作的触发源');
INSERT INTO `sys_dict_type` VALUES ('101', '射频遥控按键功能', 'rf_function', '0', 'admin', '2021-05-05 15:58:05', '', null, '射频遥控按键功能列表');
INSERT INTO `sys_dict_type` VALUES ('102', '彩灯模式', 'light_mode', '0', 'admin', '2021-05-05 16:04:53', '', null, '彩灯模式，单色、七彩、渐变、动感');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2021-05-18 02:23:07', '', null, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES ('1', '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '系统默认（有参） 总共耗时：1毫秒', '0', '', '2021-06-11 09:23:45');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES ('385', 'admin', '172.17.0.1', '内网IP', 'Mobile Safari', 'Android 1.x', '1', '用户不存在/密码错误', '2021-06-30 17:13:17');
INSERT INTO `sys_logininfor` VALUES ('386', 'admin', '172.17.0.1', '内网IP', 'Mobile Safari', 'Android 1.x', '1', '验证码已失效', '2021-06-30 17:13:34');
INSERT INTO `sys_logininfor` VALUES ('387', 'admin', '172.17.0.1', '内网IP', 'Mobile Safari', 'Android 1.x', '0', '登录成功', '2021-06-30 17:14:13');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2074 DEFAULT CHARSET=utf8 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', '1', 'system', null, '1', '0', 'M', '0', '0', '', 'system', 'admin', '2021-05-18 02:23:06', '', null, '系统管理目录');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', '2', 'monitor', null, '1', '0', 'M', '0', '0', '', 'monitor', 'admin', '2021-05-18 02:23:06', '', null, '系统监控目录');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', '3', 'tool', null, '1', '0', 'M', '0', '0', '', 'tool', 'admin', '2021-05-18 02:23:06', '', null, '系统工具目录');
INSERT INTO `sys_menu` VALUES ('4', '物美官网', '0', '4', 'http://wumei.live', null, '0', '0', 'M', '0', '0', '', 'guide', 'admin', '2021-05-18 02:23:06', 'admin', '2021-05-24 14:17:14', '若依官网地址');
INSERT INTO `sys_menu` VALUES ('100', '用户管理', '1', '1', 'user', 'system/user/index', '1', '0', 'C', '0', '0', 'system:user:list', 'user', 'admin', '2021-05-18 02:23:06', '', null, '用户管理菜单');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', '2', 'role', 'system/role/index', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2021-05-18 02:23:06', '', null, '角色管理菜单');
INSERT INTO `sys_menu` VALUES ('102', '菜单管理', '1', '3', 'menu', 'system/menu/index', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2021-05-18 02:23:06', '', null, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES ('103', '部门管理', '1', '4', 'dept', 'system/dept/index', '1', '0', 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2021-05-18 02:23:06', '', null, '部门管理菜单');
INSERT INTO `sys_menu` VALUES ('104', '岗位管理', '1', '5', 'post', 'system/post/index', '1', '0', 'C', '0', '0', 'system:post:list', 'post', 'admin', '2021-05-18 02:23:06', '', null, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES ('105', '字典管理', '1', '6', 'dict', 'system/dict/index', '1', '0', 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2021-05-18 02:23:06', '', null, '字典管理菜单');
INSERT INTO `sys_menu` VALUES ('106', '参数设置', '1', '7', 'config', 'system/config/index', '1', '0', 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2021-05-18 02:23:06', '', null, '参数设置菜单');
INSERT INTO `sys_menu` VALUES ('107', '通知公告', '1', '8', 'notice', 'system/notice/index', '1', '0', 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2021-05-18 02:23:06', '', null, '通知公告菜单');
INSERT INTO `sys_menu` VALUES ('108', '日志管理', '1', '9', 'log', '', '1', '0', 'M', '0', '0', '', 'log', 'admin', '2021-05-18 02:23:06', '', null, '日志管理菜单');
INSERT INTO `sys_menu` VALUES ('109', '在线用户', '2', '1', 'online', 'monitor/online/index', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2021-05-18 02:23:06', '', null, '在线用户菜单');
INSERT INTO `sys_menu` VALUES ('110', '定时任务', '2', '2', 'job', 'monitor/job/index', '1', '0', 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2021-05-18 02:23:06', '', null, '定时任务菜单');
INSERT INTO `sys_menu` VALUES ('111', '数据监控', '2', '3', 'druid', 'monitor/druid/index', '1', '0', 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2021-05-18 02:23:06', '', null, '数据监控菜单');
INSERT INTO `sys_menu` VALUES ('112', '服务监控', '2', '4', 'server', 'monitor/server/index', '1', '0', 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2021-05-18 02:23:06', '', null, '服务监控菜单');
INSERT INTO `sys_menu` VALUES ('113', '缓存监控', '2', '5', 'cache', 'monitor/cache/index', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2021-05-18 02:23:06', '', null, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES ('114', '表单构建', '3', '1', 'build', 'tool/build/index', '1', '0', 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2021-05-18 02:23:06', '', null, '表单构建菜单');
INSERT INTO `sys_menu` VALUES ('115', '代码生成', '3', '2', 'gen', 'tool/gen/index', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2021-05-18 02:23:06', '', null, '代码生成菜单');
INSERT INTO `sys_menu` VALUES ('116', '系统接口', '3', '3', 'swagger', 'tool/swagger/index', '1', '0', 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2021-05-18 02:23:06', '', null, '系统接口菜单');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', '1', 'operlog', 'monitor/operlog/index', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-05-18 02:23:06', '', null, '操作日志菜单');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2021-05-18 02:23:06', '', null, '登录日志菜单');
INSERT INTO `sys_menu` VALUES ('1001', '用户查询', '100', '1', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1002', '用户新增', '100', '2', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1003', '用户修改', '100', '3', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1004', '用户删除', '100', '4', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1005', '用户导出', '100', '5', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1006', '用户导入', '100', '6', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1007', '重置密码', '100', '7', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1008', '角色查询', '101', '1', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1009', '角色新增', '101', '2', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1010', '角色修改', '101', '3', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1011', '角色删除', '101', '4', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1012', '角色导出', '101', '5', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1013', '菜单查询', '102', '1', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1014', '菜单新增', '102', '2', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1015', '菜单修改', '102', '3', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1016', '菜单删除', '102', '4', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1017', '部门查询', '103', '1', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1018', '部门新增', '103', '2', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1019', '部门修改', '103', '3', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1020', '部门删除', '103', '4', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1021', '岗位查询', '104', '1', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1022', '岗位新增', '104', '2', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1023', '岗位修改', '104', '3', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1024', '岗位删除', '104', '4', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1025', '岗位导出', '104', '5', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1026', '字典查询', '105', '1', '#', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1027', '字典新增', '105', '2', '#', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1028', '字典修改', '105', '3', '#', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1029', '字典删除', '105', '4', '#', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1030', '字典导出', '105', '5', '#', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1031', '参数查询', '106', '1', '#', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1032', '参数新增', '106', '2', '#', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1033', '参数修改', '106', '3', '#', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1034', '参数删除', '106', '4', '#', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1035', '参数导出', '106', '5', '#', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1036', '公告查询', '107', '1', '#', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1037', '公告新增', '107', '2', '#', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1038', '公告修改', '107', '3', '#', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1039', '公告删除', '107', '4', '#', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1040', '操作查询', '500', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1041', '操作删除', '500', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1042', '日志导出', '500', '4', '#', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1043', '登录查询', '501', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1044', '登录删除', '501', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1045', '日志导出', '501', '3', '#', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', '3', '#', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1049', '任务查询', '110', '1', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1050', '任务新增', '110', '2', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1051', '任务修改', '110', '3', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1052', '任务删除', '110', '4', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1053', '状态修改', '110', '5', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1054', '任务导出', '110', '7', '#', '', '1', '0', 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1055', '生成查询', '115', '1', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1056', '生成修改', '115', '2', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1057', '生成删除', '115', '3', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1058', '导入代码', '115', '2', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '115', '4', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '115', '5', '#', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2021-05-18 02:23:07', '', null, '');
INSERT INTO `sys_menu` VALUES ('2000', '物联网', '0', '0', 'iot', null, '1', '0', 'M', '0', '0', '', 'iot', 'admin', '2021-05-03 17:20:27', 'admin', '2021-05-18 09:32:14', '');
INSERT INTO `sys_menu` VALUES ('2043', '设备分类', '2000', '10', 'category', 'system/category/index', '1', '0', 'C', '0', '0', 'system:category:list', 'category', 'admin', '2021-05-06 15:10:35', 'admin', '2021-05-18 09:32:58', '设备分类菜单');
INSERT INTO `sys_menu` VALUES ('2044', '设备分类查询', '2043', '1', '#', '', '1', '0', 'F', '0', '0', 'system:category:query', '#', 'admin', '2021-05-06 15:10:35', '', null, '');
INSERT INTO `sys_menu` VALUES ('2045', '设备分类新增', '2043', '2', '#', '', '1', '0', 'F', '0', '0', 'system:category:add', '#', 'admin', '2021-05-06 15:10:35', '', null, '');
INSERT INTO `sys_menu` VALUES ('2046', '设备分类修改', '2043', '3', '#', '', '1', '0', 'F', '0', '0', 'system:category:edit', '#', 'admin', '2021-05-06 15:10:35', '', null, '');
INSERT INTO `sys_menu` VALUES ('2047', '设备分类删除', '2043', '4', '#', '', '1', '0', 'F', '0', '0', 'system:category:remove', '#', 'admin', '2021-05-06 15:10:35', '', null, '');
INSERT INTO `sys_menu` VALUES ('2048', '设备分类导出', '2043', '5', '#', '', '1', '0', 'F', '0', '0', 'system:category:export', '#', 'admin', '2021-05-06 15:10:35', '', null, '');
INSERT INTO `sys_menu` VALUES ('2049', '设备列表', '2000', '11', 'device', 'system/device/index', '1', '0', 'C', '0', '0', 'system:device:list', 'device', 'admin', '2021-05-06 15:10:50', 'admin', '2021-05-18 09:33:08', '设备菜单');
INSERT INTO `sys_menu` VALUES ('2050', '设备查询', '2049', '1', '#', '', '1', '0', 'F', '0', '0', 'system:device:query', '#', 'admin', '2021-05-06 15:10:50', '', null, '');
INSERT INTO `sys_menu` VALUES ('2051', '设备新增', '2049', '2', '#', '', '1', '0', 'F', '0', '0', 'system:device:add', '#', 'admin', '2021-05-06 15:10:50', '', null, '');
INSERT INTO `sys_menu` VALUES ('2052', '设备修改', '2049', '3', '#', '', '1', '0', 'F', '0', '0', 'system:device:edit', '#', 'admin', '2021-05-06 15:10:50', '', null, '');
INSERT INTO `sys_menu` VALUES ('2053', '设备删除', '2049', '4', '#', '', '1', '0', 'F', '0', '0', 'system:device:remove', '#', 'admin', '2021-05-06 15:10:50', '', null, '');
INSERT INTO `sys_menu` VALUES ('2054', '设备导出', '2049', '5', '#', '', '1', '0', 'F', '0', '0', 'system:device:export', '#', 'admin', '2021-05-06 15:10:50', '', null, '');
INSERT INTO `sys_menu` VALUES ('2055', '配置日志', '2000', '13', 'set', 'system/set/index', '1', '0', 'C', '0', '0', 'system:set:list', 'config', 'admin', '2021-05-06 15:11:09', 'admin', '2021-05-26 14:54:24', '设备配置菜单');
INSERT INTO `sys_menu` VALUES ('2056', '设备配置查询', '2055', '1', '#', '', '1', '0', 'F', '0', '0', 'system:set:query', '#', 'admin', '2021-05-06 15:11:09', '', null, '');
INSERT INTO `sys_menu` VALUES ('2057', '设备配置新增', '2055', '2', '#', '', '1', '0', 'F', '0', '0', 'system:set:add', '#', 'admin', '2021-05-06 15:11:09', '', null, '');
INSERT INTO `sys_menu` VALUES ('2058', '设备配置修改', '2055', '3', '#', '', '1', '0', 'F', '0', '0', 'system:set:edit', '#', 'admin', '2021-05-06 15:11:09', '', null, '');
INSERT INTO `sys_menu` VALUES ('2059', '设备配置删除', '2055', '4', '#', '', '1', '0', 'F', '0', '0', 'system:set:remove', '#', 'admin', '2021-05-06 15:11:09', '', null, '');
INSERT INTO `sys_menu` VALUES ('2060', '设备配置导出', '2055', '5', '#', '', '1', '0', 'F', '0', '0', 'system:set:export', '#', 'admin', '2021-05-06 15:11:09', '', null, '');
INSERT INTO `sys_menu` VALUES ('2061', '状态日志', '2000', '12', 'status', 'system/status/index', '1', '0', 'C', '0', '0', 'system:status:list', 'status', 'admin', '2021-05-06 15:11:19', 'admin', '2021-05-26 14:54:38', '设备状态菜单');
INSERT INTO `sys_menu` VALUES ('2062', '设备状态查询', '2061', '1', '#', '', '1', '0', 'F', '0', '0', 'system:status:query', '#', 'admin', '2021-05-06 15:11:19', '', null, '');
INSERT INTO `sys_menu` VALUES ('2063', '设备状态新增', '2061', '2', '#', '', '1', '0', 'F', '0', '0', 'system:status:add', '#', 'admin', '2021-05-06 15:11:19', '', null, '');
INSERT INTO `sys_menu` VALUES ('2064', '设备状态修改', '2061', '3', '#', '', '1', '0', 'F', '0', '0', 'system:status:edit', '#', 'admin', '2021-05-06 15:11:19', '', null, '');
INSERT INTO `sys_menu` VALUES ('2065', '设备状态删除', '2061', '4', '#', '', '1', '0', 'F', '0', '0', 'system:status:remove', '#', 'admin', '2021-05-06 15:11:19', '', null, '');
INSERT INTO `sys_menu` VALUES ('2066', '设备状态导出', '2061', '5', '#', '', '1', '0', 'F', '0', '0', 'system:status:export', '#', 'admin', '2021-05-06 15:11:19', '', null, '');
INSERT INTO `sys_menu` VALUES ('2067', '设备分组', '2000', '1', 'group', 'system/group/index', '1', '0', 'C', '0', '0', 'system:group:list', 'group', 'admin', '2021-05-18 08:15:31', 'admin', '2021-05-18 09:40:59', '分组菜单');
INSERT INTO `sys_menu` VALUES ('2068', '分组查询', '2067', '1', '#', '', '1', '0', 'F', '0', '0', 'system:group:query', '#', 'admin', '2021-05-18 08:15:31', '', null, '');
INSERT INTO `sys_menu` VALUES ('2069', '分组新增', '2067', '2', '#', '', '1', '0', 'F', '0', '0', 'system:group:add', '#', 'admin', '2021-05-18 08:15:31', '', null, '');
INSERT INTO `sys_menu` VALUES ('2070', '分组修改', '2067', '3', '#', '', '1', '0', 'F', '0', '0', 'system:group:edit', '#', 'admin', '2021-05-18 08:15:31', '', null, '');
INSERT INTO `sys_menu` VALUES ('2071', '分组删除', '2067', '4', '#', '', '1', '0', 'F', '0', '0', 'system:group:remove', '#', 'admin', '2021-05-18 08:15:31', '', null, '');
INSERT INTO `sys_menu` VALUES ('2072', '分组导出', '2067', '5', '#', '', '1', '0', 'F', '0', '0', 'system:group:export', '#', 'admin', '2021-05-18 08:15:31', '', null, '');
INSERT INTO `sys_menu` VALUES ('2073', 'EMQ管理', '2000', '14', 'http://localhost:18083/#/login?redirect=%2F', null, '0', '0', 'C', '0', '0', '', 'mqtt', 'admin', '2021-05-26 14:53:48', 'admin', '2021-05-27 16:11:27', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('1', '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2021-05-18 02:23:07', '', null, '管理员');
INSERT INTO `sys_notice` VALUES ('2', '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2021-05-18 02:23:07', '', null, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1877 DEFAULT CHARSET=utf8 COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES ('1873', '设备状态', '2', 'com.ruoyi.system.controller.IotDeviceStatusController.edit()', 'PUT', '1', 'admin', null, '/system/status', '172.17.0.1', '内网IP', '{\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"triggerSource\":1,\"relayStatus\":0,\"updateTime\":1625044821428,\"params\":{}}', '{\"msg\":\"mqtt 发布成功\",\"code\":200}', '0', null, '2021-06-30 17:20:21');
INSERT INTO `sys_oper_log` VALUES ('1874', '设备状态', '2', 'com.ruoyi.system.controller.IotDeviceStatusController.edit()', 'PUT', '1', 'admin', null, '/system/status', '172.17.0.1', '内网IP', '{\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"triggerSource\":1,\"relayStatus\":1,\"updateTime\":1625044822177,\"params\":{}}', '{\"msg\":\"mqtt 发布成功\",\"code\":200}', '0', null, '2021-06-30 17:20:22');
INSERT INTO `sys_oper_log` VALUES ('1875', '设备状态', '2', 'com.ruoyi.system.controller.IotDeviceStatusController.edit()', 'PUT', '1', 'admin', null, '/system/status', '172.17.0.1', '内网IP', '{\"lightStatus\":0,\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"triggerSource\":1,\"updateTime\":1625044822998,\"params\":{}}', '{\"msg\":\"mqtt 发布成功\",\"code\":200}', '0', null, '2021-06-30 17:20:23');
INSERT INTO `sys_oper_log` VALUES ('1876', '设备状态', '2', 'com.ruoyi.system.controller.IotDeviceStatusController.edit()', 'PUT', '1', 'admin', null, '/system/status', '172.17.0.1', '内网IP', '{\"lightStatus\":1,\"deviceId\":1,\"deviceNum\":\"7CDFA1049ADA\",\"triggerSource\":1,\"updateTime\":1625044823902,\"params\":{}}', '{\"msg\":\"mqtt 发布成功\",\"code\":200}', '0', null, '2021-06-30 17:20:23');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES ('1', 'ceo', '董事长', '1', '0', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_post` VALUES ('2', 'se', '项目经理', '2', '0', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_post` VALUES ('3', 'hr', '人力资源', '3', '0', 'admin', '2021-05-18 02:23:06', '', null, '');
INSERT INTO `sys_post` VALUES ('4', 'user', '普通员工', '4', '0', 'admin', '2021-05-18 02:23:06', '', null, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'admin', '1', '1', '1', '1', '0', '0', 'admin', '2021-05-18 02:23:06', '', null, '超级管理员');
INSERT INTO `sys_role` VALUES ('2', '普通角色', 'common', '2', '2', '1', '1', '0', '0', 'admin', '2021-05-18 02:23:06', '', null, '普通角色');
INSERT INTO `sys_role` VALUES ('100', '游客角色', 'visitor', '3', '1', '1', '1', '0', '0', 'admin', '2021-05-29 08:42:32', 'admin', '2021-06-19 09:30:50', null);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('2', '100');
INSERT INTO `sys_role_dept` VALUES ('2', '101');
INSERT INTO `sys_role_dept` VALUES ('2', '105');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '2');
INSERT INTO `sys_role_menu` VALUES ('2', '3');
INSERT INTO `sys_role_menu` VALUES ('2', '4');
INSERT INTO `sys_role_menu` VALUES ('2', '100');
INSERT INTO `sys_role_menu` VALUES ('2', '101');
INSERT INTO `sys_role_menu` VALUES ('2', '102');
INSERT INTO `sys_role_menu` VALUES ('2', '103');
INSERT INTO `sys_role_menu` VALUES ('2', '104');
INSERT INTO `sys_role_menu` VALUES ('2', '105');
INSERT INTO `sys_role_menu` VALUES ('2', '106');
INSERT INTO `sys_role_menu` VALUES ('2', '107');
INSERT INTO `sys_role_menu` VALUES ('2', '108');
INSERT INTO `sys_role_menu` VALUES ('2', '109');
INSERT INTO `sys_role_menu` VALUES ('2', '110');
INSERT INTO `sys_role_menu` VALUES ('2', '111');
INSERT INTO `sys_role_menu` VALUES ('2', '112');
INSERT INTO `sys_role_menu` VALUES ('2', '113');
INSERT INTO `sys_role_menu` VALUES ('2', '114');
INSERT INTO `sys_role_menu` VALUES ('2', '115');
INSERT INTO `sys_role_menu` VALUES ('2', '116');
INSERT INTO `sys_role_menu` VALUES ('2', '500');
INSERT INTO `sys_role_menu` VALUES ('2', '501');
INSERT INTO `sys_role_menu` VALUES ('2', '1000');
INSERT INTO `sys_role_menu` VALUES ('2', '1001');
INSERT INTO `sys_role_menu` VALUES ('2', '1002');
INSERT INTO `sys_role_menu` VALUES ('2', '1003');
INSERT INTO `sys_role_menu` VALUES ('2', '1004');
INSERT INTO `sys_role_menu` VALUES ('2', '1005');
INSERT INTO `sys_role_menu` VALUES ('2', '1006');
INSERT INTO `sys_role_menu` VALUES ('2', '1007');
INSERT INTO `sys_role_menu` VALUES ('2', '1008');
INSERT INTO `sys_role_menu` VALUES ('2', '1009');
INSERT INTO `sys_role_menu` VALUES ('2', '1010');
INSERT INTO `sys_role_menu` VALUES ('2', '1011');
INSERT INTO `sys_role_menu` VALUES ('2', '1012');
INSERT INTO `sys_role_menu` VALUES ('2', '1013');
INSERT INTO `sys_role_menu` VALUES ('2', '1014');
INSERT INTO `sys_role_menu` VALUES ('2', '1015');
INSERT INTO `sys_role_menu` VALUES ('2', '1016');
INSERT INTO `sys_role_menu` VALUES ('2', '1017');
INSERT INTO `sys_role_menu` VALUES ('2', '1018');
INSERT INTO `sys_role_menu` VALUES ('2', '1019');
INSERT INTO `sys_role_menu` VALUES ('2', '1020');
INSERT INTO `sys_role_menu` VALUES ('2', '1021');
INSERT INTO `sys_role_menu` VALUES ('2', '1022');
INSERT INTO `sys_role_menu` VALUES ('2', '1023');
INSERT INTO `sys_role_menu` VALUES ('2', '1024');
INSERT INTO `sys_role_menu` VALUES ('2', '1025');
INSERT INTO `sys_role_menu` VALUES ('2', '1026');
INSERT INTO `sys_role_menu` VALUES ('2', '1027');
INSERT INTO `sys_role_menu` VALUES ('2', '1028');
INSERT INTO `sys_role_menu` VALUES ('2', '1029');
INSERT INTO `sys_role_menu` VALUES ('2', '1030');
INSERT INTO `sys_role_menu` VALUES ('2', '1031');
INSERT INTO `sys_role_menu` VALUES ('2', '1032');
INSERT INTO `sys_role_menu` VALUES ('2', '1033');
INSERT INTO `sys_role_menu` VALUES ('2', '1034');
INSERT INTO `sys_role_menu` VALUES ('2', '1035');
INSERT INTO `sys_role_menu` VALUES ('2', '1036');
INSERT INTO `sys_role_menu` VALUES ('2', '1037');
INSERT INTO `sys_role_menu` VALUES ('2', '1038');
INSERT INTO `sys_role_menu` VALUES ('2', '1039');
INSERT INTO `sys_role_menu` VALUES ('2', '1040');
INSERT INTO `sys_role_menu` VALUES ('2', '1041');
INSERT INTO `sys_role_menu` VALUES ('2', '1042');
INSERT INTO `sys_role_menu` VALUES ('2', '1043');
INSERT INTO `sys_role_menu` VALUES ('2', '1044');
INSERT INTO `sys_role_menu` VALUES ('2', '1045');
INSERT INTO `sys_role_menu` VALUES ('2', '1046');
INSERT INTO `sys_role_menu` VALUES ('2', '1047');
INSERT INTO `sys_role_menu` VALUES ('2', '1048');
INSERT INTO `sys_role_menu` VALUES ('2', '1049');
INSERT INTO `sys_role_menu` VALUES ('2', '1050');
INSERT INTO `sys_role_menu` VALUES ('2', '1051');
INSERT INTO `sys_role_menu` VALUES ('2', '1052');
INSERT INTO `sys_role_menu` VALUES ('2', '1053');
INSERT INTO `sys_role_menu` VALUES ('2', '1054');
INSERT INTO `sys_role_menu` VALUES ('2', '1055');
INSERT INTO `sys_role_menu` VALUES ('2', '1056');
INSERT INTO `sys_role_menu` VALUES ('2', '1057');
INSERT INTO `sys_role_menu` VALUES ('2', '1058');
INSERT INTO `sys_role_menu` VALUES ('2', '1059');
INSERT INTO `sys_role_menu` VALUES ('2', '1060');
INSERT INTO `sys_role_menu` VALUES ('100', '1');
INSERT INTO `sys_role_menu` VALUES ('100', '2');
INSERT INTO `sys_role_menu` VALUES ('100', '3');
INSERT INTO `sys_role_menu` VALUES ('100', '4');
INSERT INTO `sys_role_menu` VALUES ('100', '100');
INSERT INTO `sys_role_menu` VALUES ('100', '101');
INSERT INTO `sys_role_menu` VALUES ('100', '102');
INSERT INTO `sys_role_menu` VALUES ('100', '103');
INSERT INTO `sys_role_menu` VALUES ('100', '104');
INSERT INTO `sys_role_menu` VALUES ('100', '105');
INSERT INTO `sys_role_menu` VALUES ('100', '106');
INSERT INTO `sys_role_menu` VALUES ('100', '107');
INSERT INTO `sys_role_menu` VALUES ('100', '108');
INSERT INTO `sys_role_menu` VALUES ('100', '109');
INSERT INTO `sys_role_menu` VALUES ('100', '110');
INSERT INTO `sys_role_menu` VALUES ('100', '115');
INSERT INTO `sys_role_menu` VALUES ('100', '116');
INSERT INTO `sys_role_menu` VALUES ('100', '500');
INSERT INTO `sys_role_menu` VALUES ('100', '501');
INSERT INTO `sys_role_menu` VALUES ('100', '1001');
INSERT INTO `sys_role_menu` VALUES ('100', '1008');
INSERT INTO `sys_role_menu` VALUES ('100', '1013');
INSERT INTO `sys_role_menu` VALUES ('100', '1017');
INSERT INTO `sys_role_menu` VALUES ('100', '1021');
INSERT INTO `sys_role_menu` VALUES ('100', '1026');
INSERT INTO `sys_role_menu` VALUES ('100', '1031');
INSERT INTO `sys_role_menu` VALUES ('100', '1036');
INSERT INTO `sys_role_menu` VALUES ('100', '1040');
INSERT INTO `sys_role_menu` VALUES ('100', '1043');
INSERT INTO `sys_role_menu` VALUES ('100', '1046');
INSERT INTO `sys_role_menu` VALUES ('100', '1049');
INSERT INTO `sys_role_menu` VALUES ('100', '1055');
INSERT INTO `sys_role_menu` VALUES ('100', '2000');
INSERT INTO `sys_role_menu` VALUES ('100', '2043');
INSERT INTO `sys_role_menu` VALUES ('100', '2044');
INSERT INTO `sys_role_menu` VALUES ('100', '2049');
INSERT INTO `sys_role_menu` VALUES ('100', '2050');
INSERT INTO `sys_role_menu` VALUES ('100', '2055');
INSERT INTO `sys_role_menu` VALUES ('100', '2056');
INSERT INTO `sys_role_menu` VALUES ('100', '2061');
INSERT INTO `sys_role_menu` VALUES ('100', '2062');
INSERT INTO `sys_role_menu` VALUES ('100', '2067');
INSERT INTO `sys_role_menu` VALUES ('100', '2068');
INSERT INTO `sys_role_menu` VALUES ('100', '2073');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '103', 'admin', '物美智能', '00', '164770707@qq.com', '15888888888', '1', '', '$2a$10$PXtk.97BgFUAK/7lpmxZ4eNPS6zL0VVHR7g.sjrdG5XUiX7pfGaRa', '0', '0', '127.0.0.1', '2021-05-18 02:23:06', 'admin', '2021-05-18 02:23:06', '', null, '管理员');
INSERT INTO `sys_user` VALUES ('2', '105', 'wumei', '物美智能', '00', 'admin@wumei.com', '15666666666', '1', '', '$2a$10$uLlHqgW4b5oAqoS81Rhkk.7Tf6wnGvh9FE9V160Dv2Kn9doOrB4qe', '0', '0', '127.0.0.1', '2021-05-18 02:23:06', 'admin', '2021-05-18 02:23:06', 'admin', '2021-06-19 09:31:14', '测试员');
INSERT INTO `sys_user` VALUES ('100', null, 'public', '访客', '00', '', '', '0', '', '$2a$10$E8d4gZ3.QQzDE7LBfY7XpuuGX.LvWFcA982AAdAzk24u91bQ1nete', '0', '0', '', null, 'admin', '2021-05-29 08:37:36', 'admin', '2021-06-19 09:31:20', null);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES ('1', '1');
INSERT INTO `sys_user_post` VALUES ('2', '2');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '100');
INSERT INTO `sys_user_role` VALUES ('100', '100');
