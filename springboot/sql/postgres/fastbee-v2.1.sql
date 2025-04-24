/*
 Navicat Premium Data Transfer

 Source Server         : 81.71.97.58_3306
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : 81.71.97.58:3306
 Source Schema         : kaiyuan

 Target Server Type    : PostgreSQL
 Target Server Version : 130000
 File Encoding         : 65001

 Date: 21/04/2025 14:48:15
*/


-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS "public"."gen_table";
CREATE TABLE "public"."gen_table" (
  "table_id" int8 NOT NULL,
  "table_name" varchar(200),
  "table_comment" varchar(500),
  "sub_table_name" varchar(64),
  "sub_table_fk_name" varchar(64),
  "class_name" varchar(100),
  "tpl_category" varchar(200),
  "package_name" varchar(100),
  "module_name" varchar(30),
  "business_name" varchar(30),
  "function_name" varchar(50),
  "function_author" varchar(50),
  "gen_type" char(1),
  "gen_path" varchar(200),
  "options" varchar(1000),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."gen_table"."table_id" IS '编号';
COMMENT ON COLUMN "public"."gen_table"."table_name" IS '表名称';
COMMENT ON COLUMN "public"."gen_table"."table_comment" IS '表描述';
COMMENT ON COLUMN "public"."gen_table"."sub_table_name" IS '关联子表的表名';
COMMENT ON COLUMN "public"."gen_table"."sub_table_fk_name" IS '子表关联的外键名';
COMMENT ON COLUMN "public"."gen_table"."class_name" IS '实体类名称';
COMMENT ON COLUMN "public"."gen_table"."tpl_category" IS '使用的模板（crud单表操作 tree树表操作）';
COMMENT ON COLUMN "public"."gen_table"."package_name" IS '生成包路径';
COMMENT ON COLUMN "public"."gen_table"."module_name" IS '生成模块名';
COMMENT ON COLUMN "public"."gen_table"."business_name" IS '生成业务名';
COMMENT ON COLUMN "public"."gen_table"."function_name" IS '生成功能名';
COMMENT ON COLUMN "public"."gen_table"."function_author" IS '生成功能作者';
COMMENT ON COLUMN "public"."gen_table"."gen_type" IS '生成代码方式（0zip压缩包 1自定义路径）';
COMMENT ON COLUMN "public"."gen_table"."gen_path" IS '生成路径（不填默认项目路径）';
COMMENT ON COLUMN "public"."gen_table"."options" IS '其它生成选项';
COMMENT ON COLUMN "public"."gen_table"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."gen_table"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."gen_table"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."gen_table"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."gen_table"."remark" IS '备注';
COMMENT ON TABLE "public"."gen_table" IS '代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS "public"."gen_table_column";
CREATE TABLE "public"."gen_table_column" (
  "column_id" int8 NOT NULL,
  "table_id" varchar(64),
  "column_name" varchar(200),
  "column_comment" varchar(500),
  "column_type" varchar(100),
  "java_type" varchar(500),
  "java_field" varchar(200),
  "is_pk" char(1),
  "is_increment" char(1),
  "is_required" char(1),
  "is_insert" char(1),
  "is_edit" char(1),
  "is_list" char(1),
  "is_query" char(1),
  "query_type" varchar(200),
  "html_type" varchar(200),
  "dict_type" varchar(200),
  "sort" int4,
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp
)
;
COMMENT ON COLUMN "public"."gen_table_column"."column_id" IS '编号';
COMMENT ON COLUMN "public"."gen_table_column"."table_id" IS '归属表编号';
COMMENT ON COLUMN "public"."gen_table_column"."column_name" IS '列名称';
COMMENT ON COLUMN "public"."gen_table_column"."column_comment" IS '列描述';
COMMENT ON COLUMN "public"."gen_table_column"."column_type" IS '列类型';
COMMENT ON COLUMN "public"."gen_table_column"."java_type" IS 'JAVA类型';
COMMENT ON COLUMN "public"."gen_table_column"."java_field" IS 'JAVA字段名';
COMMENT ON COLUMN "public"."gen_table_column"."is_pk" IS '是否主键（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_increment" IS '是否自增（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_required" IS '是否必填（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_insert" IS '是否为插入字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_edit" IS '是否编辑字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_list" IS '是否列表字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_query" IS '是否查询字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."query_type" IS '查询方式（等于、不等于、大于、小于、范围）';
COMMENT ON COLUMN "public"."gen_table_column"."html_type" IS '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）';
COMMENT ON COLUMN "public"."gen_table_column"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."gen_table_column"."sort" IS '排序';
COMMENT ON COLUMN "public"."gen_table_column"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."gen_table_column"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."gen_table_column"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."gen_table_column"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."gen_table_column" IS '代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for iot_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_category";
CREATE TABLE "public"."iot_category" (
  "category_id" int8 NOT NULL,
  "category_name" varchar(64) NOT NULL,
  "tenant_id" int8 NOT NULL,
  "tenant_name" varchar(30) NOT NULL,
  "is_sys" int2 NOT NULL,
  "parent_id" int8,
  "order_num" int4,
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."iot_category"."category_id" IS '产品分类ID';
COMMENT ON COLUMN "public"."iot_category"."category_name" IS '产品分类名称';
COMMENT ON COLUMN "public"."iot_category"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."iot_category"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."iot_category"."is_sys" IS '是否系统通用（0-否，1-是）';
COMMENT ON COLUMN "public"."iot_category"."parent_id" IS '父级ID';
COMMENT ON COLUMN "public"."iot_category"."order_num" IS '显示顺序';
COMMENT ON COLUMN "public"."iot_category"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."iot_category"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_category"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_category"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_category"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_category"."remark" IS '备注';
COMMENT ON TABLE "public"."iot_category" IS '产品分类';

-- ----------------------------
-- Records of iot_category
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '电工照明', 1, 'admin', 1, 0, 1, '0', '', '2022-03-01 11:44:37', '', '2023-04-10 01:12:48', '例如：通断器、开关、插座、窗帘、灯');
INSERT INTO "public"."iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '家居安防', 1, 'admin', 1, 0, 2, '0', '', '2021-12-18 14:46:52', '', '2021-12-18 14:49:48', '例如：智能门锁、摄像头、智能窗帘');
INSERT INTO "public"."iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '环境电器', 1, 'admin', 1, 0, 3, '0', '', '2021-12-18 14:50:24', '', '2023-04-10 01:12:53', '例如：加湿器、风扇、扫地机器人');
INSERT INTO "public"."iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '大家电', 1, 'admin', 1, 0, 4, '0', '', '2021-12-18 14:50:58', '', '2021-12-18 14:52:30', '例如：冰箱、热水器、电视');
INSERT INTO "public"."iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '厨房电器', 1, 'admin', 1, 0, 5, '0', '', '2021-12-18 14:51:42', '', '2021-12-18 14:52:35', '例如：油烟机、烤箱、电饭煲');
INSERT INTO "public"."iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, '个护健康', 1, 'admin', 1, 0, 6, '0', '', '2021-12-18 14:52:15', '', '2021-12-18 14:52:40', '例如：洗衣机、按摩椅');
INSERT INTO "public"."iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (7, '其他', 1, 'admin', 1, 0, 7, '0', '', '2021-12-18 14:52:54', '', '2021-12-20 15:04:33', '其他');
COMMIT;

-- ----------------------------
-- Table structure for iot_device
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_device";
CREATE TABLE "public"."iot_device" (
  "device_id" int8 NOT NULL,
  "device_name" varchar(64) NOT NULL,
  "product_id" int8 NOT NULL,
  "product_name" varchar(64) NOT NULL,
  "user_id" int8 NOT NULL,
  "user_name" varchar(30) NOT NULL,
  "tenant_id" int8 NOT NULL,
  "tenant_name" varchar(30) NOT NULL,
  "serial_number" varchar(64) NOT NULL,
  "gw_dev_code" varchar(64),
  "firmware_version" float4 NOT NULL,
  "status" int2 NOT NULL,
  "rssi" int2,
  "is_shadow" int2,
  "location_way" int2,
  "things_model_value" text,
  "network_address" varchar(255),
  "network_ip" varchar(32),
  "longitude" float8,
  "latitude" float8,
  "active_time" timestamp,
  "summary" text,
  "img_url" varchar(255),
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500),
  "is_simulate" int2,
  "slave_id" int4
)
;
COMMENT ON COLUMN "public"."iot_device"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."iot_device"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."iot_device"."product_id" IS '产品ID';
COMMENT ON COLUMN "public"."iot_device"."product_name" IS '产品名称';
COMMENT ON COLUMN "public"."iot_device"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."iot_device"."user_name" IS '用户昵称';
COMMENT ON COLUMN "public"."iot_device"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."iot_device"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."iot_device"."serial_number" IS '设备编号';
COMMENT ON COLUMN "public"."iot_device"."gw_dev_code" IS '子设备网关编号';
COMMENT ON COLUMN "public"."iot_device"."firmware_version" IS '固件版本';
COMMENT ON COLUMN "public"."iot_device"."status" IS '设备状态（1-未激活，2-禁用，3-在线，4-离线）';
COMMENT ON COLUMN "public"."iot_device"."rssi" IS '信号强度（
信号极好4格[-55— 0]，
信号好3格[-70— -55]，
信号一般2格[-85— -70]，
信号差1格[-100— -85]）';
COMMENT ON COLUMN "public"."iot_device"."is_shadow" IS '是否启用设备影子(0=禁用，1=启用)';
COMMENT ON COLUMN "public"."iot_device"."location_way" IS '定位方式(1=ip自动定位，2=设备定位，3=自定义)';
COMMENT ON COLUMN "public"."iot_device"."things_model_value" IS '物模型值';
COMMENT ON COLUMN "public"."iot_device"."network_address" IS '设备所在地址';
COMMENT ON COLUMN "public"."iot_device"."network_ip" IS '设备入网IP';
COMMENT ON COLUMN "public"."iot_device"."longitude" IS '设备经度';
COMMENT ON COLUMN "public"."iot_device"."latitude" IS '设备纬度';
COMMENT ON COLUMN "public"."iot_device"."active_time" IS '激活时间';
COMMENT ON COLUMN "public"."iot_device"."summary" IS '设备摘要，格式[{"name":"device"},{"chip":"esp8266"}]';
COMMENT ON COLUMN "public"."iot_device"."img_url" IS '图片地址';
COMMENT ON COLUMN "public"."iot_device"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."iot_device"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_device"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_device"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_device"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_device"."remark" IS '备注';
COMMENT ON COLUMN "public"."iot_device"."is_simulate" IS '是否是模拟设备';
COMMENT ON COLUMN "public"."iot_device"."slave_id" IS '从机id';
COMMENT ON TABLE "public"."iot_device" IS '设备';

-- ----------------------------
-- Records of iot_device
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_device" ("device_id", "device_name", "product_id", "product_name", "user_id", "user_name", "tenant_id", "tenant_name", "serial_number", "gw_dev_code", "firmware_version", "status", "rssi", "is_shadow", "location_way", "things_model_value", "network_address", "network_ip", "longitude", "latitude", "active_time", "summary", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "is_simulate", "slave_id") VALUES (108, '温湿度开关', 41, '★智能开关产品', 1, 'admin', 1, 'admin', 'D1ELV3A5TOJS', NULL, 1.00, 4, -51, 1, 1, '[{"id": "irc", "name": "射频遥控", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "report_monitor", "name": "上报数据", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "humidity", "name": "空气湿度", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "co2", "name": "二氧化碳", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "value": " , , , ", "shadow": " , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "reset", "name": "设备重启", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "status", "name": "上报状态", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "temperature", "name": "空气温度", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "brightness", "name": "室内亮度", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}]', ' 本机地址', '127.0.0.1', 113.128512, 23.027759, '2023-02-26 00:00:00', '{"chip": "esp8266", "name": "wumei-smart", "author": "kerwincui", "create": "2022-06-06", "version": 1.6}', NULL, '0', '', '2025-02-25 23:15:56', '', '2024-04-23 15:47:11', NULL, NULL, NULL);
INSERT INTO "public"."iot_device" ("device_id", "device_name", "product_id", "product_name", "user_id", "user_name", "tenant_id", "tenant_name", "serial_number", "gw_dev_code", "firmware_version", "status", "rssi", "is_shadow", "location_way", "things_model_value", "network_address", "network_ip", "longitude", "latitude", "active_time", "summary", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "is_simulate", "slave_id") VALUES (109, '网关设备', 55, '★网关产品', 1, 'admin', 1, 'admin', 'D1PGLPG58KZ2', NULL, 1.00, 4, -73, 1, 3, '[{"id": "category_gear", "name": "运行档位", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_switch", "name": "设备开关", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_light", "ts": "2023-09-25 17:56:08.848", "name": "光照", "value": "68", "shadow": "68", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "value": " , , , , , , ", "shadow": " , , , , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "value": " , , , ", "shadow": " , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "temperature", "ts": "2023-09-25 17:56:08.582", "name": "空气温度", "value": "23.69", "shadow": "23.69", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_irc", "name": "射频遥控", "value": " , , , , , , ", "shadow": " , , , , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "brightness", "ts": "2023-09-25 17:56:08.671", "name": "室内亮度", "value": "5387", "shadow": "5387", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "report_monitor", "name": "上报监测数据", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "ts": "2023-09-25 17:56:26.188", "name": "设备开关", "value": "1,1,1, ,1,1, ", "shadow": "1,1,1, ,1,1, ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_temperature", "ts": "2023-09-25 17:56:09.203", "name": "空气温度-只读", "value": "95", "shadow": "95", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_co2", "ts": "2023-09-25 17:56:11.229", "name": "二氧化碳", "value": "3780,2612,2145,3988,5697, , ", "shadow": "3780,2612,2145,3988,5697, , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_gear", "ts": "2023-09-25 17:56:28.066", "name": "运行档位", "value": "0,0,0, ,0,0, ", "shadow": "0,0,0, ,0,0, ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_humidity", "ts": "2023-09-25 17:56:09.025", "name": "空气湿度", "value": "90", "shadow": "90", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_report_monitor", "name": "上报监测数据", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_irc", "name": "射频遥控", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "reset", "name": "设备重启", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_temperature", "ts": "2023-09-25 17:56:11.45", "name": "空气温度-只读", "value": "86,39,4,80,52, , ", "shadow": "86,39,4,80,52, , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}]', '云南省曲靖市 移通', '183.225.206.92', 104.802435, 26.496407, '2023-02-26 00:00:00', '{"chip": "esp8266", "name": "wumei-smart", "author": "kerwincui", "create": "2022-06-06", "version": 1.6}', NULL, '0', '', '2025-02-25 23:17:31', '', '2023-09-25 23:14:52', NULL, NULL, NULL);
INSERT INTO "public"."iot_device" ("device_id", "device_name", "product_id", "product_name", "user_id", "user_name", "tenant_id", "tenant_name", "serial_number", "gw_dev_code", "firmware_version", "status", "rssi", "is_shadow", "location_way", "things_model_value", "network_address", "network_ip", "longitude", "latitude", "active_time", "summary", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "is_simulate", "slave_id") VALUES (140, '视频监控', 88, '￥视频监控产品', 1, 'admin', 1, 'admin', '11010200001320000001', NULL, 1.00, 4, 0, 0, 1, NULL, '广东省 移通', '120.231.214.134', NULL, NULL, '2023-04-11 21:14:16', '{"port": 5060, "firmware": "V5.7.4", "transport": "UDP", "streammode": "UDP", "hostaddress": "192.168.2.119:5060", "manufacturer": "Hikvision"}', NULL, '0', '', '2023-04-11 21:12:35', '', '2023-04-11 22:11:01', NULL, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for iot_device_group
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_device_group";
CREATE TABLE "public"."iot_device_group" (
  "device_id" int8 NOT NULL,
  "group_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."iot_device_group"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."iot_device_group"."group_id" IS '分组ID';
COMMENT ON TABLE "public"."iot_device_group" IS '设备分组';

-- ----------------------------
-- Records of iot_device_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for iot_device_job
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_device_job";
CREATE TABLE "public"."iot_device_job" (
  "job_id" int8 NOT NULL,
  "job_name" varchar(64) NOT NULL,
  "job_group" varchar(64) NOT NULL,
  "cron_expression" varchar(255),
  "misfire_policy" varchar(20),
  "concurrent" char(1),
  "status" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500),
  "device_id" int8,
  "serial_number" varchar(64),
  "device_name" varchar(64),
  "is_advance" int2,
  "actions" text,
  "job_type" int2,
  "product_id" int8,
  "product_name" varchar(64),
  "scene_id" int8,
  "alert_id" int8,
  "alert_trigger" text
)
;
COMMENT ON COLUMN "public"."iot_device_job"."job_id" IS '任务ID';
COMMENT ON COLUMN "public"."iot_device_job"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."iot_device_job"."job_group" IS '任务组名';
COMMENT ON COLUMN "public"."iot_device_job"."cron_expression" IS 'cron执行表达式';
COMMENT ON COLUMN "public"."iot_device_job"."misfire_policy" IS '计划执行错误策略（1立即执行 2执行一次 3放弃执行）';
COMMENT ON COLUMN "public"."iot_device_job"."concurrent" IS '是否并发执行（0允许 1禁止）';
COMMENT ON COLUMN "public"."iot_device_job"."status" IS '状态（0正常 1暂停）';
COMMENT ON COLUMN "public"."iot_device_job"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_device_job"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_device_job"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_device_job"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_device_job"."remark" IS '备注信息';
COMMENT ON COLUMN "public"."iot_device_job"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."iot_device_job"."serial_number" IS '设备编号';
COMMENT ON COLUMN "public"."iot_device_job"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."iot_device_job"."is_advance" IS '是否详细corn表达式（1=是，0=否）';
COMMENT ON COLUMN "public"."iot_device_job"."actions" IS '执行的动作集合';
COMMENT ON COLUMN "public"."iot_device_job"."job_type" IS '任务类型（1=设备定时，2=设备告警，3=场景联动）';
COMMENT ON COLUMN "public"."iot_device_job"."product_id" IS '产品ID';
COMMENT ON COLUMN "public"."iot_device_job"."product_name" IS '产品名称';
COMMENT ON COLUMN "public"."iot_device_job"."scene_id" IS '场景联动ID';
COMMENT ON COLUMN "public"."iot_device_job"."alert_id" IS '告警ID';
COMMENT ON COLUMN "public"."iot_device_job"."alert_trigger" IS '定时告警触发器';
COMMENT ON TABLE "public"."iot_device_job" IS '设备定时';

-- ----------------------------
-- Records of iot_device_job
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_device_job" ("job_id", "job_name", "job_group", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark", "device_id", "serial_number", "device_name", "is_advance", "actions", "job_type", "product_id", "product_name", "scene_id", "alert_id", "alert_trigger") VALUES (4, 'P', 'DEFAULT', '0 08 11 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'admin', '2023-04-15 11:08:37', '', NULL, '', 108, 'D1ELV3A5TOJS', '★温湿度开关', 0, '[{"id": "gear", "name": "运行档位", "type": 2, "value": "2", "deviceId": 108, "deviceName": "★温湿度开关"}]', 1, 41, '★智能开关产品', NULL, NULL, NULL);
INSERT INTO "public"."iot_device_job" ("job_id", "job_name", "job_group", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark", "device_id", "serial_number", "device_name", "is_advance", "actions", "job_type", "product_id", "product_name", "scene_id", "alert_id", "alert_trigger") VALUES (5, '告警定时触发', 'DEFAULT', '0 13 11 ? * 1,2,3,4,5,6,7', '2', '1', '0', '', '2023-04-15 11:14:06', '', NULL, '', NULL, NULL, '告警定时触发', 0, '[{"id": "gear", "name": "运行档位", "type": 2, "value": "1", "productId": 96, "productName": "★网关产品"}]', 2, 96, '★网关产品', NULL, 50, '{"id": "temperature", "name": "空气温度", "type": 1, "jobId": 0, "value": "1", "params": {}, "source": 2, "status": 1, "alertId": 50, "operator": "=", "isAdvance": 0, "productId": 96, "productName": "★网关产品", "cronExpression": "0 13 11 ? * 1,2,3,4,5,6,7"}');
COMMIT;

-- ----------------------------
-- Table structure for iot_device_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_device_log";
CREATE TABLE "public"."iot_device_log" (
  "log_id" int8 NOT NULL,
  "identify" varchar(64) NOT NULL,
  "model_name" varchar(255),
  "log_type" int2 NOT NULL,
  "log_value" varchar(64) NOT NULL,
  "device_id" int8,
  "device_name" varchar(64),
  "serial_number" varchar(64),
  "is_monitor" int2 NOT NULL,
  "mode" int2 NOT NULL,
  "user_id" int8,
  "user_name" varchar(30),
  "tenant_id" int8,
  "tenant_name" varchar(30),
  "create_by" varchar(64),
  "create_time" timestamp,
  "remark" varchar(200)
)
;
COMMENT ON COLUMN "public"."iot_device_log"."log_id" IS '设备监测信息ID';
COMMENT ON COLUMN "public"."iot_device_log"."identify" IS '标识符';
COMMENT ON COLUMN "public"."iot_device_log"."model_name" IS '物模型名称';
COMMENT ON COLUMN "public"."iot_device_log"."log_type" IS '类型（1=属性上报，2=调用功能，3=事件上报，4=设备升级，5=设备上线，6=设备离线）';
COMMENT ON COLUMN "public"."iot_device_log"."log_value" IS '日志值';
COMMENT ON COLUMN "public"."iot_device_log"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."iot_device_log"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."iot_device_log"."serial_number" IS '设备编号';
COMMENT ON COLUMN "public"."iot_device_log"."is_monitor" IS '是否监测数据（1=是，0=否）';
COMMENT ON COLUMN "public"."iot_device_log"."mode" IS '模式(1=影子模式，2=在线模式，3=其他)';
COMMENT ON COLUMN "public"."iot_device_log"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."iot_device_log"."user_name" IS '用户昵称';
COMMENT ON COLUMN "public"."iot_device_log"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."iot_device_log"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."iot_device_log"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_device_log"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_device_log"."remark" IS '备注';
COMMENT ON TABLE "public"."iot_device_log" IS '设备日志';

-- ----------------------------
-- Records of iot_device_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for iot_device_template
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_device_template";
CREATE TABLE "public"."iot_device_template" (
  "id" int8 NOT NULL,
  "product_id" int8,
  "template_id" int8
)
;
COMMENT ON COLUMN "public"."iot_device_template"."id" IS '自增id';
COMMENT ON COLUMN "public"."iot_device_template"."product_id" IS '产品id';
COMMENT ON COLUMN "public"."iot_device_template"."template_id" IS '采集点模板id';
COMMENT ON TABLE "public"."iot_device_template" IS '设备采集点模板关联对象';

-- ----------------------------
-- Records of iot_device_template
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (2, 112, 1);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (3, 118, 4);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (4, 120, 6);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (5, 121, 1);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (7, 123, 11);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (33, 119, 2);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (34, 121, 3);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (35, 122, 3);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (36, 125, 6);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (38, 127, 7);
INSERT INTO "public"."iot_device_template" ("id", "product_id", "template_id") VALUES (39, 128, 1);
COMMIT;

-- ----------------------------
-- Table structure for iot_device_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_device_user";
CREATE TABLE "public"."iot_device_user" (
  "device_id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "tenant_id" int8 NOT NULL,
  "tenant_name" varchar(30) NOT NULL,
  "device_name" varchar(64) NOT NULL,
  "phonenumber" varchar(11),
  "user_name" varchar(30) NOT NULL,
  "is_owner" int2 NOT NULL,
  "perms" varchar(255),
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."iot_device_user"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."iot_device_user"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."iot_device_user"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."iot_device_user"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."iot_device_user"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."iot_device_user"."phonenumber" IS '手机号码';
COMMENT ON COLUMN "public"."iot_device_user"."user_name" IS '用户昵称';
COMMENT ON COLUMN "public"."iot_device_user"."is_owner" IS '是否为设备所有者（0=否，1=是）';
COMMENT ON COLUMN "public"."iot_device_user"."perms" IS '用户物模型权限，多个以英文逗号分隔';
COMMENT ON COLUMN "public"."iot_device_user"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."iot_device_user"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_device_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_device_user"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_device_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_device_user"."remark" IS '备注';
COMMENT ON TABLE "public"."iot_device_user" IS '设备用户';

-- ----------------------------
-- Records of iot_device_user
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (108, 1, 1, 'admin', '★温湿度开关', '15888888888', 'admin', 1, NULL, '0', '', '2023-02-25 23:15:57', '', NULL, NULL);
INSERT INTO "public"."iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (109, 1, 1, 'admin', '★网关设备', '15888888888', 'admin', 1, NULL, '0', '', '2023-02-25 23:17:32', '', NULL, NULL);
INSERT INTO "public"."iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (109, 3, 1, 'admin', '★网关设备', '15888888881', 'fastbee-t2', 0, 'ota,timer,log,monitor,statistic,reset,gear,switch', '0', '', '2023-09-03 01:17:03', '', '2023-09-03 11:05:06', NULL);
INSERT INTO "public"."iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (109, 7, 1, 'admin', '★网关设备', '18257292958', 'shenzehui', 0, NULL, '0', '', '2023-08-24 08:26:34', '', NULL, NULL);
INSERT INTO "public"."iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (109, 8, 1, 'admin', '★网关设备', '15752221201', 'shadow', 0, NULL, '0', '', '2023-08-24 08:25:44', '', NULL, NULL);
INSERT INTO "public"."iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (118, 1, 1, 'admin', '￥MODBUS网关设备', '15888888888', 'admin', 1, NULL, '0', '', '2023-02-28 16:49:18', '', NULL, NULL);
INSERT INTO "public"."iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (140, 1, 1, 'admin', '￥视频监控', '15888888888', 'admin', 1, NULL, '0', '', '2023-04-11 21:12:37', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for iot_event_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_event_log";
CREATE TABLE "public"."iot_event_log" (
  "log_id" int8 NOT NULL,
  "identify" varchar(64) NOT NULL,
  "model_name" varchar(255),
  "log_type" int2 NOT NULL,
  "log_value" varchar(64) NOT NULL,
  "device_id" int8,
  "device_name" varchar(64),
  "serial_number" varchar(64),
  "is_monitor" int2 NOT NULL,
  "mode" int2 NOT NULL,
  "user_id" int8,
  "user_name" varchar(30),
  "tenant_id" int8,
  "tenant_name" varchar(30),
  "create_by" varchar(64),
  "create_time" timestamp,
  "remark" varchar(200)
)
;
COMMENT ON COLUMN "public"."iot_event_log"."log_id" IS '设备事件日志ID';
COMMENT ON COLUMN "public"."iot_event_log"."identify" IS '标识符';
COMMENT ON COLUMN "public"."iot_event_log"."model_name" IS '物模型名称';
COMMENT ON COLUMN "public"."iot_event_log"."log_type" IS '类型（3=事件上报，5=设备上线，6=设备离线）';
COMMENT ON COLUMN "public"."iot_event_log"."log_value" IS '日志值';
COMMENT ON COLUMN "public"."iot_event_log"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."iot_event_log"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."iot_event_log"."serial_number" IS '设备编号';
COMMENT ON COLUMN "public"."iot_event_log"."is_monitor" IS '是否监测数据（1=是，0=否）';
COMMENT ON COLUMN "public"."iot_event_log"."mode" IS '模式(1=影子模式，2=在线模式，3=其他)';
COMMENT ON COLUMN "public"."iot_event_log"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."iot_event_log"."user_name" IS '用户昵称';
COMMENT ON COLUMN "public"."iot_event_log"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."iot_event_log"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."iot_event_log"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_event_log"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_event_log"."remark" IS '备注';
COMMENT ON TABLE "public"."iot_event_log" IS '事件日志';

-- ----------------------------
-- Records of iot_event_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for iot_function_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_function_log";
CREATE TABLE "public"."iot_function_log" (
  "id" int8 NOT NULL,
  "identify" varchar(64) NOT NULL,
  "fun_type" int4 NOT NULL,
  "fun_value" varchar(64) NOT NULL,
  "message_id" varchar(64),
  "device_name" varchar(64),
  "serial_number" varchar(64) NOT NULL,
  "mode" int4,
  "user_id" int8,
  "result_msg" varchar(128),
  "result_code" int4,
  "create_by" varchar(64),
  "create_time" timestamp,
  "remark" varchar(128),
  "show_value" varchar(255),
  "model_name" varchar(64),
  "reply_time" timestamp
)
;
COMMENT ON COLUMN "public"."iot_function_log"."id" IS '设备功能日志ID';
COMMENT ON COLUMN "public"."iot_function_log"."identify" IS '标识符';
COMMENT ON COLUMN "public"."iot_function_log"."fun_type" IS '1==服务下发，2=属性获取，3.OTA升级';
COMMENT ON COLUMN "public"."iot_function_log"."fun_value" IS '日志值';
COMMENT ON COLUMN "public"."iot_function_log"."message_id" IS '消息id';
COMMENT ON COLUMN "public"."iot_function_log"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."iot_function_log"."serial_number" IS '设备编号';
COMMENT ON COLUMN "public"."iot_function_log"."mode" IS '模式(1=影子模式，2=在线模式，3=其他)';
COMMENT ON COLUMN "public"."iot_function_log"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."iot_function_log"."result_msg" IS '下发结果描述';
COMMENT ON COLUMN "public"."iot_function_log"."result_code" IS '下发结果代码';
COMMENT ON COLUMN "public"."iot_function_log"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_function_log"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_function_log"."remark" IS '备注';
COMMENT ON COLUMN "public"."iot_function_log"."show_value" IS '显示值';
COMMENT ON COLUMN "public"."iot_function_log"."model_name" IS '物模型名称';
COMMENT ON COLUMN "public"."iot_function_log"."reply_time" IS '设备回复时间';
COMMENT ON TABLE "public"."iot_function_log" IS '设备服务下发日志';

-- ----------------------------
-- Records of iot_function_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for iot_group
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_group";
CREATE TABLE "public"."iot_group" (
  "group_id" int8 NOT NULL,
  "group_name" varchar(64) NOT NULL,
  "group_order" int2 NOT NULL,
  "user_id" int8 NOT NULL,
  "user_name" varchar(30) NOT NULL,
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."iot_group"."group_id" IS '分组ID';
COMMENT ON COLUMN "public"."iot_group"."group_name" IS '分组名称';
COMMENT ON COLUMN "public"."iot_group"."group_order" IS '分组排序';
COMMENT ON COLUMN "public"."iot_group"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."iot_group"."user_name" IS '用户昵称';
COMMENT ON COLUMN "public"."iot_group"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."iot_group"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_group"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_group"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_group"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_group"."remark" IS '备注';
COMMENT ON TABLE "public"."iot_group" IS '设备分组';

-- ----------------------------
-- Records of iot_group
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '卧室', 2, 1, 'admin', '0', '', '2021-12-29 13:12:42', '', '2023-04-09 22:37:06', '卧室设备');
INSERT INTO "public"."iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '厨房', 3, 1, 'admin', '0', '', '2021-12-29 13:12:59', '', '2021-12-29 13:13:48', '厨房设备');
INSERT INTO "public"."iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '书房', 4, 1, 'admin', '0', '', '2021-12-29 13:13:10', '', '2021-12-29 13:13:54', '书房设备');
INSERT INTO "public"."iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '卫生间', 5, 1, 'admin', '0', '', '2021-12-29 13:13:18', '', '2021-12-29 13:14:03', '卫生间设备');
INSERT INTO "public"."iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, '走道', 6, 1, 'admin', '0', '', '2021-12-29 13:13:26', '', '2021-12-29 13:14:11', '走道设备');
COMMIT;

-- ----------------------------
-- Table structure for iot_product
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_product";
CREATE TABLE "public"."iot_product" (
  "product_id" int8 NOT NULL,
  "product_name" varchar(64) NOT NULL,
  "protocol_code" varchar(64),
  "category_id" int8 NOT NULL,
  "category_name" varchar(64) NOT NULL,
  "tenant_id" int8 NOT NULL,
  "tenant_name" varchar(30) NOT NULL,
  "is_sys" int2 NOT NULL,
  "is_authorize" int2 NOT NULL,
  "mqtt_account" varchar(64),
  "mqtt_password" varchar(64),
  "mqtt_secret" varchar(64),
  "status" int2,
  "things_models_json" text,
  "device_type" int2,
  "network_method" int2,
  "vertificate_method" int2,
  "img_url" varchar(255),
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500),
  "transport" varchar(64)
)
;
COMMENT ON COLUMN "public"."iot_product"."product_id" IS '产品ID';
COMMENT ON COLUMN "public"."iot_product"."product_name" IS '产品名称';
COMMENT ON COLUMN "public"."iot_product"."protocol_code" IS '协议编号';
COMMENT ON COLUMN "public"."iot_product"."category_id" IS '产品分类ID';
COMMENT ON COLUMN "public"."iot_product"."category_name" IS '产品分类名称';
COMMENT ON COLUMN "public"."iot_product"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."iot_product"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."iot_product"."is_sys" IS '是否系统通用（0-否，1-是）';
COMMENT ON COLUMN "public"."iot_product"."is_authorize" IS '是否启用授权码（0-否，1-是）';
COMMENT ON COLUMN "public"."iot_product"."mqtt_account" IS 'mqtt账号';
COMMENT ON COLUMN "public"."iot_product"."mqtt_password" IS 'mqtt密码';
COMMENT ON COLUMN "public"."iot_product"."mqtt_secret" IS '产品秘钥';
COMMENT ON COLUMN "public"."iot_product"."status" IS '状态（1-未发布，2-已发布）';
COMMENT ON COLUMN "public"."iot_product"."things_models_json" IS '物模型JSON（属性、功能、事件）';
COMMENT ON COLUMN "public"."iot_product"."device_type" IS '设备类型（1-直连设备、2-网关设备、3-监控设备）';
COMMENT ON COLUMN "public"."iot_product"."network_method" IS '联网方式（1=wifi、2=蜂窝(2G/3G/4G/5G)、3=以太网、4=其他）';
COMMENT ON COLUMN "public"."iot_product"."vertificate_method" IS '认证方式（1-简单认证、2-加密认证、3-简单+加密）';
COMMENT ON COLUMN "public"."iot_product"."img_url" IS '图片地址';
COMMENT ON COLUMN "public"."iot_product"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."iot_product"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_product"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_product"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_product"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_product"."remark" IS '备注';
COMMENT ON COLUMN "public"."iot_product"."transport" IS '产品支持的传输协议';
COMMENT ON TABLE "public"."iot_product" IS '产品';

-- ----------------------------
-- Records of iot_product
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_product" ("product_id", "product_name", "protocol_code", "category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "is_authorize", "mqtt_account", "mqtt_password", "mqtt_secret", "status", "things_models_json", "device_type", "network_method", "vertificate_method", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "transport") VALUES (41, '智能开关产品', 'JSON', 1, '电工照明', 1, 'admin', 1, 0, 'FastBee', 'P47T6OD5IPFWHUM6', 'KX3TSH4Q4OS835DO', 2, '{"events": [{"id": "exception", "name": "设备发生异常", "type": 3, "order": 0, "regId": "exception", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "height_temperature", "name": "环境温度过高", "type": 3, "order": 0, "regId": "height_temperature", "isChart": 0, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}], "functions": [{"id": "report_monitor", "name": "上报数据", "type": 2, "order": 10, "regId": "report_monitor", "isChart": 0, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "type": 2, "order": 7, "regId": "message", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "type": 2, "order": 5, "regId": "light_color", "isChart": 0, "datatype": {"type": "array", "arrayType": "integer", "arrayCount": "3"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "type": 2, "order": 9, "regId": "switch", "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "reset", "name": "设备重启", "type": 2, "order": 6, "regId": "reset", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "irc", "name": "射频遥控", "type": 2, "order": 11, "regId": "irc", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "type": 2, "order": 8, "regId": "gear", "isChart": 0, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "status", "name": "上报状态", "type": 2, "order": 12, "regId": "status", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "properties": [{"id": "co2", "name": "二氧化碳", "type": 1, "order": 2, "regId": "co2", "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "brightness", "name": "室内亮度", "type": 1, "order": 4, "regId": "brightness", "isChart": 1, "datatype": {"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "temperature", "name": "空气温度", "type": 1, "order": 1, "regId": "temperature", "isChart": 1, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "humidity", "name": "空气湿度", "type": 1, "order": 3, "regId": "humidity", "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}]}', 1, 1, 3, NULL, '0', '', '2025-08-14 00:06:33', '', '2023-09-25 22:58:17', NULL, 'MQTT');
INSERT INTO "public"."iot_product" ("product_id", "product_name", "protocol_code", "category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "is_authorize", "mqtt_account", "mqtt_password", "mqtt_secret", "status", "things_models_json", "device_type", "network_method", "vertificate_method", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "transport") VALUES (55, '网关产品', 'JSON', 1, '电工照明', 1, 'admin', 1, 0, 'FastBee', 'P467433O1MT8MXS2', 'KWF32S3H95LH14LO', 2, '{"events": [{"id": "exception", "name": "设备发生异常", "type": 3, "order": 0, "regId": "exception", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "height_temperature", "name": "环境温度过高", "type": 3, "order": 0, "regId": "height_temperature", "isChart": 0, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}], "functions": [{"id": "color", "name": "状态灯色", "type": 2, "order": 0, "regId": "color", "isChart": 0, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "红色", "value": "0"}, {"text": "绿色", "value": "1"}, {"text": "蓝色", "value": "2"}, {"text": "黄色", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "type": 2, "order": 0, "regId": "message", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "type": 2, "order": 0, "regId": "light_color", "isChart": 0, "datatype": {"type": "array", "arrayType": "integer", "arrayCount": "3"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "type": 2, "order": 0, "regId": "switch", "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "irc", "name": "射频遥控", "type": 2, "order": 0, "regId": "irc", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "device", "name": "子设备", "type": 2, "order": 0, "regId": "device", "isChart": 0, "datatype": {"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "name": "设备开关", "order": 5, "datatype": {"type": "bool", "enumList": [{"text": "", "value": ""}], "trueText": "打开", "arrayType": "int", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "arrayType": "object", "arrayCount": 5}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "status", "name": "上报状态", "type": 2, "order": 0, "regId": "status", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group", "name": "功能分组", "type": 2, "order": 0, "regId": "group", "isChart": 0, "datatype": {"type": "object", "params": [{"id": "group_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "group_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isMonitor": 1, "isReadonly": 1}, {"id": "group_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isMonitor": 0, "isReadonly": 1}, {"id": "group_report_monitor", "name": "上报监测数据", "order": 7, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group_gear", "name": "运行档位", "order": 5, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "group_switch", "name": "设备开关", "order": 4, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "group_irc", "name": "红外遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}]}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "type": 2, "order": 0, "regId": "gear", "isChart": 0, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}], "properties": [{"id": "light_level", "name": "光照强度", "type": 1, "order": 0, "regId": "light_level", "isChart": 1, "datatype": {"max": 89.2, "min": 2.5, "step": 0.1, "type": "integer", "unit": "L/g"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "temperature", "name": "空气温度", "type": 1, "order": 0, "regId": "temperature", "isChart": 1, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "humidity", "name": "空气湿度", "type": 1, "order": 0, "regId": "humidity", "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}]}', 2, 2, 3, NULL, '0', '', '2025-02-25 22:51:39', '', '2023-09-16 11:46:43', NULL, 'MQTT');
INSERT INTO "public"."iot_product" ("product_id", "product_name", "protocol_code", "category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "is_authorize", "mqtt_account", "mqtt_password", "mqtt_secret", "status", "things_models_json", "device_type", "network_method", "vertificate_method", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "transport") VALUES (88, '视频监控产品', NULL, 2, '家居安防', 1, 'admin', 1, 0, 'FastBee', 'P0IB9M8A7J4R056V', 'K69914VL8175ZY21', 2, '{}', 3, 1, 3, NULL, '0', '', '2023-04-11 21:11:54', '', '2025-03-19 15:30:14', NULL, 'GB28181');
COMMIT;

-- ----------------------------
-- Table structure for iot_product_authorize
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_product_authorize";
CREATE TABLE "public"."iot_product_authorize" (
  "authorize_id" int8 NOT NULL,
  "authorize_code" varchar(32) NOT NULL,
  "product_id" int8 NOT NULL,
  "device_id" int8,
  "serial_number" varchar(64),
  "user_id" int8,
  "user_name" varchar(30),
  "status" int2,
  "del_flag" char(1) NOT NULL,
  "create_by" varchar(64) NOT NULL,
  "create_time" timestamp NOT NULL,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."iot_product_authorize"."authorize_id" IS '授权码ID';
COMMENT ON COLUMN "public"."iot_product_authorize"."authorize_code" IS '授权码';
COMMENT ON COLUMN "public"."iot_product_authorize"."product_id" IS '产品ID';
COMMENT ON COLUMN "public"."iot_product_authorize"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."iot_product_authorize"."serial_number" IS '设备编号';
COMMENT ON COLUMN "public"."iot_product_authorize"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."iot_product_authorize"."user_name" IS '用户名称';
COMMENT ON COLUMN "public"."iot_product_authorize"."status" IS '状态（1-未使用，2-使用中）';
COMMENT ON COLUMN "public"."iot_product_authorize"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."iot_product_authorize"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_product_authorize"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_product_authorize"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_product_authorize"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_product_authorize"."remark" IS '备注';
COMMENT ON TABLE "public"."iot_product_authorize" IS '产品授权码表';

-- ----------------------------
-- Records of iot_product_authorize
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for iot_protocol
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_protocol";
CREATE TABLE "public"."iot_protocol" (
  "id" int8 NOT NULL,
  "protocol_code" varchar(60) NOT NULL,
  "protocol_name" varchar(60) NOT NULL,
  "protocol_file_url" varchar(500) NOT NULL,
  "protocol_type" int4 NOT NULL,
  "jar_sign" varchar(100) NOT NULL,
  "create_time" timestamp NOT NULL,
  "update_time" timestamp NOT NULL,
  "protocol_status" int4 NOT NULL,
  "del_flag" int4 NOT NULL
)
;
COMMENT ON COLUMN "public"."iot_protocol"."id" IS '自增id';
COMMENT ON COLUMN "public"."iot_protocol"."protocol_code" IS '协议编码';
COMMENT ON COLUMN "public"."iot_protocol"."protocol_name" IS '协议名称';
COMMENT ON COLUMN "public"."iot_protocol"."protocol_file_url" IS '协议jar包,js包，c程序上传地址';
COMMENT ON COLUMN "public"."iot_protocol"."protocol_type" IS '协议类型 0:未知 1:jar，2.js,3.c';
COMMENT ON COLUMN "public"."iot_protocol"."jar_sign" IS '协议文件摘要(文件的md5)';
COMMENT ON COLUMN "public"."iot_protocol"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_protocol"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_protocol"."protocol_status" IS '0:草稿 1:启用 2:停用';
COMMENT ON COLUMN "public"."iot_protocol"."del_flag" IS '0:正常 1:删除';
COMMENT ON TABLE "public"."iot_protocol" IS '协议表';

-- ----------------------------
-- Records of iot_protocol
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_protocol" ("id", "protocol_code", "protocol_name", "protocol_file_url", "protocol_type", "jar_sign", "create_time", "update_time", "protocol_status", "del_flag") VALUES (1, 'JSON', 'JSON协议', '/', 0, '系统内置JSON编解码协议', '2023-03-01 05:46:43', '2023-04-10 14:42:12', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for iot_scene
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_scene";
CREATE TABLE "public"."iot_scene" (
  "scene_id" int8 NOT NULL,
  "scene_name" varchar(64) NOT NULL,
  "chain_name" varchar(32),
  "enable" int2,
  "user_id" int8 NOT NULL,
  "user_name" varchar(64) NOT NULL,
  "silent_period" int4,
  "cond" int2,
  "execute_mode" int2,
  "execute_delay" int4,
  "has_alert" int2,
  "application_name" varchar(32) NOT NULL,
  "el_data" text,
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."iot_scene"."scene_id" IS '场景ID';
COMMENT ON COLUMN "public"."iot_scene"."scene_name" IS '场景名称';
COMMENT ON COLUMN "public"."iot_scene"."chain_name" IS '规则名称';
COMMENT ON COLUMN "public"."iot_scene"."enable" IS '场景状态（1-启动，2-停止）';
COMMENT ON COLUMN "public"."iot_scene"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."iot_scene"."user_name" IS '用户名称';
COMMENT ON COLUMN "public"."iot_scene"."silent_period" IS '静默周期（分钟）';
COMMENT ON COLUMN "public"."iot_scene"."cond" IS '执行条件（1=或、任意条件，2=且、所有条件，3=非，不满足）';
COMMENT ON COLUMN "public"."iot_scene"."execute_mode" IS '执行方式（1=串行，顺序执行，2=并行，同时执行）';
COMMENT ON COLUMN "public"."iot_scene"."execute_delay" IS '延时执行（秒钟）';
COMMENT ON COLUMN "public"."iot_scene"."has_alert" IS '是否包含告警推送（1=包含，2=不包含）';
COMMENT ON COLUMN "public"."iot_scene"."application_name" IS '应用名称';
COMMENT ON COLUMN "public"."iot_scene"."el_data" IS '规则数据';
COMMENT ON COLUMN "public"."iot_scene"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_scene"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_scene"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_scene"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_scene"."remark" IS '备注';
COMMENT ON TABLE "public"."iot_scene" IS '场景联动';

-- ----------------------------
-- Records of iot_scene
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for iot_scene_script
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_scene_script";
CREATE TABLE "public"."iot_scene_script" (
  "script_id" varchar(32) NOT NULL,
  "scene_id" int8 NOT NULL,
  "source" int2 NOT NULL,
  "script_purpose" int2 NOT NULL,
  "product_id" int8,
  "product_name" varchar(64),
  "id" varchar(64),
  "name" varchar(64),
  "value" varchar(64),
  "operator" varchar(16),
  "type" int2,
  "device_count" int4,
  "job_id" int8,
  "cron_expression" varchar(255),
  "is_advance" int2,
  "parent_id" varchar(32),
  "parent_name" varchar(32),
  "array_index" varchar(20),
  "array_index_name" varchar(20),
  "create_by" varchar(64),
  "create_time" timestamp
)
;
COMMENT ON COLUMN "public"."iot_scene_script"."script_id" IS '脚本ID';
COMMENT ON COLUMN "public"."iot_scene_script"."scene_id" IS '场景ID';
COMMENT ON COLUMN "public"."iot_scene_script"."source" IS '触发源（1=设备触发，2=定时触发，3=产品触发,4=告警执行）';
COMMENT ON COLUMN "public"."iot_scene_script"."script_purpose" IS '脚本用途(1=数据流，2=触发器，3=执行动作)';
COMMENT ON COLUMN "public"."iot_scene_script"."product_id" IS '产品ID（用于获取对应物模型）';
COMMENT ON COLUMN "public"."iot_scene_script"."product_name" IS '产品名称';
COMMENT ON COLUMN "public"."iot_scene_script"."id" IS '物模型标识符';
COMMENT ON COLUMN "public"."iot_scene_script"."name" IS '物模型名称';
COMMENT ON COLUMN "public"."iot_scene_script"."value" IS '物模型值';
COMMENT ON COLUMN "public"."iot_scene_script"."operator" IS '操作符';
COMMENT ON COLUMN "public"."iot_scene_script"."type" IS '物模型类别（1=属性，2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线）';
COMMENT ON COLUMN "public"."iot_scene_script"."device_count" IS '设备数量';
COMMENT ON COLUMN "public"."iot_scene_script"."job_id" IS '任务ID';
COMMENT ON COLUMN "public"."iot_scene_script"."cron_expression" IS 'cron执行表达式';
COMMENT ON COLUMN "public"."iot_scene_script"."is_advance" IS '是否详细corn表达式（1=是，0=否）';
COMMENT ON COLUMN "public"."iot_scene_script"."parent_id" IS '父物模id';
COMMENT ON COLUMN "public"."iot_scene_script"."parent_name" IS '父物模名称';
COMMENT ON COLUMN "public"."iot_scene_script"."array_index" IS '数组索引';
COMMENT ON COLUMN "public"."iot_scene_script"."array_index_name" IS '数组索引名称';
COMMENT ON COLUMN "public"."iot_scene_script"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_scene_script"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."iot_scene_script" IS '场景脚本';

-- ----------------------------
-- Records of iot_scene_script
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for iot_script
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_script";
CREATE TABLE "public"."iot_script" (
  "script_id" varchar(32) NOT NULL,
  "user_id" int8 NOT NULL,
  "user_name" varchar(30) NOT NULL,
  "scene_id" int8 NOT NULL,
  "product_id" int8,
  "product_name" varchar(64),
  "script_event" int2 NOT NULL,
  "script_action" int2 NOT NULL,
  "script_purpose" int2 NOT NULL,
  "script_order" int2 NOT NULL,
  "application_name" varchar(32) NOT NULL,
  "script_name" varchar(64) NOT NULL,
  "script_data" text NOT NULL,
  "script_type" varchar(16) NOT NULL,
  "script_language" varchar(16) NOT NULL,
  "enable" int2 NOT NULL,
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."iot_script"."script_id" IS '脚本ID';
COMMENT ON COLUMN "public"."iot_script"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."iot_script"."user_name" IS '用户昵称';
COMMENT ON COLUMN "public"."iot_script"."scene_id" IS '关联场景ID';
COMMENT ON COLUMN "public"."iot_script"."product_id" IS '产品ID';
COMMENT ON COLUMN "public"."iot_script"."product_name" IS '产品名称';
COMMENT ON COLUMN "public"."iot_script"."script_event" IS '脚本事件(1=设备上报，2=平台下发，3=设备上线，4=设备离线)';
COMMENT ON COLUMN "public"."iot_script"."script_action" IS '脚本动作(1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储)';
COMMENT ON COLUMN "public"."iot_script"."script_purpose" IS '脚本用途(1=数据流，2=触发器，3=执行动作)';
COMMENT ON COLUMN "public"."iot_script"."script_order" IS '脚本执行顺序，值越大优先级越高';
COMMENT ON COLUMN "public"."iot_script"."application_name" IS '应用名，后端、规则和脚本要统一';
COMMENT ON COLUMN "public"."iot_script"."script_name" IS '脚本名';
COMMENT ON COLUMN "public"."iot_script"."script_data" IS '脚本数据';
COMMENT ON COLUMN "public"."iot_script"."script_type" IS '脚本类型：
script=普通脚本，
switch_script=选择脚本，
if_script=条件脚本，
for_script=数量循环脚本，
while_script=条件循环，
break_script=退出循环脚本';
COMMENT ON COLUMN "public"."iot_script"."script_language" IS '脚本语言（groovy | qlexpress | js | python | lua | aviator | java）';
COMMENT ON COLUMN "public"."iot_script"."enable" IS '是否生效（0-不生效，1-生效）';
COMMENT ON COLUMN "public"."iot_script"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."iot_script"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_script"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_script"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_script"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_script"."remark" IS '备注';
COMMENT ON TABLE "public"."iot_script" IS '规则引擎脚本';

-- ----------------------------
-- Records of iot_script
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_script" ("script_id", "user_id", "user_name", "scene_id", "product_id", "product_name", "script_event", "script_action", "script_purpose", "script_order", "application_name", "script_name", "script_data", "script_type", "script_language", "enable", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('D1782337038486474752', 1, 'admin', 0, 41, '★智能开关产品', 1, 1, 1, 1, 'fastbee', '消息转发规则', 'import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.hutool.core.util.NumberUtil;





//系统主题
String sysTopic = '''';
//系统数据格式
String sysPayload = '''';

// 1. 获取主题和内容
String name = msgContext.getTopic();
Long productId = msgContext.getProductId();
String serialNumber = msgContext.getSerialNumber();
String protocolCode = msgContext.getProtocolCode();
String payload = msgContext.getPayload();
System.out.println("产品id/协议编号：" + productId + " / " + protocolCode);

// 2. 转换为系统主题 /96/D1ELV3A5TOJS/property/post
sysTopic = "/" + productId + "/" + serialNumber + "/property/post" 

if("JSON".equals(protocolCode)){   
    // 3. 内容格式转换
    JSONArray newArray = new JSONArray();
    JSONObject jsonObject = JSONUtil.parseObj(payload);
    jsonObject.keySet().forEach(key -> {
        JSONObject newObject =new JSONObject();
        newObject.put("id" , key);
        newObject.put("value" , jsonObject.getStr(key));
        newArray.add(newObject);
    });
    sysPayload = newArray.toString();
}else{
    //其他协议处理
}

// 4.打印
System.out.println("新主题：" + sysTopic);
System.out.println("新内容：" + sysPayload);

// 5. 返回新的数据（必要）
msgContext.setTopic(sysTopic);
msgContext.setPayload(sysPayload);
', 'script', 'groovy', 1, '0', '', '2024-04-22 17:13:59', '', '2024-04-23 15:32:43', NULL);
COMMIT;

-- ----------------------------
-- Table structure for iot_social_platform
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_social_platform";
CREATE TABLE "public"."iot_social_platform" (
  "social_platform_id" int4 NOT NULL,
  "platform" varchar(32) NOT NULL,
  "status" char(1) NOT NULL,
  "client_id" varchar(100) NOT NULL,
  "secret_key" varchar(100) NOT NULL,
  "redirect_uri" varchar(120) NOT NULL,
  "del_flag" char(1) NOT NULL,
  "create_by" varchar(64) NOT NULL,
  "create_time" timestamp NOT NULL,
  "update_time" timestamp,
  "update_by" varchar(64),
  "remark" varchar(500),
  "bind_uri" varchar(128) NOT NULL,
  "redirect_login_uri" varchar(128) NOT NULL,
  "error_msg_uri" varchar(128) NOT NULL
)
;
COMMENT ON COLUMN "public"."iot_social_platform"."social_platform_id" IS '第三方登录平台主键';
COMMENT ON COLUMN "public"."iot_social_platform"."platform" IS '第三方登录平台';
COMMENT ON COLUMN "public"."iot_social_platform"."status" IS ' 0:启用 ,1:禁用';
COMMENT ON COLUMN "public"."iot_social_platform"."client_id" IS '第三方平台申请Id';
COMMENT ON COLUMN "public"."iot_social_platform"."secret_key" IS '第三方平台密钥';
COMMENT ON COLUMN "public"."iot_social_platform"."redirect_uri" IS '用户认证后跳转地址';
COMMENT ON COLUMN "public"."iot_social_platform"."del_flag" IS '删除标记位(0代表存在，1代表删除)';
COMMENT ON COLUMN "public"."iot_social_platform"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_social_platform"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_social_platform"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_social_platform"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_social_platform"."remark" IS '备注';
COMMENT ON COLUMN "public"."iot_social_platform"."bind_uri" IS '绑定注册登录uri,http://localhost/login?bindId=';
COMMENT ON COLUMN "public"."iot_social_platform"."redirect_login_uri" IS '跳转登录uri,http://localhost/login?loginId=';
COMMENT ON COLUMN "public"."iot_social_platform"."error_msg_uri" IS '错误提示uri,http://localhost/login?errorId=';
COMMENT ON TABLE "public"."iot_social_platform" IS '第三方登录平台控制';

-- ----------------------------
-- Records of iot_social_platform
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for iot_social_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_social_user";
CREATE TABLE "public"."iot_social_user" (
  "social_user_id" int4 NOT NULL,
  "uuid" varchar(64) NOT NULL,
  "source" varchar(32) NOT NULL,
  "access_token" varchar(255),
  "expire_in" int4,
  "refresh_token" varchar(255),
  "open_id" varchar(100),
  "uid" varchar(64),
  "access_code" varchar(64),
  "union_id" varchar(100),
  "scope" varchar(64),
  "token_type" varchar(64),
  "id_token" varchar(64),
  "mac_algorithm" varchar(64),
  "mac_key" varchar(64),
  "code" varchar(64),
  "oauth_token" varchar(64),
  "oauth_token_secret" varchar(64),
  "create_time" timestamp NOT NULL,
  "create_by" varchar(64) NOT NULL,
  "update_time" timestamp,
  "update_by" varchar(64),
  "del_flag" char(1) NOT NULL,
  "status" char(1) NOT NULL,
  "sys_user_id" int4,
  "username" varchar(64),
  "nickname" varchar(64),
  "avatar" varchar(256),
  "gender" int2,
  "source_client" varchar(64)
)
;
COMMENT ON COLUMN "public"."iot_social_user"."social_user_id" IS '第三方系统用户表主键';
COMMENT ON COLUMN "public"."iot_social_user"."uuid" IS '第三方系统的唯一ID';
COMMENT ON COLUMN "public"."iot_social_user"."source" IS '第三方用户来源';
COMMENT ON COLUMN "public"."iot_social_user"."access_token" IS '用户的授权令牌';
COMMENT ON COLUMN "public"."iot_social_user"."expire_in" IS '第三方用户的授权令牌的有效期（部分平台可能没有）';
COMMENT ON COLUMN "public"."iot_social_user"."refresh_token" IS '刷新令牌(部分平台可能没有)';
COMMENT ON COLUMN "public"."iot_social_user"."open_id" IS '第三方用户的 open id（部分平台可能没有）';
COMMENT ON COLUMN "public"."iot_social_user"."uid" IS '第三方用户的 ID(部分平台可能没有)';
COMMENT ON COLUMN "public"."iot_social_user"."access_code" IS '个别平台的授权信息（部分平台可能没有）';
COMMENT ON COLUMN "public"."iot_social_user"."union_id" IS '第三方用户的 union id(部分平台可能没有)';
COMMENT ON COLUMN "public"."iot_social_user"."scope" IS '第三方用户授予的权限(部分平台可能没有)';
COMMENT ON COLUMN "public"."iot_social_user"."token_type" IS '个别平台的授权信息（部分平台可能没有）';
COMMENT ON COLUMN "public"."iot_social_user"."id_token" IS 'id token（部分平台可能没有）';
COMMENT ON COLUMN "public"."iot_social_user"."mac_algorithm" IS '小米平台用户的附带属性（部分平台可能没有）';
COMMENT ON COLUMN "public"."iot_social_user"."mac_key" IS '小米平台用户的附带属性(部分平台可能没有)';
COMMENT ON COLUMN "public"."iot_social_user"."code" IS '用户的授权code（部分平台可能没有）';
COMMENT ON COLUMN "public"."iot_social_user"."oauth_token" IS 'Twitter平台用户的附带属性(部分平台可能没有)';
COMMENT ON COLUMN "public"."iot_social_user"."oauth_token_secret" IS 'Twitter平台用户的附带属性(部分平台可能没有)';
COMMENT ON COLUMN "public"."iot_social_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_social_user"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_social_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_social_user"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_social_user"."del_flag" IS '删除标记位(0代表存在,2代表删除)';
COMMENT ON COLUMN "public"."iot_social_user"."status" IS '绑定状态(0:未绑定,1:绑定)';
COMMENT ON COLUMN "public"."iot_social_user"."sys_user_id" IS '用户ID';
COMMENT ON COLUMN "public"."iot_social_user"."username" IS '用户名';
COMMENT ON COLUMN "public"."iot_social_user"."nickname" IS '用户昵称';
COMMENT ON COLUMN "public"."iot_social_user"."avatar" IS '用户头像';
COMMENT ON COLUMN "public"."iot_social_user"."gender" IS '用户性别';
COMMENT ON COLUMN "public"."iot_social_user"."source_client" IS '第三方用户来源客户端（web、app、小程序）';
COMMENT ON TABLE "public"."iot_social_user" IS '第三方登录用户';

-- ----------------------------
-- Records of iot_social_user
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (1, 'ojefY6BdTpoXOLjdpsFQXWixAG_Q', 'WECHAT_OPEN', '71_7qVQ56lx6qdC7mmArXFwQD8Nl6BTjayw4HJdfHdPoXS0sEHDffiSYa4k8dIK7XG7puk2asZ0s0Rj_Pk8ahqdDQICL4FumjWmXHm3ql2si-M', 7200, '71_rh7a79t0eJmC0JyJrQjABF3zZdkNhP7oAUm3Jj6Rk1skL_i4V3ITlM3ViYO0PA_NCKn9ba85pz2vttdloreR0lWmUxK-VOm3XaMt33vZ9a0', 'ojefY6BdTpoXOLjdpsFQXWixAG_Q', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-23 11:48:04', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/dNibaEkibxjJZSffkH5gQKtCg0pqfz39PGbPcQ8IhADianIaEYqibvD2JhrxYLMeQexBGVR6VOl9MR4gtsYiaxEqPFA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (2, 'ojefY6Pny526TwBwsyfUhzBB_szg', 'WECHAT_OPEN', '71_HlBJGUovm8cvZoEljoFkrAbRXtqt3mWNqxEOfMGsse-2Sie51YjkfJQbrSZySyIsf9sYTIwXj7EjbPO5GciN_xqEsSRCzyG6qIvUvkyNIBs', 7200, '71_Bc5n4-MS-25vBkt8p8BAxeuAZBawwmx4ryi-KCJxzi0OKY73HinwKYRTPZaw08kXgpD6zToRAjqIoRuyt-mNwEgfeN50hW8Unk5NuK4Bdpo', 'ojefY6Pny526TwBwsyfUhzBB_szg', NULL, NULL, 'oL1Fu589vTytNQy2okIKQnKBUmRU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-24 08:22:53', 'System', NULL, NULL, '0', '0', NULL, '🌲', '🌲', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLTLicc0w6SgPWibR5Z92j9AdW9aC4QxuFjQcJXcekbjc13fkHD7iaZc7CwEHtUq9FQalub6vOZ46LZA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (3, 'ojefY6AZPO1PPy9K4tWd8xdLWUss', 'WECHAT_OPEN', '71_x8HU8YdqqKMXts7KJ3T0hLOvmlP5YIi0pkTQ9bLA8vRusmEEUQFKyBpbG2UAFRDMEJvpp6cKGh9EGkiRdj7zSA4aHP2r-luXHSkAhP7zyvU', 7200, '71_AFMUcIv8tP4PGiHrOwJVN0B8bpCGyKXuG8ZCDiVGF5zaG10MTTLTmTJXNHJHmZzs3h6X9kbLY8sukNk83uj3QI3_J5SGOtihOUNMa9g7Ir0', 'ojefY6AZPO1PPy9K4tWd8xdLWUss', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-24 09:41:51', 'System', '2023-08-24 10:36:16', 'System', '0', '0', NULL, 'oh', 'oh', 'https://thirdwx.qlogo.cn/mmopen/vi_32/RNia2ASTn210r40Tb91yfWgmiaWXGPXF7rNnic5lkes9avGbZQ0365uZObT1JicIQpiba7MDuHicScKUxnYWWyTN5VAw/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (4, 'ojefY6JUjFaO7RBRqgcrRGLxPVFA', 'WECHAT_OPEN', '71_qkQqwgA9RYmL5oQASwBxwwR4loysQQc3YRqGJRJONSxpNrPLlLdNibDk5YINFYjfnCxwnhjVPQqhX7xHaGE_UZMX5e1JaWKCJdrgwP62LxY', 7200, '71_oEKp3JLiEtv5668rprSxidUBbcd30cZQ2Bbt_tL5XdWQX52Yb3po5t5ynFwlA4n-7dLt5rGR3E1FKb9Qw8Xso8SfSfF-4CBF9ZCjSxppIvI', 'ojefY6JUjFaO7RBRqgcrRGLxPVFA', NULL, NULL, 'oL1Fu55Rkr9A69wS6buTQz7zdkDc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-24 09:58:59', 'System', NULL, NULL, '0', '0', NULL, 'shadow 张', 'shadow 张', 'https://thirdwx.qlogo.cn/mmopen/vi_32/EcUsiaR4Y1WkyibJXHDEPAiazbERr1BXAnzZWjh2SiayuawoEaT0icDzL2dZtuu0ia6Z7AJZZbiaxDJb8iaJxTnyk7Xicgw/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (5, 'ojefY6I66aL78LElFNjsA_rY7JIE', 'WECHAT_OPEN', '71_sanZ8NfbnEANzqUTQQAY6CRoafcBaV1eS4KPtcAv_rkOlunJQyVeJJzFbXSge3QxsCvljt65TTpyiLSifSjADJdaSZGtKzhF7IXlo5km2Po', 7200, '71_JbHfJV6zy02mK8ZnCKA3Yyhe2upHOqeah6IeZxzO3CKVAcOqH7CGbsk9GFsK3bqDD1SF8jp05ncC8XfkzR5BS4A3s_QIQjt44bviFckymtE', 'ojefY6I66aL78LElFNjsA_rY7JIE', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-24 11:49:31', 'System', '2023-08-24 14:10:29', 'System', '0', '0', NULL, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/tgaqAZ2oTMAZfF4cHRPib77yOLRSv9ibPibQfkQiclB8kwBuicB3vDcLfTnfU6HWZRNRqjmSXjWYYY5fNdOAR8CSxzg/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (6, '71420ce6-5300-4495-92da-6d1a4a7e2fdd', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:32:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (7, '6ec4d0be-bde5-466b-b3cf-5b3736d15ba7', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:40:17', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (8, 'ac2d836d-29fe-4e01-9f3d-bc54d4168855', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:45:52', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (9, 'ef2510ab-8fdd-4433-b0ff-1b57ef2f0fa9', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:47:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (10, 'b7c2ee2f-d644-46b9-812d-104b1d122fe0', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:50:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (11, '214e90ab-5b09-4aec-a6d1-4100c21db1b6', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:51:42', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (12, 'a23aec75-40df-4878-b33f-a1aacc6b45f6', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 09:53:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (13, '37de2b33-e690-40f6-a981-fc7182503606', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:00:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (14, '8c1e964e-9bb8-4876-bc92-6a41faaf2097', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:09:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (15, 'a7b77ebb-0815-4983-b0ad-b9b2a37593ca', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:09:59', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (16, '0ee69f21-448a-420f-a092-68418ae96c01', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:10:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (17, '0c928db4-03b5-40c9-9971-3b13d39ba4b8', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:11:41', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (18, '8f0daa3d-f332-423b-ad37-95e740a109e8', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:12:44', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (19, 'd15e0ae9-f49d-4e55-9965-79e260e8ffd0', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:13:33', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (20, 'b4da93b9-21c7-4e76-937b-2162024a9c6c', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:14:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (21, 'a16423aa-99ce-427e-89cf-a9f13955acec', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:15:54', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (22, '7771c72d-741f-4f66-bec4-414471ebb5db', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:16:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (23, '9def0641-b670-45cc-8297-6c3171f12025', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:17:36', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (24, 'e8f70c8b-bc52-4b38-aaf7-6a8df9ffb8cd', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:18:23', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (25, 'a359a333-4348-4786-973e-f15b9fa6ce94', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:19:15', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (26, '061154f9-ac4b-4035-a549-cd602422427a', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:19:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (27, '10003d18-0b00-458d-966e-3a54b218c83b', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:21:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (28, '376f2a15-662d-4820-bb62-683dd555fdbf', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:24:01', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (29, 'd4e4fe18-1f99-4361-b509-e464fdc806a2', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:24:42', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (30, '7b37261c-b420-45d5-8cd0-7ab6e4787621', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:25:17', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (31, '7635bed2-0d6e-4924-b9d7-af0235fc2ecc', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:25:26', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (32, '6aa3715d-b3a6-4b12-8bb4-1fc3af297d99', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:26:09', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (33, '0222ba55-f5a8-4218-a23d-949ecc78c405', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:26:52', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (34, '0bb2118c-b365-4dae-943e-84e0f8dca104', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:27:50', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (35, '5c065548-d171-44b8-a5bb-b93db08b22b3', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:28:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (36, '79429286-c4c7-4db8-9902-6f10ffd26e06', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:28:53', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (37, '4eb61991-8715-427b-b6a1-6e479f3faafc', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:29:44', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (38, 'cbcf9cfb-109f-4806-9bd0-5e9a4ba0c108', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:30:33', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (39, '810f0806-21e0-487b-b2fe-c9d037b20c81', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:31:28', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (40, '7da601d4-765c-40bf-aa2d-96bdef88c9ff', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:32:23', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (41, 'e3e29354-d06b-4d18-b172-a86e563a20f1', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:33:16', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (42, 'c73ece08-7a9e-462f-ad04-e5a5ce05a8b5', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:33:47', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (43, '7b48faf5-b023-46d7-9332-8ead5d82895e', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:34:27', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (44, 'aa8db705-654d-43d9-8ec2-3b090bb9685d', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:35:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (45, 'b3f319a4-a4aa-48bd-9a43-ff03b09e9b0f', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:36:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (46, '297e229a-545e-47a1-8acd-85708430d78d', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:37:10', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (47, '74d77e94-a9c2-4fca-9b47-e1c7ea0ab419', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:37:45', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (48, '0a750c6d-2e14-4e12-bd11-5ae390b04451', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:57:10', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (49, '6b353153-2eb0-4916-ad83-f5465ccd4480', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 10:57:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (50, '10be370a-38e0-4de4-822b-e6b1a07f0ff2', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 11:47:28', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (51, '8634fc78-e8d0-447f-af90-51fd29536ae4', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:40:06', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (52, '4e49726d-9078-47de-8752-5fac79a5b9b1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:45:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (53, '77e28b94-5f6e-4dda-bc15-a411ce9423e8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:49:07', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (54, '17b87cd8-6a14-4834-9d9e-e4121d563079', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:53:20', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (55, 'b2b7ddc7-6e48-4f24-9d03-8c481b6fc165', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:57:00', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (56, 'c394c827-3f3f-42c3-88db-b5e3edc5a3e8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:58:51', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (57, '16bf6849-9619-4448-9b0f-1ad4a999e33f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 15:59:47', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (58, '8f19e5f6-e197-4b81-9585-ea3ea655dd2a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:01:56', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (59, '647ce6e6-5aa4-4504-80db-fb1df687c0b6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:03:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (60, '04f69ab8-5a84-495c-8dfa-7f19a1a32c63', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:05:03', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (61, '520bf6de-19a5-4b06-b905-6c61a37a1809', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:06:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (62, 'e70c584c-5d6f-4cdd-9d63-42606b21941f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:07:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (63, 'd85b3a8e-4917-470c-8412-9c7ccbdd26e6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:08:13', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (64, '21e06b88-33cd-4ddc-9d3e-22a0cc79d8ab', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:09:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (65, '70903b36-f5da-4784-8505-9e0ee7842a7c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:10:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (66, '4300b8fb-4d5a-4c83-b45f-f46de9070789', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:11:57', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (67, 'a83706e9-c606-4393-b46c-bd589102fa23', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:14:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (68, '03b705d7-cb9b-4176-ba52-82caee369ee5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:16:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (69, '9c1aa75d-0afe-4d9b-93a4-82ff51476b83', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:18:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (70, 'd5153a89-5dca-4ce1-b225-cdf1f06734b3', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:20:23', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (71, '6f0dc304-3697-4d5e-b6f5-dcae95c6037d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:23:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (72, '1a8d1436-b1fc-4648-8ef3-8986b200f609', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:25:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (73, '87c74066-e8db-4312-ba9c-8d4a58d65b88', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:26:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (74, '7c36eace-b7c5-405f-a2a1-b1fa95d7b526', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:26:36', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (75, '9147f792-55be-4ca6-824d-b8c4a42960b3', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:27:48', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (76, '2183b103-858d-4bb4-9111-83fc8ddf24c1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:34:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (77, '9594b67d-6651-4237-887d-ebadfabc8ca3', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:35:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (78, '60649e01-d220-4bbc-a21c-211ce67bd9a7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:36:29', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (79, '83aa1836-36c5-4e74-aebb-9263843ce8fa', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:36:41', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (80, 'd7dfb927-1f17-41f7-868b-6ee0b8ec2d2f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:40:14', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (81, '9898d830-f0f3-4dbd-a687-a49709b855de', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:42:14', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (82, 'e7a5b6b0-3e50-4892-b4cc-e628fb803be6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:43:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (83, '34454957-3dfd-4819-8930-46daf47d2f81', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:45:03', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (84, '384b5ce9-5bf7-43b0-950d-496737c3a8dd', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:45:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (85, 'dd6de292-124f-44e6-a0fd-057cfeed410c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:46:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (86, 'a370f0b0-fb7f-41cf-a4ed-eafb873cd50b', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:48:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (87, 'bfb06fff-b0bb-43a4-8cf0-bf4f4b3445f6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:50:00', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (88, '53634812-48d2-420a-9e3c-2ac032b5d9cc', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:50:52', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (89, '994f638f-cf08-4846-9630-94bb509ab7db', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:51:27', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (90, '76813df6-4bdd-4add-981e-8e782a3b772a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:52:16', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (91, 'df0c3f75-a865-4621-988d-ec494e9ea407', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:53:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (92, '07f1722d-d9d4-43f7-8f7e-81c6446d7b3f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:57:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (93, '1d91f1b5-a008-446a-ad12-3210e899c55d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:57:50', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (94, '9b0f8585-4432-401a-9ae1-f363a158a133', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:58:27', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (95, '33b73d87-df3c-41b4-8abc-d2c51bf4657e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 16:59:41', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (96, '08daa4b5-b5e0-4217-8249-d47928afcf82', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:02:57', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (97, 'a1d11647-2316-4636-85ce-a589084c383a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:03:27', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (98, 'c8579e89-0858-4ba7-9e00-f1ea2a208be8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:06:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (99, 'd3837059-b25b-4221-9fd0-aed6f958b8a0', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:07:15', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (100, 'a47efa4b-e840-4e07-a710-459fa9f01e5e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:08:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (101, 'dca0f5d4-df0f-4d95-830e-2ae8aa60a550', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:15:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (102, 'be678468-abc2-48db-b34d-47e81352bf5c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:16:49', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (103, 'ae4265e7-e192-46f5-8a9e-53d6ba6aee3e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:20:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (104, '232a0407-b8f0-40b2-bf70-b368aecc3f48', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:22:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (105, '09aa4d6e-471a-4890-98f1-85ec1f41d16d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:23:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (106, '6dc0c49c-29a6-4292-bb59-d19d3c7dc11f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:23:49', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (107, 'aafb9719-a7e3-4c25-be9f-150fbc4e345d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:25:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (108, 'ce799416-f0a8-4941-9f84-ff3bf5a5ae00', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:26:16', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (109, '38ad0b87-c569-4831-84ea-f45bfb1b06e6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:28:00', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (110, 'a0ee9a9f-6f2f-49a2-80e1-f0976cb115d5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:28:16', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (111, '42b6c87d-a031-4f7e-8670-09672fd00239', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:29:40', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (112, '39812b97-1a6d-4255-ba0f-86e8e6150bf7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:29:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (113, '38df607a-72e4-45c5-9b9a-fda85114e7a8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:30:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (114, '3d1dbb97-c0d4-4790-9bd1-57d2a26c945e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:34:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (115, 'f9544196-41ca-4f54-926e-2f43bd5482ef', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:34:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (116, 'b954f7a1-e544-4ac1-a103-54cfbc9ce982', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:35:13', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (117, '53484323-65ce-4720-91e6-51f81741df2d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:36:26', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (118, 'cae0d43e-f1d9-427a-9e2e-a276848a9e6a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:37:04', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (119, '3d1dd8c7-2d3d-46c7-aec0-8aeae75bd53c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:38:24', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (120, 'd206b8cc-4663-4253-919c-eecbf4bdae2d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:39:14', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (121, '30f22b8a-39f3-4088-a917-e7b0bb315d96', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:40:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (122, 'b58fa0aa-f173-4a25-b245-3eedae47c4bf', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:40:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (123, '6de207b2-2f61-465f-8e2d-7115220cfb0a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:41:10', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (124, 'a2734f2b-41c2-4b5c-a9e7-0301482c2db1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:42:30', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (125, '0142a300-7a9a-4a09-990e-f9d53363168c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:43:54', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (126, 'a1207e54-0e14-424a-a485-9a560bce8058', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:49:37', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (127, 'cd2425fc-dab4-4f73-bc61-1b9f43920801', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:51:55', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (128, 'ee27889d-4dbb-4ed0-8184-81d0c56cee06', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:53:38', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (129, 'd85434f8-c11b-438c-890e-8e5732f91a22', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:55:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (130, '0cff5da9-3cd4-4363-80be-c3cccb523a95', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:57:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (131, '58cf157e-c55c-4cf4-90ee-6f9546ea60de', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:58:23', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (132, '3ad40393-bdc1-4cc5-90cb-c40c45737c07', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 17:59:36', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (133, '268d0dec-0c8c-4017-adf0-c87c7a5705f5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:03:33', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (134, 'a925f086-1f57-4ffc-bb0b-656e27cac343', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:05:28', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (135, '0d344981-1748-4b0c-bd5e-38db0d9d4903', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:07:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (136, '545b520c-d306-4ae9-affa-ead01383de6b', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:07:44', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (137, '2cf65789-0d5a-4a04-a86b-71b4c4632fab', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:08:02', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (138, '69b4eb4c-89e3-4ff1-ba0a-ec181cfa269e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:11:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (139, 'eae37130-5acb-4a7c-a466-867202b5de22', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:12:07', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (140, '74471c0e-fb55-4545-b23a-944f56a01d9e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:13:54', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (141, '3dc79a1b-6974-4338-a05e-732a08c06d9f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:15:26', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (142, '1bb4277e-05dc-455a-86f1-a4d7a570a7c9', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:21:19', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (143, 'f6c85ba2-6d99-4509-9fce-e32762a3d9fc', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:25:01', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (144, '99f90484-cd36-4caf-b874-64cdec51c973', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:26:24', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (145, '254a881a-36c0-46a8-89c1-47ec0902cc1c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:28:43', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (146, '40814010-a24d-448f-9841-ea26f75e3d4f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:29:17', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (147, 'b9d31023-b415-4a05-88be-e8f6077ba1c1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-12 18:30:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (148, '8d98204f-cc93-4ae7-961a-ffc88f16ad22', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:02:29', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (149, 'cfa57e94-fa7b-4cd7-8b0e-f84c2a32517a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:03:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (150, 'b0742424-3b90-4c92-91b6-da7d0c1042e4', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:04:31', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (151, '92fb0d86-db06-4bd2-88a6-2c5e5659c2dd', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:10:44', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (152, '157c9ab2-260f-4fc9-953c-244e66a416dc', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:14:04', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (153, '58250a3d-9d20-4c06-a161-b89a5cbe2205', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:17:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (154, '503ec9f6-9c51-494c-abe6-d2025b6d5de8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:23:32', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (155, '7da9ee7e-00f1-400c-9e82-aa756d33c2f7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:25:14', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (156, '576eb582-a62f-4de4-a7c6-5a79d06a317e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:26:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (157, '35fe81bd-a801-411e-a588-83e2073b53d1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:36:01', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (158, '13cc3148-7818-4aae-b404-5aa5b21bcb43', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:37:12', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (159, 'c667755d-08bf-4575-8763-ece99a8d34ff', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:38:20', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (160, 'e9cb8b8f-0f5a-47f0-ac70-04b75341a2cd', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:40:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (161, '128cb9e9-52a8-4ecc-8b4f-14d0377a9bdb', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:41:53', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (162, 'e71e95b5-4d16-45d4-ad99-c719c971ee4f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:46:18', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (163, 'c22e9388-e8e1-4965-8689-67d614efa611', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:47:29', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (164, 'f3232bc6-a8d0-48c0-a08f-0f7ad79dfaa1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:48:36', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (165, '0bd9b8c6-bfe6-41f3-80ad-2bad1f56348b', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:51:38', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (166, '4c04dbef-6f2d-48a7-a549-55089038e197', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:53:04', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (167, '2c3b82a0-1cdb-4ccf-80ec-41d49f5c1bcf', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:54:21', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (168, '20d05c1d-c3c2-4f89-8093-44b548165d42', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:55:38', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (169, '6364f00a-44f9-41c6-a462-1edf968fe4e5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 09:59:29', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (170, '6598c9c5-9e50-432c-aaa2-636e0e8d44f9', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:07:53', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (171, '3909b811-7a5a-46c1-b390-6d21d8857670', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:10:11', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (172, 'd3da6d29-b931-4f25-ba5b-bd091af19ff5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:21:05', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (173, '11040fcd-6f8b-470b-aedc-1411b36165c7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:23:34', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (174, 'c3ac6479-d9c2-4205-a257-abefe814a842', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:26:47', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (175, 'f0cf37ba-eeeb-44ea-a870-8bc74c079d5c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:39:49', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (176, 'babe0cad-db0c-4f07-b478-89f8d89bc197', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:42:21', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (177, 'df2b5aae-e7da-4793-8f42-d7025855208e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:46:08', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (178, '4b6bd295-aa7c-4549-b82f-fd0d8be4a439', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:49:22', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (179, '2e3ffaa3-d499-46a7-aa1b-b2ae27ef4d32', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:50:20', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (180, '8670c605-1b89-4448-9de3-e4d15a1b0bad', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:52:38', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (181, 'fc90c9b0-c5d1-41b2-be40-1ea9ee2e52f2', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:53:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (182, '4cb82fc7-e322-439d-bd49-59e22b4ba8de', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:55:25', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (183, '9d4f9fd7-0564-4128-be27-25030761f141', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 10:58:06', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (184, 'bfe86e54-30e8-4c0c-ae49-497863b73708', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 11:00:58', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (185, '89953f9b-30af-446c-9682-27358d8f4d76', 'WECHAT_OPEN_MOBILE', '72_1zj9L8T0iKDEqORM5reOYHBG3nL_5jbvb3TfFjGQqw5jv9-0YmI02SgOto6PZXZ7Y1R0o8nm5EeJc8bR8547MfZMBbICbasV2YDtW0XbfSQ', 7200, '72_0Ae6bzB8bTMtnrrfuHkNDN37ko1GEOTLsbqbE3tbQAXNHNd6n_7-HIie0v_zC_clqDr4mOmJBOtkvjCzVHDWW7OS0pAdoDUovfy2n-Y7WD8', 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 11:01:17', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/NEJsVswPcQnxDy3UBXcVGIpMwvn2FmJ6I1k5DoNZk0UcZwQEm7lCewbdneEEfCeVkVNXOIQOXw8evKBea5MBdA/132', 0, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (186, '09277a77-53a8-4cf9-8396-0442d33166ab', 'WECHAT_OPEN_MOBILE', '72_StpVhV87sy7cSsbkVoOJyxCdtlD3JxcdxG5vO8vgZ1eR7C2mORJdxYynL9SJR__pD_rdt2IHbfcSIH2Fpw5wh-BVMu3TTKeESp6qD4Nl1go', 7200, '72_LbZu1ZoNlOHPoqHVRROZ_eGiaMHwqRE4dy3xa6QxpbvnlV5mfAiyyiI0wfUYcnCyruuudNtMlW50NBZNcAxBPeBu3TYILuhlA3rYzCgaNqo', 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 11:03:08', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, 'oh', 'oh', 'https://thirdwx.qlogo.cn/mmopen/vi_32/5M4DYfvJP2dlsqQVmiclkxeGZrnnMf7hj6ryUR35INtKBicn7Whq0oPCdcJfotYxslSPGH2d8s2exvIicu8FYDXicg/132', 0, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (187, '79aca6b3-0552-4f19-8720-10efa034834f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:34:42', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (188, 'e4f08938-b416-4713-8c37-a157d006991f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 12:03:46', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (189, '2392005b-1079-4e6b-9625-a295f5e482ec', 'WECHAT_OPEN_MOBILE', '72_Yg_G7_l9nv0ikzJ6Oe7h1q9bz5oU_cJ3TYUMhKxO2ZKudg1bYfhAYygNt95C_qRy_zqiAZVO8jYvxj89iQaRvl5dgKLJl4gAh2GZus6xYfw', 7200, '72_NWbKK4ucUpHoMmLTKSGxTKfMOau99ebYJoWHJkWtVndGLVB6SmwVSwOlavfbh1KHDKqh4RNw28FWl4SauyBCoicugrLnH528z3RyIqrYF9M', 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:14:17', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/NEJsVswPcQnxDy3UBXcVGIpMwvn2FmJ6I1k5DoNZk0UcZwQEm7lCewbdneEEfCeVkVNXOIQOXw8evKBea5MBdA/132', 0, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (190, '13fec398-b9a0-4a3f-b878-bc892a0104b0', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:15:04', 'System', '2023-09-22 09:07:14', NULL, '1', '1', 6, NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (191, '338c3d89-a231-4b57-b5f0-cfe3d1f13850', 'WECHAT_OPEN_MOBILE', '72_4DWd6gR3GQIiXPpuagGrM5eILwEO4SfHWJIDwLMqp8I_2FJpBwdNL-Or9UhQ7T8BNKoV0GZ2lh9FaCHk_7LyABY3lmABBpee6Ok4W_KBX08', 7200, '72_iH1rgWvH35a-0O2aXSFSB9qWyXPF_JcChEpn-WFVeFzI1Scfw_1ZxhD8_tEZY5Wk5OMNCqh9WyOKBtO11pL0bUQIWyzYgoPiJHCA2NCrukw', 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 15:34:45', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, 'oh', 'oh', 'https://thirdwx.qlogo.cn/mmopen/vi_32/5M4DYfvJP2dlsqQVmiclkxeGZrnnMf7hj6ryUR35INtKBicn7Whq0oPCdcJfotYxsla7j7Dvh5eWLLNxttY6gyYA/132', 0, 'wechat_open_mobile');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (192, 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', 'WECHAT_OPEN', '72_1RLeJ9QnQYJkiMs87FTBBMoK5h9ISBM3XZtPLveA6IetBtyejnDk5c7f-p0mC1RTHLxMkjC-e9KfX8l2y-0XqCPKav_0R20C-Tzbw95wlt0', 7200, '72_lcw1_ihZeBiAUFq4YPt3gc10tRBDMMhLKEsV-f7fZrZkd8xK5-tKbRXaCZL-Cbf4QkPbxnCPWb4svWODgBKMjUXc7g4W4qEkqgNg-4zllss', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 17:16:47', 'System', '2023-09-15 17:23:12', NULL, '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (193, 'bd40330e-9ff0-4c2b-ba00-ff2c3a9cf9e3', 'wechat_open_web', '72_pg1i2Xl9vrW288PCqZybI56qq3-2Yin1o8nvKFAPCRx9OaS8HxJNHUVb6xuG5j_fQdwMecInJYxUpvTTUlJ659DsFOVYrr4RBCTI0sAEqBU', NULL, '72_v0sNSaJQyj8XUCk1bRPIl0A7TB8n4pN0mC807o7YGbPVXugt7aId7RAyb2hi9gsvd0aX2R4vAW-BnDtCTHPm_Un_AkW-mM8SYc44JuxMhOg', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 17:30:40', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (194, 'a8681dc9-f2cc-4316-a6a4-d8d43aa00e19', 'wechat_open_web', '72_44jRuqhWDZYQwgFJMFzJkNRKd3_w0m9npMlL7gv16EoEW2UZy6CbNfy_oSuhqMz28PnUHOJwAyC-Xv--LvNxSePhPu-K-FOajq-1BE10G2o', NULL, '72_wF_NsYq04JgoGpNVvq6EvbZjD7BDDz7XHpGfGA4bT61A_wf3ITbXSFhc57MJUwi_o-HhCfBJ9FnSEBu2nySYkDVTbQ457WZ-ZXDTkwo7OMc', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 18:13:09', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (195, '128d79bf-7573-40c6-bbca-ff5fcf2a0a71', 'wechat_open_web', '72_h2CaZanyW6eeDFw4jybBzdqYKIWBovGeEeB29G6WZEPDtZPiXANNrFRLEMmtd_HGLwv8YwqwBinOVTIxtrjwFcue_x_z9YJlgM5pfJFNHJA', NULL, '72_hK0QOqLAqq-5-0sbwA4_Kqs-nweY_HC0LTaprTL8n_nbZD8wwhPkil5b2-0Sk855gQ47NGTwczEAt-pCt8ZyZwkTEX0gtO6kcRp8Ajz2kew', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 18:13:47', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (196, '698dbf21-8b29-47fa-9946-19a82d067645', 'wechat_open_web', '72_smafRNdslVfgLL-x0nBV5JZO3jT_r3LJBwYw2HJQYpcGe7KKBSSYtIrqpsvVFY75Z7knhMefGlOf9r6s1sH9sjdmAq5EQAOCx2B5QexT3_U', NULL, '72_ongWXQyEHIhXich6claT-7BzZZJbTAb-0dlr245Ee8GO4I9MFplLxa9P5o8qGmgxWhh3h1HvpyYzCyIJ2xxMaS79GhdOhmv6ZJ0dyJN5tsI', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-14 18:49:36', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (197, 'f0fd123d-b82a-4eb9-a67a-fb81db6b739d', 'wechat_open_web', '72_eexrzOvM96xPvH3Lsl7viBOtnBHFDzFJdIz1d074PJxOhAB9qY0HE-NxnWm67afHT0zphQ4RyVEM1BOohhE32HN_D5yZVcMh24oMrSCPJYg', NULL, '72_W25_phPvOFAfeASpx050O28_pOfgtW0LsnuWYQZI6LIrMeVJnju7FrLTG5xuYG_awhD7crWRzpd-guJs2gZ3ZBVj7bSRtwIgSvgVRfzG0zs', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 11:49:37', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (198, '702797d1-04ef-4374-a618-aa2c3370135c', 'wechat_open_web', '72_BqSILWRpNzD35f9vkga9dMSHQp3bftJMa7eBpOXIepLh7zJVdBMUiPghVRz96hvtuCvvY7CryJtM5yuKx0tU4IJer4ZshmLHSw1Fl7jYtlo', NULL, '72_jJ0WZ-4r18IkeIs0YC6FfCS0QtCk9S5N1cqYeCIsKijORm2I1diDUE4zVLzYL5dUfxoVeUdHpYY8EyFBKQiWOzaGSECPPLw2bzQnigQzr-g', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 14:27:11', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (199, 'ebe3c9b0-6d17-4e7a-9d4b-a4d127e5f81e', 'wechat_open_web', '72_eahdqYL3gU93PJ1IWa6sIKwL4-XvLvCcMnkLYYI3au_8OQ2ZEwe5YHjnRKVzmXDkEfW_IUwCpSyGBLYaOS_ms4RfSI-TAH_s7lUnh_pwOpQ', NULL, '72_8RcuvSh7R88zZSjHyMfuROguXNJxl28CinaM0DMVnQdlvrLORUkT-ArLdWEY_ukrctsOppiY85xYUtZ8mRKit66-IMJauWckLptvbS6mVtk', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:14:33', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (200, 'a9865b55-498e-47e5-ab12-bfc028f9401a', 'wechat_open_web', '72_sDs8oTAz4diS5nsjQyO-y2aO2IXDYL0CkVFkHaA5gJDb1YCUqfmG9ejNR0-lsshtYwOOswE5s5hdIMkBXsUt_zuVK5nyTlJ3oi3sVrUEaP4', NULL, '72_Z9mP_wckNOwwmrA0eGB8lUB5CY23FvlLciZBegzfnyg10VW0GOe56QF0uM4rgtTha-kO7Uhasm2FIFdDdGKhriu8t1OYs2PEyYT-GOYauvA', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 16:16:30', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (201, '45ef2f02-0498-4a91-9b7e-7ec1fbba1f4f', 'wechat_open_web', '72_pj5qq79ny99dg-nnZztIDdBw6pxQUTOI7GC1-50zdFugMU3JhIUgoWKG_zISSOT63HSkuogl0GTSM7zV-7XaGRZoVvT3ks9e4No7qh4lmcM', NULL, '72_jJaohqyJXjiOai2Y1X2JGxinYVUpGYQhNrNRqRBEGDzY44zuPuNxJSIAvlXbJoZXwi57WfV2FxbLCfeUPCnBzypTR6MyAgnY7UBPzfnkO8E', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 17:22:53', 'System', '2023-09-15 17:23:12', 'System', '1', '1', 8, 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (202, '719938db-a623-427c-b0bb-f93ccc66e12e', 'wechat_open_web', '72_47aVnqUFSV_6B866IIt56eXQ4MCeaON9p6uNXDNd8tM9C1aDLc42MpMvPCh4gUJBr1CPk6W2BjaJdbp53mhvgJQ9mbVTHi3Rgt7S5lYa1uc', NULL, '72_ES4G1cNwL7SR5zxg7wSUtyh1JAMD3iHksu9PhfriYVa7BviNMKTBXq0XA92tRNDGTLbYyjpzXBsihDooqcYziiJjJNJZ8HV573kvdk5Js6g', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-15 18:01:00', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (203, '6c128697-f856-4cec-9b22-9c041e546aa9', 'wechat_open_web', '72_ouu4bb-uHrl6KXeQP_H_nI2cn0GBsiCAq4sJcwK0vEhi4DqPbvInOEpYwX1ljPsrxJ2a6iXf48A8SRDDT0G-jKPhs5qsI7MTUvylc3tIvIA', NULL, '72_8yFIgg2C-J3jomyS19ZQmPsNu_bwxoVe_pOjDQInuid5WH2SLBL5ul8NIXF4kFbBT5S1xDvQ9Wo0yGLgLg4kAwvGRRk2atyA9u85HLXRrCU', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:40:55', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (204, 'd78d0dfd-ea6a-419c-a95d-916f75ef8645', 'wechat_open_web', '72_In2RD2EUmBPN_cKpj_e_6WhSI0BFkOqOSGMAxPg8frEv3EExLiPv7H7p1VJFBoTXDRMUzxX4uBXJUanI3B38y2IO0T_T21WZWToph0Hqrfk', NULL, '72_ICxLSkfZYijpSu7nJwnOGVjwG0bLkwAlsKxMNYUAJF0O-hkVP44qlnSJjrEXvQ7tpId_-8uygb3EjfSYMBh1h5D-YtjYFTYgj-tQOcponpQ', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:48:25', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (205, '3057f429-575b-4116-b6c2-2be2ed0daa6a', 'wechat_open_web', '72_8RcuvSh7R88zZSjHyMfuRAU8ESiAbG5qYjyInId2yhXEwIsJ--rVPWI-ZuUTkJzBym4oNf7hFJtvwZWqv1S0H-poe26G0sU_ge92uPjC3J8', NULL, '72_j_d-U4TM9Uc6ZXfG_ckplSQX_umZya-Z-HssZe57QjB0rYvI0LP2nzWusHpAVu352zq7LXTNGd2X239O3wHqlPSJ9dstTukRWWYy3h0nnVQ', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:50:17', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (206, 'c0013cb3-7862-4477-b178-a1cf885ad278', 'wechat_open_web', '72_VO1uAiIQgD1l49wDcy5oqfq7Qp-e6qX8FDtdvgbGuib3T2JAZZrBC6wKunFue-O5fai49_Y2-Y_0NUldDAgGjFVGJ53FwA9sQH6W9yovX3Y', NULL, '72_ldWlbgKsd3GropvbdrgjzZMFOgKS8i8Cre678hFHSWlrGaQVjPR9WgRZftTWcQHA0vgDQM-wKERD7_LGC1qzKnxEeUPOH1cO_VztQ3ZCvM0', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 16:53:02', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (207, '243912df-6515-4821-a2d2-311869eb4b66', 'wechat_open_web', '72_nrEdUC4X_xkmBsNbtePmd4tyBTDyhAzb35Xp0ul9pUfRsMfG8GIVQrIvM-GIJXyvJ1n5BscRwmOKeZxxqfzKiQdq-WjWy0PVmKEJ7YV2p_8', NULL, '72_H4I7KKoI2DSFE3dSVXAzyGxz0OqTXT6d8kMvraXgA4nslgsCM6iLB_7d-aHGOhKjKOQbUAJb8-mOerc9YhfM1oPRb_nW4y1lvswt-QwXrRs', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 17:22:13', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (208, 'b14bbe72-eddb-4282-a42b-77281f61f27c', 'wechat_open_web', '72_eahdqYL3gU93PJ1IWa6sIHdTySn-4UB_nLAkQLGDSjY7CTMUE4EOSyKYEFSoZmq9Fs64RdAHCV3PJG4ifk_VlZaFkGopHrytcIScSIfyU6w', NULL, '72_8RcuvSh7R88zZSjHyMfuRKViN1EJKbd_ZCElj0V8epojZFlgv6LJZd_fBKE2hE3q9iUqj-0vPqndpMCdc-FfPUjbvDh4B5w1UtNv78wz1Ak', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 17:39:53', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (209, '56f25762-2dcc-4be2-a50e-934eac40e328', 'wechat_open_web', '72_GqYw5ylQK7W9nn_cd8keVairltJ1Fcyp9SsIORxMtkihL1iQecSo5Boclagxl-RXHnmdc7mo82DLkFkSqSTDn0JunfPAtAIyAZl5geONq88', NULL, '72_2PoE8DZBF2qybpGHXPHagdYdPtt3Un3YjomGW7pGF65KKYF8t-qd4scANEK1QguVv1ig6zEDvL7F7iFgNVGkkRTEicSq21-QyZ7jVul6J1Y', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-21 18:31:11', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "public"."iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES (210, '3a8b4ac4-8e24-4b23-b850-8fca2d90794b', 'wechat_open_web', '72_jJ0WZ-4r18IkeIs0YC6FfDOthAf9UIUNqALqUbYzBMirZuUh48M4AcVlp0Pjy4KbdA_OA1sWvkL1XWAcLa-KtqM-g-gF8Bz9DBfVUwcKGMU', NULL, '72_qfKdEHN3PH23LcmUsUrXoUmO2EkXUtRStVV_j7RabNi8Kuj8mhZYao9fZYCs_m_djArcug96q0TgX2Nxxnkk8LFOYQ26ODl0fy8ZLW6WW9c', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-22 09:06:39', 'System', '2023-09-22 09:07:14', 'System', '1', '1', 6, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
COMMIT;

-- ----------------------------
-- Table structure for iot_things_model
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_things_model";
CREATE TABLE "public"."iot_things_model" (
  "model_id" int8 NOT NULL,
  "model_name" varchar(64) NOT NULL,
  "product_id" int8 NOT NULL,
  "product_name" varchar(64) NOT NULL,
  "tenant_id" int8 NOT NULL,
  "tenant_name" varchar(30) NOT NULL,
  "identifier" varchar(32) NOT NULL,
  "type" int2 NOT NULL,
  "datatype" varchar(64) NOT NULL,
  "specs" text,
  "is_chart" int2 NOT NULL,
  "is_monitor" int2 NOT NULL,
  "is_history" int2,
  "is_readonly" int2,
  "is_share_perm" int2,
  "model_order" int4,
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500),
  "temp_slave_id" int8,
  "formula" varchar(255),
  "reverse_formula" varchar(255),
  "reg_addr" int4,
  "bit_option" varchar(255),
  "value_type" varchar(64),
  "is_params" int4,
  "quantity" int4,
  "code" varchar(255),
  "parse_type" varchar(20)
)
;
COMMENT ON COLUMN "public"."iot_things_model"."model_id" IS '物模型ID';
COMMENT ON COLUMN "public"."iot_things_model"."model_name" IS '物模型名称';
COMMENT ON COLUMN "public"."iot_things_model"."product_id" IS '产品ID';
COMMENT ON COLUMN "public"."iot_things_model"."product_name" IS '产品名称';
COMMENT ON COLUMN "public"."iot_things_model"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."iot_things_model"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."iot_things_model"."identifier" IS '标识符，产品下唯一';
COMMENT ON COLUMN "public"."iot_things_model"."type" IS '模型类别（1-属性，2-功能，3-事件）';
COMMENT ON COLUMN "public"."iot_things_model"."datatype" IS '数据类型（integer、decimal、string、bool、array、enum）';
COMMENT ON COLUMN "public"."iot_things_model"."specs" IS '数据定义';
COMMENT ON COLUMN "public"."iot_things_model"."is_chart" IS '是否图表展示（0-否，1-是）';
COMMENT ON COLUMN "public"."iot_things_model"."is_monitor" IS '是否实时监测（0-否，1-是）';
COMMENT ON COLUMN "public"."iot_things_model"."is_history" IS '是否历史存储（0-否，1-是）';
COMMENT ON COLUMN "public"."iot_things_model"."is_readonly" IS '是否只读数据(0-否，1-是)';
COMMENT ON COLUMN "public"."iot_things_model"."is_share_perm" IS '是否设备分享权限(0-否，1-是)';
COMMENT ON COLUMN "public"."iot_things_model"."model_order" IS '排序，值越大，排序越靠前';
COMMENT ON COLUMN "public"."iot_things_model"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."iot_things_model"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_things_model"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_things_model"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_things_model"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_things_model"."remark" IS '备注';
COMMENT ON COLUMN "public"."iot_things_model"."temp_slave_id" IS '从机id';
COMMENT ON COLUMN "public"."iot_things_model"."formula" IS '计算公式';
COMMENT ON COLUMN "public"."iot_things_model"."reverse_formula" IS '控制公式';
COMMENT ON COLUMN "public"."iot_things_model"."reg_addr" IS '寄存器地址值';
COMMENT ON COLUMN "public"."iot_things_model"."bit_option" IS '位定义选项';
COMMENT ON COLUMN "public"."iot_things_model"."value_type" IS '解析类型 1.数值 2.选项';
COMMENT ON COLUMN "public"."iot_things_model"."is_params" IS '是否是计算参数';
COMMENT ON COLUMN "public"."iot_things_model"."quantity" IS '读取寄存器数量';
COMMENT ON COLUMN "public"."iot_things_model"."code" IS 'modbus功能码';
COMMENT ON COLUMN "public"."iot_things_model"."parse_type" IS 'modbus解析类型';
COMMENT ON TABLE "public"."iot_things_model" IS '物模型';

-- ----------------------------
-- Records of iot_things_model
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (113, '设备开关', 41, '温湿度智能开关', 1, 'admin', 'switch', 2, 'bool', '{"type": "bool", "trueText": "打开", "falseText": "关闭"}', 0, 0, 1, 0, 0, 9, '0', NULL, '2022-08-14 00:06:53', '', '2023-03-31 23:43:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (125, '空气温度', 41, '温湿度智能开关', 1, 'admin', 'temperature', 1, 'decimal', '{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', 1, 1, 1, 1, 0, 1, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:44:21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (126, '空气湿度', 41, '温湿度智能开关', 1, 'admin', 'humidity', 1, 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}', 1, 1, 1, 1, 0, 3, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:44:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (127, '二氧化碳', 41, '温湿度智能开关', 1, 'admin', 'co2', 1, 'integer', '{"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm"}', 1, 1, 1, 1, 0, 2, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:44:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (128, '室内亮度', 41, '温湿度智能开关', 1, 'admin', 'brightness', 1, 'integer', '{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}', 1, 1, 1, 1, 0, 4, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:44:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (129, '运行档位', 41, '温湿度智能开关', 1, 'admin', 'gear', 2, 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', 0, 0, 1, 0, 0, 8, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:43:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (130, '灯光色值', 41, '温湿度智能开关', 1, 'admin', 'light_color', 2, 'array', '{"type": "array", "arrayType": "integer", "arrayCount": "3"}', 0, 0, 1, 0, 0, 5, '0', NULL, '2022-11-05 23:56:21', '', '2023-09-25 22:57:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (131, '屏显消息', 41, '温湿度智能开关', 1, 'admin', 'message', 2, 'string', '{"type": "string", "maxLength": 1024}', 0, 0, 1, 0, 0, 7, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:43:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (132, '上报数据', 41, '温湿度智能开关', 1, 'admin', 'report_monitor', 2, 'integer', '{"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}', 0, 0, 0, 0, 0, 10, '0', NULL, '2022-11-05 23:56:21', '', '2023-03-31 23:43:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (134, '环境温度过高', 41, '温湿度智能开关', 1, 'admin', 'height_temperature', 3, 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', 0, 0, 1, 0, 0, 0, '0', NULL, '2022-11-05 23:56:29', '', '2023-03-31 23:44:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (135, '设备发生异常', 41, '温湿度智能开关', 1, 'admin', 'exception', 3, 'string', '{"type": "string", "maxLength": 1024}', 0, 0, 1, 0, 0, 0, '0', NULL, '2022-11-05 23:56:29', '', '2023-03-31 23:44:29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (161, '子设备', 96, '网关产品', 1, 'admin', 'device', 1, 'array', '{"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1, "isSharePerm": 0}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "isChart": 0, "datatype": {"type": "enum", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "device_switch", "name": "设备开关", "order": 5, "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "isChart": 0, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "device_irc", "name": "射频遥控", "order": 1, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}], "arrayType": "object", "arrayCount": "5"}', 0, 0, 0, 0, 1, 10, '0', NULL, '2023-02-25 22:51:53', '', '2023-09-25 23:13:21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (162, '功能分组', 96, '网关产品', 1, 'admin', 'category', 1, 'object', '{"type": "object", "params": [{"id": "category_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "category_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isHistory": 0, "isMonitor": 1, "isReadonly": 1}, {"id": "category_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 1}, {"id": "category_report_monitor", "name": "上报监测数据", "order": 7, "isChart": 0, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "category_gear", "name": "运行档位", "order": 5, "isChart": 0, "datatype": {"type": "enum", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "category_switch", "name": "设备开关", "order": 4, "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "category_irc", "name": "射频遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控配对", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}]}', 0, 0, 0, 0, 1, 9, '0', NULL, '2023-02-25 22:51:53', '', '2023-09-03 11:03:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (163, '空气温度', 96, '网关产品', 1, 'admin', 'temperature', 1, 'decimal', '{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', 1, 1, 1, 1, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', '2023-03-31 16:08:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (164, '设备开关', 96, '网关产品', 1, 'admin', 'switch', 2, 'bool', '{"type": "bool", "trueText": "打开", "falseText": "关闭"}', 0, 0, 1, 0, 1, 8, '0', NULL, '2023-02-25 22:52:16', '', '2023-09-03 11:03:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (165, '运行档位', 96, '网关产品', 1, 'admin', 'gear', 2, 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', 0, 0, 1, 0, 1, 7, '0', NULL, '2023-02-25 22:52:16', '', '2023-09-03 11:03:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (166, '灯光色值', 96, '网关产品', 1, 'admin', 'light_color', 2, 'array', '{"type": "array", "arrayType": "integer", "arrayCount": "3"}', 0, 0, 1, 0, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', '2023-03-31 16:08:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (167, '上报监测数据', 96, '网关产品', 1, 'admin', 'report_monitor', 2, 'integer', '{"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}', 0, 0, 1, 0, 1, 11, '0', NULL, '2023-02-25 22:52:16', '', '2023-09-03 11:03:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (168, '环境温度过高', 96, '网关产品', 1, 'admin', 'height_temperature', 3, 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', 0, 0, 1, 0, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', '2023-03-31 16:08:15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (169, '设备发生异常', 96, '网关产品', 1, 'admin', 'exception', 3, 'string', '{"type": "string", "maxLength": 1024}', 0, 0, 1, 0, 0, 0, '0', NULL, '2023-02-25 22:52:16', '', '2023-03-31 16:08:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (170, '屏显消息', 96, '网关产品', 1, 'admin', 'message', 2, 'string', '{"type": "string", "maxLength": 1024}', 0, 0, 1, 0, 1, 0, '0', NULL, '2023-02-25 22:52:35', '', '2023-09-03 11:03:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (171, '设备重启', 96, '网关产品', 1, 'admin', 'reset', 2, 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}', 0, 0, 1, 0, 1, 0, '0', NULL, '2023-02-25 22:52:35', '', '2023-09-03 11:03:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (174, '室内亮度', 96, '网关产品', 1, 'admin', 'brightness', 1, 'integer', '{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}', 1, 1, 1, 1, 0, 0, '0', NULL, '2023-02-26 00:56:39', '', '2023-09-03 10:40:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (175, '设备重启', 41, '智能开关', 1, 'admin', 'reset', 2, 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}', 0, 0, 1, 0, 0, 6, '0', NULL, '2023-02-26 02:20:40', '', '2023-04-01 23:40:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (385, '射频遥控', 41, '★智能开关', 1, 'admin', 'irc', 2, 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}', 0, 0, 1, 0, 0, 11, '0', 'admin', '2023-03-31 23:46:36', '', '2023-04-13 01:38:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (439, '上报状态', 41, '★智能开关产品', 1, 'admin', 'status', 2, 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}', 0, 0, 0, 0, 0, 12, '0', 'admin', '2023-04-13 01:39:31', '', '2023-04-13 01:39:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (493, '漏水值', 112, '★MODBUS协议产品', 1, 'admin', '0', 1, 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "度"}', 0, 0, 1, 0, 0, 0, '0', '', '2023-09-13 23:33:19', '', NULL, NULL, 1, NULL, NULL, 0, NULL, NULL, NULL, 1, '3', 'ushort');
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (494, '温度', 112, '★MODBUS协议产品', 1, 'admin', '0', 1, 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "°"}', 0, 0, 1, 0, 0, 0, '0', '', '2023-09-13 23:33:19', '', NULL, NULL, 2, NULL, NULL, 0, NULL, NULL, NULL, 1, '3', 'ushort');
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (495, '电量', 112, '★MODBUS协议产品', 1, 'admin', '1', 1, 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": ""}', 0, 0, 1, 0, 0, 0, '0', '', '2023-09-13 23:33:19', '', NULL, NULL, 11, NULL, NULL, 1, NULL, NULL, NULL, 1, '3', 'ushort');
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (496, '光照强度', 55, '网关产品', 1, 'admin', 'light_level', 1, 'integer', '{"max": 89.2, "min": 2.5, "step": 0.1, "type": "integer", "unit": "L/g"}', 1, 1, 1, 1, 0, 0, '0', 'admin', '2025-03-19 16:32:06', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (497, '状态灯色', 55, '网关产品', 1, 'admin', 'color', 2, 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "红色", "value": "0"}, {"text": "绿色", "value": "1"}, {"text": "蓝色", "value": "2"}, {"text": "黄色", "value": "3"}]}', 0, 0, 1, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:06', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (498, '子设备', 55, '网关产品', 1, 'admin', 'device', 2, 'array', '{"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "name": "设备开关", "order": 5, "datatype": {"type": "bool", "enumList": [{"text": "", "value": ""}], "trueText": "打开", "arrayType": "int", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "arrayType": "object", "arrayCount": 5}', 0, 0, 0, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:06', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (499, '功能分组', 55, '网关产品', 1, 'admin', 'group', 2, 'object', '{"type": "object", "params": [{"id": "group_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "group_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isMonitor": 1, "isReadonly": 1}, {"id": "group_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isMonitor": 0, "isReadonly": 1}, {"id": "group_report_monitor", "name": "上报监测数据", "order": 7, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group_gear", "name": "运行档位", "order": 5, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "group_switch", "name": "设备开关", "order": 4, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "group_irc", "name": "红外遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}]}', 0, 0, 0, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:06', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (500, '射频遥控', 55, '网关产品', 1, 'admin', 'irc', 2, 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}', 0, 0, 1, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:06', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (501, '上报状态', 55, '网关产品', 1, 'admin', 'status', 2, 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}', 0, 0, 0, 0, 1, 0, '0', 'admin', '2025-03-19 16:32:06', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (502, '运行档位', 55, '网关产品', 1, 'admin', 'gear', 2, 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', 0, 0, 1, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:21', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (503, '灯光色值', 55, '网关产品', 1, 'admin', 'light_color', 2, 'array', '{"type": "array", "arrayType": "integer", "arrayCount": "3"}', 0, 0, 1, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:21', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (504, '屏显消息', 55, '网关产品', 1, 'admin', 'message', 2, 'string', '{"type": "string", "maxLength": 1024}', 0, 0, 1, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:21', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (505, '环境温度过高', 55, '网关产品', 1, 'admin', 'height_temperature', 3, 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', 0, 0, 1, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:21', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (506, '设备发生异常', 55, '网关产品', 1, 'admin', 'exception', 3, 'string', '{"type": "string", "maxLength": 1024}', 0, 0, 1, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:21', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (507, '空气温度', 55, '网关产品', 1, 'admin', 'temperature', 1, 'decimal', '{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', 1, 1, 1, 1, 0, 0, '0', 'admin', '2025-03-19 16:32:31', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (508, '空气湿度', 55, '网关产品', 1, 'admin', 'humidity', 1, 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}', 1, 1, 1, 1, 0, 0, '0', 'admin', '2025-03-19 16:32:31', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES (509, '设备开关', 55, '网关产品', 1, 'admin', 'switch', 2, 'bool', '{"type": "bool", "trueText": "打开", "falseText": "关闭"}', 0, 0, 1, 0, 0, 0, '0', 'admin', '2025-03-19 16:32:31', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for iot_things_model_template
-- ----------------------------
DROP TABLE IF EXISTS "public"."iot_things_model_template";
CREATE TABLE "public"."iot_things_model_template" (
  "template_id" int8 NOT NULL,
  "template_name" varchar(64) NOT NULL,
  "tenant_id" int8 NOT NULL,
  "tenant_name" varchar(30) NOT NULL,
  "identifier" varchar(32) NOT NULL,
  "type" int2 NOT NULL,
  "datatype" varchar(64) NOT NULL,
  "specs" text,
  "is_sys" int2 NOT NULL,
  "is_chart" int2 NOT NULL,
  "is_monitor" int2 NOT NULL,
  "is_history" int2 NOT NULL,
  "is_readonly" int2,
  "is_share_perm" int2,
  "model_order" int4,
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500),
  "temp_slave_id" varchar(20),
  "formula" varchar(255),
  "reverse_formula" varchar(255),
  "reg_addr" int4,
  "bit_option" varchar(255),
  "value_type" varchar(64),
  "is_params" int8,
  "quantity" int4,
  "code" varchar(255),
  "old_identifier" varchar(10),
  "old_temp_slave_id" varchar(10),
  "parse_type" varchar(20)
)
;
COMMENT ON COLUMN "public"."iot_things_model_template"."template_id" IS '物模型ID';
COMMENT ON COLUMN "public"."iot_things_model_template"."template_name" IS '物模型名称';
COMMENT ON COLUMN "public"."iot_things_model_template"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."iot_things_model_template"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."iot_things_model_template"."identifier" IS '标识符，产品下唯一';
COMMENT ON COLUMN "public"."iot_things_model_template"."type" IS '模型类别（1-属性，2-功能，3-事件）';
COMMENT ON COLUMN "public"."iot_things_model_template"."datatype" IS '数据类型（integer、decimal、string、bool、array、enum）';
COMMENT ON COLUMN "public"."iot_things_model_template"."specs" IS '数据定义';
COMMENT ON COLUMN "public"."iot_things_model_template"."is_sys" IS '是否系统通用（0-否，1-是）';
COMMENT ON COLUMN "public"."iot_things_model_template"."is_chart" IS '是否图表展示（0-否，1-是）';
COMMENT ON COLUMN "public"."iot_things_model_template"."is_monitor" IS '是否实时监测（0-否，1-是）';
COMMENT ON COLUMN "public"."iot_things_model_template"."is_history" IS '是否历史存储 (0-否，1-是）';
COMMENT ON COLUMN "public"."iot_things_model_template"."is_readonly" IS '是否只读数据(0-否，1-是)';
COMMENT ON COLUMN "public"."iot_things_model_template"."is_share_perm" IS '是否设备分享权限(0-否，1-是)';
COMMENT ON COLUMN "public"."iot_things_model_template"."model_order" IS '排序，值越大，排序越靠前';
COMMENT ON COLUMN "public"."iot_things_model_template"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."iot_things_model_template"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."iot_things_model_template"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."iot_things_model_template"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."iot_things_model_template"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."iot_things_model_template"."remark" IS '备注';
COMMENT ON COLUMN "public"."iot_things_model_template"."temp_slave_id" IS '从机id';
COMMENT ON COLUMN "public"."iot_things_model_template"."formula" IS '计算公式';
COMMENT ON COLUMN "public"."iot_things_model_template"."reverse_formula" IS '控制公式';
COMMENT ON COLUMN "public"."iot_things_model_template"."reg_addr" IS '寄存器地址值';
COMMENT ON COLUMN "public"."iot_things_model_template"."bit_option" IS '位定义选项';
COMMENT ON COLUMN "public"."iot_things_model_template"."value_type" IS '解析类型 1.数值 2.选项';
COMMENT ON COLUMN "public"."iot_things_model_template"."is_params" IS '是否是计算参数,默认否 0=否，1=是';
COMMENT ON COLUMN "public"."iot_things_model_template"."quantity" IS '读取寄存器数量';
COMMENT ON COLUMN "public"."iot_things_model_template"."code" IS 'modbus功能码';
COMMENT ON COLUMN "public"."iot_things_model_template"."old_identifier" IS '旧的标识符';
COMMENT ON COLUMN "public"."iot_things_model_template"."old_temp_slave_id" IS '旧的从机id';
COMMENT ON COLUMN "public"."iot_things_model_template"."parse_type" IS 'modbus解析类型';
COMMENT ON TABLE "public"."iot_things_model_template" IS '物模型模板';

-- ----------------------------
-- Records of iot_things_model_template
-- ----------------------------
BEGIN;
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (1, '空气温度', 1, 'admin', 'temperature', 1, 'decimal', '{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', 1, 1, 1, 1, 1, 0, 4, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:12:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (2, '空气湿度', 1, 'admin', 'humidity', 1, 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}', 1, 1, 1, 1, 1, 0, 3, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:12:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (3, '二氧化碳', 1, 'admin', 'co2', 1, 'integer', '{"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (4, '室内亮度', 1, 'admin', 'brightness', 1, 'integer', '{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (5, '设备开关', 1, 'admin', 'switch', 2, 'bool', '{"type": "bool", "trueText": "打开", "falseText": "关闭"}', 1, 0, 0, 1, 0, 0, 5, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (6, '运行档位', 1, 'admin', 'gear', 2, 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', 1, 0, 0, 1, 0, 0, 6, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (7, '灯光色值', 1, 'admin', 'light_color', 2, 'array', '{"type": "array", "arrayType": "integer", "arrayCount": "3"}', 1, 0, 0, 1, 0, 0, 2, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (8, '屏显消息', 1, 'admin', 'message', 2, 'string', '{"type": "string", "maxLength": 1024}', 1, 0, 0, 1, 0, 0, 1, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (9, '上报监测数据', 1, 'admin', 'report_monitor', 2, 'integer', '{"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}', 1, 0, 0, 0, 0, 0, 9, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (10, '环境温度过高', 1, 'admin', 'height_temperature', 3, 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', 1, 0, 0, 1, 0, 0, 8, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (11, '设备发生异常', 1, 'admin', 'exception', 3, 'string', '{"type": "string", "maxLength": 1024}', 1, 0, 0, 1, 0, 0, 7, '0', 'admin', '2022-03-09 17:41:49', 'admin', '2023-04-10 01:11:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (12, '光照', 1, 'admin', 'light', 1, 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', 0, 1, 1, 1, 1, 0, 0, '0', 'wumei', '2022-05-07 09:41:17', 'admin', '2023-04-10 01:11:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (13, '压力', 1, 'admin', 'pressure', 1, 'decimal', '{"max": 200, "min": 0, "step": 0.1, "type": "decimal", "unit": "帕斯卡"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 22:39:18', 'admin', '2023-04-10 01:11:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (14, '设备重启', 1, 'admin', 'reset', 2, 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}', 1, 0, 0, 1, 0, 0, 0, '0', 'admin', '2023-02-20 23:15:25', 'admin', '2023-04-10 01:11:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (15, '电池电压', 1, 'admin', 'voltage', 1, 'decimal', '{"max": 5, "min": 0, "step": 0.001, "type": "decimal", "unit": "V"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:17:43', 'admin', '2023-04-10 01:10:56', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (16, '饮水量', 1, 'admin', 'shuiliang', 1, 'integer', '{"max": 500, "min": 80, "step": 1, "type": "integer", "unit": "ML"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:18:39', 'admin', '2023-04-10 01:10:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (17, '灯光', 1, 'admin', 'light', 1, 'integer', '{"max": 1000, "min": 0, "step": 1, "type": "integer", "unit": "Lux"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:19:23', 'admin', '2023-04-10 01:10:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (18, '长度', 1, 'admin', 'length', 1, 'integer', '{"max": 2000, "min": 1, "step": 5, "type": "integer", "unit": "M"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:20:03', 'admin', '2023-04-10 01:10:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (19, '心率', 1, 'admin', 'heart_rate', 1, 'integer', '{"max": 250, "min": 0, "step": 1, "type": "integer", "unit": "次数"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:21:46', 'admin', '2023-04-10 01:12:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (20, '光照强度', 1, 'admin', 'light_level', 1, 'integer', '{"max": 89.2, "min": 2.5, "step": 0.1, "type": "integer", "unit": "L/g"}', 1, 1, 1, 1, 1, 0, 0, '0', 'admin', '2023-02-20 23:24:36', 'admin', '2023-04-10 01:10:35', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (21, '状态灯色', 1, 'admin', 'color', 2, 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "红色", "value": "0"}, {"text": "绿色", "value": "1"}, {"text": "蓝色", "value": "2"}, {"text": "黄色", "value": "3"}]}', 1, 0, 0, 1, 0, 0, 0, '0', 'admin', '2023-02-20 23:26:24', 'admin', '2023-04-10 01:10:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (22, '子设备', 1, 'admin', 'device', 2, 'array', '{"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "name": "设备开关", "order": 5, "datatype": {"type": "bool", "enumList": [{"text": "", "value": ""}], "trueText": "打开", "arrayType": "int", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "arrayType": "object", "arrayCount": 5}', 1, 0, 0, 0, 0, 0, 10, '0', 'admin', '2023-02-24 01:10:43', 'admin', '2023-04-13 01:33:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (23, '功能分组', 1, 'admin', 'group', 2, 'object', '{"type": "object", "params": [{"id": "group_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "group_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isMonitor": 1, "isReadonly": 1}, {"id": "group_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isMonitor": 0, "isReadonly": 1}, {"id": "group_report_monitor", "name": "上报监测数据", "order": 7, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group_gear", "name": "运行档位", "order": 5, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "group_switch", "name": "设备开关", "order": 4, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "group_irc", "name": "红外遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}]}', 1, 0, 0, 0, 0, 0, 11, '0', 'admin', '2023-02-25 22:41:43', 'admin', '2023-08-30 15:29:34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (201, '频率 ', 1, 'admin', 'frequency', 2, 'integer', '{"max": 65535, "min": 0, "step": 1, "type": "integer", "unit": "0.001Hz"}', 1, 0, 0, 1, 0, 0, 0, '0', '', '2023-02-28 16:08:06', 'admin', '2023-04-10 03:37:11', NULL, '3#3', '%s*0.001', '', 27, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (225, '校验位', 1, 'admin', 'check', 2, 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "N", "value": "0"}, {"text": "O", "value": "1"}, {"text": "E", "value": "2"}]}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-02-28 16:08:08', 'admin', '2023-04-10 21:36:01', NULL, '3#3', '', '', 771, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (226, '波特率', 1, 'admin', 'baud', 2, 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "1200", "value": "0"}, {"text": "2400", "value": "1"}, {"text": "4800", "value": "2"}, {"text": "9600", "value": "3"}, {"text": "19200", "value": "4"}]}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-02-28 16:08:09', 'admin', '2023-04-10 03:37:32', NULL, '3#3', '', '', 772, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (227, '电压', 1, 'admin', 'voltage', 1, 'integer', '{"max": 6, "min": 0.1, "step": 0.1, "type": "integer", "unit": "v"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-02-28 16:08:09', 'admin', '2023-04-10 03:37:16', NULL, '3#3', '', '', 773, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (236, '射频遥控', 1, 'admin', 'irc', 2, 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}', 1, 0, 0, 1, 0, 0, 0, '0', 'admin', '2023-03-31 23:46:20', 'admin', '2023-04-10 01:09:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (250, '漏水值', 1, 'admin', '0', 1, 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "度"}', 1, 0, 0, 1, 0, 0, 0, '0', '', '2023-04-11 22:35:36', '', '2023-09-13 23:32:34', NULL, '1#1', NULL, NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, 'ushort');
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (251, '温度', 1, 'admin', '0', 1, 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "°"}', 1, 0, 0, 1, 0, 0, 0, '0', '', '2023-04-11 22:36:10', '', '2023-09-13 23:32:51', NULL, '1#2', NULL, NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, 'ushort');
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (252, '电量', 1, 'admin', '1', 1, 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": ""}', 1, 0, 0, 1, 0, 0, 0, '0', '', '2023-04-11 22:36:27', '', '2023-09-13 23:33:11', NULL, '1#11', NULL, NULL, 1, NULL, NULL, NULL, 1, '3', NULL, NULL, 'ushort');
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (323, '上报状态', 1, 'admin', 'status', 2, 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}', 1, 0, 0, 0, 0, 1, 0, '0', 'admin', '2023-04-13 01:35:42', 'admin', '2023-09-03 10:50:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (324, 'X位移', 1, 'admin', 'x-shift', 1, 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-08-26 19:36:58', '', NULL, NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (325, 'Y位移', 1, 'admin', 'y-shift', 1, 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-08-26 19:37:23', '', '2023-08-26 19:37:32', NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (326, 'X位移', 1, 'admin', 'x-shift', 1, 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-08-26 19:38:31', '', NULL, NULL, '2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (327, 'Y位移', 1, 'admin', 'y-shift', 1, 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', 1, 1, 1, 1, 1, 0, 0, '0', '', '2023-08-26 19:38:51', '', NULL, NULL, '2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (328, '计件数量', 1, 'admin', '0', 1, 'integer', '{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": ""}', 1, 0, 0, 0, 1, 0, 0, '0', '', '2023-08-28 15:05:25', '', NULL, NULL, '3#1', NULL, NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (329, '参数1', 1, 'admin', '0', 1, 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', 1, 0, 0, 0, 1, 0, 0, '0', '', '2023-08-28 15:06:55', '', NULL, NULL, '3#2', NULL, NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (330, '图片', 1, 'admin', 'image', 1, 'string', '{"type": "string", "maxLength": 10240}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-28 23:19:30', '', NULL, NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (331, '回路状态', 10, 'jamon', 'loop_status', 1, 'array', '{"type": "array", "arrayType": "integer"}', 0, 0, 0, 0, 0, 0, 0, '0', '', '2023-08-29 18:21:38', '', NULL, NULL, '4#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (332, '回路状态', 10, 'jamon', 'loop_status', 1, 'array', '{"type": "array", "arrayType": "integer"}', 0, 0, 0, 0, 0, 0, 0, '0', '', '2023-08-29 18:23:08', '', NULL, NULL, '4#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (335, '湿度', 1, 'admin', '0', 1, 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 14:05:38', '', '2023-08-30 14:58:28', NULL, '6#1', '%s/10', NULL, 0, NULL, NULL, NULL, 1, '3', NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (336, '温度', 1, 'admin', '1', 1, 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": "°C"}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 14:06:05', '', '2023-08-30 14:58:38', NULL, '6#1', '%s/10', NULL, 1, NULL, NULL, NULL, 1, '3', NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (341, '视频', 1, 'admin', 'video', 1, 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 23:08:51', '', '2023-08-30 23:25:15', NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (342, '图片', 1, 'admin', 'image', 1, 'string', '{"type": "string", "maxLength": 1024}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 23:21:48', '', '2023-08-30 23:25:22', NULL, '2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES (343, '状态', 1, 'admin', 'status', 1, 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', 1, 0, 0, 1, 1, 0, 0, '0', '', '2023-08-30 23:28:00', '', '2023-08-30 23:28:17', NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for media_server
-- ----------------------------
DROP TABLE IF EXISTS "public"."media_server";
CREATE TABLE "public"."media_server" (
  "id" int8 NOT NULL,
  "server_id" varchar(30) NOT NULL,
  "tenant_id" int8 NOT NULL,
  "tenant_name" varchar(30) NOT NULL,
  "enabled" int2,
  "protocol" varchar(10) NOT NULL,
  "ip" varchar(255) NOT NULL,
  "domain" varchar(128) NOT NULL,
  "hookurl" varchar(255) NOT NULL,
  "secret" varchar(255) NOT NULL,
  "port_http" int4 NOT NULL,
  "port_https" int4 NOT NULL,
  "port_rtmp" int4 NOT NULL,
  "port_rtsp" int4 NOT NULL,
  "rtp_proxy_port" int4 NOT NULL,
  "rtp_enable" int2 NOT NULL,
  "rtp_port_range" varchar(255) NOT NULL,
  "record_port" int4 NOT NULL,
  "auto_config" int2 NOT NULL,
  "status" int2 NOT NULL,
  "del_flag" char(1) NOT NULL,
  "create_by" varchar(64) NOT NULL,
  "create_time" timestamp NOT NULL,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500),
  "port_ws" int4
)
;
COMMENT ON COLUMN "public"."media_server"."id" IS '流媒体配置ID';
COMMENT ON COLUMN "public"."media_server"."server_id" IS '服务器标识';
COMMENT ON COLUMN "public"."media_server"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."media_server"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."media_server"."enabled" IS '使能开关';
COMMENT ON COLUMN "public"."media_server"."protocol" IS '默认播放协议';
COMMENT ON COLUMN "public"."media_server"."ip" IS '服务器ip';
COMMENT ON COLUMN "public"."media_server"."domain" IS '服务器域名';
COMMENT ON COLUMN "public"."media_server"."hookurl" IS '回调服务器地址';
COMMENT ON COLUMN "public"."media_server"."secret" IS '流媒体密钥';
COMMENT ON COLUMN "public"."media_server"."port_http" IS 'http端口';
COMMENT ON COLUMN "public"."media_server"."port_https" IS 'https端口';
COMMENT ON COLUMN "public"."media_server"."port_rtmp" IS 'rtmp端口';
COMMENT ON COLUMN "public"."media_server"."port_rtsp" IS 'rtsp端口';
COMMENT ON COLUMN "public"."media_server"."rtp_proxy_port" IS 'RTP收流端口';
COMMENT ON COLUMN "public"."media_server"."rtp_enable" IS '是否使用多端口模式';
COMMENT ON COLUMN "public"."media_server"."rtp_port_range" IS 'rtp端口范围';
COMMENT ON COLUMN "public"."media_server"."record_port" IS '录像服务端口';
COMMENT ON COLUMN "public"."media_server"."auto_config" IS '是否自动同步配置ZLM';
COMMENT ON COLUMN "public"."media_server"."status" IS '状态';
COMMENT ON COLUMN "public"."media_server"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."media_server"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."media_server"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."media_server"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."media_server"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."media_server"."remark" IS '备注';
COMMENT ON COLUMN "public"."media_server"."port_ws" IS 'ws端口';
COMMENT ON TABLE "public"."media_server" IS '流媒体服务器配置';

-- ----------------------------
-- Records of media_server
-- ----------------------------
BEGIN;
INSERT INTO "public"."media_server" ("id", "server_id", "tenant_id", "tenant_name", "enabled", "protocol", "ip", "domain", "hookurl", "secret", "port_http", "port_https", "port_rtmp", "port_rtsp", "rtp_proxy_port", "rtp_enable", "rtp_port_range", "record_port", "auto_config", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "port_ws") VALUES (7, 'fastbee', 1, 'admin', 1, 'http', '192.168.2.120', 'fastbee.com2', '192.168.2.15:8080', '035c73f7-bb6b-4889-a715-d9eb2d192xxx', 8082, 8443, 1935, 554, 0, 1, '30000,30103', 18081, 1, 0, '0', '', '2023-09-26 21:11:43', '', '2023-10-26 21:51:25', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS "public"."news";
CREATE TABLE "public"."news" (
  "news_id" int8 NOT NULL,
  "title" varchar(64) NOT NULL,
  "content" text NOT NULL,
  "img_url" varchar(128) NOT NULL,
  "is_top" int2 NOT NULL,
  "is_banner" int2 NOT NULL,
  "category_id" int8 NOT NULL,
  "category_name" varchar(32) NOT NULL,
  "status" int2 NOT NULL,
  "author" varchar(50) NOT NULL,
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."news"."news_id" IS '新闻ID';
COMMENT ON COLUMN "public"."news"."title" IS '标题';
COMMENT ON COLUMN "public"."news"."content" IS '内容';
COMMENT ON COLUMN "public"."news"."img_url" IS '封面';
COMMENT ON COLUMN "public"."news"."is_top" IS '是否置顶(0-置顶 1-置顶)';
COMMENT ON COLUMN "public"."news"."is_banner" IS '是否banner(0-是banner 1-不是banner)';
COMMENT ON COLUMN "public"."news"."category_id" IS '分类ID';
COMMENT ON COLUMN "public"."news"."category_name" IS '分类名称';
COMMENT ON COLUMN "public"."news"."status" IS '新闻状态（0-未发布，1-已发布）';
COMMENT ON COLUMN "public"."news"."author" IS '作者';
COMMENT ON COLUMN "public"."news"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."news"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."news"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."news"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."news"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."news"."remark" IS '备注';
COMMENT ON TABLE "public"."news" IS '新闻资讯';

-- ----------------------------
-- Records of news
-- ----------------------------
BEGIN;
INSERT INTO "public"."news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '广告图一', '<p>请后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-215805.png', 0, 1, 2, '相关产品', 1, '物美智能', '0', '', '2022-05-12 12:13:40', '', '2022-05-12 12:13:40', '物美智能');
INSERT INTO "public"."news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '广告图二', '<p>请后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-215852.png', 0, 1, 1, '新闻资讯', 1, '物美智能', '0', '', '2022-05-12 12:13:42', '', '2022-05-12 12:13:42', '物美智能');
INSERT INTO "public"."news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '广告图三', '<p>后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-224553.png', 0, 1, 2, '相关产品', 1, '物美智能', '0', '', '2022-05-12 12:13:44', '', '2022-05-12 12:13:44', '物美智能');
INSERT INTO "public"."news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '物美智能-快速搭建物联网和智能家居平台', '<p class="ql-align-justify">物美智能 wumei-smart 是一个简单易用的生活物联网平台。可用于搭建物联网平台以及二次开发和学习。设备接入使用EMQX消息服务器，加密认证；后端采用Spring boot；前端采用Vue；移动端采用Uniapp；数据库采用Mysql和Redis；设备端支持ESP32、ESP8266、树莓派等；</p><p class="ql-align-justify"><img src="/prod-api/profile/upload/2022/05/11/5f479f25-b85d-4c9f-b6a7-deadd2cdec76.png"></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>系统功能介绍</strong></p><p class="ql-align-justify"><br></p><p class="ql-align-justify">1.权限管理： 用户管理、部门管理、岗位管理、菜单管理、角色管理、字典和参数管理等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">2.系统监控： 操作日志、登录日志、系统日志、在线用户、服务监控、连接池监控、缓存监控等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">3.产品管理： 产品、产品物模型、产品分类、产品固件、授权码等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">4.设备管理： 控制、分组、定时、日志、统计、定位、OTA升级、影子模式、实时监测、加密认证等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">5.EMQ管理： Mqtt客户端、监听器、消息主题、消息订阅、插件管理、规则引擎、资源</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">6.硬件 SDK： 支持WIFI和MQTT连接、物模型响应、实时监测、定时上报监测数据、AES加密、NTP时间等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">7.物模型管理： 属性（设备状态和监测数据），功能（执行特定任务），事件（设备主动上报给云端）</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">8.其他（开发中）：第三方登录，设备分享、设备告警、场景联动（进度50%），智能音箱、多租户、APP界面自定义（进度40%），时序数据库、分布式集群部署、Granfa监控（进度30%），视频流处理、桌面端模拟器/监控、安卓端模拟器/监控（进度20%）</p><p class="ql-align-justify"><strong>﻿</strong></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>硬件设备接入流程</strong></p><p><br></p><p>1.设备认证：加密认证、简单认证和emqx支持的多种认证方式。</p><p class="ql-align-justify">2.设备交互：发布和订阅物模型、设备信息、设备升级和时钟同步等mqtt主题</p>', '/iot/tool/download?fileName=/profile/iot/1/2022-0508-133031.png', 1, 0, 2, '相关产品', 1, '物美智能', '0', '', '2022-05-12 12:13:46', '', '2022-05-12 12:13:46', '物美智能');
INSERT INTO "public"."news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '2022年中国物联网全景图产业链上中下游市场及企业剖析', '<p>后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-224151.png', 1, 0, 1, '新闻资讯', 1, '物美智能', '0', '', '2022-05-12 12:13:48', '', '2022-05-12 12:13:48', '物美智能');
INSERT INTO "public"."news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, 'Arm打造物联网全面解决方案 携手合作伙伴共探智能未来', '<p>后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-224352.png', 1, 0, 1, '新闻资讯', 1, '物美智能', '0', '', '2022-05-12 12:13:50', '', '2022-05-12 12:13:50', '物美智能');
INSERT INTO "public"."news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (7, '使用ESP32开发板，快速学习物联网开发', '<p>请后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0428-130824.jpg', 1, 0, 2, '相关产品', 1, '物美智能', '0', '', '2022-05-12 12:13:53', '', '2022-05-12 12:13:53', '物美智能');
INSERT INTO "public"."news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (8, '物联网赛道观察之无源物联网', '<p>无源物联网，即终端无外接能量源，采用获取环境能量的方式进行供能的物联网技术。在当前物联网技术发展条件下，终端覆盖率是一个亟待解决的问题，而无源物联网凭借其极低的部署和维护成本、灵活多变的应用场景成为解决更广范围内终端供能需求问题、实现“千亿级互联”愿景的关键。</p><p><br></p><p>无源物联网技术的发展最终有赖于环境能量采集、低功耗计算与反向散射等低功耗通讯技术的进步。目前无源物联网应用较为成熟的路线主要包括射频识别技术（RFID）与近场通信技术（NFC）两类，覆盖仓储物流、智能制造、智慧零售、资产管理、物业服务等多元应用场景。未来，随着物联网行业的碎片化整合以及以Bluetooth、5G、LoRa等为媒介进行能量采集与信息传输的技术路线的逐渐成熟，当前困扰行业的诸多问题将会逐步得到解决，随之而来的是更包罗多样的无源终端需求与极具潜力的应用场景。</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-215643.png', 1, 0, 1, '新闻资讯', 1, '物美智能', '0', '', '2022-05-12 12:13:55', '', '2022-05-12 12:13:55', '物美智能');
COMMIT;

-- ----------------------------
-- Table structure for news_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."news_category";
CREATE TABLE "public"."news_category" (
  "category_id" int8 NOT NULL,
  "category_name" varchar(64) NOT NULL,
  "order_num" int4 NOT NULL,
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."news_category"."category_id" IS '分类ID';
COMMENT ON COLUMN "public"."news_category"."category_name" IS '分类名称';
COMMENT ON COLUMN "public"."news_category"."order_num" IS '显示顺序';
COMMENT ON COLUMN "public"."news_category"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."news_category"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."news_category"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."news_category"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."news_category"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."news_category"."remark" IS '备注';
COMMENT ON TABLE "public"."news_category" IS '新闻分类';

-- ----------------------------
-- Records of news_category
-- ----------------------------
BEGIN;
INSERT INTO "public"."news_category" ("category_id", "category_name", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '新闻资讯', 3, '0', '', '2022-04-11 20:53:55', '', '2022-04-13 15:30:22', '新闻资讯信息');
INSERT INTO "public"."news_category" ("category_id", "category_name", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '相关产品', 2, '0', '', '2022-04-11 20:54:16', '', '2022-04-13 15:30:15', '相关产品推荐');
COMMIT;

-- ----------------------------
-- Table structure for oauth_access_token
-- ----------------------------
DROP TABLE IF EXISTS "public"."oauth_access_token";
CREATE TABLE "public"."oauth_access_token" (
  "token_id" varchar(255),
  "token" bytea,
  "authentication_id" varchar(255),
  "user_name" varchar(255),
  "client_id" varchar(255),
  "authentication" bytea,
  "refresh_token" varchar(255)
)
;

-- ----------------------------
-- Records of oauth_access_token
-- ----------------------------
BEGIN;
INSERT INTO "public"."oauth_access_token" ("token_id", "token", "authentication_id", "user_name", "client_id", "authentication", "refresh_token") VALUES ('d406d946aac7c24cd01a2df1105ec898', E'\\254\\355\\000\\005sr\\000Corg.springframework.security.oauth2.common.DefaultOAuth2AccessToken\\014\\262\\2366\\033$\\372\\316\\002\\000\\006L\\000\\025additionalInformationt\\000\\017Ljava/util/Map;L\\000\\012expirationt\\000\\020Ljava/util/Date;L\\000\\014refreshTokent\\000?Lorg/springframework/security/oauth2/common/OAuth2RefreshToken;L\\000\\005scopet\\000\\017Ljava/util/Set;L\\000\\011tokenTypet\\000\\022Ljava/lang/String;L\\000\\005valueq\\000~\\000\\005xpsr\\000\\036java.util.Collections$EmptyMapY6\\024\\205Z\\334\\347\\320\\002\\000\\000xpsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001\\212\\247`\\321cxsr\\000Lorg.springframework.security.oauth2.common.DefaultExpiringOAuth2RefreshToken/\\337Gc\\235\\320\\311\\267\\002\\000\\001L\\000\\012expirationq\\000~\\000\\002xr\\000Dorg.springframework.security.oauth2.common.DefaultOAuth2RefreshTokens\\341\\016\\012cT\\324^\\002\\000\\001L\\000\\005valueq\\000~\\000\\005xpt\\000\\033VE-7wD8mpAJ4Izf-I4_EdP1o1bosq\\000~\\000\\011w\\010\\000\\000\\001\\212\\247`\\321-xsr\\000%java.util.Collections$UnmodifiableSet\\200\\035\\222\\321\\217\\233\\200U\\002\\000\\000xr\\000,java.util.Collections$UnmodifiableCollection\\031B\\000\\200\\313^\\367\\036\\002\\000\\001L\\000\\001ct\\000\\026Ljava/util/Collection;xpsr\\000\\027java.util.LinkedHashSet\\330l\\327Z\\225\\335*\\036\\002\\000\\000xr\\000\\021java.util.HashSet\\272D\\205\\225\\226\\270\\2674\\003\\000\\000xpw\\014\\000\\000\\000\\004?@\\000\\000\\000\\000\\000\\002t\\000\\004readt\\000\\005writext\\000\\006bearert\\000\\033p8Z_G8JsI2z3xeugD0djIK0Z9k8', '2c27d3f4516a653753e8337094cf35e1', 'admin', 'admin-dueros', E'\\254\\355\\000\\005sr\\000Aorg.springframework.security.oauth2.provider.OAuth2Authentication\\275@\\013\\002\\026bR\\023\\002\\000\\002L\\000\\015storedRequestt\\000<Lorg/springframework/security/oauth2/provider/OAuth2Request;L\\000\\022userAuthenticationt\\0002Lorg/springframework/security/core/Authentication;xr\\000Gorg.springframework.security.authentication.AbstractAuthenticationToken\\323\\252(~nGd\\016\\002\\000\\003Z\\000\\015authenticatedL\\000\\013authoritiest\\000\\026Ljava/util/Collection;L\\000\\007detailst\\000\\022Ljava/lang/Object;xp\\000sr\\000&java.util.Collections$UnmodifiableList\\374\\017%1\\265\\354\\216\\020\\002\\000\\001L\\000\\004listt\\000\\020Ljava/util/List;xr\\000,java.util.Collections$UnmodifiableCollection\\031B\\000\\200\\313^\\367\\036\\002\\000\\001L\\000\\001cq\\000~\\000\\004xpsr\\000\\023java.util.ArrayListx\\201\\322\\035\\231\\307a\\235\\003\\000\\001I\\000\\004sizexp\\000\\000\\000\\000w\\004\\000\\000\\000\\000xq\\000~\\000\\014psr\\000:org.springframework.security.oauth2.provider.OAuth2Request\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007Z\\000\\010approvedL\\000\\013authoritiesq\\000~\\000\\004L\\000\\012extensionst\\000\\017Ljava/util/Map;L\\000\\013redirectUrit\\000\\022Ljava/lang/String;L\\000\\007refresht\\000;Lorg/springframework/security/oauth2/provider/TokenRequest;L\\000\\013resourceIdst\\000\\017Ljava/util/Set;L\\000\\015responseTypesq\\000~\\000\\021xr\\0008org.springframework.security.oauth2.provider.BaseRequest6(z>\\243qi\\275\\002\\000\\003L\\000\\010clientIdq\\000~\\000\\017L\\000\\021requestParametersq\\000~\\000\\016L\\000\\005scopeq\\000~\\000\\021xpt\\000\\014admin-duerossr\\000%java.util.Collections$UnmodifiableMap\\361\\245\\250\\376t\\365\\007B\\002\\000\\001L\\000\\001mq\\000~\\000\\016xpsr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\014w\\010\\000\\000\\000\\020\\000\\000\\000\\011t\\000\\004codet\\000\\006nwpdqat\\000\\012grant_typet\\000\\022authorization_codet\\000\\005scopet\\000\\012read writet\\000\\015response_typet\\000\\004codet\\000\\014redirect_urit\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dt\\000\\005statet\\000 4f5e7c04b1710bbe867e57d1744a5478t\\000\\015client_secrett\\000 S2EneHxdt^MHhBv8N#$^ty6nq$NQY2Ndt\\000\\012dueros_uidt\\000 4f5e7c04b1710bbe867e57d1744a5478t\\000\\011client_idt\\000\\014admin-duerosxsr\\000%java.util.Collections$UnmodifiableSet\\200\\035\\222\\321\\217\\233\\200U\\002\\000\\000xq\\000~\\000\\011sr\\000\\027java.util.LinkedHashSet\\330l\\327Z\\225\\335*\\036\\002\\000\\000xr\\000\\021java.util.HashSet\\272D\\205\\225\\226\\270\\2674\\003\\000\\000xpw\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\002t\\000\\004readt\\000\\005writex\\001sq\\000~\\000.w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001sr\\000Borg.springframework.security.core.authority.SimpleGrantedAuthority\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\001L\\000\\004roleq\\000~\\000\\017xpt\\000\\012ROLE_ADMINxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dpsq\\000~\\000.w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001t\\000\\017speaker-servicexsq\\000~\\000.w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001q\\000~\\000 xsr\\000Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\013credentialsq\\000~\\000\\005L\\000\\011principalq\\000~\\000\\005xq\\000~\\000\\003\\001sr\\000\\037java.util.Collections$EmptyListz\\270\\027\\264<\\247\\236\\336\\002\\000\\000xpsr\\000Horg.springframework.security.web.authentication.WebAuthenticationDetails\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\015remoteAddressq\\000~\\000\\017L\\000\\011sessionIdq\\000~\\000\\017xpt\\000\\0170:0:0:0:0:0:0:1ppsr\\000.com.fastbee.common.core.domain.model.LoginUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\013L\\000\\007browserq\\000~\\000\\017L\\000\\006deptIdt\\000\\020Ljava/lang/Long;L\\000\\012expireTimeq\\000~\\000CL\\000\\006ipaddrq\\000~\\000\\017L\\000\\015loginLocationq\\000~\\000\\017L\\000\\011loginTimeq\\000~\\000CL\\000\\002osq\\000~\\000\\017L\\000\\013permissionsq\\000~\\000\\021L\\000\\005tokenq\\000~\\000\\017L\\000\\004usert\\000/Lcom/fastbee/common/core/domain/entity/SysUser;L\\000\\006userIdq\\000~\\000Cxpt\\000\\011Chrome 11sr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000gsq\\000~\\000G\\000\\000\\001\\212\\254\\011|Ct\\000\\011127.0.0.1t\\000\\010\\345\\206\\205\\347\\275\\221IPsq\\000~\\000G\\000\\000\\001\\212\\246\\343 Ct\\000\\012Windows 10sq\\000~\\000.w\\014\\000\\000\\000\\002?@\\000\\000\\000\\000\\000\\001t\\000\\005*:*:*xt\\000$92db9efe-ed8f-49e9-a899-6d941c33927csr\\000-com.fastbee.common.core.domain.entity.SysUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\022L\\000\\006avatarq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017L\\000\\004deptt\\000/Lcom/fastbee/common/core/domain/entity/SysDept;L\\000\\006deptIdq\\000~\\000CL\\000\\005emailq\\000~\\000\\017L\\000\\011loginDatet\\000\\020Ljava/util/Date;L\\000\\007loginIpq\\000~\\000\\017L\\000\\010nickNameq\\000~\\000\\017L\\000\\010passwordq\\000~\\000\\017L\\000\\013phonenumberq\\000~\\000\\017[\\000\\007postIdst\\000\\021[Ljava/lang/Long;L\\000\\006roleIdq\\000~\\000C[\\000\\007roleIdsq\\000~\\000UL\\000\\005rolesq\\000~\\000\\010L\\000\\003sexq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017L\\000\\006userIdq\\000~\\000CL\\000\\010userNameq\\000~\\000\\017xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\017L\\000\\012createTimeq\\000~\\000TL\\000\\006paramsq\\000~\\000\\016L\\000\\006remarkq\\000~\\000\\017L\\000\\013searchValueq\\000~\\000\\017L\\000\\010updateByq\\000~\\000\\017L\\000\\012updateTimeq\\000~\\000Txpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001}\\276N\\330Pxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000\\011\\347\\256\\241\\347\\220\\206\\345\\221\\230pppt\\000\\000t\\000\\0010sr\\000-com.fastbee.common.core.domain.entity.SysDept\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\014L\\000\\011ancestorsq\\000~\\000\\017L\\000\\010childrenq\\000~\\000\\010L\\000\\007delFlagq\\000~\\000\\017L\\000\\006deptIdq\\000~\\000CL\\000\\010deptNameq\\000~\\000\\017L\\000\\005emailq\\000~\\000\\017L\\000\\006leaderq\\000~\\000\\017L\\000\\010orderNumt\\000\\023Ljava/lang/Integer;L\\000\\010parentIdq\\000~\\000CL\\000\\012parentNameq\\000~\\000\\017L\\000\\005phoneq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017xq\\000~\\000Vppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xppppt\\000\\0110,100,101sq\\000~\\000\\013\\000\\000\\000\\000w\\004\\000\\000\\000\\000xpq\\000~\\000It\\000\\014\\347\\240\\224\\345\\217\\221\\351\\203\\250\\351\\227\\250pt\\000\\006\\347\\211\\251\\347\\276\\216sr\\000\\021java.lang.Integer\\022\\342\\240\\244\\367\\201\\2078\\002\\000\\001I\\000\\005valuexq\\000~\\000H\\000\\000\\000\\001sq\\000~\\000G\\000\\000\\000\\000\\000\\000\\000eppt\\000\\0011q\\000~\\000It\\000\\020164770707@qq.comsq\\000~\\000Yw\\010\\000\\000\\001\\212\\246Q\\303\\270xt\\000\\011127.0.0.1t\\000\\017\\350\\234\\202\\344\\277\\241\\347\\256\\241\\347\\220\\206\\345\\221\\230t\\000<$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUut\\000\\01315888888888pppsq\\000~\\000\\013\\000\\000\\000\\001w\\004\\000\\000\\000\\001sr\\000-com.fastbee.common.core.domain.entity.SysRole\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\015Z\\000\\021deptCheckStrictlyZ\\000\\004flagZ\\000\\021menuCheckStrictlyL\\000\\011dataScopeq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017[\\000\\007deptIdsq\\000~\\000U[\\000\\007menuIdsq\\000~\\000UL\\000\\013permissionsq\\000~\\000\\021L\\000\\006roleIdq\\000~\\000CL\\000\\007roleKeyq\\000~\\000\\017L\\000\\010roleNameq\\000~\\000\\017L\\000\\010roleSortq\\000~\\000`L\\000\\006statusq\\000~\\000\\017xq\\000~\\000Vppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xpppp\\000\\000\\000t\\000\\0011ppppsq\\000~\\000G\\000\\000\\000\\000\\000\\000\\000\\001t\\000\\005admint\\000\\017\\350\\266\\205\\347\\272\\247\\347\\256\\241\\347\\220\\206\\345\\221\\230q\\000~\\000ht\\000\\0010xt\\000\\0010t\\000\\0010q\\000~\\000vt\\000\\005adminq\\000~\\000v', '4cabc0e9bcfa34131342209bdaf275eb');
COMMIT;

-- ----------------------------
-- Table structure for oauth_approvals
-- ----------------------------
DROP TABLE IF EXISTS "public"."oauth_approvals";
CREATE TABLE "public"."oauth_approvals" (
  "userId" varchar(255),
  "clientId" varchar(255),
  "scope" varchar(255),
  "status" varchar(10),
  "expiresAt" timestamp NOT NULL,
  "lastModifiedAt" timestamp
)
;

-- ----------------------------
-- Records of oauth_approvals
-- ----------------------------
BEGIN;
INSERT INTO "public"."oauth_approvals" ("userId", "clientId", "scope", "status", "expiresAt", "lastModifiedAt") VALUES ('admin', 'admin-dueros', 'read', 'APPROVED', '2023-10-18 22:12:45', '2023-09-18 22:12:45');
INSERT INTO "public"."oauth_approvals" ("userId", "clientId", "scope", "status", "expiresAt", "lastModifiedAt") VALUES ('admin', 'admin-dueros', 'write', 'APPROVED', '2023-10-18 22:12:45', '2023-09-18 22:12:45');
COMMIT;

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS "public"."oauth_client_details";
CREATE TABLE "public"."oauth_client_details" (
  "client_id" varchar(255) NOT NULL,
  "resource_ids" varchar(255),
  "client_secret" varchar(255),
  "scope" varchar(255),
  "authorized_grant_types" varchar(255),
  "web_server_redirect_uri" varchar(255),
  "authorities" varchar(255),
  "access_token_validity" int4,
  "refresh_token_validity" int4,
  "additional_information" text,
  "autoapprove" varchar(255),
  "type" int2
)
;
COMMENT ON COLUMN "public"."oauth_client_details"."client_id" IS '客户端ID';
COMMENT ON COLUMN "public"."oauth_client_details"."resource_ids" IS '客户端所能访问的资源id集合,多个资源时用逗号(,)分隔';
COMMENT ON COLUMN "public"."oauth_client_details"."client_secret" IS '客户端秘钥';
COMMENT ON COLUMN "public"."oauth_client_details"."scope" IS '权限范围,可选值包括read,write,trust;若有多个权限范围用逗号(,)分隔';
COMMENT ON COLUMN "public"."oauth_client_details"."authorized_grant_types" IS '授权模式，可选值包括authorization_code,password,refresh_token,implicit,client_credentials, 若支持多个grant_type用逗号(,)分隔';
COMMENT ON COLUMN "public"."oauth_client_details"."web_server_redirect_uri" IS '回调地址';
COMMENT ON COLUMN "public"."oauth_client_details"."authorities" IS '权限';
COMMENT ON COLUMN "public"."oauth_client_details"."access_token_validity" IS '设定客户端的access_token的有效时间值(单位:秒)';
COMMENT ON COLUMN "public"."oauth_client_details"."refresh_token_validity" IS '设定客户端的refresh_token的有效时间值(单位:秒)';
COMMENT ON COLUMN "public"."oauth_client_details"."additional_information" IS '预留的字段,在Oauth的流程中没有实际的使用,可选,但若设置值,必须是JSON格式的数据';
COMMENT ON COLUMN "public"."oauth_client_details"."autoapprove" IS '设置用户是否自动Approval操作, 默认值为 ''false'', 可选值包括 ''true'',''false'', ''read'',''write''. 
该字段只适用于grant_type="authorization_code"的情况,当用户登录成功后,若该值为''true''或支持的scope值,则会跳过用户Approve的页面, 直接授权. ';
COMMENT ON COLUMN "public"."oauth_client_details"."type" IS '1=小度(DuerOS),2=天猫精灵(ALiGenie),3=小米小爱';

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
BEGIN;
INSERT INTO "public"."oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('admin-dueros', 'speaker-service', 'S2EneHxdt^MHhBv8N#$^ty6nq$NQY2Nd', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694d', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 1);
INSERT INTO "public"."oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('fastbee-dueros', 'speaker-service', 'S2EneHxdt^MHhBv8N#$^ty6nq$NQY2Nc', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/35dc8a5b53719ea6bbb7bd818ca8d5b6', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 1);
INSERT INTO "public"."oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('speaker', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'client_credentials,password,authorization_code,implicit,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 1);
INSERT INTO "public"."oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('tianmao', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', '
https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'true', 2);
INSERT INTO "public"."oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('xiaoai', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'true', 3);
INSERT INTO "public"."oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('xiaoyi', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', 7200, 7200, NULL, 'false', 4);
COMMIT;

-- ----------------------------
-- Table structure for oauth_client_token
-- ----------------------------
DROP TABLE IF EXISTS "public"."oauth_client_token";
CREATE TABLE "public"."oauth_client_token" (
  "token_id" varchar(255),
  "token" bytea,
  "authentication_id" varchar(255),
  "user_name" varchar(255),
  "client_id" varchar(255)
)
;

-- ----------------------------
-- Records of oauth_client_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for oauth_code
-- ----------------------------
DROP TABLE IF EXISTS "public"."oauth_code";
CREATE TABLE "public"."oauth_code" (
  "code" varchar(255),
  "authentication" bytea
)
;

-- ----------------------------
-- Records of oauth_code
-- ----------------------------
BEGIN;
INSERT INTO "public"."oauth_code" ("code", "authentication") VALUES ('mLAeh7', E'\\254\\355\\000\\005sr\\000Aorg.springframework.security.oauth2.provider.OAuth2Authentication\\275@\\013\\002\\026bR\\023\\002\\000\\002L\\000\\015storedRequestt\\000<Lorg/springframework/security/oauth2/provider/OAuth2Request;L\\000\\022userAuthenticationt\\0002Lorg/springframework/security/core/Authentication;xr\\000Gorg.springframework.security.authentication.AbstractAuthenticationToken\\323\\252(~nGd\\016\\002\\000\\003Z\\000\\015authenticatedL\\000\\013authoritiest\\000\\026Ljava/util/Collection;L\\000\\007detailst\\000\\022Ljava/lang/Object;xp\\000sr\\000&java.util.Collections$UnmodifiableList\\374\\017%1\\265\\354\\216\\020\\002\\000\\001L\\000\\004listt\\000\\020Ljava/util/List;xr\\000,java.util.Collections$UnmodifiableCollection\\031B\\000\\200\\313^\\367\\036\\002\\000\\001L\\000\\001cq\\000~\\000\\004xpsr\\000\\023java.util.ArrayListx\\201\\322\\035\\231\\307a\\235\\003\\000\\001I\\000\\004sizexp\\000\\000\\000\\000w\\004\\000\\000\\000\\000xq\\000~\\000\\014psr\\000:org.springframework.security.oauth2.provider.OAuth2Request\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007Z\\000\\010approvedL\\000\\013authoritiesq\\000~\\000\\004L\\000\\012extensionst\\000\\017Ljava/util/Map;L\\000\\013redirectUrit\\000\\022Ljava/lang/String;L\\000\\007refresht\\000;Lorg/springframework/security/oauth2/provider/TokenRequest;L\\000\\013resourceIdst\\000\\017Ljava/util/Set;L\\000\\015responseTypesq\\000~\\000\\021xr\\0008org.springframework.security.oauth2.provider.BaseRequest6(z>\\243qi\\275\\002\\000\\003L\\000\\010clientIdq\\000~\\000\\017L\\000\\021requestParametersq\\000~\\000\\016L\\000\\005scopeq\\000~\\000\\021xpt\\000\\014admin-duerossr\\000%java.util.Collections$UnmodifiableMap\\361\\245\\250\\376t\\365\\007B\\002\\000\\001L\\000\\001mq\\000~\\000\\016xpsr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\006w\\010\\000\\000\\000\\010\\000\\000\\000\\004t\\000\\015response_typet\\000\\004codet\\000\\014redirect_urit\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dt\\000\\011client_idq\\000~\\000\\024t\\000\\005scopet\\000\\012read writexsr\\000%java.util.Collections$UnmodifiableSet\\200\\035\\222\\321\\217\\233\\200U\\002\\000\\000xq\\000~\\000\\011sr\\000\\027java.util.LinkedHashSet\\330l\\327Z\\225\\335*\\036\\002\\000\\000xr\\000\\021java.util.HashSet\\272D\\205\\225\\226\\270\\2674\\003\\000\\000xpw\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\002t\\000\\004readt\\000\\005writex\\001sq\\000~\\000#w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001sr\\000Borg.springframework.security.core.authority.SimpleGrantedAuthority\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\001L\\000\\004roleq\\000~\\000\\017xpt\\000\\012ROLE_ADMINxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dpsq\\000~\\000#w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001t\\000\\017speaker-servicexsq\\000~\\000#w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001q\\000~\\000\\032xsr\\000Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\013credentialsq\\000~\\000\\005L\\000\\011principalq\\000~\\000\\005xq\\000~\\000\\003\\001sr\\000\\037java.util.Collections$EmptyListz\\270\\027\\264<\\247\\236\\336\\002\\000\\000xpsr\\000Horg.springframework.security.web.authentication.WebAuthenticationDetails\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\015remoteAddressq\\000~\\000\\017L\\000\\011sessionIdq\\000~\\000\\017xpt\\000\\0170:0:0:0:0:0:0:1ppsr\\000.com.fastbee.common.core.domain.model.LoginUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\013L\\000\\007browserq\\000~\\000\\017L\\000\\006deptIdt\\000\\020Ljava/lang/Long;L\\000\\012expireTimeq\\000~\\0008L\\000\\006ipaddrq\\000~\\000\\017L\\000\\015loginLocationq\\000~\\000\\017L\\000\\011loginTimeq\\000~\\0008L\\000\\002osq\\000~\\000\\017L\\000\\013permissionsq\\000~\\000\\021L\\000\\005tokenq\\000~\\000\\017L\\000\\004usert\\000/Lcom/fastbee/common/core/domain/entity/SysUser;L\\000\\006userIdq\\000~\\0008xpt\\000\\011Chrome 11sr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000gsq\\000~\\000<\\000\\000\\001\\212\\254\\011|Ct\\000\\011127.0.0.1t\\000\\010\\345\\206\\205\\347\\275\\221IPsq\\000~\\000<\\000\\000\\001\\212\\246\\343 Ct\\000\\012Windows 10sq\\000~\\000#w\\014\\000\\000\\000\\002?@\\000\\000\\000\\000\\000\\001t\\000\\005*:*:*xt\\000$92db9efe-ed8f-49e9-a899-6d941c33927csr\\000-com.fastbee.common.core.domain.entity.SysUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\022L\\000\\006avatarq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017L\\000\\004deptt\\000/Lcom/fastbee/common/core/domain/entity/SysDept;L\\000\\006deptIdq\\000~\\0008L\\000\\005emailq\\000~\\000\\017L\\000\\011loginDatet\\000\\020Ljava/util/Date;L\\000\\007loginIpq\\000~\\000\\017L\\000\\010nickNameq\\000~\\000\\017L\\000\\010passwordq\\000~\\000\\017L\\000\\013phonenumberq\\000~\\000\\017[\\000\\007postIdst\\000\\021[Ljava/lang/Long;L\\000\\006roleIdq\\000~\\0008[\\000\\007roleIdsq\\000~\\000JL\\000\\005rolesq\\000~\\000\\010L\\000\\003sexq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017L\\000\\006userIdq\\000~\\0008L\\000\\010userNameq\\000~\\000\\017xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\017L\\000\\012createTimeq\\000~\\000IL\\000\\006paramsq\\000~\\000\\016L\\000\\006remarkq\\000~\\000\\017L\\000\\013searchValueq\\000~\\000\\017L\\000\\010updateByq\\000~\\000\\017L\\000\\012updateTimeq\\000~\\000Ixpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001}\\276N\\330Pxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000\\011\\347\\256\\241\\347\\220\\206\\345\\221\\230pppt\\000\\000t\\000\\0010sr\\000-com.fastbee.common.core.domain.entity.SysDept\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\014L\\000\\011ancestorsq\\000~\\000\\017L\\000\\010childrenq\\000~\\000\\010L\\000\\007delFlagq\\000~\\000\\017L\\000\\006deptIdq\\000~\\0008L\\000\\010deptNameq\\000~\\000\\017L\\000\\005emailq\\000~\\000\\017L\\000\\006leaderq\\000~\\000\\017L\\000\\010orderNumt\\000\\023Ljava/lang/Integer;L\\000\\010parentIdq\\000~\\0008L\\000\\012parentNameq\\000~\\000\\017L\\000\\005phoneq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017xq\\000~\\000Kppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xppppt\\000\\0110,100,101sq\\000~\\000\\013\\000\\000\\000\\000w\\004\\000\\000\\000\\000xpq\\000~\\000>t\\000\\014\\347\\240\\224\\345\\217\\221\\351\\203\\250\\351\\227\\250pt\\000\\006\\347\\211\\251\\347\\276\\216sr\\000\\021java.lang.Integer\\022\\342\\240\\244\\367\\201\\2078\\002\\000\\001I\\000\\005valuexq\\000~\\000=\\000\\000\\000\\001sq\\000~\\000<\\000\\000\\000\\000\\000\\000\\000eppt\\000\\0011q\\000~\\000>t\\000\\020164770707@qq.comsq\\000~\\000Nw\\010\\000\\000\\001\\212\\246Q\\303\\270xt\\000\\011127.0.0.1t\\000\\017\\350\\234\\202\\344\\277\\241\\347\\256\\241\\347\\220\\206\\345\\221\\230t\\000<$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUut\\000\\01315888888888pppsq\\000~\\000\\013\\000\\000\\000\\001w\\004\\000\\000\\000\\001sr\\000-com.fastbee.common.core.domain.entity.SysRole\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\015Z\\000\\021deptCheckStrictlyZ\\000\\004flagZ\\000\\021menuCheckStrictlyL\\000\\011dataScopeq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017[\\000\\007deptIdsq\\000~\\000J[\\000\\007menuIdsq\\000~\\000JL\\000\\013permissionsq\\000~\\000\\021L\\000\\006roleIdq\\000~\\0008L\\000\\007roleKeyq\\000~\\000\\017L\\000\\010roleNameq\\000~\\000\\017L\\000\\010roleSortq\\000~\\000UL\\000\\006statusq\\000~\\000\\017xq\\000~\\000Kppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xpppp\\000\\000\\000t\\000\\0011ppppsq\\000~\\000<\\000\\000\\000\\000\\000\\000\\000\\001t\\000\\005admint\\000\\017\\350\\266\\205\\347\\272\\247\\347\\256\\241\\347\\220\\206\\345\\221\\230q\\000~\\000]t\\000\\0010xt\\000\\0010t\\000\\0010q\\000~\\000kt\\000\\005adminq\\000~\\000k');
INSERT INTO "public"."oauth_code" ("code", "authentication") VALUES ('1YESo2', E'\\254\\355\\000\\005sr\\000Aorg.springframework.security.oauth2.provider.OAuth2Authentication\\275@\\013\\002\\026bR\\023\\002\\000\\002L\\000\\015storedRequestt\\000<Lorg/springframework/security/oauth2/provider/OAuth2Request;L\\000\\022userAuthenticationt\\0002Lorg/springframework/security/core/Authentication;xr\\000Gorg.springframework.security.authentication.AbstractAuthenticationToken\\323\\252(~nGd\\016\\002\\000\\003Z\\000\\015authenticatedL\\000\\013authoritiest\\000\\026Ljava/util/Collection;L\\000\\007detailst\\000\\022Ljava/lang/Object;xp\\000sr\\000&java.util.Collections$UnmodifiableList\\374\\017%1\\265\\354\\216\\020\\002\\000\\001L\\000\\004listt\\000\\020Ljava/util/List;xr\\000,java.util.Collections$UnmodifiableCollection\\031B\\000\\200\\313^\\367\\036\\002\\000\\001L\\000\\001cq\\000~\\000\\004xpsr\\000\\023java.util.ArrayListx\\201\\322\\035\\231\\307a\\235\\003\\000\\001I\\000\\004sizexp\\000\\000\\000\\000w\\004\\000\\000\\000\\000xq\\000~\\000\\014psr\\000:org.springframework.security.oauth2.provider.OAuth2Request\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007Z\\000\\010approvedL\\000\\013authoritiesq\\000~\\000\\004L\\000\\012extensionst\\000\\017Ljava/util/Map;L\\000\\013redirectUrit\\000\\022Ljava/lang/String;L\\000\\007refresht\\000;Lorg/springframework/security/oauth2/provider/TokenRequest;L\\000\\013resourceIdst\\000\\017Ljava/util/Set;L\\000\\015responseTypesq\\000~\\000\\021xr\\0008org.springframework.security.oauth2.provider.BaseRequest6(z>\\243qi\\275\\002\\000\\003L\\000\\010clientIdq\\000~\\000\\017L\\000\\021requestParametersq\\000~\\000\\016L\\000\\005scopeq\\000~\\000\\021xpt\\000\\014admin-duerossr\\000%java.util.Collections$UnmodifiableMap\\361\\245\\250\\376t\\365\\007B\\002\\000\\001L\\000\\001mq\\000~\\000\\016xpsr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\006w\\010\\000\\000\\000\\010\\000\\000\\000\\004t\\000\\015response_typet\\000\\004codet\\000\\014redirect_urit\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dt\\000\\011client_idq\\000~\\000\\024t\\000\\005scopet\\000\\012read writexsr\\000%java.util.Collections$UnmodifiableSet\\200\\035\\222\\321\\217\\233\\200U\\002\\000\\000xq\\000~\\000\\011sr\\000\\027java.util.LinkedHashSet\\330l\\327Z\\225\\335*\\036\\002\\000\\000xr\\000\\021java.util.HashSet\\272D\\205\\225\\226\\270\\2674\\003\\000\\000xpw\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\002t\\000\\004readt\\000\\005writex\\001sq\\000~\\000#w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001sr\\000Borg.springframework.security.core.authority.SimpleGrantedAuthority\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\001L\\000\\004roleq\\000~\\000\\017xpt\\000\\012ROLE_ADMINxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dpsq\\000~\\000#w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001t\\000\\017speaker-servicexsq\\000~\\000#w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001q\\000~\\000\\032xsr\\000Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\013credentialsq\\000~\\000\\005L\\000\\011principalq\\000~\\000\\005xq\\000~\\000\\003\\001sr\\000\\037java.util.Collections$EmptyListz\\270\\027\\264<\\247\\236\\336\\002\\000\\000xpsr\\000Horg.springframework.security.web.authentication.WebAuthenticationDetails\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\015remoteAddressq\\000~\\000\\017L\\000\\011sessionIdq\\000~\\000\\017xpt\\000\\0170:0:0:0:0:0:0:1ppsr\\000.com.fastbee.common.core.domain.model.LoginUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\013L\\000\\007browserq\\000~\\000\\017L\\000\\006deptIdt\\000\\020Ljava/lang/Long;L\\000\\012expireTimeq\\000~\\0008L\\000\\006ipaddrq\\000~\\000\\017L\\000\\015loginLocationq\\000~\\000\\017L\\000\\011loginTimeq\\000~\\0008L\\000\\002osq\\000~\\000\\017L\\000\\013permissionsq\\000~\\000\\021L\\000\\005tokenq\\000~\\000\\017L\\000\\004usert\\000/Lcom/fastbee/common/core/domain/entity/SysUser;L\\000\\006userIdq\\000~\\0008xpt\\000\\011Chrome 11sr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000gsq\\000~\\000<\\000\\000\\001\\212\\254\\011|Ct\\000\\011127.0.0.1t\\000\\010\\345\\206\\205\\347\\275\\221IPsq\\000~\\000<\\000\\000\\001\\212\\246\\343 Ct\\000\\012Windows 10sq\\000~\\000#w\\014\\000\\000\\000\\002?@\\000\\000\\000\\000\\000\\001t\\000\\005*:*:*xt\\000$92db9efe-ed8f-49e9-a899-6d941c33927csr\\000-com.fastbee.common.core.domain.entity.SysUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\022L\\000\\006avatarq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017L\\000\\004deptt\\000/Lcom/fastbee/common/core/domain/entity/SysDept;L\\000\\006deptIdq\\000~\\0008L\\000\\005emailq\\000~\\000\\017L\\000\\011loginDatet\\000\\020Ljava/util/Date;L\\000\\007loginIpq\\000~\\000\\017L\\000\\010nickNameq\\000~\\000\\017L\\000\\010passwordq\\000~\\000\\017L\\000\\013phonenumberq\\000~\\000\\017[\\000\\007postIdst\\000\\021[Ljava/lang/Long;L\\000\\006roleIdq\\000~\\0008[\\000\\007roleIdsq\\000~\\000JL\\000\\005rolesq\\000~\\000\\010L\\000\\003sexq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017L\\000\\006userIdq\\000~\\0008L\\000\\010userNameq\\000~\\000\\017xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\017L\\000\\012createTimeq\\000~\\000IL\\000\\006paramsq\\000~\\000\\016L\\000\\006remarkq\\000~\\000\\017L\\000\\013searchValueq\\000~\\000\\017L\\000\\010updateByq\\000~\\000\\017L\\000\\012updateTimeq\\000~\\000Ixpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001}\\276N\\330Pxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000\\011\\347\\256\\241\\347\\220\\206\\345\\221\\230pppt\\000\\000t\\000\\0010sr\\000-com.fastbee.common.core.domain.entity.SysDept\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\014L\\000\\011ancestorsq\\000~\\000\\017L\\000\\010childrenq\\000~\\000\\010L\\000\\007delFlagq\\000~\\000\\017L\\000\\006deptIdq\\000~\\0008L\\000\\010deptNameq\\000~\\000\\017L\\000\\005emailq\\000~\\000\\017L\\000\\006leaderq\\000~\\000\\017L\\000\\010orderNumt\\000\\023Ljava/lang/Integer;L\\000\\010parentIdq\\000~\\0008L\\000\\012parentNameq\\000~\\000\\017L\\000\\005phoneq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017xq\\000~\\000Kppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xppppt\\000\\0110,100,101sq\\000~\\000\\013\\000\\000\\000\\000w\\004\\000\\000\\000\\000xpq\\000~\\000>t\\000\\014\\347\\240\\224\\345\\217\\221\\351\\203\\250\\351\\227\\250pt\\000\\006\\347\\211\\251\\347\\276\\216sr\\000\\021java.lang.Integer\\022\\342\\240\\244\\367\\201\\2078\\002\\000\\001I\\000\\005valuexq\\000~\\000=\\000\\000\\000\\001sq\\000~\\000<\\000\\000\\000\\000\\000\\000\\000eppt\\000\\0011q\\000~\\000>t\\000\\020164770707@qq.comsq\\000~\\000Nw\\010\\000\\000\\001\\212\\246Q\\303\\270xt\\000\\011127.0.0.1t\\000\\017\\350\\234\\202\\344\\277\\241\\347\\256\\241\\347\\220\\206\\345\\221\\230t\\000<$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUut\\000\\01315888888888pppsq\\000~\\000\\013\\000\\000\\000\\001w\\004\\000\\000\\000\\001sr\\000-com.fastbee.common.core.domain.entity.SysRole\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\015Z\\000\\021deptCheckStrictlyZ\\000\\004flagZ\\000\\021menuCheckStrictlyL\\000\\011dataScopeq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017[\\000\\007deptIdsq\\000~\\000J[\\000\\007menuIdsq\\000~\\000JL\\000\\013permissionsq\\000~\\000\\021L\\000\\006roleIdq\\000~\\0008L\\000\\007roleKeyq\\000~\\000\\017L\\000\\010roleNameq\\000~\\000\\017L\\000\\010roleSortq\\000~\\000UL\\000\\006statusq\\000~\\000\\017xq\\000~\\000Kppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xpppp\\000\\000\\000t\\000\\0011ppppsq\\000~\\000<\\000\\000\\000\\000\\000\\000\\000\\001t\\000\\005admint\\000\\017\\350\\266\\205\\347\\272\\247\\347\\256\\241\\347\\220\\206\\345\\221\\230q\\000~\\000]t\\000\\0010xt\\000\\0010t\\000\\0010q\\000~\\000kt\\000\\005adminq\\000~\\000k');
INSERT INTO "public"."oauth_code" ("code", "authentication") VALUES ('DhdDPY', E'\\254\\355\\000\\005sr\\000Aorg.springframework.security.oauth2.provider.OAuth2Authentication\\275@\\013\\002\\026bR\\023\\002\\000\\002L\\000\\015storedRequestt\\000<Lorg/springframework/security/oauth2/provider/OAuth2Request;L\\000\\022userAuthenticationt\\0002Lorg/springframework/security/core/Authentication;xr\\000Gorg.springframework.security.authentication.AbstractAuthenticationToken\\323\\252(~nGd\\016\\002\\000\\003Z\\000\\015authenticatedL\\000\\013authoritiest\\000\\026Ljava/util/Collection;L\\000\\007detailst\\000\\022Ljava/lang/Object;xp\\000sr\\000&java.util.Collections$UnmodifiableList\\374\\017%1\\265\\354\\216\\020\\002\\000\\001L\\000\\004listt\\000\\020Ljava/util/List;xr\\000,java.util.Collections$UnmodifiableCollection\\031B\\000\\200\\313^\\367\\036\\002\\000\\001L\\000\\001cq\\000~\\000\\004xpsr\\000\\023java.util.ArrayListx\\201\\322\\035\\231\\307a\\235\\003\\000\\001I\\000\\004sizexp\\000\\000\\000\\000w\\004\\000\\000\\000\\000xq\\000~\\000\\014psr\\000:org.springframework.security.oauth2.provider.OAuth2Request\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007Z\\000\\010approvedL\\000\\013authoritiesq\\000~\\000\\004L\\000\\012extensionst\\000\\017Ljava/util/Map;L\\000\\013redirectUrit\\000\\022Ljava/lang/String;L\\000\\007refresht\\000;Lorg/springframework/security/oauth2/provider/TokenRequest;L\\000\\013resourceIdst\\000\\017Ljava/util/Set;L\\000\\015responseTypesq\\000~\\000\\021xr\\0008org.springframework.security.oauth2.provider.BaseRequest6(z>\\243qi\\275\\002\\000\\003L\\000\\010clientIdq\\000~\\000\\017L\\000\\021requestParametersq\\000~\\000\\016L\\000\\005scopeq\\000~\\000\\021xpt\\000\\014admin-duerossr\\000%java.util.Collections$UnmodifiableMap\\361\\245\\250\\376t\\365\\007B\\002\\000\\001L\\000\\001mq\\000~\\000\\016xpsr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\014w\\010\\000\\000\\000\\020\\000\\000\\000\\006t\\000\\005scopet\\000\\012read writet\\000\\015response_typet\\000\\004codet\\000\\014redirect_urit\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dt\\000\\005statet\\000 4f5e7c04b1710bbe867e57d1744a5478t\\000\\012dueros_uidt\\000 4f5e7c04b1710bbe867e57d1744a5478t\\000\\011client_idq\\000~\\000\\024xsr\\000%java.util.Collections$UnmodifiableSet\\200\\035\\222\\321\\217\\233\\200U\\002\\000\\000xq\\000~\\000\\011sr\\000\\027java.util.LinkedHashSet\\330l\\327Z\\225\\335*\\036\\002\\000\\000xr\\000\\021java.util.HashSet\\272D\\205\\225\\226\\270\\2674\\003\\000\\000xpw\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\002t\\000\\004readt\\000\\005writex\\001sq\\000~\\000''w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001sr\\000Borg.springframework.security.core.authority.SimpleGrantedAuthority\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\001L\\000\\004roleq\\000~\\000\\017xpt\\000\\012ROLE_ADMINxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dpsq\\000~\\000''w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001t\\000\\017speaker-servicexsq\\000~\\000''w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001q\\000~\\000\\034xsr\\000Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\013credentialsq\\000~\\000\\005L\\000\\011principalq\\000~\\000\\005xq\\000~\\000\\003\\001sr\\000\\037java.util.Collections$EmptyListz\\270\\027\\264<\\247\\236\\336\\002\\000\\000xpsr\\000Horg.springframework.security.web.authentication.WebAuthenticationDetails\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\015remoteAddressq\\000~\\000\\017L\\000\\011sessionIdq\\000~\\000\\017xpt\\000\\0170:0:0:0:0:0:0:1ppsr\\000.com.fastbee.common.core.domain.model.LoginUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\013L\\000\\007browserq\\000~\\000\\017L\\000\\006deptIdt\\000\\020Ljava/lang/Long;L\\000\\012expireTimeq\\000~\\000<L\\000\\006ipaddrq\\000~\\000\\017L\\000\\015loginLocationq\\000~\\000\\017L\\000\\011loginTimeq\\000~\\000<L\\000\\002osq\\000~\\000\\017L\\000\\013permissionsq\\000~\\000\\021L\\000\\005tokenq\\000~\\000\\017L\\000\\004usert\\000/Lcom/fastbee/common/core/domain/entity/SysUser;L\\000\\006userIdq\\000~\\000<xpt\\000\\011Chrome 11sr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000gsq\\000~\\000@\\000\\000\\001\\212\\254\\011|Ct\\000\\011127.0.0.1t\\000\\010\\345\\206\\205\\347\\275\\221IPsq\\000~\\000@\\000\\000\\001\\212\\246\\343 Ct\\000\\012Windows 10sq\\000~\\000''w\\014\\000\\000\\000\\002?@\\000\\000\\000\\000\\000\\001t\\000\\005*:*:*xt\\000$92db9efe-ed8f-49e9-a899-6d941c33927csr\\000-com.fastbee.common.core.domain.entity.SysUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\022L\\000\\006avatarq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017L\\000\\004deptt\\000/Lcom/fastbee/common/core/domain/entity/SysDept;L\\000\\006deptIdq\\000~\\000<L\\000\\005emailq\\000~\\000\\017L\\000\\011loginDatet\\000\\020Ljava/util/Date;L\\000\\007loginIpq\\000~\\000\\017L\\000\\010nickNameq\\000~\\000\\017L\\000\\010passwordq\\000~\\000\\017L\\000\\013phonenumberq\\000~\\000\\017[\\000\\007postIdst\\000\\021[Ljava/lang/Long;L\\000\\006roleIdq\\000~\\000<[\\000\\007roleIdsq\\000~\\000NL\\000\\005rolesq\\000~\\000\\010L\\000\\003sexq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017L\\000\\006userIdq\\000~\\000<L\\000\\010userNameq\\000~\\000\\017xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\017L\\000\\012createTimeq\\000~\\000ML\\000\\006paramsq\\000~\\000\\016L\\000\\006remarkq\\000~\\000\\017L\\000\\013searchValueq\\000~\\000\\017L\\000\\010updateByq\\000~\\000\\017L\\000\\012updateTimeq\\000~\\000Mxpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001}\\276N\\330Pxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000\\011\\347\\256\\241\\347\\220\\206\\345\\221\\230pppt\\000\\000t\\000\\0010sr\\000-com.fastbee.common.core.domain.entity.SysDept\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\014L\\000\\011ancestorsq\\000~\\000\\017L\\000\\010childrenq\\000~\\000\\010L\\000\\007delFlagq\\000~\\000\\017L\\000\\006deptIdq\\000~\\000<L\\000\\010deptNameq\\000~\\000\\017L\\000\\005emailq\\000~\\000\\017L\\000\\006leaderq\\000~\\000\\017L\\000\\010orderNumt\\000\\023Ljava/lang/Integer;L\\000\\010parentIdq\\000~\\000<L\\000\\012parentNameq\\000~\\000\\017L\\000\\005phoneq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017xq\\000~\\000Oppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xppppt\\000\\0110,100,101sq\\000~\\000\\013\\000\\000\\000\\000w\\004\\000\\000\\000\\000xpq\\000~\\000Bt\\000\\014\\347\\240\\224\\345\\217\\221\\351\\203\\250\\351\\227\\250pt\\000\\006\\347\\211\\251\\347\\276\\216sr\\000\\021java.lang.Integer\\022\\342\\240\\244\\367\\201\\2078\\002\\000\\001I\\000\\005valuexq\\000~\\000A\\000\\000\\000\\001sq\\000~\\000@\\000\\000\\000\\000\\000\\000\\000eppt\\000\\0011q\\000~\\000Bt\\000\\020164770707@qq.comsq\\000~\\000Rw\\010\\000\\000\\001\\212\\246Q\\303\\270xt\\000\\011127.0.0.1t\\000\\017\\350\\234\\202\\344\\277\\241\\347\\256\\241\\347\\220\\206\\345\\221\\230t\\000<$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUut\\000\\01315888888888pppsq\\000~\\000\\013\\000\\000\\000\\001w\\004\\000\\000\\000\\001sr\\000-com.fastbee.common.core.domain.entity.SysRole\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\015Z\\000\\021deptCheckStrictlyZ\\000\\004flagZ\\000\\021menuCheckStrictlyL\\000\\011dataScopeq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017[\\000\\007deptIdsq\\000~\\000N[\\000\\007menuIdsq\\000~\\000NL\\000\\013permissionsq\\000~\\000\\021L\\000\\006roleIdq\\000~\\000<L\\000\\007roleKeyq\\000~\\000\\017L\\000\\010roleNameq\\000~\\000\\017L\\000\\010roleSortq\\000~\\000YL\\000\\006statusq\\000~\\000\\017xq\\000~\\000Oppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xpppp\\000\\000\\000t\\000\\0011ppppsq\\000~\\000@\\000\\000\\000\\000\\000\\000\\000\\001t\\000\\005admint\\000\\017\\350\\266\\205\\347\\272\\247\\347\\256\\241\\347\\220\\206\\345\\221\\230q\\000~\\000at\\000\\0010xt\\000\\0010t\\000\\0010q\\000~\\000ot\\000\\005adminq\\000~\\000o');
COMMIT;

-- ----------------------------
-- Table structure for oauth_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS "public"."oauth_refresh_token";
CREATE TABLE "public"."oauth_refresh_token" (
  "token_id" varchar(255),
  "token" bytea,
  "authentication" bytea
)
;

-- ----------------------------
-- Records of oauth_refresh_token
-- ----------------------------
BEGIN;
INSERT INTO "public"."oauth_refresh_token" ("token_id", "token", "authentication") VALUES ('4cabc0e9bcfa34131342209bdaf275eb', E'\\254\\355\\000\\005sr\\000Lorg.springframework.security.oauth2.common.DefaultExpiringOAuth2RefreshToken/\\337Gc\\235\\320\\311\\267\\002\\000\\001L\\000\\012expirationt\\000\\020Ljava/util/Date;xr\\000Dorg.springframework.security.oauth2.common.DefaultOAuth2RefreshTokens\\341\\016\\012cT\\324^\\002\\000\\001L\\000\\005valuet\\000\\022Ljava/lang/String;xpt\\000\\033VE-7wD8mpAJ4Izf-I4_EdP1o1bosr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001\\212\\247`\\321-x', E'\\254\\355\\000\\005sr\\000Aorg.springframework.security.oauth2.provider.OAuth2Authentication\\275@\\013\\002\\026bR\\023\\002\\000\\002L\\000\\015storedRequestt\\000<Lorg/springframework/security/oauth2/provider/OAuth2Request;L\\000\\022userAuthenticationt\\0002Lorg/springframework/security/core/Authentication;xr\\000Gorg.springframework.security.authentication.AbstractAuthenticationToken\\323\\252(~nGd\\016\\002\\000\\003Z\\000\\015authenticatedL\\000\\013authoritiest\\000\\026Ljava/util/Collection;L\\000\\007detailst\\000\\022Ljava/lang/Object;xp\\000sr\\000&java.util.Collections$UnmodifiableList\\374\\017%1\\265\\354\\216\\020\\002\\000\\001L\\000\\004listt\\000\\020Ljava/util/List;xr\\000,java.util.Collections$UnmodifiableCollection\\031B\\000\\200\\313^\\367\\036\\002\\000\\001L\\000\\001cq\\000~\\000\\004xpsr\\000\\023java.util.ArrayListx\\201\\322\\035\\231\\307a\\235\\003\\000\\001I\\000\\004sizexp\\000\\000\\000\\000w\\004\\000\\000\\000\\000xq\\000~\\000\\014psr\\000:org.springframework.security.oauth2.provider.OAuth2Request\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007Z\\000\\010approvedL\\000\\013authoritiesq\\000~\\000\\004L\\000\\012extensionst\\000\\017Ljava/util/Map;L\\000\\013redirectUrit\\000\\022Ljava/lang/String;L\\000\\007refresht\\000;Lorg/springframework/security/oauth2/provider/TokenRequest;L\\000\\013resourceIdst\\000\\017Ljava/util/Set;L\\000\\015responseTypesq\\000~\\000\\021xr\\0008org.springframework.security.oauth2.provider.BaseRequest6(z>\\243qi\\275\\002\\000\\003L\\000\\010clientIdq\\000~\\000\\017L\\000\\021requestParametersq\\000~\\000\\016L\\000\\005scopeq\\000~\\000\\021xpt\\000\\014admin-duerossr\\000%java.util.Collections$UnmodifiableMap\\361\\245\\250\\376t\\365\\007B\\002\\000\\001L\\000\\001mq\\000~\\000\\016xpsr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\014w\\010\\000\\000\\000\\020\\000\\000\\000\\011t\\000\\004codet\\000\\006SlKOhLt\\000\\012grant_typet\\000\\022authorization_codet\\000\\005scopet\\000\\012read writet\\000\\015response_typet\\000\\004codet\\000\\014redirect_urit\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dt\\000\\005statet\\000 4f5e7c04b1710bbe867e57d1744a5478t\\000\\015client_secrett\\000"S2EneHxdt^MHhBv8N%23$^ty6nq$NQY2Ndt\\000\\012dueros_uidt\\000 4f5e7c04b1710bbe867e57d1744a5478t\\000\\011client_idt\\000\\014admin-duerosxsr\\000%java.util.Collections$UnmodifiableSet\\200\\035\\222\\321\\217\\233\\200U\\002\\000\\000xq\\000~\\000\\011sr\\000\\027java.util.LinkedHashSet\\330l\\327Z\\225\\335*\\036\\002\\000\\000xr\\000\\021java.util.HashSet\\272D\\205\\225\\226\\270\\2674\\003\\000\\000xpw\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\002t\\000\\004readt\\000\\005writex\\001sq\\000~\\000.w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001sr\\000Borg.springframework.security.core.authority.SimpleGrantedAuthority\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\001L\\000\\004roleq\\000~\\000\\017xpt\\000\\012ROLE_ADMINxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000Dhttps://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694dpsq\\000~\\000.w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001t\\000\\017speaker-servicexsq\\000~\\000.w\\014\\000\\000\\000\\020?@\\000\\000\\000\\000\\000\\001q\\000~\\000 xsr\\000Oorg.springframework.security.authentication.UsernamePasswordAuthenticationToken\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\013credentialsq\\000~\\000\\005L\\000\\011principalq\\000~\\000\\005xq\\000~\\000\\003\\001sr\\000\\037java.util.Collections$EmptyListz\\270\\027\\264<\\247\\236\\336\\002\\000\\000xpsr\\000Horg.springframework.security.web.authentication.WebAuthenticationDetails\\000\\000\\000\\000\\000\\000\\002&\\002\\000\\002L\\000\\015remoteAddressq\\000~\\000\\017L\\000\\011sessionIdq\\000~\\000\\017xpt\\000\\0170:0:0:0:0:0:0:1ppsr\\000.com.fastbee.common.core.domain.model.LoginUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\013L\\000\\007browserq\\000~\\000\\017L\\000\\006deptIdt\\000\\020Ljava/lang/Long;L\\000\\012expireTimeq\\000~\\000CL\\000\\006ipaddrq\\000~\\000\\017L\\000\\015loginLocationq\\000~\\000\\017L\\000\\011loginTimeq\\000~\\000CL\\000\\002osq\\000~\\000\\017L\\000\\013permissionsq\\000~\\000\\021L\\000\\005tokenq\\000~\\000\\017L\\000\\004usert\\000/Lcom/fastbee/common/core/domain/entity/SysUser;L\\000\\006userIdq\\000~\\000Cxpt\\000\\011Chrome 11sr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000gsq\\000~\\000G\\000\\000\\001\\212\\254\\011|Ct\\000\\011127.0.0.1t\\000\\010\\345\\206\\205\\347\\275\\221IPsq\\000~\\000G\\000\\000\\001\\212\\246\\343 Ct\\000\\012Windows 10sq\\000~\\000.w\\014\\000\\000\\000\\002?@\\000\\000\\000\\000\\000\\001t\\000\\005*:*:*xt\\000$92db9efe-ed8f-49e9-a899-6d941c33927csr\\000-com.fastbee.common.core.domain.entity.SysUser\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\022L\\000\\006avatarq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017L\\000\\004deptt\\000/Lcom/fastbee/common/core/domain/entity/SysDept;L\\000\\006deptIdq\\000~\\000CL\\000\\005emailq\\000~\\000\\017L\\000\\011loginDatet\\000\\020Ljava/util/Date;L\\000\\007loginIpq\\000~\\000\\017L\\000\\010nickNameq\\000~\\000\\017L\\000\\010passwordq\\000~\\000\\017L\\000\\013phonenumberq\\000~\\000\\017[\\000\\007postIdst\\000\\021[Ljava/lang/Long;L\\000\\006roleIdq\\000~\\000C[\\000\\007roleIdsq\\000~\\000UL\\000\\005rolesq\\000~\\000\\010L\\000\\003sexq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017L\\000\\006userIdq\\000~\\000CL\\000\\010userNameq\\000~\\000\\017xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\017L\\000\\012createTimeq\\000~\\000TL\\000\\006paramsq\\000~\\000\\016L\\000\\006remarkq\\000~\\000\\017L\\000\\013searchValueq\\000~\\000\\017L\\000\\010updateByq\\000~\\000\\017L\\000\\012updateTimeq\\000~\\000Txpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001}\\276N\\330Pxsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xt\\000\\011\\347\\256\\241\\347\\220\\206\\345\\221\\230pppt\\000\\000t\\000\\0010sr\\000-com.fastbee.common.core.domain.entity.SysDept\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\014L\\000\\011ancestorsq\\000~\\000\\017L\\000\\010childrenq\\000~\\000\\010L\\000\\007delFlagq\\000~\\000\\017L\\000\\006deptIdq\\000~\\000CL\\000\\010deptNameq\\000~\\000\\017L\\000\\005emailq\\000~\\000\\017L\\000\\006leaderq\\000~\\000\\017L\\000\\010orderNumt\\000\\023Ljava/lang/Integer;L\\000\\010parentIdq\\000~\\000CL\\000\\012parentNameq\\000~\\000\\017L\\000\\005phoneq\\000~\\000\\017L\\000\\006statusq\\000~\\000\\017xq\\000~\\000Vppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xppppt\\000\\0110,100,101sq\\000~\\000\\013\\000\\000\\000\\000w\\004\\000\\000\\000\\000xpq\\000~\\000It\\000\\014\\347\\240\\224\\345\\217\\221\\351\\203\\250\\351\\227\\250pt\\000\\006\\347\\211\\251\\347\\276\\216sr\\000\\021java.lang.Integer\\022\\342\\240\\244\\367\\201\\2078\\002\\000\\001I\\000\\005valuexq\\000~\\000H\\000\\000\\000\\001sq\\000~\\000G\\000\\000\\000\\000\\000\\000\\000eppt\\000\\0011q\\000~\\000It\\000\\020164770707@qq.comsq\\000~\\000Yw\\010\\000\\000\\001\\212\\246Q\\303\\270xt\\000\\011127.0.0.1t\\000\\017\\350\\234\\202\\344\\277\\241\\347\\256\\241\\347\\220\\206\\345\\221\\230t\\000<$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUut\\000\\01315888888888pppsq\\000~\\000\\013\\000\\000\\000\\001w\\004\\000\\000\\000\\001sr\\000-com.fastbee.common.core.domain.entity.SysRole\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\015Z\\000\\021deptCheckStrictlyZ\\000\\004flagZ\\000\\021menuCheckStrictlyL\\000\\011dataScopeq\\000~\\000\\017L\\000\\007delFlagq\\000~\\000\\017[\\000\\007deptIdsq\\000~\\000U[\\000\\007menuIdsq\\000~\\000UL\\000\\013permissionsq\\000~\\000\\021L\\000\\006roleIdq\\000~\\000CL\\000\\007roleKeyq\\000~\\000\\017L\\000\\010roleNameq\\000~\\000\\017L\\000\\010roleSortq\\000~\\000`L\\000\\006statusq\\000~\\000\\017xq\\000~\\000Vppsq\\000~\\000\\027?@\\000\\000\\000\\000\\000\\000w\\010\\000\\000\\000\\020\\000\\000\\000\\000xpppp\\000\\000\\000t\\000\\0011ppppsq\\000~\\000G\\000\\000\\000\\000\\000\\000\\000\\001t\\000\\005admint\\000\\017\\350\\266\\205\\347\\272\\247\\347\\256\\241\\347\\220\\206\\345\\221\\230q\\000~\\000ht\\000\\0010xt\\000\\0010t\\000\\0010q\\000~\\000vt\\000\\005adminq\\000~\\000v');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_blob_triggers";
CREATE TABLE "public"."qrtz_blob_triggers" (
  "sched_name" varchar(120) NOT NULL,
  "trigger_name" varchar(200) NOT NULL,
  "trigger_group" varchar(200) NOT NULL,
  "blob_data" bytea
)
;
COMMENT ON COLUMN "public"."qrtz_blob_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_blob_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "public"."qrtz_blob_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "public"."qrtz_blob_triggers"."blob_data" IS '存放持久化Trigger对象';
COMMENT ON TABLE "public"."qrtz_blob_triggers" IS 'Blob类型的触发器表';

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_calendars";
CREATE TABLE "public"."qrtz_calendars" (
  "sched_name" varchar(120) NOT NULL,
  "calendar_name" varchar(200) NOT NULL,
  "calendar" bytea NOT NULL
)
;
COMMENT ON COLUMN "public"."qrtz_calendars"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_calendars"."calendar_name" IS '日历名称';
COMMENT ON COLUMN "public"."qrtz_calendars"."calendar" IS '存放持久化calendar对象';
COMMENT ON TABLE "public"."qrtz_calendars" IS '日历信息表';

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_cron_triggers";
CREATE TABLE "public"."qrtz_cron_triggers" (
  "sched_name" varchar(120) NOT NULL,
  "trigger_name" varchar(200) NOT NULL,
  "trigger_group" varchar(200) NOT NULL,
  "cron_expression" varchar(200) NOT NULL,
  "time_zone_id" varchar(80)
)
;
COMMENT ON COLUMN "public"."qrtz_cron_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_cron_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "public"."qrtz_cron_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "public"."qrtz_cron_triggers"."cron_expression" IS 'cron表达式';
COMMENT ON COLUMN "public"."qrtz_cron_triggers"."time_zone_id" IS '时区';
COMMENT ON TABLE "public"."qrtz_cron_triggers" IS 'Cron类型的触发器表';

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
BEGIN;
INSERT INTO "public"."qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO "public"."qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO "public"."qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');
INSERT INTO "public"."qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'SYSTEM', '0 0/4 * * * ? ', 'Asia/Shanghai');
INSERT INTO "public"."qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME5', 'SYSTEM', '0 0/1 * * * ? ', 'Asia/Shanghai');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_fired_triggers";
CREATE TABLE "public"."qrtz_fired_triggers" (
  "sched_name" varchar(120) NOT NULL,
  "entry_id" varchar(95) NOT NULL,
  "trigger_name" varchar(200) NOT NULL,
  "trigger_group" varchar(200) NOT NULL,
  "instance_name" varchar(200) NOT NULL,
  "fired_time" int8 NOT NULL,
  "sched_time" int8 NOT NULL,
  "priority" int4 NOT NULL,
  "state" varchar(16) NOT NULL,
  "job_name" varchar(200),
  "job_group" varchar(200),
  "is_nonconcurrent" varchar(1),
  "requests_recovery" varchar(1)
)
;
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."entry_id" IS '调度器实例id';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."instance_name" IS '调度器实例名';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."fired_time" IS '触发的时间';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."sched_time" IS '定时器制定的时间';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."priority" IS '优先级';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."state" IS '状态';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."job_group" IS '任务组名';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."is_nonconcurrent" IS '是否并发';
COMMENT ON COLUMN "public"."qrtz_fired_triggers"."requests_recovery" IS '是否接受恢复执行';
COMMENT ON TABLE "public"."qrtz_fired_triggers" IS '已触发的触发器表';

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_job_details";
CREATE TABLE "public"."qrtz_job_details" (
  "sched_name" varchar(120) NOT NULL,
  "job_name" varchar(200) NOT NULL,
  "job_group" varchar(200) NOT NULL,
  "description" varchar(250),
  "job_class_name" varchar(250) NOT NULL,
  "is_durable" varchar(1) NOT NULL,
  "is_nonconcurrent" varchar(1) NOT NULL,
  "is_update_data" varchar(1) NOT NULL,
  "requests_recovery" varchar(1) NOT NULL,
  "job_data" bytea
)
;
COMMENT ON COLUMN "public"."qrtz_job_details"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_job_details"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."qrtz_job_details"."job_group" IS '任务组名';
COMMENT ON COLUMN "public"."qrtz_job_details"."description" IS '相关介绍';
COMMENT ON COLUMN "public"."qrtz_job_details"."job_class_name" IS '执行任务类名称';
COMMENT ON COLUMN "public"."qrtz_job_details"."is_durable" IS '是否持久化';
COMMENT ON COLUMN "public"."qrtz_job_details"."is_nonconcurrent" IS '是否并发';
COMMENT ON COLUMN "public"."qrtz_job_details"."is_update_data" IS '是否更新数据';
COMMENT ON COLUMN "public"."qrtz_job_details"."requests_recovery" IS '是否接受恢复执行';
COMMENT ON COLUMN "public"."qrtz_job_details"."job_data" IS '存放持久化job对象';
COMMENT ON TABLE "public"."qrtz_job_details" IS '任务详细信息表';

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
BEGIN;
INSERT INTO "public"."qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', E'\\254\\355\\000\\005sr\\000\\025org.quartz.JobDataMap\\237\\260\\203\\350\\277\\251\\260\\313\\002\\000\\000xr\\000&org.quartz.utils.StringKeyDirtyFlagMap\\202\\010\\350\\303\\373\\305](\\002\\000\\001Z\\000\\023allowsTransientDataxr\\000\\035org.quartz.utils.DirtyFlagMap\\023\\346.\\255(v\\012\\316\\002\\000\\002Z\\000\\005dirtyL\\000\\003mapt\\000\\017Ljava/util/Map;xp\\001sr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\014w\\010\\000\\000\\000\\020\\000\\000\\000\\001t\\000\\017TASK_PROPERTIESsr\\000 com.fastbee.quartz.domain.SysJob\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\010L\\000\\012concurrentt\\000\\022Ljava/lang/String;L\\000\\016cronExpressionq\\000~\\000\\011L\\000\\014invokeTargetq\\000~\\000\\011L\\000\\010jobGroupq\\000~\\000\\011L\\000\\005jobIdt\\000\\020Ljava/lang/Long;L\\000\\007jobNameq\\000~\\000\\011L\\000\\015misfirePolicyq\\000~\\000\\011L\\000\\006statusq\\000~\\000\\011xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\011L\\000\\012createTimet\\000\\020Ljava/util/Date;L\\000\\006paramsq\\000~\\000\\003L\\000\\006remarkq\\000~\\000\\011L\\000\\013searchValueq\\000~\\000\\011L\\000\\010updateByq\\000~\\000\\011L\\000\\012updateTimeq\\000~\\000\\014xpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001}\\276N\\330Pxpt\\000\\000pppt\\000\\0011t\\000\\0160/10 * * * * ?t\\000\\021ryTask.ryNoParamst\\000\\007DEFAULTsr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000\\001t\\000\\030\\347\\263\\273\\347\\273\\237\\351\\273\\230\\350\\256\\244\\357\\274\\210\\346\\227\\240\\345\\217\\202\\357\\274\\211t\\000\\0013t\\000\\0010x\\000');
INSERT INTO "public"."qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', E'\\254\\355\\000\\005sr\\000\\025org.quartz.JobDataMap\\237\\260\\203\\350\\277\\251\\260\\313\\002\\000\\000xr\\000&org.quartz.utils.StringKeyDirtyFlagMap\\202\\010\\350\\303\\373\\305](\\002\\000\\001Z\\000\\023allowsTransientDataxr\\000\\035org.quartz.utils.DirtyFlagMap\\023\\346.\\255(v\\012\\316\\002\\000\\002Z\\000\\005dirtyL\\000\\003mapt\\000\\017Ljava/util/Map;xp\\001sr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\014w\\010\\000\\000\\000\\020\\000\\000\\000\\001t\\000\\017TASK_PROPERTIESsr\\000 com.fastbee.quartz.domain.SysJob\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\010L\\000\\012concurrentt\\000\\022Ljava/lang/String;L\\000\\016cronExpressionq\\000~\\000\\011L\\000\\014invokeTargetq\\000~\\000\\011L\\000\\010jobGroupq\\000~\\000\\011L\\000\\005jobIdt\\000\\020Ljava/lang/Long;L\\000\\007jobNameq\\000~\\000\\011L\\000\\015misfirePolicyq\\000~\\000\\011L\\000\\006statusq\\000~\\000\\011xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\011L\\000\\012createTimet\\000\\020Ljava/util/Date;L\\000\\006paramsq\\000~\\000\\003L\\000\\006remarkq\\000~\\000\\011L\\000\\013searchValueq\\000~\\000\\011L\\000\\010updateByq\\000~\\000\\011L\\000\\012updateTimeq\\000~\\000\\014xpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001}\\276N\\330Pxpt\\000\\000pppt\\000\\0011t\\000\\0160/15 * * * * ?t\\000\\025ryTask.ryParams(''ry'')t\\000\\007DEFAULTsr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000\\002t\\000\\030\\347\\263\\273\\347\\273\\237\\351\\273\\230\\350\\256\\244\\357\\274\\210\\346\\234\\211\\345\\217\\202\\357\\274\\211t\\000\\0013t\\000\\0011x\\000');
INSERT INTO "public"."qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', E'\\254\\355\\000\\005sr\\000\\025org.quartz.JobDataMap\\237\\260\\203\\350\\277\\251\\260\\313\\002\\000\\000xr\\000&org.quartz.utils.StringKeyDirtyFlagMap\\202\\010\\350\\303\\373\\305](\\002\\000\\001Z\\000\\023allowsTransientDataxr\\000\\035org.quartz.utils.DirtyFlagMap\\023\\346.\\255(v\\012\\316\\002\\000\\002Z\\000\\005dirtyL\\000\\003mapt\\000\\017Ljava/util/Map;xp\\001sr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\014w\\010\\000\\000\\000\\020\\000\\000\\000\\001t\\000\\017TASK_PROPERTIESsr\\000 com.fastbee.quartz.domain.SysJob\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\010L\\000\\012concurrentt\\000\\022Ljava/lang/String;L\\000\\016cronExpressionq\\000~\\000\\011L\\000\\014invokeTargetq\\000~\\000\\011L\\000\\010jobGroupq\\000~\\000\\011L\\000\\005jobIdt\\000\\020Ljava/lang/Long;L\\000\\007jobNameq\\000~\\000\\011L\\000\\015misfirePolicyq\\000~\\000\\011L\\000\\006statusq\\000~\\000\\011xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\011L\\000\\012createTimet\\000\\020Ljava/util/Date;L\\000\\006paramsq\\000~\\000\\003L\\000\\006remarkq\\000~\\000\\011L\\000\\013searchValueq\\000~\\000\\011L\\000\\010updateByq\\000~\\000\\011L\\000\\012updateTimeq\\000~\\000\\014xpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001}\\276N\\330Pxpt\\000\\000pppt\\000\\0011t\\000\\0160/20 * * * * ?t\\0008ryTask.ryMultipleParams(''ry'', true, 2000L, 316.50D, 100)t\\000\\007DEFAULTsr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000\\003t\\000\\030\\347\\263\\273\\347\\273\\237\\351\\273\\230\\350\\256\\244\\357\\274\\210\\345\\244\\232\\345\\217\\202\\357\\274\\211t\\000\\0013t\\000\\0011x\\000');
INSERT INTO "public"."qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'SYSTEM', NULL, 'com.fastbee.quartz.util.QuartzJobExecution', '0', '0', '0', '0', E'\\254\\355\\000\\005sr\\000\\025org.quartz.JobDataMap\\237\\260\\203\\350\\277\\251\\260\\313\\002\\000\\000xr\\000&org.quartz.utils.StringKeyDirtyFlagMap\\202\\010\\350\\303\\373\\305](\\002\\000\\001Z\\000\\023allowsTransientDataxr\\000\\035org.quartz.utils.DirtyFlagMap\\023\\346.\\255(v\\012\\316\\002\\000\\002Z\\000\\005dirtyL\\000\\003mapt\\000\\017Ljava/util/Map;xp\\001sr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\014w\\010\\000\\000\\000\\020\\000\\000\\000\\001t\\000\\017TASK_PROPERTIESsr\\000 com.fastbee.quartz.domain.SysJob\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\010L\\000\\012concurrentt\\000\\022Ljava/lang/String;L\\000\\016cronExpressionq\\000~\\000\\011L\\000\\014invokeTargetq\\000~\\000\\011L\\000\\010jobGroupq\\000~\\000\\011L\\000\\005jobIdt\\000\\020Ljava/lang/Long;L\\000\\007jobNameq\\000~\\000\\011L\\000\\015misfirePolicyq\\000~\\000\\011L\\000\\006statusq\\000~\\000\\011xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\011L\\000\\012createTimet\\000\\020Ljava/util/Date;L\\000\\006paramsq\\000~\\000\\003L\\000\\006remarkq\\000~\\000\\011L\\000\\013searchValueq\\000~\\000\\011L\\000\\010updateByq\\000~\\000\\011L\\000\\012updateTimeq\\000~\\000\\014xpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001\\206\\227Y\\260\\270xpt\\000\\000pppt\\000\\0010t\\000\\0160 0/4 * * * ? t\\000 propGetServiceImpl.fetchPropertyt\\000\\006SYSTEMsr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000\\004t\\000\\022modbus\\344\\272\\221\\347\\253\\257\\350\\275\\256\\350\\257\\242t\\000\\0011t\\000\\0010x\\000');
INSERT INTO "public"."qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME5', 'SYSTEM', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', E'\\254\\355\\000\\005sr\\000\\025org.quartz.JobDataMap\\237\\260\\203\\350\\277\\251\\260\\313\\002\\000\\000xr\\000&org.quartz.utils.StringKeyDirtyFlagMap\\202\\010\\350\\303\\373\\305](\\002\\000\\001Z\\000\\023allowsTransientDataxr\\000\\035org.quartz.utils.DirtyFlagMap\\023\\346.\\255(v\\012\\316\\002\\000\\002Z\\000\\005dirtyL\\000\\003mapt\\000\\017Ljava/util/Map;xp\\001sr\\000\\021java.util.HashMap\\005\\007\\332\\301\\303\\026`\\321\\003\\000\\002F\\000\\012loadFactorI\\000\\011thresholdxp?@\\000\\000\\000\\000\\000\\014w\\010\\000\\000\\000\\020\\000\\000\\000\\001t\\000\\017TASK_PROPERTIESsr\\000 com.fastbee.quartz.domain.SysJob\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\010L\\000\\012concurrentt\\000\\022Ljava/lang/String;L\\000\\016cronExpressionq\\000~\\000\\011L\\000\\014invokeTargetq\\000~\\000\\011L\\000\\010jobGroupq\\000~\\000\\011L\\000\\005jobIdt\\000\\020Ljava/lang/Long;L\\000\\007jobNameq\\000~\\000\\011L\\000\\015misfirePolicyq\\000~\\000\\011L\\000\\006statusq\\000~\\000\\011xr\\000)com.fastbee.common.core.domain.BaseEntity\\000\\000\\000\\000\\000\\000\\000\\001\\002\\000\\007L\\000\\010createByq\\000~\\000\\011L\\000\\012createTimet\\000\\020Ljava/util/Date;L\\000\\006paramsq\\000~\\000\\003L\\000\\006remarkq\\000~\\000\\011L\\000\\013searchValueq\\000~\\000\\011L\\000\\010updateByq\\000~\\000\\011L\\000\\012updateTimeq\\000~\\000\\014xpt\\000\\005adminsr\\000\\016java.util.Datehj\\201\\001KYt\\031\\003\\000\\000xpw\\010\\000\\000\\001\\207\\021\\215\\007\\340xpt\\000\\000pppt\\000\\0011t\\000\\0160 0/1 * * * ? t\\000(deviceJob.timingUpdateDeviceStatusStatust\\000\\006SYSTEMsr\\000\\016java.lang.Long;\\213\\344\\220\\314\\217#\\337\\002\\000\\001J\\000\\005valuexr\\000\\020java.lang.Number\\206\\254\\225\\035\\013\\224\\340\\213\\002\\000\\000xp\\000\\000\\000\\000\\000\\000\\000\\005t\\000\\022\\350\\256\\276\\345\\244\\207\\345\\256\\232\\346\\227\\266\\344\\273\\273\\345\\212\\241t\\000\\0011t\\000\\0010x\\000');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_locks";
CREATE TABLE "public"."qrtz_locks" (
  "sched_name" varchar(120) NOT NULL,
  "lock_name" varchar(40) NOT NULL
)
;
COMMENT ON COLUMN "public"."qrtz_locks"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_locks"."lock_name" IS '悲观锁名称';
COMMENT ON TABLE "public"."qrtz_locks" IS '存储的悲观锁信息表';

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
BEGIN;
INSERT INTO "public"."qrtz_locks" ("sched_name", "lock_name") VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO "public"."qrtz_locks" ("sched_name", "lock_name") VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_paused_trigger_grps";
CREATE TABLE "public"."qrtz_paused_trigger_grps" (
  "sched_name" varchar(120) NOT NULL,
  "trigger_group" varchar(200) NOT NULL
)
;
COMMENT ON COLUMN "public"."qrtz_paused_trigger_grps"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_paused_trigger_grps"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON TABLE "public"."qrtz_paused_trigger_grps" IS '暂停的触发器表';

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_scheduler_state";
CREATE TABLE "public"."qrtz_scheduler_state" (
  "sched_name" varchar(120) NOT NULL,
  "instance_name" varchar(200) NOT NULL,
  "last_checkin_time" int8 NOT NULL,
  "checkin_interval" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."qrtz_scheduler_state"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_scheduler_state"."instance_name" IS '实例名称';
COMMENT ON COLUMN "public"."qrtz_scheduler_state"."last_checkin_time" IS '上次检查时间';
COMMENT ON COLUMN "public"."qrtz_scheduler_state"."checkin_interval" IS '检查间隔时间';
COMMENT ON TABLE "public"."qrtz_scheduler_state" IS '调度器状态表';

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
BEGIN;
INSERT INTO "public"."qrtz_scheduler_state" ("sched_name", "instance_name", "last_checkin_time", "checkin_interval") VALUES ('RuoyiScheduler', 'beecue1680023933011', 1680023961720, 15000);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_simple_triggers";
CREATE TABLE "public"."qrtz_simple_triggers" (
  "sched_name" varchar(120) NOT NULL,
  "trigger_name" varchar(200) NOT NULL,
  "trigger_group" varchar(200) NOT NULL,
  "repeat_count" int8 NOT NULL,
  "repeat_interval" int8 NOT NULL,
  "times_triggered" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."qrtz_simple_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_simple_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "public"."qrtz_simple_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "public"."qrtz_simple_triggers"."repeat_count" IS '重复的次数统计';
COMMENT ON COLUMN "public"."qrtz_simple_triggers"."repeat_interval" IS '重复的间隔时间';
COMMENT ON COLUMN "public"."qrtz_simple_triggers"."times_triggered" IS '已经触发的次数';
COMMENT ON TABLE "public"."qrtz_simple_triggers" IS '简单触发器的信息表';

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_simprop_triggers";
CREATE TABLE "public"."qrtz_simprop_triggers" (
  "sched_name" varchar(120) NOT NULL,
  "trigger_name" varchar(200) NOT NULL,
  "trigger_group" varchar(200) NOT NULL,
  "str_prop_1" varchar(512),
  "str_prop_2" varchar(512),
  "str_prop_3" varchar(512),
  "int_prop_1" int4,
  "int_prop_2" int4,
  "long_prop_1" int8,
  "long_prop_2" int8,
  "dec_prop_1" numeric(13,4),
  "dec_prop_2" numeric(13,4),
  "bool_prop_1" varchar(1),
  "bool_prop_2" varchar(1)
)
;
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."str_prop_1" IS 'String类型的trigger的第一个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."str_prop_2" IS 'String类型的trigger的第二个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."str_prop_3" IS 'String类型的trigger的第三个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."int_prop_1" IS 'int类型的trigger的第一个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."int_prop_2" IS 'int类型的trigger的第二个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."long_prop_1" IS 'long类型的trigger的第一个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."long_prop_2" IS 'long类型的trigger的第二个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."dec_prop_1" IS 'decimal类型的trigger的第一个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."dec_prop_2" IS 'decimal类型的trigger的第二个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."bool_prop_1" IS 'Boolean类型的trigger的第一个参数';
COMMENT ON COLUMN "public"."qrtz_simprop_triggers"."bool_prop_2" IS 'Boolean类型的trigger的第二个参数';
COMMENT ON TABLE "public"."qrtz_simprop_triggers" IS '同步机制的行锁表';

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS "public"."qrtz_triggers";
CREATE TABLE "public"."qrtz_triggers" (
  "sched_name" varchar(120) NOT NULL,
  "trigger_name" varchar(200) NOT NULL,
  "trigger_group" varchar(200) NOT NULL,
  "job_name" varchar(200) NOT NULL,
  "job_group" varchar(200) NOT NULL,
  "description" varchar(250),
  "next_fire_time" int8,
  "prev_fire_time" int8,
  "priority" int4,
  "trigger_state" varchar(16) NOT NULL,
  "trigger_type" varchar(8) NOT NULL,
  "start_time" int8 NOT NULL,
  "end_time" int8,
  "calendar_name" varchar(200),
  "misfire_instr" int2,
  "job_data" bytea
)
;
COMMENT ON COLUMN "public"."qrtz_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "public"."qrtz_triggers"."trigger_name" IS '触发器的名字';
COMMENT ON COLUMN "public"."qrtz_triggers"."trigger_group" IS '触发器所属组的名字';
COMMENT ON COLUMN "public"."qrtz_triggers"."job_name" IS 'qrtz_job_details表job_name的外键';
COMMENT ON COLUMN "public"."qrtz_triggers"."job_group" IS 'qrtz_job_details表job_group的外键';
COMMENT ON COLUMN "public"."qrtz_triggers"."description" IS '相关介绍';
COMMENT ON COLUMN "public"."qrtz_triggers"."next_fire_time" IS '上一次触发时间（毫秒）';
COMMENT ON COLUMN "public"."qrtz_triggers"."prev_fire_time" IS '下一次触发时间（默认为-1表示不触发）';
COMMENT ON COLUMN "public"."qrtz_triggers"."priority" IS '优先级';
COMMENT ON COLUMN "public"."qrtz_triggers"."trigger_state" IS '触发器状态';
COMMENT ON COLUMN "public"."qrtz_triggers"."trigger_type" IS '触发器的类型';
COMMENT ON COLUMN "public"."qrtz_triggers"."start_time" IS '开始时间';
COMMENT ON COLUMN "public"."qrtz_triggers"."end_time" IS '结束时间';
COMMENT ON COLUMN "public"."qrtz_triggers"."calendar_name" IS '日程表名称';
COMMENT ON COLUMN "public"."qrtz_triggers"."misfire_instr" IS '补偿执行的策略';
COMMENT ON COLUMN "public"."qrtz_triggers"."job_data" IS '存放持久化job对象';
COMMENT ON TABLE "public"."qrtz_triggers" IS '触发器详细信息表';

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
BEGIN;
INSERT INTO "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1680023970000, 1680023960000, 5, 'WAITING', 'CRON', 1680023946000, 0, NULL, 2, '');
INSERT INTO "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1680023955000, -1, 5, 'PAUSED', 'CRON', 1680023947000, 0, NULL, 2, '');
INSERT INTO "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1680023960000, -1, 5, 'PAUSED', 'CRON', 1680023948000, 0, NULL, 2, '');
INSERT INTO "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'SYSTEM', 'TASK_CLASS_NAME4', 'SYSTEM', NULL, 1680024000000, -1, 5, 'WAITING', 'CRON', 1680023950000, 0, NULL, -1, '');
INSERT INTO "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME5', 'SYSTEM', 'TASK_CLASS_NAME5', 'SYSTEM', NULL, 1680024000000, -1, 5, 'WAITING', 'CRON', 1680023951000, 0, NULL, -1, '');
COMMIT;

-- ----------------------------
-- Table structure for sip_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."sip_config";
CREATE TABLE "public"."sip_config" (
  "id" int8 NOT NULL,
  "product_id" int8 NOT NULL,
  "product_name" varchar(64) NOT NULL,
  "enabled" int2,
  "isdefault" int2,
  "seniorSdp" int2,
  "domain" varchar(10) NOT NULL,
  "server_sipid" varchar(20) NOT NULL,
  "password" varchar(20) NOT NULL,
  "ip" varchar(32),
  "port" int8,
  "del_flag" char(1) NOT NULL,
  "create_by" varchar(64) NOT NULL,
  "create_time" timestamp NOT NULL,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sip_config"."id" IS '主键';
COMMENT ON COLUMN "public"."sip_config"."product_id" IS '产品ID';
COMMENT ON COLUMN "public"."sip_config"."product_name" IS '产品名称';
COMMENT ON COLUMN "public"."sip_config"."enabled" IS '使能开关';
COMMENT ON COLUMN "public"."sip_config"."isdefault" IS '系统默认配置';
COMMENT ON COLUMN "public"."sip_config"."seniorSdp" IS '拓展sdp';
COMMENT ON COLUMN "public"."sip_config"."domain" IS '服务器域';
COMMENT ON COLUMN "public"."sip_config"."server_sipid" IS '服务器sipid';
COMMENT ON COLUMN "public"."sip_config"."password" IS 'sip认证密码';
COMMENT ON COLUMN "public"."sip_config"."ip" IS 'sip接入IP';
COMMENT ON COLUMN "public"."sip_config"."port" IS 'sip接入端口号';
COMMENT ON COLUMN "public"."sip_config"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."sip_config"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sip_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sip_config"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sip_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sip_config"."remark" IS '备注';
COMMENT ON TABLE "public"."sip_config" IS 'sip系统配置';

-- ----------------------------
-- Records of sip_config
-- ----------------------------
BEGIN;
INSERT INTO "public"."sip_config" ("id", "product_id", "product_name", "enabled", "isdefault", "seniorSdp", "domain", "server_sipid", "password", "ip", "port", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (38, 117, '', 1, 1, NULL, '3402000000', '34020000002000000001', '12345678', '177.7.0.13', 5061, '0', '', '2023-03-16 21:26:18', '', '2023-03-16 21:26:24', NULL);
INSERT INTO "public"."sip_config" ("id", "product_id", "product_name", "enabled", "isdefault", "seniorSdp", "domain", "server_sipid", "password", "ip", "port", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (39, 118, '', 1, 1, NULL, '3402000000', '34020000002000000001', '12345678', '177.7.0.13', 5061, '0', '', '2023-04-11 21:11:54', '', NULL, NULL);
INSERT INTO "public"."sip_config" ("id", "product_id", "product_name", "enabled", "isdefault", "seniorSdp", "domain", "server_sipid", "password", "ip", "port", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (41, 135, '', 1, 1, NULL, '3402000000', '34020000002000000001', '12345678', '177.7.0.13', 5061, '0', '', '2024-01-08 22:14:35', '', NULL, NULL);
INSERT INTO "public"."sip_config" ("id", "product_id", "product_name", "enabled", "isdefault", "seniorSdp", "domain", "server_sipid", "password", "ip", "port", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (42, 131, '', 0, 0, NULL, '3402000000', '34020000002000000001', '12345678', '192.168.5.27', 5061, '0', '', '2025-03-19 16:26:04', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sip_device
-- ----------------------------
DROP TABLE IF EXISTS "public"."sip_device";
CREATE TABLE "public"."sip_device" (
  "device_id" int8 NOT NULL,
  "product_id" int8 NOT NULL,
  "product_name" varchar(64) NOT NULL,
  "device_sip_id" varchar(64) NOT NULL,
  "device_name" varchar(64) NOT NULL,
  "manufacturer" varchar(64) NOT NULL,
  "model" varchar(64) NOT NULL,
  "firmware" varchar(64) NOT NULL,
  "transport" varchar(64) NOT NULL,
  "stream_mode" varchar(64) NOT NULL,
  "online" varchar(64) NOT NULL,
  "register_time" timestamp NOT NULL,
  "last_connect_time" timestamp,
  "active_time" timestamp,
  "ip" varchar(32),
  "port" int8,
  "host_address" varchar(32),
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sip_device"."device_id" IS '设备ID';
COMMENT ON COLUMN "public"."sip_device"."product_id" IS '产品ID';
COMMENT ON COLUMN "public"."sip_device"."product_name" IS '产品名称';
COMMENT ON COLUMN "public"."sip_device"."device_sip_id" IS '设备SipID';
COMMENT ON COLUMN "public"."sip_device"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."sip_device"."manufacturer" IS '厂商名称';
COMMENT ON COLUMN "public"."sip_device"."model" IS '产品型号';
COMMENT ON COLUMN "public"."sip_device"."firmware" IS '固件版本';
COMMENT ON COLUMN "public"."sip_device"."transport" IS '传输模式';
COMMENT ON COLUMN "public"."sip_device"."stream_mode" IS '流模式';
COMMENT ON COLUMN "public"."sip_device"."online" IS '在线状态';
COMMENT ON COLUMN "public"."sip_device"."register_time" IS '注册时间';
COMMENT ON COLUMN "public"."sip_device"."last_connect_time" IS '最后上线时间';
COMMENT ON COLUMN "public"."sip_device"."active_time" IS '激活时间';
COMMENT ON COLUMN "public"."sip_device"."ip" IS '设备入网IP';
COMMENT ON COLUMN "public"."sip_device"."port" IS '设备接入端口号';
COMMENT ON COLUMN "public"."sip_device"."host_address" IS '设备地址';
COMMENT ON COLUMN "public"."sip_device"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."sip_device"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sip_device"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sip_device"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sip_device"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sip_device"."remark" IS '备注';
COMMENT ON TABLE "public"."sip_device" IS '监控设备';

-- ----------------------------
-- Records of sip_device
-- ----------------------------
BEGIN;
INSERT INTO "public"."sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (9, 0, '', '13030300001170000008', '8E085C3RAJE156F', 'Dahua', 'DH-3H3205-ADW', '2.810.0000027.0.R,2022-08-26', 'UDP', 'UDP', '', '2023-02-27 12:07:35', '2023-02-26 23:36:45', NULL, '177.7.0.1', 35332, '177.7.0.1:35332', '0', '', NULL, '', NULL, NULL);
INSERT INTO "public"."sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (12, 0, '', '11010100001320000001', '海康威视摄像头', 'Hikvision', 'iDS-2DE2402IX-D3/W/XM', 'V5.7.4', 'UDP', 'UDP', '', '2024-01-09 23:29:52', '2024-01-09 23:35:00', NULL, '192.168.2.119', 5065, '192.168.2.119:5065', '0', '', NULL, '', NULL, NULL);
INSERT INTO "public"."sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (13, 0, '', '11010200001320000017', '', '', '', '', 'UDP', 'UDP', '', '2023-03-16 21:41:45', '2023-03-16 21:52:50', NULL, '192.168.2.119', 5060, '192.168.2.119:5060', '0', '', NULL, '', NULL, NULL);
INSERT INTO "public"."sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (16, 0, '', '12010100001320000003', 'IP DOME', 'Hikvision', 'iDS-2DE2402IX-D3/W/XM', 'V5.7.4', 'UDP', 'UDP', '', '2023-04-11 21:08:07', '2023-04-11 21:13:16', NULL, '192.168.2.119', 5060, '192.168.2.119:5060', '0', '', NULL, '', NULL, NULL);
INSERT INTO "public"."sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (18, 0, '', '13030100001320000001', '', 'ABCD', 'TEST001', 'V1.0', 'UDP', 'UDP', '', '2023-03-28 16:06:45', '2023-03-28 16:09:52', NULL, '192.168.205.250', 5063, '192.168.205.250:5063', '0', '', NULL, '', NULL, NULL);
INSERT INTO "public"."sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (19, 0, '', '11010200001320000001', '海康威视摄像头', 'Hikvision', 'iDS-2DE2402IX-D3/W/XM', 'V5.7.4', 'UDP', 'UDP', '', '2024-01-08 22:08:27', '2024-01-08 22:16:32', NULL, '192.168.2.119', 5065, '192.168.2.119:5065', '0', '', NULL, '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sip_device_channel
-- ----------------------------
DROP TABLE IF EXISTS "public"."sip_device_channel";
CREATE TABLE "public"."sip_device_channel" (
  "id" int8 NOT NULL,
  "tenant_id" int8 NOT NULL,
  "tenant_name" varchar(30) NOT NULL,
  "product_id" int8 NOT NULL,
  "product_name" varchar(64) NOT NULL,
  "user_id" int8 NOT NULL,
  "user_name" varchar(64) NOT NULL,
  "device_sip_id" varchar(64) NOT NULL,
  "channel_sip_id" varchar(64) NOT NULL,
  "channel_name" varchar(64) NOT NULL,
  "register_time" timestamp,
  "device_type" varchar(64),
  "channel_type" varchar(64),
  "cityCode" varchar(64) NOT NULL,
  "civilCode" varchar(64) NOT NULL,
  "manufacture" varchar(64) NOT NULL,
  "model" varchar(64) NOT NULL,
  "owner" varchar(64) NOT NULL,
  "block" varchar(64) NOT NULL,
  "address" varchar(64) NOT NULL,
  "parentId" varchar(64) NOT NULL,
  "ipAddress" varchar(32),
  "port" int8,
  "password" varchar(64) NOT NULL,
  "PTZType" int8 NOT NULL,
  "PTZTypeText" varchar(64) NOT NULL,
  "status" int2 NOT NULL,
  "longitude" float8,
  "latitude" float8,
  "streamId" varchar(64) NOT NULL,
  "subCount" int8 NOT NULL,
  "parental" int2 NOT NULL,
  "hasAudio" int2 NOT NULL,
  "del_flag" char(1) NOT NULL,
  "create_by" varchar(64) NOT NULL,
  "create_time" timestamp NOT NULL,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sip_device_channel"."id" IS '主键';
COMMENT ON COLUMN "public"."sip_device_channel"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "public"."sip_device_channel"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "public"."sip_device_channel"."product_id" IS '产品ID';
COMMENT ON COLUMN "public"."sip_device_channel"."product_name" IS '产品名称';
COMMENT ON COLUMN "public"."sip_device_channel"."user_id" IS '产品ID';
COMMENT ON COLUMN "public"."sip_device_channel"."user_name" IS '产品名称';
COMMENT ON COLUMN "public"."sip_device_channel"."device_sip_id" IS '设备SipID';
COMMENT ON COLUMN "public"."sip_device_channel"."channel_sip_id" IS '通道SipID';
COMMENT ON COLUMN "public"."sip_device_channel"."channel_name" IS '通道名称';
COMMENT ON COLUMN "public"."sip_device_channel"."register_time" IS '注册时间';
COMMENT ON COLUMN "public"."sip_device_channel"."device_type" IS '设备类型';
COMMENT ON COLUMN "public"."sip_device_channel"."channel_type" IS '通道类型';
COMMENT ON COLUMN "public"."sip_device_channel"."cityCode" IS '城市编码';
COMMENT ON COLUMN "public"."sip_device_channel"."civilCode" IS '行政区域';
COMMENT ON COLUMN "public"."sip_device_channel"."manufacture" IS '厂商名称';
COMMENT ON COLUMN "public"."sip_device_channel"."model" IS '产品型号';
COMMENT ON COLUMN "public"."sip_device_channel"."owner" IS '设备归属';
COMMENT ON COLUMN "public"."sip_device_channel"."block" IS '警区';
COMMENT ON COLUMN "public"."sip_device_channel"."address" IS '安装地址';
COMMENT ON COLUMN "public"."sip_device_channel"."parentId" IS '父级id';
COMMENT ON COLUMN "public"."sip_device_channel"."ipAddress" IS '设备入网IP';
COMMENT ON COLUMN "public"."sip_device_channel"."port" IS '设备接入端口号';
COMMENT ON COLUMN "public"."sip_device_channel"."password" IS '密码';
COMMENT ON COLUMN "public"."sip_device_channel"."PTZType" IS 'PTZ类型';
COMMENT ON COLUMN "public"."sip_device_channel"."PTZTypeText" IS 'PTZ类型描述字符串';
COMMENT ON COLUMN "public"."sip_device_channel"."status" IS '设备状态（1-未激活，2-禁用，3-在线，4-离线）';
COMMENT ON COLUMN "public"."sip_device_channel"."longitude" IS '设备经度';
COMMENT ON COLUMN "public"."sip_device_channel"."latitude" IS '设备纬度';
COMMENT ON COLUMN "public"."sip_device_channel"."streamId" IS '流媒体ID';
COMMENT ON COLUMN "public"."sip_device_channel"."subCount" IS '子设备数';
COMMENT ON COLUMN "public"."sip_device_channel"."parental" IS '是否有子设备（1-有, 0-没有）';
COMMENT ON COLUMN "public"."sip_device_channel"."hasAudio" IS '是否含有音频（1-有, 0-没有）';
COMMENT ON COLUMN "public"."sip_device_channel"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."sip_device_channel"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sip_device_channel"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sip_device_channel"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sip_device_channel"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sip_device_channel"."remark" IS '备注';
COMMENT ON TABLE "public"."sip_device_channel" IS '监控设备通道信息';

-- ----------------------------
-- Records of sip_device_channel
-- ----------------------------
BEGIN;
INSERT INTO "public"."sip_device_channel" ("id", "tenant_id", "tenant_name", "product_id", "product_name", "user_id", "user_name", "device_sip_id", "channel_sip_id", "channel_name", "register_time", "device_type", "channel_type", "cityCode", "civilCode", "manufacture", "model", "owner", "block", "address", "parentId", "ipAddress", "port", "password", "PTZType", "PTZTypeText", "status", "longitude", "latitude", "streamId", "subCount", "parental", "hasAudio", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (84, 1, 'admin', 118, '监控设备', 1, 'admin', '11010200001320000001', '11010200001320000001', 'IPdome', '2024-01-08 22:16:32', '132', '132', '北京市/市辖区/西城区', '3402000000', 'Hikvision', 'IP Camera', 'Owner', '', 'Address', '34020000002000000001', '', 0, '', 0, '', 3, 0.000000, 0.000000, 'gb_play_11010200001320000001_11010200001320000001', 0, 0, 0, '0', '', '2023-04-11 21:12:33', '', NULL, NULL);
INSERT INTO "public"."sip_device_channel" ("id", "tenant_id", "tenant_name", "product_id", "product_name", "user_id", "user_name", "device_sip_id", "channel_sip_id", "channel_name", "register_time", "device_type", "channel_type", "cityCode", "civilCode", "manufacture", "model", "owner", "block", "address", "parentId", "ipAddress", "port", "password", "PTZType", "PTZTypeText", "status", "longitude", "latitude", "streamId", "subCount", "parental", "hasAudio", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (102, 1, 'admin', 135, '视频监控', 0, '', '11010100001320000001', '11010100001320000001', 'IPdome', '2024-01-09 23:35:00', '132', '132', '北京市/市辖区/东城区', '3402000000', 'Hikvision', 'IP Camera', 'Owner', '', 'Address', '34020000002000000001', '', 0, '', 0, '', 3, 0.000000, 0.000000, '', 0, 0, 0, '0', '', '2024-01-08 22:15:57', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_auth_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_auth_user";
CREATE TABLE "public"."sys_auth_user" (
  "auth_id" int8 NOT NULL,
  "uuid" varchar(500) NOT NULL,
  "user_id" int8 NOT NULL,
  "login_name" varchar(30) NOT NULL,
  "user_name" varchar(30),
  "avatar" varchar(500),
  "email" varchar(255),
  "source" varchar(255),
  "create_time" timestamp
)
;
COMMENT ON COLUMN "public"."sys_auth_user"."auth_id" IS '授权ID';
COMMENT ON COLUMN "public"."sys_auth_user"."uuid" IS '第三方平台用户唯一ID';
COMMENT ON COLUMN "public"."sys_auth_user"."user_id" IS '系统用户ID';
COMMENT ON COLUMN "public"."sys_auth_user"."login_name" IS '登录账号';
COMMENT ON COLUMN "public"."sys_auth_user"."user_name" IS '用户昵称';
COMMENT ON COLUMN "public"."sys_auth_user"."avatar" IS '头像地址';
COMMENT ON COLUMN "public"."sys_auth_user"."email" IS '用户邮箱';
COMMENT ON COLUMN "public"."sys_auth_user"."source" IS '用户来源';
COMMENT ON COLUMN "public"."sys_auth_user"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."sys_auth_user" IS '第三方授权表';

-- ----------------------------
-- Records of sys_auth_user
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_config";
CREATE TABLE "public"."sys_config" (
  "config_id" int4 NOT NULL,
  "config_name" varchar(100),
  "config_key" varchar(100),
  "config_value" varchar(500),
  "config_type" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sys_config"."config_id" IS '参数主键';
COMMENT ON COLUMN "public"."sys_config"."config_name" IS '参数名称';
COMMENT ON COLUMN "public"."sys_config"."config_key" IS '参数键名';
COMMENT ON COLUMN "public"."sys_config"."config_value" IS '参数键值';
COMMENT ON COLUMN "public"."sys_config"."config_type" IS '系统内置（Y是 N否）';
COMMENT ON COLUMN "public"."sys_config"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_config"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_config"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_config" IS '参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO "public"."sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '初始化密码 123456');
INSERT INTO "public"."sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-12-15 21:36:18', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO "public"."sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2021-12-15 21:36:18', 'admin', '2021-12-24 22:43:33', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO "public"."sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2023-03-10 23:29:21', '', NULL, '是否开启验证码功能（true开启，false关闭）');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dept";
CREATE TABLE "public"."sys_dept" (
  "dept_id" int8 NOT NULL,
  "parent_id" int8,
  "ancestors" varchar(50),
  "dept_name" varchar(30),
  "order_num" int4,
  "leader" varchar(20),
  "phone" varchar(11),
  "email" varchar(50),
  "status" char(1),
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp
)
;
COMMENT ON COLUMN "public"."sys_dept"."dept_id" IS '部门id';
COMMENT ON COLUMN "public"."sys_dept"."parent_id" IS '父部门id';
COMMENT ON COLUMN "public"."sys_dept"."ancestors" IS '祖级列表';
COMMENT ON COLUMN "public"."sys_dept"."dept_name" IS '部门名称';
COMMENT ON COLUMN "public"."sys_dept"."order_num" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_dept"."leader" IS '负责人';
COMMENT ON COLUMN "public"."sys_dept"."phone" IS '联系电话';
COMMENT ON COLUMN "public"."sys_dept"."email" IS '邮箱';
COMMENT ON COLUMN "public"."sys_dept"."status" IS '部门状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_dept"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."sys_dept"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_dept"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dept"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_dept"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."sys_dept" IS '部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (100, 0, '0', '蜂信物联', 0, 'FastBee', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-02-26 23:06:24');
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (101, 100, '0,100', '北京总公司', 1, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-03-09 16:49:53');
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (102, 100, '0,100', '深圳分公司', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-02-26 23:06:07');
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (103, 101, '0,100,101', '研发部门', 1, '物美', '15888888888', '164770707@qq.com', '1', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2022-02-01 23:12:40');
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (104, 101, '0,100,101', '市场部门', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (105, 101, '0,100,101', '测试部门', 3, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (106, 101, '0,100,101', '财务部门', 4, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (107, 101, '0,100,101', '运维部门', 5, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (108, 102, '0,100,102', '市场部门', 1, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
INSERT INTO "public"."sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES (109, 102, '0,100,102', '财务部门', 2, '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dict_data";
CREATE TABLE "public"."sys_dict_data" (
  "dict_code" int8 NOT NULL,
  "dict_sort" int4,
  "dict_label" varchar(100),
  "dict_value" varchar(100),
  "dict_type" varchar(100),
  "css_class" varchar(100),
  "list_class" varchar(100),
  "is_default" char(1),
  "status" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sys_dict_data"."dict_code" IS '字典编码';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_sort" IS '字典排序';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_label" IS '字典标签';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_value" IS '字典键值';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."sys_dict_data"."css_class" IS '样式属性（其他样式扩展）';
COMMENT ON COLUMN "public"."sys_dict_data"."list_class" IS '表格回显样式';
COMMENT ON COLUMN "public"."sys_dict_data"."is_default" IS '是否默认（Y是 N否）';
COMMENT ON COLUMN "public"."sys_dict_data"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_dict_data"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_dict_data"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dict_data"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_dict_data"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_dict_data"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_dict_data" IS '字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '性别男');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '性别女');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '性别未知');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '显示菜单');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '隐藏菜单');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '停用状态');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '停用状态');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '默认分组');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统分组');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统默认是');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统默认否');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '通知');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '公告');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '关闭状态');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '新增操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '修改操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '删除操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '授权操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '导出操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '导入操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '强退操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '生成操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '清空操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '停用状态');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (100, 1, '属性', '1', 'iot_things_type', '', 'primary', 'Y', '0', 'admin', '2021-12-12 16:41:15', 'admin', '2021-12-15 22:49:37', '');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (101, 2, '功能', '2', 'iot_things_type', '', 'success', 'Y', '0', 'admin', '2021-12-12 16:43:33', 'admin', '2021-12-14 16:33:11', '');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (102, 3, '事件', '3', 'iot_things_type', NULL, 'warning', 'Y', '0', 'admin', '2021-12-12 16:46:04', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (103, 1, '整数', 'integer', 'iot_data_type', '', '', 'Y', '0', 'admin', '2021-12-12 20:20:46', 'admin', '2021-12-14 16:09:56', '');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (104, 2, '小数', 'decimal', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:21:21', 'admin', '2021-12-15 22:51:07', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (105, 3, '布尔', 'bool', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:22:12', 'admin', '2021-12-15 22:51:02', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (106, 4, '枚举', 'enum', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:22:37', 'admin', '2021-12-15 22:50:57', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (107, 5, '字符串', 'string', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-12 20:22:54', 'admin', '2021-12-15 22:50:52', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (108, 1, '是', '1', 'iot_yes_no', '', 'default', 'Y', '0', 'admin', '2021-12-12 20:25:14', 'admin', '2022-01-02 13:39:09', '');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (109, 2, '否', '0', 'iot_yes_no', '', 'default', 'Y', '0', 'admin', '2021-12-12 20:25:25', 'admin', '2022-01-02 13:39:15', '');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (110, 6, '数组', 'array', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', '2021-12-13 18:18:04', 'admin', '2021-12-15 22:50:42', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (111, 1, '未发布', '1', 'iot_product_status', NULL, 'info', 'N', '0', 'admin', '2021-12-19 15:01:18', 'admin', '2021-12-19 15:01:55', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (112, 2, '已发布', '2', 'iot_product_status', NULL, 'success', 'N', '0', 'admin', '2021-12-19 15:01:43', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (113, 1, '直连设备', '1', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:03:49', 'admin', '2021-12-19 15:10:13', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (114, 2, '网关设备', '2', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:04:28', 'admin', '2023-02-09 16:25:46', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (116, 1, 'WIFI', '1', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:07:35', 'admin', '2021-12-22 00:11:19', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (117, 2, '蜂窝(2G/3G/4G/5G)', '2', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:08:30', 'admin', '2022-01-14 02:12:27', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (118, 3, '以太网', '3', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:09:08', 'admin', '2022-01-14 02:12:39', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (119, 1, '简单认证', '1', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:13:16', 'admin', '2022-06-05 00:14:48', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (120, 2, '加密认证', '2', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', '2021-12-19 15:13:26', 'admin', '2022-06-05 00:14:57', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (122, 1, 'ESP8266/Arduino', '1', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 15:54:52', 'admin', '2021-12-24 16:07:31', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (123, 3, 'ESP32/Arduino', '2', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 15:55:04', 'admin', '2021-12-24 16:07:26', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (124, 2, 'ESP8266/RTOS', '3', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 15:56:08', 'admin', '2021-12-24 16:07:17', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (127, 4, 'ESP32/ESP-IDF', '4', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 16:07:54', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (128, 5, '树莓派/Python', '5', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2021-12-24 16:08:31', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (129, 0, '未激活', '1', 'iot_device_status', NULL, 'warning', 'N', '0', 'admin', '2021-12-27 22:21:04', 'admin', '2021-12-27 22:22:09', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (130, 0, '禁用', '2', 'iot_device_status', NULL, 'danger', 'N', '0', 'admin', '2021-12-27 22:21:22', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (131, 0, '在线', '3', 'iot_device_status', NULL, 'success', 'N', '0', 'admin', '2021-12-27 22:21:42', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (132, 0, '离线', '4', 'iot_device_status', NULL, 'info', 'N', '0', 'admin', '2021-12-27 22:22:01', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (133, 0, '启用', '1', 'iot_is_enable', NULL, 'success', 'N', '0', 'admin', '2022-01-12 23:25:08', 'admin', '2022-01-12 23:25:30', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (134, 0, '禁用', '0', 'iot_is_enable', NULL, 'info', 'N', '0', 'admin', '2022-01-12 23:25:19', 'admin', '2022-01-12 23:25:38', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (135, 0, '提醒通知', '1', 'iot_alert_level', NULL, 'success', 'N', '0', 'admin', '2022-01-13 14:58:10', 'admin', '2022-01-13 14:58:31', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (136, 0, '轻微问题', '2', 'iot_alert_level', NULL, 'warning', 'N', '0', 'admin', '2022-01-13 14:59:00', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (137, 0, '严重警告', '3', 'iot_alert_level', NULL, 'danger', 'N', '0', 'admin', '2022-01-13 14:59:16', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (138, 0, '不需要处理', '1', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', '2022-01-13 15:06:03', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (139, 0, '未处理', '2', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', '2022-01-13 15:06:14', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (140, 0, '已处理', '3', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', '2022-01-13 15:06:24', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (141, 1, '属性上报', '1', 'iot_device_log_type', NULL, 'primary', 'N', '0', 'admin', '2022-01-13 15:10:32', 'admin', '2022-03-13 00:20:25', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (142, 3, '事件上报', '3', 'iot_device_log_type', NULL, 'danger', 'N', '0', 'admin', '2022-01-13 15:10:43', 'admin', '2022-03-13 00:21:00', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (143, 2, '功能调用', '2', 'iot_device_log_type', NULL, 'warning', 'N', '0', 'admin', '2022-01-13 15:10:55', 'admin', '2022-03-13 00:20:32', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (144, 4, '设备升级', '4', 'iot_device_log_type', NULL, 'success', 'N', '0', 'admin', '2022-01-13 15:11:08', 'admin', '2022-03-13 00:21:06', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (145, 5, '设备上线', '5', 'iot_device_log_type', NULL, 'success', 'N', '0', 'admin', '2022-01-13 15:11:23', 'admin', '2022-03-13 00:21:26', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (146, 6, '设备离线', '6', 'iot_device_log_type', NULL, 'info', 'N', '0', 'admin', '2022-01-13 15:11:32', 'admin', '2022-03-13 00:21:13', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (147, 4, '其他', '4', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', '2022-01-14 02:12:49', 'admin', '2022-01-14 02:13:03', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (148, 6, '安卓/Android', '6', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2022-01-16 12:39:27', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (149, 7, '其他', '7', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', '2022-01-16 12:39:55', 'admin', '2022-01-16 12:40:13', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (150, 1, '小度平台', '1', 'oauth_platform', NULL, 'primary', 'N', '0', 'admin', '2022-02-07 20:29:23', 'admin', '2022-02-07 22:24:28', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (151, 2, '天猫精灵', '2', 'oauth_platform', NULL, 'danger', 'N', '0', 'admin', '2022-02-07 20:29:41', 'admin', '2022-02-07 22:23:14', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (152, 3, '小米小爱', '3', 'oauth_platform', NULL, 'success', 'N', '0', 'admin', '2022-02-07 20:30:07', 'admin', '2022-02-07 22:23:24', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (153, 4, '其他平台', '4', 'oauth_platform', NULL, 'warning', 'N', '0', 'admin', '2022-02-07 22:23:52', 'admin', '2022-02-07 22:24:02', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (154, 1, '微信登录', 'WECHAT', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2022-04-20 16:41:33', 'admin', '2023-09-22 10:27:54', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (155, 2, 'QQ登录', 'QQ', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2022-04-20 16:42:46', 'admin', '2023-09-22 10:28:03', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (156, 0, '启用', '0', 'iot_social_platform_status', NULL, 'success', 'N', '0', 'admin', '2022-04-20 17:02:48', 'admin', '2022-05-12 17:39:40', '启用');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (157, 1, '未启用', '1', 'iot_social_platform_status', NULL, 'info', 'N', '0', 'admin', '2022-04-20 17:03:15', 'admin', '2022-05-21 13:44:13', '禁用');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (158, 3, '支付宝', 'ALIPAY', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2022-05-12 17:49:24', 'admin', '2022-05-12 17:50:21', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (159, 1, '自动定位', '1', 'iot_location_way', NULL, 'success', 'N', '0', 'admin', '2022-05-21 13:46:51', 'admin', '2022-05-21 13:53:23', 'IP定位，精确到城市');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (160, 2, '设备定位', '2', 'iot_location_way', NULL, 'warning', 'N', '0', 'admin', '2022-05-21 13:46:51', 'admin', '2022-05-21 13:49:21', '最精确定位');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (161, 3, '自定义位置', '3', 'iot_location_way', NULL, 'primary', 'N', '0', 'admin', '2022-05-21 13:48:50', 'admin', '2022-05-21 13:55:45', '位置自定义');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (162, 3, '简单+加密', '3', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', '2022-06-05 00:15:46', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (163, 1, '未使用', '1', 'iot_auth_status', NULL, 'info', 'N', '0', 'admin', '2022-06-07 17:39:22', 'admin', '2022-06-07 17:40:10', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (164, 2, '已使用', '2', 'iot_auth_status', NULL, 'success', 'N', '0', 'admin', '2022-06-07 17:40:01', 'admin', '2022-06-07 23:21:49', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (165, 7, '对象', 'object', 'iot_data_type', NULL, 'default', 'N', '0', 'admin', '2023-02-09 16:20:57', 'admin', '2023-02-09 16:21:08', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (166, 3, '监控设备', '3', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', '2023-02-09 16:26:00', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (169, 0, 'DVR', '111', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:07:06', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (170, 1, 'NVR', '118', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:07:59', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (171, 2, '报警控制器', '117', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:08:13', 'admin', '2023-02-22 01:08:35', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (172, 4, '摄像机', '131', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:08:52', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (173, 5, 'IPC', '132', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:09:11', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (174, 6, '显示器', '133', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:09:30', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (175, 7, '报警输入设备', '134', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:09:49', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (176, 8, '报警输出设备', '135', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:10:08', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (177, 9, '语音输入设备', '136', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:10:29', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (178, 10, '语音输出设备', '137', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:10:46', 'admin', '2023-02-22 01:10:51', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (179, 11, '移动传输设备', '138', 'video_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:11:09', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (180, 0, '报警控制器', '117', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:12:09', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (181, 1, '摄像机', '131', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:12:24', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (182, 2, 'IPC', '132', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:12:39', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (183, 3, '显示器', '133', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:12:57', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (184, 5, '报警输入设备', '134', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:13:14', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (185, 6, '报警输出设备', '135', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:13:29', 'admin', '2023-02-22 01:13:49', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (186, 7, '语音输入设备', '136', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:14:14', 'admin', '2023-02-22 01:14:24', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (187, 8, '语音输出设备', '137', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:14:50', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (188, 9, '移动传输设备', '138', 'channel_type', NULL, 'default', 'N', '0', 'admin', '2023-02-22 01:15:11', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (198, 0, 'MQTT', 'MQTT', 'iot_transport_type', NULL, 'primary', 'N', '0', 'admin', '2023-02-28 16:35:40', 'admin', '2025-03-19 16:23:48', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (230, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-03-10 23:28:32', '', NULL, '其他操作');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (231, 0, '事件上报', '3', 'iot_event_type', NULL, 'danger', 'N', '0', 'admin', '2023-03-29 00:25:28', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (232, 0, '设备上线', '5', 'iot_event_type', NULL, 'success', 'N', '0', 'admin', '2023-03-29 00:25:52', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (233, 0, '设备离线', '6', 'iot_event_type', NULL, 'info', 'N', '0', 'admin', '2023-03-29 00:26:09', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (234, 0, '服务下发', '1', 'iot_function_type', NULL, 'primary', 'N', '0', 'admin', '2023-03-29 00:38:26', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (235, 0, '属性获取', '2', 'iot_function_type', NULL, 'success', 'N', '0', 'admin', '2023-03-29 00:38:44', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (237, 0, '读写', '0', 'iot_data_read_write', NULL, 'primary', 'N', '0', 'admin', '2023-04-09 02:12:05', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (238, 0, '只读', '1', 'iot_data_read_write', NULL, 'info', 'N', '0', 'admin', '2023-04-09 02:12:19', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (239, 0, '全部设备', '1', 'oat_update_limit', NULL, 'default', 'N', '0', 'admin', '2023-04-09 23:57:06', 'admin', '2023-04-11 11:53:57', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (240, 1, '指定设备', '2', 'oat_update_limit', NULL, 'default', 'N', '0', 'admin', '2023-04-11 11:53:28', 'admin', '2023-04-11 11:53:52', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (241, 4, 'GB28181', 'GB28181', 'iot_transport_type', NULL, 'success', 'N', '0', 'admin', '2023-05-12 14:25:39', 'admin', '2025-03-19 16:24:12', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (242, 1, '02(读离散量输入)', '2', 'iot_modbus_status_code', NULL, 'default', 'N', '0', 'admin', '2023-07-03 10:16:48', 'admin', '2023-07-03 10:17:35', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (243, 3, '04(读输入寄存器)', '4', 'iot_modbus_status_code', NULL, 'default', 'N', '0', 'admin', '2023-07-03 10:17:18', 'admin', '2023-07-03 10:17:58', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (247, 4, '微信开放平台网站应用', 'wechat_open_web', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (248, 5, '微信开放平台移动应用', 'wechat_open_mobile', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:29:14', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (249, 6, '微信开放平台小程序', 'wechat_open_mini_program', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:38:12', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (250, 0, '16位 无符号', 'ushort', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:11:54', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (251, 1, '16位 有符号', 'short', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:12:26', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (252, 2, '32位 有符号(ABCD)', 'long-ABCD', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:12:53', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (253, 3, '32位 有符号(CDAB)', 'long-CDAB', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:13:21', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (254, 4, '32位 无符号(ABCD)', 'ulong-ABCD', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:13:42', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (255, 5, '32位 无符号(CDAB)', 'ulong-CDAB', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:14:06', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (256, 6, '32位 浮点数(ABCD)', 'float-ABCD', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:14:28', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (257, 7, '32位 浮点数(CDAB)', 'float-CDAB', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:14:50', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (258, 8, '位', 'bit', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', '2023-09-04 14:15:13', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (259, 0, '电灯', 'LIGHT', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (260, 0, '空调', 'AIR_CONDITION', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (261, 0, '窗帘', 'CURTAIN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (262, 0, '窗纱', 'CURT_SIMP', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (263, 0, '插座', 'SOCKET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (264, 0, '开关', 'SWITCH', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (265, 0, '冰箱', 'FRIDGE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (266, 0, '净水器', 'WATER_PURIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (267, 0, '加湿器', 'HUMIDIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (268, 0, '除湿器', 'DEHUMIDIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (269, 0, '电磁炉', 'INDUCTION_COOKER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (270, 0, '空气净化器', 'AIR_PURIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (271, 0, '洗衣机', 'WASHING_MACHINE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (272, 0, '热水器', 'WATER_HEATER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (273, 0, '燃气灶', 'GAS_STOVE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (274, 0, '电视机', 'TV_SET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (275, 0, '网络盒子', 'OTT_BOX', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (276, 0, '油烟机', 'RANGE_HOOD', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (277, 0, '电风扇', 'FAN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (278, 0, '投影仪', 'PROJECTOR', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (279, 0, '扫地机器人', 'SWEEPING_ROBOT', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (280, 0, '热水壶', 'KETTLE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (281, 0, '微波炉', 'MICROWAVE_OVEN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (282, 0, '压力锅', 'PRESSURE_COOKER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (283, 0, '电饭煲', 'RICE_COOKER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (284, 0, '破壁机', 'HIGH_SPEED_BLENDER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (285, 0, '新风机', 'AIR_FRESHER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (286, 0, '晾衣架', 'CLOTHES_RACK', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (287, 0, '烤箱设备', 'OVEN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (288, 0, '蒸烤箱', 'STEAM_OVEN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (289, 0, '蒸箱', 'STEAM_BOX', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (290, 0, '电暖器', 'HEATER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (291, 0, '开窗器', 'WINDOW_OPENER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (292, 0, '摄像头', 'WEBCAM', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (293, 0, '相机', 'CAMERA', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (294, 0, '机器人', 'ROBOT', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (295, 0, '打印机', 'PRINTER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (296, 0, '饮水机', 'WATER_COOLER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (297, 0, '鱼缸', 'FISH_TANK', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (298, 0, '浇花器', 'WATERING_DEVICE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (299, 0, '机顶盒', 'SET_TOP_BOX', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (300, 0, '香薰机', 'AROMATHERAPY_MACHINE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (301, 0, 'DVD', 'DVD', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (302, 0, '鞋柜', 'SHOE_CABINET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (303, 0, '走步机', 'WALKING_MACHINE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (304, 0, '跑步机', 'TREADMILL', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (305, 0, '床', 'BED', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (306, 0, '浴霸', 'YUBA', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (307, 0, '花洒', 'SHOWER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (308, 0, '浴缸', 'BATHTUB', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (309, 0, '消毒柜', 'DISINFECTION_CABINET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (310, 0, '洗碗机', 'DISHWASHER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (311, 0, '沙发品类', 'SOFA', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (312, 0, '门铃', 'DOOR_BELL', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (313, 0, '电梯', 'ELEVATOR', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (314, 0, '体重秤', 'WEIGHT_SCALE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (315, 0, '体脂秤', 'BODY_FAT_SCALE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (316, 0, '壁挂炉', 'WALL_HUNG_GAS_BOILER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (317, 0, '特定设备的组合场景', 'SCENE_TRIGGER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, '描述特定设备的组合场景，设备之间没有相互关联，无特定操作顺序。 例如“打开睡眠模式”包括关灯和锁上房门，但是关灯和锁上房门之间没有必然联系，可以先关灯然后锁上房门，也可以先锁上房门后关灯');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (318, 0, '特定设备的组合场景', 'ACTIVITY_TRIGGER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', '2023-08-23 11:28:15', '', NULL, '描述特定设备的组合场景。场景中的设备必须以指定顺序操作。如“观看优酷视频”场景中必须先打开电视机，然后打开HDMI1');
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (319, 0, '打开', 'turnOn', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (320, 0, '关闭', 'turnOff', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (321, 0, '定时打开', 'timingTurnOn', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (322, 0, '定时关闭', 'timingTurnOff', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (323, 0, '暂停', 'pause', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (324, 0, '继续', 'continue', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (325, 0, '设置颜色', 'setColor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (326, 0, '设置灯光色温', 'setColorTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (327, 0, '增高灯光色温', 'incrementColorTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (328, 0, '降低灯光色温', 'decrementColorTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (329, 0, '设置灯光亮度', 'setBrightnessPercentage', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (330, 0, '调亮灯光', 'incrementBrightnessPercentage', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (331, 0, '调暗灯光', 'decrementBrightnessPercentage', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (332, 0, '设置功率', 'setPower', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (333, 0, '增大功率', 'incrementPower', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (334, 0, '减小功率', 'decrementPower', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (335, 0, '升高温度', 'incrementTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (336, 0, '降低温度', 'decrementTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (337, 0, '设置温度', 'setTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (338, 0, '增加风速', 'incrementFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (339, 0, '减小风速', 'decrementFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (340, 0, '设置风速', 'setFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (341, 0, '设置档位', 'setGear', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (342, 0, '设置模式', 'setMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (343, 0, '取消设置的模式', 'unSetMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (344, 0, '定时设置模式', 'timingSetMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (345, 0, '定时取消设置的模式', 'timingUnsetMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (346, 0, '调高音量', 'incrementVolume', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (347, 0, '调低音量', 'decrementVolume', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (348, 0, '设置音量', 'setVolume', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (349, 0, '设置静音状态', 'setVolumeMute', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (350, 0, '上一个频道', 'decrementTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (351, 0, '下一个频道', 'incrementTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (352, 0, '设置频道', 'setTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (353, 0, '返回上个频道', 'returnTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (354, 0, '开始充电', 'chargeTurnOn', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (355, 0, '停止充电', 'chargeTurnOff', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (356, 0, '查询开关状态', 'getTurnOnState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (357, 0, '查询油量', 'getOilCapacity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (358, 0, '查询电量', 'getElectricityCapacity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (359, 0, '上锁/解锁', 'setLockState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (360, 0, '查询锁状态', 'getLockState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (361, 0, '设置吸力', 'setSuction', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (362, 0, '设置水量', 'setWaterLevel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (363, 0, '设置清扫位置', 'setCleaningLocation', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (364, 0, '执行自定义复杂动作', 'setComplexActions', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (365, 0, '设置移动方向', 'setDirection', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (366, 0, '打印', 'submitPrint', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (367, 0, '查询PM2.5', 'getAirPM25', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (368, 0, '查询PM10', 'getAirPM10', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (369, 0, '查询二氧化碳含量', 'getCO2Quantity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (370, 0, '查询空气质量', 'getAirQualityIndex', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (371, 0, '查询温度（当前温度和目标温度）', 'getTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (372, 0, '查询当前温度', 'getTemperatureReading', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (373, 0, '查询目标温度', 'getTargetTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (374, 0, '查询湿度', 'getHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (375, 0, '查询目标湿度', 'getTargetHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (376, 0, '查询水质', 'getWaterQuality', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (377, 0, '查询设备所有状态', 'getState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (378, 0, '查询剩余时间', 'getTimeLeft', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (379, 0, '查询运行状态', 'getRunningStatus', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (380, 0, '查询运行时间', 'getRunningTime', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (381, 0, '查询设备所在位置', 'getLocation', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (382, 0, '设备定时', 'setTimer', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (383, 0, '取消设备定时', 'timingCancel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (384, 0, '设备复位', 'reset', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (385, 0, '升高高度', 'incrementHeight', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (386, 0, '降低高度', 'decrementHeight', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (387, 0, '设置摆风角度', 'setSwingAngle', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (388, 0, '查询风速', 'getFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (389, 0, '设置湿度模式', 'setHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (390, 0, '增大湿度', 'incrementHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (391, 0, '降低湿度', 'decrementHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (392, 0, '增大雾量', 'incrementMist', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (393, 0, '见效雾量', 'decrementMist', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (394, 0, '设置雾量', 'setMist', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (395, 0, '设备启动', 'startUp', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (396, 0, '设置电梯楼层', 'setFloor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (397, 0, '电梯按下', 'decrementFloor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (398, 0, '电梯按上', 'incrementFloor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (399, 0, '增加速度', 'incrementSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (400, 0, '降低速度', 'decrementSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (401, 0, '设置速度', 'setSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (402, 0, '获取速度', 'getSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (403, 0, '获取跑步信息', 'getMotionInfo', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (404, 0, '打开灶眼', 'turnOnBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (405, 0, '关闭灶眼', 'turnOffBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (406, 0, '定时打开灶眼', 'timingTurnOnBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (407, 0, '定时关闭灶眼', 'timingTurnOffBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', '2023-09-22 10:35:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (408, 7, '微信开放平台网站应用个人中心绑定', 'wechat_open_web_bind', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', '2023-10-09 11:28:15', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (749, 1, 'Java脚本引擎', 'java', 'rule_script_language', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:51:09', 'admin', '2023-11-04 01:51:42', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (750, 2, 'JavaScript脚本引擎', 'js', 'rule_script_language', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:51:36', 'admin', '2023-11-05 10:28:30', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (751, 1, '普通脚本节点', 'script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:53:11', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (752, 2, '选择脚本节点 (switch)', 'switch_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:53:32', 'admin', '2023-11-04 01:56:44', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (753, 3, '条件脚本节点 (if)', 'if_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:53:48', 'admin', '2023-11-04 01:56:55', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (754, 4, '数量循环节点 (for)', 'for_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:54:11', 'admin', '2023-11-04 01:57:07', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (755, 5, '条件循环节点 (while)', 'while_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:54:30', 'admin', '2023-11-04 01:57:16', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (756, 6, '退出循环节点 (break)', 'break_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', '2023-11-04 01:54:50', 'admin', '2023-11-04 01:57:29', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (757, 3, 'groovy脚本引擎', 'groovy', 'rule_script_language', NULL, 'default', 'N', '0', 'admin', '2023-11-05 10:29:14', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (767, 1, '设备上报', '1', 'rule_script_event', NULL, 'primary', 'N', '0', 'admin', '2023-12-19 11:40:34', 'admin', '2023-12-20 02:23:43', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (768, 2, '平台下发', '2', 'rule_script_event', NULL, 'warning', 'N', '0', 'admin', '2023-12-19 11:40:46', 'admin', '2023-12-20 02:23:51', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (769, 3, '设备上线', '3', 'rule_script_event', NULL, 'success', 'N', '0', 'admin', '2023-12-19 11:40:58', 'admin', '2023-12-20 02:24:00', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (770, 4, '设备离线', '4', 'rule_script_event', NULL, 'info', 'N', '0', 'admin', '2023-12-19 11:41:09', 'admin', '2023-12-20 02:24:08', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (771, 1, '数据流', '1', 'rule_script_purpose', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:41:39', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (772, 2, '触发器', '2', 'rule_script_purpose', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:41:48', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (773, 3, '执行动作', '3', 'rule_script_purpose', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:41:59', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (774, 1, '消息重发', '1', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:42:26', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (775, 2, '消息通知', '2', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:43:18', 'admin', '2023-12-19 11:43:38', NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (776, 3, 'Http推送', '3', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:43:33', '', NULL, NULL);
INSERT INTO "public"."sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (777, 4, 'Mqtt桥接', '4', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', '2023-12-19 11:43:54', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dict_type";
CREATE TABLE "public"."sys_dict_type" (
  "dict_id" int8 NOT NULL,
  "dict_name" varchar(100),
  "dict_type" varchar(100),
  "status" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sys_dict_type"."dict_id" IS '字典主键';
COMMENT ON COLUMN "public"."sys_dict_type"."dict_name" IS '字典名称';
COMMENT ON COLUMN "public"."sys_dict_type"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."sys_dict_type"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_dict_type"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_dict_type"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dict_type"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_dict_type"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_dict_type"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_dict_type" IS '字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '用户性别列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '菜单状态列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统开关列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '任务状态列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '任务分组列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '系统是否列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '通知类型列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '通知状态列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '操作类型列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '登录状态列表');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (100, '物模型类别', 'iot_things_type', '0', 'admin', '2021-12-12 16:39:47', 'admin', '2021-12-15 22:49:19', '属性、动作、事件');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (101, '数据类型', 'iot_data_type', '0', 'admin', '2021-12-12 20:16:48', 'admin', '2021-12-12 20:17:54', 'integer、decimal、bool、string、enum');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (102, '是否', 'iot_yes_no', '0', 'admin', '2021-12-12 20:24:51', 'admin', '2021-12-19 15:12:35', '是、否');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (103, '产品状态', 'iot_product_status', '0', 'admin', '2021-12-19 15:00:13', '', NULL, '未发布、已发布（不能修改）');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (104, '设备类型', 'iot_device_type', '0', 'admin', '2021-12-19 15:03:06', '', NULL, '直连设备、网关子设备、网关设备');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (105, '联网方式', 'iot_network_method', '0', 'admin', '2021-12-19 15:07:12', 'admin', '2022-01-14 02:11:58', 'wifi、蜂窝(2G/3G/4G/5G)、以太网、其他');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (106, '认证方式', 'iot_vertificate_method', '0', 'admin', '2021-12-19 15:11:48', 'admin', '2022-06-05 12:57:02', '1=简单认证、2=加密认证、3=简单+加密');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (107, '设备芯片', 'iot_device_chip', '0', 'admin', '2021-12-24 15:53:27', 'admin', '2022-01-22 00:14:23', 'ESP8266、ESP32、树莓派');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (109, '设备状态', 'iot_device_status', '0', 'admin', '2021-12-27 22:19:55', 'admin', '2021-12-27 22:20:13', '未激活、禁用、在线、离线');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (110, '是否启用', 'iot_is_enable', '0', 'admin', '2022-01-12 23:24:01', 'admin', '2022-01-12 23:24:15', '启用、禁用');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (111, '告警类型', 'iot_alert_level', '0', 'admin', '2022-01-13 14:56:44', 'admin', '2022-01-13 15:04:46', '1=提醒通知，2=轻微问题，3=严重警告');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (112, '处理状态', 'iot_process_status', '0', 'admin', '2022-01-13 15:04:06', 'admin', '2022-01-13 15:06:39', '1=不需要处理,2=未处理,3=已处理');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (113, '设备日志类型', 'iot_device_log_type', '0', 'admin', '2022-01-13 15:09:49', 'admin', '2022-03-13 00:22:43', '1=属性上报，2=调用功能,3=事件上报，4=设备升级，5=设备上线，6=设备离线');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (114, 'Oauth开放平台', 'oauth_platform', '0', 'admin', '2022-02-07 20:27:48', 'admin', '2022-05-21 13:44:50', '1=小度，2=天猫精灵，3=小爱，4=其他');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (115, '第三方登录平台', 'iot_social_platform', '0', 'admin', '2022-04-12 15:28:13', 'admin', '2022-04-12 15:37:48', 'Wechat、QQ、');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (116, '第三方登录平台状态', 'iot_social_platform_status', '0', 'admin', '2022-04-20 17:02:13', 'admin', '2022-04-20 17:02:23', '第三方登录平台状态');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (117, '设备定位方式', 'iot_location_way', '0', 'admin', '2022-05-21 13:45:16', 'admin', '2022-05-21 13:46:06', '1=IP自动定位，2=设备定位，3=自定义');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (118, '授权码状态', 'iot_auth_status', '0', 'admin', '2022-06-07 17:38:56', '', NULL, '1=未分配，2=使用中');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (119, 'SipID状态', 'sip_gen_status', '0', 'admin', '2023-02-19 15:43:36', 'admin', '2023-02-19 15:45:54', '1=未使用，2=使用中');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (120, '监控设备类型', 'video_type', '0', 'admin', '2023-02-22 01:06:38', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (121, '通道类型', 'channel_type', '0', 'admin', '2023-02-22 01:11:51', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (122, '轮询方式', 'data_collect_type', '0', 'admin', '2023-02-28 13:55:45', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (123, '批量采集时间', 'iot_modbus_poll_time', '0', 'admin', '2023-02-28 14:38:21', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (124, '寄存器功能码', 'iot_modbus_status_code', '0', 'admin', '2023-02-28 15:19:02', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (125, '传输协议类型', 'iot_transport_type', '0', 'admin', '2023-02-28 16:35:20', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (126, '设备事件类型', 'iot_event_type', '0', 'admin', '2023-03-29 00:24:51', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (127, '指令下发类型', 'iot_function_type', '0', 'admin', '2023-03-29 00:37:51', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (128, '读写类型', 'iot_data_read_write', '0', 'admin', '2023-04-09 02:11:14', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (129, '升级范围', 'oat_update_limit', '0', 'admin', '2023-04-09 23:51:45', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (130, '云存储平台类型', 'oss_platform_type', '0', 'admin', '2023-04-12 00:26:09', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (131, 'modbus数据类型', 'iot_modbus_data_type', '0', 'admin', '2023-09-04 13:54:17', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (132, '小度音箱关联设备', 'dueros_related_device', '0', 'admin', '2023-09-22 09:45:15', 'admin', '2023-09-22 09:45:15', '小度音箱支持的设备、场景类型，在设备下配置关联');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (133, '小度音箱操作类型', 'dueros_operate_type', '0', 'admin', '2023-09-22 09:45:15', 'admin', '2023-09-22 09:45:15', '小度音箱智能家居设备操作类型，在产品物模型下配置');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (198, '规则脚本类型', 'rule_script_type', '0', 'admin', '2023-11-04 01:48:50', 'admin', '2023-11-04 01:50:16', NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (199, '规则脚本语言', 'rule_script_language', '0', 'admin', '2023-11-04 01:50:06', '', NULL, NULL);
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (204, '规则脚本事件', 'rule_script_event', '0', 'admin', '2023-12-19 11:33:48', '', NULL, '1=设备上报，2=平台下发，3=设备上线，4=设备离线');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (205, '规则脚本用途', 'rule_script_purpose', '0', 'admin', '2023-12-19 11:38:18', '', NULL, '1=数据流，2=触发器，3=执行动作');
INSERT INTO "public"."sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (206, '规则脚本动作', 'rule_script_action', '0', 'admin', '2023-12-19 11:39:58', '', NULL, '1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_job";
CREATE TABLE "public"."sys_job" (
  "job_id" int8 NOT NULL,
  "job_name" varchar(64) NOT NULL,
  "job_group" varchar(64) NOT NULL,
  "invoke_target" varchar(500) NOT NULL,
  "cron_expression" varchar(255),
  "misfire_policy" varchar(20),
  "concurrent" char(1),
  "status" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sys_job"."job_id" IS '任务ID';
COMMENT ON COLUMN "public"."sys_job"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."sys_job"."job_group" IS '任务组名';
COMMENT ON COLUMN "public"."sys_job"."invoke_target" IS '调用目标字符串';
COMMENT ON COLUMN "public"."sys_job"."cron_expression" IS 'cron执行表达式';
COMMENT ON COLUMN "public"."sys_job"."misfire_policy" IS '计划执行错误策略（1立即执行 2执行一次 3放弃执行）';
COMMENT ON COLUMN "public"."sys_job"."concurrent" IS '是否并发执行（0允许 1禁止）';
COMMENT ON COLUMN "public"."sys_job"."status" IS '状态（0正常 1暂停）';
COMMENT ON COLUMN "public"."sys_job"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_job"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_job"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_job"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_job"."remark" IS '备注信息';
COMMENT ON TABLE "public"."sys_job" IS '定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_job" ("job_id", "job_name", "job_group", "invoke_target", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(''ry'')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_job" ("job_id", "job_name", "job_group", "invoke_target", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '监控在线状态更新', 'SYSTEM', 'deviceJob.updateSipDeviceOnlineStatus(90)', '0 0/2 * * * ?', '1', '0', '0', 'admin', '2023-03-24 10:57:48', 'admin', '2025-03-26 15:50:06', '');
INSERT INTO "public"."sys_job" ("job_id", "job_name", "job_group", "invoke_target", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, '设备定时同步', 'SYSTEM', 'deviceJob.syncDeviceStatus', '0 0/1 * * * ? ', '1', '0', '0', 'admin', '2025-03-26 17:44:26', 'admin', '2025-03-26 17:45:08', '');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_job_log";
CREATE TABLE "public"."sys_job_log" (
  "job_log_id" int8 NOT NULL,
  "job_name" varchar(64) NOT NULL,
  "job_group" varchar(64) NOT NULL,
  "invoke_target" varchar(500) NOT NULL,
  "job_message" varchar(500),
  "status" char(1),
  "exception_info" varchar(2000),
  "create_time" timestamp
)
;
COMMENT ON COLUMN "public"."sys_job_log"."job_log_id" IS '任务日志ID';
COMMENT ON COLUMN "public"."sys_job_log"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."sys_job_log"."job_group" IS '任务组名';
COMMENT ON COLUMN "public"."sys_job_log"."invoke_target" IS '调用目标字符串';
COMMENT ON COLUMN "public"."sys_job_log"."job_message" IS '日志信息';
COMMENT ON COLUMN "public"."sys_job_log"."status" IS '执行状态（0正常 1失败）';
COMMENT ON COLUMN "public"."sys_job_log"."exception_info" IS '异常信息';
COMMENT ON COLUMN "public"."sys_job_log"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."sys_job_log" IS '定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_job_log" ("job_log_id", "job_name", "job_group", "invoke_target", "job_message", "status", "exception_info", "create_time") VALUES (1, '设备定时同步', 'SYSTEM', 'deviceJob.syncDeviceStatus', '设备定时同步 总共耗时：35毫秒', '0', '', '2025-03-26 17:52:59');
INSERT INTO "public"."sys_job_log" ("job_log_id", "job_name", "job_group", "invoke_target", "job_message", "status", "exception_info", "create_time") VALUES (2, '设备定时任务', 'SYSTEM', 'deviceJob.timingUpdateDeviceStatusStatus', '设备定时任务 总共耗时：0毫秒', '1', 'java.lang.NoSuchMethodException: com.fastbee.data.service.impl.DeviceJob.timingUpdateDeviceStatusStatus()
	at java.lang.Class.getMethod(Class.java:1786)
	at com.fastbee.quartz.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:60)
	at com.fastbee.quartz.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:33)
	at com.fastbee.quartz.util.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)
	at com.fastbee.quartz.util.AbstractQuartzJob.execute(AbstractQuartzJob.java:43)
	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)
	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)
', '2025-03-26 17:53:00');
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_logininfor";
CREATE TABLE "public"."sys_logininfor" (
  "info_id" int8 NOT NULL,
  "user_name" varchar(50),
  "ipaddr" varchar(128),
  "login_location" varchar(255),
  "browser" varchar(50),
  "os" varchar(50),
  "status" char(1),
  "msg" varchar(255),
  "login_time" timestamp
)
;
COMMENT ON COLUMN "public"."sys_logininfor"."info_id" IS '访问ID';
COMMENT ON COLUMN "public"."sys_logininfor"."user_name" IS '用户账号';
COMMENT ON COLUMN "public"."sys_logininfor"."ipaddr" IS '登录IP地址';
COMMENT ON COLUMN "public"."sys_logininfor"."login_location" IS '登录地点';
COMMENT ON COLUMN "public"."sys_logininfor"."browser" IS '浏览器类型';
COMMENT ON COLUMN "public"."sys_logininfor"."os" IS '操作系统';
COMMENT ON COLUMN "public"."sys_logininfor"."status" IS '登录状态（0成功 1失败）';
COMMENT ON COLUMN "public"."sys_logininfor"."msg" IS '提示消息';
COMMENT ON COLUMN "public"."sys_logininfor"."login_time" IS '访问时间';
COMMENT ON TABLE "public"."sys_logininfor" IS '系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_menu";
CREATE TABLE "public"."sys_menu" (
  "menu_id" int8 NOT NULL,
  "menu_name" varchar(50) NOT NULL,
  "parent_id" int8,
  "order_num" int4,
  "path" varchar(200),
  "component" varchar(255),
  "query" varchar(255),
  "is_frame" int4,
  "is_cache" int4,
  "menu_type" char(1),
  "visible" char(1),
  "status" char(1),
  "perms" varchar(100),
  "icon" varchar(100),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sys_menu"."menu_id" IS '菜单ID';
COMMENT ON COLUMN "public"."sys_menu"."menu_name" IS '菜单名称';
COMMENT ON COLUMN "public"."sys_menu"."parent_id" IS '父菜单ID';
COMMENT ON COLUMN "public"."sys_menu"."order_num" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_menu"."path" IS '路由地址';
COMMENT ON COLUMN "public"."sys_menu"."component" IS '组件路径';
COMMENT ON COLUMN "public"."sys_menu"."query" IS '路由参数';
COMMENT ON COLUMN "public"."sys_menu"."is_frame" IS '是否为外链（0是 1否）';
COMMENT ON COLUMN "public"."sys_menu"."is_cache" IS '是否缓存（0缓存 1不缓存）';
COMMENT ON COLUMN "public"."sys_menu"."menu_type" IS '菜单类型（M目录 C菜单 F按钮）';
COMMENT ON COLUMN "public"."sys_menu"."visible" IS '菜单状态（0显示 1隐藏）';
COMMENT ON COLUMN "public"."sys_menu"."status" IS '菜单状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_menu"."perms" IS '权限标识';
COMMENT ON COLUMN "public"."sys_menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "public"."sys_menu"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_menu"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_menu"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_menu"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_menu"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_menu" IS '菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '系统管理', 0, 4, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-12-15 21:36:18', 'admin', '2023-09-16 16:42:52', '系统管理目录');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '系统监控', 0, 5, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-12-15 21:36:18', 'admin', '2023-08-24 17:21:20', '系统监控目录');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '系统工具', 0, 6, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2021-12-15 21:36:18', 'admin', '2023-08-24 17:21:28', '系统工具目录');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '蜂信物联', 0, 10, 'http://fastbee.cn', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2021-12-15 21:36:18', 'admin', '2025-03-19 15:14:02', '若依官网地址');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2021-12-15 21:36:18', '', NULL, '用户管理菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2021-12-15 21:36:18', '', NULL, '角色管理菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2021-12-15 21:36:18', '', NULL, '菜单管理菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2021-12-15 21:36:18', '', NULL, '部门管理菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2021-12-15 21:36:18', '', NULL, '岗位管理菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2021-12-15 21:36:18', '', NULL, '字典管理菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2021-12-15 21:36:18', '', NULL, '参数设置菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2021-12-15 21:36:18', '', NULL, '通知公告菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2021-12-15 21:36:18', '', NULL, '日志管理菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2021-12-15 21:36:18', '', NULL, '在线用户菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2021-12-15 21:36:18', '', NULL, '定时任务菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2021-12-15 21:36:18', '', NULL, '数据监控菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2021-12-15 21:36:18', '', NULL, '服务监控菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2021-12-15 21:36:18', '', NULL, '缓存监控菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2021-12-15 21:36:18', '', NULL, '表单构建菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2021-12-15 21:36:18', '', NULL, '代码生成菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2021-12-15 21:36:18', '', NULL, '系统接口菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (124, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2023-03-10 23:22:42', '', NULL, '缓存列表菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-12-15 21:36:18', '', NULL, '操作日志菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2021-12-15 21:36:18', '', NULL, '登录日志菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1054, '任务导出', 110, 7, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1065, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2023-03-10 23:23:04', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2000, '设备管理', 0, 0, 'iot', NULL, NULL, 1, 0, 'M', '0', '0', '', 'iot', 'admin', '2021-12-15 23:57:06', 'admin', '2021-12-26 23:55:54', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2001, '产品分类', 2000, 2, 'category', 'iot/category/index', NULL, 1, 0, 'C', '0', '0', 'iot:category:list', 'category', 'admin', '2021-12-16 00:40:02', 'admin', '2021-12-26 23:56:20', '产品分类菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2002, '产品分类查询', 2001, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:query', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2003, '产品分类新增', 2001, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:add', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2004, '产品分类修改', 2001, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:edit', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2005, '产品分类删除', 2001, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:remove', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2006, '产品分类导出', 2001, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:category:export', '#', 'admin', '2021-12-16 00:40:02', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2007, '设备管理', 2000, 5, 'device', 'iot/device/index', NULL, 1, 0, 'C', '0', '0', 'iot:device:list', 'device', 'admin', '2021-12-16 00:40:12', 'admin', '2022-01-08 15:47:14', '设备菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2008, '设备查询', 2007, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:query', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2009, '设备新增', 2007, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:add', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2010, '设备修改', 2007, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:edit', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2011, '设备删除', 2007, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:remove', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2012, '设备导出', 2007, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:device:export', '#', 'admin', '2021-12-16 00:40:12', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2019, '设备分组', 2000, 4, 'group', 'iot/group/index', NULL, 1, 0, 'C', '0', '0', 'iot:group:list', 'group', 'admin', '2021-12-16 00:40:31', 'admin', '2021-12-26 23:56:54', '设备分组菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2020, '设备分组查询', 2019, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:query', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2021, '设备分组新增', 2019, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:add', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2022, '设备分组修改', 2019, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:edit', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2023, '设备分组删除', 2019, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:remove', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2024, '设备分组导出', 2019, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:group:export', '#', 'admin', '2021-12-16 00:40:31', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2043, '产品管理', 2000, 3, 'product', 'iot/product/index', NULL, 1, 0, 'C', '0', '0', 'iot:product:list', 'product', 'admin', '2021-12-16 00:41:18', 'admin', '2021-12-26 23:58:44', '产品菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2044, '产品查询', 2043, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:query', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2045, '产品新增', 2043, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:add', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2046, '产品修改', 2043, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:edit', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2047, '产品删除', 2043, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:remove', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2048, '产品导出', 2043, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:product:export', '#', 'admin', '2021-12-16 00:41:18', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2049, '通用物模型', 2000, 1, 'template', 'iot/template/index', NULL, 1, 0, 'C', '0', '0', 'iot:template:list', 'model', 'admin', '2021-12-16 00:41:28', 'admin', '2021-12-26 23:56:09', '通用物模型菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2050, '通用物模型查询', 2049, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:query', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2051, '通用物模型新增', 2049, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:add', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2052, '通用物模型修改', 2049, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:edit', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2053, '通用物模型删除', 2049, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:remove', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2054, '通用物模型导出', 2049, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:template:export', '#', 'admin', '2021-12-16 00:41:28', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2123, '新闻分类', 1, 10, 'newsCategory', 'iot/newsCategory/index', NULL, 1, 0, 'C', '0', '0', 'iot:newsCategory:list', 'category', 'admin', '2022-04-11 16:47:27', 'admin', '2022-05-12 17:20:51', '新闻分类菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2124, '新闻分类查询', 2123, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:query', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2125, '新闻分类新增', 2123, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:add', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2126, '新闻分类修改', 2123, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:edit', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2127, '新闻分类删除', 2123, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:remove', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2128, '新闻分类导出', 2123, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:newsCategory:export', '#', 'admin', '2022-04-11 16:47:27', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2129, '新闻资讯', 1, 11, 'news', 'iot/news/index', NULL, 1, 0, 'C', '0', '0', 'iot:news:list', 'documentation', 'admin', '2022-04-11 16:47:46', 'admin', '2022-05-12 17:20:58', '新闻资讯菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2130, '新闻资讯查询', 2129, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:query', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2131, '新闻资讯新增', 2129, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:add', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2132, '新闻资讯修改', 2129, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:edit', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2133, '新闻资讯删除', 2129, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:remove', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2134, '新闻资讯导出', 2129, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:news:export', '#', 'admin', '2022-04-11 16:47:46', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2136, '产品授权码查询', 2043, 6, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:query', '#', 'admin', '2022-04-11 17:17:53', 'admin', '2022-06-04 21:21:40', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2137, '产品授权码新增', 2043, 7, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:add', '#', 'admin', '2022-04-11 17:17:53', 'admin', '2022-06-04 21:21:59', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2138, '产品授权码修改', 2043, 8, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:edit', '#', 'admin', '2022-04-11 17:17:53', 'admin', '2022-06-04 21:22:08', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2139, '产品授权码删除', 2043, 9, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:remove', '#', 'admin', '2022-04-11 17:17:53', 'admin', '2022-06-04 21:22:26', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2140, '产品授权码导出', 2043, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:authorize:export', '#', 'admin', '2022-04-11 17:17:53', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2142, '平台查询', 2142, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:platform:query', '#', 'admin', '2022-04-11 19:10:28', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2147, '设备分享', 2007, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:device:share', '#', 'admin', '2022-06-10 01:08:40', 'admin', '2022-06-10 01:10:46', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2148, '设备定时', 2007, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:device:timer', '#', 'admin', '2022-06-10 01:10:30', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3031, 'Netty管理', 0, 3, 'netty', NULL, NULL, 1, 0, 'M', '0', '0', '', 'mq', 'admin', '2022-02-26 00:42:12', 'admin', '2023-09-26 00:11:57', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3032, '客户端', 3031, 1, 'client', 'iot/netty/clients', NULL, 1, 0, 'C', '0', '0', 'monitor:server:list', 'client', 'admin', '2022-02-26 00:45:39', 'admin', '2023-08-23 23:38:08', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3033, '事件日志', 2000, 1, 'log', 'iot/log/index', NULL, 1, 0, 'F', '0', '0', 'iot:event:list', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '事件日志菜单');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3034, '事件日志查询', 3033, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:query', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3035, '事件日志新增', 3033, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:add', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3036, '事件日志修改', 3033, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:edit', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3037, '事件日志删除', 3033, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:remove', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3038, '事件日志导出', 3033, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'iot:event:export', '#', 'admin', '2023-03-28 14:23:52', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3048, 'Mqtt统计', 3031, 2, 'mqtt', 'iot/netty/mqtt', NULL, 1, 0, 'C', '0', '0', 'monitor:server:list', 'monitor', 'admin', '2023-08-23 23:40:28', 'admin', '2023-08-23 23:40:38', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3050, '规则引擎', 0, 2, 'ruleengine', NULL, NULL, 1, 0, 'M', '0', '0', '', 'channel', 'admin', '2024-04-22 16:28:15', 'admin', '2025-03-19 15:13:50', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3051, '规则脚本', 3050, 2, 'script', 'iot/scene/script', NULL, 1, 0, 'C', '0', '0', 'iot:script:list', 'code', 'admin', '2024-04-22 16:30:00', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3052, '规则脚本查询', 3051, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:query', '#', 'admin', '2024-04-22 16:30:53', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3053, '规则脚本新增', 3051, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:add', '#', 'admin', '2024-04-22 16:31:28', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3054, '规则脚本修改', 3051, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:edit', '#', 'admin', '2024-04-22 16:32:04', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3056, '规则脚本导出', 3051, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:export', '#', 'admin', '2024-04-22 16:33:25', 'admin', '2024-04-22 16:33:49', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3057, '规则脚本删除', 3051, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'iot:script:remove', '#', 'admin', '2024-04-22 16:35:01', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3058, '视频中心', 0, 1, 'video', NULL, NULL, 1, 0, 'M', '0', '0', '', 'live', 'admin', '2024-07-15 14:42:13', 'admin', '2025-03-19 15:13:43', '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3059, '通道管理', 3058, 1, 'sip', 'iot/sip/index', NULL, 1, 0, 'C', '0', '0', 'iot:video:list', 'swagger', 'admin', '2024-07-15 14:43:22', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3060, '视频配置', 3058, 2, 'mediaServer', 'iot/sip/mediaServer', NULL, 1, 0, 'C', '0', '0', NULL, 'edit', 'admin', '2024-07-15 14:48:52', '', NULL, '');
INSERT INTO "public"."sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3062, '大屏展示', 2000, 6, 'http://localhost/bigScreen', NULL, NULL, 0, 0, 'M', '0', '0', '', 'monitor-a', 'admin', '2025-03-19 15:07:39', 'admin', '2025-03-20 22:18:42', '');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_notice";
CREATE TABLE "public"."sys_notice" (
  "notice_id" int4 NOT NULL,
  "notice_title" varchar(50) NOT NULL,
  "notice_type" char(1) NOT NULL,
  "notice_content" bytea,
  "status" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(255)
)
;
COMMENT ON COLUMN "public"."sys_notice"."notice_id" IS '公告ID';
COMMENT ON COLUMN "public"."sys_notice"."notice_title" IS '公告标题';
COMMENT ON COLUMN "public"."sys_notice"."notice_type" IS '公告类型（1通知 2公告）';
COMMENT ON COLUMN "public"."sys_notice"."notice_content" IS '公告内容';
COMMENT ON COLUMN "public"."sys_notice"."status" IS '公告状态（0正常 1关闭）';
COMMENT ON COLUMN "public"."sys_notice"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_notice"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_notice"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_notice"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_notice"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_notice" IS '通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_notice" ("notice_id", "notice_title", "notice_type", "notice_content", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, 'FastBeeV1.2版本发布', '2', E'<p>\\350\\277\\231\\346\\230\\257\\346\\265\\213\\350\\257\\225\\345\\206\\205\\345\\256\\271\\357\\274\\214\\346\\226\\260\\347\\211\\210\\346\\234\\254\\345\\212\\237\\350\\203\\275\\357\\274\\232</p><ol><li>\\346\\224\\257\\346\\214\\201\\345\\244\\232\\347\\247\\237\\346\\210\\267</li><li>\\346\\224\\257\\346\\214\\201\\350\\256\\276\\345\\244\\207\\345\\210\\206\\344\\272\\253</li><li>\\346\\224\\257\\346\\214\\201\\346\\227\\266\\345\\272\\217\\346\\225\\260\\346\\215\\256\\345\\272\\223</li><li>\\347\\256\\200\\345\\215\\225\\350\\256\\244\\350\\257\\201\\345\\222\\214\\345\\212\\240\\345\\257\\206\\350\\256\\244\\350\\257\\201\\347\\273\\237\\344\\270\\200</li></ol>', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-09-26 21:21:30', '管理员');
INSERT INTO "public"."sys_notice" ("notice_id", "notice_title", "notice_type", "notice_content", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, 'FastBee sdk支持树莓派', '1', E'<p>\\350\\277\\231\\346\\230\\257\\346\\265\\213\\350\\257\\225\\345\\206\\205\\345\\256\\271\\357\\274\\214\\347\\233\\256\\345\\211\\215sdk\\346\\224\\257\\346\\214\\201\\347\\232\\204\\347\\211\\210\\346\\234\\254:</p><p><br></p><p><br></p><ol><li>Arduino esp8266</li><li>Arduino esp32</li><li>esp-idf</li><li>raspberry \\346\\240\\221\\350\\216\\223\\346\\264\\276</li></ol>', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-09-26 21:21:41', '管理员');
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_oper_log";
CREATE TABLE "public"."sys_oper_log" (
  "oper_id" int8 NOT NULL,
  "title" varchar(50),
  "business_type" int4,
  "method" varchar(100),
  "request_method" varchar(10),
  "operator_type" int4,
  "oper_name" varchar(50),
  "dept_name" varchar(50),
  "oper_url" varchar(255),
  "oper_ip" varchar(128),
  "oper_location" varchar(255),
  "oper_param" varchar(2000),
  "json_result" varchar(2000),
  "status" int4,
  "error_msg" varchar(2000),
  "oper_time" timestamp
)
;
COMMENT ON COLUMN "public"."sys_oper_log"."oper_id" IS '操作日志ID';
COMMENT ON COLUMN "public"."sys_oper_log"."title" IS '模块标题';
COMMENT ON COLUMN "public"."sys_oper_log"."business_type" IS '业务类型（0其它 1新增 2修改 3删除）';
COMMENT ON COLUMN "public"."sys_oper_log"."method" IS '方法名称';
COMMENT ON COLUMN "public"."sys_oper_log"."request_method" IS '请求方式';
COMMENT ON COLUMN "public"."sys_oper_log"."operator_type" IS '操作类别（0其它 1后台用户 2手机端用户）';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_name" IS '操作人员';
COMMENT ON COLUMN "public"."sys_oper_log"."dept_name" IS '部门名称';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_url" IS '请求URL';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_ip" IS '主机地址';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_location" IS '操作地点';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_param" IS '请求参数';
COMMENT ON COLUMN "public"."sys_oper_log"."json_result" IS '返回参数';
COMMENT ON COLUMN "public"."sys_oper_log"."status" IS '操作状态（0正常 1异常）';
COMMENT ON COLUMN "public"."sys_oper_log"."error_msg" IS '错误消息';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_time" IS '操作时间';
COMMENT ON TABLE "public"."sys_oper_log" IS '操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_post";
CREATE TABLE "public"."sys_post" (
  "post_id" int8 NOT NULL,
  "post_code" varchar(64) NOT NULL,
  "post_name" varchar(50) NOT NULL,
  "post_sort" int4 NOT NULL,
  "status" char(1) NOT NULL,
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sys_post"."post_id" IS '岗位ID';
COMMENT ON COLUMN "public"."sys_post"."post_code" IS '岗位编码';
COMMENT ON COLUMN "public"."sys_post"."post_name" IS '岗位名称';
COMMENT ON COLUMN "public"."sys_post"."post_sort" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_post"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_post"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_post"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_post"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_post"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_post"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_post" IS '岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_post" ("post_id", "post_code", "post_name", "post_sort", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_post" ("post_id", "post_code", "post_name", "post_sort", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_post" ("post_id", "post_code", "post_name", "post_sort", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
INSERT INTO "public"."sys_post" ("post_id", "post_code", "post_name", "post_sort", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2021-12-15 21:36:18', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role";
CREATE TABLE "public"."sys_role" (
  "role_id" int8 NOT NULL,
  "role_name" varchar(30) NOT NULL,
  "role_key" varchar(100) NOT NULL,
  "role_sort" int4 NOT NULL,
  "data_scope" char(1),
  "menu_check_strictly" int2,
  "dept_check_strictly" int2,
  "status" char(1) NOT NULL,
  "del_flag" char(1),
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sys_role"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role"."role_name" IS '角色名称';
COMMENT ON COLUMN "public"."sys_role"."role_key" IS '角色权限字符串';
COMMENT ON COLUMN "public"."sys_role"."role_sort" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_role"."data_scope" IS '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）';
COMMENT ON COLUMN "public"."sys_role"."menu_check_strictly" IS '菜单树选择项是否关联显示';
COMMENT ON COLUMN "public"."sys_role"."dept_check_strictly" IS '部门树选择项是否关联显示';
COMMENT ON COLUMN "public"."sys_role"."status" IS '角色状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_role"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."sys_role"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_role"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_role"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_role"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_role"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_role" IS '角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', '', NULL, '超级管理员');
INSERT INTO "public"."sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, '设备租户', 'tenant', 2, '5', 1, 1, '0', '0', 'admin', '2021-12-16 16:41:30', 'admin', '2023-04-12 19:53:34', '管理产品和设备');
INSERT INTO "public"."sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, '普通用户', 'general', 3, '5', 1, 1, '0', '0', 'admin', '2021-12-15 21:36:18', 'admin', '2023-02-22 08:17:37', '设备的最终用户，只能管理设备和分组');
INSERT INTO "public"."sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, '游客', 'visitor', 4, '1', 1, 1, '0', '0', 'admin', '2021-12-16 16:44:30', 'admin', '2025-03-19 15:06:10', '只能查询和新增系统数据');
INSERT INTO "public"."sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, '管理员', 'manager', 5, '1', 1, 1, '0', '0', 'admin', '2022-06-10 13:54:29', 'admin', '2025-03-19 15:10:17', '普通管理员');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_dept";
CREATE TABLE "public"."sys_role_dept" (
  "role_id" int8 NOT NULL,
  "dept_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_role_dept"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role_dept"."dept_id" IS '部门ID';
COMMENT ON TABLE "public"."sys_role_dept" IS '角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_menu";
CREATE TABLE "public"."sys_role_menu" (
  "role_id" int8 NOT NULL,
  "menu_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_role_menu"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role_menu"."menu_id" IS '菜单ID';
COMMENT ON TABLE "public"."sys_role_menu" IS '角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 1);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 4);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 107);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 1036);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2000);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2001);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2002);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2003);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2004);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2005);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2006);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2007);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2008);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2009);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2010);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2011);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2012);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2019);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2020);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2021);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2022);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2023);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2024);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2043);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2044);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2045);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2046);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2047);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2048);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2049);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2050);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2051);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2052);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2053);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2054);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2129);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2130);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2136);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2137);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2138);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2139);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2140);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2147);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (2, 2148);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 4);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 107);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 1036);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2000);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2007);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2008);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2009);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2010);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2011);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2012);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2019);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2020);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2021);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2022);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2023);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2024);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2067);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2068);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2085);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2086);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2087);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2088);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2089);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2090);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2129);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2130);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2147);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2148);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2168);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2169);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2170);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2171);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (3, 2172);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 3);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 4);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 100);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 101);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 102);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 103);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 104);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 105);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 106);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 107);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 108);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 109);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 110);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 111);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 112);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 113);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 114);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 115);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 116);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 500);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 501);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1001);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1008);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1013);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1017);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1021);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1026);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1031);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1036);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1040);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1043);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1046);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1049);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 1055);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2000);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2001);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2002);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2003);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2007);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2008);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2009);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2019);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2020);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2021);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2043);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2044);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2045);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2049);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2050);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2051);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2123);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2124);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2125);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2129);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2130);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2131);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2136);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2137);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2147);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 2148);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 3031);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 3032);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 3033);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 3034);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (4, 3035);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 3);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 4);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 100);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 101);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 102);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 103);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 104);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 105);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 106);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 107);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 108);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 109);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 110);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 111);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 112);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 113);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 114);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 115);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 116);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 124);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 500);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 501);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1001);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1002);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1003);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1004);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1005);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1006);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1007);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1008);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1009);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1010);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1011);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1012);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1013);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1014);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1015);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1016);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1017);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1018);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1019);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1020);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1021);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1022);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1023);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1024);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1025);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1026);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1027);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1028);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1029);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1030);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1031);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1032);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1033);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1034);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1035);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1036);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1037);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1038);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1039);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1040);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1041);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1042);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1043);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1044);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1045);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1046);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1047);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1048);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1049);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1050);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1051);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1052);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1053);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1054);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1055);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1056);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1057);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1058);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1059);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1060);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 1065);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2000);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2001);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2002);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2003);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2004);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2005);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2006);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2007);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2008);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2009);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2010);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2011);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2012);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2019);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2020);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2021);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2022);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2023);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2024);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2043);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2044);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2045);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2046);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2047);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2048);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2049);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2050);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2051);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2052);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2053);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2054);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2123);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2124);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2125);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2126);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2127);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2128);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2129);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2130);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2131);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2132);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2133);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2134);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2136);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2137);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2138);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2139);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2140);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2147);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 2148);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 3031);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 3032);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 3033);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 3034);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 3035);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 3036);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 3037);
INSERT INTO "public"."sys_role_menu" ("role_id", "menu_id") VALUES (5, 3038);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user";
CREATE TABLE "public"."sys_user" (
  "user_id" int8 NOT NULL,
  "dept_id" int8,
  "user_name" varchar(30) NOT NULL,
  "nick_name" varchar(30) NOT NULL,
  "user_type" varchar(2),
  "email" varchar(50),
  "phonenumber" varchar(11),
  "sex" char(1),
  "avatar" varchar(100),
  "password" varchar(100),
  "status" char(1),
  "del_flag" char(1),
  "login_ip" varchar(128),
  "login_date" timestamp,
  "create_by" varchar(64),
  "create_time" timestamp,
  "update_by" varchar(64),
  "update_time" timestamp,
  "remark" varchar(500)
)
;
COMMENT ON COLUMN "public"."sys_user"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user"."dept_id" IS '部门ID';
COMMENT ON COLUMN "public"."sys_user"."user_name" IS '用户账号';
COMMENT ON COLUMN "public"."sys_user"."nick_name" IS '用户昵称';
COMMENT ON COLUMN "public"."sys_user"."user_type" IS '用户类型（00系统用户）';
COMMENT ON COLUMN "public"."sys_user"."email" IS '用户邮箱';
COMMENT ON COLUMN "public"."sys_user"."phonenumber" IS '手机号码';
COMMENT ON COLUMN "public"."sys_user"."sex" IS '用户性别（0男 1女 2未知）';
COMMENT ON COLUMN "public"."sys_user"."avatar" IS '头像地址';
COMMENT ON COLUMN "public"."sys_user"."password" IS '密码';
COMMENT ON COLUMN "public"."sys_user"."status" IS '帐号状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_user"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "public"."sys_user"."login_ip" IS '最后登录IP';
COMMENT ON COLUMN "public"."sys_user"."login_date" IS '最后登录时间';
COMMENT ON COLUMN "public"."sys_user"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_user"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_user"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_user" IS '用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (1, 103, 'admin', '蜂信管理员', '00', '164770707@qq.com', '15888888888', '0', '', '$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUu', '0', '0', '183.225.40.49', '2025-03-26 11:18:01', 'admin', '2021-12-15 21:36:18', '', '2025-03-26 11:18:01', '管理员');
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (2, 100, 'fastbee-t1', '蜂信租户壹', '00', '', '15888888880', '0', '', '$2a$10$BAWId9C2Nrcwklzl1Ikoau4iqL8XRGvfRjq6Wl.PXWpzwAw0sXMdK', '0', '0', '61.145.97.26', '2023-08-29 14:52:27', 'admin', '2022-04-15 16:21:25', 'admin', '2023-08-29 14:52:26', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (3, 100, 'fastbee-t2', '蜂信租户贰', '00', '', '15888888881', '0', '', '$2a$10$1zMlbW7hGpzA59gpzWGO/ObeASziQ296evjMjHrYdZnxKBLU4WUum', '0', '0', '127.0.0.1', '2022-06-12 00:54:28', 'admin', '2022-04-15 16:22:08', 'admin', '2022-06-12 00:54:30', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (4, 100, 'fastbee-u1', '蜂信用户壹', '00', '', '15888888882', '0', '', '$2a$10$691RJMXZ9HM4sgNTExLPfO5Nw6J6cWgCvcoF9V.jKMnPk5o/8c9VS', '0', '0', '127.0.0.1', '2023-04-12 22:26:39', 'admin', '2022-04-15 16:22:37', 'admin', '2023-04-12 22:26:39', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (5, 100, 'fastbee-u2', '蜂信用户贰', '00', '', '15888888883', '0', '', '$2a$10$x3rM39rewwbi7ayvriGMEOKUHoPCqcL2CYXPLTJRCWYPVvykFIYJq', '0', '0', '127.0.0.1', '2022-06-12 00:55:45', 'admin', '2022-04-15 16:23:13', 'admin', '2022-06-12 00:55:46', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (6, 100, 'fastbee', '游客账号', '00', '', '15888888884', '0', '', '$2a$10$kKeZptrTnSlm0fencX4U2eq.QiaukDs.DckiUsMCwVTxh0IS2LRQ.', '0', '0', '127.0.0.1', '2023-09-21 18:39:29', 'admin', '2022-03-09 16:49:19', 'admin', '2023-09-21 18:39:28', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (7, NULL, 'shenzehui', 'shenzehui', '00', '', '18257292958', '0', '', '$2a$10$UYKWiQF.VWfVvuksS/DMiO234Mwtz.niU7cM/noFgwLVRl7Jjt5pa', '0', '2', '39.189.61.11', '2023-04-16 14:18:09', '', '2023-04-16 14:17:59', '', '2023-04-16 14:18:08', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (8, NULL, 'shadow', 'shadow', '00', '165456465465@qq.com', '15752221201', '0', '', '$2a$10$FXSw4fufDjecEhMxYjji3.7PkrpwkliCBoQO.h8nW0Nhk0bPpxS6u', '0', '2', '39.130.41.108', '2023-09-15 17:21:33', '', '2023-08-23 11:34:23', '', '2023-09-15 17:21:32', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (9, NULL, 'guanshubiao', 'guanshubiao', '00', '', '15217628961', '0', '', '$2a$10$J9kJeP/dzc/SYq8Ev1rFXOigPdN50Kq8MkCX9j56/fQwDXAUkAPYi', '0', '2', '61.145.97.26', '2023-08-29 17:33:16', '', '2023-08-29 14:56:19', '', '2023-08-29 17:33:16', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (10, NULL, 'jamon', 'jamon', '00', '', '13717112711', '0', '', '$2a$10$LMASUfB9IngDi47fQ9Eh7u003VNNh4DcjdPHMyvAQ4mdLXhQgvnpu', '0', '2', '61.145.97.26', '2023-09-01 09:06:23', '', '2023-08-29 15:06:39', '', '2023-09-01 09:06:23', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (11, 101, 'fastbee123', 'fastbee123', '00', '', '18231210622', '0', '', '$2a$10$qpLuw5yAIDLV/.UCIaWRROxhtI2nYpJe/.tbIKwSmy2Pxm.vc26Ri', '0', '2', '27.187.242.251', '2023-08-31 16:22:40', 'admin', '2023-08-31 16:22:21', '', '2023-08-31 16:22:40', NULL);
INSERT INTO "public"."sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES (12, NULL, 'shadow', 'shadow', '00', '', '15752221201', '0', '', '$2a$10$QEYxDoFO6e3wuksc2d7XIOJe0UBzY0EkYR3fKfp8pYfM5bWI4.VO6', '0', '2', '39.130.41.179', '2023-09-19 10:11:00', '', '2023-09-19 10:10:49', '', '2023-09-19 10:11:00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_post";
CREATE TABLE "public"."sys_user_post" (
  "user_id" int8 NOT NULL,
  "post_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_user_post"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user_post"."post_id" IS '岗位ID';
COMMENT ON TABLE "public"."sys_user_post" IS '用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_user_post" ("user_id", "post_id") VALUES (1, 1);
INSERT INTO "public"."sys_user_post" ("user_id", "post_id") VALUES (6, 4);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_role";
CREATE TABLE "public"."sys_user_role" (
  "user_id" int8 NOT NULL,
  "role_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_user_role"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user_role"."role_id" IS '角色ID';
COMMENT ON TABLE "public"."sys_user_role" IS '用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO "public"."sys_user_role" ("user_id", "role_id") VALUES (1, 1);
INSERT INTO "public"."sys_user_role" ("user_id", "role_id") VALUES (2, 2);
INSERT INTO "public"."sys_user_role" ("user_id", "role_id") VALUES (3, 2);
INSERT INTO "public"."sys_user_role" ("user_id", "role_id") VALUES (4, 3);
INSERT INTO "public"."sys_user_role" ("user_id", "role_id") VALUES (5, 3);
INSERT INTO "public"."sys_user_role" ("user_id", "role_id") VALUES (6, 4);
COMMIT;

-- ----------------------------
-- Primary Key structure for table gen_table
-- ----------------------------
ALTER TABLE "public"."gen_table" ADD PRIMARY KEY ("table_id");

-- ----------------------------
-- Primary Key structure for table gen_table_column
-- ----------------------------
ALTER TABLE "public"."gen_table_column" ADD PRIMARY KEY ("column_id");

-- ----------------------------
-- Indexes structure for table iot_category
-- ----------------------------
CREATE INDEX "iot_category_index_tenant_id" ON "public"."iot_category" USING btree (
  "tenant_id" ASC
);
CREATE INDEX "iot_category_index_parent_id" ON "public"."iot_category" USING btree (
  "parent_id" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_category
-- ----------------------------
ALTER TABLE "public"."iot_category" ADD PRIMARY KEY ("category_id");

-- ----------------------------
-- Indexes structure for table iot_device
-- ----------------------------
CREATE UNIQUE INDEX "iot_device_index_serial_number" ON "public"."iot_device" USING btree (
  "serial_number" ASC
);
CREATE INDEX "iot_device_index_product_id" ON "public"."iot_device" USING btree (
  "product_id" ASC
);
CREATE INDEX "iot_device_index_tanant_id" ON "public"."iot_device" USING btree (
  "tenant_id" ASC
);
CREATE INDEX "iot_device_index_user_id" ON "public"."iot_device" USING btree (
  "user_id" ASC
);
CREATE INDEX "iot_device_index_create_time" ON "public"."iot_device" USING btree (
  "create_time" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_device
-- ----------------------------
ALTER TABLE "public"."iot_device" ADD PRIMARY KEY ("device_id");

-- ----------------------------
-- Primary Key structure for table iot_device_group
-- ----------------------------
ALTER TABLE "public"."iot_device_group" ADD PRIMARY KEY ("device_id", "group_id");

-- ----------------------------
-- Indexes structure for table iot_device_job
-- ----------------------------
CREATE INDEX "iot_device_job_index_device_id" ON "public"."iot_device_job" USING btree (
  "device_id" ASC
);
CREATE INDEX "iot_device_job_index_product_id" ON "public"."iot_device_job" USING btree (
  "product_id" ASC
);
CREATE INDEX "iot_device_job_index_scene_id" ON "public"."iot_device_job" USING btree (
  "scene_id" ASC
);
CREATE INDEX "iot_device_job_index_alert_id" ON "public"."iot_device_job" USING btree (
  "alert_id" ASC
);
CREATE INDEX "iot_device_job_index_serial_number" ON "public"."iot_device_job" USING btree (
  "serial_number" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_device_job
-- ----------------------------
ALTER TABLE "public"."iot_device_job" ADD PRIMARY KEY ("job_id", "job_name", "job_group");

-- ----------------------------
-- Indexes structure for table iot_device_log
-- ----------------------------
CREATE INDEX "iot_device_log_index_serial_number" ON "public"."iot_device_log" USING btree (
  "serial_number" ASC
);
CREATE INDEX "iot_device_log_index_tenant_id" ON "public"."iot_device_log" USING btree (
  "tenant_id" ASC
);
CREATE INDEX "iot_device_log_index_user_id" ON "public"."iot_device_log" USING btree (
  "user_id" ASC
);
CREATE INDEX "iot_device_log_index_device_id" ON "public"."iot_device_log" USING btree (
  "device_id" ASC
);
CREATE INDEX "index_serialNumber_createTime" ON "public"."iot_device_log" USING btree (
  "serial_number" ASC,
  "create_time" ASC
);
CREATE INDEX "index_isMonitor_serialNumber_createTime" ON "public"."iot_device_log" USING btree (
  "serial_number" ASC,
  "is_monitor" ASC,
  "create_time" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_device_log
-- ----------------------------
ALTER TABLE "public"."iot_device_log" ADD PRIMARY KEY ("log_id");

-- ----------------------------
-- Primary Key structure for table iot_device_template
-- ----------------------------
ALTER TABLE "public"."iot_device_template" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table iot_device_user
-- ----------------------------
CREATE INDEX "iot_device_user_index_user_id" ON "public"."iot_device_user" USING btree (
  "user_id" ASC
);
CREATE INDEX "iot_device_user_index_tenant_id" ON "public"."iot_device_user" USING btree (
  "tenant_id" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_device_user
-- ----------------------------
ALTER TABLE "public"."iot_device_user" ADD PRIMARY KEY ("device_id", "user_id");

-- ----------------------------
-- Primary Key structure for table iot_event_log
-- ----------------------------
ALTER TABLE "public"."iot_event_log" ADD PRIMARY KEY ("log_id");

-- ----------------------------
-- Indexes structure for table iot_function_log
-- ----------------------------
CREATE UNIQUE INDEX "iot_function_log_id_uindex" ON "public"."iot_function_log" USING btree (
  "id" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_function_log
-- ----------------------------
ALTER TABLE "public"."iot_function_log" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table iot_group
-- ----------------------------
CREATE INDEX "iot_group_index_user_id" ON "public"."iot_group" USING btree (
  "user_id" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_group
-- ----------------------------
ALTER TABLE "public"."iot_group" ADD PRIMARY KEY ("group_id");

-- ----------------------------
-- Indexes structure for table iot_product
-- ----------------------------
CREATE INDEX "iot_product_index_category_id" ON "public"."iot_product" USING btree (
  "category_id" ASC
);
CREATE INDEX "iot_product_index_tenant_id" ON "public"."iot_product" USING btree (
  "tenant_id" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_product
-- ----------------------------
ALTER TABLE "public"."iot_product" ADD PRIMARY KEY ("product_id");

-- ----------------------------
-- Indexes structure for table iot_product_authorize
-- ----------------------------
CREATE INDEX "iot_product_authorize_index_product_id" ON "public"."iot_product_authorize" USING btree (
  "product_id" ASC
);
CREATE INDEX "iot_product_authorize_index_device_id" ON "public"."iot_product_authorize" USING btree (
  "device_id" ASC
);
CREATE INDEX "iot_product_authorize_index_serial_number" ON "public"."iot_product_authorize" USING btree (
  "serial_number" ASC
);
CREATE INDEX "iot_product_authorize_index_user_id" ON "public"."iot_product_authorize" USING btree (
  "user_id" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_product_authorize
-- ----------------------------
ALTER TABLE "public"."iot_product_authorize" ADD PRIMARY KEY ("authorize_id");

-- ----------------------------
-- Indexes structure for table iot_protocol
-- ----------------------------
CREATE UNIQUE INDEX "UNIQUE_CODE" ON "public"."iot_protocol" USING btree (
  "protocol_code" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_protocol
-- ----------------------------
ALTER TABLE "public"."iot_protocol" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table iot_scene
-- ----------------------------
CREATE INDEX "iot_scene_index_user_id" ON "public"."iot_scene" USING btree (
  "user_id" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_scene
-- ----------------------------
ALTER TABLE "public"."iot_scene" ADD PRIMARY KEY ("scene_id");

-- ----------------------------
-- Primary Key structure for table iot_scene_script
-- ----------------------------
ALTER TABLE "public"."iot_scene_script" ADD PRIMARY KEY ("script_id");

-- ----------------------------
-- Primary Key structure for table iot_script
-- ----------------------------
ALTER TABLE "public"."iot_script" ADD PRIMARY KEY ("script_id");

-- ----------------------------
-- Indexes structure for table iot_social_platform
-- ----------------------------
CREATE UNIQUE INDEX "iot_social_platform_platform_uindex" ON "public"."iot_social_platform" USING btree (
  "platform" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_social_platform
-- ----------------------------
ALTER TABLE "public"."iot_social_platform" ADD PRIMARY KEY ("social_platform_id");

-- ----------------------------
-- Indexes structure for table iot_social_user
-- ----------------------------
CREATE UNIQUE INDEX "iot_social_user_pk" ON "public"."iot_social_user" USING btree (
  "social_user_id" ASC
);
CREATE UNIQUE INDEX "iot_social_user_unique_key" ON "public"."iot_social_user" USING btree (
  "uuid" ASC,
  "source" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_social_user
-- ----------------------------
ALTER TABLE "public"."iot_social_user" ADD PRIMARY KEY ("social_user_id");

-- ----------------------------
-- Indexes structure for table iot_things_model
-- ----------------------------
CREATE INDEX "iot_things_model_index_product_id" ON "public"."iot_things_model" USING btree (
  "product_id" ASC
);
CREATE INDEX "iot_things_model_index_tenant_id" ON "public"."iot_things_model" USING btree (
  "tenant_id" ASC
);
CREATE INDEX "iot_things_model_index_model_order" ON "public"."iot_things_model" USING btree (
  "model_order" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_things_model
-- ----------------------------
ALTER TABLE "public"."iot_things_model" ADD PRIMARY KEY ("model_id");

-- ----------------------------
-- Indexes structure for table iot_things_model_template
-- ----------------------------
CREATE INDEX "iot_things_model_template_index_tenant_id" ON "public"."iot_things_model_template" USING btree (
  "tenant_id" ASC
);
CREATE INDEX "iot_things_model_template_index_model_order" ON "public"."iot_things_model_template" USING btree (
  "model_order" ASC
);

-- ----------------------------
-- Primary Key structure for table iot_things_model_template
-- ----------------------------
ALTER TABLE "public"."iot_things_model_template" ADD PRIMARY KEY ("template_id");

-- ----------------------------
-- Primary Key structure for table media_server
-- ----------------------------
ALTER TABLE "public"."media_server" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table news
-- ----------------------------
CREATE INDEX "news_index_category_id" ON "public"."news" USING btree (
  "category_id" ASC
);

-- ----------------------------
-- Primary Key structure for table news
-- ----------------------------
ALTER TABLE "public"."news" ADD PRIMARY KEY ("news_id");

-- ----------------------------
-- Primary Key structure for table news_category
-- ----------------------------
ALTER TABLE "public"."news_category" ADD PRIMARY KEY ("category_id");

-- ----------------------------
-- Primary Key structure for table oauth_client_details
-- ----------------------------
ALTER TABLE "public"."oauth_client_details" ADD PRIMARY KEY ("client_id");

-- ----------------------------
-- Primary Key structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_blob_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_calendars
-- ----------------------------
ALTER TABLE "public"."qrtz_calendars" ADD PRIMARY KEY ("sched_name", "calendar_name");

-- ----------------------------
-- Primary Key structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_cron_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_fired_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_fired_triggers" ADD PRIMARY KEY ("sched_name", "entry_id");

-- ----------------------------
-- Primary Key structure for table qrtz_job_details
-- ----------------------------
ALTER TABLE "public"."qrtz_job_details" ADD PRIMARY KEY ("sched_name", "job_name", "job_group");

-- ----------------------------
-- Primary Key structure for table qrtz_locks
-- ----------------------------
ALTER TABLE "public"."qrtz_locks" ADD PRIMARY KEY ("sched_name", "lock_name");

-- ----------------------------
-- Primary Key structure for table qrtz_paused_trigger_grps
-- ----------------------------
ALTER TABLE "public"."qrtz_paused_trigger_grps" ADD PRIMARY KEY ("sched_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_scheduler_state
-- ----------------------------
ALTER TABLE "public"."qrtz_scheduler_state" ADD PRIMARY KEY ("sched_name", "instance_name");

-- ----------------------------
-- Primary Key structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_simple_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_simprop_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Indexes structure for table qrtz_triggers
-- ----------------------------
CREATE INDEX "sched_name" ON "public"."qrtz_triggers" USING btree (
  "sched_name" ASC,
  "job_name" ASC,
  "job_group" ASC
);

-- ----------------------------
-- Primary Key structure for table qrtz_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table sip_config
-- ----------------------------
ALTER TABLE "public"."sip_config" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sip_device
-- ----------------------------
ALTER TABLE "public"."sip_device" ADD PRIMARY KEY ("device_id");

-- ----------------------------
-- Primary Key structure for table sip_device_channel
-- ----------------------------
ALTER TABLE "public"."sip_device_channel" ADD PRIMARY KEY ("id", "device_sip_id");

-- ----------------------------
-- Primary Key structure for table sys_auth_user
-- ----------------------------
ALTER TABLE "public"."sys_auth_user" ADD PRIMARY KEY ("auth_id");

-- ----------------------------
-- Primary Key structure for table sys_config
-- ----------------------------
ALTER TABLE "public"."sys_config" ADD PRIMARY KEY ("config_id");

-- ----------------------------
-- Primary Key structure for table sys_dept
-- ----------------------------
ALTER TABLE "public"."sys_dept" ADD PRIMARY KEY ("dept_id");

-- ----------------------------
-- Primary Key structure for table sys_dict_data
-- ----------------------------
ALTER TABLE "public"."sys_dict_data" ADD PRIMARY KEY ("dict_code");

-- ----------------------------
-- Indexes structure for table sys_dict_type
-- ----------------------------
CREATE UNIQUE INDEX "dict_type" ON "public"."sys_dict_type" USING btree (
  "dict_type" ASC
);

-- ----------------------------
-- Primary Key structure for table sys_dict_type
-- ----------------------------
ALTER TABLE "public"."sys_dict_type" ADD PRIMARY KEY ("dict_id");

-- ----------------------------
-- Primary Key structure for table sys_job
-- ----------------------------
ALTER TABLE "public"."sys_job" ADD PRIMARY KEY ("job_id", "job_name", "job_group");

-- ----------------------------
-- Primary Key structure for table sys_job_log
-- ----------------------------
ALTER TABLE "public"."sys_job_log" ADD PRIMARY KEY ("job_log_id");

-- ----------------------------
-- Primary Key structure for table sys_logininfor
-- ----------------------------
ALTER TABLE "public"."sys_logininfor" ADD PRIMARY KEY ("info_id");

-- ----------------------------
-- Primary Key structure for table sys_menu
-- ----------------------------
ALTER TABLE "public"."sys_menu" ADD PRIMARY KEY ("menu_id");

-- ----------------------------
-- Primary Key structure for table sys_notice
-- ----------------------------
ALTER TABLE "public"."sys_notice" ADD PRIMARY KEY ("notice_id");

-- ----------------------------
-- Primary Key structure for table sys_oper_log
-- ----------------------------
ALTER TABLE "public"."sys_oper_log" ADD PRIMARY KEY ("oper_id");

-- ----------------------------
-- Primary Key structure for table sys_post
-- ----------------------------
ALTER TABLE "public"."sys_post" ADD PRIMARY KEY ("post_id");

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "public"."sys_role" ADD PRIMARY KEY ("role_id");

-- ----------------------------
-- Primary Key structure for table sys_role_dept
-- ----------------------------
ALTER TABLE "public"."sys_role_dept" ADD PRIMARY KEY ("role_id", "dept_id");

-- ----------------------------
-- Primary Key structure for table sys_role_menu
-- ----------------------------
ALTER TABLE "public"."sys_role_menu" ADD PRIMARY KEY ("role_id", "menu_id");

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table sys_user_post
-- ----------------------------
ALTER TABLE "public"."sys_user_post" ADD PRIMARY KEY ("user_id", "post_id");

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "public"."sys_user_role" ADD PRIMARY KEY ("user_id", "role_id");

-- ----------------------------
-- Foreign Keys structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_blob_triggers" ADD CONSTRAINT "QRTZ_BLOB_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Foreign Keys structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_cron_triggers" ADD CONSTRAINT "QRTZ_CRON_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Foreign Keys structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_simple_triggers" ADD CONSTRAINT "QRTZ_SIMPLE_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Foreign Keys structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_simprop_triggers" ADD CONSTRAINT "QRTZ_SIMPROP_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "public"."qrtz_triggers" ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Foreign Keys structure for table qrtz_triggers
-- ----------------------------
ALTER TABLE "public"."qrtz_triggers" ADD CONSTRAINT "QRTZ_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "job_name", "job_group") REFERENCES "public"."qrtz_job_details" ("sched_name", "job_name", "job_group");
