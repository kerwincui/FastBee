/*
 Navicat Premium Data Transfer

 Source Server         : 101.33.237.12_3306
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : 101.33.237.12:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44)
 File Encoding         : 65001

 Date: 23/04/2024 17:59:34
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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `iot_category_index_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_category_index_parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_category
-- ----------------------------
INSERT INTO `iot_category` VALUES (1, '电工照明', 1, 'admin', 1, 0, 1, '0', '', '2022-03-01 11:44:37', '', '2023-04-10 01:12:48', '例如：通断器、开关、插座、窗帘、灯');
INSERT INTO `iot_category` VALUES (2, '家居安防', 1, 'admin', 1, 0, 2, '0', '', '2021-12-18 14:46:52', '', '2021-12-18 14:49:48', '例如：智能门锁、摄像头、智能窗帘');
INSERT INTO `iot_category` VALUES (3, '环境电器', 1, 'admin', 1, 0, 3, '0', '', '2021-12-18 14:50:24', '', '2023-04-10 01:12:53', '例如：加湿器、风扇、扫地机器人');
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
  `gw_dev_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子设备网关编号',
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
  `active_time` datetime NULL DEFAULT NULL COMMENT '激活时间',
  `summary` json NULL COMMENT '设备摘要，格式[{\"name\":\"device\"},{\"chip\":\"esp8266\"}]',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_simulate` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否是模拟设备',
  `slave_id` int(10) NULL DEFAULT NULL COMMENT '从机id',
  PRIMARY KEY (`device_id`) USING BTREE,
  UNIQUE INDEX `iot_device_index_serial_number`(`serial_number`) USING BTREE,
  INDEX `iot_device_index_product_id`(`product_id`) USING BTREE,
  INDEX `iot_device_index_tanant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_device_index_user_id`(`user_id`) USING BTREE,
  INDEX `iot_device_index_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 141 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_device
-- ----------------------------
INSERT INTO `iot_device` VALUES (108, '★温湿度开关', 41, '★智能开关产品', 1, 'admin', 1, 'admin', 'D1ELV3A5TOJS', NULL, 1.00, 4, -51, 1, 1, '[{\"id\": \"irc\", \"name\": \"射频遥控\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"switch\", \"name\": \"设备开关\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"report_monitor\", \"name\": \"上报数据\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"humidity\", \"name\": \"空气湿度\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"co2\", \"name\": \"二氧化碳\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"light_color\", \"name\": \"灯光色值\", \"value\": \" , , , \", \"shadow\": \" , , , \", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"gear\", \"name\": \"运行档位\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"reset\", \"name\": \"设备重启\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"status\", \"name\": \"上报状态\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"temperature\", \"name\": \"空气温度\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"message\", \"name\": \"屏显消息\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"brightness\", \"name\": \"室内亮度\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}]', ' 本机地址', '127.0.0.1', 113.128512, 23.027759, '2023-02-26 00:00:00', '{\"chip\": \"esp8266\", \"name\": \"wumei-smart\", \"author\": \"kerwincui\", \"create\": \"2022-06-06\", \"version\": 1.6}', NULL, '0', '', '2025-02-25 23:15:56', '', '2024-04-23 15:47:11', NULL, NULL, NULL);
INSERT INTO `iot_device` VALUES (109, '★网关设备', 55, '★网关产品', 1, 'admin', 1, 'admin', 'D1PGLPG58KZ2', NULL, 1.00, 4, -73, 1, 3, '[{\"id\": \"category_gear\", \"name\": \"运行档位\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"switch\", \"name\": \"设备开关\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_switch\", \"name\": \"设备开关\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_light\", \"ts\": \"2023-09-25 17:56:08.848\", \"name\": \"光照\", \"value\": \"68\", \"shadow\": \"68\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_report_monitor\", \"name\": \"上报监测数据\", \"value\": \" , , , , , , \", \"shadow\": \" , , , , , , \", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"light_color\", \"name\": \"灯光色值\", \"value\": \" , , , \", \"shadow\": \" , , , \", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"gear\", \"name\": \"运行档位\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"message\", \"name\": \"屏显消息\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"temperature\", \"ts\": \"2023-09-25 17:56:08.582\", \"name\": \"空气温度\", \"value\": \"23.69\", \"shadow\": \"23.69\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_irc\", \"name\": \"射频遥控\", \"value\": \" , , , , , , \", \"shadow\": \" , , , , , , \", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"brightness\", \"ts\": \"2023-09-25 17:56:08.671\", \"name\": \"室内亮度\", \"value\": \"5387\", \"shadow\": \"5387\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"report_monitor\", \"name\": \"上报监测数据\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_switch\", \"ts\": \"2023-09-25 17:56:26.188\", \"name\": \"设备开关\", \"value\": \"1,1,1, ,1,1, \", \"shadow\": \"1,1,1, ,1,1, \", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_temperature\", \"ts\": \"2023-09-25 17:56:09.203\", \"name\": \"空气温度-只读\", \"value\": \"95\", \"shadow\": \"95\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_co2\", \"ts\": \"2023-09-25 17:56:11.229\", \"name\": \"二氧化碳\", \"value\": \"3780,2612,2145,3988,5697, , \", \"shadow\": \"3780,2612,2145,3988,5697, , \", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_gear\", \"ts\": \"2023-09-25 17:56:28.066\", \"name\": \"运行档位\", \"value\": \"0,0,0, ,0,0, \", \"shadow\": \"0,0,0, ,0,0, \", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_humidity\", \"ts\": \"2023-09-25 17:56:09.025\", \"name\": \"空气湿度\", \"value\": \"90\", \"shadow\": \"90\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_report_monitor\", \"name\": \"上报监测数据\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"category_irc\", \"name\": \"射频遥控\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"reset\", \"name\": \"设备重启\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_temperature\", \"ts\": \"2023-09-25 17:56:11.45\", \"name\": \"空气温度-只读\", \"value\": \"86,39,4,80,52, , \", \"shadow\": \"86,39,4,80,52, , \", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}]', '云南省曲靖市 移通', '183.225.206.92', 104.802435, 26.496407, '2023-02-26 00:00:00', '{\"chip\": \"esp8266\", \"name\": \"wumei-smart\", \"author\": \"kerwincui\", \"create\": \"2022-06-06\", \"version\": 1.6}', NULL, '0', '', '2025-02-25 23:17:31', '', '2023-09-25 23:14:52', NULL, NULL, NULL);
INSERT INTO `iot_device` VALUES (118, '￥MODBUS网关设备', 66, '￥MODBUS协议产品', 1, 'admin', 1, 'admin', 'D4AD203F3A1C', NULL, 1.00, 4, 0, 0, 1, '[{\"id\": \"6#11\", \"name\": \"A相无功功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"31#11\", \"name\": \"三相视在功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"53#11\", \"name\": \"正向无功电能累加值高位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"0#11\", \"name\": \"相电压Ua\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"55#11\", \"name\": \"负向无功电能累加值高位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"789#11\", \"name\": \"缺相电压值\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"37#11\", \"name\": \"正向无功电能累加值低位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"17#11\", \"name\": \"线电压Ubc\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"12#11\", \"name\": \"B相有功功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"769#11\", \"name\": \"被测系统负载接线方式\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"40#11\", \"name\": \"负向无功电能累加值低高字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"50#11\", \"name\": \"正向有功电能累加值低位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"26#11\", \"name\": \"三相平均相电流 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"771#11\", \"name\": \"校验位\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"16#11\", \"name\": \"相电压Uc \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"34#11\", \"name\": \"正向有功电能累加值高位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"0#1\", \"name\": \"漏水值\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"15#11\", \"name\": \"B相视在功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"33#11\", \"name\": \"正向有功电能累加值低位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"24#11\", \"name\": \"三相平均相电压 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"0#2\", \"name\": \"温度\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"2#11\", \"name\": \"A相电流 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"23#11\", \"name\": \"C相视在功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"1#2\", \"name\": \"湿度\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"29#11\", \"name\": \"三相总功率因数 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"9#11\", \"name\": \"线电压Uab\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"13#11\", \"name\": \"B相功率因数\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"11#11\", \"name\": \"D0开出状态检测 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"56#11\", \"name\": \"负向无功电能累加值低高字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"775#11\", \"name\": \"PT\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"20#11\", \"name\": \"C相有功功率\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"38#11\", \"name\": \"正向无功电能累加值高位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"22#11\", \"name\": \"C相无功功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"35#11\", \"name\": \"负向有功电能累加值低位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"18#11\", \"name\": \"C相电流\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"51#11\", \"name\": \"负向有功电能累加值高位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"3#11\", \"name\": \"D1开入状态检测 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"54#11\", \"name\": \"正向无功电能累加值低位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"21#11\", \"name\": \"C相功率因数\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"19#11\", \"name\": \"零地电压\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"49#11\", \"name\": \"正向有功电能累加值高位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"10#11\", \"name\": \"B相电流 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"7#11\", \"name\": \"A相视在功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"14#11\", \"name\": \"B相无功功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"4#11\", \"name\": \"A相有功功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"52#11\", \"name\": \"负向有功电能累加值低位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"8#11\", \"name\": \"相电压Ub\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"28#11\", \"name\": \"三相有功功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"32#11\", \"name\": \"零序电流 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"36#11\", \"name\": \"负向有功电能累加值高位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"772#11\", \"name\": \"波特率\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"39#11\", \"name\": \"负向无功电能累加值低位字\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"25#11\", \"name\": \"三相平均线电压 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"5#11\", \"name\": \"A相功率因数\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"27#11\", \"name\": \"频率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"773#11\", \"name\": \"电压范围\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"777#11\", \"name\": \"CT\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"30#11\", \"name\": \"三相无功功率 \", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"1#11\", \"name\": \"线电压Uca\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"768#11\", \"name\": \"本机地址\", \"value\": \"\", \"shadow\": \"\", \"isChart\": 0, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}]', ' 本机地址', '127.0.0.1', 103.802435, 25.496407, '2023-03-23 00:00:00', NULL, NULL, '0', '', '2025-02-28 16:49:17', '', '2023-09-25 16:19:30', NULL, NULL, 1);
INSERT INTO `iot_device` VALUES (119, '￥漏水器', 66, '￥MODBUS协议产品', 1, 'admin', 1, 'admin', 'D4AD203F3A1C_1', 'D4AD203F3A1C', 1.00, 4, 0, 0, 1, NULL, ' 本机地址', '127.0.0.1', 103.802435, 25.496407, '2023-03-23 00:00:00', NULL, NULL, '0', '', '2023-02-28 16:49:17', '', '2023-09-25 16:19:30', NULL, NULL, 1);
INSERT INTO `iot_device` VALUES (120, '￥温湿度计', 66, '￥MODBUS协议产品', 1, 'admin', 1, 'admin', 'D4AD203F3A1C_2', 'D4AD203F3A1C', 1.00, 4, 0, 0, 1, NULL, ' 本机地址', '127.0.0.1', 103.802435, 25.496407, '2023-03-23 00:00:00', NULL, NULL, '0', '', '2023-02-28 16:49:17', '', '2023-09-25 16:19:30', NULL, NULL, 2);
INSERT INTO `iot_device` VALUES (121, '￥电量仪', 66, '￥MODBUS协议产品', 1, 'admin', 1, 'admin', 'D4AD203F3A1C_11', 'D4AD203F3A1C', 1.00, 4, 0, 0, 1, NULL, ' 本机地址', '127.0.0.1', 103.802435, 25.496407, '2023-03-23 00:00:00', NULL, NULL, '0', '', '2023-02-28 16:49:17', '', '2023-09-25 16:19:30', NULL, NULL, 11);
INSERT INTO `iot_device` VALUES (140, '￥视频监控', 88, '￥视频监控产品', 1, 'admin', 1, 'admin', '11010200001320000001', NULL, 1.00, 4, 0, 0, 1, NULL, '广东省 移通', '120.231.214.134', NULL, NULL, '2023-04-11 21:14:16', '{\"port\": 5060, \"firmware\": \"V5.7.4\", \"transport\": \"UDP\", \"streammode\": \"UDP\", \"hostaddress\": \"192.168.2.119:5060\", \"manufacturer\": \"Hikvision\"}', NULL, '0', '', '2023-04-11 21:12:35', '', '2023-04-11 22:11:01', NULL, 0, NULL);

-- ----------------------------
-- Table structure for iot_device_group
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_group`;
CREATE TABLE `iot_device_group`  (
  `device_id` bigint(20) NOT NULL COMMENT '设备ID',
  `group_id` bigint(20) NOT NULL COMMENT '分组ID',
  PRIMARY KEY (`device_id`, `group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备分组' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备定时' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_device_job
-- ----------------------------
INSERT INTO `iot_device_job` VALUES (4, 'P', 'DEFAULT', '0 08 11 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'admin', '2023-04-15 11:08:37', '', NULL, '', 108, 'D1ELV3A5TOJS', '★温湿度开关', 0, '[{\"id\": \"gear\", \"name\": \"运行档位\", \"type\": 2, \"value\": \"2\", \"deviceId\": 108, \"deviceName\": \"★温湿度开关\"}]', 1, 41, '★智能开关产品', NULL, NULL, NULL);
INSERT INTO `iot_device_job` VALUES (5, '告警定时触发', 'DEFAULT', '0 13 11 ? * 1,2,3,4,5,6,7', '2', '1', '0', '', '2023-04-15 11:14:06', '', NULL, '', NULL, NULL, '告警定时触发', 0, '[{\"id\": \"gear\", \"name\": \"运行档位\", \"type\": 2, \"value\": \"1\", \"productId\": 96, \"productName\": \"★网关产品\"}]', 2, 96, '★网关产品', NULL, 50, '{\"id\": \"temperature\", \"name\": \"空气温度\", \"type\": 1, \"jobId\": 0, \"value\": \"1\", \"params\": {}, \"source\": 2, \"status\": 1, \"alertId\": 50, \"operator\": \"=\", \"isAdvance\": 0, \"productId\": 96, \"productName\": \"★网关产品\", \"cronExpression\": \"0 13 11 ? * 1,2,3,4,5,6,7\"}');

-- ----------------------------
-- Table structure for iot_device_log
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_log`;
CREATE TABLE `iot_device_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备监测信息ID',
  `identity` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符',
  `model_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型名称',
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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `iot_device_log_index_serial_number`(`serial_number`) USING BTREE,
  INDEX `iot_device_log_index_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_device_log_index_user_id`(`user_id`) USING BTREE,
  INDEX `iot_device_log_index_device_id`(`device_id`) USING BTREE,
  INDEX `index_serialNumber_createTime`(`serial_number`, `create_time`) USING BTREE,
  INDEX `index_isMonitor_serialNumber_createTime`(`serial_number`, `is_monitor`, `create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_device_log
-- ----------------------------

-- ----------------------------
-- Table structure for iot_device_template
-- ----------------------------
DROP TABLE IF EXISTS `iot_device_template`;
CREATE TABLE `iot_device_template`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `product_id` bigint(20) NULL DEFAULT NULL COMMENT '产品id',
  `template_id` bigint(20) NULL DEFAULT NULL COMMENT '采集点模板id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '设备采集点模板关联对象' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_device_template
-- ----------------------------
INSERT INTO `iot_device_template` VALUES (2, 112, 1);
INSERT INTO `iot_device_template` VALUES (3, 118, 4);
INSERT INTO `iot_device_template` VALUES (4, 120, 6);
INSERT INTO `iot_device_template` VALUES (5, 121, 1);
INSERT INTO `iot_device_template` VALUES (7, 123, 11);
INSERT INTO `iot_device_template` VALUES (33, 119, 2);
INSERT INTO `iot_device_template` VALUES (34, 121, 3);
INSERT INTO `iot_device_template` VALUES (35, 122, 3);
INSERT INTO `iot_device_template` VALUES (36, 125, 6);
INSERT INTO `iot_device_template` VALUES (38, 127, 7);
INSERT INTO `iot_device_template` VALUES (39, 128, 1);

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
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户物模型权限，多个以英文逗号分隔',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`device_id`, `user_id`) USING BTREE,
  INDEX `iot_device_user_index_user_id`(`user_id`) USING BTREE,
  INDEX `iot_device_user_index_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_device_user
-- ----------------------------
INSERT INTO `iot_device_user` VALUES (108, 1, 1, 'admin', '★温湿度开关', '15888888888', 'admin', 1, NULL, '0', '', '2023-02-25 23:15:57', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (109, 1, 1, 'admin', '★网关设备', '15888888888', 'admin', 1, NULL, '0', '', '2023-02-25 23:17:32', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (109, 3, 1, 'admin', '★网关设备', '15888888881', 'fastbee-t2', 0, 'ota,timer,log,monitor,statistic,reset,gear,switch', '0', '', '2023-09-03 01:17:03', '', '2023-09-03 11:05:06', NULL);
INSERT INTO `iot_device_user` VALUES (109, 7, 1, 'admin', '★网关设备', '18257292958', 'shenzehui', 0, NULL, '0', '', '2023-08-24 08:26:34', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (109, 8, 1, 'admin', '★网关设备', '15752221201', 'shadow', 0, NULL, '0', '', '2023-08-24 08:25:44', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (118, 1, 1, 'admin', '￥MODBUS网关设备', '15888888888', 'admin', 1, NULL, '0', '', '2023-02-28 16:49:18', '', NULL, NULL);
INSERT INTO `iot_device_user` VALUES (140, 1, 1, 'admin', '￥视频监控', '15888888888', 'admin', 1, NULL, '0', '', '2023-04-11 21:12:37', '', NULL, NULL);

-- ----------------------------
-- Table structure for iot_event_log
-- ----------------------------
DROP TABLE IF EXISTS `iot_event_log`;
CREATE TABLE `iot_event_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备事件日志ID',
  `identity` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符',
  `model_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型名称',
  `log_type` tinyint(1) NOT NULL COMMENT '类型（3=事件上报，5=设备上线，6=设备离线）',
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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_event_log
-- ----------------------------

-- ----------------------------
-- Table structure for iot_function_log
-- ----------------------------
DROP TABLE IF EXISTS `iot_function_log`;
CREATE TABLE `iot_function_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备功能日志ID',
  `identify` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '标识符',
  `fun_type` int(2) NOT NULL COMMENT '1==服务下发，2=属性获取，3.OTA升级',
  `fun_value` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '日志值',
  `message_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '消息id',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '设备名称',
  `serial_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '设备编号',
  `mode` int(2) NULL DEFAULT NULL COMMENT '模式(1=影子模式，2=在线模式，3=其他)',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `result_msg` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '下发结果描述',
  `result_code` int(3) NULL DEFAULT NULL COMMENT '下发结果代码',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `show_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '显示值',
  `model_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '物模型名称',
  `reply_time` datetime NULL DEFAULT NULL COMMENT '设备回复时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `iot_function_log_id_uindex`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '设备服务下发日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_function_log
-- ----------------------------

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`group_id`) USING BTREE,
  INDEX `iot_group_index_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备分组' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_group
-- ----------------------------
INSERT INTO `iot_group` VALUES (2, '卧室', 2, 1, 'admin', '0', '', '2021-12-29 13:12:42', '', '2023-04-09 22:37:06', '卧室设备');
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
  `protocol_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '协议编号',
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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `transport` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品支持的传输协议',
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `iot_product_index_category_id`(`category_id`) USING BTREE,
  INDEX `iot_product_index_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_product
-- ----------------------------
INSERT INTO `iot_product` VALUES (41, '★智能开关产品', 'JSON', 1, '电工照明', 1, 'admin', 1, 0, 'FastBee', 'P47T6OD5IPFWHUM6', 'KX3TSH4Q4OS835DO', 2, '{\"events\": [{\"id\": \"exception\", \"name\": \"设备发生异常\", \"type\": 3, \"order\": 0, \"regId\": \"exception\", \"isChart\": 0, \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"height_temperature\", \"name\": \"环境温度过高\", \"type\": 3, \"order\": 0, \"regId\": \"height_temperature\", \"isChart\": 0, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}], \"functions\": [{\"id\": \"report_monitor\", \"name\": \"上报数据\", \"type\": 2, \"order\": 10, \"regId\": \"report_monitor\", \"isChart\": 0, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"message\", \"name\": \"屏显消息\", \"type\": 2, \"order\": 7, \"regId\": \"message\", \"isChart\": 0, \"datatype\": {\"type\": \"string\", \"maxLength\": 1024}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"light_color\", \"name\": \"灯光色值\", \"type\": 2, \"order\": 5, \"regId\": \"light_color\", \"isChart\": 0, \"datatype\": {\"type\": \"array\", \"arrayType\": \"integer\", \"arrayCount\": \"3\"}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"switch\", \"name\": \"设备开关\", \"type\": 2, \"order\": 9, \"regId\": \"switch\", \"isChart\": 0, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"reset\", \"name\": \"设备重启\", \"type\": 2, \"order\": 6, \"regId\": \"reset\", \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"重启\", \"value\": \"restart\"}]}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"irc\", \"name\": \"射频遥控\", \"type\": 2, \"order\": 11, \"regId\": \"irc\", \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"遥控学习\", \"value\": \"FFXX01\"}, {\"text\": \"遥控清码\", \"value\": \"FFXX02\"}, {\"text\": \"打开开关\", \"value\": \"FFXX03\"}, {\"text\": \"关闭开关\", \"value\": \"FFXX04\"}, {\"text\": \"暂停\", \"value\": \"FFXX05\"}, {\"text\": \"锁定\", \"value\": \"FFXX06\"}]}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"gear\", \"name\": \"运行档位\", \"type\": 2, \"order\": 8, \"regId\": \"gear\", \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"showWay\": \"select\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"status\", \"name\": \"上报状态\", \"type\": 2, \"order\": 12, \"regId\": \"status\", \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"更新状态\", \"value\": \"update_status\"}]}, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}], \"properties\": [{\"id\": \"co2\", \"name\": \"二氧化碳\", \"type\": 1, \"order\": 2, \"regId\": \"co2\", \"isChart\": 1, \"datatype\": {\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}, \"isHistory\": 1, \"isMonitor\": 1, \"isReadonly\": 1}, {\"id\": \"brightness\", \"name\": \"室内亮度\", \"type\": 1, \"order\": 4, \"regId\": \"brightness\", \"isChart\": 1, \"datatype\": {\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}, \"isHistory\": 1, \"isMonitor\": 1, \"isReadonly\": 1}, {\"id\": \"temperature\", \"name\": \"空气温度\", \"type\": 1, \"order\": 1, \"regId\": \"temperature\", \"isChart\": 1, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isHistory\": 1, \"isMonitor\": 1, \"isReadonly\": 1}, {\"id\": \"humidity\", \"name\": \"空气湿度\", \"type\": 1, \"order\": 3, \"regId\": \"humidity\", \"isChart\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isHistory\": 1, \"isMonitor\": 1, \"isReadonly\": 1}]}', 1, 1, 3, NULL, '0', '', '2025-08-14 00:06:33', '', '2023-09-25 22:58:17', NULL, 'MQTT');
INSERT INTO `iot_product` VALUES (55, '★网关产品', 'JSON', 1, '电工照明', 1, 'admin', 1, 0, 'FastBee', 'P467433O1MT8MXS2', 'KWF32S3H95LH14LO', 2, '{}', 2, 2, 3, NULL, '0', '', '2025-02-25 22:51:39', '', '2023-09-16 11:46:43', NULL, 'MQTT');
INSERT INTO `iot_product` VALUES (66, '￥MODBUS协议产品', 'MODBUS-RTU', 1, '电工照明', 1, 'admin', 1, 0, 'FastBee', 'P6JPN3V4PRZA91W8', 'KJVHI708452TMIS0', 2, '{}', 2, 1, 3, NULL, '0', '', '2023-02-28 16:40:13', '', NULL, NULL, 'MQTT');
INSERT INTO `iot_product` VALUES (88, '￥视频监控产品', NULL, 2, '家居安防', 1, 'admin', 1, 0, 'FastBee', 'P0IB9M8A7J4R056V', 'K69914VL8175ZY21', 2, '{}', 3, 1, 3, NULL, '0', '', '2023-04-11 21:11:54', '', NULL, NULL, 'GB28181');
INSERT INTO `iot_product` VALUES (130, 'TCP测试设备', 'JSON', 1, '电工照明', 1, 'admin', 1, 0, 'FastBee', 'P385PS3059I8S5EL', 'KHP44MH2X75GLGA8', 2, '{\"functions\": [{\"id\": \"status\", \"name\": \"上报状态\", \"type\": 2, \"order\": 0, \"regId\": \"status\", \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"更新状态\", \"value\": \"update_status\"}]}, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}]}', 1, 1, 3, '', '0', '', '2023-09-19 11:22:44', '', NULL, NULL, 'TCP');

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
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`authorize_id`) USING BTREE,
  INDEX `iot_product_authorize_index_product_id`(`product_id`) USING BTREE,
  INDEX `iot_product_authorize_index_device_id`(`device_id`) USING BTREE,
  INDEX `iot_product_authorize_index_serial_number`(`serial_number`) USING BTREE,
  INDEX `iot_product_authorize_index_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品授权码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_product_authorize
-- ----------------------------

-- ----------------------------
-- Table structure for iot_protocol
-- ----------------------------
DROP TABLE IF EXISTS `iot_protocol`;
CREATE TABLE `iot_protocol`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `protocol_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '协议编码',
  `protocol_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '协议名称',
  `protocol_file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '协议jar包,js包，c程序上传地址',
  `protocol_type` int(11) NOT NULL DEFAULT 0 COMMENT '协议类型 0:未知 1:jar，2.js,3.c',
  `jar_sign` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '协议文件摘要(文件的md5)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `protocol_status` int(11) NOT NULL DEFAULT 0 COMMENT '0:草稿 1:启用 2:停用',
  `del_flag` int(11) NOT NULL DEFAULT 0 COMMENT '0:正常 1:删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UNIQUE_CODE`(`protocol_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '协议表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_protocol
-- ----------------------------
INSERT INTO `iot_protocol` VALUES (1, 'JSON', 'JSON协议', '/', 0, '系统内置JSON编解码协议', '2023-03-01 05:46:43', '2023-04-10 14:42:12', 1, 0);
INSERT INTO `iot_protocol` VALUES (2, 'MODBUS-RTU', 'ModbusRtu协议', '/', 0, '系统内置ModbusRtu编解码协议(商业版本支持更多非标协议)', '2023-03-01 05:52:33', '2023-04-09 15:58:59', 1, 0);
INSERT INTO `iot_protocol` VALUES (3, 'JSONOBJECT-CHENYI', 'JSON-Data协议', '', 0, '系统内置JSONObject编解码协议', '2023-08-23 01:31:39', '2023-08-23 01:31:39', 1, 0);
INSERT INTO `iot_protocol` VALUES (4, 'JSONOBJECT', 'JSONObject协议', '', 0, '系统内置JSONObject编解码协议', '2023-08-23 01:31:39', '2023-08-23 01:31:39', 1, 0);
INSERT INTO `iot_protocol` VALUES (5, '商业版非标协议', '商业版本支持更多非标协议', '', 0, '商业版本支持更多非标协议', '2023-08-23 01:31:39', '2023-08-23 01:31:39', 1, 0);

-- ----------------------------
-- Table structure for iot_scene
-- ----------------------------
DROP TABLE IF EXISTS `iot_scene`;
CREATE TABLE `iot_scene`  (
  `scene_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '场景ID',
  `scene_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '场景名称',
  `chain_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则名称',
  `enable` tinyint(1) NULL DEFAULT NULL COMMENT '场景状态（1-启动，2-停止）',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `silent_period` int(20) NULL DEFAULT NULL COMMENT '静默周期（分钟）',
  `cond` tinyint(2) NULL DEFAULT NULL COMMENT '执行条件（1=或、任意条件，2=且、所有条件，3=非，不满足）',
  `execute_mode` tinyint(1) NULL DEFAULT NULL COMMENT '执行方式（1=串行，顺序执行，2=并行，同时执行）',
  `execute_delay` int(10) NULL DEFAULT NULL COMMENT '延时执行（秒钟）',
  `has_alert` tinyint(1) NULL DEFAULT 0 COMMENT '是否包含告警推送（1=包含，2=不包含）',
  `application_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用名称',
  `el_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '规则数据',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`scene_id`) USING BTREE,
  INDEX `iot_scene_index_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场景联动' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_scene
-- ----------------------------

-- ----------------------------
-- Table structure for iot_scene_script
-- ----------------------------
DROP TABLE IF EXISTS `iot_scene_script`;
CREATE TABLE `iot_scene_script`  (
  `script_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '脚本ID',
  `scene_id` bigint(20) NOT NULL COMMENT '场景ID',
  `source` tinyint(1) NOT NULL COMMENT '触发源（1=设备触发，2=定时触发，3=产品触发,4=告警执行）',
  `script_purpose` tinyint(1) NOT NULL COMMENT '脚本用途(1=数据流，2=触发器，3=执行动作)',
  `product_id` bigint(20) NULL DEFAULT NULL COMMENT '产品ID（用于获取对应物模型）',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型标识符',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型名称',
  `value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物模型值',
  `operator` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作符',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '物模型类别（1=属性，2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线）',
  `device_count` int(20) NULL DEFAULT NULL COMMENT '设备数量',
  `job_id` bigint(20) NULL DEFAULT NULL COMMENT '任务ID',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `is_advance` tinyint(1) NULL DEFAULT NULL COMMENT '是否详细corn表达式（1=是，0=否）',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父物模id',
  `parent_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父物模名称',
  `array_index` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数组索引',
  `array_index_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数组索引名称',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`script_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '场景脚本' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_scene_script
-- ----------------------------

-- ----------------------------
-- Table structure for iot_script
-- ----------------------------
DROP TABLE IF EXISTS `iot_script`;
CREATE TABLE `iot_script`  (
  `script_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '脚本ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `scene_id` bigint(64) NOT NULL DEFAULT 0 COMMENT '关联场景ID',
  `product_id` bigint(20) NULL DEFAULT NULL COMMENT '产品ID',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `script_event` tinyint(1) NOT NULL COMMENT '脚本事件(1=设备上报，2=平台下发，3=设备上线，4=设备离线)',
  `script_action` tinyint(1) NOT NULL COMMENT '脚本动作(1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储)',
  `script_purpose` tinyint(1) NOT NULL COMMENT '脚本用途(1=数据流，2=触发器，3=执行动作)',
  `script_order` tinyint(1) NOT NULL DEFAULT 0 COMMENT '脚本执行顺序，值越大优先级越高',
  `application_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用名，后端、规则和脚本要统一',
  `script_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '脚本名',
  `script_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '脚本数据',
  `script_type` char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '脚本类型：\r\nscript=普通脚本，\r\nswitch_script=选择脚本，\r\nif_script=条件脚本，\r\nfor_script=数量循环脚本，\r\nwhile_script=条件循环，\r\nbreak_script=退出循环脚本',
  `script_language` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '脚本语言（groovy | qlexpress | js | python | lua | aviator | java）',
  `enable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否生效（0-不生效，1-生效）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`script_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '规则引擎脚本' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_script
-- ----------------------------
INSERT INTO `iot_script` VALUES ('D1782337038486474752', 1, 'admin', 0, 41, '★智能开关产品', 1, 1, 1, 1, 'fastbee', '消息转发规则', 'import cn.hutool.json.JSONArray;\nimport cn.hutool.json.JSONObject;\nimport cn.hutool.json.JSONUtil;\nimport cn.hutool.core.util.NumberUtil;\n\n\n\n\n\n//系统主题\nString sysTopic = \'\';\n//系统数据格式\nString sysPayload = \'\';\n\n// 1. 获取主题和内容\nString name = msgContext.getTopic();\nLong productId = msgContext.getProductId();\nString serialNumber = msgContext.getSerialNumber();\nString protocolCode = msgContext.getProtocolCode();\nString payload = msgContext.getPayload();\nSystem.out.println(\"产品id/协议编号：\" + productId + \" / \" + protocolCode);\n\n// 2. 转换为系统主题 /96/D1ELV3A5TOJS/property/post\nsysTopic = \"/\" + productId + \"/\" + serialNumber + \"/property/post\" \n\nif(\"JSON\".equals(protocolCode)){   \n    // 3. 内容格式转换\n    JSONArray newArray = new JSONArray();\n    JSONObject jsonObject = JSONUtil.parseObj(payload);\n    jsonObject.keySet().forEach(key -> {\n        JSONObject newObject =new JSONObject();\n        newObject.put(\"id\" , key);\n        newObject.put(\"value\" , jsonObject.getStr(key));\n        newArray.add(newObject);\n    });\n    sysPayload = newArray.toString();\n}else{\n    //其他协议处理\n}\n\n// 4.打印\nSystem.out.println(\"新主题：\" + sysTopic);\nSystem.out.println(\"新内容：\" + sysPayload);\n\n// 5. 返回新的数据（必要）\nmsgContext.setTopic(sysTopic);\nmsgContext.setPayload(sysPayload);\n', 'script', 'groovy', 1, '0', '', '2024-04-22 17:13:59', '', '2024-04-23 15:32:43', NULL);

-- ----------------------------
-- Table structure for iot_social_platform
-- ----------------------------
DROP TABLE IF EXISTS `iot_social_platform`;
CREATE TABLE `iot_social_platform`  (
  `social_platform_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '第三方登录平台主键',
  `platform` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方登录平台',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT ' 0:启用 ,1:禁用',
  `client_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方平台申请Id',
  `secret_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方平台密钥',
  `redirect_uri` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户认证后跳转地址',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记位(0代表存在，1代表删除)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bind_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '绑定注册登录uri,http://localhost/login?bindId=',
  `redirect_login_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '跳转登录uri,http://localhost/login?loginId=',
  `error_msg_uri` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '错误提示uri,http://localhost/login?errorId=',
  PRIMARY KEY (`social_platform_id`) USING BTREE,
  UNIQUE INDEX `iot_social_platform_platform_uindex`(`platform`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方登录平台控制' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_social_platform
-- ----------------------------
INSERT INTO `iot_social_platform` VALUES (1, 'QQ', '0', '102005066', 'PhkaBYgZ99999', 'https://iot.wumei.live/auth/callback/qq', '0', 'admin', '2022-04-18 11:21:28', '2022-04-20 16:29:23', 'admin', NULL, 'http://localhost/login?bindId=', 'http://localhost/login?loginId=', 'http://localhost/login?errorId=');
INSERT INTO `iot_social_platform` VALUES (2, 'wechat_open_web', '0', 'wxd8e66af0d2ac0b9d', 'c1172c438d407d8ebce2ac0e314a18db', 'https://81.71.97.58/prod-api/auth/callback/wechat_open_web', '0', 'admin', '2023-08-23 11:41:37', '2023-09-14 17:16:25', 'admin', NULL, 'https://81.71.97.58/login?bindId=', 'https://81.71.97.58/login?loginId=', 'https://81.71.97.58/login?errorId=');
INSERT INTO `iot_social_platform` VALUES (3, 'wechat_open_mobile', '0', 'wx6be3f0d7bf7154e1', 'b6c1d0da60bd5250857d211cdc64fdc9', 'http://localhost', '0', 'admin', '2023-08-28 14:21:29', NULL, NULL, NULL, 'http://localhost', 'http://localhost', 'http://localhost');
INSERT INTO `iot_social_platform` VALUES (4, 'wechat_open_mini_program', '0', 'wx5bfbadf52adc17f3', '1faddfc3fa6ab2f9ce937f41fcfc7c52', 'http://localhost', '0', 'admin', '2023-09-12 15:39:48', NULL, NULL, NULL, 'http://localhost', 'http://localhost', 'http://localhost');

-- ----------------------------
-- Table structure for iot_social_user
-- ----------------------------
DROP TABLE IF EXISTS `iot_social_user`;
CREATE TABLE `iot_social_user`  (
  `social_user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '第三方系统用户表主键',
  `uuid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方系统的唯一ID',
  `source` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方用户来源',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户的授权令牌',
  `expire_in` int(11) NULL DEFAULT NULL COMMENT '第三方用户的授权令牌的有效期（部分平台可能没有）',
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '刷新令牌(部分平台可能没有)',
  `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户的 open id（部分平台可能没有）',
  `uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户的 ID(部分平台可能没有)',
  `access_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息（部分平台可能没有）',
  `union_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户的 union id(部分平台可能没有)',
  `scope` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户授予的权限(部分平台可能没有)',
  `token_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个别平台的授权信息（部分平台可能没有）',
  `id_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'id token（部分平台可能没有）',
  `mac_algorithm` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性（部分平台可能没有）',
  `mac_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小米平台用户的附带属性(部分平台可能没有)',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户的授权code（部分平台可能没有）',
  `oauth_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性(部分平台可能没有)',
  `oauth_token_secret` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Twitter平台用户的附带属性(部分平台可能没有)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记位(0代表存在,2代表删除)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '绑定状态(0:未绑定,1:绑定)',
  `sys_user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `gender` tinyint(4) NULL DEFAULT NULL COMMENT '用户性别',
  `source_client` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方用户来源客户端（web、app、小程序）',
  PRIMARY KEY (`social_user_id`) USING BTREE,
  UNIQUE INDEX `iot_social_user_pk`(`social_user_id`) USING BTREE,
  UNIQUE INDEX `iot_social_user_unique_key`(`uuid`, `source`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 211 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方登录用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_social_user
-- ----------------------------
INSERT INTO `iot_social_user` VALUES (1, 'ojefY6BdTpoXOLjdpsFQXWixAG_Q', 'WECHAT_OPEN', '71_7qVQ56lx6qdC7mmArXFwQD8Nl6BTjayw4HJdfHdPoXS0sEHDffiSYa4k8dIK7XG7puk2asZ0s0Rj_Pk8ahqdDQICL4FumjWmXHm3ql2si-M', 7200, '71_rh7a79t0eJmC0JyJrQjABF3zZdkNhP7oAUm3Jj6Rk1skL_i4V3ITlM3ViYO0PA_NCKn9ba85pz2vttdloreR0lWmUxK-VOm3XaMt33vZ9a0', 'ojefY6BdTpoXOLjdpsFQXWixAG_Q', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-23 11:48:04', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/dNibaEkibxjJZSffkH5gQKtCg0pqfz39PGbPcQ8IhADianIaEYqibvD2JhrxYLMeQexBGVR6VOl9MR4gtsYiaxEqPFA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (2, 'ojefY6Pny526TwBwsyfUhzBB_szg', 'WECHAT_OPEN', '71_HlBJGUovm8cvZoEljoFkrAbRXtqt3mWNqxEOfMGsse-2Sie51YjkfJQbrSZySyIsf9sYTIwXj7EjbPO5GciN_xqEsSRCzyG6qIvUvkyNIBs', 7200, '71_Bc5n4-MS-25vBkt8p8BAxeuAZBawwmx4ryi-KCJxzi0OKY73HinwKYRTPZaw08kXgpD6zToRAjqIoRuyt-mNwEgfeN50hW8Unk5NuK4Bdpo', 'ojefY6Pny526TwBwsyfUhzBB_szg', NULL, NULL, 'oL1Fu589vTytNQy2okIKQnKBUmRU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-24 08:22:53', 'System', NULL, NULL, '0', '0', NULL, '🌲', '🌲', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLTLicc0w6SgPWibR5Z92j9AdW9aC4QxuFjQcJXcekbjc13fkHD7iaZc7CwEHtUq9FQalub6vOZ46LZA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (3, 'ojefY6AZPO1PPy9K4tWd8xdLWUss', 'WECHAT_OPEN', '71_x8HU8YdqqKMXts7KJ3T0hLOvmlP5YIi0pkTQ9bLA8vRusmEEUQFKyBpbG2UAFRDMEJvpp6cKGh9EGkiRdj7zSA4aHP2r-luXHSkAhP7zyvU', 7200, '71_AFMUcIv8tP4PGiHrOwJVN0B8bpCGyKXuG8ZCDiVGF5zaG10MTTLTmTJXNHJHmZzs3h6X9kbLY8sukNk83uj3QI3_J5SGOtihOUNMa9g7Ir0', 'ojefY6AZPO1PPy9K4tWd8xdLWUss', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-24 09:41:51', 'System', '2023-08-24 10:36:16', 'System', '0', '0', NULL, 'oh', 'oh', 'https://thirdwx.qlogo.cn/mmopen/vi_32/RNia2ASTn210r40Tb91yfWgmiaWXGPXF7rNnic5lkes9avGbZQ0365uZObT1JicIQpiba7MDuHicScKUxnYWWyTN5VAw/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (4, 'ojefY6JUjFaO7RBRqgcrRGLxPVFA', 'WECHAT_OPEN', '71_qkQqwgA9RYmL5oQASwBxwwR4loysQQc3YRqGJRJONSxpNrPLlLdNibDk5YINFYjfnCxwnhjVPQqhX7xHaGE_UZMX5e1JaWKCJdrgwP62LxY', 7200, '71_oEKp3JLiEtv5668rprSxidUBbcd30cZQ2Bbt_tL5XdWQX52Yb3po5t5ynFwlA4n-7dLt5rGR3E1FKb9Qw8Xso8SfSfF-4CBF9ZCjSxppIvI', 'ojefY6JUjFaO7RBRqgcrRGLxPVFA', NULL, NULL, 'oL1Fu55Rkr9A69wS6buTQz7zdkDc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-24 09:58:59', 'System', NULL, NULL, '0', '0', NULL, 'shadow 张', 'shadow 张', 'https://thirdwx.qlogo.cn/mmopen/vi_32/EcUsiaR4Y1WkyibJXHDEPAiazbERr1BXAnzZWjh2SiayuawoEaT0icDzL2dZtuu0ia6Z7AJZZbiaxDJb8iaJxTnyk7Xicgw/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (5, 'ojefY6I66aL78LElFNjsA_rY7JIE', 'WECHAT_OPEN', '71_sanZ8NfbnEANzqUTQQAY6CRoafcBaV1eS4KPtcAv_rkOlunJQyVeJJzFbXSge3QxsCvljt65TTpyiLSifSjADJdaSZGtKzhF7IXlo5km2Po', 7200, '71_JbHfJV6zy02mK8ZnCKA3Yyhe2upHOqeah6IeZxzO3CKVAcOqH7CGbsk9GFsK3bqDD1SF8jp05ncC8XfkzR5BS4A3s_QIQjt44bviFckymtE', 'ojefY6I66aL78LElFNjsA_rY7JIE', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-24 11:49:31', 'System', '2023-08-24 14:10:29', 'System', '0', '0', NULL, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/tgaqAZ2oTMAZfF4cHRPib77yOLRSv9ibPibQfkQiclB8kwBuicB3vDcLfTnfU6HWZRNRqjmSXjWYYY5fNdOAR8CSxzg/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (6, '71420ce6-5300-4495-92da-6d1a4a7e2fdd', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:32:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (7, '6ec4d0be-bde5-466b-b3cf-5b3736d15ba7', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:40:17', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (8, 'ac2d836d-29fe-4e01-9f3d-bc54d4168855', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:45:52', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (9, 'ef2510ab-8fdd-4433-b0ff-1b57ef2f0fa9', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:47:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (10, 'b7c2ee2f-d644-46b9-812d-104b1d122fe0', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:50:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (11, '214e90ab-5b09-4aec-a6d1-4100c21db1b6', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:51:42', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (12, 'a23aec75-40df-4878-b33f-a1aacc6b45f6', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:53:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (13, '37de2b33-e690-40f6-a981-fc7182503606', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:00:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (14, '8c1e964e-9bb8-4876-bc92-6a41faaf2097', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:09:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (15, 'a7b77ebb-0815-4983-b0ad-b9b2a37593ca', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:09:59', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (16, '0ee69f21-448a-420f-a092-68418ae96c01', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:10:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (17, '0c928db4-03b5-40c9-9971-3b13d39ba4b8', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:11:41', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (18, '8f0daa3d-f332-423b-ad37-95e740a109e8', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:12:44', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (19, 'd15e0ae9-f49d-4e55-9965-79e260e8ffd0', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:13:33', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (20, 'b4da93b9-21c7-4e76-937b-2162024a9c6c', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:14:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (21, 'a16423aa-99ce-427e-89cf-a9f13955acec', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:15:54', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (22, '7771c72d-741f-4f66-bec4-414471ebb5db', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:16:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (23, '9def0641-b670-45cc-8297-6c3171f12025', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:17:36', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (24, 'e8f70c8b-bc52-4b38-aaf7-6a8df9ffb8cd', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:18:23', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (25, 'a359a333-4348-4786-973e-f15b9fa6ce94', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:19:15', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (26, '061154f9-ac4b-4035-a549-cd602422427a', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:19:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (27, '10003d18-0b00-458d-966e-3a54b218c83b', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:21:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (28, '376f2a15-662d-4820-bb62-683dd555fdbf', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:24:01', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (29, 'd4e4fe18-1f99-4361-b509-e464fdc806a2', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:24:42', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (30, '7b37261c-b420-45d5-8cd0-7ab6e4787621', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:25:17', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (31, '7635bed2-0d6e-4924-b9d7-af0235fc2ecc', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:25:26', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (32, '6aa3715d-b3a6-4b12-8bb4-1fc3af297d99', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:26:09', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (33, '0222ba55-f5a8-4218-a23d-949ecc78c405', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:26:52', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (34, '0bb2118c-b365-4dae-943e-84e0f8dca104', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:27:50', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (35, '5c065548-d171-44b8-a5bb-b93db08b22b3', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:28:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (36, '79429286-c4c7-4db8-9902-6f10ffd26e06', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:28:53', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (37, '4eb61991-8715-427b-b6a1-6e479f3faafc', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:29:44', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (38, 'cbcf9cfb-109f-4806-9bd0-5e9a4ba0c108', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:30:33', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (39, '810f0806-21e0-487b-b2fe-c9d037b20c81', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:31:28', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (40, '7da601d4-765c-40bf-aa2d-96bdef88c9ff', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:32:23', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (41, 'e3e29354-d06b-4d18-b172-a86e563a20f1', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:33:16', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (42, 'c73ece08-7a9e-462f-ad04-e5a5ce05a8b5', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:33:47', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (43, '7b48faf5-b023-46d7-9332-8ead5d82895e', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:34:27', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (44, 'aa8db705-654d-43d9-8ec2-3b090bb9685d', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:35:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (45, 'b3f319a4-a4aa-48bd-9a43-ff03b09e9b0f', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:36:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (46, '297e229a-545e-47a1-8acd-85708430d78d', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:37:10', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (47, '74d77e94-a9c2-4fca-9b47-e1c7ea0ab419', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:37:45', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (48, '0a750c6d-2e14-4e12-bd11-5ae390b04451', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:57:10', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (49, '6b353153-2eb0-4916-ad83-f5465ccd4480', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:57:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (50, '10be370a-38e0-4de4-822b-e6b1a07f0ff2', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 11:47:28', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (51, '8634fc78-e8d0-447f-af90-51fd29536ae4', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:40:06', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (52, '4e49726d-9078-47de-8752-5fac79a5b9b1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:45:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (53, '77e28b94-5f6e-4dda-bc15-a411ce9423e8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:49:07', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (54, '17b87cd8-6a14-4834-9d9e-e4121d563079', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:53:20', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (55, 'b2b7ddc7-6e48-4f24-9d03-8c481b6fc165', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:57:00', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (56, 'c394c827-3f3f-42c3-88db-b5e3edc5a3e8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:58:51', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (57, '16bf6849-9619-4448-9b0f-1ad4a999e33f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:59:47', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (58, '8f19e5f6-e197-4b81-9585-ea3ea655dd2a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:01:56', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (59, '647ce6e6-5aa4-4504-80db-fb1df687c0b6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:03:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (60, '04f69ab8-5a84-495c-8dfa-7f19a1a32c63', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:05:03', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (61, '520bf6de-19a5-4b06-b905-6c61a37a1809', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:06:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (62, 'e70c584c-5d6f-4cdd-9d63-42606b21941f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:07:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (63, 'd85b3a8e-4917-470c-8412-9c7ccbdd26e6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:08:13', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (64, '21e06b88-33cd-4ddc-9d3e-22a0cc79d8ab', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:09:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (65, '70903b36-f5da-4784-8505-9e0ee7842a7c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:10:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (66, '4300b8fb-4d5a-4c83-b45f-f46de9070789', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:11:57', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (67, 'a83706e9-c606-4393-b46c-bd589102fa23', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:14:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (68, '03b705d7-cb9b-4176-ba52-82caee369ee5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:16:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (69, '9c1aa75d-0afe-4d9b-93a4-82ff51476b83', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:18:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (70, 'd5153a89-5dca-4ce1-b225-cdf1f06734b3', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:20:23', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (71, '6f0dc304-3697-4d5e-b6f5-dcae95c6037d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:23:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (72, '1a8d1436-b1fc-4648-8ef3-8986b200f609', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:25:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (73, '87c74066-e8db-4312-ba9c-8d4a58d65b88', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:26:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (74, '7c36eace-b7c5-405f-a2a1-b1fa95d7b526', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:26:36', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (75, '9147f792-55be-4ca6-824d-b8c4a42960b3', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:27:48', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (76, '2183b103-858d-4bb4-9111-83fc8ddf24c1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:34:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (77, '9594b67d-6651-4237-887d-ebadfabc8ca3', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:35:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (78, '60649e01-d220-4bbc-a21c-211ce67bd9a7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:36:29', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (79, '83aa1836-36c5-4e74-aebb-9263843ce8fa', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:36:41', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (80, 'd7dfb927-1f17-41f7-868b-6ee0b8ec2d2f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:40:14', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (81, '9898d830-f0f3-4dbd-a687-a49709b855de', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:42:14', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (82, 'e7a5b6b0-3e50-4892-b4cc-e628fb803be6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:43:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (83, '34454957-3dfd-4819-8930-46daf47d2f81', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:45:03', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (84, '384b5ce9-5bf7-43b0-950d-496737c3a8dd', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:45:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (85, 'dd6de292-124f-44e6-a0fd-057cfeed410c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:46:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (86, 'a370f0b0-fb7f-41cf-a4ed-eafb873cd50b', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:48:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (87, 'bfb06fff-b0bb-43a4-8cf0-bf4f4b3445f6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:50:00', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (88, '53634812-48d2-420a-9e3c-2ac032b5d9cc', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:50:52', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (89, '994f638f-cf08-4846-9630-94bb509ab7db', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:51:27', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (90, '76813df6-4bdd-4add-981e-8e782a3b772a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:52:16', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (91, 'df0c3f75-a865-4621-988d-ec494e9ea407', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:53:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (92, '07f1722d-d9d4-43f7-8f7e-81c6446d7b3f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:57:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (93, '1d91f1b5-a008-446a-ad12-3210e899c55d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:57:50', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (94, '9b0f8585-4432-401a-9ae1-f363a158a133', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:58:27', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (95, '33b73d87-df3c-41b4-8abc-d2c51bf4657e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:59:41', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (96, '08daa4b5-b5e0-4217-8249-d47928afcf82', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:02:57', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (97, 'a1d11647-2316-4636-85ce-a589084c383a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:03:27', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (98, 'c8579e89-0858-4ba7-9e00-f1ea2a208be8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:06:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (99, 'd3837059-b25b-4221-9fd0-aed6f958b8a0', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:07:15', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (100, 'a47efa4b-e840-4e07-a710-459fa9f01e5e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:08:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (101, 'dca0f5d4-df0f-4d95-830e-2ae8aa60a550', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:15:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (102, 'be678468-abc2-48db-b34d-47e81352bf5c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:16:49', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (103, 'ae4265e7-e192-46f5-8a9e-53d6ba6aee3e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:20:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (104, '232a0407-b8f0-40b2-bf70-b368aecc3f48', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:22:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (105, '09aa4d6e-471a-4890-98f1-85ec1f41d16d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:23:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (106, '6dc0c49c-29a6-4292-bb59-d19d3c7dc11f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:23:49', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (107, 'aafb9719-a7e3-4c25-be9f-150fbc4e345d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:25:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (108, 'ce799416-f0a8-4941-9f84-ff3bf5a5ae00', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:26:16', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (109, '38ad0b87-c569-4831-84ea-f45bfb1b06e6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:28:00', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (110, 'a0ee9a9f-6f2f-49a2-80e1-f0976cb115d5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:28:16', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (111, '42b6c87d-a031-4f7e-8670-09672fd00239', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:29:40', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (112, '39812b97-1a6d-4255-ba0f-86e8e6150bf7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:29:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (113, '38df607a-72e4-45c5-9b9a-fda85114e7a8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:30:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (114, '3d1dbb97-c0d4-4790-9bd1-57d2a26c945e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:34:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (115, 'f9544196-41ca-4f54-926e-2f43bd5482ef', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:34:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (116, 'b954f7a1-e544-4ac1-a103-54cfbc9ce982', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:35:13', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (117, '53484323-65ce-4720-91e6-51f81741df2d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:36:26', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (118, 'cae0d43e-f1d9-427a-9e2e-a276848a9e6a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:37:04', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (119, '3d1dd8c7-2d3d-46c7-aec0-8aeae75bd53c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:38:24', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (120, 'd206b8cc-4663-4253-919c-eecbf4bdae2d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:39:14', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (121, '30f22b8a-39f3-4088-a917-e7b0bb315d96', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:40:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (122, 'b58fa0aa-f173-4a25-b245-3eedae47c4bf', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:40:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (123, '6de207b2-2f61-465f-8e2d-7115220cfb0a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:41:10', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (124, 'a2734f2b-41c2-4b5c-a9e7-0301482c2db1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:42:30', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (125, '0142a300-7a9a-4a09-990e-f9d53363168c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:43:54', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (126, 'a1207e54-0e14-424a-a485-9a560bce8058', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:49:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (127, 'cd2425fc-dab4-4f73-bc61-1b9f43920801', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:51:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (128, 'ee27889d-4dbb-4ed0-8184-81d0c56cee06', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:53:38', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (129, 'd85434f8-c11b-438c-890e-8e5732f91a22', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:55:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (130, '0cff5da9-3cd4-4363-80be-c3cccb523a95', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:57:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (131, '58cf157e-c55c-4cf4-90ee-6f9546ea60de', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:58:23', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (132, '3ad40393-bdc1-4cc5-90cb-c40c45737c07', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:59:36', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (133, '268d0dec-0c8c-4017-adf0-c87c7a5705f5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:03:33', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (134, 'a925f086-1f57-4ffc-bb0b-656e27cac343', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:05:28', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (135, '0d344981-1748-4b0c-bd5e-38db0d9d4903', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:07:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (136, '545b520c-d306-4ae9-affa-ead01383de6b', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:07:44', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (137, '2cf65789-0d5a-4a04-a86b-71b4c4632fab', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:08:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (138, '69b4eb4c-89e3-4ff1-ba0a-ec181cfa269e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:11:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (139, 'eae37130-5acb-4a7c-a466-867202b5de22', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:12:07', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (140, '74471c0e-fb55-4545-b23a-944f56a01d9e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:13:54', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (141, '3dc79a1b-6974-4338-a05e-732a08c06d9f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:15:26', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (142, '1bb4277e-05dc-455a-86f1-a4d7a570a7c9', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:21:19', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (143, 'f6c85ba2-6d99-4509-9fce-e32762a3d9fc', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:25:01', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (144, '99f90484-cd36-4caf-b874-64cdec51c973', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:26:24', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (145, '254a881a-36c0-46a8-89c1-47ec0902cc1c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:28:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (146, '40814010-a24d-448f-9841-ea26f75e3d4f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:29:17', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (147, 'b9d31023-b415-4a05-88be-e8f6077ba1c1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:30:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (148, '8d98204f-cc93-4ae7-961a-ffc88f16ad22', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:02:29', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (149, 'cfa57e94-fa7b-4cd7-8b0e-f84c2a32517a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:03:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (150, 'b0742424-3b90-4c92-91b6-da7d0c1042e4', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:04:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (151, '92fb0d86-db06-4bd2-88a6-2c5e5659c2dd', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:10:44', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (152, '157c9ab2-260f-4fc9-953c-244e66a416dc', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:14:04', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (153, '58250a3d-9d20-4c06-a161-b89a5cbe2205', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:17:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (154, '503ec9f6-9c51-494c-abe6-d2025b6d5de8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:23:32', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (155, '7da9ee7e-00f1-400c-9e82-aa756d33c2f7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:25:14', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (156, '576eb582-a62f-4de4-a7c6-5a79d06a317e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:26:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (157, '35fe81bd-a801-411e-a588-83e2073b53d1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:36:01', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (158, '13cc3148-7818-4aae-b404-5aa5b21bcb43', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:37:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (159, 'c667755d-08bf-4575-8763-ece99a8d34ff', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:38:20', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (160, 'e9cb8b8f-0f5a-47f0-ac70-04b75341a2cd', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:40:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (161, '128cb9e9-52a8-4ecc-8b4f-14d0377a9bdb', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:41:53', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (162, 'e71e95b5-4d16-45d4-ad99-c719c971ee4f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:46:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (163, 'c22e9388-e8e1-4965-8689-67d614efa611', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:47:29', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (164, 'f3232bc6-a8d0-48c0-a08f-0f7ad79dfaa1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:48:36', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (165, '0bd9b8c6-bfe6-41f3-80ad-2bad1f56348b', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:51:38', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (166, '4c04dbef-6f2d-48a7-a549-55089038e197', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:53:04', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (167, '2c3b82a0-1cdb-4ccf-80ec-41d49f5c1bcf', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:54:21', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (168, '20d05c1d-c3c2-4f89-8093-44b548165d42', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:55:38', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (169, '6364f00a-44f9-41c6-a462-1edf968fe4e5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:59:29', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (170, '6598c9c5-9e50-432c-aaa2-636e0e8d44f9', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:07:53', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (171, '3909b811-7a5a-46c1-b390-6d21d8857670', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:10:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (172, 'd3da6d29-b931-4f25-ba5b-bd091af19ff5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:21:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (173, '11040fcd-6f8b-470b-aedc-1411b36165c7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:23:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (174, 'c3ac6479-d9c2-4205-a257-abefe814a842', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:26:47', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (175, 'f0cf37ba-eeeb-44ea-a870-8bc74c079d5c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:39:49', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (176, 'babe0cad-db0c-4f07-b478-89f8d89bc197', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:42:21', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (177, 'df2b5aae-e7da-4793-8f42-d7025855208e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:46:08', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (178, '4b6bd295-aa7c-4549-b82f-fd0d8be4a439', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:49:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (179, '2e3ffaa3-d499-46a7-aa1b-b2ae27ef4d32', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:50:20', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (180, '8670c605-1b89-4448-9de3-e4d15a1b0bad', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:52:38', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (181, 'fc90c9b0-c5d1-41b2-be40-1ea9ee2e52f2', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:53:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (182, '4cb82fc7-e322-439d-bd49-59e22b4ba8de', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:55:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (183, '9d4f9fd7-0564-4128-be27-25030761f141', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:58:06', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (184, 'bfe86e54-30e8-4c0c-ae49-497863b73708', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 11:00:58', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (185, '89953f9b-30af-446c-9682-27358d8f4d76', 'WECHAT_OPEN_MOBILE', '72_1zj9L8T0iKDEqORM5reOYHBG3nL_5jbvb3TfFjGQqw5jv9-0YmI02SgOto6PZXZ7Y1R0o8nm5EeJc8bR8547MfZMBbICbasV2YDtW0XbfSQ', 7200, '72_0Ae6bzB8bTMtnrrfuHkNDN37ko1GEOTLsbqbE3tbQAXNHNd6n_7-HIie0v_zC_clqDr4mOmJBOtkvjCzVHDWW7OS0pAdoDUovfy2n-Y7WD8', 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 11:01:17', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/NEJsVswPcQnxDy3UBXcVGIpMwvn2FmJ6I1k5DoNZk0UcZwQEm7lCewbdneEEfCeVkVNXOIQOXw8evKBea5MBdA/132', 0, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (186, '09277a77-53a8-4cf9-8396-0442d33166ab', 'WECHAT_OPEN_MOBILE', '72_StpVhV87sy7cSsbkVoOJyxCdtlD3JxcdxG5vO8vgZ1eR7C2mORJdxYynL9SJR__pD_rdt2IHbfcSIH2Fpw5wh-BVMu3TTKeESp6qD4Nl1go', 7200, '72_LbZu1ZoNlOHPoqHVRROZ_eGiaMHwqRE4dy3xa6QxpbvnlV5mfAiyyiI0wfUYcnCyruuudNtMlW50NBZNcAxBPeBu3TYILuhlA3rYzCgaNqo', 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 11:03:08', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, 'oh', 'oh', 'https://thirdwx.qlogo.cn/mmopen/vi_32/5M4DYfvJP2dlsqQVmiclkxeGZrnnMf7hj6ryUR35INtKBicn7Whq0oPCdcJfotYxslSPGH2d8s2exvIicu8FYDXicg/132', 0, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (187, '79aca6b3-0552-4f19-8720-10efa034834f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:34:42', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (188, 'e4f08938-b416-4713-8c37-a157d006991f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 12:03:46', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (189, '2392005b-1079-4e6b-9625-a295f5e482ec', 'WECHAT_OPEN_MOBILE', '72_Yg_G7_l9nv0ikzJ6Oe7h1q9bz5oU_cJ3TYUMhKxO2ZKudg1bYfhAYygNt95C_qRy_zqiAZVO8jYvxj89iQaRvl5dgKLJl4gAh2GZus6xYfw', 7200, '72_NWbKK4ucUpHoMmLTKSGxTKfMOau99ebYJoWHJkWtVndGLVB6SmwVSwOlavfbh1KHDKqh4RNw28FWl4SauyBCoicugrLnH528z3RyIqrYF9M', 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:14:17', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/NEJsVswPcQnxDy3UBXcVGIpMwvn2FmJ6I1k5DoNZk0UcZwQEm7lCewbdneEEfCeVkVNXOIQOXw8evKBea5MBdA/132', 0, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (190, '13fec398-b9a0-4a3f-b878-bc892a0104b0', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:15:04', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO `iot_social_user` VALUES (191, '338c3d89-a231-4b57-b5f0-cfe3d1f13850', 'WECHAT_OPEN_MOBILE', '72_4DWd6gR3GQIiXPpuagGrM5eILwEO4SfHWJIDwLMqp8I_2FJpBwdNL-Or9UhQ7T8BNKoV0GZ2lh9FaCHk_7LyABY3lmABBpee6Ok4W_KBX08', 7200, '72_iH1rgWvH35a-0O2aXSFSB9qWyXPF_JcChEpn-WFVeFzI1Scfw_1ZxhD8_tEZY5Wk5OMNCqh9WyOKBtO11pL0bUQIWyzYgoPiJHCA2NCrukw', 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:34:45', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, 'oh', 'oh', 'https://thirdwx.qlogo.cn/mmopen/vi_32/5M4DYfvJP2dlsqQVmiclkxeGZrnnMf7hj6ryUR35INtKBicn7Whq0oPCdcJfotYxsla7j7Dvh5eWLLNxttY6gyYA/132', 0, 'wechat_open_mobile');
INSERT INTO `iot_social_user` VALUES (192, 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', 'WECHAT_OPEN', '72_1RLeJ9QnQYJkiMs87FTBBMoK5h9ISBM3XZtPLveA6IetBtyejnDk5c7f-p0mC1RTHLxMkjC-e9KfX8l2y-0XqCPKav_0R20C-Tzbw95wlt0', 7200, '72_lcw1_ihZeBiAUFq4YPt3gc10tRBDMMhLKEsV-f7fZrZkd8xK5-tKbRXaCZL-Cbf4QkPbxnCPWb4svWODgBKMjUXc7g4W4qEkqgNg-4zllss', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 17:16:47', 'System', '2023-09-15 17:23:12', NULL, '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (193, 'bd40330e-9ff0-4c2b-ba00-ff2c3a9cf9e3', 'wechat_open_web', '72_pg1i2Xl9vrW288PCqZybI56qq3-2Yin1o8nvKFAPCRx9OaS8HxJNHUVb6xuG5j_fQdwMecInJYxUpvTTUlJ659DsFOVYrr4RBCTI0sAEqBU', NULL, '72_v0sNSaJQyj8XUCk1bRPIl0A7TB8n4pN0mC807o7YGbPVXugt7aId7RAyb2hi9gsvd0aX2R4vAW-BnDtCTHPm_Un_AkW-mM8SYc44JuxMhOg', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 17:30:40', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (194, 'a8681dc9-f2cc-4316-a6a4-d8d43aa00e19', 'wechat_open_web', '72_44jRuqhWDZYQwgFJMFzJkNRKd3_w0m9npMlL7gv16EoEW2UZy6CbNfy_oSuhqMz28PnUHOJwAyC-Xv--LvNxSePhPu-K-FOajq-1BE10G2o', NULL, '72_wF_NsYq04JgoGpNVvq6EvbZjD7BDDz7XHpGfGA4bT61A_wf3ITbXSFhc57MJUwi_o-HhCfBJ9FnSEBu2nySYkDVTbQ457WZ-ZXDTkwo7OMc', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 18:13:09', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (195, '128d79bf-7573-40c6-bbca-ff5fcf2a0a71', 'wechat_open_web', '72_h2CaZanyW6eeDFw4jybBzdqYKIWBovGeEeB29G6WZEPDtZPiXANNrFRLEMmtd_HGLwv8YwqwBinOVTIxtrjwFcue_x_z9YJlgM5pfJFNHJA', NULL, '72_hK0QOqLAqq-5-0sbwA4_Kqs-nweY_HC0LTaprTL8n_nbZD8wwhPkil5b2-0Sk855gQ47NGTwczEAt-pCt8ZyZwkTEX0gtO6kcRp8Ajz2kew', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 18:13:47', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (196, '698dbf21-8b29-47fa-9946-19a82d067645', 'wechat_open_web', '72_smafRNdslVfgLL-x0nBV5JZO3jT_r3LJBwYw2HJQYpcGe7KKBSSYtIrqpsvVFY75Z7knhMefGlOf9r6s1sH9sjdmAq5EQAOCx2B5QexT3_U', NULL, '72_ongWXQyEHIhXich6claT-7BzZZJbTAb-0dlr245Ee8GO4I9MFplLxa9P5o8qGmgxWhh3h1HvpyYzCyIJ2xxMaS79GhdOhmv6ZJ0dyJN5tsI', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 18:49:36', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (197, 'f0fd123d-b82a-4eb9-a67a-fb81db6b739d', 'wechat_open_web', '72_eexrzOvM96xPvH3Lsl7viBOtnBHFDzFJdIz1d074PJxOhAB9qY0HE-NxnWm67afHT0zphQ4RyVEM1BOohhE32HN_D5yZVcMh24oMrSCPJYg', NULL, '72_W25_phPvOFAfeASpx050O28_pOfgtW0LsnuWYQZI6LIrMeVJnju7FrLTG5xuYG_awhD7crWRzpd-guJs2gZ3ZBVj7bSRtwIgSvgVRfzG0zs', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 11:49:37', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (198, '702797d1-04ef-4374-a618-aa2c3370135c', 'wechat_open_web', '72_BqSILWRpNzD35f9vkga9dMSHQp3bftJMa7eBpOXIepLh7zJVdBMUiPghVRz96hvtuCvvY7CryJtM5yuKx0tU4IJer4ZshmLHSw1Fl7jYtlo', NULL, '72_jJ0WZ-4r18IkeIs0YC6FfCS0QtCk9S5N1cqYeCIsKijORm2I1diDUE4zVLzYL5dUfxoVeUdHpYY8EyFBKQiWOzaGSECPPLw2bzQnigQzr-g', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 14:27:11', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (199, 'ebe3c9b0-6d17-4e7a-9d4b-a4d127e5f81e', 'wechat_open_web', '72_eahdqYL3gU93PJ1IWa6sIKwL4-XvLvCcMnkLYYI3au_8OQ2ZEwe5YHjnRKVzmXDkEfW_IUwCpSyGBLYaOS_ms4RfSI-TAH_s7lUnh_pwOpQ', NULL, '72_8RcuvSh7R88zZSjHyMfuROguXNJxl28CinaM0DMVnQdlvrLORUkT-ArLdWEY_ukrctsOppiY85xYUtZ8mRKit66-IMJauWckLptvbS6mVtk', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:14:33', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (200, 'a9865b55-498e-47e5-ab12-bfc028f9401a', 'wechat_open_web', '72_sDs8oTAz4diS5nsjQyO-y2aO2IXDYL0CkVFkHaA5gJDb1YCUqfmG9ejNR0-lsshtYwOOswE5s5hdIMkBXsUt_zuVK5nyTlJ3oi3sVrUEaP4', NULL, '72_Z9mP_wckNOwwmrA0eGB8lUB5CY23FvlLciZBegzfnyg10VW0GOe56QF0uM4rgtTha-kO7Uhasm2FIFdDdGKhriu8t1OYs2PEyYT-GOYauvA', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:16:30', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (201, '45ef2f02-0498-4a91-9b7e-7ec1fbba1f4f', 'wechat_open_web', '72_pj5qq79ny99dg-nnZztIDdBw6pxQUTOI7GC1-50zdFugMU3JhIUgoWKG_zISSOT63HSkuogl0GTSM7zV-7XaGRZoVvT3ks9e4No7qh4lmcM', NULL, '72_jJaohqyJXjiOai2Y1X2JGxinYVUpGYQhNrNRqRBEGDzY44zuPuNxJSIAvlXbJoZXwi57WfV2FxbLCfeUPCnBzypTR6MyAgnY7UBPzfnkO8E', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 17:22:53', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (202, '719938db-a623-427c-b0bb-f93ccc66e12e', 'wechat_open_web', '72_47aVnqUFSV_6B866IIt56eXQ4MCeaON9p6uNXDNd8tM9C1aDLc42MpMvPCh4gUJBr1CPk6W2BjaJdbp53mhvgJQ9mbVTHi3Rgt7S5lYa1uc', NULL, '72_ES4G1cNwL7SR5zxg7wSUtyh1JAMD3iHksu9PhfriYVa7BviNMKTBXq0XA92tRNDGTLbYyjpzXBsihDooqcYziiJjJNJZ8HV573kvdk5Js6g', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 18:01:00', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (203, '6c128697-f856-4cec-9b22-9c041e546aa9', 'wechat_open_web', '72_ouu4bb-uHrl6KXeQP_H_nI2cn0GBsiCAq4sJcwK0vEhi4DqPbvInOEpYwX1ljPsrxJ2a6iXf48A8SRDDT0G-jKPhs5qsI7MTUvylc3tIvIA', NULL, '72_8yFIgg2C-J3jomyS19ZQmPsNu_bwxoVe_pOjDQInuid5WH2SLBL5ul8NIXF4kFbBT5S1xDvQ9Wo0yGLgLg4kAwvGRRk2atyA9u85HLXRrCU', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:40:55', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (204, 'd78d0dfd-ea6a-419c-a95d-916f75ef8645', 'wechat_open_web', '72_In2RD2EUmBPN_cKpj_e_6WhSI0BFkOqOSGMAxPg8frEv3EExLiPv7H7p1VJFBoTXDRMUzxX4uBXJUanI3B38y2IO0T_T21WZWToph0Hqrfk', NULL, '72_ICxLSkfZYijpSu7nJwnOGVjwG0bLkwAlsKxMNYUAJF0O-hkVP44qlnSJjrEXvQ7tpId_-8uygb3EjfSYMBh1h5D-YtjYFTYgj-tQOcponpQ', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:48:25', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (205, '3057f429-575b-4116-b6c2-2be2ed0daa6a', 'wechat_open_web', '72_8RcuvSh7R88zZSjHyMfuRAU8ESiAbG5qYjyInId2yhXEwIsJ--rVPWI-ZuUTkJzBym4oNf7hFJtvwZWqv1S0H-poe26G0sU_ge92uPjC3J8', NULL, '72_j_d-U4TM9Uc6ZXfG_ckplSQX_umZya-Z-HssZe57QjB0rYvI0LP2nzWusHpAVu352zq7LXTNGd2X239O3wHqlPSJ9dstTukRWWYy3h0nnVQ', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:50:17', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (206, 'c0013cb3-7862-4477-b178-a1cf885ad278', 'wechat_open_web', '72_VO1uAiIQgD1l49wDcy5oqfq7Qp-e6qX8FDtdvgbGuib3T2JAZZrBC6wKunFue-O5fai49_Y2-Y_0NUldDAgGjFVGJ53FwA9sQH6W9yovX3Y', NULL, '72_ldWlbgKsd3GropvbdrgjzZMFOgKS8i8Cre678hFHSWlrGaQVjPR9WgRZftTWcQHA0vgDQM-wKERD7_LGC1qzKnxEeUPOH1cO_VztQ3ZCvM0', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:53:02', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (207, '243912df-6515-4821-a2d2-311869eb4b66', 'wechat_open_web', '72_nrEdUC4X_xkmBsNbtePmd4tyBTDyhAzb35Xp0ul9pUfRsMfG8GIVQrIvM-GIJXyvJ1n5BscRwmOKeZxxqfzKiQdq-WjWy0PVmKEJ7YV2p_8', NULL, '72_H4I7KKoI2DSFE3dSVXAzyGxz0OqTXT6d8kMvraXgA4nslgsCM6iLB_7d-aHGOhKjKOQbUAJb8-mOerc9YhfM1oPRb_nW4y1lvswt-QwXrRs', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 17:22:13', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (208, 'b14bbe72-eddb-4282-a42b-77281f61f27c', 'wechat_open_web', '72_eahdqYL3gU93PJ1IWa6sIHdTySn-4UB_nLAkQLGDSjY7CTMUE4EOSyKYEFSoZmq9Fs64RdAHCV3PJG4ifk_VlZaFkGopHrytcIScSIfyU6w', NULL, '72_8RcuvSh7R88zZSjHyMfuRKViN1EJKbd_ZCElj0V8epojZFlgv6LJZd_fBKE2hE3q9iUqj-0vPqndpMCdc-FfPUjbvDh4B5w1UtNv78wz1Ak', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 17:39:53', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (209, '56f25762-2dcc-4be2-a50e-934eac40e328', 'wechat_open_web', '72_GqYw5ylQK7W9nn_cd8keVairltJ1Fcyp9SsIORxMtkihL1iQecSo5Boclagxl-RXHnmdc7mo82DLkFkSqSTDn0JunfPAtAIyAZl5geONq88', NULL, '72_2PoE8DZBF2qybpGHXPHagdYdPtt3Un3YjomGW7pGF65KKYF8t-qd4scANEK1QguVv1ig6zEDvL7F7iFgNVGkkRTEicSq21-QyZ7jVul6J1Y', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 18:31:11', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO `iot_social_user` VALUES (210, '3a8b4ac4-8e24-4b23-b850-8fca2d90794b', 'wechat_open_web', '72_jJ0WZ-4r18IkeIs0YC6FfDOthAf9UIUNqALqUbYzBMirZuUh48M4AcVlp0Pjy4KbdA_OA1sWvkL1XWAcLa-KtqM-g-gF8Bz9DBfVUwcKGMU', NULL, '72_qfKdEHN3PH23LcmUsUrXoUmO2EkXUtRStVV_j7RabNi8Kuj8mhZYao9fZYCs_m_djArcug96q0TgX2Nxxnkk8LFOYQ26ODl0fy8ZLW6WW9c', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 09:06:39', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');

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
  `specs` json NULL COMMENT '数据定义',
  `is_chart` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否图表展示（0-否，1-是）',
  `is_monitor` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否实时监测（0-否，1-是）',
  `is_history` tinyint(1) NULL DEFAULT 0 COMMENT '是否历史存储（0-否，1-是）',
  `is_readonly` tinyint(1) NULL DEFAULT 0 COMMENT '是否只读数据(0-否，1-是)',
  `is_share_perm` tinyint(1) NULL DEFAULT 0 COMMENT '是否设备分享权限(0-否，1-是)',
  `model_order` int(10) NULL DEFAULT 0 COMMENT '排序，值越大，排序越靠前',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `temp_slave_id` bigint(20) NULL DEFAULT NULL COMMENT '从机id',
  `formula` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计算公式',
  `reverse_formula` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '控制公式',
  `reg_addr` int(255) NULL DEFAULT NULL COMMENT '寄存器地址值',
  `bit_option` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '位定义选项',
  `value_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '解析类型 1.数值 2.选项',
  `is_params` int(1) NULL DEFAULT NULL COMMENT '是否是计算参数',
  `quantity` int(2) NULL DEFAULT NULL COMMENT '读取寄存器数量',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'modbus功能码',
  `parse_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'modbus解析类型',
  PRIMARY KEY (`model_id`) USING BTREE,
  INDEX `iot_things_model_index_product_id`(`product_id`) USING BTREE,
  INDEX `iot_things_model_index_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_things_model_index_model_order`(`model_order`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 500 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物模型' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_things_model
-- ----------------------------
INSERT INTO `iot_things_model` VALUES (113, '设备开关', 41, '温湿度智能开关', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 0, 0, 1, 0, 0, 9, '0', NULL, '2022-08-14 00:06:53', '', '2023-03-31 23:43:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (125, '空气温度', 41, '温湿度智能开关', 1, 'admin', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, 1, 1, 0, 1, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:44:21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (126, '空气湿度', 41, '温湿度智能开关', 1, 'admin', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, 1, 1, 0, 3, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:44:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (127, '二氧化碳', 41, '温湿度智能开关', 1, 'admin', 'co2', 1, 'integer', '{\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}', 1, 1, 1, 1, 0, 2, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:44:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (128, '室内亮度', 41, '温湿度智能开关', 1, 'admin', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 1, 1, 1, 1, 0, 4, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:44:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (129, '运行档位', 41, '温湿度智能开关', 1, 'admin', 'gear', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"select\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 0, 0, 1, 0, 0, 8, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:43:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (130, '灯光色值', 41, '温湿度智能开关', 1, 'admin', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"integer\", \"arrayCount\": \"3\"}', 0, 0, 1, 0, 0, 5, '0', NULL, '2022-11-05 23:56:21', '', '2023-09-25 22:57:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (131, '屏显消息', 41, '温湿度智能开关', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, 1, 0, 0, 7, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:43:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (132, '上报数据', 41, '温湿度智能开关', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 0, 0, 0, 0, 0, 10, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:43:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (134, '环境温度过高', 41, '温湿度智能开关', 1, 'admin', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 0, 0, 1, 0, 0, 0, '0', NULL, '2022-11-05 23:56:29', '', '2023-03-31 23:44:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (135, '设备发生异常', 41, '温湿度智能开关', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, 1, 0, 0, 0, '0', NULL, '2022-11-05 23:56:29', '', '2023-03-31 23:44:29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (161, '子设备', 96, '网关产品', 1, 'admin', 'device', 1, 'array', '{\"type\": \"array\", \"params\": [{\"id\": \"device_co2\", \"name\": \"二氧化碳\", \"order\": 0, \"isChart\": 1, \"datatype\": {\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\", \"enumList\": [{\"text\": \"\", \"value\": \"\"}], \"arrayType\": \"int\"}, \"isHistory\": 1, \"isMonitor\": 1, \"isReadonly\": 1, \"isSharePerm\": 0}, {\"id\": \"device_temperature\", \"name\": \"空气温度-只读\", \"order\": 4, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"device_gear\", \"name\": \"运行档位\", \"order\": 6, \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0, \"isSharePerm\": 1}, {\"id\": \"device_switch\", \"name\": \"设备开关\", \"order\": 5, \"isChart\": 0, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0, \"isSharePerm\": 1}, {\"id\": \"device_report_monitor\", \"name\": \"上报监测数据\", \"order\": 9, \"isChart\": 0, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0, \"isSharePerm\": 1}, {\"id\": \"device_irc\", \"name\": \"射频遥控\", \"order\": 1, \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"遥控学习\", \"value\": \"FFXX01\"}, {\"text\": \"遥控清码\", \"value\": \"FFXX02\"}, {\"text\": \"打开开关\", \"value\": \"FFXX03\"}, {\"text\": \"关闭开关\", \"value\": \"FFXX04\"}, {\"text\": \"暂停\", \"value\": \"FFXX05\"}, {\"text\": \"锁定\", \"value\": \"FFXX06\"}]}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0, \"isSharePerm\": 1}], \"arrayType\": \"object\", \"arrayCount\": \"5\"}', 0, 0, 0, 0, 1, 10, '0', NULL, '2023-02-25 22:51:53', '', '2023-09-25 23:13:21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (162, '功能分组', 96, '网关产品', 1, 'admin', 'category', 1, 'object', '{\"type\": \"object\", \"params\": [{\"id\": \"category_light\", \"name\": \"光照\", \"order\": 1, \"isChart\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}, \"isHistory\": 1, \"isMonitor\": 1, \"isReadonly\": 1}, {\"id\": \"category_humidity\", \"name\": \"空气湿度\", \"order\": 2, \"isChart\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isHistory\": 0, \"isMonitor\": 1, \"isReadonly\": 1}, {\"id\": \"category_temperature\", \"name\": \"空气温度-只读\", \"order\": 3, \"isChart\": 0, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"category_report_monitor\", \"name\": \"上报监测数据\", \"order\": 7, \"isChart\": 0, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0, \"isSharePerm\": 1}, {\"id\": \"category_gear\", \"name\": \"运行档位\", \"order\": 5, \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0, \"isSharePerm\": 1}, {\"id\": \"category_switch\", \"name\": \"设备开关\", \"order\": 4, \"isChart\": 0, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0, \"isSharePerm\": 1}, {\"id\": \"category_irc\", \"name\": \"射频遥控\", \"order\": 6, \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"遥控配对\", \"value\": \"FFXX01\"}, {\"text\": \"遥控清码\", \"value\": \"FFXX02\"}, {\"text\": \"打开开关\", \"value\": \"FFXX03\"}, {\"text\": \"关闭开关\", \"value\": \"FFXX04\"}, {\"text\": \"暂停\", \"value\": \"FFXX05\"}, {\"text\": \"锁定\", \"value\": \"FFXX06\"}]}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0, \"isSharePerm\": 1}]}', 0, 0, 0, 0, 1, 9, '0', NULL, '2023-02-25 22:51:53', '', '2023-09-03 11:03:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (163, '空气温度', 96, '网关产品', 1, 'admin', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, 1, 1, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', '2023-03-31 16:08:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (164, '设备开关', 96, '网关产品', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 0, 0, 1, 0, 1, 8, '0', NULL, '2023-02-25 22:52:16', '', '2023-09-03 11:03:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (165, '运行档位', 96, '网关产品', 1, 'admin', 'gear', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"select\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 0, 0, 1, 0, 1, 7, '0', NULL, '2023-02-25 22:52:16', '', '2023-09-03 11:03:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (166, '灯光色值', 96, '网关产品', 1, 'admin', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"integer\", \"arrayCount\": \"3\"}', 0, 0, 1, 0, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', '2023-03-31 16:08:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (167, '上报监测数据', 96, '网关产品', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 0, 0, 1, 0, 1, 11, '0', NULL, '2023-02-25 22:52:16', '', '2023-09-03 11:03:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (168, '环境温度过高', 96, '网关产品', 1, 'admin', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 0, 0, 1, 0, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', '2023-03-31 16:08:15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (169, '设备发生异常', 96, '网关产品', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, 1, 0, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', '2023-03-31 16:08:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (170, '屏显消息', 96, '网关产品', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 0, 0, 1, 0, 1, 0, '0', NULL, '2023-02-25 22:52:35', '', '2023-09-03 11:03:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (171, '设备重启', 96, '网关产品', 1, 'admin', 'reset', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"重启\", \"value\": \"restart\"}]}', 0, 0, 1, 0, 1, 0, '0', NULL, '2023-02-25 22:52:35', '', '2023-09-03 11:03:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (174, '室内亮度', 96, '网关产品', 1, 'admin', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 1, 1, 1, 1, 0, 0, '0', NULL, '2023-02-26 00:56:39', '', '2023-09-03 10:40:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (175, '设备重启', 41, '智能开关', 1, 'admin', 'reset', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"重启\", \"value\": \"restart\"}]}', 0, 0, 1, 0, 0, 6, '0', NULL, '2023-02-26 02:20:40', '', '2023-04-01 23:40:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (385, '射频遥控', 41, '★智能开关', 1, 'admin', 'irc', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"遥控学习\", \"value\": \"FFXX01\"}, {\"text\": \"遥控清码\", \"value\": \"FFXX02\"}, {\"text\": \"打开开关\", \"value\": \"FFXX03\"}, {\"text\": \"关闭开关\", \"value\": \"FFXX04\"}, {\"text\": \"暂停\", \"value\": \"FFXX05\"}, {\"text\": \"锁定\", \"value\": \"FFXX06\"}]}', 0, 0, 1, 0, 0, 11, '0', 'admin', '2023-03-31 23:46:36', '', '2023-04-13 01:38:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (439, '上报状态', 41, '★智能开关产品', 1, 'admin', 'status', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"更新状态\", \"value\": \"update_status\"}]}', 0, 0, 0, 0, 0, 12, '0', 'admin', '2023-04-13 01:39:31', '', '2023-04-13 01:39:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model` VALUES (493, '漏水值', 112, '★MODBUS协议产品', 1, 'admin', '0', 1, 'integer', '{\"max\": 100, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"度\"}', 0, 0, 1, 0, 0, 0, '0', '', '2023-09-13 23:33:19', '', NULL, NULL, 1, NULL, NULL, 0, NULL, NULL, NULL, 1, '3', 'ushort');
INSERT INTO `iot_things_model` VALUES (494, '温度', 112, '★MODBUS协议产品', 1, 'admin', '0', 1, 'integer', '{\"max\": 100, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"°\"}', 0, 0, 1, 0, 0, 0, '0', '', '2023-09-13 23:33:19', '', NULL, NULL, 2, NULL, NULL, 0, NULL, NULL, NULL, 1, '3', 'ushort');
INSERT INTO `iot_things_model` VALUES (495, '电量', 112, '★MODBUS协议产品', 1, 'admin', '1', 1, 'integer', '{\"max\": 100, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"\"}', 0, 0, 1, 0, 0, 0, '0', '', '2023-09-13 23:33:19', '', NULL, NULL, 11, NULL, NULL, 1, NULL, NULL, NULL, 1, '3', 'ushort');
INSERT INTO `iot_things_model` VALUES (499, '上报状态', 130, 'TCP测试设备', 1, 'admin', 'status', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"更新状态\", \"value\": \"update_status\"}]}', 0, 0, 0, 0, 1, 0, '0', 'admin', '2023-09-19 11:22:55', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
  `specs` json NULL COMMENT '数据定义',
  `is_sys` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否系统通用（0-否，1-是）',
  `is_chart` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否图表展示（0-否，1-是）',
  `is_monitor` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否实时监测（0-否，1-是）',
  `is_history` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否历史存储 (0-否，1-是）',
  `is_readonly` tinyint(1) NULL DEFAULT 0 COMMENT '是否只读数据(0-否，1-是)',
  `is_share_perm` tinyint(1) NULL DEFAULT 0 COMMENT '是否设备分享权限(0-否，1-是)',
  `model_order` int(10) NULL DEFAULT 0 COMMENT '排序，值越大，排序越靠前',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `temp_slave_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '从机id',
  `formula` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计算公式',
  `reverse_formula` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '控制公式',
  `reg_addr` int(255) NULL DEFAULT NULL COMMENT '寄存器地址值',
  `bit_option` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '位定义选项',
  `value_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '解析类型 1.数值 2.选项',
  `is_params` int(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '是否是计算参数,默认否 0=否，1=是',
  `quantity` int(2) NULL DEFAULT NULL COMMENT '读取寄存器数量',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'modbus功能码',
  `old_identifier` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '旧的标识符',
  `old_temp_slave_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '旧的从机id',
  `parse_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'modbus解析类型',
  PRIMARY KEY (`template_id`) USING BTREE,
  INDEX `iot_things_model_template_index_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `iot_things_model_template_index_model_order`(`model_order`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 344 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物模型模板' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of iot_things_model_template
-- ----------------------------
INSERT INTO `iot_things_model_template` VALUES (1, '空气温度', 1, 'admin', 'temperature', 1, 'decimal', '{\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 1, 1, 1, 1, 0, 4, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:12:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (2, '空气湿度', 1, 'admin', 'humidity', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}', 1, 1, 1, 1, 1, 0, 3, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:12:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (3, '二氧化碳', 1, 'admin', 'co2', 1, 'integer', '{\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (4, '室内亮度', 1, 'admin', 'brightness', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"cd/m2\"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (5, '设备开关', 1, 'admin', 'switch', 2, 'bool', '{\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}', 1, 0, 0, 1, 0, 0, 5, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (6, '运行档位', 1, 'admin', 'gear', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"select\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}', 1, 0, 0, 1, 0, 0, 6, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (7, '灯光色值', 1, 'admin', 'light_color', 2, 'array', '{\"type\": \"array\", \"arrayType\": \"integer\", \"arrayCount\": \"3\"}', 1, 0, 0, 1, 0, 0, 2, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (8, '屏显消息', 1, 'admin', 'message', 2, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 1, 0, 0, 1, 0, 0, 1, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (9, '上报监测数据', 1, 'admin', 'report_monitor', 2, 'integer', '{\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 1, 0, 0, 0, 0, 0, 9, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (10, '环境温度过高', 1, 'admin', 'height_temperature', 3, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}', 1, 0, 0, 1, 0, 0, 8, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (11, '设备发生异常', 1, 'admin', 'exception', 3, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 1, 0, 0, 1, 0, 0, 7, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (12, '光照', 1, 'admin', 'light', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}', 0, 1, 1, 1, 1, 0, 0, '0', 'wumei', '2022-05-07 09:41:17', 'admin', '2023-04-10 01:11:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (13, '压力', 1, 'admin', 'pressure', 1, 'decimal', '{\"max\": 200, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"帕斯卡\"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 22:39:18', 'admin', '2023-04-10 01:11:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (14, '设备重启', 1, 'admin', 'reset', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"重启\", \"value\": \"restart\"}]}', 1, 0, 0, 1, 0, 0, 0, '0', 'admin', '2023-02-20 23:15:25', 'admin', '2023-04-10 01:11:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (15, '电池电压', 1, 'admin', 'voltage', 1, 'decimal', '{\"max\": 5, \"min\": 0, \"step\": 0.001, \"type\": \"decimal\", \"unit\": \"V\"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:17:43', 'admin', '2023-04-10 01:10:56', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (16, '饮水量', 1, 'admin', 'shuiliang', 1, 'integer', '{\"max\": 500, \"min\": 80, \"step\": 1, \"type\": \"integer\", \"unit\": \"ML\"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:18:39', 'admin', '2023-04-10 01:10:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (17, '灯光', 1, 'admin', 'light', 1, 'integer', '{\"max\": 1000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"Lux\"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:19:23', 'admin', '2023-04-10 01:10:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (18, '长度', 1, 'admin', 'length', 1, 'integer', '{\"max\": 2000, \"min\": 1, \"step\": 5, \"type\": \"integer\", \"unit\": \"M\"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:20:03', 'admin', '2023-04-10 01:10:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (19, '心率', 1, 'admin', 'heart_rate', 1, 'integer', '{\"max\": 250, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:21:46', 'admin', '2023-04-10 01:12:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (20, '光照强度', 1, 'admin', 'light_level', 1, 'integer', '{\"max\": 89.2, \"min\": 2.5, \"step\": 0.1, \"type\": \"integer\", \"unit\": \"L/g\"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:24:36', 'admin', '2023-04-10 01:10:35', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (21, '状态灯色', 1, 'admin', 'color', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"select\", \"enumList\": [{\"text\": \"红色\", \"value\": \"0\"}, {\"text\": \"绿色\", \"value\": \"1\"}, {\"text\": \"蓝色\", \"value\": \"2\"}, {\"text\": \"黄色\", \"value\": \"3\"}]}', 1, 0, 0, 1, 0, 0, 0, '0', 'admin', '2023-02-20 23:26:24', 'admin', '2023-04-10 01:10:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (22, '子设备', 1, 'admin', 'device', 2, 'array', '{\"type\": \"array\", \"params\": [{\"id\": \"device_co2\", \"name\": \"二氧化碳\", \"order\": 0, \"isChart\": 1, \"datatype\": {\"max\": 6000, \"min\": 100, \"step\": 1, \"type\": \"integer\", \"unit\": \"ppm\", \"enumList\": [{\"text\": \"\", \"value\": \"\"}], \"arrayType\": \"int\"}, \"isHistory\": 1, \"isMonitor\": 1, \"isReadonly\": 1}, {\"id\": \"device_temperature\", \"name\": \"空气温度-只读\", \"order\": 4, \"isChart\": 0, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\", \"enumList\": [{\"text\": \"\", \"value\": \"\"}], \"arrayType\": \"int\"}, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"device_gear\", \"name\": \"运行档位\", \"order\": 6, \"datatype\": {\"type\": \"enum\", \"showWay\": \"select\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_switch\", \"name\": \"设备开关\", \"order\": 5, \"datatype\": {\"type\": \"bool\", \"enumList\": [{\"text\": \"\", \"value\": \"\"}], \"trueText\": \"打开\", \"arrayType\": \"int\", \"falseText\": \"关闭\"}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"device_report_monitor\", \"name\": \"上报监测数据\", \"order\": 9, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\", \"enumList\": [{\"text\": \"\", \"value\": \"\"}], \"arrayType\": \"int\"}, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}], \"arrayType\": \"object\", \"arrayCount\": 5}', 1, 0, 0, 0, 0, 0, 10, '0', 'admin', '2023-02-24 01:10:43', 'admin', '2023-04-13 01:33:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (23, '功能分组', 1, 'admin', 'group', 2, 'object', '{\"type\": \"object\", \"params\": [{\"id\": \"group_light\", \"name\": \"光照\", \"order\": 1, \"isChart\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}, \"isHistory\": 1, \"isMonitor\": 1, \"isReadonly\": 1}, {\"id\": \"group_humidity\", \"name\": \"空气湿度\", \"order\": 2, \"isChart\": 1, \"datatype\": {\"max\": 100, \"min\": 0, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"%\"}, \"isMonitor\": 1, \"isReadonly\": 1}, {\"id\": \"group_temperature\", \"name\": \"空气温度-只读\", \"order\": 3, \"isChart\": 0, \"datatype\": {\"max\": 120, \"min\": -20, \"step\": 0.1, \"type\": \"decimal\", \"unit\": \"℃\"}, \"isMonitor\": 0, \"isReadonly\": 1}, {\"id\": \"group_report_monitor\", \"name\": \"上报监测数据\", \"order\": 7, \"datatype\": {\"max\": 10, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"次数\"}, \"isHistory\": 0, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"group_gear\", \"name\": \"运行档位\", \"order\": 5, \"datatype\": {\"type\": \"enum\", \"showWay\": \"select\", \"enumList\": [{\"text\": \"低速档位\", \"value\": \"0\"}, {\"text\": \"中速档位\", \"value\": \"1\"}, {\"text\": \"中高速档位\", \"value\": \"2\"}, {\"text\": \"高速档位\", \"value\": \"3\"}]}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"group_switch\", \"name\": \"设备开关\", \"order\": 4, \"datatype\": {\"type\": \"bool\", \"trueText\": \"打开\", \"falseText\": \"关闭\"}, \"isMonitor\": 0, \"isReadonly\": 0}, {\"id\": \"group_irc\", \"name\": \"红外遥控\", \"order\": 6, \"isChart\": 0, \"datatype\": {\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"遥控学习\", \"value\": \"FFXX01\"}, {\"text\": \"遥控清码\", \"value\": \"FFXX02\"}, {\"text\": \"打开开关\", \"value\": \"FFXX03\"}, {\"text\": \"关闭开关\", \"value\": \"FFXX04\"}, {\"text\": \"暂停\", \"value\": \"FFXX05\"}, {\"text\": \"锁定\", \"value\": \"FFXX06\"}]}, \"isHistory\": 1, \"isMonitor\": 0, \"isReadonly\": 0}]}', 1, 0, 0, 0, 0, 0, 11, '0', 'admin', '2023-02-25 22:41:43', 'admin', '2023-08-30 15:29:34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (201, '频率 ', 1, 'admin', 'frequency', 2, 'integer', '{\"max\": 65535, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"0.001Hz\"}', 1, 0, 0, 1, 0, 0, 0, '0', '', '2023-02-28 16:08:06', 'admin', '2023-04-10 03:37:11', NULL, '3#3', '%s*0.001', '', 27, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (225, '校验位', 1, 'admin', 'check', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"select\", \"enumList\": [{\"text\": \"N\", \"value\": \"0\"}, {\"text\": \"O\", \"value\": \"1\"}, {\"text\": \"E\", \"value\": \"2\"}]}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-02-28 16:08:08', 'admin', '2023-04-10 21:36:01', NULL, '3#3', '', '', 771, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (226, '波特率', 1, 'admin', 'baud', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"select\", \"enumList\": [{\"text\": \"1200\", \"value\": \"0\"}, {\"text\": \"2400\", \"value\": \"1\"}, {\"text\": \"4800\", \"value\": \"2\"}, {\"text\": \"9600\", \"value\": \"3\"}, {\"text\": \"19200\", \"value\": \"4\"}]}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-02-28 16:08:09', 'admin', '2023-04-10 03:37:32', NULL, '3#3', '', '', 772, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (227, '电压', 1, 'admin', 'voltage', 1, 'integer', '{\"max\": 6, \"min\": 0.1, \"step\": 0.1, \"type\": \"integer\", \"unit\": \"v\"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-02-28 16:08:09', 'admin', '2023-04-10 03:37:16', NULL, '3#3', '', '', 773, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (236, '射频遥控', 1, 'admin', 'irc', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"遥控学习\", \"value\": \"FFXX01\"}, {\"text\": \"遥控清码\", \"value\": \"FFXX02\"}, {\"text\": \"打开开关\", \"value\": \"FFXX03\"}, {\"text\": \"关闭开关\", \"value\": \"FFXX04\"}, {\"text\": \"暂停\", \"value\": \"FFXX05\"}, {\"text\": \"锁定\", \"value\": \"FFXX06\"}]}', 1, 0, 0, 1, 0, 0, 0, '0', 'admin', '2023-03-31 23:46:20', 'admin', '2023-04-10 01:09:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (250, '漏水值', 1, 'admin', '0', 1, 'integer', '{\"max\": 100, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"度\"}', 1, 0, 0, 1, 0, 0, 0, '0', '', '2023-04-11 22:35:36', '', '2023-09-13 23:32:34', NULL, '1#1', NULL, NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, 'ushort');
INSERT INTO `iot_things_model_template` VALUES (251, '温度', 1, 'admin', '0', 1, 'integer', '{\"max\": 100, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"°\"}', 1, 0, 0, 1, 0, 0, 0, '0', '', '2023-04-11 22:36:10', '', '2023-09-13 23:32:51', NULL, '1#2', NULL, NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, 'ushort');
INSERT INTO `iot_things_model_template` VALUES (252, '电量', 1, 'admin', '1', 1, 'integer', '{\"max\": 100, \"min\": 1, \"step\": 1, \"type\": \"integer\", \"unit\": \"\"}', 1, 0, 0, 1, 0, 0, 0, '0', '', '2023-04-11 22:36:27', '', '2023-09-13 23:33:11', NULL, '1#11', NULL, NULL, 1, NULL, NULL, NULL, 1, '3', NULL, NULL, 'ushort');
INSERT INTO `iot_things_model_template` VALUES (323, '上报状态', 1, 'admin', 'status', 2, 'enum', '{\"type\": \"enum\", \"showWay\": \"button\", \"enumList\": [{\"text\": \"更新状态\", \"value\": \"update_status\"}]}', 1, 0, 0, 0, 0, 1, 0, '0', 'admin', '2023-04-13 01:35:42', 'admin', '2023-09-03 10:50:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (324, 'X位移', 1, 'admin', 'x-shift', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-08-26 19:36:58', '', NULL, NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (325, 'Y位移', 1, 'admin', 'y-shift', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-08-26 19:37:23', '', '2023-08-26 19:37:32', NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (326, 'X位移', 1, 'admin', 'x-shift', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-08-26 19:38:31', '', NULL, NULL, '2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (327, 'Y位移', 1, 'admin', 'y-shift', 1, 'decimal', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"decimal\", \"unit\": \"mm\"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-08-26 19:38:51', '', NULL, NULL, '2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (328, '计件数量', 1, 'admin', '0', 1, 'integer', '{\"max\": 10000, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"\"}', 1, 0, 0, 0, 1, 0, 0, '0', '', '2023-08-28 15:05:25', '', NULL, NULL, '3#1', NULL, NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (329, '参数1', 1, 'admin', '0', 1, 'integer', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"\"}', 1, 0, 0, 0, 1, 0, 0, '0', '', '2023-08-28 15:06:55', '', NULL, NULL, '3#2', NULL, NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (330, '图片', 1, 'admin', 'image', 1, 'string', '{\"type\": \"string\", \"maxLength\": 10240}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-28 23:19:30', '', NULL, NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (331, '回路状态', 10, 'jamon', 'loop_status', 1, 'array', '{\"type\": \"array\", \"arrayType\": \"integer\"}', 0, 0, 0, 0, 0, 0, 0, '0', '', '2023-08-29 18:21:38', '', NULL, NULL, '4#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (332, '回路状态', 10, 'jamon', 'loop_status', 1, 'array', '{\"type\": \"array\", \"arrayType\": \"integer\"}', 0, 0, 0, 0, 0, 0, 0, '0', '', '2023-08-29 18:23:08', '', NULL, NULL, '4#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (335, '湿度', 1, 'admin', '0', 1, 'integer', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"\"}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 14:05:38', '', '2023-08-30 14:58:28', NULL, '6#1', '%s/10', NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (336, '温度', 1, 'admin', '1', 1, 'integer', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"°C\"}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 14:06:05', '', '2023-08-30 14:58:38', NULL, '6#1', '%s/10', NULL, 1, NULL, NULL, NULL, 1, '3', NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (341, '视频', 1, 'admin', 'video', 1, 'integer', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"\"}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 23:08:51', '', '2023-08-30 23:25:15', NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (342, '图片', 1, 'admin', 'image', 1, 'string', '{\"type\": \"string\", \"maxLength\": 1024}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 23:21:48', '', '2023-08-30 23:25:22', NULL, '2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `iot_things_model_template` VALUES (343, '状态', 1, 'admin', 'status', 1, 'integer', '{\"max\": 100, \"min\": 0, \"step\": 1, \"type\": \"integer\", \"unit\": \"\"}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 23:28:00', '', '2023-08-30 23:28:17', NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


DROP TABLE IF EXISTS `media_server`;
CREATE TABLE `media_server`  (
                                 `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '流媒体配置ID',
                                 `server_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务器标识',
                                 `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
                                 `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
                                 `enabled` tinyint(1) NULL DEFAULT NULL COMMENT '使能开关',
                                 `protocol` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '默认播放协议',
                                 `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务器ip',
                                 `domain` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务器域名',
                                 `hookurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '回调服务器地址',
                                 `secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '流媒体密钥',
                                 `port_http` int(11) NOT NULL DEFAULT 0 COMMENT 'http端口',
                                 `port_https` int(11) NOT NULL DEFAULT 0 COMMENT 'https端口',
                                 `port_rtmp` int(11) NOT NULL DEFAULT 0 COMMENT 'rtmp端口',
                                 `port_rtsp` int(11) NOT NULL DEFAULT 0 COMMENT 'rtsp端口',
                                 `rtp_proxy_port` int(11) NOT NULL DEFAULT 0 COMMENT 'RTP收流端口',
                                 `rtp_enable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否使用多端口模式',
                                 `rtp_port_range` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'rtp端口范围',
                                 `record_port` int(11) NOT NULL DEFAULT 0 COMMENT '录像服务端口',
                                 `auto_config` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否自动同步配置ZLM',
                                 `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态',
                                 `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                                 `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime NOT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                                 `port_ws` int(11) NULL DEFAULT NULL COMMENT 'ws端口',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流媒体服务器配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of media_server
-- ----------------------------
INSERT INTO `media_server` VALUES (7, 'fastbee', 1, 'admin', 1, 'http', '192.168.2.120', 'fastbee.com2', '192.168.2.15:8080', '035c73f7-bb6b-4889-a715-d9eb2d192xxx', 8082, 8443, 1935, 554, 0, 1, '30000,30103', 18081, 1, 0, '0', '', '2023-09-26 21:11:43', '', '2023-10-26 21:51:25', NULL, NULL);

DROP TABLE IF EXISTS `sip_device_channel`;
CREATE TABLE `sip_device_channel`  (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                       `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
                                       `tenant_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
                                       `product_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '产品ID',
                                       `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品名称',
                                       `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '产品ID',
                                       `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品名称',
                                       `device_sip_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备SipID',
                                       `channel_sip_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通道SipID',
                                       `channel_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通道名称',
                                       `register_time` datetime NULL DEFAULT NULL COMMENT '注册时间',
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
                                       `create_time` datetime NOT NULL COMMENT '创建时间',
                                       `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
                                       `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                       `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                                       PRIMARY KEY (`id`, `device_sip_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '监控设备通道信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sip_device_channel
-- ----------------------------
INSERT INTO `sip_device_channel` VALUES (84, 1, 'admin', 118, '监控设备', 1, 'admin', '11010200001320000001', '11010200001320000001', 'IPdome', '2024-01-08 22:16:32', '132', '132', '北京市/市辖区/西城区', '3402000000', 'Hikvision', 'IP Camera', 'Owner', '', 'Address', '34020000002000000001', '', 0, '', 0, '', 3, 0.000000, 0.000000, 'gb_play_11010200001320000001_11010200001320000001', 0, 0, 0, '0', '', '2023-04-11 21:12:33', '', NULL, NULL);
INSERT INTO `sip_device_channel` VALUES (102, 1, 'admin', 135, '视频监控', 0, '', '11010100001320000001', '11010100001320000001', 'IPdome', '2024-01-09 23:35:00', '132', '132', '北京市/市辖区/东城区', '3402000000', 'Hikvision', 'IP Camera', 'Owner', '', 'Address', '34020000002000000001', '', 0, '', 0, '', 3, 0.000000, 0.000000, '', 0, 0, 0, '0', '', '2024-01-08 22:15:57', '', NULL, NULL);

DROP TABLE IF EXISTS `sip_device`;
CREATE TABLE `sip_device`  (
                               `device_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备ID',
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
                               `registerTime` datetime NOT NULL COMMENT '注册时间',
                               `lastConnectTime` datetime NULL DEFAULT NULL COMMENT '最后上线时间',
                               `active_time` datetime NULL DEFAULT NULL COMMENT '激活时间',
                               `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备入网IP',
                               `port` bigint(10) NULL DEFAULT NULL COMMENT '设备接入端口号',
                               `hostAddress` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备地址',
                               `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                               `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                               `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                               PRIMARY KEY (`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '监控设备' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sip_device
-- ----------------------------
INSERT INTO `sip_device` VALUES (9, 0, '', '13030300001170000008', '8E085C3RAJE156F', 'Dahua', 'DH-3H3205-ADW', '2.810.0000027.0.R,2022-08-26', 'UDP', 'UDP', '', '2023-02-27 12:07:35', '2023-02-26 23:36:45', NULL, '177.7.0.1', 35332, '177.7.0.1:35332', '0', '', NULL, '', NULL, NULL);
INSERT INTO `sip_device` VALUES (12, 0, '', '11010100001320000001', '海康威视摄像头', 'Hikvision', 'iDS-2DE2402IX-D3/W/XM', 'V5.7.4', 'UDP', 'UDP', '', '2024-01-09 23:29:52', '2024-01-09 23:35:00', NULL, '192.168.2.119', 5065, '192.168.2.119:5065', '0', '', NULL, '', NULL, NULL);
INSERT INTO `sip_device` VALUES (13, 0, '', '11010200001320000017', '', '', '', '', 'UDP', 'UDP', '', '2023-03-16 21:41:45', '2023-03-16 21:52:50', NULL, '192.168.2.119', 5060, '192.168.2.119:5060', '0', '', NULL, '', NULL, NULL);
INSERT INTO `sip_device` VALUES (16, 0, '', '12010100001320000003', 'IP DOME', 'Hikvision', 'iDS-2DE2402IX-D3/W/XM', 'V5.7.4', 'UDP', 'UDP', '', '2023-04-11 21:08:07', '2023-04-11 21:13:16', NULL, '192.168.2.119', 5060, '192.168.2.119:5060', '0', '', NULL, '', NULL, NULL);
INSERT INTO `sip_device` VALUES (18, 0, '', '13030100001320000001', '', 'ABCD', 'TEST001', 'V1.0', 'UDP', 'UDP', '', '2023-03-28 16:06:45', '2023-03-28 16:09:52', NULL, '192.168.205.250', 5063, '192.168.205.250:5063', '0', '', NULL, '', NULL, NULL);
INSERT INTO `sip_device` VALUES (19, 0, '', '11010200001320000001', '海康威视摄像头', 'Hikvision', 'iDS-2DE2402IX-D3/W/XM', 'V5.7.4', 'UDP', 'UDP', '', '2024-01-08 22:08:27', '2024-01-08 22:16:32', NULL, '192.168.2.119', 5065, '192.168.2.119:5065', '0', '', NULL, '', NULL, NULL);

DROP TABLE IF EXISTS `sip_config`;
CREATE TABLE `sip_config`  (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
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
                               `create_time` datetime NOT NULL COMMENT '创建时间',
                               `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                               `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'sip系统配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sip_config
-- ----------------------------
INSERT INTO `sip_config` VALUES (38, 117, '', 1, 1, NULL, '3402000000', '34020000002000000001', '12345678', '177.7.0.13', 5061, '0', '', '2023-03-16 21:26:18', '', '2023-03-16 21:26:24', NULL);
INSERT INTO `sip_config` VALUES (39, 118, '', 1, 1, NULL, '3402000000', '34020000002000000001', '12345678', '177.7.0.13', 5061, '0', '', '2023-04-11 21:11:54', '', NULL, NULL);
INSERT INTO `sip_config` VALUES (41, 135, '', 1, 1, NULL, '3402000000', '34020000002000000001', '12345678', '177.7.0.13', 5061, '0', '', '2024-01-08 22:14:35', '', NULL, NULL);

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
  `create_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`news_id`) USING BTREE,
  INDEX `news_index_category_id`(`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '新闻资讯' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '新闻分类' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_access_token
-- ----------------------------
INSERT INTO `oauth_access_token` VALUES ('d406d946aac7c24cd01a2df1105ec898', 0xACED0005737200436F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744F4175746832416363657373546F6B656E0CB29E361B24FACE0200064C00156164646974696F6E616C496E666F726D6174696F6E74000F4C6A6176612F7574696C2F4D61703B4C000A65787069726174696F6E7400104C6A6176612F7574696C2F446174653B4C000C72656672657368546F6B656E74003F4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F636F6D6D6F6E2F4F417574683252656672657368546F6B656E3B4C000573636F706574000F4C6A6176612F7574696C2F5365743B4C0009746F6B656E547970657400124C6A6176612F6C616E672F537472696E673B4C000576616C756571007E000578707372001E6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794D6170593614855ADCE7D002000078707372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018AA760D163787372004C6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744578706972696E674F417574683252656672657368546F6B656E2FDF47639DD0C9B70200014C000A65787069726174696F6E71007E0002787200446F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744F417574683252656672657368546F6B656E73E10E0A6354D45E0200014C000576616C756571007E0005787074001B56452D377744386D70414A34497A662D49345F456450316F31626F7371007E000977080000018AA760D12D78737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C0001637400164C6A6176612F7574696C2F436F6C6C656374696F6E3B7870737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000043F400000000000027400047265616474000577726974657874000662656172657274001B70385A5F47384A7349327A33786575674430646A494B305A396B38, '2c27d3f4516a653753e8337094cf35e1', 'admin', 'admin-dueros', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000009740004636F64657400066E777064716174000A6772616E745F74797065740012617574686F72697A6174696F6E5F636F646574000573636F706574000A7265616420777269746574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F65326566636666663936383964633462366166363764373865313039363934647400057374617465740020346635653763303462313731306262653836376535376431373434613534373874000D636C69656E745F7365637265747400205332456E65487864745E4D48684276384E23245E7479366E71244E5159324E6474000A647565726F735F7569647400203466356537633034623137313062626538363765353764313734346135343738740009636C69656E745F696474000C61646D696E2D647565726F7378737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E002E770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E002E770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E002E770C000000103F4000000000000171007E0020787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00434C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00434C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E004378707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E00470000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E00470000018AA6E3204374000A57696E646F77732031307371007E002E770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00434C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00435B0007726F6C6549647371007E00554C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00434C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00544C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0054787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00434C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00434C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E005670707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E004974000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0048000000017371007E0047000000000000006570707400013171007E00497400103136343737303730374071712E636F6D7371007E005977080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E00555B00076D656E7549647371007E00554C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00434C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00604C000673746174757371007E000F7871007E005670707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E0047000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E00687400013078740001307400013071007E007674000561646D696E71007E0076, '4cabc0e9bcfa34131342209bdaf275eb');

-- ----------------------------
-- Table structure for oauth_approvals
-- ----------------------------
DROP TABLE IF EXISTS `oauth_approvals`;
CREATE TABLE `oauth_approvals`  (
  `userId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `clientId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `expiresAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastModifiedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_approvals
-- ----------------------------
INSERT INTO `oauth_approvals` VALUES ('admin', 'admin-dueros', 'read', 'APPROVED', '2023-10-18 22:12:45', '2023-09-18 22:12:45');
INSERT INTO `oauth_approvals` VALUES ('admin', 'admin-dueros', 'write', 'APPROVED', '2023-10-18 22:12:45', '2023-09-18 22:12:45');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
INSERT INTO `oauth_client_details` VALUES ('admin-dueros', 'speaker-service', 'S2EneHxdt^MHhBv8N#$^ty6nq$NQY2Nd', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694d', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 1);
INSERT INTO `oauth_client_details` VALUES ('fastbee-dueros', 'speaker-service', 'S2EneHxdt^MHhBv8N#$^ty6nq$NQY2Nc', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/35dc8a5b53719ea6bbb7bd818ca8d5b6', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 1);
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_code
-- ----------------------------
INSERT INTO `oauth_code` VALUES ('mLAeh7', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000474000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464740009636C69656E745F696471007E001474000573636F706574000A7265616420777269746578737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E0023770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E0023770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E0023770C000000103F4000000000000171007E001A787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00384C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00384C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E003878707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E003C0000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E003C0000018AA6E3204374000A57696E646F77732031307371007E0023770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00384C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00385B0007726F6C6549647371007E004A4C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00384C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00494C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0049787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00384C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00384C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E004B70707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E003E74000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E003D000000017371007E003C000000000000006570707400013171007E003E7400103136343737303730374071712E636F6D7371007E004E77080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E004A5B00076D656E7549647371007E004A4C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00384C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00554C000673746174757371007E000F7871007E004B70707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E003C000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E005D7400013078740001307400013071007E006B74000561646D696E71007E006B);
INSERT INTO `oauth_code` VALUES ('1YESo2', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000474000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464740009636C69656E745F696471007E001474000573636F706574000A7265616420777269746578737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E0023770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E0023770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E0023770C000000103F4000000000000171007E001A787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00384C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00384C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E003878707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E003C0000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E003C0000018AA6E3204374000A57696E646F77732031307371007E0023770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00384C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00385B0007726F6C6549647371007E004A4C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00384C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00494C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0049787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00384C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00384C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E004B70707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E003E74000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E003D000000017371007E003C000000000000006570707400013171007E003E7400103136343737303730374071712E636F6D7371007E004E77080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E004A5B00076D656E7549647371007E004A4C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00384C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00554C000673746174757371007E000F7871007E004B70707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E003C000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E005D7400013078740001307400013071007E006B74000561646D696E71007E006B);
INSERT INTO `oauth_code` VALUES ('DhdDPY', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000674000573636F706574000A7265616420777269746574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F65326566636666663936383964633462366166363764373865313039363934647400057374617465740020346635653763303462313731306262653836376535376431373434613534373874000A647565726F735F7569647400203466356537633034623137313062626538363765353764313734346135343738740009636C69656E745F696471007E001478737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E0027770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E0027770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E0027770C000000103F4000000000000171007E001C787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E003C4C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E003C4C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E003C78707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E00400000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E00400000018AA6E3204374000A57696E646F77732031307371007E0027770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E003C4C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E003C5B0007726F6C6549647371007E004E4C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E003C4C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E004D4C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E004D787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E003C4C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E003C4C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E004F70707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E004274000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0041000000017371007E0040000000000000006570707400013171007E00427400103136343737303730374071712E636F6D7371007E005277080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E004E5B00076D656E7549647371007E004E4C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E003C4C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00594C000673746174757371007E000F7871007E004F70707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E0040000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E00617400013078740001307400013071007E006F74000561646D696E71007E006F);

-- ----------------------------
-- Table structure for oauth_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_token`;
CREATE TABLE `oauth_refresh_token`  (
  `token_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` blob NULL,
  `authentication` blob NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_refresh_token
-- ----------------------------
INSERT INTO `oauth_refresh_token` VALUES ('4cabc0e9bcfa34131342209bdaf275eb', 0xACED00057372004C6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744578706972696E674F417574683252656672657368546F6B656E2FDF47639DD0C9B70200014C000A65787069726174696F6E7400104C6A6176612F7574696C2F446174653B787200446F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744F417574683252656672657368546F6B656E73E10E0A6354D45E0200014C000576616C75657400124C6A6176612F6C616E672F537472696E673B787074001B56452D377744386D70414A34497A662D49345F456450316F31626F7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018AA760D12D78, 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000009740004636F6465740006536C4B4F684C74000A6772616E745F74797065740012617574686F72697A6174696F6E5F636F646574000573636F706574000A7265616420777269746574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F65326566636666663936383964633462366166363764373865313039363934647400057374617465740020346635653763303462313731306262653836376535376431373434613534373874000D636C69656E745F7365637265747400225332456E65487864745E4D48684276384E253233245E7479366E71244E5159324E6474000A647565726F735F7569647400203466356537633034623137313062626538363765353764313734346135343738740009636C69656E745F696474000C61646D696E2D647565726F7378737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E002E770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E002E770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E002E770C000000103F4000000000000171007E0020787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00434C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00434C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E004378707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E00470000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E00470000018AA6E3204374000A57696E646F77732031307371007E002E770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00434C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00435B0007726F6C6549647371007E00554C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00434C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00544C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0054787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00434C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00434C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E005670707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E004974000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0048000000017371007E0047000000000000006570707400013171007E00497400103136343737303730374071712E636F6D7371007E005977080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E00555B00076D656E7549647371007E00554C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00434C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00604C000673746174757371007E000F7871007E005670707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E0047000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E00687400013078740001307400013071007E007674000561646D696E71007E0076);

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'SYSTEM', '0 0/4 * * * ? ', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME5', 'SYSTEM', '0 0/1 * * * ? ', 'Asia/Shanghai');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED85078707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001307800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED85078707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED85078707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'SYSTEM', NULL, 'com.fastbee.quartz.util.QuartzJobExecution', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001869759B0B878707400007070707400013074000E3020302F34202A202A202A203F2074002070726F7047657453657276696365496D706C2E666574636850726F706572747974000653595354454D7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000047400126D6F64627573E4BA91E7ABAFE8BDAEE8AFA274000131740001307800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME5', 'SYSTEM', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000187118D07E078707400007070707400013174000E3020302F31202A202A202A203F207400286465766963654A6F622E74696D696E6755706461746544657669636553746174757353746174757374000653595354454D7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000005740012E8AEBEE5A487E5AE9AE697B6E4BBBBE58AA174000131740001307800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'beecue1680023933011', 1680023961720, 15000);

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1680023970000, 1680023960000, 5, 'WAITING', 'CRON', 1680023946000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1680023955000, -1, 5, 'PAUSED', 'CRON', 1680023947000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1680023960000, -1, 5, 'PAUSED', 'CRON', 1680023948000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'SYSTEM', 'TASK_CLASS_NAME4', 'SYSTEM', NULL, 1680024000000, -1, 5, 'WAITING', 'CRON', 1680023950000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME5', 'SYSTEM', 'TASK_CLASS_NAME5', 'SYSTEM', NULL, 1680024000000, -1, 5, 'WAITING', 'CRON', 1680023951000, 0, NULL, -1, '');

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`auth_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方授权表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2021-12-15 21:36:18', 'admin', '2021-12-24 22:43:33', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2023-03-10 23:29:21', '', NULL, '是否开启验证码功能（true开启，false关闭）');

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 778 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_dict_data` VALUES (154, 1, '微信登录', 'WECHAT', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2022-04-20 16:41:33', 'admin', '2023-09-22 10:27:54', NULL);
INSERT INTO `sys_dict_data` VALUES (155, 2, 'QQ登录', 'QQ', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2022-04-20 16:42:46', 'admin', '2023-09-22 10:28:03', NULL);
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
INSERT INTO `sys_dict_data` VALUES (198, 0, 'MQTT', 'MQTT', 'iot_transport_type', NULL, 'default', 'N', '0', 'admin', '2023-02-28 16:35:40', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (199, 1, 'TCP', 'TCP', 'iot_transport_type', NULL, 'default', 'N', '0', 'admin', '2023-02-28 16:35:51', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (201, 2, 'UDP', 'UDP', 'iot_transport_type', NULL, 'default', 'N', '0', 'admin', '2023-02-28 16:36:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (230, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-03-10 23:28:32', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (231, 0, '事件上报', '3', 'iot_event_type', NULL, 'danger', 'N', '0', 'admin', '2023-03-29 00:25:28', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (232, 0, '设备上线', '5', 'iot_event_type', NULL, 'success', 'N', '0', 'admin', '2023-03-29 00:25:52', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (233, 0, '设备离线', '6', 'iot_event_type', NULL, 'info', 'N', '0', 'admin', '2023-03-29 00:26:09', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (234, 0, '服务下发', '1', 'iot_function_type', NULL, 'primary', 'N', '0', 'admin', '2023-03-29 00:38:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (235, 0, '属性获取', '2', 'iot_function_type', NULL, 'success', 'N', '0', 'admin', '2023-03-29 00:38:44', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (237, 0, '读写', '0', 'iot_data_read_write', NULL, 'primary', 'N', '0', 'admin', '2023-04-09 02:12:05', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (238, 0, '只读', '1', 'iot_data_read_write', NULL, 'info', 'N', '0', 'admin', '2023-04-09 02:12:19', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (239, 0, '全部设备', '1', 'oat_update_limit', NULL, 'default', 'N', '0', 'admin', '2023-04-09 23:57:06', 'admin', '2023-04-11 11:53:57', NULL);
INSERT INTO `sys_dict_data` VALUES (240, 1, '指定设备', '2', 'oat_update_limit', NULL, 'default', 'N', '0', 'admin', '2023-04-11 11:53:28', 'admin', '2023-04-11 11:53:52', NULL);
INSERT INTO `sys_dict_data` VALUES (241, 4, 'GB28181', 'GB28181', 'iot_transport_type', NULL, 'primary', 'N', '0', 'admin', '2023-05-12 14:25:39', 'admin', '2023-05-12 14:26:09', NULL);
INSERT INTO `sys_dict_data` VALUES (242, 1, '02(读离散量输入)', '2', 'iot_modbus_status_code', NULL, 'default', 'N', '0', 'admin', '2023-07-03 10:16:48', 'admin', '2023-07-03 10:17:35', NULL);
INSERT INTO `sys_dict_data` VALUES (243, 3, '04(读输入寄存器)', '4', 'iot_modbus_status_code', NULL, 'default', 'N', '0', 'admin', '2023-07-03 10:17:18', 'admin', '2023-07-03 10:17:58', NULL);
INSERT INTO `sys_dict_data` VALUES (247, 4, '微信开放平台网站应用', 'wechat_open_web', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (248, 5, '微信开放平台移动应用', 'wechat_open_mobile', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:29:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (249, 6, '微信开放平台小程序', 'wechat_open_mini_program', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:38:12', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (250, 0, '16位 无符号', 'ushort', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:11:54', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (251, 1, '16位 有符号', 'short', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:12:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (252, 2, '32位 有符号(ABCD)', 'long-ABCD', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:12:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (253, 3, '32位 有符号(CDAB)', 'long-CDAB', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:13:21', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (254, 4, '32位 无符号(ABCD)', 'ulong-ABCD', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:13:42', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (255, 5, '32位 无符号(CDAB)', 'ulong-CDAB', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:14:06', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (256, 6, '32位 浮点数(ABCD)', 'float-ABCD', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:14:28', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (257, 7, '32位 浮点数(CDAB)', 'float-CDAB', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:14:50', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (258, 8, '位', 'bit', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:15:13', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (259, 0, '电灯', 'LIGHT', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (260, 0, '空调', 'AIR_CONDITION', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (261, 0, '窗帘', 'CURTAIN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (262, 0, '窗纱', 'CURT_SIMP', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (263, 0, '插座', 'SOCKET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (264, 0, '开关', 'SWITCH', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (265, 0, '冰箱', 'FRIDGE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (266, 0, '净水器', 'WATER_PURIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (267, 0, '加湿器', 'HUMIDIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (268, 0, '除湿器', 'DEHUMIDIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (269, 0, '电磁炉', 'INDUCTION_COOKER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (270, 0, '空气净化器', 'AIR_PURIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (271, 0, '洗衣机', 'WASHING_MACHINE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (272, 0, '热水器', 'WATER_HEATER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (273, 0, '燃气灶', 'GAS_STOVE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (274, 0, '电视机', 'TV_SET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (275, 0, '网络盒子', 'OTT_BOX', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (276, 0, '油烟机', 'RANGE_HOOD', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (277, 0, '电风扇', 'FAN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (278, 0, '投影仪', 'PROJECTOR', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (279, 0, '扫地机器人', 'SWEEPING_ROBOT', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (280, 0, '热水壶', 'KETTLE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (281, 0, '微波炉', 'MICROWAVE_OVEN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (282, 0, '压力锅', 'PRESSURE_COOKER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (283, 0, '电饭煲', 'RICE_COOKER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (284, 0, '破壁机', 'HIGH_SPEED_BLENDER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (285, 0, '新风机', 'AIR_FRESHER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (286, 0, '晾衣架', 'CLOTHES_RACK', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (287, 0, '烤箱设备', 'OVEN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (288, 0, '蒸烤箱', 'STEAM_OVEN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (289, 0, '蒸箱', 'STEAM_BOX', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (290, 0, '电暖器', 'HEATER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (291, 0, '开窗器', 'WINDOW_OPENER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (292, 0, '摄像头', 'WEBCAM', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (293, 0, '相机', 'CAMERA', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (294, 0, '机器人', 'ROBOT', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (295, 0, '打印机', 'PRINTER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (296, 0, '饮水机', 'WATER_COOLER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (297, 0, '鱼缸', 'FISH_TANK', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (298, 0, '浇花器', 'WATERING_DEVICE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (299, 0, '机顶盒', 'SET_TOP_BOX', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (300, 0, '香薰机', 'AROMATHERAPY_MACHINE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (301, 0, 'DVD', 'DVD', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (302, 0, '鞋柜', 'SHOE_CABINET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (303, 0, '走步机', 'WALKING_MACHINE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (304, 0, '跑步机', 'TREADMILL', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (305, 0, '床', 'BED', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (306, 0, '浴霸', 'YUBA', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (307, 0, '花洒', 'SHOWER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (308, 0, '浴缸', 'BATHTUB', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (309, 0, '消毒柜', 'DISINFECTION_CABINET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (310, 0, '洗碗机', 'DISHWASHER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (311, 0, '沙发品类', 'SOFA', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (312, 0, '门铃', 'DOOR_BELL', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (313, 0, '电梯', 'ELEVATOR', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (314, 0, '体重秤', 'WEIGHT_SCALE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (315, 0, '体脂秤', 'BODY_FAT_SCALE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (316, 0, '壁挂炉', 'WALL_HUNG_GAS_BOILER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (317, 0, '特定设备的组合场景', 'SCENE_TRIGGER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, '描述特定设备的组合场景，设备之间没有相互关联，无特定操作顺序。 例如“打开睡眠模式”包括关灯和锁上房门，但是关灯和锁上房门之间没有必然联系，可以先关灯然后锁上房门，也可以先锁上房门后关灯');
INSERT INTO `sys_dict_data` VALUES (318, 0, '特定设备的组合场景', 'ACTIVITY_TRIGGER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, '描述特定设备的组合场景。场景中的设备必须以指定顺序操作。如“观看优酷视频”场景中必须先打开电视机，然后打开HDMI1');
INSERT INTO `sys_dict_data` VALUES (319, 0, '打开', 'turnOn', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (320, 0, '关闭', 'turnOff', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (321, 0, '定时打开', 'timingTurnOn', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (322, 0, '定时关闭', 'timingTurnOff', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (323, 0, '暂停', 'pause', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (324, 0, '继续', 'continue', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (325, 0, '设置颜色', 'setColor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (326, 0, '设置灯光色温', 'setColorTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (327, 0, '增高灯光色温', 'incrementColorTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (328, 0, '降低灯光色温', 'decrementColorTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (329, 0, '设置灯光亮度', 'setBrightnessPercentage', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (330, 0, '调亮灯光', 'incrementBrightnessPercentage', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (331, 0, '调暗灯光', 'decrementBrightnessPercentage', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (332, 0, '设置功率', 'setPower', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (333, 0, '增大功率', 'incrementPower', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (334, 0, '减小功率', 'decrementPower', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (335, 0, '升高温度', 'incrementTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (336, 0, '降低温度', 'decrementTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (337, 0, '设置温度', 'setTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (338, 0, '增加风速', 'incrementFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (339, 0, '减小风速', 'decrementFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (340, 0, '设置风速', 'setFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (341, 0, '设置档位', 'setGear', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (342, 0, '设置模式', 'setMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (343, 0, '取消设置的模式', 'unSetMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (344, 0, '定时设置模式', 'timingSetMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (345, 0, '定时取消设置的模式', 'timingUnsetMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (346, 0, '调高音量', 'incrementVolume', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (347, 0, '调低音量', 'decrementVolume', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (348, 0, '设置音量', 'setVolume', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (349, 0, '设置静音状态', 'setVolumeMute', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (350, 0, '上一个频道', 'decrementTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (351, 0, '下一个频道', 'incrementTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (352, 0, '设置频道', 'setTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (353, 0, '返回上个频道', 'returnTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (354, 0, '开始充电', 'chargeTurnOn', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (355, 0, '停止充电', 'chargeTurnOff', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (356, 0, '查询开关状态', 'getTurnOnState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (357, 0, '查询油量', 'getOilCapacity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (358, 0, '查询电量', 'getElectricityCapacity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (359, 0, '上锁/解锁', 'setLockState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (360, 0, '查询锁状态', 'getLockState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (361, 0, '设置吸力', 'setSuction', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (362, 0, '设置水量', 'setWaterLevel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (363, 0, '设置清扫位置', 'setCleaningLocation', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (364, 0, '执行自定义复杂动作', 'setComplexActions', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (365, 0, '设置移动方向', 'setDirection', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (366, 0, '打印', 'submitPrint', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (367, 0, '查询PM2.5', 'getAirPM25', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (368, 0, '查询PM10', 'getAirPM10', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (369, 0, '查询二氧化碳含量', 'getCO2Quantity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (370, 0, '查询空气质量', 'getAirQualityIndex', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (371, 0, '查询温度（当前温度和目标温度）', 'getTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (372, 0, '查询当前温度', 'getTemperatureReading', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (373, 0, '查询目标温度', 'getTargetTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (374, 0, '查询湿度', 'getHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (375, 0, '查询目标湿度', 'getTargetHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (376, 0, '查询水质', 'getWaterQuality', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (377, 0, '查询设备所有状态', 'getState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (378, 0, '查询剩余时间', 'getTimeLeft', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (379, 0, '查询运行状态', 'getRunningStatus', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (380, 0, '查询运行时间', 'getRunningTime', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (381, 0, '查询设备所在位置', 'getLocation', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (382, 0, '设备定时', 'setTimer', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (383, 0, '取消设备定时', 'timingCancel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (384, 0, '设备复位', 'reset', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (385, 0, '升高高度', 'incrementHeight', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (386, 0, '降低高度', 'decrementHeight', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (387, 0, '设置摆风角度', 'setSwingAngle', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (388, 0, '查询风速', 'getFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (389, 0, '设置湿度模式', 'setHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (390, 0, '增大湿度', 'incrementHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (391, 0, '降低湿度', 'decrementHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (392, 0, '增大雾量', 'incrementMist', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (393, 0, '见效雾量', 'decrementMist', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (394, 0, '设置雾量', 'setMist', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (395, 0, '设备启动', 'startUp', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (396, 0, '设置电梯楼层', 'setFloor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (397, 0, '电梯按下', 'decrementFloor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (398, 0, '电梯按上', 'incrementFloor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (399, 0, '增加速度', 'incrementSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (400, 0, '降低速度', 'decrementSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (401, 0, '设置速度', 'setSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (402, 0, '获取速度', 'getSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (403, 0, '获取跑步信息', 'getMotionInfo', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (404, 0, '打开灶眼', 'turnOnBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (405, 0, '关闭灶眼', 'turnOffBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (406, 0, '定时打开灶眼', 'timingTurnOnBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (407, 0, '定时关闭灶眼', 'timingTurnOffBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (408, 7, '微信开放平台网站应用个人中心绑定', 'wechat_open_web_bind', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2023-10-09 11:28:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (749, 1, 'Java脚本引擎', 'java', 'rule_script_language', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:51:09', 'admin', '2023-11-04 01:51:42', NULL);
INSERT INTO `sys_dict_data` VALUES (750, 2, 'JavaScript脚本引擎', 'js', 'rule_script_language', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:51:36', 'admin', '2023-11-05 10:28:30', NULL);
INSERT INTO `sys_dict_data` VALUES (751, 1, '普通脚本节点', 'script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:53:11', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (752, 2, '选择脚本节点 (switch)', 'switch_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:53:32', 'admin', '2023-11-04 01:56:44', NULL);
INSERT INTO `sys_dict_data` VALUES (753, 3, '条件脚本节点 (if)', 'if_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:53:48', 'admin', '2023-11-04 01:56:55', NULL);
INSERT INTO `sys_dict_data` VALUES (754, 4, '数量循环节点 (for)', 'for_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:54:11', 'admin', '2023-11-04 01:57:07', NULL);
INSERT INTO `sys_dict_data` VALUES (755, 5, '条件循环节点 (while)', 'while_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:54:30', 'admin', '2023-11-04 01:57:16', NULL);
INSERT INTO `sys_dict_data` VALUES (756, 6, '退出循环节点 (break)', 'break_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:54:50', 'admin', '2023-11-04 01:57:29', NULL);
INSERT INTO `sys_dict_data` VALUES (757, 3, 'groovy脚本引擎', 'groovy', 'rule_script_language', NULL, 'default', 'N', '0', 'admin', '2023-11-05 10:29:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (767, 1, '设备上报', '1', 'rule_script_event', NULL, 'primary', 'N', '0', 'admin', '2023-12-19 11:40:34', 'admin', '2023-12-20 02:23:43', NULL);
INSERT INTO `sys_dict_data` VALUES (768, 2, '平台下发', '2', 'rule_script_event', NULL, 'warning', 'N', '0', 'admin', '2023-12-19 11:40:46', 'admin', '2023-12-20 02:23:51', NULL);
INSERT INTO `sys_dict_data` VALUES (769, 3, '设备上线', '3', 'rule_script_event', NULL, 'success', 'N', '0', 'admin', '2023-12-19 11:40:58', 'admin', '2023-12-20 02:24:00', NULL);
INSERT INTO `sys_dict_data` VALUES (770, 4, '设备离线', '4', 'rule_script_event', NULL, 'info', 'N', '0', 'admin', '2023-12-19 11:41:09', 'admin', '2023-12-20 02:24:08', NULL);
INSERT INTO `sys_dict_data` VALUES (771, 1, '数据流', '1', 'rule_script_purpose', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:41:39', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (772, 2, '触发器', '2', 'rule_script_purpose', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:41:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (773, 3, '执行动作', '3', 'rule_script_purpose', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:41:59', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (774, 1, '消息重发', '1', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:42:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (775, 2, '消息通知', '2', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:43:18', 'admin', '2023-12-19 11:43:38', NULL);
INSERT INTO `sys_dict_data` VALUES (776, 3, 'Http推送', '3', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:43:33', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (777, 4, 'Mqtt桥接', '4', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:43:54', '', NULL, NULL);
-- 视频模块新增字典
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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 207 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_dict_type` VALUES (122, '轮询方式', 'data_collect_type', '0', 'admin', '2023-02-28 13:55:45', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (123, '批量采集时间', 'iot_modbus_poll_time', '0', 'admin', '2023-02-28 14:38:21', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (124, '寄存器功能码', 'iot_modbus_status_code', '0', 'admin', '2023-02-28 15:19:02', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (125, '传输协议类型', 'iot_transport_type', '0', 'admin', '2023-02-28 16:35:20', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (126, '设备事件类型', 'iot_event_type', '0', 'admin', '2023-03-29 00:24:51', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (127, '指令下发类型', 'iot_function_type', '0', 'admin', '2023-03-29 00:37:51', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (128, '读写类型', 'iot_data_read_write', '0', 'admin', '2023-04-09 02:11:14', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (129, '升级范围', 'oat_update_limit', '0', 'admin', '2023-04-09 23:51:45', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (130, '云存储平台类型', 'oss_platform_type', '0', 'admin', '2023-04-12 00:26:09', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (131, 'modbus数据类型', 'iot_modbus_data_type', '0', 'admin', '2023-09-04 13:54:17', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (132, '小度音箱关联设备', 'dueros_related_device', '0', 'admin', '2023-09-22 09:45:15', 'admin', '2023-09-22 09:45:15', '小度音箱支持的设备、场景类型，在设备下配置关联');
INSERT INTO `sys_dict_type` VALUES (133, '小度音箱操作类型', 'dueros_operate_type', '0', 'admin', '2023-09-22 09:45:15', 'admin', '2023-09-22 09:45:15', '小度音箱智能家居设备操作类型，在产品物模型下配置');
INSERT INTO `sys_dict_type` VALUES (198, '规则脚本类型', 'rule_script_type', '0', 'admin', '2023-11-04 01:48:50', 'admin', '2023-11-04 01:50:16', NULL);
INSERT INTO `sys_dict_type` VALUES (199, '规则脚本语言', 'rule_script_language', '0', 'admin', '2023-11-04 01:50:06', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (204, '规则脚本事件', 'rule_script_event', '0', 'admin', '2023-12-19 11:33:48', '', NULL, '1=设备上报，2=平台下发，3=设备上线，4=设备离线');
INSERT INTO `sys_dict_type` VALUES (205, '规则脚本用途', 'rule_script_purpose', '0', 'admin', '2023-12-19 11:38:18', '', NULL, '1=数据流，2=触发器，3=执行动作');
INSERT INTO `sys_dict_type` VALUES (206, '规则脚本动作', 'rule_script_action', '0', 'admin', '2023-12-19 11:39:58', '', NULL, '1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储');

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO `sys_job` VALUES (4, 'modbus云端轮询', 'SYSTEM', 'propGetServiceImpl.fetchProperty', '0 0/1 * * * ? ', '1', '0', '1', 'admin', '2023-02-28 17:28:03', 'admin', '2024-04-23 09:53:31', '');
INSERT INTO `sys_job` VALUES (5, '设备定时任务', 'SYSTEM', 'deviceJob.timingUpdateDeviceStatusStatus', '0 0/1 * * * ? ', '1', '1', '1', 'admin', '2023-03-24 10:57:48', 'admin', '2023-03-31 21:14:55', '');

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

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
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3058 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 4, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-12-15 21:36:18', 'admin', '2023-09-16 16:42:52', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 5, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-12-15 21:36:18', 'admin', '2023-08-24 17:21:20', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 6, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2021-12-15 21:36:18', 'admin', '2023-08-24 17:21:28', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '蜂信物联', 0, 9, 'http://fastbee.cn', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2021-12-15 21:36:18', 'admin', '2023-08-24 17:21:59', '若依官网地址');
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
INSERT INTO `sys_menu` VALUES (124, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2023-03-10 23:22:42', '', NULL, '缓存列表菜单');
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
INSERT INTO `sys_menu` VALUES (1065, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2023-03-10 23:23:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '设备管理', 0, 0, 'iot', NULL, NULL, 1, 0, 'M', '0', '0', '', 'iot', 'admin', '2021-12-15 23:57:06', 'admin', '2021-12-26 23:55:54', '');
INSERT INTO `sys_menu` VALUES (2001, '产品分类', 2000, 2, 'category', 'iot/category/index', NULL, 1, 0, 'C', '0', '0', 'iot:category:list', 'category', 'admin', '2021-12-16 00:40:02', 'admin', '2021-12-26 23:56:20', '产品分类菜单');
INSERT INTO `sys_menu` VALUES (2002, '产品分类查询', 2001, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:query', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '产品分类新增', 2001, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:add', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '产品分类修改', 2001, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:edit', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '产品分类删除', 2001, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:remove', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '产品分类导出', 2001, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:export', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '设备管理', 2000, 5, 'device', 'iot/device/index', NULL, 1, 0, 'C', '0', '0', 'iot:device:list', 'device', 'admin', '2021-12-16 00:40:12', 'admin', '2022-01-08 15:47:14', '设备菜单');
INSERT INTO `sys_menu` VALUES (2008, '设备查询', 2007, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:query', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '设备新增', 2007, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:add', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '设备修改', 2007, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:edit', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '设备删除', 2007, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:remove', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '设备导出', 2007, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:export', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '设备分组', 2000, 4, 'group', 'iot/group/index', NULL, 1, 0, 'C', '0', '0', 'iot:group:list', 'group', 'admin', '2021-12-16 00:40:31', 'admin', '2021-12-26 23:56:54', '设备分组菜单');
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
INSERT INTO `sys_menu` VALUES (2104, 'EMQ管理', 0, 8, 'http://81.71.97.58:18083/', NULL, NULL, 0, 0, 'M', '0', '0', '', 'mq', 'admin', '2022-02-26 00:42:12', 'admin', '2023-09-26 00:07:24', '');
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
INSERT INTO `sys_menu` VALUES (2141, '三方登录', 1, 12, 'platform', 'iot/platform/index', NULL, 1, 1, 'C', '0', '0', 'iot:platform:list', 'cloud', 'admin', '2022-04-11 18:55:34', 'admin', '2023-08-23 11:26:52', '');
INSERT INTO `sys_menu` VALUES (2142, '平台查询', 2142, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:platform:query', '#', 'admin', '2022-04-11 19:10:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2147, '设备分享', 2007, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:device:share', '#', 'admin', '2022-06-10 01:08:40', 'admin', '2022-06-10 01:10:46', '');
INSERT INTO `sys_menu` VALUES (2148, '设备定时', 2007, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:device:timer', '#', 'admin', '2022-06-10 01:10:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2149, '大屏展示', 3047, 5, 'https://iot.fastbee.cn/bigScreen', NULL, NULL, 0, 0, 'M', '0', '0', '', 'monitor-a', 'admin', '2022-08-13 22:32:11', 'admin', '2023-08-23 23:11:11', '');
INSERT INTO `sys_menu` VALUES (3007, '协议管理', 2000, 6, 'protocol', 'iot/protocol/index', NULL, 1, 0, 'C', '0', '0', 'iot:protocol:list', 'connect', 'admin', '2023-02-28 11:26:54', 'admin', '2023-04-12 22:02:14', '协议菜单');
INSERT INTO `sys_menu` VALUES (3008, '协议查询', 3007, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:protocol:query', '#', 'admin', '2023-02-28 11:26:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3009, '协议新增', 3007, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:protocol:add', '#', 'admin', '2023-02-28 11:26:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3010, '协议修改', 3007, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:protocol:edit', '#', 'admin', '2023-02-28 11:26:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3011, '协议删除', 3007, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:protocol:remove', '#', 'admin', '2023-02-28 11:26:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3012, '协议导出', 3007, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:protocol:export', '#', 'admin', '2023-02-28 11:26:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3031, 'Netty管理', 0, 3, 'netty', NULL, NULL, 1, 0, 'M', '0', '0', '', 'mq', 'admin', '2022-02-26 00:42:12', 'admin', '2023-09-26 00:11:57', '');
INSERT INTO `sys_menu` VALUES (3032, '客户端', 3031, 1, 'client', 'iot/netty/clients', NULL, 1, 0, 'C', '0', '0', 'monitor:server:list', 'client', 'admin', '2022-02-26 00:45:39', 'admin', '2023-08-23 23:38:08', '');
INSERT INTO `sys_menu` VALUES (3033, '事件日志', 2000, 1, 'log', 'iot/log/index', NULL, 1, 0, 'F', '0', '0', 'iot:event:list', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '事件日志菜单');
INSERT INTO `sys_menu` VALUES (3034, '事件日志查询', 3033, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:query', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3035, '事件日志新增', 3033, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:add', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3036, '事件日志修改', 3033, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:edit', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3037, '事件日志删除', 3033, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:remove', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3038, '事件日志导出', 3033, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:export', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3047, '数据可视化', 0, 7, 'screen', NULL, NULL, 1, 0, 'M', '0', '0', '', 'monitor-a', 'admin', '2023-08-23 23:09:28', 'admin', '2023-08-24 17:21:48', '');
INSERT INTO `sys_menu` VALUES (3048, 'Mqtt统计', 3031, 2, 'mqtt', 'iot/netty/mqtt', NULL, 1, 0, 'C', '0', '0', 'monitor:server:list', 'monitor', 'admin', '2023-08-23 23:40:28', 'admin', '2023-08-23 23:40:38', '');
INSERT INTO `sys_menu` VALUES (3050, '规则引擎', 0, 4, 'ruleengine', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'channel', 'admin', '2024-04-22 16:28:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3051, '规则脚本', 3050, 2, 'script', 'iot/scene/script', NULL, 1, 0, 'C', '0', '0', 'iot:script:list', 'code', 'admin', '2024-04-22 16:30:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3052, '规则脚本查询', 3051, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:query', '#', 'admin', '2024-04-22 16:30:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3053, '规则脚本新增', 3051, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:add', '#', 'admin', '2024-04-22 16:31:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3054, '规则脚本修改', 3051, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:edit', '#', 'admin', '2024-04-22 16:32:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3056, '规则脚本导出', 3051, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:export', '#', 'admin', '2024-04-22 16:33:25', 'admin', '2024-04-22 16:33:49', '');
INSERT INTO `sys_menu` VALUES (3057, '规则脚本删除', 3051, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:remove', '#', 'admin', '2024-04-22 16:35:01', '', NULL, '');
-- 视频模块新增菜单
INSERT INTO `sys_menu` VALUES (3058, '视频中心', 0, 2, 'video', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'live', 'admin', '2024-07-15 14:42:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3059, '通道管理', 3058, 1, 'sip', 'iot/sip/index', NULL, 1, 0, 'C', '0', '0', 'iot:video:list', 'swagger', 'admin', '2024-07-15 14:43:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3060, '视频配置', 3058, 2, 'mediaServer', 'iot/sip/mediaServer', NULL, 1, 0, 'C', '0', '0', NULL, 'edit', 'admin', '2024-07-15 14:48:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (3061, '告警配置', 3050, 2, 'alert', 'iot/alert/index', NULL, 1, 0, 'C', '0', '0', 'iot:alert:list', 'alert', 'admin', '2024-07-16 10:01:34', '', NULL, '');


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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, 'FastBeeV1.2版本发布', '2', 0x3C703EE8BF99E698AFE6B58BE8AF95E58685E5AEB9EFBC8CE696B0E78988E69CACE58A9FE883BDEFBC9A3C2F703E3C6F6C3E3C6C693EE694AFE68C81E5A49AE7A79FE688B73C2F6C693E3C6C693EE694AFE68C81E8AEBEE5A487E58886E4BAAB3C2F6C693E3C6C693EE694AFE68C81E697B6E5BA8FE695B0E68DAEE5BA933C2F6C693E3C6C693EE7AE80E58D95E8AEA4E8AF81E5928CE58AA0E5AF86E8AEA4E8AF81E7BB9FE4B8803C2F6C693E3C2F6F6C3E, '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-09-26 21:21:30', '管理员');
INSERT INTO `sys_notice` VALUES (2, 'FastBee sdk支持树莓派', '1', 0x3C703EE8BF99E698AFE6B58BE8AF95E58685E5AEB9EFBC8CE79BAEE5898D73646BE694AFE68C81E79A84E78988E69CAC3A3C2F703E3C703E3C62723E3C2F703E3C703E3C62723E3C2F703E3C6F6C3E3C6C693E41726475696E6F20657370383236363C2F6C693E3C6C693E41726475696E6F2065737033323C2F6C693E3C6C693E6573702D6964663C2F6C693E3C6C693E72617370626572727920E6A091E88E93E6B4BE3C2F6C693E3C2F6F6C3E, '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-09-26 21:21:41', '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '操作日志ID',
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
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '设备租户', 'tenant', 2, '5', 1, 1, '0', '0', 'admin', '2021-12-16 16:41:30', 'admin', '2023-04-12 19:53:34', '管理产品和设备');
INSERT INTO `sys_role` VALUES (3, '普通用户', 'general', 3, '5', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-02-22 08:17:37', '设备的最终用户，只能管理设备和分组');
INSERT INTO `sys_role` VALUES (4, '游客', 'visitor', 4, '1', 1, 1, '0', '0', 'admin', '2021-12-16 16:44:30', 'admin', '2023-04-12 22:11:46', '只能查询和新增系统数据');
INSERT INTO `sys_role` VALUES (5, '管理员', 'manager', 5, '1', 1, 1, '0', '0', 'admin', '2022-06-10 13:54:29', 'admin', '2023-04-12 19:50:29', '普通管理员');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_role_menu` VALUES (4, 2019);
INSERT INTO `sys_role_menu` VALUES (4, 2020);
INSERT INTO `sys_role_menu` VALUES (4, 2021);
INSERT INTO `sys_role_menu` VALUES (4, 2043);
INSERT INTO `sys_role_menu` VALUES (4, 2044);
INSERT INTO `sys_role_menu` VALUES (4, 2045);
INSERT INTO `sys_role_menu` VALUES (4, 2049);
INSERT INTO `sys_role_menu` VALUES (4, 2050);
INSERT INTO `sys_role_menu` VALUES (4, 2051);
INSERT INTO `sys_role_menu` VALUES (4, 2104);
INSERT INTO `sys_role_menu` VALUES (4, 2123);
INSERT INTO `sys_role_menu` VALUES (4, 2124);
INSERT INTO `sys_role_menu` VALUES (4, 2125);
INSERT INTO `sys_role_menu` VALUES (4, 2129);
INSERT INTO `sys_role_menu` VALUES (4, 2130);
INSERT INTO `sys_role_menu` VALUES (4, 2131);
INSERT INTO `sys_role_menu` VALUES (4, 2136);
INSERT INTO `sys_role_menu` VALUES (4, 2137);
INSERT INTO `sys_role_menu` VALUES (4, 2141);
INSERT INTO `sys_role_menu` VALUES (4, 2147);
INSERT INTO `sys_role_menu` VALUES (4, 2148);
INSERT INTO `sys_role_menu` VALUES (4, 2149);
INSERT INTO `sys_role_menu` VALUES (4, 3007);
INSERT INTO `sys_role_menu` VALUES (4, 3008);
INSERT INTO `sys_role_menu` VALUES (4, 3009);
INSERT INTO `sys_role_menu` VALUES (4, 3031);
INSERT INTO `sys_role_menu` VALUES (4, 3032);
INSERT INTO `sys_role_menu` VALUES (4, 3033);
INSERT INTO `sys_role_menu` VALUES (4, 3034);
INSERT INTO `sys_role_menu` VALUES (4, 3035);
INSERT INTO `sys_role_menu` VALUES (4, 3047);
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
INSERT INTO `sys_role_menu` VALUES (5, 124);
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
INSERT INTO `sys_role_menu` VALUES (5, 1065);
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
INSERT INTO `sys_role_menu` VALUES (5, 2104);
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
INSERT INTO `sys_role_menu` VALUES (5, 2147);
INSERT INTO `sys_role_menu` VALUES (5, 2148);
INSERT INTO `sys_role_menu` VALUES (5, 2149);
INSERT INTO `sys_role_menu` VALUES (5, 3007);
INSERT INTO `sys_role_menu` VALUES (5, 3008);
INSERT INTO `sys_role_menu` VALUES (5, 3009);
INSERT INTO `sys_role_menu` VALUES (5, 3010);
INSERT INTO `sys_role_menu` VALUES (5, 3011);
INSERT INTO `sys_role_menu` VALUES (5, 3012);
INSERT INTO `sys_role_menu` VALUES (5, 3031);
INSERT INTO `sys_role_menu` VALUES (5, 3032);
INSERT INTO `sys_role_menu` VALUES (5, 3033);
INSERT INTO `sys_role_menu` VALUES (5, 3034);
INSERT INTO `sys_role_menu` VALUES (5, 3035);
INSERT INTO `sys_role_menu` VALUES (5, 3036);
INSERT INTO `sys_role_menu` VALUES (5, 3037);
INSERT INTO `sys_role_menu` VALUES (5, 3038);
INSERT INTO `sys_role_menu` VALUES (5, 3047);

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
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '蜂信管理员', '00', '164770707@qq.com', '15888888888', '0', '', '$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUu', '0', '0', '127.0.0.1', '2024-04-22 16:04:55', 'admin', '2021-12-15 21:36:18', '', '2024-04-22 16:04:54', '管理员');
INSERT INTO `sys_user` VALUES (2, 100, 'fastbee-t1', '蜂信租户壹', '00', '', '15888888880', '0', '', '$2a$10$BAWId9C2Nrcwklzl1Ikoau4iqL8XRGvfRjq6Wl.PXWpzwAw0sXMdK', '0', '0', '61.145.97.26', '2023-08-29 14:52:27', 'admin', '2022-04-15 16:21:25', 'admin', '2023-08-29 14:52:26', NULL);
INSERT INTO `sys_user` VALUES (3, 100, 'fastbee-t2', '蜂信租户贰', '00', '', '15888888881', '0', '', '$2a$10$1zMlbW7hGpzA59gpzWGO/ObeASziQ296evjMjHrYdZnxKBLU4WUum', '0', '0', '127.0.0.1', '2022-06-12 00:54:28', 'admin', '2022-04-15 16:22:08', 'admin', '2022-06-12 00:54:30', NULL);
INSERT INTO `sys_user` VALUES (4, 100, 'fastbee-u1', '蜂信用户壹', '00', '', '15888888882', '0', '', '$2a$10$691RJMXZ9HM4sgNTExLPfO5Nw6J6cWgCvcoF9V.jKMnPk5o/8c9VS', '0', '0', '127.0.0.1', '2023-04-12 22:26:39', 'admin', '2022-04-15 16:22:37', 'admin', '2023-04-12 22:26:39', NULL);
INSERT INTO `sys_user` VALUES (5, 100, 'fastbee-u2', '蜂信用户贰', '00', '', '15888888883', '0', '', '$2a$10$x3rM39rewwbi7ayvriGMEOKUHoPCqcL2CYXPLTJRCWYPVvykFIYJq', '0', '0', '127.0.0.1', '2022-06-12 00:55:45', 'admin', '2022-04-15 16:23:13', 'admin', '2022-06-12 00:55:46', NULL);
INSERT INTO `sys_user` VALUES (6, 100, 'fastbee', '游客账号', '00', '', '15888888884', '0', '', '$2a$10$kKeZptrTnSlm0fencX4U2eq.QiaukDs.DckiUsMCwVTxh0IS2LRQ.', '0', '0', '127.0.0.1', '2023-09-21 18:39:29', 'admin', '2022-03-09 16:49:19', 'admin', '2023-09-21 18:39:28', NULL);
INSERT INTO `sys_user` VALUES (7, NULL, 'shenzehui', 'shenzehui', '00', '', '18257292958', '0', '', '$2a$10$UYKWiQF.VWfVvuksS/DMiO234Mwtz.niU7cM/noFgwLVRl7Jjt5pa', '0', '2', '39.189.61.11', '2023-04-16 14:18:09', '', '2023-04-16 14:17:59', '', '2023-04-16 14:18:08', NULL);
INSERT INTO `sys_user` VALUES (8, NULL, 'shadow', 'shadow', '00', '165456465465@qq.com', '15752221201', '0', '', '$2a$10$FXSw4fufDjecEhMxYjji3.7PkrpwkliCBoQO.h8nW0Nhk0bPpxS6u', '0', '2', '39.130.41.108', '2023-09-15 17:21:33', '', '2023-08-23 11:34:23', '', '2023-09-15 17:21:32', NULL);
INSERT INTO `sys_user` VALUES (9, NULL, 'guanshubiao', 'guanshubiao', '00', '', '15217628961', '0', '', '$2a$10$J9kJeP/dzc/SYq8Ev1rFXOigPdN50Kq8MkCX9j56/fQwDXAUkAPYi', '0', '2', '61.145.97.26', '2023-08-29 17:33:16', '', '2023-08-29 14:56:19', '', '2023-08-29 17:33:16', NULL);
INSERT INTO `sys_user` VALUES (10, NULL, 'jamon', 'jamon', '00', '', '13717112711', '0', '', '$2a$10$LMASUfB9IngDi47fQ9Eh7u003VNNh4DcjdPHMyvAQ4mdLXhQgvnpu', '0', '2', '61.145.97.26', '2023-09-01 09:06:23', '', '2023-08-29 15:06:39', '', '2023-09-01 09:06:23', NULL);
INSERT INTO `sys_user` VALUES (11, 101, 'fastbee123', 'fastbee123', '00', '', '18231210622', '0', '', '$2a$10$qpLuw5yAIDLV/.UCIaWRROxhtI2nYpJe/.tbIKwSmy2Pxm.vc26Ri', '0', '2', '27.187.242.251', '2023-08-31 16:22:40', 'admin', '2023-08-31 16:22:21', '', '2023-08-31 16:22:40', NULL);
INSERT INTO `sys_user` VALUES (12, NULL, 'shadow', 'shadow', '00', '', '15752221201', '0', '', '$2a$10$QEYxDoFO6e3wuksc2d7XIOJe0UBzY0EkYR3fKfp8pYfM5bWI4.VO6', '0', '2', '39.130.41.179', '2023-09-19 10:11:00', '', '2023-09-19 10:10:49', '', '2023-09-19 10:11:00', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

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
