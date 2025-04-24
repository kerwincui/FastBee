/*
 Navicat Premium Data Transfer

 Source Server         : 81.71.97.58_3306
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : 81.71.97.58:3306
 Source Schema         : kaiyuan

 Target Server Type    : Oracle
 Target Server Version : 120100
 File Encoding         : 65001

 Date: 24/04/2025 18:00:19
*/


-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE "gen_table";
CREATE TABLE "gen_table" (
  "table_id" NUMBER(20) NOT NULL,
  "table_name" NVARCHAR2(200),
  "data_name" NVARCHAR2(200),
  "table_comment" NVARCHAR2(500),
  "sub_table_name" NVARCHAR2(64),
  "sub_table_fk_name" NVARCHAR2(64),
  "class_name" NVARCHAR2(100),
  "tpl_category" NVARCHAR2(200),
  "package_name" NVARCHAR2(100),
  "module_name" NVARCHAR2(30),
  "business_name" NVARCHAR2(30),
  "function_name" NVARCHAR2(50),
  "function_author" NVARCHAR2(50),
  "gen_type" NCHAR(1),
  "gen_path" NVARCHAR2(200),
  "options" NVARCHAR2(1000),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "gen_table"."table_id" IS '编号';
COMMENT ON COLUMN "gen_table"."table_name" IS '表名称';
COMMENT ON COLUMN "gen_table"."data_name" IS '数据源名称';
COMMENT ON COLUMN "gen_table"."table_comment" IS '表描述';
COMMENT ON COLUMN "gen_table"."sub_table_name" IS '关联子表的表名';
COMMENT ON COLUMN "gen_table"."sub_table_fk_name" IS '子表关联的外键名';
COMMENT ON COLUMN "gen_table"."class_name" IS '实体类名称';
COMMENT ON COLUMN "gen_table"."tpl_category" IS '使用的模板（crud单表操作 tree树表操作）';
COMMENT ON COLUMN "gen_table"."package_name" IS '生成包路径';
COMMENT ON COLUMN "gen_table"."module_name" IS '生成模块名';
COMMENT ON COLUMN "gen_table"."business_name" IS '生成业务名';
COMMENT ON COLUMN "gen_table"."function_name" IS '生成功能名';
COMMENT ON COLUMN "gen_table"."function_author" IS '生成功能作者';
COMMENT ON COLUMN "gen_table"."gen_type" IS '生成代码方式（0zip压缩包 1自定义路径）';
COMMENT ON COLUMN "gen_table"."gen_path" IS '生成路径（不填默认项目路径）';
COMMENT ON COLUMN "gen_table"."options" IS '其它生成选项';
COMMENT ON COLUMN "gen_table"."create_by" IS '创建者';
COMMENT ON COLUMN "gen_table"."create_time" IS '创建时间';
COMMENT ON COLUMN "gen_table"."update_by" IS '更新者';
COMMENT ON COLUMN "gen_table"."update_time" IS '更新时间';
COMMENT ON COLUMN "gen_table"."remark" IS '备注';
COMMENT ON TABLE "gen_table" IS '代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE "gen_table_column";
CREATE TABLE "gen_table_column" (
  "column_id" NUMBER(20) NOT NULL,
  "table_id" NVARCHAR2(64),
  "column_name" NVARCHAR2(200),
  "column_comment" NVARCHAR2(500),
  "column_type" NVARCHAR2(100),
  "java_type" NVARCHAR2(500),
  "java_field" NVARCHAR2(200),
  "is_pk" NCHAR(1),
  "is_increment" NCHAR(1),
  "is_required" NCHAR(1),
  "is_insert" NCHAR(1),
  "is_edit" NCHAR(1),
  "is_list" NCHAR(1),
  "is_query" NCHAR(1),
  "query_type" NVARCHAR2(200),
  "html_type" NVARCHAR2(200),
  "dict_type" NVARCHAR2(200),
  "sort" NUMBER(11),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE
)
;
COMMENT ON COLUMN "gen_table_column"."column_id" IS '编号';
COMMENT ON COLUMN "gen_table_column"."table_id" IS '归属表编号';
COMMENT ON COLUMN "gen_table_column"."column_name" IS '列名称';
COMMENT ON COLUMN "gen_table_column"."column_comment" IS '列描述';
COMMENT ON COLUMN "gen_table_column"."column_type" IS '列类型';
COMMENT ON COLUMN "gen_table_column"."java_type" IS 'JAVA类型';
COMMENT ON COLUMN "gen_table_column"."java_field" IS 'JAVA字段名';
COMMENT ON COLUMN "gen_table_column"."is_pk" IS '是否主键（1是）';
COMMENT ON COLUMN "gen_table_column"."is_increment" IS '是否自增（1是）';
COMMENT ON COLUMN "gen_table_column"."is_required" IS '是否必填（1是）';
COMMENT ON COLUMN "gen_table_column"."is_insert" IS '是否为插入字段（1是）';
COMMENT ON COLUMN "gen_table_column"."is_edit" IS '是否编辑字段（1是）';
COMMENT ON COLUMN "gen_table_column"."is_list" IS '是否列表字段（1是）';
COMMENT ON COLUMN "gen_table_column"."is_query" IS '是否查询字段（1是）';
COMMENT ON COLUMN "gen_table_column"."query_type" IS '查询方式（等于、不等于、大于、小于、范围）';
COMMENT ON COLUMN "gen_table_column"."html_type" IS '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）';
COMMENT ON COLUMN "gen_table_column"."dict_type" IS '字典类型';
COMMENT ON COLUMN "gen_table_column"."sort" IS '排序';
COMMENT ON COLUMN "gen_table_column"."create_by" IS '创建者';
COMMENT ON COLUMN "gen_table_column"."create_time" IS '创建时间';
COMMENT ON COLUMN "gen_table_column"."update_by" IS '更新者';
COMMENT ON COLUMN "gen_table_column"."update_time" IS '更新时间';
COMMENT ON TABLE "gen_table_column" IS '代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_category
-- ----------------------------
DROP TABLE "iot_category";
CREATE TABLE "iot_category" (
  "category_id" NUMBER(20) NOT NULL,
  "category_name" NVARCHAR2(64) NOT NULL,
  "tenant_id" NUMBER(20) NOT NULL,
  "tenant_name" NVARCHAR2(30) NOT NULL,
  "is_sys" NUMBER(4) NOT NULL,
  "parent_id" NUMBER(20),
  "order_num" NUMBER(11),
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "iot_category"."category_id" IS '产品分类ID';
COMMENT ON COLUMN "iot_category"."category_name" IS '产品分类名称';
COMMENT ON COLUMN "iot_category"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "iot_category"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "iot_category"."is_sys" IS '是否系统通用（0-否，1-是）';
COMMENT ON COLUMN "iot_category"."parent_id" IS '父级ID';
COMMENT ON COLUMN "iot_category"."order_num" IS '显示顺序';
COMMENT ON COLUMN "iot_category"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "iot_category"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_category"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_category"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_category"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_category"."remark" IS '备注';
COMMENT ON TABLE "iot_category" IS '产品分类';

-- ----------------------------
-- Records of iot_category
-- ----------------------------
INSERT INTO "iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', '电工照明', '1', 'admin', '1', '0', '1', '0', '', TO_DATE('2022-03-01 11:44:37', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-04-10 01:12:48', 'SYYYY-MM-DD HH24:MI:SS'), '例如：通断器、开关、插座、窗帘、灯');
INSERT INTO "iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '家居安防', '1', 'admin', '1', '0', '2', '0', '', TO_DATE('2021-12-18 14:46:52', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2021-12-18 14:49:48', 'SYYYY-MM-DD HH24:MI:SS'), '例如：智能门锁、摄像头、智能窗帘');
INSERT INTO "iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', '环境电器', '1', 'admin', '1', '0', '3', '0', '', TO_DATE('2021-12-18 14:50:24', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-04-10 01:12:53', 'SYYYY-MM-DD HH24:MI:SS'), '例如：加湿器、风扇、扫地机器人');
INSERT INTO "iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('4', '大家电', '1', 'admin', '1', '0', '4', '0', '', TO_DATE('2021-12-18 14:50:58', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2021-12-18 14:52:30', 'SYYYY-MM-DD HH24:MI:SS'), '例如：冰箱、热水器、电视');
INSERT INTO "iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('5', '厨房电器', '1', 'admin', '1', '0', '5', '0', '', TO_DATE('2021-12-18 14:51:42', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2021-12-18 14:52:35', 'SYYYY-MM-DD HH24:MI:SS'), '例如：油烟机、烤箱、电饭煲');
INSERT INTO "iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('6', '个护健康', '1', 'admin', '1', '0', '6', '0', '', TO_DATE('2021-12-18 14:52:15', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2021-12-18 14:52:40', 'SYYYY-MM-DD HH24:MI:SS'), '例如：洗衣机、按摩椅');
INSERT INTO "iot_category" ("category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "parent_id", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('7', '其他', '1', 'admin', '1', '0', '7', '0', '', TO_DATE('2021-12-18 14:52:54', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2021-12-20 15:04:33', 'SYYYY-MM-DD HH24:MI:SS'), '其他');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_device
-- ----------------------------
DROP TABLE "iot_device";
CREATE TABLE "iot_device" (
  "device_id" NUMBER(20) NOT NULL,
  "device_name" NVARCHAR2(64) NOT NULL,
  "product_id" NUMBER(20) NOT NULL,
  "product_name" NVARCHAR2(64) NOT NULL,
  "user_id" NUMBER(20) NOT NULL,
  "user_name" NVARCHAR2(30) NOT NULL,
  "tenant_id" NUMBER(20) NOT NULL,
  "tenant_name" NVARCHAR2(30) NOT NULL,
  "serial_number" NVARCHAR2(64) NOT NULL,
  "gw_dev_code" NVARCHAR2(64),
  "firmware_version" NUMBER(11,2) NOT NULL,
  "status" NUMBER(4) NOT NULL,
  "rssi" NUMBER(4),
  "is_shadow" NUMBER(4),
  "location_way" NUMBER(4),
  "things_model_value" CLOB,
  "network_address" NVARCHAR2(255),
  "network_ip" NVARCHAR2(32),
  "longitude" NUMBER(11,6),
  "latitude" NUMBER(11,6),
  "active_time" DATE,
  "summary" CLOB,
  "img_url" NVARCHAR2(255),
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500),
  "is_simulate" NUMBER(4),
  "slave_id" NUMBER(11)
)
;
COMMENT ON COLUMN "iot_device"."device_id" IS '设备ID';
COMMENT ON COLUMN "iot_device"."device_name" IS '设备名称';
COMMENT ON COLUMN "iot_device"."product_id" IS '产品ID';
COMMENT ON COLUMN "iot_device"."product_name" IS '产品名称';
COMMENT ON COLUMN "iot_device"."user_id" IS '用户ID';
COMMENT ON COLUMN "iot_device"."user_name" IS '用户昵称';
COMMENT ON COLUMN "iot_device"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "iot_device"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "iot_device"."serial_number" IS '设备编号';
COMMENT ON COLUMN "iot_device"."gw_dev_code" IS '子设备网关编号';
COMMENT ON COLUMN "iot_device"."firmware_version" IS '固件版本';
COMMENT ON COLUMN "iot_device"."status" IS '设备状态（1-未激活，2-禁用，3-在线，4-离线）';
COMMENT ON COLUMN "iot_device"."rssi" IS '信号强度（
信号极好4格[-55— 0]，
信号好3格[-70— -55]，
信号一般2格[-85— -70]，
信号差1格[-100— -85]）';
COMMENT ON COLUMN "iot_device"."is_shadow" IS '是否启用设备影子(0=禁用，1=启用)';
COMMENT ON COLUMN "iot_device"."location_way" IS '定位方式(1=ip自动定位，2=设备定位，3=自定义)';
COMMENT ON COLUMN "iot_device"."things_model_value" IS '物模型值';
COMMENT ON COLUMN "iot_device"."network_address" IS '设备所在地址';
COMMENT ON COLUMN "iot_device"."network_ip" IS '设备入网IP';
COMMENT ON COLUMN "iot_device"."longitude" IS '设备经度';
COMMENT ON COLUMN "iot_device"."latitude" IS '设备纬度';
COMMENT ON COLUMN "iot_device"."active_time" IS '激活时间';
COMMENT ON COLUMN "iot_device"."summary" IS '设备摘要，格式[{"name":"device"},{"chip":"esp8266"}]';
COMMENT ON COLUMN "iot_device"."img_url" IS '图片地址';
COMMENT ON COLUMN "iot_device"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "iot_device"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_device"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_device"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_device"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_device"."remark" IS '备注';
COMMENT ON COLUMN "iot_device"."is_simulate" IS '是否是模拟设备';
COMMENT ON COLUMN "iot_device"."slave_id" IS '从机id';
COMMENT ON TABLE "iot_device" IS '设备';

-- ----------------------------
-- Records of iot_device
-- ----------------------------
INSERT INTO "iot_device" ("device_id", "device_name", "product_id", "product_name", "user_id", "user_name", "tenant_id", "tenant_name", "serial_number", "gw_dev_code", "firmware_version", "status", "rssi", "is_shadow", "location_way", "things_model_value", "network_address", "network_ip", "longitude", "latitude", "active_time", "summary", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "is_simulate", "slave_id") VALUES ('108', '温湿度开关', '41', '★智能开关产品', '1', 'admin', '1', 'admin', 'D1ELV3A5TOJS', NULL, '1.00', '4', '-51', '1', '1', '[{"id": "irc", "name": "射频遥控", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "report_monitor", "name": "上报数据", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "humidity", "name": "空气湿度", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "co2", "name": "二氧化碳", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "value": " , , , ", "shadow": " , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "reset", "name": "设备重启", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "status", "name": "上报状态", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "temperature", "name": "空气温度", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "brightness", "name": "室内亮度", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}]', ' 本机地址', '127.0.0.1', '113.128512', '23.027759', TO_DATE('2023-02-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '{"chip": "esp8266", "name": "wumei-smart", "author": "kerwincui", "create": "2022-06-06", "version": 1.6}', NULL, '0', '', TO_DATE('2025-02-25 23:15:56', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2024-04-23 15:47:11', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL);
INSERT INTO "iot_device" ("device_id", "device_name", "product_id", "product_name", "user_id", "user_name", "tenant_id", "tenant_name", "serial_number", "gw_dev_code", "firmware_version", "status", "rssi", "is_shadow", "location_way", "things_model_value", "network_address", "network_ip", "longitude", "latitude", "active_time", "summary", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "is_simulate", "slave_id") VALUES ('109', '网关设备', '55', '★网关产品', '1', 'admin', '1', 'admin', 'D1PGLPG58KZ2', NULL, '1.00', '4', '-73', '1', '3', '[{"id": "category_gear", "name": "运行档位", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_switch", "name": "设备开关", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_light", "ts": "2023-09-25 17:56:08.848", "name": "光照", "value": "68", "shadow": "68", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "value": " , , , , , , ", "shadow": " , , , , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "value": " , , , ", "shadow": " , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "temperature", "ts": "2023-09-25 17:56:08.582", "name": "空气温度", "value": "23.69", "shadow": "23.69", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_irc", "name": "射频遥控", "value": " , , , , , , ", "shadow": " , , , , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "brightness", "ts": "2023-09-25 17:56:08.671", "name": "室内亮度", "value": "5387", "shadow": "5387", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "report_monitor", "name": "上报监测数据", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "ts": "2023-09-25 17:56:26.188", "name": "设备开关", "value": "1,1,1, ,1,1, ", "shadow": "1,1,1, ,1,1, ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_temperature", "ts": "2023-09-25 17:56:09.203", "name": "空气温度-只读", "value": "95", "shadow": "95", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_co2", "ts": "2023-09-25 17:56:11.229", "name": "二氧化碳", "value": "3780,2612,2145,3988,5697, , ", "shadow": "3780,2612,2145,3988,5697, , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_gear", "ts": "2023-09-25 17:56:28.066", "name": "运行档位", "value": "0,0,0, ,0,0, ", "shadow": "0,0,0, ,0,0, ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_humidity", "ts": "2023-09-25 17:56:09.025", "name": "空气湿度", "value": "90", "shadow": "90", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_report_monitor", "name": "上报监测数据", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_irc", "name": "射频遥控", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "reset", "name": "设备重启", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_temperature", "ts": "2023-09-25 17:56:11.45", "name": "空气温度-只读", "value": "86,39,4,80,52, , ", "shadow": "86,39,4,80,52, , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}]', '云南省曲靖市 移通', '183.225.206.92', '104.802435', '26.496407', TO_DATE('2023-02-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '{"chip": "esp8266", "name": "wumei-smart", "author": "kerwincui", "create": "2022-06-06", "version": 1.6}', NULL, '0', '', TO_DATE('2025-02-25 23:17:31', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-25 23:14:52', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL);
INSERT INTO "iot_device" ("device_id", "device_name", "product_id", "product_name", "user_id", "user_name", "tenant_id", "tenant_name", "serial_number", "gw_dev_code", "firmware_version", "status", "rssi", "is_shadow", "location_way", "things_model_value", "network_address", "network_ip", "longitude", "latitude", "active_time", "summary", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "is_simulate", "slave_id") VALUES ('140', '视频监控', '88', '￥视频监控产品', '1', 'admin', '1', 'admin', '11010200001320000001', NULL, '1.00', '4', '0', '0', '1', NULL, '广东省 移通', '120.231.214.134', NULL, NULL, TO_DATE('2023-04-11 21:14:16', 'SYYYY-MM-DD HH24:MI:SS'), '{"port": 5060, "firmware": "V5.7.4", "transport": "UDP", "streammode": "UDP", "hostaddress": "192.168.2.119:5060", "manufacturer": "Hikvision"}', NULL, '0', '', TO_DATE('2023-04-11 21:12:35', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-04-11 22:11:01', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_device_group
-- ----------------------------
DROP TABLE "iot_device_group";
CREATE TABLE "iot_device_group" (
  "device_id" NUMBER(20) NOT NULL,
  "group_id" NUMBER(20) NOT NULL
)
;
COMMENT ON COLUMN "iot_device_group"."device_id" IS '设备ID';
COMMENT ON COLUMN "iot_device_group"."group_id" IS '分组ID';
COMMENT ON TABLE "iot_device_group" IS '设备分组';

-- ----------------------------
-- Records of iot_device_group
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_device_job
-- ----------------------------
DROP TABLE "iot_device_job";
CREATE TABLE "iot_device_job" (
  "job_id" NUMBER(20) NOT NULL,
  "job_name" NVARCHAR2(64) NOT NULL,
  "job_group" NVARCHAR2(64) NOT NULL,
  "cron_expression" NVARCHAR2(255),
  "misfire_policy" NVARCHAR2(20),
  "concurrent" NCHAR(1),
  "status" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500),
  "device_id" NUMBER(20),
  "serial_number" NVARCHAR2(64),
  "device_name" NVARCHAR2(64),
  "is_advance" NUMBER(4),
  "actions" CLOB,
  "job_type" NUMBER(4),
  "product_id" NUMBER(20),
  "product_name" NVARCHAR2(64),
  "scene_id" NUMBER(20),
  "alert_id" NUMBER(20),
  "alert_trigger" CLOB
)
;
COMMENT ON COLUMN "iot_device_job"."job_id" IS '任务ID';
COMMENT ON COLUMN "iot_device_job"."job_name" IS '任务名称';
COMMENT ON COLUMN "iot_device_job"."job_group" IS '任务组名';
COMMENT ON COLUMN "iot_device_job"."cron_expression" IS 'cron执行表达式';
COMMENT ON COLUMN "iot_device_job"."misfire_policy" IS '计划执行错误策略（1立即执行 2执行一次 3放弃执行）';
COMMENT ON COLUMN "iot_device_job"."concurrent" IS '是否并发执行（0允许 1禁止）';
COMMENT ON COLUMN "iot_device_job"."status" IS '状态（0正常 1暂停）';
COMMENT ON COLUMN "iot_device_job"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_device_job"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_device_job"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_device_job"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_device_job"."remark" IS '备注信息';
COMMENT ON COLUMN "iot_device_job"."device_id" IS '设备ID';
COMMENT ON COLUMN "iot_device_job"."serial_number" IS '设备编号';
COMMENT ON COLUMN "iot_device_job"."device_name" IS '设备名称';
COMMENT ON COLUMN "iot_device_job"."is_advance" IS '是否详细corn表达式（1=是，0=否）';
COMMENT ON COLUMN "iot_device_job"."actions" IS '执行的动作集合';
COMMENT ON COLUMN "iot_device_job"."job_type" IS '任务类型（1=设备定时，2=设备告警，3=场景联动）';
COMMENT ON COLUMN "iot_device_job"."product_id" IS '产品ID';
COMMENT ON COLUMN "iot_device_job"."product_name" IS '产品名称';
COMMENT ON COLUMN "iot_device_job"."scene_id" IS '场景联动ID';
COMMENT ON COLUMN "iot_device_job"."alert_id" IS '告警ID';
COMMENT ON COLUMN "iot_device_job"."alert_trigger" IS '定时告警触发器';
COMMENT ON TABLE "iot_device_job" IS '设备定时';

-- ----------------------------
-- Records of iot_device_job
-- ----------------------------
INSERT INTO "iot_device_job" ("job_id", "job_name", "job_group", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark", "device_id", "serial_number", "device_name", "is_advance", "actions", "job_type", "product_id", "product_name", "scene_id", "alert_id", "alert_trigger") VALUES ('4', 'P', 'DEFAULT', '0 08 11 ? * 1,2,3,4,5,6,7', '2', '1', '0', 'admin', TO_DATE('2023-04-15 11:08:37', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '', '108', 'D1ELV3A5TOJS', '★温湿度开关', '0', '[{"id": "gear", "name": "运行档位", "type": 2, "value": "2", "deviceId": 108, "deviceName": "★温湿度开关"}]', '1', '41', '★智能开关产品', NULL, NULL, NULL);
INSERT INTO "iot_device_job" ("job_id", "job_name", "job_group", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark", "device_id", "serial_number", "device_name", "is_advance", "actions", "job_type", "product_id", "product_name", "scene_id", "alert_id", "alert_trigger") VALUES ('5', '告警定时触发', 'DEFAULT', '0 13 11 ? * 1,2,3,4,5,6,7', '2', '1', '0', '', TO_DATE('2023-04-15 11:14:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '', NULL, NULL, '告警定时触发', '0', '[{"id": "gear", "name": "运行档位", "type": 2, "value": "1", "productId": 96, "productName": "★网关产品"}]', '2', '96', '★网关产品', NULL, '50', '{"id": "temperature", "name": "空气温度", "type": 1, "jobId": 0, "value": "1", "params": {}, "source": 2, "status": 1, "alertId": 50, "operator": "=", "isAdvance": 0, "productId": 96, "productName": "★网关产品", "cronExpression": "0 13 11 ? * 1,2,3,4,5,6,7"}');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_device_log
-- ----------------------------
DROP TABLE "iot_device_log";
CREATE TABLE "iot_device_log" (
  "log_id" NUMBER(20) NOT NULL,
  "identify" NVARCHAR2(64) NOT NULL,
  "model_name" NVARCHAR2(255),
  "log_type" NUMBER(4) NOT NULL,
  "log_value" NVARCHAR2(64) NOT NULL,
  "device_id" NUMBER(20),
  "device_name" NVARCHAR2(64),
  "serial_number" NVARCHAR2(64),
  "is_monitor" NUMBER(4) NOT NULL,
  "mode" NUMBER(4) NOT NULL,
  "user_id" NUMBER(20),
  "user_name" NVARCHAR2(30),
  "tenant_id" NUMBER(20),
  "tenant_name" NVARCHAR2(30),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "remark" NVARCHAR2(200)
)
;
COMMENT ON COLUMN "iot_device_log"."log_id" IS '设备监测信息ID';
COMMENT ON COLUMN "iot_device_log"."identify" IS '标识符';
COMMENT ON COLUMN "iot_device_log"."model_name" IS '物模型名称';
COMMENT ON COLUMN "iot_device_log"."log_type" IS '类型（1=属性上报，2=调用功能，3=事件上报，4=设备升级，5=设备上线，6=设备离线）';
COMMENT ON COLUMN "iot_device_log"."log_value" IS '日志值';
COMMENT ON COLUMN "iot_device_log"."device_id" IS '设备ID';
COMMENT ON COLUMN "iot_device_log"."device_name" IS '设备名称';
COMMENT ON COLUMN "iot_device_log"."serial_number" IS '设备编号';
COMMENT ON COLUMN "iot_device_log"."is_monitor" IS '是否监测数据（1=是，0=否）';
COMMENT ON COLUMN "iot_device_log"."mode" IS '模式(1=影子模式，2=在线模式，3=其他)';
COMMENT ON COLUMN "iot_device_log"."user_id" IS '用户ID';
COMMENT ON COLUMN "iot_device_log"."user_name" IS '用户昵称';
COMMENT ON COLUMN "iot_device_log"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "iot_device_log"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "iot_device_log"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_device_log"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_device_log"."remark" IS '备注';
COMMENT ON TABLE "iot_device_log" IS '设备日志';

-- ----------------------------
-- Records of iot_device_log
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_device_template
-- ----------------------------
DROP TABLE "iot_device_template";
CREATE TABLE "iot_device_template" (
  "id" NUMBER(20) NOT NULL,
  "product_id" NUMBER(20),
  "template_id" NUMBER(20)
)
;
COMMENT ON COLUMN "iot_device_template"."id" IS '自增id';
COMMENT ON COLUMN "iot_device_template"."product_id" IS '产品id';
COMMENT ON COLUMN "iot_device_template"."template_id" IS '采集点模板id';
COMMENT ON TABLE "iot_device_template" IS '设备采集点模板关联对象';

-- ----------------------------
-- Records of iot_device_template
-- ----------------------------
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('2', '112', '1');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('3', '118', '4');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('4', '120', '6');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('5', '121', '1');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('7', '123', '11');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('33', '119', '2');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('34', '121', '3');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('35', '122', '3');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('36', '125', '6');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('38', '127', '7');
INSERT INTO "iot_device_template" ("id", "product_id", "template_id") VALUES ('39', '128', '1');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_device_user
-- ----------------------------
DROP TABLE "iot_device_user";
CREATE TABLE "iot_device_user" (
  "device_id" NUMBER(20) NOT NULL,
  "user_id" NUMBER(20) NOT NULL,
  "tenant_id" NUMBER(20) NOT NULL,
  "tenant_name" NVARCHAR2(30) NOT NULL,
  "device_name" NVARCHAR2(64) NOT NULL,
  "phonenumber" NVARCHAR2(11),
  "user_name" NVARCHAR2(30) NOT NULL,
  "is_owner" NUMBER(4) NOT NULL,
  "perms" NVARCHAR2(255),
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "iot_device_user"."device_id" IS '设备ID';
COMMENT ON COLUMN "iot_device_user"."user_id" IS '用户ID';
COMMENT ON COLUMN "iot_device_user"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "iot_device_user"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "iot_device_user"."device_name" IS '设备名称';
COMMENT ON COLUMN "iot_device_user"."phonenumber" IS '手机号码';
COMMENT ON COLUMN "iot_device_user"."user_name" IS '用户昵称';
COMMENT ON COLUMN "iot_device_user"."is_owner" IS '是否为设备所有者（0=否，1=是）';
COMMENT ON COLUMN "iot_device_user"."perms" IS '用户物模型权限，多个以英文逗号分隔';
COMMENT ON COLUMN "iot_device_user"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "iot_device_user"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_device_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_device_user"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_device_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_device_user"."remark" IS '备注';
COMMENT ON TABLE "iot_device_user" IS '设备用户';

-- ----------------------------
-- Records of iot_device_user
-- ----------------------------
INSERT INTO "iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('108', '1', '1', 'admin', '★温湿度开关', '15888888888', 'admin', '1', NULL, '0', '', TO_DATE('2023-02-25 23:15:57', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('109', '1', '1', 'admin', '★网关设备', '15888888888', 'admin', '1', NULL, '0', '', TO_DATE('2023-02-25 23:17:32', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('109', '3', '1', 'admin', '★网关设备', '15888888881', 'fastbee-t2', '0', 'ota,timer,log,monitor,statistic,reset,gear,switch', '0', '', TO_DATE('2023-09-03 01:17:03', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-03 11:05:06', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('109', '7', '1', 'admin', '★网关设备', '18257292958', 'shenzehui', '0', NULL, '0', '', TO_DATE('2023-08-24 08:26:34', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('109', '8', '1', 'admin', '★网关设备', '15752221201', 'shadow', '0', NULL, '0', '', TO_DATE('2023-08-24 08:25:44', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('118', '1', '1', 'admin', '￥MODBUS网关设备', '15888888888', 'admin', '1', NULL, '0', '', TO_DATE('2023-02-28 16:49:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "iot_device_user" ("device_id", "user_id", "tenant_id", "tenant_name", "device_name", "phonenumber", "user_name", "is_owner", "perms", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('140', '1', '1', 'admin', '￥视频监控', '15888888888', 'admin', '1', NULL, '0', '', TO_DATE('2023-04-11 21:12:37', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_event_log
-- ----------------------------
DROP TABLE "iot_event_log";
CREATE TABLE "iot_event_log" (
  "log_id" NUMBER(20) NOT NULL,
  "identify" NVARCHAR2(64) NOT NULL,
  "model_name" NVARCHAR2(255),
  "log_type" NUMBER(4) NOT NULL,
  "log_value" NVARCHAR2(64) NOT NULL,
  "device_id" NUMBER(20),
  "device_name" NVARCHAR2(64),
  "serial_number" NVARCHAR2(64),
  "is_monitor" NUMBER(4) NOT NULL,
  "mode" NUMBER(4) NOT NULL,
  "user_id" NUMBER(20),
  "user_name" NVARCHAR2(30),
  "tenant_id" NUMBER(20),
  "tenant_name" NVARCHAR2(30),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "remark" NVARCHAR2(200)
)
;
COMMENT ON COLUMN "iot_event_log"."log_id" IS '设备事件日志ID';
COMMENT ON COLUMN "iot_event_log"."identify" IS '标识符';
COMMENT ON COLUMN "iot_event_log"."model_name" IS '物模型名称';
COMMENT ON COLUMN "iot_event_log"."log_type" IS '类型（3=事件上报，5=设备上线，6=设备离线）';
COMMENT ON COLUMN "iot_event_log"."log_value" IS '日志值';
COMMENT ON COLUMN "iot_event_log"."device_id" IS '设备ID';
COMMENT ON COLUMN "iot_event_log"."device_name" IS '设备名称';
COMMENT ON COLUMN "iot_event_log"."serial_number" IS '设备编号';
COMMENT ON COLUMN "iot_event_log"."is_monitor" IS '是否监测数据（1=是，0=否）';
COMMENT ON COLUMN "iot_event_log"."mode" IS '模式(1=影子模式，2=在线模式，3=其他)';
COMMENT ON COLUMN "iot_event_log"."user_id" IS '用户ID';
COMMENT ON COLUMN "iot_event_log"."user_name" IS '用户昵称';
COMMENT ON COLUMN "iot_event_log"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "iot_event_log"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "iot_event_log"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_event_log"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_event_log"."remark" IS '备注';
COMMENT ON TABLE "iot_event_log" IS '事件日志';

-- ----------------------------
-- Records of iot_event_log
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_function_log
-- ----------------------------
DROP TABLE "iot_function_log";
CREATE TABLE "iot_function_log" (
  "id" NUMBER(20) NOT NULL,
  "identify" NVARCHAR2(64) NOT NULL,
  "fun_type" NUMBER(11) NOT NULL,
  "fun_value" NVARCHAR2(64) NOT NULL,
  "message_id" NVARCHAR2(64),
  "device_name" NVARCHAR2(64),
  "serial_number" NVARCHAR2(64) NOT NULL,
  "mode" NUMBER(11),
  "user_id" NUMBER(20),
  "result_msg" NVARCHAR2(128),
  "result_code" NUMBER(11),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "remark" NVARCHAR2(128),
  "show_value" NVARCHAR2(255),
  "model_name" NVARCHAR2(64),
  "reply_time" DATE
)
;
COMMENT ON COLUMN "iot_function_log"."id" IS '设备功能日志ID';
COMMENT ON COLUMN "iot_function_log"."identify" IS '标识符';
COMMENT ON COLUMN "iot_function_log"."fun_type" IS '1==服务下发，2=属性获取，3.OTA升级';
COMMENT ON COLUMN "iot_function_log"."fun_value" IS '日志值';
COMMENT ON COLUMN "iot_function_log"."message_id" IS '消息id';
COMMENT ON COLUMN "iot_function_log"."device_name" IS '设备名称';
COMMENT ON COLUMN "iot_function_log"."serial_number" IS '设备编号';
COMMENT ON COLUMN "iot_function_log"."mode" IS '模式(1=影子模式，2=在线模式，3=其他)';
COMMENT ON COLUMN "iot_function_log"."user_id" IS '用户id';
COMMENT ON COLUMN "iot_function_log"."result_msg" IS '下发结果描述';
COMMENT ON COLUMN "iot_function_log"."result_code" IS '下发结果代码';
COMMENT ON COLUMN "iot_function_log"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_function_log"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_function_log"."remark" IS '备注';
COMMENT ON COLUMN "iot_function_log"."show_value" IS '显示值';
COMMENT ON COLUMN "iot_function_log"."model_name" IS '物模型名称';
COMMENT ON COLUMN "iot_function_log"."reply_time" IS '设备回复时间';
COMMENT ON TABLE "iot_function_log" IS '设备服务下发日志';

-- ----------------------------
-- Records of iot_function_log
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_group
-- ----------------------------
DROP TABLE "iot_group";
CREATE TABLE "iot_group" (
  "group_id" NUMBER(20) NOT NULL,
  "group_name" NVARCHAR2(64) NOT NULL,
  "group_order" NUMBER(4) NOT NULL,
  "user_id" NUMBER(20) NOT NULL,
  "user_name" NVARCHAR2(30) NOT NULL,
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "iot_group"."group_id" IS '分组ID';
COMMENT ON COLUMN "iot_group"."group_name" IS '分组名称';
COMMENT ON COLUMN "iot_group"."group_order" IS '分组排序';
COMMENT ON COLUMN "iot_group"."user_id" IS '用户ID';
COMMENT ON COLUMN "iot_group"."user_name" IS '用户昵称';
COMMENT ON COLUMN "iot_group"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "iot_group"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_group"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_group"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_group"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_group"."remark" IS '备注';
COMMENT ON TABLE "iot_group" IS '设备分组';

-- ----------------------------
-- Records of iot_group
-- ----------------------------
INSERT INTO "iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '卧室', '2', '1', 'admin', '0', '', TO_DATE('2021-12-29 13:12:42', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-04-09 22:37:06', 'SYYYY-MM-DD HH24:MI:SS'), '卧室设备');
INSERT INTO "iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', '厨房', '3', '1', 'admin', '0', '', TO_DATE('2021-12-29 13:12:59', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2021-12-29 13:13:48', 'SYYYY-MM-DD HH24:MI:SS'), '厨房设备');
INSERT INTO "iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('4', '书房', '4', '1', 'admin', '0', '', TO_DATE('2021-12-29 13:13:10', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2021-12-29 13:13:54', 'SYYYY-MM-DD HH24:MI:SS'), '书房设备');
INSERT INTO "iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('5', '卫生间', '5', '1', 'admin', '0', '', TO_DATE('2021-12-29 13:13:18', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2021-12-29 13:14:03', 'SYYYY-MM-DD HH24:MI:SS'), '卫生间设备');
INSERT INTO "iot_group" ("group_id", "group_name", "group_order", "user_id", "user_name", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('6', '走道', '6', '1', 'admin', '0', '', TO_DATE('2021-12-29 13:13:26', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2021-12-29 13:14:11', 'SYYYY-MM-DD HH24:MI:SS'), '走道设备');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_product
-- ----------------------------
DROP TABLE "iot_product";
CREATE TABLE "iot_product" (
  "product_id" NUMBER(20) NOT NULL,
  "product_name" NVARCHAR2(64) NOT NULL,
  "protocol_code" NVARCHAR2(64),
  "category_id" NUMBER(20) NOT NULL,
  "category_name" NVARCHAR2(64) NOT NULL,
  "tenant_id" NUMBER(20) NOT NULL,
  "tenant_name" NVARCHAR2(30) NOT NULL,
  "is_sys" NUMBER(4) NOT NULL,
  "is_authorize" NUMBER(4) NOT NULL,
  "mqtt_account" NVARCHAR2(64),
  "mqtt_password" NVARCHAR2(64),
  "mqtt_secret" NVARCHAR2(64),
  "status" NUMBER(4),
  "things_models_json" CLOB,
  "device_type" NUMBER(4),
  "network_method" NUMBER(4),
  "vertificate_method" NUMBER(4),
  "img_url" NVARCHAR2(255),
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500),
  "transport" NVARCHAR2(64)
)
;
COMMENT ON COLUMN "iot_product"."product_id" IS '产品ID';
COMMENT ON COLUMN "iot_product"."product_name" IS '产品名称';
COMMENT ON COLUMN "iot_product"."protocol_code" IS '协议编号';
COMMENT ON COLUMN "iot_product"."category_id" IS '产品分类ID';
COMMENT ON COLUMN "iot_product"."category_name" IS '产品分类名称';
COMMENT ON COLUMN "iot_product"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "iot_product"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "iot_product"."is_sys" IS '是否系统通用（0-否，1-是）';
COMMENT ON COLUMN "iot_product"."is_authorize" IS '是否启用授权码（0-否，1-是）';
COMMENT ON COLUMN "iot_product"."mqtt_account" IS 'mqtt账号';
COMMENT ON COLUMN "iot_product"."mqtt_password" IS 'mqtt密码';
COMMENT ON COLUMN "iot_product"."mqtt_secret" IS '产品秘钥';
COMMENT ON COLUMN "iot_product"."status" IS '状态（1-未发布，2-已发布）';
COMMENT ON COLUMN "iot_product"."things_models_json" IS '物模型JSON（属性、功能、事件）';
COMMENT ON COLUMN "iot_product"."device_type" IS '设备类型（1-直连设备、2-网关设备、3-监控设备）';
COMMENT ON COLUMN "iot_product"."network_method" IS '联网方式（1=wifi、2=蜂窝(2G/3G/4G/5G)、3=以太网、4=其他）';
COMMENT ON COLUMN "iot_product"."vertificate_method" IS '认证方式（1-简单认证、2-加密认证、3-简单+加密）';
COMMENT ON COLUMN "iot_product"."img_url" IS '图片地址';
COMMENT ON COLUMN "iot_product"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "iot_product"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_product"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_product"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_product"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_product"."remark" IS '备注';
COMMENT ON COLUMN "iot_product"."transport" IS '产品支持的传输协议';
COMMENT ON TABLE "iot_product" IS '产品';

-- ----------------------------
-- Records of iot_product
-- ----------------------------
INSERT INTO "iot_product" ("product_id", "product_name", "protocol_code", "category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "is_authorize", "mqtt_account", "mqtt_password", "mqtt_secret", "status", "things_models_json", "device_type", "network_method", "vertificate_method", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "transport") VALUES ('41', '智能开关产品', 'JSON', '1', '电工照明', '1', 'admin', '1', '0', 'FastBee', 'P47T6OD5IPFWHUM6', 'KX3TSH4Q4OS835DO', '2', '{"events": [{"id": "exception", "name": "设备发生异常", "type": 3, "order": 0, "regId": "exception", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "height_temperature", "name": "环境温度过高", "type": 3, "order": 0, "regId": "height_temperature", "isChart": 0, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}], "functions": [{"id": "report_monitor", "name": "上报数据", "type": 2, "order": 10, "regId": "report_monitor", "isChart": 0, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "type": 2, "order": 7, "regId": "message", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "type": 2, "order": 5, "regId": "light_color", "isChart": 0, "datatype": {"type": "array", "arrayType": "integer", "arrayCount": "3"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "type": 2, "order": 9, "regId": "switch", "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "reset", "name": "设备重启", "type": 2, "order": 6, "regId": "reset", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "irc", "name": "射频遥控", "type": 2, "order": 11, "regId": "irc", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "type": 2, "order": 8, "regId": "gear", "isChart": 0, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "status", "name": "上报状态", "type": 2, "order": 12, "regId": "status", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "properties": [{"id": "co2", "name": "二氧化碳", "type": 1, "order": 2, "regId": "co2", "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "brightness", "name": "室内亮度", "type": 1, "order": 4, "regId": "brightness", "isChart": 1, "datatype": {"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "temperature", "name": "空气温度", "type": 1, "order": 1, "regId": "temperature", "isChart": 1, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "humidity", "name": "空气湿度", "type": 1, "order": 3, "regId": "humidity", "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}]}', '1', '1', '3', NULL, '0', '', TO_DATE('2025-08-14 00:06:33', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-25 22:58:17', 'SYYYY-MM-DD HH24:MI:SS'), NULL, 'MQTT');
INSERT INTO "iot_product" ("product_id", "product_name", "protocol_code", "category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "is_authorize", "mqtt_account", "mqtt_password", "mqtt_secret", "status", "things_models_json", "device_type", "network_method", "vertificate_method", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "transport") VALUES ('55', '网关产品', 'JSON', '1', '电工照明', '1', 'admin', '1', '0', 'FastBee', 'P467433O1MT8MXS2', 'KWF32S3H95LH14LO', '2', '{"events": [{"id": "exception", "name": "设备发生异常", "type": 3, "order": 0, "regId": "exception", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "height_temperature", "name": "环境温度过高", "type": 3, "order": 0, "regId": "height_temperature", "isChart": 0, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}], "functions": [{"id": "color", "name": "状态灯色", "type": 2, "order": 0, "regId": "color", "isChart": 0, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "红色", "value": "0"}, {"text": "绿色", "value": "1"}, {"text": "蓝色", "value": "2"}, {"text": "黄色", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "type": 2, "order": 0, "regId": "message", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "type": 2, "order": 0, "regId": "light_color", "isChart": 0, "datatype": {"type": "array", "arrayType": "integer", "arrayCount": "3"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "type": 2, "order": 0, "regId": "switch", "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "irc", "name": "射频遥控", "type": 2, "order": 0, "regId": "irc", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "device", "name": "子设备", "type": 2, "order": 0, "regId": "device", "isChart": 0, "datatype": {"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "name": "设备开关", "order": 5, "datatype": {"type": "bool", "enumList": [{"text": "", "value": ""}], "trueText": "打开", "arrayType": "int", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "arrayType": "object", "arrayCount": 5}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "status", "name": "上报状态", "type": 2, "order": 0, "regId": "status", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group", "name": "功能分组", "type": 2, "order": 0, "regId": "group", "isChart": 0, "datatype": {"type": "object", "params": [{"id": "group_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "group_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isMonitor": 1, "isReadonly": 1}, {"id": "group_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isMonitor": 0, "isReadonly": 1}, {"id": "group_report_monitor", "name": "上报监测数据", "order": 7, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group_gear", "name": "运行档位", "order": 5, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "group_switch", "name": "设备开关", "order": 4, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "group_irc", "name": "红外遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}]}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "type": 2, "order": 0, "regId": "gear", "isChart": 0, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}], "properties": [{"id": "light_level", "name": "光照强度", "type": 1, "order": 0, "regId": "light_level", "isChart": 1, "datatype": {"max": 89.2, "min": 2.5, "step": 0.1, "type": "integer", "unit": "L/g"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "temperature", "name": "空气温度", "type": 1, "order": 0, "regId": "temperature", "isChart": 1, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "humidity", "name": "空气湿度", "type": 1, "order": 0, "regId": "humidity", "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}]}', '2', '2', '3', NULL, '0', '', TO_DATE('2025-02-25 22:51:39', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-16 11:46:43', 'SYYYY-MM-DD HH24:MI:SS'), NULL, 'MQTT');
INSERT INTO "iot_product" ("product_id", "product_name", "protocol_code", "category_id", "category_name", "tenant_id", "tenant_name", "is_sys", "is_authorize", "mqtt_account", "mqtt_password", "mqtt_secret", "status", "things_models_json", "device_type", "network_method", "vertificate_method", "img_url", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "transport") VALUES ('88', '视频监控产品', NULL, '2', '家居安防', '1', 'admin', '1', '0', 'FastBee', 'P0IB9M8A7J4R056V', 'K69914VL8175ZY21', '2', '{}', '3', '1', '3', NULL, '0', '', TO_DATE('2023-04-11 21:11:54', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2025-03-19 15:30:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, 'GB28181');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_product_authorize
-- ----------------------------
DROP TABLE "iot_product_authorize";
CREATE TABLE "iot_product_authorize" (
  "authorize_id" NUMBER(20) NOT NULL,
  "authorize_code" NVARCHAR2(32) NOT NULL,
  "product_id" NUMBER(20) NOT NULL,
  "device_id" NUMBER(20),
  "serial_number" NVARCHAR2(64),
  "user_id" NUMBER(20),
  "user_name" NVARCHAR2(30),
  "status" NUMBER(4),
  "del_flag" NCHAR(1) NOT NULL,
  "create_by" NVARCHAR2(64) NOT NULL,
  "create_time" DATE NOT NULL,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "iot_product_authorize"."authorize_id" IS '授权码ID';
COMMENT ON COLUMN "iot_product_authorize"."authorize_code" IS '授权码';
COMMENT ON COLUMN "iot_product_authorize"."product_id" IS '产品ID';
COMMENT ON COLUMN "iot_product_authorize"."device_id" IS '设备ID';
COMMENT ON COLUMN "iot_product_authorize"."serial_number" IS '设备编号';
COMMENT ON COLUMN "iot_product_authorize"."user_id" IS '用户ID';
COMMENT ON COLUMN "iot_product_authorize"."user_name" IS '用户名称';
COMMENT ON COLUMN "iot_product_authorize"."status" IS '状态（1-未使用，2-使用中）';
COMMENT ON COLUMN "iot_product_authorize"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "iot_product_authorize"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_product_authorize"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_product_authorize"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_product_authorize"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_product_authorize"."remark" IS '备注';
COMMENT ON TABLE "iot_product_authorize" IS '产品授权码表';

-- ----------------------------
-- Records of iot_product_authorize
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_protocol
-- ----------------------------
DROP TABLE "iot_protocol";
CREATE TABLE "iot_protocol" (
  "id" NUMBER(20) NOT NULL,
  "protocol_code" NVARCHAR2(60) NOT NULL,
  "protocol_name" NVARCHAR2(60) NOT NULL,
  "protocol_file_url" NVARCHAR2(500) NOT NULL,
  "protocol_type" NUMBER(11) NOT NULL,
  "jar_sign" NVARCHAR2(100) NOT NULL,
  "create_time" DATE NOT NULL,
  "update_time" DATE NOT NULL,
  "protocol_status" NUMBER(11) NOT NULL,
  "del_flag" NUMBER(11) NOT NULL
)
;
COMMENT ON COLUMN "iot_protocol"."id" IS '自增id';
COMMENT ON COLUMN "iot_protocol"."protocol_code" IS '协议编码';
COMMENT ON COLUMN "iot_protocol"."protocol_name" IS '协议名称';
COMMENT ON COLUMN "iot_protocol"."protocol_file_url" IS '协议jar包,js包，c程序上传地址';
COMMENT ON COLUMN "iot_protocol"."protocol_type" IS '协议类型 0:未知 1:jar，2.js,3.c';
COMMENT ON COLUMN "iot_protocol"."jar_sign" IS '协议文件摘要(文件的md5)';
COMMENT ON COLUMN "iot_protocol"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_protocol"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_protocol"."protocol_status" IS '0:草稿 1:启用 2:停用';
COMMENT ON COLUMN "iot_protocol"."del_flag" IS '0:正常 1:删除';
COMMENT ON TABLE "iot_protocol" IS '协议表';

-- ----------------------------
-- Records of iot_protocol
-- ----------------------------
INSERT INTO "iot_protocol" ("id", "protocol_code", "protocol_name", "protocol_file_url", "protocol_type", "jar_sign", "create_time", "update_time", "protocol_status", "del_flag") VALUES ('1', 'JSON', 'JSON协议', '/', '0', '系统内置JSON编解码协议', TO_DATE('2023-03-01 05:46:43', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-04-10 14:42:12', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_scene
-- ----------------------------
DROP TABLE "iot_scene";
CREATE TABLE "iot_scene" (
  "scene_id" NUMBER(20) NOT NULL,
  "scene_name" NVARCHAR2(64) NOT NULL,
  "chain_name" NVARCHAR2(32),
  "enable" NUMBER(4),
  "user_id" NUMBER(20) NOT NULL,
  "user_name" NVARCHAR2(64) NOT NULL,
  "silent_period" NUMBER(11),
  "cond" NUMBER(4),
  "execute_mode" NUMBER(4),
  "execute_delay" NUMBER(11),
  "has_alert" NUMBER(4),
  "application_name" NVARCHAR2(32) NOT NULL,
  "el_data" NCLOB,
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "iot_scene"."scene_id" IS '场景ID';
COMMENT ON COLUMN "iot_scene"."scene_name" IS '场景名称';
COMMENT ON COLUMN "iot_scene"."chain_name" IS '规则名称';
COMMENT ON COLUMN "iot_scene"."enable" IS '场景状态（1-启动，2-停止）';
COMMENT ON COLUMN "iot_scene"."user_id" IS '用户ID';
COMMENT ON COLUMN "iot_scene"."user_name" IS '用户名称';
COMMENT ON COLUMN "iot_scene"."silent_period" IS '静默周期（分钟）';
COMMENT ON COLUMN "iot_scene"."cond" IS '执行条件（1=或、任意条件，2=且、所有条件，3=非，不满足）';
COMMENT ON COLUMN "iot_scene"."execute_mode" IS '执行方式（1=串行，顺序执行，2=并行，同时执行）';
COMMENT ON COLUMN "iot_scene"."execute_delay" IS '延时执行（秒钟）';
COMMENT ON COLUMN "iot_scene"."has_alert" IS '是否包含告警推送（1=包含，2=不包含）';
COMMENT ON COLUMN "iot_scene"."application_name" IS '应用名称';
COMMENT ON COLUMN "iot_scene"."el_data" IS '规则数据';
COMMENT ON COLUMN "iot_scene"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_scene"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_scene"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_scene"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_scene"."remark" IS '备注';
COMMENT ON TABLE "iot_scene" IS '场景联动';

-- ----------------------------
-- Records of iot_scene
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_scene_script
-- ----------------------------
DROP TABLE "iot_scene_script";
CREATE TABLE "iot_scene_script" (
  "script_id" NVARCHAR2(32) NOT NULL,
  "scene_id" NUMBER(20) NOT NULL,
  "source" NUMBER(4) NOT NULL,
  "script_purpose" NUMBER(4) NOT NULL,
  "product_id" NUMBER(20),
  "product_name" NVARCHAR2(64),
  "id" NVARCHAR2(64),
  "name" NVARCHAR2(64),
  "value" NVARCHAR2(64),
  "operator" NVARCHAR2(16),
  "type" NUMBER(4),
  "device_count" NUMBER(11),
  "job_id" NUMBER(20),
  "cron_expression" NVARCHAR2(255),
  "is_advance" NUMBER(4),
  "parent_id" NVARCHAR2(32),
  "parent_name" NVARCHAR2(32),
  "array_index" NVARCHAR2(20),
  "array_index_name" NVARCHAR2(20),
  "create_by" NVARCHAR2(64),
  "create_time" DATE
)
;
COMMENT ON COLUMN "iot_scene_script"."script_id" IS '脚本ID';
COMMENT ON COLUMN "iot_scene_script"."scene_id" IS '场景ID';
COMMENT ON COLUMN "iot_scene_script"."source" IS '触发源（1=设备触发，2=定时触发，3=产品触发,4=告警执行）';
COMMENT ON COLUMN "iot_scene_script"."script_purpose" IS '脚本用途(1=数据流，2=触发器，3=执行动作)';
COMMENT ON COLUMN "iot_scene_script"."product_id" IS '产品ID（用于获取对应物模型）';
COMMENT ON COLUMN "iot_scene_script"."product_name" IS '产品名称';
COMMENT ON COLUMN "iot_scene_script"."id" IS '物模型标识符';
COMMENT ON COLUMN "iot_scene_script"."name" IS '物模型名称';
COMMENT ON COLUMN "iot_scene_script"."value" IS '物模型值';
COMMENT ON COLUMN "iot_scene_script"."operator" IS '操作符';
COMMENT ON COLUMN "iot_scene_script"."type" IS '物模型类别（1=属性，2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线）';
COMMENT ON COLUMN "iot_scene_script"."device_count" IS '设备数量';
COMMENT ON COLUMN "iot_scene_script"."job_id" IS '任务ID';
COMMENT ON COLUMN "iot_scene_script"."cron_expression" IS 'cron执行表达式';
COMMENT ON COLUMN "iot_scene_script"."is_advance" IS '是否详细corn表达式（1=是，0=否）';
COMMENT ON COLUMN "iot_scene_script"."parent_id" IS '父物模id';
COMMENT ON COLUMN "iot_scene_script"."parent_name" IS '父物模名称';
COMMENT ON COLUMN "iot_scene_script"."array_index" IS '数组索引';
COMMENT ON COLUMN "iot_scene_script"."array_index_name" IS '数组索引名称';
COMMENT ON COLUMN "iot_scene_script"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_scene_script"."create_time" IS '创建时间';
COMMENT ON TABLE "iot_scene_script" IS '场景脚本';

-- ----------------------------
-- Records of iot_scene_script
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_script
-- ----------------------------
DROP TABLE "iot_script";
CREATE TABLE "iot_script" (
  "script_id" NVARCHAR2(32) NOT NULL,
  "user_id" NUMBER(20) NOT NULL,
  "user_name" NVARCHAR2(30) NOT NULL,
  "scene_id" NUMBER(20) NOT NULL,
  "product_id" NUMBER(20),
  "product_name" NVARCHAR2(64),
  "script_event" NUMBER(4) NOT NULL,
  "script_action" NUMBER(4) NOT NULL,
  "script_purpose" NUMBER(4) NOT NULL,
  "script_order" NUMBER(4) NOT NULL,
  "application_name" NVARCHAR2(32) NOT NULL,
  "script_name" NVARCHAR2(64) NOT NULL,
  "script_data" NCLOB NOT NULL,
  "script_type" NCHAR(16) NOT NULL,
  "script_language" NVARCHAR2(16) NOT NULL,
  "enable" NUMBER(4) NOT NULL,
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "iot_script"."script_id" IS '脚本ID';
COMMENT ON COLUMN "iot_script"."user_id" IS '用户ID';
COMMENT ON COLUMN "iot_script"."user_name" IS '用户昵称';
COMMENT ON COLUMN "iot_script"."scene_id" IS '关联场景ID';
COMMENT ON COLUMN "iot_script"."product_id" IS '产品ID';
COMMENT ON COLUMN "iot_script"."product_name" IS '产品名称';
COMMENT ON COLUMN "iot_script"."script_event" IS '脚本事件(1=设备上报，2=平台下发，3=设备上线，4=设备离线)';
COMMENT ON COLUMN "iot_script"."script_action" IS '脚本动作(1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储)';
COMMENT ON COLUMN "iot_script"."script_purpose" IS '脚本用途(1=数据流，2=触发器，3=执行动作)';
COMMENT ON COLUMN "iot_script"."script_order" IS '脚本执行顺序，值越大优先级越高';
COMMENT ON COLUMN "iot_script"."application_name" IS '应用名，后端、规则和脚本要统一';
COMMENT ON COLUMN "iot_script"."script_name" IS '脚本名';
COMMENT ON COLUMN "iot_script"."script_data" IS '脚本数据';
COMMENT ON COLUMN "iot_script"."script_type" IS '脚本类型：
script=普通脚本，
switch_script=选择脚本，
if_script=条件脚本，
for_script=数量循环脚本，
while_script=条件循环，
break_script=退出循环脚本';
COMMENT ON COLUMN "iot_script"."script_language" IS '脚本语言（groovy | qlexpress | js | python | lua | aviator | java）';
COMMENT ON COLUMN "iot_script"."enable" IS '是否生效（0-不生效，1-生效）';
COMMENT ON COLUMN "iot_script"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "iot_script"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_script"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_script"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_script"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_script"."remark" IS '备注';
COMMENT ON TABLE "iot_script" IS '规则引擎脚本';

-- ----------------------------
-- Records of iot_script
-- ----------------------------
INSERT INTO "iot_script" ("script_id", "user_id", "user_name", "scene_id", "product_id", "product_name", "script_event", "script_action", "script_purpose", "script_order", "application_name", "script_name", "script_data", "script_type", "script_language", "enable", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('D1782337038486474752', '1', 'admin', '0', '41', '★智能开关产品', '1', '1', '1', '1', 'fastbee', '消息转发规则', 'import cn.hutool.json.JSONArray;
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
', 'script', 'groovy', '1', '0', '', TO_DATE('2024-04-22 17:13:59', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2024-04-23 15:32:43', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_social_platform
-- ----------------------------
DROP TABLE "iot_social_platform";
CREATE TABLE "iot_social_platform" (
  "social_platform_id" NUMBER(11) NOT NULL,
  "platform" NVARCHAR2(32) NOT NULL,
  "status" NCHAR(1) NOT NULL,
  "client_id" NVARCHAR2(100) NOT NULL,
  "secret_key" NVARCHAR2(100) NOT NULL,
  "redirect_uri" NVARCHAR2(120) NOT NULL,
  "del_flag" NCHAR(1) NOT NULL,
  "create_by" NVARCHAR2(64) NOT NULL,
  "create_time" DATE NOT NULL,
  "update_time" DATE,
  "update_by" NVARCHAR2(64),
  "remark" NVARCHAR2(500),
  "bind_uri" NVARCHAR2(128) NOT NULL,
  "redirect_login_uri" NVARCHAR2(128) NOT NULL,
  "error_msg_uri" NVARCHAR2(128) NOT NULL
)
;
COMMENT ON COLUMN "iot_social_platform"."social_platform_id" IS '第三方登录平台主键';
COMMENT ON COLUMN "iot_social_platform"."platform" IS '第三方登录平台';
COMMENT ON COLUMN "iot_social_platform"."status" IS ' 0:启用 ,1:禁用';
COMMENT ON COLUMN "iot_social_platform"."client_id" IS '第三方平台申请Id';
COMMENT ON COLUMN "iot_social_platform"."secret_key" IS '第三方平台密钥';
COMMENT ON COLUMN "iot_social_platform"."redirect_uri" IS '用户认证后跳转地址';
COMMENT ON COLUMN "iot_social_platform"."del_flag" IS '删除标记位(0代表存在，1代表删除)';
COMMENT ON COLUMN "iot_social_platform"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_social_platform"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_social_platform"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_social_platform"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_social_platform"."remark" IS '备注';
COMMENT ON COLUMN "iot_social_platform"."bind_uri" IS '绑定注册登录uri,http://localhost/login?bindId=';
COMMENT ON COLUMN "iot_social_platform"."redirect_login_uri" IS '跳转登录uri,http://localhost/login?loginId=';
COMMENT ON COLUMN "iot_social_platform"."error_msg_uri" IS '错误提示uri,http://localhost/login?errorId=';
COMMENT ON TABLE "iot_social_platform" IS '第三方登录平台控制';

-- ----------------------------
-- Records of iot_social_platform
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_social_user
-- ----------------------------
DROP TABLE "iot_social_user";
CREATE TABLE "iot_social_user" (
  "social_user_id" NUMBER(11) NOT NULL,
  "uuid" NVARCHAR2(64) NOT NULL,
  "source" NVARCHAR2(32) NOT NULL,
  "access_token" NVARCHAR2(255),
  "expire_in" NUMBER(11),
  "refresh_token" NVARCHAR2(255),
  "open_id" NVARCHAR2(100),
  "uid" NVARCHAR2(64),
  "access_code" NVARCHAR2(64),
  "union_id" NVARCHAR2(100),
  "scope" NVARCHAR2(64),
  "token_type" NVARCHAR2(64),
  "id_token" NVARCHAR2(64),
  "mac_algorithm" NVARCHAR2(64),
  "mac_key" NVARCHAR2(64),
  "code" NVARCHAR2(64),
  "oauth_token" NVARCHAR2(64),
  "oauth_token_secret" NVARCHAR2(64),
  "create_time" DATE NOT NULL,
  "create_by" NVARCHAR2(64) NOT NULL,
  "update_time" DATE,
  "update_by" NVARCHAR2(64),
  "del_flag" NCHAR(1) NOT NULL,
  "status" NCHAR(1) NOT NULL,
  "sys_user_id" NUMBER(11),
  "username" NVARCHAR2(64),
  "nickname" NVARCHAR2(64),
  "avatar" NVARCHAR2(256),
  "gender" NUMBER(4),
  "source_client" NVARCHAR2(64)
)
;
COMMENT ON COLUMN "iot_social_user"."social_user_id" IS '第三方系统用户表主键';
COMMENT ON COLUMN "iot_social_user"."uuid" IS '第三方系统的唯一ID';
COMMENT ON COLUMN "iot_social_user"."source" IS '第三方用户来源';
COMMENT ON COLUMN "iot_social_user"."access_token" IS '用户的授权令牌';
COMMENT ON COLUMN "iot_social_user"."expire_in" IS '第三方用户的授权令牌的有效期（部分平台可能没有）';
COMMENT ON COLUMN "iot_social_user"."refresh_token" IS '刷新令牌(部分平台可能没有)';
COMMENT ON COLUMN "iot_social_user"."open_id" IS '第三方用户的 open id（部分平台可能没有）';
COMMENT ON COLUMN "iot_social_user"."uid" IS '第三方用户的 ID(部分平台可能没有)';
COMMENT ON COLUMN "iot_social_user"."access_code" IS '个别平台的授权信息（部分平台可能没有）';
COMMENT ON COLUMN "iot_social_user"."union_id" IS '第三方用户的 union id(部分平台可能没有)';
COMMENT ON COLUMN "iot_social_user"."scope" IS '第三方用户授予的权限(部分平台可能没有)';
COMMENT ON COLUMN "iot_social_user"."token_type" IS '个别平台的授权信息（部分平台可能没有）';
COMMENT ON COLUMN "iot_social_user"."id_token" IS 'id token（部分平台可能没有）';
COMMENT ON COLUMN "iot_social_user"."mac_algorithm" IS '小米平台用户的附带属性（部分平台可能没有）';
COMMENT ON COLUMN "iot_social_user"."mac_key" IS '小米平台用户的附带属性(部分平台可能没有)';
COMMENT ON COLUMN "iot_social_user"."code" IS '用户的授权code（部分平台可能没有）';
COMMENT ON COLUMN "iot_social_user"."oauth_token" IS 'Twitter平台用户的附带属性(部分平台可能没有)';
COMMENT ON COLUMN "iot_social_user"."oauth_token_secret" IS 'Twitter平台用户的附带属性(部分平台可能没有)';
COMMENT ON COLUMN "iot_social_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_social_user"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_social_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_social_user"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_social_user"."del_flag" IS '删除标记位(0代表存在,2代表删除)';
COMMENT ON COLUMN "iot_social_user"."status" IS '绑定状态(0:未绑定,1:绑定)';
COMMENT ON COLUMN "iot_social_user"."sys_user_id" IS '用户ID';
COMMENT ON COLUMN "iot_social_user"."username" IS '用户名';
COMMENT ON COLUMN "iot_social_user"."nickname" IS '用户昵称';
COMMENT ON COLUMN "iot_social_user"."avatar" IS '用户头像';
COMMENT ON COLUMN "iot_social_user"."gender" IS '用户性别';
COMMENT ON COLUMN "iot_social_user"."source_client" IS '第三方用户来源客户端（web、app、小程序）';
COMMENT ON TABLE "iot_social_user" IS '第三方登录用户';

-- ----------------------------
-- Records of iot_social_user
-- ----------------------------
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('1', 'ojefY6BdTpoXOLjdpsFQXWixAG_Q', 'WECHAT_OPEN', '71_7qVQ56lx6qdC7mmArXFwQD8Nl6BTjayw4HJdfHdPoXS0sEHDffiSYa4k8dIK7XG7puk2asZ0s0Rj_Pk8ahqdDQICL4FumjWmXHm3ql2si-M', '7200', '71_rh7a79t0eJmC0JyJrQjABF3zZdkNhP7oAUm3Jj6Rk1skL_i4V3ITlM3ViYO0PA_NCKn9ba85pz2vttdloreR0lWmUxK-VOm3XaMt33vZ9a0', 'ojefY6BdTpoXOLjdpsFQXWixAG_Q', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-08-23 11:48:04', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-15 17:23:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '8', 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/dNibaEkibxjJZSffkH5gQKtCg0pqfz39PGbPcQ8IhADianIaEYqibvD2JhrxYLMeQexBGVR6VOl9MR4gtsYiaxEqPFA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('2', 'ojefY6Pny526TwBwsyfUhzBB_szg', 'WECHAT_OPEN', '71_HlBJGUovm8cvZoEljoFkrAbRXtqt3mWNqxEOfMGsse-2Sie51YjkfJQbrSZySyIsf9sYTIwXj7EjbPO5GciN_xqEsSRCzyG6qIvUvkyNIBs', '7200', '71_Bc5n4-MS-25vBkt8p8BAxeuAZBawwmx4ryi-KCJxzi0OKY73HinwKYRTPZaw08kXgpD6zToRAjqIoRuyt-mNwEgfeN50hW8Unk5NuK4Bdpo', 'ojefY6Pny526TwBwsyfUhzBB_szg', NULL, NULL, 'oL1Fu589vTytNQy2okIKQnKBUmRU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-08-24 08:22:53', 'SYYYY-MM-DD HH24:MI:SS'), 'System', NULL, NULL, '0', '0', NULL, '🌲', '🌲', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLTLicc0w6SgPWibR5Z92j9AdW9aC4QxuFjQcJXcekbjc13fkHD7iaZc7CwEHtUq9FQalub6vOZ46LZA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('3', 'ojefY6AZPO1PPy9K4tWd8xdLWUss', 'WECHAT_OPEN', '71_x8HU8YdqqKMXts7KJ3T0hLOvmlP5YIi0pkTQ9bLA8vRusmEEUQFKyBpbG2UAFRDMEJvpp6cKGh9EGkiRdj7zSA4aHP2r-luXHSkAhP7zyvU', '7200', '71_AFMUcIv8tP4PGiHrOwJVN0B8bpCGyKXuG8ZCDiVGF5zaG10MTTLTmTJXNHJHmZzs3h6X9kbLY8sukNk83uj3QI3_J5SGOtihOUNMa9g7Ir0', 'ojefY6AZPO1PPy9K4tWd8xdLWUss', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-08-24 09:41:51', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-08-24 10:36:16', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '0', '0', NULL, 'oh', 'oh', 'https://thirdwx.qlogo.cn/mmopen/vi_32/RNia2ASTn210r40Tb91yfWgmiaWXGPXF7rNnic5lkes9avGbZQ0365uZObT1JicIQpiba7MDuHicScKUxnYWWyTN5VAw/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('4', 'ojefY6JUjFaO7RBRqgcrRGLxPVFA', 'WECHAT_OPEN', '71_qkQqwgA9RYmL5oQASwBxwwR4loysQQc3YRqGJRJONSxpNrPLlLdNibDk5YINFYjfnCxwnhjVPQqhX7xHaGE_UZMX5e1JaWKCJdrgwP62LxY', '7200', '71_oEKp3JLiEtv5668rprSxidUBbcd30cZQ2Bbt_tL5XdWQX52Yb3po5t5ynFwlA4n-7dLt5rGR3E1FKb9Qw8Xso8SfSfF-4CBF9ZCjSxppIvI', 'ojefY6JUjFaO7RBRqgcrRGLxPVFA', NULL, NULL, 'oL1Fu55Rkr9A69wS6buTQz7zdkDc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-08-24 09:58:59', 'SYYYY-MM-DD HH24:MI:SS'), 'System', NULL, NULL, '0', '0', NULL, 'shadow 张', 'shadow 张', 'https://thirdwx.qlogo.cn/mmopen/vi_32/EcUsiaR4Y1WkyibJXHDEPAiazbERr1BXAnzZWjh2SiayuawoEaT0icDzL2dZtuu0ia6Z7AJZZbiaxDJb8iaJxTnyk7Xicgw/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('5', 'ojefY6I66aL78LElFNjsA_rY7JIE', 'WECHAT_OPEN', '71_sanZ8NfbnEANzqUTQQAY6CRoafcBaV1eS4KPtcAv_rkOlunJQyVeJJzFbXSge3QxsCvljt65TTpyiLSifSjADJdaSZGtKzhF7IXlo5km2Po', '7200', '71_JbHfJV6zy02mK8ZnCKA3Yyhe2upHOqeah6IeZxzO3CKVAcOqH7CGbsk9GFsK3bqDD1SF8jp05ncC8XfkzR5BS4A3s_QIQjt44bviFckymtE', 'ojefY6I66aL78LElFNjsA_rY7JIE', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-08-24 11:49:31', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-08-24 14:10:29', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '0', '0', NULL, '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/tgaqAZ2oTMAZfF4cHRPib77yOLRSv9ibPibQfkQiclB8kwBuicB3vDcLfTnfU6HWZRNRqjmSXjWYYY5fNdOAR8CSxzg/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('6', '71420ce6-5300-4495-92da-6d1a4a7e2fdd', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 09:32:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('7', '6ec4d0be-bde5-466b-b3cf-5b3736d15ba7', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 09:40:17', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('8', 'ac2d836d-29fe-4e01-9f3d-bc54d4168855', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 09:45:52', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('9', 'ef2510ab-8fdd-4433-b0ff-1b57ef2f0fa9', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 09:47:34', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('10', 'b7c2ee2f-d644-46b9-812d-104b1d122fe0', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 09:50:43', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('11', '214e90ab-5b09-4aec-a6d1-4100c21db1b6', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 09:51:42', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('12', 'a23aec75-40df-4878-b33f-a1aacc6b45f6', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 09:53:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('13', '37de2b33-e690-40f6-a981-fc7182503606', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:00:02', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('14', '8c1e964e-9bb8-4876-bc92-6a41faaf2097', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:09:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('15', 'a7b77ebb-0815-4983-b0ad-b9b2a37593ca', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:09:59', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('16', '0ee69f21-448a-420f-a092-68418ae96c01', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:10:34', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('17', '0c928db4-03b5-40c9-9971-3b13d39ba4b8', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:11:41', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('18', '8f0daa3d-f332-423b-ad37-95e740a109e8', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:12:44', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('19', 'd15e0ae9-f49d-4e55-9965-79e260e8ffd0', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:13:33', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('20', 'b4da93b9-21c7-4e76-937b-2162024a9c6c', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:14:37', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('21', 'a16423aa-99ce-427e-89cf-a9f13955acec', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:15:54', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('22', '7771c72d-741f-4f66-bec4-414471ebb5db', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:16:34', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('23', '9def0641-b670-45cc-8297-6c3171f12025', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:17:36', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('24', 'e8f70c8b-bc52-4b38-aaf7-6a8df9ffb8cd', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:18:23', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('25', 'a359a333-4348-4786-973e-f15b9fa6ce94', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:19:15', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('26', '061154f9-ac4b-4035-a549-cd602422427a', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:19:55', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('27', '10003d18-0b00-458d-966e-3a54b218c83b', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:21:18', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('28', '376f2a15-662d-4820-bb62-683dd555fdbf', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:24:01', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('29', 'd4e4fe18-1f99-4361-b509-e464fdc806a2', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:24:42', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('30', '7b37261c-b420-45d5-8cd0-7ab6e4787621', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:25:17', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('31', '7635bed2-0d6e-4924-b9d7-af0235fc2ecc', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:25:26', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('32', '6aa3715d-b3a6-4b12-8bb4-1fc3af297d99', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:26:09', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('33', '0222ba55-f5a8-4218-a23d-949ecc78c405', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:26:52', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('34', '0bb2118c-b365-4dae-943e-84e0f8dca104', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:27:50', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('35', '5c065548-d171-44b8-a5bb-b93db08b22b3', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:28:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('36', '79429286-c4c7-4db8-9902-6f10ffd26e06', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:28:53', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('37', '4eb61991-8715-427b-b6a1-6e479f3faafc', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:29:44', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('38', 'cbcf9cfb-109f-4806-9bd0-5e9a4ba0c108', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:30:33', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('39', '810f0806-21e0-487b-b2fe-c9d037b20c81', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:31:28', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('40', '7da601d4-765c-40bf-aa2d-96bdef88c9ff', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:32:23', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('41', 'e3e29354-d06b-4d18-b172-a86e563a20f1', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:33:16', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('42', 'c73ece08-7a9e-462f-ad04-e5a5ce05a8b5', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:33:47', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('43', '7b48faf5-b023-46d7-9332-8ead5d82895e', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:34:27', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('44', 'aa8db705-654d-43d9-8ec2-3b090bb9685d', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:35:18', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('45', 'b3f319a4-a4aa-48bd-9a43-ff03b09e9b0f', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('46', '297e229a-545e-47a1-8acd-85708430d78d', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:37:10', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('47', '74d77e94-a9c2-4fca-9b47-e1c7ea0ab419', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:37:45', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('48', '0a750c6d-2e14-4e12-bd11-5ae390b04451', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:57:10', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('49', '6b353153-2eb0-4916-ad83-f5465ccd4480', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 10:57:55', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('50', '10be370a-38e0-4de4-822b-e6b1a07f0ff2', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 11:47:28', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('51', '8634fc78-e8d0-447f-af90-51fd29536ae4', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 15:40:06', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('52', '4e49726d-9078-47de-8752-5fac79a5b9b1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 15:45:31', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('53', '77e28b94-5f6e-4dda-bc15-a411ce9423e8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 15:49:07', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('54', '17b87cd8-6a14-4834-9d9e-e4121d563079', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 15:53:20', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('55', 'b2b7ddc7-6e48-4f24-9d03-8c481b6fc165', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 15:57:00', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('56', 'c394c827-3f3f-42c3-88db-b5e3edc5a3e8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 15:58:51', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('57', '16bf6849-9619-4448-9b0f-1ad4a999e33f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 15:59:47', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('58', '8f19e5f6-e197-4b81-9585-ea3ea655dd2a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:01:56', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('59', '647ce6e6-5aa4-4504-80db-fb1df687c0b6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:03:22', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('60', '04f69ab8-5a84-495c-8dfa-7f19a1a32c63', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:05:03', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('61', '520bf6de-19a5-4b06-b905-6c61a37a1809', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:06:05', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('62', 'e70c584c-5d6f-4cdd-9d63-42606b21941f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:07:37', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('63', 'd85b3a8e-4917-470c-8412-9c7ccbdd26e6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:08:13', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('64', '21e06b88-33cd-4ddc-9d3e-22a0cc79d8ab', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:09:43', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('65', '70903b36-f5da-4784-8505-9e0ee7842a7c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:10:31', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('66', '4300b8fb-4d5a-4c83-b45f-f46de9070789', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:11:57', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('67', 'a83706e9-c606-4393-b46c-bd589102fa23', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:14:25', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('68', '03b705d7-cb9b-4176-ba52-82caee369ee5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:16:11', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('69', '9c1aa75d-0afe-4d9b-93a4-82ff51476b83', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:18:05', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('70', 'd5153a89-5dca-4ce1-b225-cdf1f06734b3', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:20:23', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('71', '6f0dc304-3697-4d5e-b6f5-dcae95c6037d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:23:43', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('72', '1a8d1436-b1fc-4648-8ef3-8986b200f609', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:25:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('73', '87c74066-e8db-4312-ba9c-8d4a58d65b88', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:26:02', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('74', '7c36eace-b7c5-405f-a2a1-b1fa95d7b526', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:26:36', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('75', '9147f792-55be-4ca6-824d-b8c4a42960b3', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:27:48', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('76', '2183b103-858d-4bb4-9111-83fc8ddf24c1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:34:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('77', '9594b67d-6651-4237-887d-ebadfabc8ca3', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:35:55', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('78', '60649e01-d220-4bbc-a21c-211ce67bd9a7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:36:29', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('79', '83aa1836-36c5-4e74-aebb-9263843ce8fa', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:36:41', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('80', 'd7dfb927-1f17-41f7-868b-6ee0b8ec2d2f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:40:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('81', '9898d830-f0f3-4dbd-a687-a49709b855de', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:42:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('82', 'e7a5b6b0-3e50-4892-b4cc-e628fb803be6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:43:31', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('83', '34454957-3dfd-4819-8930-46daf47d2f81', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:45:03', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('84', '384b5ce9-5bf7-43b0-950d-496737c3a8dd', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:45:37', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('85', 'dd6de292-124f-44e6-a0fd-057cfeed410c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:46:25', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('86', 'a370f0b0-fb7f-41cf-a4ed-eafb873cd50b', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:48:31', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('87', 'bfb06fff-b0bb-43a4-8cf0-bf4f4b3445f6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:50:00', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('88', '53634812-48d2-420a-9e3c-2ac032b5d9cc', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:50:52', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('89', '994f638f-cf08-4846-9630-94bb509ab7db', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:51:27', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('90', '76813df6-4bdd-4add-981e-8e782a3b772a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:52:16', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('91', 'df0c3f75-a865-4621-988d-ec494e9ea407', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:53:22', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('92', '07f1722d-d9d4-43f7-8f7e-81c6446d7b3f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:57:11', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('93', '1d91f1b5-a008-446a-ad12-3210e899c55d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:57:50', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('94', '9b0f8585-4432-401a-9ae1-f363a158a133', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:58:27', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('95', '33b73d87-df3c-41b4-8abc-d2c51bf4657e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 16:59:41', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('96', '08daa4b5-b5e0-4217-8249-d47928afcf82', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:02:57', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('97', 'a1d11647-2316-4636-85ce-a589084c383a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:03:27', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('98', 'c8579e89-0858-4ba7-9e00-f1ea2a208be8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:06:37', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('99', 'd3837059-b25b-4221-9fd0-aed6f958b8a0', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:07:15', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('100', 'a47efa4b-e840-4e07-a710-459fa9f01e5e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:08:43', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('101', 'dca0f5d4-df0f-4d95-830e-2ae8aa60a550', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:15:11', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('102', 'be678468-abc2-48db-b34d-47e81352bf5c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:16:49', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('103', 'ae4265e7-e192-46f5-8a9e-53d6ba6aee3e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:20:34', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('104', '232a0407-b8f0-40b2-bf70-b368aecc3f48', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:22:02', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('105', '09aa4d6e-471a-4890-98f1-85ec1f41d16d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:23:05', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('106', '6dc0c49c-29a6-4292-bb59-d19d3c7dc11f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:23:49', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('107', 'aafb9719-a7e3-4c25-be9f-150fbc4e345d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:25:22', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('108', 'ce799416-f0a8-4941-9f84-ff3bf5a5ae00', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:26:16', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('109', '38ad0b87-c569-4831-84ea-f45bfb1b06e6', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:28:00', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('110', 'a0ee9a9f-6f2f-49a2-80e1-f0976cb115d5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:28:16', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('111', '42b6c87d-a031-4f7e-8670-09672fd00239', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:29:40', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('112', '39812b97-1a6d-4255-ba0f-86e8e6150bf7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:29:55', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('113', '38df607a-72e4-45c5-9b9a-fda85114e7a8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:30:43', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('114', '3d1dbb97-c0d4-4790-9bd1-57d2a26c945e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:34:02', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('115', 'f9544196-41ca-4f54-926e-2f43bd5482ef', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:34:31', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('116', 'b954f7a1-e544-4ac1-a103-54cfbc9ce982', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:35:13', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('117', '53484323-65ce-4720-91e6-51f81741df2d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:36:26', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('118', 'cae0d43e-f1d9-427a-9e2e-a276848a9e6a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:37:04', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('119', '3d1dd8c7-2d3d-46c7-aec0-8aeae75bd53c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:38:24', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('120', 'd206b8cc-4663-4253-919c-eecbf4bdae2d', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:39:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('121', '30f22b8a-39f3-4088-a917-e7b0bb315d96', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:40:18', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('122', 'b58fa0aa-f173-4a25-b245-3eedae47c4bf', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:40:43', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('123', '6de207b2-2f61-465f-8e2d-7115220cfb0a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:41:10', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('124', 'a2734f2b-41c2-4b5c-a9e7-0301482c2db1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:42:30', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('125', '0142a300-7a9a-4a09-990e-f9d53363168c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:43:54', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('126', 'a1207e54-0e14-424a-a485-9a560bce8058', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:49:37', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('127', 'cd2425fc-dab4-4f73-bc61-1b9f43920801', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:51:55', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('128', 'ee27889d-4dbb-4ed0-8184-81d0c56cee06', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:53:38', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('129', 'd85434f8-c11b-438c-890e-8e5732f91a22', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:55:11', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('130', '0cff5da9-3cd4-4363-80be-c3cccb523a95', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:57:34', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('131', '58cf157e-c55c-4cf4-90ee-6f9546ea60de', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:58:23', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('132', '3ad40393-bdc1-4cc5-90cb-c40c45737c07', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 17:59:36', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('133', '268d0dec-0c8c-4017-adf0-c87c7a5705f5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:03:33', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('134', 'a925f086-1f57-4ffc-bb0b-656e27cac343', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:05:28', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('135', '0d344981-1748-4b0c-bd5e-38db0d9d4903', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:07:31', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('136', '545b520c-d306-4ae9-affa-ead01383de6b', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:07:44', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('137', '2cf65789-0d5a-4a04-a86b-71b4c4632fab', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:08:02', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('138', '69b4eb4c-89e3-4ff1-ba0a-ec181cfa269e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:11:22', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('139', 'eae37130-5acb-4a7c-a466-867202b5de22', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:12:07', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('140', '74471c0e-fb55-4545-b23a-944f56a01d9e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:13:54', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('141', '3dc79a1b-6974-4338-a05e-732a08c06d9f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:15:26', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('142', '1bb4277e-05dc-455a-86f1-a4d7a570a7c9', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:21:19', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('143', 'f6c85ba2-6d99-4509-9fce-e32762a3d9fc', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:25:01', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('144', '99f90484-cd36-4caf-b874-64cdec51c973', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:26:24', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('145', '254a881a-36c0-46a8-89c1-47ec0902cc1c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:28:43', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('146', '40814010-a24d-448f-9841-ea26f75e3d4f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:29:17', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('147', 'b9d31023-b415-4a05-88be-e8f6077ba1c1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-12 18:30:22', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('148', '8d98204f-cc93-4ae7-961a-ffc88f16ad22', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:02:29', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('149', 'cfa57e94-fa7b-4cd7-8b0e-f84c2a32517a', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:03:05', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('150', 'b0742424-3b90-4c92-91b6-da7d0c1042e4', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:04:31', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('151', '92fb0d86-db06-4bd2-88a6-2c5e5659c2dd', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:10:44', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('152', '157c9ab2-260f-4fc9-953c-244e66a416dc', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:14:04', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('153', '58250a3d-9d20-4c06-a161-b89a5cbe2205', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:17:25', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('154', '503ec9f6-9c51-494c-abe6-d2025b6d5de8', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:23:32', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('155', '7da9ee7e-00f1-400c-9e82-aa756d33c2f7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:25:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('156', '576eb582-a62f-4de4-a7c6-5a79d06a317e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:26:11', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('157', '35fe81bd-a801-411e-a588-83e2073b53d1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:36:01', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('158', '13cc3148-7818-4aae-b404-5aa5b21bcb43', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:37:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('159', 'c667755d-08bf-4575-8763-ece99a8d34ff', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:38:20', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('160', 'e9cb8b8f-0f5a-47f0-ac70-04b75341a2cd', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:40:18', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('161', '128cb9e9-52a8-4ecc-8b4f-14d0377a9bdb', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:41:53', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('162', 'e71e95b5-4d16-45d4-ad99-c719c971ee4f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:46:18', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('163', 'c22e9388-e8e1-4965-8689-67d614efa611', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:47:29', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('164', 'f3232bc6-a8d0-48c0-a08f-0f7ad79dfaa1', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:48:36', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('165', '0bd9b8c6-bfe6-41f3-80ad-2bad1f56348b', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:51:38', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('166', '4c04dbef-6f2d-48a7-a549-55089038e197', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:53:04', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('167', '2c3b82a0-1cdb-4ccf-80ec-41d49f5c1bcf', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:54:21', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('168', '20d05c1d-c3c2-4f89-8093-44b548165d42', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:55:38', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('169', '6364f00a-44f9-41c6-a462-1edf968fe4e5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 09:59:29', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('170', '6598c9c5-9e50-432c-aaa2-636e0e8d44f9', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:07:53', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('171', '3909b811-7a5a-46c1-b390-6d21d8857670', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:10:11', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('172', 'd3da6d29-b931-4f25-ba5b-bd091af19ff5', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:21:05', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('173', '11040fcd-6f8b-470b-aedc-1411b36165c7', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:23:34', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('174', 'c3ac6479-d9c2-4205-a257-abefe814a842', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:26:47', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('175', 'f0cf37ba-eeeb-44ea-a870-8bc74c079d5c', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:39:49', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('176', 'babe0cad-db0c-4f07-b478-89f8d89bc197', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:42:21', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('177', 'df2b5aae-e7da-4793-8f42-d7025855208e', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:46:08', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('178', '4b6bd295-aa7c-4549-b82f-fd0d8be4a439', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:49:22', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('179', '2e3ffaa3-d499-46a7-aa1b-b2ae27ef4d32', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:50:20', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('180', '8670c605-1b89-4448-9de3-e4d15a1b0bad', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:52:38', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('181', 'fc90c9b0-c5d1-41b2-be40-1ea9ee2e52f2', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:53:25', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('182', '4cb82fc7-e322-439d-bd49-59e22b4ba8de', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:55:25', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('183', '9d4f9fd7-0564-4128-be27-25030761f141', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 10:58:06', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('184', 'bfe86e54-30e8-4c0c-ae49-497863b73708', 'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 11:00:58', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('185', '89953f9b-30af-446c-9682-27358d8f4d76', 'WECHAT_OPEN_MOBILE', '72_1zj9L8T0iKDEqORM5reOYHBG3nL_5jbvb3TfFjGQqw5jv9-0YmI02SgOto6PZXZ7Y1R0o8nm5EeJc8bR8547MfZMBbICbasV2YDtW0XbfSQ', '7200', '72_0Ae6bzB8bTMtnrrfuHkNDN37ko1GEOTLsbqbE3tbQAXNHNd6n_7-HIie0v_zC_clqDr4mOmJBOtkvjCzVHDWW7OS0pAdoDUovfy2n-Y7WD8', 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 11:01:17', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/NEJsVswPcQnxDy3UBXcVGIpMwvn2FmJ6I1k5DoNZk0UcZwQEm7lCewbdneEEfCeVkVNXOIQOXw8evKBea5MBdA/132', '0', 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('186', '09277a77-53a8-4cf9-8396-0442d33166ab', 'WECHAT_OPEN_MOBILE', '72_StpVhV87sy7cSsbkVoOJyxCdtlD3JxcdxG5vO8vgZ1eR7C2mORJdxYynL9SJR__pD_rdt2IHbfcSIH2Fpw5wh-BVMu3TTKeESp6qD4Nl1go', '7200', '72_LbZu1ZoNlOHPoqHVRROZ_eGiaMHwqRE4dy3xa6QxpbvnlV5mfAiyyiI0wfUYcnCyruuudNtMlW50NBZNcAxBPeBu3TYILuhlA3rYzCgaNqo', 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 11:03:08', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', 'oh', 'oh', 'https://thirdwx.qlogo.cn/mmopen/vi_32/5M4DYfvJP2dlsqQVmiclkxeGZrnnMf7hj6ryUR35INtKBicn7Whq0oPCdcJfotYxslSPGH2d8s2exvIicu8FYDXicg/132', '0', 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('187', '79aca6b3-0552-4f19-8720-10efa034834f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-13 14:34:42', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('188', 'e4f08938-b416-4713-8c37-a157d006991f', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-14 12:03:46', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('189', '2392005b-1079-4e6b-9625-a295f5e482ec', 'WECHAT_OPEN_MOBILE', '72_Yg_G7_l9nv0ikzJ6Oe7h1q9bz5oU_cJ3TYUMhKxO2ZKudg1bYfhAYygNt95C_qRy_zqiAZVO8jYvxj89iQaRvl5dgKLJl4gAh2GZus6xYfw', '7200', '72_NWbKK4ucUpHoMmLTKSGxTKfMOau99ebYJoWHJkWtVndGLVB6SmwVSwOlavfbh1KHDKqh4RNw28FWl4SauyBCoicugrLnH528z3RyIqrYF9M', 'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, 'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-14 15:14:17', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/NEJsVswPcQnxDy3UBXcVGIpMwvn2FmJ6I1k5DoNZk0UcZwQEm7lCewbdneEEfCeVkVNXOIQOXw8evKBea5MBdA/132', '0', 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('190', '13fec398-b9a0-4a3f-b878-bc892a0104b0', 'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, 'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, 'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-14 15:15:04', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '6', NULL, NULL, NULL, NULL, 'wechat_open_mini_program');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('191', '338c3d89-a231-4b57-b5f0-cfe3d1f13850', 'WECHAT_OPEN_MOBILE', '72_4DWd6gR3GQIiXPpuagGrM5eILwEO4SfHWJIDwLMqp8I_2FJpBwdNL-Or9UhQ7T8BNKoV0GZ2lh9FaCHk_7LyABY3lmABBpee6Ok4W_KBX08', '7200', '72_iH1rgWvH35a-0O2aXSFSB9qWyXPF_JcChEpn-WFVeFzI1Scfw_1ZxhD8_tEZY5Wk5OMNCqh9WyOKBtO11pL0bUQIWyzYgoPiJHCA2NCrukw', 'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, 'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-14 15:34:45', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', 'oh', 'oh', 'https://thirdwx.qlogo.cn/mmopen/vi_32/5M4DYfvJP2dlsqQVmiclkxeGZrnnMf7hj6ryUR35INtKBicn7Whq0oPCdcJfotYxsla7j7Dvh5eWLLNxttY6gyYA/132', '0', 'wechat_open_mobile');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('192', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', 'WECHAT_OPEN', '72_1RLeJ9QnQYJkiMs87FTBBMoK5h9ISBM3XZtPLveA6IetBtyejnDk5c7f-p0mC1RTHLxMkjC-e9KfX8l2y-0XqCPKav_0R20C-Tzbw95wlt0', '7200', '72_lcw1_ihZeBiAUFq4YPt3gc10tRBDMMhLKEsV-f7fZrZkd8xK5-tKbRXaCZL-Cbf4QkPbxnCPWb4svWODgBKMjUXc7g4W4qEkqgNg-4zllss', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-14 17:16:47', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-15 17:23:12', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1', '1', '8', 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('193', 'bd40330e-9ff0-4c2b-ba00-ff2c3a9cf9e3', 'wechat_open_web', '72_pg1i2Xl9vrW288PCqZybI56qq3-2Yin1o8nvKFAPCRx9OaS8HxJNHUVb6xuG5j_fQdwMecInJYxUpvTTUlJ659DsFOVYrr4RBCTI0sAEqBU', NULL, '72_v0sNSaJQyj8XUCk1bRPIl0A7TB8n4pN0mC807o7YGbPVXugt7aId7RAyb2hi9gsvd0aX2R4vAW-BnDtCTHPm_Un_AkW-mM8SYc44JuxMhOg', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-14 17:30:40', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-15 17:23:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '8', 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('194', 'a8681dc9-f2cc-4316-a6a4-d8d43aa00e19', 'wechat_open_web', '72_44jRuqhWDZYQwgFJMFzJkNRKd3_w0m9npMlL7gv16EoEW2UZy6CbNfy_oSuhqMz28PnUHOJwAyC-Xv--LvNxSePhPu-K-FOajq-1BE10G2o', NULL, '72_wF_NsYq04JgoGpNVvq6EvbZjD7BDDz7XHpGfGA4bT61A_wf3ITbXSFhc57MJUwi_o-HhCfBJ9FnSEBu2nySYkDVTbQ457WZ-ZXDTkwo7OMc', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-14 18:13:09', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('195', '128d79bf-7573-40c6-bbca-ff5fcf2a0a71', 'wechat_open_web', '72_h2CaZanyW6eeDFw4jybBzdqYKIWBovGeEeB29G6WZEPDtZPiXANNrFRLEMmtd_HGLwv8YwqwBinOVTIxtrjwFcue_x_z9YJlgM5pfJFNHJA', NULL, '72_hK0QOqLAqq-5-0sbwA4_Kqs-nweY_HC0LTaprTL8n_nbZD8wwhPkil5b2-0Sk855gQ47NGTwczEAt-pCt8ZyZwkTEX0gtO6kcRp8Ajz2kew', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-14 18:13:47', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('196', '698dbf21-8b29-47fa-9946-19a82d067645', 'wechat_open_web', '72_smafRNdslVfgLL-x0nBV5JZO3jT_r3LJBwYw2HJQYpcGe7KKBSSYtIrqpsvVFY75Z7knhMefGlOf9r6s1sH9sjdmAq5EQAOCx2B5QexT3_U', NULL, '72_ongWXQyEHIhXich6claT-7BzZZJbTAb-0dlr245Ee8GO4I9MFplLxa9P5o8qGmgxWhh3h1HvpyYzCyIJ2xxMaS79GhdOhmv6ZJ0dyJN5tsI', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-14 18:49:36', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-15 17:23:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '8', 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('197', 'f0fd123d-b82a-4eb9-a67a-fb81db6b739d', 'wechat_open_web', '72_eexrzOvM96xPvH3Lsl7viBOtnBHFDzFJdIz1d074PJxOhAB9qY0HE-NxnWm67afHT0zphQ4RyVEM1BOohhE32HN_D5yZVcMh24oMrSCPJYg', NULL, '72_W25_phPvOFAfeASpx050O28_pOfgtW0LsnuWYQZI6LIrMeVJnju7FrLTG5xuYG_awhD7crWRzpd-guJs2gZ3ZBVj7bSRtwIgSvgVRfzG0zs', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-15 11:49:37', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-15 17:23:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '8', 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('198', '702797d1-04ef-4374-a618-aa2c3370135c', 'wechat_open_web', '72_BqSILWRpNzD35f9vkga9dMSHQp3bftJMa7eBpOXIepLh7zJVdBMUiPghVRz96hvtuCvvY7CryJtM5yuKx0tU4IJer4ZshmLHSw1Fl7jYtlo', NULL, '72_jJ0WZ-4r18IkeIs0YC6FfCS0QtCk9S5N1cqYeCIsKijORm2I1diDUE4zVLzYL5dUfxoVeUdHpYY8EyFBKQiWOzaGSECPPLw2bzQnigQzr-g', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-15 14:27:11', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('199', 'ebe3c9b0-6d17-4e7a-9d4b-a4d127e5f81e', 'wechat_open_web', '72_eahdqYL3gU93PJ1IWa6sIKwL4-XvLvCcMnkLYYI3au_8OQ2ZEwe5YHjnRKVzmXDkEfW_IUwCpSyGBLYaOS_ms4RfSI-TAH_s7lUnh_pwOpQ', NULL, '72_8RcuvSh7R88zZSjHyMfuROguXNJxl28CinaM0DMVnQdlvrLORUkT-ArLdWEY_ukrctsOppiY85xYUtZ8mRKit66-IMJauWckLptvbS6mVtk', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-15 16:14:33', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('200', 'a9865b55-498e-47e5-ab12-bfc028f9401a', 'wechat_open_web', '72_sDs8oTAz4diS5nsjQyO-y2aO2IXDYL0CkVFkHaA5gJDb1YCUqfmG9ejNR0-lsshtYwOOswE5s5hdIMkBXsUt_zuVK5nyTlJ3oi3sVrUEaP4', NULL, '72_Z9mP_wckNOwwmrA0eGB8lUB5CY23FvlLciZBegzfnyg10VW0GOe56QF0uM4rgtTha-kO7Uhasm2FIFdDdGKhriu8t1OYs2PEyYT-GOYauvA', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-15 16:16:30', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('201', '45ef2f02-0498-4a91-9b7e-7ec1fbba1f4f', 'wechat_open_web', '72_pj5qq79ny99dg-nnZztIDdBw6pxQUTOI7GC1-50zdFugMU3JhIUgoWKG_zISSOT63HSkuogl0GTSM7zV-7XaGRZoVvT3ks9e4No7qh4lmcM', NULL, '72_jJaohqyJXjiOai2Y1X2JGxinYVUpGYQhNrNRqRBEGDzY44zuPuNxJSIAvlXbJoZXwi57WfV2FxbLCfeUPCnBzypTR6MyAgnY7UBPzfnkO8E', 'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, 'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-15 17:22:53', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-15 17:23:12', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '8', 'shadow', 'shadow', 'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('202', '719938db-a623-427c-b0bb-f93ccc66e12e', 'wechat_open_web', '72_47aVnqUFSV_6B866IIt56eXQ4MCeaON9p6uNXDNd8tM9C1aDLc42MpMvPCh4gUJBr1CPk6W2BjaJdbp53mhvgJQ9mbVTHi3Rgt7S5lYa1uc', NULL, '72_ES4G1cNwL7SR5zxg7wSUtyh1JAMD3iHksu9PhfriYVa7BviNMKTBXq0XA92tRNDGTLbYyjpzXBsihDooqcYziiJjJNJZ8HV573kvdk5Js6g', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-15 18:01:00', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('203', '6c128697-f856-4cec-9b22-9c041e546aa9', 'wechat_open_web', '72_ouu4bb-uHrl6KXeQP_H_nI2cn0GBsiCAq4sJcwK0vEhi4DqPbvInOEpYwX1ljPsrxJ2a6iXf48A8SRDDT0G-jKPhs5qsI7MTUvylc3tIvIA', NULL, '72_8yFIgg2C-J3jomyS19ZQmPsNu_bwxoVe_pOjDQInuid5WH2SLBL5ul8NIXF4kFbBT5S1xDvQ9Wo0yGLgLg4kAwvGRRk2atyA9u85HLXRrCU', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-21 16:40:55', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('204', 'd78d0dfd-ea6a-419c-a95d-916f75ef8645', 'wechat_open_web', '72_In2RD2EUmBPN_cKpj_e_6WhSI0BFkOqOSGMAxPg8frEv3EExLiPv7H7p1VJFBoTXDRMUzxX4uBXJUanI3B38y2IO0T_T21WZWToph0Hqrfk', NULL, '72_ICxLSkfZYijpSu7nJwnOGVjwG0bLkwAlsKxMNYUAJF0O-hkVP44qlnSJjrEXvQ7tpId_-8uygb3EjfSYMBh1h5D-YtjYFTYgj-tQOcponpQ', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-21 16:48:25', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('205', '3057f429-575b-4116-b6c2-2be2ed0daa6a', 'wechat_open_web', '72_8RcuvSh7R88zZSjHyMfuRAU8ESiAbG5qYjyInId2yhXEwIsJ--rVPWI-ZuUTkJzBym4oNf7hFJtvwZWqv1S0H-poe26G0sU_ge92uPjC3J8', NULL, '72_j_d-U4TM9Uc6ZXfG_ckplSQX_umZya-Z-HssZe57QjB0rYvI0LP2nzWusHpAVu352zq7LXTNGd2X239O3wHqlPSJ9dstTukRWWYy3h0nnVQ', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-21 16:50:17', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('206', 'c0013cb3-7862-4477-b178-a1cf885ad278', 'wechat_open_web', '72_VO1uAiIQgD1l49wDcy5oqfq7Qp-e6qX8FDtdvgbGuib3T2JAZZrBC6wKunFue-O5fai49_Y2-Y_0NUldDAgGjFVGJ53FwA9sQH6W9yovX3Y', NULL, '72_ldWlbgKsd3GropvbdrgjzZMFOgKS8i8Cre678hFHSWlrGaQVjPR9WgRZftTWcQHA0vgDQM-wKERD7_LGC1qzKnxEeUPOH1cO_VztQ3ZCvM0', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-21 16:53:02', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('207', '243912df-6515-4821-a2d2-311869eb4b66', 'wechat_open_web', '72_nrEdUC4X_xkmBsNbtePmd4tyBTDyhAzb35Xp0ul9pUfRsMfG8GIVQrIvM-GIJXyvJ1n5BscRwmOKeZxxqfzKiQdq-WjWy0PVmKEJ7YV2p_8', NULL, '72_H4I7KKoI2DSFE3dSVXAzyGxz0OqTXT6d8kMvraXgA4nslgsCM6iLB_7d-aHGOhKjKOQbUAJb8-mOerc9YhfM1oPRb_nW4y1lvswt-QwXrRs', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-21 17:22:13', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('208', 'b14bbe72-eddb-4282-a42b-77281f61f27c', 'wechat_open_web', '72_eahdqYL3gU93PJ1IWa6sIHdTySn-4UB_nLAkQLGDSjY7CTMUE4EOSyKYEFSoZmq9Fs64RdAHCV3PJG4ifk_VlZaFkGopHrytcIScSIfyU6w', NULL, '72_8RcuvSh7R88zZSjHyMfuRKViN1EJKbd_ZCElj0V8epojZFlgv6LJZd_fBKE2hE3q9iUqj-0vPqndpMCdc-FfPUjbvDh4B5w1UtNv78wz1Ak', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-21 17:39:53', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('209', '56f25762-2dcc-4be2-a50e-934eac40e328', 'wechat_open_web', '72_GqYw5ylQK7W9nn_cd8keVairltJ1Fcyp9SsIORxMtkihL1iQecSo5Boclagxl-RXHnmdc7mo82DLkFkSqSTDn0JunfPAtAIyAZl5geONq88', NULL, '72_2PoE8DZBF2qybpGHXPHagdYdPtt3Un3YjomGW7pGF65KKYF8t-qd4scANEK1QguVv1ig6zEDvL7F7iFgNVGkkRTEicSq21-QyZ7jVul6J1Y', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-21 18:31:11', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
INSERT INTO "iot_social_user" ("social_user_id", "uuid", "source", "access_token", "expire_in", "refresh_token", "open_id", "uid", "access_code", "union_id", "scope", "token_type", "id_token", "mac_algorithm", "mac_key", "code", "oauth_token", "oauth_token_secret", "create_time", "create_by", "update_time", "update_by", "del_flag", "status", "sys_user_id", "username", "nickname", "avatar", "gender", "source_client") VALUES ('210', '3a8b4ac4-8e24-4b23-b850-8fca2d90794b', 'wechat_open_web', '72_jJ0WZ-4r18IkeIs0YC6FfDOthAf9UIUNqALqUbYzBMirZuUh48M4AcVlp0Pjy4KbdA_OA1sWvkL1XWAcLa-KtqM-g-gF8Bz9DBfVUwcKGMU', NULL, '72_qfKdEHN3PH23LcmUsUrXoUmO2EkXUtRStVV_j7RabNi8Kuj8mhZYao9fZYCs_m_djArcug96q0TgX2Nxxnkk8LFOYQ26ODl0fy8ZLW6WW9c', 'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, 'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TO_DATE('2023-09-22 09:06:39', 'SYYYY-MM-DD HH24:MI:SS'), 'System', TO_DATE('2023-09-22 09:07:14', 'SYYYY-MM-DD HH24:MI:SS'), 'System', '1', '1', '6', '🍎', '🍎', 'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, 'wechat_open_web');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_things_model
-- ----------------------------
DROP TABLE "iot_things_model";
CREATE TABLE "iot_things_model" (
  "model_id" NUMBER(20) NOT NULL,
  "model_name" NVARCHAR2(64) NOT NULL,
  "product_id" NUMBER(20) NOT NULL,
  "product_name" NVARCHAR2(64) NOT NULL,
  "tenant_id" NUMBER(20) NOT NULL,
  "tenant_name" NVARCHAR2(30) NOT NULL,
  "identifier" NVARCHAR2(32) NOT NULL,
  "type" NUMBER(4) NOT NULL,
  "datatype" NVARCHAR2(64) NOT NULL,
  "specs" CLOB,
  "is_chart" NUMBER(4) NOT NULL,
  "is_monitor" NUMBER(4) NOT NULL,
  "is_history" NUMBER(4),
  "is_readonly" NUMBER(4),
  "is_share_perm" NUMBER(4),
  "model_order" NUMBER(11),
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500),
  "temp_slave_id" NUMBER(20),
  "formula" NVARCHAR2(255),
  "reverse_formula" NVARCHAR2(255),
  "reg_addr" NUMBER(11),
  "bit_option" NVARCHAR2(255),
  "value_type" NVARCHAR2(64),
  "is_params" NUMBER(11),
  "quantity" NUMBER(11),
  "code" NVARCHAR2(255),
  "parse_type" NVARCHAR2(20)
)
;
COMMENT ON COLUMN "iot_things_model"."model_id" IS '物模型ID';
COMMENT ON COLUMN "iot_things_model"."model_name" IS '物模型名称';
COMMENT ON COLUMN "iot_things_model"."product_id" IS '产品ID';
COMMENT ON COLUMN "iot_things_model"."product_name" IS '产品名称';
COMMENT ON COLUMN "iot_things_model"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "iot_things_model"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "iot_things_model"."identifier" IS '标识符，产品下唯一';
COMMENT ON COLUMN "iot_things_model"."type" IS '模型类别（1-属性，2-功能，3-事件）';
COMMENT ON COLUMN "iot_things_model"."datatype" IS '数据类型（integer、decimal、string、bool、array、enum）';
COMMENT ON COLUMN "iot_things_model"."specs" IS '数据定义';
COMMENT ON COLUMN "iot_things_model"."is_chart" IS '是否图表展示（0-否，1-是）';
COMMENT ON COLUMN "iot_things_model"."is_monitor" IS '是否实时监测（0-否，1-是）';
COMMENT ON COLUMN "iot_things_model"."is_history" IS '是否历史存储（0-否，1-是）';
COMMENT ON COLUMN "iot_things_model"."is_readonly" IS '是否只读数据(0-否，1-是)';
COMMENT ON COLUMN "iot_things_model"."is_share_perm" IS '是否设备分享权限(0-否，1-是)';
COMMENT ON COLUMN "iot_things_model"."model_order" IS '排序，值越大，排序越靠前';
COMMENT ON COLUMN "iot_things_model"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "iot_things_model"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_things_model"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_things_model"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_things_model"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_things_model"."remark" IS '备注';
COMMENT ON COLUMN "iot_things_model"."temp_slave_id" IS '从机id';
COMMENT ON COLUMN "iot_things_model"."formula" IS '计算公式';
COMMENT ON COLUMN "iot_things_model"."reverse_formula" IS '控制公式';
COMMENT ON COLUMN "iot_things_model"."reg_addr" IS '寄存器地址值';
COMMENT ON COLUMN "iot_things_model"."bit_option" IS '位定义选项';
COMMENT ON COLUMN "iot_things_model"."value_type" IS '解析类型 1.数值 2.选项';
COMMENT ON COLUMN "iot_things_model"."is_params" IS '是否是计算参数';
COMMENT ON COLUMN "iot_things_model"."quantity" IS '读取寄存器数量';
COMMENT ON COLUMN "iot_things_model"."code" IS 'modbus功能码';
COMMENT ON COLUMN "iot_things_model"."parse_type" IS 'modbus解析类型';
COMMENT ON TABLE "iot_things_model" IS '物模型';

-- ----------------------------
-- Records of iot_things_model
-- ----------------------------
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('113', '设备开关', '41', '温湿度智能开关', '1', 'admin', 'switch', '2', 'bool', '{"type": "bool", "trueText": "打开", "falseText": "关闭"}', '0', '0', '1', '0', '0', '9', '0', NULL, TO_DATE('2022-08-14 00:06:53', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:43:43', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('125', '空气温度', '41', '温湿度智能开关', '1', 'admin', 'temperature', '1', 'decimal', '{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', '1', '1', '1', '1', '0', '1', '0', NULL, TO_DATE('2022-11-05 23:56:21', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:44:21', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('126', '空气湿度', '41', '温湿度智能开关', '1', 'admin', 'humidity', '1', 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}', '1', '1', '1', '1', '0', '3', '0', NULL, TO_DATE('2022-11-05 23:56:21', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:44:12', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('127', '二氧化碳', '41', '温湿度智能开关', '1', 'admin', 'co2', '1', 'integer', '{"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm"}', '1', '1', '1', '1', '0', '2', '0', NULL, TO_DATE('2022-11-05 23:56:21', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:44:17', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('128', '室内亮度', '41', '温湿度智能开关', '1', 'admin', 'brightness', '1', 'integer', '{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}', '1', '1', '1', '1', '0', '4', '0', NULL, TO_DATE('2022-11-05 23:56:21', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:44:08', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('129', '运行档位', '41', '温湿度智能开关', '1', 'admin', 'gear', '2', 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', '0', '0', '1', '0', '0', '8', '0', NULL, TO_DATE('2022-11-05 23:56:21', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:43:49', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('130', '灯光色值', '41', '温湿度智能开关', '1', 'admin', 'light_color', '2', 'array', '{"type": "array", "arrayType": "integer", "arrayCount": "3"}', '0', '0', '1', '0', '0', '5', '0', NULL, TO_DATE('2022-11-05 23:56:21', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-25 22:57:42', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('131', '屏显消息', '41', '温湿度智能开关', '1', 'admin', 'message', '2', 'string', '{"type": "string", "maxLength": 1024}', '0', '0', '1', '0', '0', '7', '0', NULL, TO_DATE('2022-11-05 23:56:21', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:43:54', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('132', '上报数据', '41', '温湿度智能开关', '1', 'admin', 'report_monitor', '2', 'integer', '{"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}', '0', '0', '0', '0', '0', '10', '0', NULL, TO_DATE('2022-11-05 23:56:21', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:43:38', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('134', '环境温度过高', '41', '温湿度智能开关', '1', 'admin', 'height_temperature', '3', 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', '0', '0', '1', '0', '0', '0', '0', NULL, TO_DATE('2022-11-05 23:56:29', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:44:25', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('135', '设备发生异常', '41', '温湿度智能开关', '1', 'admin', 'exception', '3', 'string', '{"type": "string", "maxLength": 1024}', '0', '0', '1', '0', '0', '0', '0', NULL, TO_DATE('2022-11-05 23:56:29', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 23:44:29', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('161', '子设备', '96', '网关产品', '1', 'admin', 'device', '1', 'array', '{"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1, "isSharePerm": 0}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "isChart": 0, "datatype": {"type": "enum", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "device_switch", "name": "设备开关", "order": 5, "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "isChart": 0, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "device_irc", "name": "射频遥控", "order": 1, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}], "arrayType": "object", "arrayCount": "5"}', '0', '0', '0', '0', '1', '10', '0', NULL, TO_DATE('2023-02-25 22:51:53', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-25 23:13:21', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('162', '功能分组', '96', '网关产品', '1', 'admin', 'category', '1', 'object', '{"type": "object", "params": [{"id": "category_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "category_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isHistory": 0, "isMonitor": 1, "isReadonly": 1}, {"id": "category_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 1}, {"id": "category_report_monitor", "name": "上报监测数据", "order": 7, "isChart": 0, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "category_gear", "name": "运行档位", "order": 5, "isChart": 0, "datatype": {"type": "enum", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "category_switch", "name": "设备开关", "order": 4, "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "category_irc", "name": "射频遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控配对", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}]}', '0', '0', '0', '0', '1', '9', '0', NULL, TO_DATE('2023-02-25 22:51:53', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-03 11:03:24', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('163', '空气温度', '96', '网关产品', '1', 'admin', 'temperature', '1', 'decimal', '{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', '1', '1', '1', '1', '0', '0', '0', NULL, TO_DATE('2023-02-25 22:52:16', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 16:08:03', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('164', '设备开关', '96', '网关产品', '1', 'admin', 'switch', '2', 'bool', '{"type": "bool", "trueText": "打开", "falseText": "关闭"}', '0', '0', '1', '0', '1', '8', '0', NULL, TO_DATE('2023-02-25 22:52:16', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-03 11:03:30', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('165', '运行档位', '96', '网关产品', '1', 'admin', 'gear', '2', 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', '0', '0', '1', '0', '1', '7', '0', NULL, TO_DATE('2023-02-25 22:52:16', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-03 11:03:41', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('166', '灯光色值', '96', '网关产品', '1', 'admin', 'light_color', '2', 'array', '{"type": "array", "arrayType": "integer", "arrayCount": "3"}', '0', '0', '1', '0', '0', '0', '0', NULL, TO_DATE('2023-02-25 22:52:16', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 16:08:09', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('167', '上报监测数据', '96', '网关产品', '1', 'admin', 'report_monitor', '2', 'integer', '{"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}', '0', '0', '1', '0', '1', '11', '0', NULL, TO_DATE('2023-02-25 22:52:16', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-03 11:03:11', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('168', '环境温度过高', '96', '网关产品', '1', 'admin', 'height_temperature', '3', 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', '0', '0', '1', '0', '0', '0', '0', NULL, TO_DATE('2023-02-25 22:52:16', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 16:08:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('169', '设备发生异常', '96', '网关产品', '1', 'admin', 'exception', '3', 'string', '{"type": "string", "maxLength": 1024}', '0', '0', '1', '0', '0', '0', '0', NULL, TO_DATE('2023-02-25 22:52:16', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-31 16:08:20', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('170', '屏显消息', '96', '网关产品', '1', 'admin', 'message', '2', 'string', '{"type": "string", "maxLength": 1024}', '0', '0', '1', '0', '1', '0', '0', NULL, TO_DATE('2023-02-25 22:52:35', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-03 11:03:55', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('171', '设备重启', '96', '网关产品', '1', 'admin', 'reset', '2', 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}', '0', '0', '1', '0', '1', '0', '0', NULL, TO_DATE('2023-02-25 22:52:35', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-03 11:03:48', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('174', '室内亮度', '96', '网关产品', '1', 'admin', 'brightness', '1', 'integer', '{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}', '1', '1', '1', '1', '0', '0', '0', NULL, TO_DATE('2023-02-26 00:56:39', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-03 10:40:55', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('175', '设备重启', '41', '智能开关', '1', 'admin', 'reset', '2', 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}', '0', '0', '1', '0', '0', '6', '0', NULL, TO_DATE('2023-02-26 02:20:40', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-04-01 23:40:05', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('385', '射频遥控', '41', '★智能开关', '1', 'admin', 'irc', '2', 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}', '0', '0', '1', '0', '0', '11', '0', 'admin', TO_DATE('2023-03-31 23:46:36', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-04-13 01:38:48', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('439', '上报状态', '41', '★智能开关产品', '1', 'admin', 'status', '2', 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}', '0', '0', '0', '0', '0', '12', '0', 'admin', TO_DATE('2023-04-13 01:39:31', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-04-13 01:39:42', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('493', '漏水值', '112', '★MODBUS协议产品', '1', 'admin', '0', '1', 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "度"}', '0', '0', '1', '0', '0', '0', '0', '', TO_DATE('2023-09-13 23:33:19', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '1', NULL, NULL, '0', NULL, NULL, NULL, '1', '3', 'ushort');
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('494', '温度', '112', '★MODBUS协议产品', '1', 'admin', '0', '1', 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "°"}', '0', '0', '1', '0', '0', '0', '0', '', TO_DATE('2023-09-13 23:33:19', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '2', NULL, NULL, '0', NULL, NULL, NULL, '1', '3', 'ushort');
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('495', '电量', '112', '★MODBUS协议产品', '1', 'admin', '1', '1', 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": ""}', '0', '0', '1', '0', '0', '0', '0', '', TO_DATE('2023-09-13 23:33:19', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '11', NULL, NULL, '1', NULL, NULL, NULL, '1', '3', 'ushort');
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('496', '光照强度', '55', '网关产品', '1', 'admin', 'light_level', '1', 'integer', '{"max": 89.2, "min": 2.5, "step": 0.1, "type": "integer", "unit": "L/g"}', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('497', '状态灯色', '55', '网关产品', '1', 'admin', 'color', '2', 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "红色", "value": "0"}, {"text": "绿色", "value": "1"}, {"text": "蓝色", "value": "2"}, {"text": "黄色", "value": "3"}]}', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('498', '子设备', '55', '网关产品', '1', 'admin', 'device', '2', 'array', '{"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "name": "设备开关", "order": 5, "datatype": {"type": "bool", "enumList": [{"text": "", "value": ""}], "trueText": "打开", "arrayType": "int", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "arrayType": "object", "arrayCount": 5}', '0', '0', '0', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('499', '功能分组', '55', '网关产品', '1', 'admin', 'group', '2', 'object', '{"type": "object", "params": [{"id": "group_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "group_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isMonitor": 1, "isReadonly": 1}, {"id": "group_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isMonitor": 0, "isReadonly": 1}, {"id": "group_report_monitor", "name": "上报监测数据", "order": 7, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group_gear", "name": "运行档位", "order": 5, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "group_switch", "name": "设备开关", "order": 4, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "group_irc", "name": "红外遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}]}', '0', '0', '0', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('500', '射频遥控', '55', '网关产品', '1', 'admin', 'irc', '2', 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('501', '上报状态', '55', '网关产品', '1', 'admin', 'status', '2', 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}', '0', '0', '0', '0', '1', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('502', '运行档位', '55', '网关产品', '1', 'admin', 'gear', '2', 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:21', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('503', '灯光色值', '55', '网关产品', '1', 'admin', 'light_color', '2', 'array', '{"type": "array", "arrayType": "integer", "arrayCount": "3"}', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:21', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('504', '屏显消息', '55', '网关产品', '1', 'admin', 'message', '2', 'string', '{"type": "string", "maxLength": 1024}', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:21', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('505', '环境温度过高', '55', '网关产品', '1', 'admin', 'height_temperature', '3', 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:21', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('506', '设备发生异常', '55', '网关产品', '1', 'admin', 'exception', '3', 'string', '{"type": "string", "maxLength": 1024}', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:21', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('507', '空气温度', '55', '网关产品', '1', 'admin', 'temperature', '1', 'decimal', '{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('508', '空气湿度', '55', '网关产品', '1', 'admin', 'humidity', '1', 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model" ("model_id", "model_name", "product_id", "product_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "parse_type") VALUES ('509', '设备开关', '55', '网关产品', '1', 'admin', 'switch', '2', 'bool', '{"type": "bool", "trueText": "打开", "falseText": "关闭"}', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2025-03-19 16:32:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for iot_things_model_template
-- ----------------------------
DROP TABLE "iot_things_model_template";
CREATE TABLE "iot_things_model_template" (
  "template_id" NUMBER(20) NOT NULL,
  "template_name" NVARCHAR2(64) NOT NULL,
  "tenant_id" NUMBER(20) NOT NULL,
  "tenant_name" NVARCHAR2(30) NOT NULL,
  "identifier" NVARCHAR2(32) NOT NULL,
  "type" NUMBER(4) NOT NULL,
  "datatype" NVARCHAR2(64) NOT NULL,
  "specs" CLOB,
  "is_sys" NUMBER(4) NOT NULL,
  "is_chart" NUMBER(4) NOT NULL,
  "is_monitor" NUMBER(4) NOT NULL,
  "is_history" NUMBER(4) NOT NULL,
  "is_readonly" NUMBER(4),
  "is_share_perm" NUMBER(4),
  "model_order" NUMBER(11),
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500),
  "temp_slave_id" NVARCHAR2(20),
  "formula" NVARCHAR2(255),
  "reverse_formula" NVARCHAR2(255),
  "reg_addr" NUMBER(11),
  "bit_option" NVARCHAR2(255),
  "value_type" NVARCHAR2(64),
  "is_params" NUMBER(11),
  "quantity" NUMBER(11),
  "code" NVARCHAR2(255),
  "old_identifier" NVARCHAR2(10),
  "old_temp_slave_id" NVARCHAR2(10),
  "parse_type" NVARCHAR2(20)
)
;
COMMENT ON COLUMN "iot_things_model_template"."template_id" IS '物模型ID';
COMMENT ON COLUMN "iot_things_model_template"."template_name" IS '物模型名称';
COMMENT ON COLUMN "iot_things_model_template"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "iot_things_model_template"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "iot_things_model_template"."identifier" IS '标识符，产品下唯一';
COMMENT ON COLUMN "iot_things_model_template"."type" IS '模型类别（1-属性，2-功能，3-事件）';
COMMENT ON COLUMN "iot_things_model_template"."datatype" IS '数据类型（integer、decimal、string、bool、array、enum）';
COMMENT ON COLUMN "iot_things_model_template"."specs" IS '数据定义';
COMMENT ON COLUMN "iot_things_model_template"."is_sys" IS '是否系统通用（0-否，1-是）';
COMMENT ON COLUMN "iot_things_model_template"."is_chart" IS '是否图表展示（0-否，1-是）';
COMMENT ON COLUMN "iot_things_model_template"."is_monitor" IS '是否实时监测（0-否，1-是）';
COMMENT ON COLUMN "iot_things_model_template"."is_history" IS '是否历史存储 (0-否，1-是）';
COMMENT ON COLUMN "iot_things_model_template"."is_readonly" IS '是否只读数据(0-否，1-是)';
COMMENT ON COLUMN "iot_things_model_template"."is_share_perm" IS '是否设备分享权限(0-否，1-是)';
COMMENT ON COLUMN "iot_things_model_template"."model_order" IS '排序，值越大，排序越靠前';
COMMENT ON COLUMN "iot_things_model_template"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "iot_things_model_template"."create_by" IS '创建者';
COMMENT ON COLUMN "iot_things_model_template"."create_time" IS '创建时间';
COMMENT ON COLUMN "iot_things_model_template"."update_by" IS '更新者';
COMMENT ON COLUMN "iot_things_model_template"."update_time" IS '更新时间';
COMMENT ON COLUMN "iot_things_model_template"."remark" IS '备注';
COMMENT ON COLUMN "iot_things_model_template"."temp_slave_id" IS '从机id';
COMMENT ON COLUMN "iot_things_model_template"."formula" IS '计算公式';
COMMENT ON COLUMN "iot_things_model_template"."reverse_formula" IS '控制公式';
COMMENT ON COLUMN "iot_things_model_template"."reg_addr" IS '寄存器地址值';
COMMENT ON COLUMN "iot_things_model_template"."bit_option" IS '位定义选项';
COMMENT ON COLUMN "iot_things_model_template"."value_type" IS '解析类型 1.数值 2.选项';
COMMENT ON COLUMN "iot_things_model_template"."is_params" IS '是否是计算参数,默认否 0=否，1=是';
COMMENT ON COLUMN "iot_things_model_template"."quantity" IS '读取寄存器数量';
COMMENT ON COLUMN "iot_things_model_template"."code" IS 'modbus功能码';
COMMENT ON COLUMN "iot_things_model_template"."old_identifier" IS '旧的标识符';
COMMENT ON COLUMN "iot_things_model_template"."old_temp_slave_id" IS '旧的从机id';
COMMENT ON COLUMN "iot_things_model_template"."parse_type" IS 'modbus解析类型';
COMMENT ON TABLE "iot_things_model_template" IS '物模型模板';

-- ----------------------------
-- Records of iot_things_model_template
-- ----------------------------
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('1', '空气温度', '1', 'admin', 'temperature', '1', 'decimal', '{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', '1', '1', '1', '1', '1', '0', '4', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:12:06', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('2', '空气湿度', '1', 'admin', 'humidity', '1', 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}', '1', '1', '1', '1', '1', '0', '3', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:12:02', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('3', '二氧化碳', '1', 'admin', 'co2', '1', 'integer', '{"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm"}', '1', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:57', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('4', '室内亮度', '1', 'admin', 'brightness', '1', 'integer', '{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}', '1', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:53', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('5', '设备开关', '1', 'admin', 'switch', '2', 'bool', '{"type": "bool", "trueText": "打开", "falseText": "关闭"}', '1', '0', '0', '1', '0', '0', '5', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:48', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('6', '运行档位', '1', 'admin', 'gear', '2', 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', '1', '0', '0', '1', '0', '0', '6', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:43', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('7', '灯光色值', '1', 'admin', 'light_color', '2', 'array', '{"type": "array", "arrayType": "integer", "arrayCount": "3"}', '1', '0', '0', '1', '0', '0', '2', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:38', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('8', '屏显消息', '1', 'admin', 'message', '2', 'string', '{"type": "string", "maxLength": 1024}', '1', '0', '0', '1', '0', '0', '1', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:32', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('9', '上报监测数据', '1', 'admin', 'report_monitor', '2', 'integer', '{"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}', '1', '0', '0', '0', '0', '0', '9', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:25', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('10', '环境温度过高', '1', 'admin', 'height_temperature', '3', 'decimal', '{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', '1', '0', '0', '1', '0', '0', '8', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:19', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('11', '设备发生异常', '1', 'admin', 'exception', '3', 'string', '{"type": "string", "maxLength": 1024}', '1', '0', '0', '1', '0', '0', '7', '0', 'admin', TO_DATE('2022-03-09 17:41:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:16', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('12', '光照', '1', 'admin', 'light', '1', 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', '0', '1', '1', '1', '1', '0', '0', '0', 'wumei', TO_DATE('2022-05-07 09:41:17', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:12', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('13', '压力', '1', 'admin', 'pressure', '1', 'decimal', '{"max": 200, "min": 0, "step": 0.1, "type": "decimal", "unit": "帕斯卡"}', '1', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2023-02-20 22:39:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:05', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('14', '设备重启', '1', 'admin', 'reset', '2', 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}', '1', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2023-02-20 23:15:25', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:11:08', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('15', '电池电压', '1', 'admin', 'voltage', '1', 'decimal', '{"max": 5, "min": 0, "step": 0.001, "type": "decimal", "unit": "V"}', '1', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2023-02-20 23:17:43', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:10:56', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('16', '饮水量', '1', 'admin', 'shuiliang', '1', 'integer', '{"max": 500, "min": 80, "step": 1, "type": "integer", "unit": "ML"}', '1', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2023-02-20 23:18:39', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:10:52', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('17', '灯光', '1', 'admin', 'light', '1', 'integer', '{"max": 1000, "min": 0, "step": 1, "type": "integer", "unit": "Lux"}', '1', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2023-02-20 23:19:23', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:10:49', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('18', '长度', '1', 'admin', 'length', '1', 'integer', '{"max": 2000, "min": 1, "step": 5, "type": "integer", "unit": "M"}', '1', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2023-02-20 23:20:03', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:10:44', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('19', '心率', '1', 'admin', 'heart_rate', '1', 'integer', '{"max": 250, "min": 0, "step": 1, "type": "integer", "unit": "次数"}', '1', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2023-02-20 23:21:46', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:12:40', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('20', '光照强度', '1', 'admin', 'light_level', '1', 'integer', '{"max": 89.2, "min": 2.5, "step": 0.1, "type": "integer", "unit": "L/g"}', '1', '1', '1', '1', '1', '0', '0', '0', 'admin', TO_DATE('2023-02-20 23:24:36', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:10:35', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('21', '状态灯色', '1', 'admin', 'color', '2', 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "红色", "value": "0"}, {"text": "绿色", "value": "1"}, {"text": "蓝色", "value": "2"}, {"text": "黄色", "value": "3"}]}', '1', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2023-02-20 23:26:24', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:10:32', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('22', '子设备', '1', 'admin', 'device', '2', 'array', '{"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "name": "设备开关", "order": 5, "datatype": {"type": "bool", "enumList": [{"text": "", "value": ""}], "trueText": "打开", "arrayType": "int", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "arrayType": "object", "arrayCount": 5}', '1', '0', '0', '0', '0', '0', '10', '0', 'admin', TO_DATE('2023-02-24 01:10:43', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-13 01:33:38', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('23', '功能分组', '1', 'admin', 'group', '2', 'object', '{"type": "object", "params": [{"id": "group_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "group_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isMonitor": 1, "isReadonly": 1}, {"id": "group_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isMonitor": 0, "isReadonly": 1}, {"id": "group_report_monitor", "name": "上报监测数据", "order": 7, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group_gear", "name": "运行档位", "order": 5, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "group_switch", "name": "设备开关", "order": 4, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "group_irc", "name": "红外遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}]}', '1', '0', '0', '0', '0', '0', '11', '0', 'admin', TO_DATE('2023-02-25 22:41:43', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-08-30 15:29:34', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('201', '频率 ', '1', 'admin', 'frequency', '2', 'integer', '{"max": 65535, "min": 0, "step": 1, "type": "integer", "unit": "0.001Hz"}', '1', '0', '0', '1', '0', '0', '0', '0', '', TO_DATE('2023-02-28 16:08:06', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 03:37:11', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '3#3', '%s*0.001', '', '27', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('225', '校验位', '1', 'admin', 'check', '2', 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "N", "value": "0"}, {"text": "O", "value": "1"}, {"text": "E", "value": "2"}]}', '1', '0', '0', '1', '1', '0', '0', '0', '', TO_DATE('2023-02-28 16:08:08', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 21:36:01', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '3#3', '', '', '771', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('226', '波特率', '1', 'admin', 'baud', '2', 'enum', '{"type": "enum", "showWay": "select", "enumList": [{"text": "1200", "value": "0"}, {"text": "2400", "value": "1"}, {"text": "4800", "value": "2"}, {"text": "9600", "value": "3"}, {"text": "19200", "value": "4"}]}', '1', '0', '0', '1', '1', '0', '0', '0', '', TO_DATE('2023-02-28 16:08:09', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 03:37:32', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '3#3', '', '', '772', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('227', '电压', '1', 'admin', 'voltage', '1', 'integer', '{"max": 6, "min": 0.1, "step": 0.1, "type": "integer", "unit": "v"}', '1', '1', '1', '1', '1', '0', '0', '0', '', TO_DATE('2023-02-28 16:08:09', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 03:37:16', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '3#3', '', '', '773', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('236', '射频遥控', '1', 'admin', 'irc', '2', 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}', '1', '0', '0', '1', '0', '0', '0', '0', 'admin', TO_DATE('2023-03-31 23:46:20', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-10 01:09:46', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('250', '漏水值', '1', 'admin', '0', '1', 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "度"}', '1', '0', '0', '1', '0', '0', '0', '0', '', TO_DATE('2023-04-11 22:35:36', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-13 23:32:34', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1#1', NULL, NULL, '0', NULL, NULL, NULL, '1', '3', NULL, NULL, 'ushort');
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('251', '温度', '1', 'admin', '0', '1', 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "°"}', '1', '0', '0', '1', '0', '0', '0', '0', '', TO_DATE('2023-04-11 22:36:10', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-13 23:32:51', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1#2', NULL, NULL, '0', NULL, NULL, NULL, '1', '3', NULL, NULL, 'ushort');
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('252', '电量', '1', 'admin', '1', '1', 'integer', '{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": ""}', '1', '0', '0', '1', '0', '0', '0', '0', '', TO_DATE('2023-04-11 22:36:27', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-13 23:33:11', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '1#11', NULL, NULL, '1', NULL, NULL, NULL, '1', '3', NULL, NULL, 'ushort');
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('323', '上报状态', '1', 'admin', 'status', '2', 'enum', '{"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}', '1', '0', '0', '0', '0', '1', '0', '0', 'admin', TO_DATE('2023-04-13 01:35:42', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-03 10:50:16', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('324', 'X位移', '1', 'admin', 'x-shift', '1', 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', '1', '1', '1', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-26 19:36:58', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('325', 'Y位移', '1', 'admin', 'y-shift', '1', 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', '1', '1', '1', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-26 19:37:23', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-26 19:37:32', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('326', 'X位移', '1', 'admin', 'x-shift', '1', 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', '1', '1', '1', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-26 19:38:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('327', 'Y位移', '1', 'admin', 'y-shift', '1', 'decimal', '{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', '1', '1', '1', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-26 19:38:51', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('328', '计件数量', '1', 'admin', '0', '1', 'integer', '{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": ""}', '1', '0', '0', '0', '1', '0', '0', '0', '', TO_DATE('2023-08-28 15:05:25', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '3#1', NULL, NULL, '0', NULL, NULL, NULL, '1', '3', NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('329', '参数1', '1', 'admin', '0', '1', 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', '1', '0', '0', '0', '1', '0', '0', '0', '', TO_DATE('2023-08-28 15:06:55', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '3#2', NULL, NULL, '0', NULL, NULL, NULL, '1', '3', NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('330', '图片', '1', 'admin', 'image', '1', 'string', '{"type": "string", "maxLength": 10240}', '1', '0', '0', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-28 23:19:30', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('331', '回路状态', '10', 'jamon', 'loop_status', '1', 'array', '{"type": "array", "arrayType": "integer"}', '0', '0', '0', '0', '0', '0', '0', '0', '', TO_DATE('2023-08-29 18:21:38', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '4#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('332', '回路状态', '10', 'jamon', 'loop_status', '1', 'array', '{"type": "array", "arrayType": "integer"}', '0', '0', '0', '0', '0', '0', '0', '0', '', TO_DATE('2023-08-29 18:23:08', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL, '4#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('335', '湿度', '1', 'admin', '0', '1', 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', '1', '0', '0', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-30 14:05:38', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-30 14:58:28', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '6#1', '%s/10', NULL, '0', NULL, NULL, NULL, '1', '3', NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('336', '温度', '1', 'admin', '1', '1', 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": "°C"}', '1', '0', '0', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-30 14:06:05', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-30 14:58:38', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '6#1', '%s/10', NULL, '1', NULL, NULL, NULL, '1', '3', NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('341', '视频', '1', 'admin', 'video', '1', 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', '1', '0', '0', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-30 23:08:51', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-30 23:25:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('342', '图片', '1', 'admin', 'image', '1', 'string', '{"type": "string", "maxLength": 1024}', '1', '0', '0', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-30 23:21:48', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-30 23:25:22', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "iot_things_model_template" ("template_id", "template_name", "tenant_id", "tenant_name", "identifier", "type", "datatype", "specs", "is_sys", "is_chart", "is_monitor", "is_history", "is_readonly", "is_share_perm", "model_order", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "temp_slave_id", "formula", "reverse_formula", "reg_addr", "bit_option", "value_type", "is_params", "quantity", "code", "old_identifier", "old_temp_slave_id", "parse_type") VALUES ('343', '状态', '1', 'admin', 'status', '1', 'integer', '{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', '1', '0', '0', '1', '1', '0', '0', '0', '', TO_DATE('2023-08-30 23:28:00', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-30 23:28:17', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for media_server
-- ----------------------------
DROP TABLE "media_server";
CREATE TABLE "media_server" (
  "id" NUMBER(20) NOT NULL,
  "server_id" NVARCHAR2(30) NOT NULL,
  "tenant_id" NUMBER(20) NOT NULL,
  "tenant_name" NVARCHAR2(30) NOT NULL,
  "enabled" NUMBER(4),
  "protocol" NVARCHAR2(10) NOT NULL,
  "ip" NVARCHAR2(255) NOT NULL,
  "domain" NVARCHAR2(128) NOT NULL,
  "hookurl" NVARCHAR2(255) NOT NULL,
  "secret" NVARCHAR2(255) NOT NULL,
  "port_http" NUMBER(11) NOT NULL,
  "port_https" NUMBER(11) NOT NULL,
  "port_rtmp" NUMBER(11) NOT NULL,
  "port_rtsp" NUMBER(11) NOT NULL,
  "rtp_proxy_port" NUMBER(11) NOT NULL,
  "rtp_enable" NUMBER(4) NOT NULL,
  "rtp_port_range" NVARCHAR2(255) NOT NULL,
  "record_port" NUMBER(11) NOT NULL,
  "auto_config" NUMBER(4) NOT NULL,
  "status" NUMBER(4) NOT NULL,
  "del_flag" NCHAR(1) NOT NULL,
  "create_by" NVARCHAR2(64) NOT NULL,
  "create_time" DATE NOT NULL,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500),
  "port_ws" NUMBER(11)
)
;
COMMENT ON COLUMN "media_server"."id" IS '流媒体配置ID';
COMMENT ON COLUMN "media_server"."server_id" IS '服务器标识';
COMMENT ON COLUMN "media_server"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "media_server"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "media_server"."enabled" IS '使能开关';
COMMENT ON COLUMN "media_server"."protocol" IS '默认播放协议';
COMMENT ON COLUMN "media_server"."ip" IS '服务器ip';
COMMENT ON COLUMN "media_server"."domain" IS '服务器域名';
COMMENT ON COLUMN "media_server"."hookurl" IS '回调服务器地址';
COMMENT ON COLUMN "media_server"."secret" IS '流媒体密钥';
COMMENT ON COLUMN "media_server"."port_http" IS 'http端口';
COMMENT ON COLUMN "media_server"."port_https" IS 'https端口';
COMMENT ON COLUMN "media_server"."port_rtmp" IS 'rtmp端口';
COMMENT ON COLUMN "media_server"."port_rtsp" IS 'rtsp端口';
COMMENT ON COLUMN "media_server"."rtp_proxy_port" IS 'RTP收流端口';
COMMENT ON COLUMN "media_server"."rtp_enable" IS '是否使用多端口模式';
COMMENT ON COLUMN "media_server"."rtp_port_range" IS 'rtp端口范围';
COMMENT ON COLUMN "media_server"."record_port" IS '录像服务端口';
COMMENT ON COLUMN "media_server"."auto_config" IS '是否自动同步配置ZLM';
COMMENT ON COLUMN "media_server"."status" IS '状态';
COMMENT ON COLUMN "media_server"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "media_server"."create_by" IS '创建者';
COMMENT ON COLUMN "media_server"."create_time" IS '创建时间';
COMMENT ON COLUMN "media_server"."update_by" IS '更新者';
COMMENT ON COLUMN "media_server"."update_time" IS '更新时间';
COMMENT ON COLUMN "media_server"."remark" IS '备注';
COMMENT ON COLUMN "media_server"."port_ws" IS 'ws端口';
COMMENT ON TABLE "media_server" IS '流媒体服务器配置';

-- ----------------------------
-- Records of media_server
-- ----------------------------
INSERT INTO "media_server" ("id", "server_id", "tenant_id", "tenant_name", "enabled", "protocol", "ip", "domain", "hookurl", "secret", "port_http", "port_https", "port_rtmp", "port_rtsp", "rtp_proxy_port", "rtp_enable", "rtp_port_range", "record_port", "auto_config", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark", "port_ws") VALUES ('7', 'fastbee', '1', 'admin', '1', 'http', '192.168.2.120', 'fastbee.com2', '192.168.2.15:8080', '035c73f7-bb6b-4889-a715-d9eb2d192xxx', '8082', '8443', '1935', '554', '0', '1', '30000,30103', '18081', '1', '0', '0', '', TO_DATE('2023-09-26 21:11:43', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-10-26 21:51:25', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE "news";
CREATE TABLE "news" (
  "news_id" NUMBER(20) NOT NULL,
  "title" NVARCHAR2(64) NOT NULL,
  "content" NCLOB NOT NULL,
  "img_url" NVARCHAR2(128) NOT NULL,
  "is_top" NUMBER(4) NOT NULL,
  "is_banner" NUMBER(4) NOT NULL,
  "category_id" NUMBER(20) NOT NULL,
  "category_name" NVARCHAR2(32) NOT NULL,
  "status" NUMBER(4) NOT NULL,
  "author" NVARCHAR2(50) NOT NULL,
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "news"."news_id" IS '新闻ID';
COMMENT ON COLUMN "news"."title" IS '标题';
COMMENT ON COLUMN "news"."content" IS '内容';
COMMENT ON COLUMN "news"."img_url" IS '封面';
COMMENT ON COLUMN "news"."is_top" IS '是否置顶(0-置顶 1-置顶)';
COMMENT ON COLUMN "news"."is_banner" IS '是否banner(0-是banner 1-不是banner)';
COMMENT ON COLUMN "news"."category_id" IS '分类ID';
COMMENT ON COLUMN "news"."category_name" IS '分类名称';
COMMENT ON COLUMN "news"."status" IS '新闻状态（0-未发布，1-已发布）';
COMMENT ON COLUMN "news"."author" IS '作者';
COMMENT ON COLUMN "news"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "news"."create_by" IS '创建者';
COMMENT ON COLUMN "news"."create_time" IS '创建时间';
COMMENT ON COLUMN "news"."update_by" IS '更新者';
COMMENT ON COLUMN "news"."update_time" IS '更新时间';
COMMENT ON COLUMN "news"."remark" IS '备注';
COMMENT ON TABLE "news" IS '新闻资讯';

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO "news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', '广告图一', '<p>请后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-215805.png', '0', '1', '2', '相关产品', '1', '物美智能', '0', '', TO_DATE('2022-05-12 12:13:40', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-05-12 12:13:40', 'SYYYY-MM-DD HH24:MI:SS'), '物美智能');
INSERT INTO "news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '广告图二', '<p>请后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-215852.png', '0', '1', '1', '新闻资讯', '1', '物美智能', '0', '', TO_DATE('2022-05-12 12:13:42', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-05-12 12:13:42', 'SYYYY-MM-DD HH24:MI:SS'), '物美智能');
INSERT INTO "news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', '广告图三', '<p>后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-224553.png', '0', '1', '2', '相关产品', '1', '物美智能', '0', '', TO_DATE('2022-05-12 12:13:44', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-05-12 12:13:44', 'SYYYY-MM-DD HH24:MI:SS'), '物美智能');
INSERT INTO "news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('4', '物美智能-快速搭建物联网和智能家居平台', '<p class="ql-align-justify">物美智能 wumei-smart 是一个简单易用的生活物联网平台。可用于搭建物联网平台以及二次开发和学习。设备接入使用EMQX消息服务器，加密认证；后端采用Spring boot；前端采用Vue；移动端采用Uniapp；数据库采用Mysql和Redis；设备端支持ESP32、ESP8266、树莓派等；</p><p class="ql-align-justify"><img src="/prod-api/profile/upload/2022/05/11/5f479f25-b85d-4c9f-b6a7-deadd2cdec76.png"></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>系统功能介绍</strong></p><p class="ql-align-justify"><br></p><p class="ql-align-justify">1.权限管理： 用户管理、部门管理、岗位管理、菜单管理、角色管理、字典和参数管理等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">2.系统监控： 操作日志、登录日志、系统日志、在线用户、服务监控、连接池监控、缓存监控等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">3.产品管理： 产品、产品物模型、产品分类、产品固件、授权码等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">4.设备管理： 控制、分组、定时、日志、统计、定位、OTA升级、影子模式、实时监测、加密认证等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">5.EMQ管理： Mqtt客户端、监听器、消息主题、消息订阅、插件管理、规则引擎、资源</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">6.硬件 SDK： 支持WIFI和MQTT连接、物模型响应、实时监测、定时上报监测数据、AES加密、NTP时间等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">7.物模型管理： 属性（设备状态和监测数据），功能（执行特定任务），事件（设备主动上报给云端）</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">8.其他（开发中）：第三方登录，设备分享、设备告警、场景联动（进度50%），智能音箱、多租户、APP界面自定义（进度40%），时序数据库、分布式集群部署、Granfa监控（进度30%），视频流处理、桌面端模拟器/监控、安卓端模拟器/监控（进度20%）</p><p class="ql-align-justify"><strong>﻿</strong></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>硬件设备接入流程</strong></p><p><br></p><p>1.设备认证：加密认证、简单认证和emqx支持的多种认证方式。</p><p class="ql-align-justify">2.设备交互：发布和订阅物模型、设备信息、设备升级和时钟同步等mqtt主题</p>', '/iot/tool/download?fileName=/profile/iot/1/2022-0508-133031.png', '1', '0', '2', '相关产品', '1', '物美智能', '0', '', TO_DATE('2022-05-12 12:13:46', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-05-12 12:13:46', 'SYYYY-MM-DD HH24:MI:SS'), '物美智能');
INSERT INTO "news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('5', '2022年中国物联网全景图产业链上中下游市场及企业剖析', '<p>后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-224151.png', '1', '0', '1', '新闻资讯', '1', '物美智能', '0', '', TO_DATE('2022-05-12 12:13:48', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-05-12 12:13:48', 'SYYYY-MM-DD HH24:MI:SS'), '物美智能');
INSERT INTO "news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('6', 'Arm打造物联网全面解决方案 携手合作伙伴共探智能未来', '<p>后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-224352.png', '1', '0', '1', '新闻资讯', '1', '物美智能', '0', '', TO_DATE('2022-05-12 12:13:50', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-05-12 12:13:50', 'SYYYY-MM-DD HH24:MI:SS'), '物美智能');
INSERT INTO "news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('7', '使用ESP32开发板，快速学习物联网开发', '<p>请后台添加内容</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0428-130824.jpg', '1', '0', '2', '相关产品', '1', '物美智能', '0', '', TO_DATE('2022-05-12 12:13:53', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-05-12 12:13:53', 'SYYYY-MM-DD HH24:MI:SS'), '物美智能');
INSERT INTO "news" ("news_id", "title", "content", "img_url", "is_top", "is_banner", "category_id", "category_name", "status", "author", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('8', '物联网赛道观察之无源物联网', '<p>无源物联网，即终端无外接能量源，采用获取环境能量的方式进行供能的物联网技术。在当前物联网技术发展条件下，终端覆盖率是一个亟待解决的问题，而无源物联网凭借其极低的部署和维护成本、灵活多变的应用场景成为解决更广范围内终端供能需求问题、实现“千亿级互联”愿景的关键。</p><p><br></p><p>无源物联网技术的发展最终有赖于环境能量采集、低功耗计算与反向散射等低功耗通讯技术的进步。目前无源物联网应用较为成熟的路线主要包括射频识别技术（RFID）与近场通信技术（NFC）两类，覆盖仓储物流、智能制造、智慧零售、资产管理、物业服务等多元应用场景。未来，随着物联网行业的碎片化整合以及以Bluetooth、5G、LoRa等为媒介进行能量采集与信息传输的技术路线的逐渐成熟，当前困扰行业的诸多问题将会逐步得到解决，随之而来的是更包罗多样的无源终端需求与极具潜力的应用场景。</p>', '/iot/tool/download?fileName=/profile/iot/118/2022-0424-215643.png', '1', '0', '1', '新闻资讯', '1', '物美智能', '0', '', TO_DATE('2022-05-12 12:13:55', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-05-12 12:13:55', 'SYYYY-MM-DD HH24:MI:SS'), '物美智能');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for news_category
-- ----------------------------
DROP TABLE "news_category";
CREATE TABLE "news_category" (
  "category_id" NUMBER(20) NOT NULL,
  "category_name" NVARCHAR2(64) NOT NULL,
  "order_num" NUMBER(11) NOT NULL,
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "news_category"."category_id" IS '分类ID';
COMMENT ON COLUMN "news_category"."category_name" IS '分类名称';
COMMENT ON COLUMN "news_category"."order_num" IS '显示顺序';
COMMENT ON COLUMN "news_category"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "news_category"."create_by" IS '创建者';
COMMENT ON COLUMN "news_category"."create_time" IS '创建时间';
COMMENT ON COLUMN "news_category"."update_by" IS '更新者';
COMMENT ON COLUMN "news_category"."update_time" IS '更新时间';
COMMENT ON COLUMN "news_category"."remark" IS '备注';
COMMENT ON TABLE "news_category" IS '新闻分类';

-- ----------------------------
-- Records of news_category
-- ----------------------------
INSERT INTO "news_category" ("category_id", "category_name", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', '新闻资讯', '3', '0', '', TO_DATE('2022-04-11 20:53:55', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-04-13 15:30:22', 'SYYYY-MM-DD HH24:MI:SS'), '新闻资讯信息');
INSERT INTO "news_category" ("category_id", "category_name", "order_num", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '相关产品', '2', '0', '', TO_DATE('2022-04-11 20:54:16', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2022-04-13 15:30:15', 'SYYYY-MM-DD HH24:MI:SS'), '相关产品推荐');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for oauth_access_token
-- ----------------------------
DROP TABLE "oauth_access_token";
CREATE TABLE "oauth_access_token" (
  "token_id" NVARCHAR2(255),
  "token" BLOB,
  "authentication_id" NVARCHAR2(255),
  "user_name" NVARCHAR2(255),
  "client_id" NVARCHAR2(255),
  "authentication" BLOB,
  "refresh_token" NVARCHAR2(255)
)
;

-- ----------------------------
-- Records of oauth_access_token
-- ----------------------------
INSERT INTO "oauth_access_token" ("token_id", "token", "authentication_id", "user_name", "client_id", "authentication", "refresh_token") VALUES ('d406d946aac7c24cd01a2df1105ec898', HEXTORAW('ACED0005737200436F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744F4175746832416363657373546F6B656E0CB29E361B24FACE0200064C00156164646974696F6E616C496E666F726D6174696F6E74000F4C6A6176612F7574696C2F4D61703B4C000A65787069726174696F6E7400104C6A6176612F7574696C2F446174653B4C000C72656672657368546F6B656E74003F4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F636F6D6D6F6E2F4F417574683252656672657368546F6B656E3B4C000573636F706574000F4C6A6176612F7574696C2F5365743B4C0009746F6B656E547970657400124C6A6176612F6C616E672F537472696E673B4C000576616C756571007E000578707372001E6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794D6170593614855ADCE7D002000078707372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018AA760D163787372004C6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744578706972696E674F417574683252656672657368546F6B656E2FDF47639DD0C9B70200014C000A65787069726174696F6E71007E0002787200446F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744F417574683252656672657368546F6B656E73E10E0A6354D45E0200014C000576616C756571007E0005787074001B56452D377744386D70414A34497A662D49345F456450316F31626F7371007E000977080000018AA760D12D78737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C0001637400164C6A6176612F7574696C2F436F6C6C656374696F6E3B7870737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000043F400000000000027400047265616474000577726974657874000662656172657274001B70385A5F47384A7349327A33786575674430646A494B305A396B38'), '2c27d3f4516a653753e8337094cf35e1', 'admin', 'admin-dueros', HEXTORAW('ACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000009740004636F64657400066E777064716174000A6772616E745F74797065740012617574686F72697A6174696F6E5F636F646574000573636F706574000A7265616420777269746574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F65326566636666663936383964633462366166363764373865313039363934647400057374617465740020346635653763303462313731306262653836376535376431373434613534373874000D636C69656E745F7365637265747400205332456E65487864745E4D48684276384E23245E7479366E71244E5159324E6474000A647565726F735F7569647400203466356537633034623137313062626538363765353764313734346135343738740009636C69656E745F696474000C61646D696E2D647565726F7378737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E002E770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E002E770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E002E770C000000103F4000000000000171007E0020787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00434C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00434C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E004378707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E00470000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E00470000018AA6E3204374000A57696E646F77732031307371007E002E770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00434C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00435B0007726F6C6549647371007E00554C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00434C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00544C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0054787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00434C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00434C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E005670707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E004974000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0048000000017371007E0047000000000000006570707400013171007E00497400103136343737303730374071712E636F6D7371007E005977080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E00555B00076D656E7549647371007E00554C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00434C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00604C000673746174757371007E000F7871007E005670707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E0047000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E00687400013078740001307400013071007E007674000561646D696E71007E0076'), '4cabc0e9bcfa34131342209bdaf275eb');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for oauth_approvals
-- ----------------------------
DROP TABLE "oauth_approvals";
CREATE TABLE "oauth_approvals" (
  "userId" NVARCHAR2(255),
  "clientId" NVARCHAR2(255),
  "scope" NVARCHAR2(255),
  "status" NVARCHAR2(10),
  "expiresAt" DATE NOT NULL,
  "lastModifiedAt" DATE
)
;

-- ----------------------------
-- Records of oauth_approvals
-- ----------------------------
INSERT INTO "oauth_approvals" ("userId", "clientId", "scope", "status", "expiresAt", "lastModifiedAt") VALUES ('admin', 'admin-dueros', 'read', 'APPROVED', TO_DATE('2023-10-18 22:12:45', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-18 22:12:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "oauth_approvals" ("userId", "clientId", "scope", "status", "expiresAt", "lastModifiedAt") VALUES ('admin', 'admin-dueros', 'write', 'APPROVED', TO_DATE('2023-10-18 22:12:45', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-09-18 22:12:45', 'SYYYY-MM-DD HH24:MI:SS'));
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE "oauth_client_details";
CREATE TABLE "oauth_client_details" (
  "client_id" NVARCHAR2(255) NOT NULL,
  "resource_ids" NVARCHAR2(255),
  "client_secret" NVARCHAR2(255),
  "scope" NVARCHAR2(255),
  "authorized_grant_types" NVARCHAR2(255),
  "web_server_redirect_uri" NVARCHAR2(255),
  "authorities" NVARCHAR2(255),
  "access_token_validity" NUMBER(11),
  "refresh_token_validity" NUMBER(11),
  "additional_information" NCLOB,
  "autoapprove" NVARCHAR2(255),
  "type" NUMBER(4)
)
;
COMMENT ON COLUMN "oauth_client_details"."client_id" IS '客户端ID';
COMMENT ON COLUMN "oauth_client_details"."resource_ids" IS '客户端所能访问的资源id集合,多个资源时用逗号(,)分隔';
COMMENT ON COLUMN "oauth_client_details"."client_secret" IS '客户端秘钥';
COMMENT ON COLUMN "oauth_client_details"."scope" IS '权限范围,可选值包括read,write,trust;若有多个权限范围用逗号(,)分隔';
COMMENT ON COLUMN "oauth_client_details"."authorized_grant_types" IS '授权模式，可选值包括authorization_code,password,refresh_token,implicit,client_credentials, 若支持多个grant_type用逗号(,)分隔';
COMMENT ON COLUMN "oauth_client_details"."web_server_redirect_uri" IS '回调地址';
COMMENT ON COLUMN "oauth_client_details"."authorities" IS '权限';
COMMENT ON COLUMN "oauth_client_details"."access_token_validity" IS '设定客户端的access_token的有效时间值(单位:秒)';
COMMENT ON COLUMN "oauth_client_details"."refresh_token_validity" IS '设定客户端的refresh_token的有效时间值(单位:秒)';
COMMENT ON COLUMN "oauth_client_details"."additional_information" IS '预留的字段,在Oauth的流程中没有实际的使用,可选,但若设置值,必须是JSON格式的数据';
COMMENT ON COLUMN "oauth_client_details"."autoapprove" IS '设置用户是否自动Approval操作, 默认值为 ''false'', 可选值包括 ''true'',''false'', ''read'',''write''. 
该字段只适用于grant_type="authorization_code"的情况,当用户登录成功后,若该值为''true''或支持的scope值,则会跳过用户Approve的页面, 直接授权. ';
COMMENT ON COLUMN "oauth_client_details"."type" IS '1=小度(DuerOS),2=天猫精灵(ALiGenie),3=小米小爱';

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
INSERT INTO "oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('admin-dueros', 'speaker-service', 'S2EneHxdt^MHhBv8N#$^ty6nq$NQY2Nd', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694d', 'ROLE_ADMIN', '7200', '7200', NULL, 'false', '1');
INSERT INTO "oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('fastbee-dueros', 'speaker-service', 'S2EneHxdt^MHhBv8N#$^ty6nq$NQY2Nc', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/35dc8a5b53719ea6bbb7bd818ca8d5b6', 'ROLE_ADMIN', '7200', '7200', NULL, 'false', '1');
INSERT INTO "oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('speaker', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'client_credentials,password,authorization_code,implicit,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', '7200', '7200', NULL, 'false', '1');
INSERT INTO "oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('tianmao', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', '
https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', '7200', '7200', NULL, 'true', '2');
INSERT INTO "oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('xiaoai', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', '7200', '7200', NULL, 'true', '3');
INSERT INTO "oauth_client_details" ("client_id", "resource_ids", "client_secret", "scope", "authorized_grant_types", "web_server_redirect_uri", "authorities", "access_token_validity", "refresh_token_validity", "additional_information", "autoapprove", "type") VALUES ('xiaoyi', 'speaker-service', '$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', 'read,write', 'authorization_code,refresh_token', 'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', 'ROLE_ADMIN', '7200', '7200', NULL, 'false', '4');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for oauth_client_token
-- ----------------------------
DROP TABLE "oauth_client_token";
CREATE TABLE "oauth_client_token" (
  "token_id" NVARCHAR2(255),
  "token" BLOB,
  "authentication_id" NVARCHAR2(255),
  "user_name" NVARCHAR2(255),
  "client_id" NVARCHAR2(255)
)
;

-- ----------------------------
-- Records of oauth_client_token
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for oauth_code
-- ----------------------------
DROP TABLE "oauth_code";
CREATE TABLE "oauth_code" (
  "code" NVARCHAR2(255),
  "authentication" BLOB
)
;

-- ----------------------------
-- Records of oauth_code
-- ----------------------------
INSERT INTO "oauth_code" ("code", "authentication") VALUES ('mLAeh7', HEXTORAW('ACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000474000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464740009636C69656E745F696471007E001474000573636F706574000A7265616420777269746578737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E0023770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E0023770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E0023770C000000103F4000000000000171007E001A787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00384C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00384C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E003878707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E003C0000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E003C0000018AA6E3204374000A57696E646F77732031307371007E0023770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00384C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00385B0007726F6C6549647371007E004A4C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00384C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00494C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0049787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00384C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00384C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E004B70707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E003E74000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E003D000000017371007E003C000000000000006570707400013171007E003E7400103136343737303730374071712E636F6D7371007E004E77080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E004A5B00076D656E7549647371007E004A4C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00384C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00554C000673746174757371007E000F7871007E004B70707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E003C000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E005D7400013078740001307400013071007E006B74000561646D696E71007E006B'));
INSERT INTO "oauth_code" ("code", "authentication") VALUES ('1YESo2', HEXTORAW('ACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000474000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464740009636C69656E745F696471007E001474000573636F706574000A7265616420777269746578737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E0023770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E0023770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E0023770C000000103F4000000000000171007E001A787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00384C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00384C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E003878707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E003C0000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E003C0000018AA6E3204374000A57696E646F77732031307371007E0023770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00384C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00385B0007726F6C6549647371007E004A4C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00384C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00494C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0049787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00384C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00384C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E004B70707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E003E74000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E003D000000017371007E003C000000000000006570707400013171007E003E7400103136343737303730374071712E636F6D7371007E004E77080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E004A5B00076D656E7549647371007E004A4C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00384C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00554C000673746174757371007E000F7871007E004B70707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E003C000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E005D7400013078740001307400013071007E006B74000561646D696E71007E006B'));
INSERT INTO "oauth_code" ("code", "authentication") VALUES ('DhdDPY', HEXTORAW('ACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000674000573636F706574000A7265616420777269746574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F65326566636666663936383964633462366166363764373865313039363934647400057374617465740020346635653763303462313731306262653836376535376431373434613534373874000A647565726F735F7569647400203466356537633034623137313062626538363765353764313734346135343738740009636C69656E745F696471007E001478737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E0027770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E0027770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E0027770C000000103F4000000000000171007E001C787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E003C4C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E003C4C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E003C78707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E00400000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E00400000018AA6E3204374000A57696E646F77732031307371007E0027770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E003C4C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E003C5B0007726F6C6549647371007E004E4C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E003C4C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E004D4C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E004D787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E003C4C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E003C4C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E004F70707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E004274000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0041000000017371007E0040000000000000006570707400013171007E00427400103136343737303730374071712E636F6D7371007E005277080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E004E5B00076D656E7549647371007E004E4C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E003C4C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00594C000673746174757371007E000F7871007E004F70707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E0040000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E00617400013078740001307400013071007E006F74000561646D696E71007E006F'));
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for oauth_refresh_token
-- ----------------------------
DROP TABLE "oauth_refresh_token";
CREATE TABLE "oauth_refresh_token" (
  "token_id" NVARCHAR2(255),
  "token" BLOB,
  "authentication" BLOB
)
;

-- ----------------------------
-- Records of oauth_refresh_token
-- ----------------------------
INSERT INTO "oauth_refresh_token" ("token_id", "token", "authentication") VALUES ('4cabc0e9bcfa34131342209bdaf275eb', HEXTORAW('ACED00057372004C6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744578706972696E674F417574683252656672657368546F6B656E2FDF47639DD0C9B70200014C000A65787069726174696F6E7400104C6A6176612F7574696C2F446174653B787200446F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744F417574683252656672657368546F6B656E73E10E0A6354D45E0200014C000576616C75657400124C6A6176612F6C616E672F537472696E673B787074001B56452D377744386D70414A34497A662D49345F456450316F31626F7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018AA760D12D78'), HEXTORAW('ACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000009740004636F6465740006536C4B4F684C74000A6772616E745F74797065740012617574686F72697A6174696F6E5F636F646574000573636F706574000A7265616420777269746574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F65326566636666663936383964633462366166363764373865313039363934647400057374617465740020346635653763303462313731306262653836376535376431373434613534373874000D636C69656E745F7365637265747400225332456E65487864745E4D48684276384E253233245E7479366E71244E5159324E6474000A647565726F735F7569647400203466356537633034623137313062626538363765353764313734346135343738740009636C69656E745F696474000C61646D696E2D647565726F7378737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E002E770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E002E770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E002E770C000000103F4000000000000171007E0020787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00434C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00434C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E004378707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E00470000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E00470000018AA6E3204374000A57696E646F77732031307371007E002E770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00434C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00435B0007726F6C6549647371007E00554C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00434C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00544C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0054787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00434C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00434C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E005670707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E004974000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0048000000017371007E0047000000000000006570707400013171007E00497400103136343737303730374071712E636F6D7371007E005977080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E00555B00076D656E7549647371007E00554C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00434C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00604C000673746174757371007E000F7871007E005670707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E0047000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E00687400013078740001307400013071007E007674000561646D696E71007E0076'));
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE "qrtz_blob_triggers";
CREATE TABLE "qrtz_blob_triggers" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "trigger_name" NVARCHAR2(200) NOT NULL,
  "trigger_group" NVARCHAR2(200) NOT NULL,
  "blob_data" BLOB
)
;
COMMENT ON COLUMN "qrtz_blob_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_blob_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "qrtz_blob_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "qrtz_blob_triggers"."blob_data" IS '存放持久化Trigger对象';
COMMENT ON TABLE "qrtz_blob_triggers" IS 'Blob类型的触发器表';

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE "qrtz_calendars";
CREATE TABLE "qrtz_calendars" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "calendar_name" NVARCHAR2(200) NOT NULL,
  "calendar" BLOB NOT NULL
)
;
COMMENT ON COLUMN "qrtz_calendars"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_calendars"."calendar_name" IS '日历名称';
COMMENT ON COLUMN "qrtz_calendars"."calendar" IS '存放持久化calendar对象';
COMMENT ON TABLE "qrtz_calendars" IS '日历信息表';

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE "qrtz_cron_triggers";
CREATE TABLE "qrtz_cron_triggers" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "trigger_name" NVARCHAR2(200) NOT NULL,
  "trigger_group" NVARCHAR2(200) NOT NULL,
  "cron_expression" NVARCHAR2(200) NOT NULL,
  "time_zone_id" NVARCHAR2(80)
)
;
COMMENT ON COLUMN "qrtz_cron_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_cron_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "qrtz_cron_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "qrtz_cron_triggers"."cron_expression" IS 'cron表达式';
COMMENT ON COLUMN "qrtz_cron_triggers"."time_zone_id" IS '时区';
COMMENT ON TABLE "qrtz_cron_triggers" IS 'Cron类型的触发器表';

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO "qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO "qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO "qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');
INSERT INTO "qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'SYSTEM', '0 0/4 * * * ? ', 'Asia/Shanghai');
INSERT INTO "qrtz_cron_triggers" ("sched_name", "trigger_name", "trigger_group", "cron_expression", "time_zone_id") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME5', 'SYSTEM', '0 0/1 * * * ? ', 'Asia/Shanghai');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE "qrtz_fired_triggers";
CREATE TABLE "qrtz_fired_triggers" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "entry_id" NVARCHAR2(95) NOT NULL,
  "trigger_name" NVARCHAR2(200) NOT NULL,
  "trigger_group" NVARCHAR2(200) NOT NULL,
  "instance_name" NVARCHAR2(200) NOT NULL,
  "fired_time" NUMBER(20) NOT NULL,
  "sched_time" NUMBER(20) NOT NULL,
  "priority" NUMBER(11) NOT NULL,
  "state" NVARCHAR2(16) NOT NULL,
  "job_name" NVARCHAR2(200),
  "job_group" NVARCHAR2(200),
  "is_nonconcurrent" NVARCHAR2(1),
  "requests_recovery" NVARCHAR2(1)
)
;
COMMENT ON COLUMN "qrtz_fired_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_fired_triggers"."entry_id" IS '调度器实例id';
COMMENT ON COLUMN "qrtz_fired_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "qrtz_fired_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "qrtz_fired_triggers"."instance_name" IS '调度器实例名';
COMMENT ON COLUMN "qrtz_fired_triggers"."fired_time" IS '触发的时间';
COMMENT ON COLUMN "qrtz_fired_triggers"."sched_time" IS '定时器制定的时间';
COMMENT ON COLUMN "qrtz_fired_triggers"."priority" IS '优先级';
COMMENT ON COLUMN "qrtz_fired_triggers"."state" IS '状态';
COMMENT ON COLUMN "qrtz_fired_triggers"."job_name" IS '任务名称';
COMMENT ON COLUMN "qrtz_fired_triggers"."job_group" IS '任务组名';
COMMENT ON COLUMN "qrtz_fired_triggers"."is_nonconcurrent" IS '是否并发';
COMMENT ON COLUMN "qrtz_fired_triggers"."requests_recovery" IS '是否接受恢复执行';
COMMENT ON TABLE "qrtz_fired_triggers" IS '已触发的触发器表';

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE "qrtz_job_details";
CREATE TABLE "qrtz_job_details" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "job_name" NVARCHAR2(200) NOT NULL,
  "job_group" NVARCHAR2(200) NOT NULL,
  "description" NVARCHAR2(250),
  "job_class_name" NVARCHAR2(250) NOT NULL,
  "is_durable" NVARCHAR2(1) NOT NULL,
  "is_nonconcurrent" NVARCHAR2(1) NOT NULL,
  "is_update_data" NVARCHAR2(1) NOT NULL,
  "requests_recovery" NVARCHAR2(1) NOT NULL,
  "job_data" BLOB
)
;
COMMENT ON COLUMN "qrtz_job_details"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_job_details"."job_name" IS '任务名称';
COMMENT ON COLUMN "qrtz_job_details"."job_group" IS '任务组名';
COMMENT ON COLUMN "qrtz_job_details"."description" IS '相关介绍';
COMMENT ON COLUMN "qrtz_job_details"."job_class_name" IS '执行任务类名称';
COMMENT ON COLUMN "qrtz_job_details"."is_durable" IS '是否持久化';
COMMENT ON COLUMN "qrtz_job_details"."is_nonconcurrent" IS '是否并发';
COMMENT ON COLUMN "qrtz_job_details"."is_update_data" IS '是否更新数据';
COMMENT ON COLUMN "qrtz_job_details"."requests_recovery" IS '是否接受恢复执行';
COMMENT ON COLUMN "qrtz_job_details"."job_data" IS '存放持久化job对象';
COMMENT ON TABLE "qrtz_job_details" IS '任务详细信息表';

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO "qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', HEXTORAW('ACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED85078707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001307800'));
INSERT INTO "qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', HEXTORAW('ACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED85078707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800'));
INSERT INTO "qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', HEXTORAW('ACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED85078707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800'));
INSERT INTO "qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'SYSTEM', NULL, 'com.fastbee.quartz.util.QuartzJobExecution', '0', '0', '0', '0', HEXTORAW('ACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001869759B0B878707400007070707400013074000E3020302F34202A202A202A203F2074002070726F7047657453657276696365496D706C2E666574636850726F706572747974000653595354454D7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000047400126D6F64627573E4BA91E7ABAFE8BDAEE8AFA274000131740001307800'));
INSERT INTO "qrtz_job_details" ("sched_name", "job_name", "job_group", "description", "job_class_name", "is_durable", "is_nonconcurrent", "is_update_data", "requests_recovery", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME5', 'SYSTEM', NULL, 'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', HEXTORAW('ACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000187118D07E078707400007070707400013174000E3020302F31202A202A202A203F207400286465766963654A6F622E74696D696E6755706461746544657669636553746174757353746174757374000653595354454D7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000005740012E8AEBEE5A487E5AE9AE697B6E4BBBBE58AA174000131740001307800'));
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE "qrtz_locks";
CREATE TABLE "qrtz_locks" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "lock_name" NVARCHAR2(40) NOT NULL
)
;
COMMENT ON COLUMN "qrtz_locks"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_locks"."lock_name" IS '悲观锁名称';
COMMENT ON TABLE "qrtz_locks" IS '存储的悲观锁信息表';

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO "qrtz_locks" ("sched_name", "lock_name") VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO "qrtz_locks" ("sched_name", "lock_name") VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE "qrtz_paused_trigger_grps";
CREATE TABLE "qrtz_paused_trigger_grps" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "trigger_group" NVARCHAR2(200) NOT NULL
)
;
COMMENT ON COLUMN "qrtz_paused_trigger_grps"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_paused_trigger_grps"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON TABLE "qrtz_paused_trigger_grps" IS '暂停的触发器表';

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE "qrtz_scheduler_state";
CREATE TABLE "qrtz_scheduler_state" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "instance_name" NVARCHAR2(200) NOT NULL,
  "last_checkin_time" NUMBER(20) NOT NULL,
  "checkin_interval" NUMBER(20) NOT NULL
)
;
COMMENT ON COLUMN "qrtz_scheduler_state"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_scheduler_state"."instance_name" IS '实例名称';
COMMENT ON COLUMN "qrtz_scheduler_state"."last_checkin_time" IS '上次检查时间';
COMMENT ON COLUMN "qrtz_scheduler_state"."checkin_interval" IS '检查间隔时间';
COMMENT ON TABLE "qrtz_scheduler_state" IS '调度器状态表';

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO "qrtz_scheduler_state" ("sched_name", "instance_name", "last_checkin_time", "checkin_interval") VALUES ('RuoyiScheduler', 'beecue1680023933011', '1680023961720', '15000');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE "qrtz_simple_triggers";
CREATE TABLE "qrtz_simple_triggers" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "trigger_name" NVARCHAR2(200) NOT NULL,
  "trigger_group" NVARCHAR2(200) NOT NULL,
  "repeat_count" NUMBER(20) NOT NULL,
  "repeat_interval" NUMBER(20) NOT NULL,
  "times_triggered" NUMBER(20) NOT NULL
)
;
COMMENT ON COLUMN "qrtz_simple_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_simple_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "qrtz_simple_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "qrtz_simple_triggers"."repeat_count" IS '重复的次数统计';
COMMENT ON COLUMN "qrtz_simple_triggers"."repeat_interval" IS '重复的间隔时间';
COMMENT ON COLUMN "qrtz_simple_triggers"."times_triggered" IS '已经触发的次数';
COMMENT ON TABLE "qrtz_simple_triggers" IS '简单触发器的信息表';

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE "qrtz_simprop_triggers";
CREATE TABLE "qrtz_simprop_triggers" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "trigger_name" NVARCHAR2(200) NOT NULL,
  "trigger_group" NVARCHAR2(200) NOT NULL,
  "str_prop_1" NVARCHAR2(512),
  "str_prop_2" NVARCHAR2(512),
  "str_prop_3" NVARCHAR2(512),
  "int_prop_1" NUMBER(11),
  "int_prop_2" NUMBER(11),
  "long_prop_1" NUMBER(20),
  "long_prop_2" NUMBER(20),
  "dec_prop_1" NUMBER,
  "dec_prop_2" NUMBER,
  "bool_prop_1" NVARCHAR2(1),
  "bool_prop_2" NVARCHAR2(1)
)
;
COMMENT ON COLUMN "qrtz_simprop_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_simprop_triggers"."trigger_name" IS 'qrtz_triggers表trigger_name的外键';
COMMENT ON COLUMN "qrtz_simprop_triggers"."trigger_group" IS 'qrtz_triggers表trigger_group的外键';
COMMENT ON COLUMN "qrtz_simprop_triggers"."str_prop_1" IS 'String类型的trigger的第一个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."str_prop_2" IS 'String类型的trigger的第二个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."str_prop_3" IS 'String类型的trigger的第三个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."int_prop_1" IS 'int类型的trigger的第一个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."int_prop_2" IS 'int类型的trigger的第二个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."long_prop_1" IS 'long类型的trigger的第一个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."long_prop_2" IS 'long类型的trigger的第二个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."dec_prop_1" IS 'decimal类型的trigger的第一个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."dec_prop_2" IS 'decimal类型的trigger的第二个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."bool_prop_1" IS 'Boolean类型的trigger的第一个参数';
COMMENT ON COLUMN "qrtz_simprop_triggers"."bool_prop_2" IS 'Boolean类型的trigger的第二个参数';
COMMENT ON TABLE "qrtz_simprop_triggers" IS '同步机制的行锁表';

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE "qrtz_triggers";
CREATE TABLE "qrtz_triggers" (
  "sched_name" NVARCHAR2(120) NOT NULL,
  "trigger_name" NVARCHAR2(200) NOT NULL,
  "trigger_group" NVARCHAR2(200) NOT NULL,
  "job_name" NVARCHAR2(200) NOT NULL,
  "job_group" NVARCHAR2(200) NOT NULL,
  "description" NVARCHAR2(250),
  "next_fire_time" NUMBER(20),
  "prev_fire_time" NUMBER(20),
  "priority" NUMBER(11),
  "trigger_state" NVARCHAR2(16) NOT NULL,
  "trigger_type" NVARCHAR2(8) NOT NULL,
  "start_time" NUMBER(20) NOT NULL,
  "end_time" NUMBER(20),
  "calendar_name" NVARCHAR2(200),
  "misfire_instr" NUMBER(6),
  "job_data" BLOB
)
;
COMMENT ON COLUMN "qrtz_triggers"."sched_name" IS '调度名称';
COMMENT ON COLUMN "qrtz_triggers"."trigger_name" IS '触发器的名字';
COMMENT ON COLUMN "qrtz_triggers"."trigger_group" IS '触发器所属组的名字';
COMMENT ON COLUMN "qrtz_triggers"."job_name" IS 'qrtz_job_details表job_name的外键';
COMMENT ON COLUMN "qrtz_triggers"."job_group" IS 'qrtz_job_details表job_group的外键';
COMMENT ON COLUMN "qrtz_triggers"."description" IS '相关介绍';
COMMENT ON COLUMN "qrtz_triggers"."next_fire_time" IS '上一次触发时间（毫秒）';
COMMENT ON COLUMN "qrtz_triggers"."prev_fire_time" IS '下一次触发时间（默认为-1表示不触发）';
COMMENT ON COLUMN "qrtz_triggers"."priority" IS '优先级';
COMMENT ON COLUMN "qrtz_triggers"."trigger_state" IS '触发器状态';
COMMENT ON COLUMN "qrtz_triggers"."trigger_type" IS '触发器的类型';
COMMENT ON COLUMN "qrtz_triggers"."start_time" IS '开始时间';
COMMENT ON COLUMN "qrtz_triggers"."end_time" IS '结束时间';
COMMENT ON COLUMN "qrtz_triggers"."calendar_name" IS '日程表名称';
COMMENT ON COLUMN "qrtz_triggers"."misfire_instr" IS '补偿执行的策略';
COMMENT ON COLUMN "qrtz_triggers"."job_data" IS '存放持久化job对象';
COMMENT ON TABLE "qrtz_triggers" IS '触发器详细信息表';

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO "qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, '1680023970000', '1680023960000', '5', 'WAITING', 'CRON', '1680023946000', '0', NULL, '2', EMPTY_BLOB());
INSERT INTO "qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, '1680023955000', '-1', '5', 'PAUSED', 'CRON', '1680023947000', '0', NULL, '2', EMPTY_BLOB());
INSERT INTO "qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, '1680023960000', '-1', '5', 'PAUSED', 'CRON', '1680023948000', '0', NULL, '2', EMPTY_BLOB());
INSERT INTO "qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME4', 'SYSTEM', 'TASK_CLASS_NAME4', 'SYSTEM', NULL, '1680024000000', '-1', '5', 'WAITING', 'CRON', '1680023950000', '0', NULL, '-1', EMPTY_BLOB());
INSERT INTO "qrtz_triggers" ("sched_name", "trigger_name", "trigger_group", "job_name", "job_group", "description", "next_fire_time", "prev_fire_time", "priority", "trigger_state", "trigger_type", "start_time", "end_time", "calendar_name", "misfire_instr", "job_data") VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME5', 'SYSTEM', 'TASK_CLASS_NAME5', 'SYSTEM', NULL, '1680024000000', '-1', '5', 'WAITING', 'CRON', '1680023951000', '0', NULL, '-1', EMPTY_BLOB());
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sip_config
-- ----------------------------
DROP TABLE "sip_config";
CREATE TABLE "sip_config" (
  "id" NUMBER(20) NOT NULL,
  "product_id" NUMBER(20) NOT NULL,
  "product_name" NVARCHAR2(64) NOT NULL,
  "enabled" NUMBER(4),
  "isdefault" NUMBER(4),
  "seniorSdp" NUMBER(4),
  "domain_alias" NVARCHAR2(10) NOT NULL,
  "server_sipid" NVARCHAR2(20) NOT NULL,
  "password" NVARCHAR2(20) NOT NULL,
  "ip" NVARCHAR2(32),
  "port" NUMBER(20),
  "del_flag" NCHAR(1) NOT NULL,
  "create_by" NVARCHAR2(64) NOT NULL,
  "create_time" DATE NOT NULL,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sip_config"."id" IS '主键';
COMMENT ON COLUMN "sip_config"."product_id" IS '产品ID';
COMMENT ON COLUMN "sip_config"."product_name" IS '产品名称';
COMMENT ON COLUMN "sip_config"."enabled" IS '使能开关';
COMMENT ON COLUMN "sip_config"."isdefault" IS '系统默认配置';
COMMENT ON COLUMN "sip_config"."seniorSdp" IS '拓展sdp';
COMMENT ON COLUMN "sip_config"."domain_alias" IS '服务器域';
COMMENT ON COLUMN "sip_config"."server_sipid" IS '服务器sipid';
COMMENT ON COLUMN "sip_config"."password" IS 'sip认证密码';
COMMENT ON COLUMN "sip_config"."ip" IS 'sip接入IP';
COMMENT ON COLUMN "sip_config"."port" IS 'sip接入端口号';
COMMENT ON COLUMN "sip_config"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "sip_config"."create_by" IS '创建者';
COMMENT ON COLUMN "sip_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "sip_config"."update_by" IS '更新者';
COMMENT ON COLUMN "sip_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "sip_config"."remark" IS '备注';
COMMENT ON TABLE "sip_config" IS 'sip系统配置';

-- ----------------------------
-- Records of sip_config
-- ----------------------------
INSERT INTO "sip_config" ("id", "product_id", "product_name", "enabled", "isdefault", "seniorSdp", "domain_alias", "server_sipid", "password", "ip", "port", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('38', '117', '', '1', '1', NULL, '3402000000', '34020000002000000001', '12345678', '177.7.0.13', '5061', '0', '', TO_DATE('2023-03-16 21:26:18', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-03-16 21:26:24', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sip_config" ("id", "product_id", "product_name", "enabled", "isdefault", "seniorSdp", "domain_alias", "server_sipid", "password", "ip", "port", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('39', '118', '', '1', '1', NULL, '3402000000', '34020000002000000001', '12345678', '177.7.0.13', '5061', '0', '', TO_DATE('2023-04-11 21:11:54', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sip_config" ("id", "product_id", "product_name", "enabled", "isdefault", "seniorSdp", "domain_alias", "server_sipid", "password", "ip", "port", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('41', '135', '', '1', '1', NULL, '3402000000', '34020000002000000001', '12345678', '177.7.0.13', '5061', '0', '', TO_DATE('2024-01-08 22:14:35', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sip_config" ("id", "product_id", "product_name", "enabled", "isdefault", "seniorSdp", "domain_alias", "server_sipid", "password", "ip", "port", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('42', '131', '', '0', '0', NULL, '3402000000', '34020000002000000001', '12345678', '192.168.5.27', '5061', '0', '', TO_DATE('2025-03-19 16:26:04', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sip_device
-- ----------------------------
DROP TABLE "sip_device";
CREATE TABLE "sip_device" (
  "device_id" NUMBER(20) NOT NULL,
  "product_id" NUMBER(20) NOT NULL,
  "product_name" NVARCHAR2(64) NOT NULL,
  "device_sip_id" NVARCHAR2(64) NOT NULL,
  "device_name" NVARCHAR2(64) NOT NULL,
  "manufacturer" NVARCHAR2(64) NOT NULL,
  "model" NVARCHAR2(64) NOT NULL,
  "firmware" NVARCHAR2(64) NOT NULL,
  "transport" NVARCHAR2(64) NOT NULL,
  "stream_mode" NVARCHAR2(64) NOT NULL,
  "online" NVARCHAR2(64) NOT NULL,
  "register_time" DATE NOT NULL,
  "last_connect_time" DATE,
  "active_time" DATE,
  "ip" NVARCHAR2(32),
  "port" NUMBER(20),
  "host_address" NVARCHAR2(32),
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sip_device"."device_id" IS '设备ID';
COMMENT ON COLUMN "sip_device"."product_id" IS '产品ID';
COMMENT ON COLUMN "sip_device"."product_name" IS '产品名称';
COMMENT ON COLUMN "sip_device"."device_sip_id" IS '设备SipID';
COMMENT ON COLUMN "sip_device"."device_name" IS '设备名称';
COMMENT ON COLUMN "sip_device"."manufacturer" IS '厂商名称';
COMMENT ON COLUMN "sip_device"."model" IS '产品型号';
COMMENT ON COLUMN "sip_device"."firmware" IS '固件版本';
COMMENT ON COLUMN "sip_device"."transport" IS '传输模式';
COMMENT ON COLUMN "sip_device"."stream_mode" IS '流模式';
COMMENT ON COLUMN "sip_device"."online" IS '在线状态';
COMMENT ON COLUMN "sip_device"."register_time" IS '注册时间';
COMMENT ON COLUMN "sip_device"."last_connect_time" IS '最后上线时间';
COMMENT ON COLUMN "sip_device"."active_time" IS '激活时间';
COMMENT ON COLUMN "sip_device"."ip" IS '设备入网IP';
COMMENT ON COLUMN "sip_device"."port" IS '设备接入端口号';
COMMENT ON COLUMN "sip_device"."host_address" IS '设备地址';
COMMENT ON COLUMN "sip_device"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "sip_device"."create_by" IS '创建者';
COMMENT ON COLUMN "sip_device"."create_time" IS '创建时间';
COMMENT ON COLUMN "sip_device"."update_by" IS '更新者';
COMMENT ON COLUMN "sip_device"."update_time" IS '更新时间';
COMMENT ON COLUMN "sip_device"."remark" IS '备注';
COMMENT ON TABLE "sip_device" IS '监控设备';

-- ----------------------------
-- Records of sip_device
-- ----------------------------
INSERT INTO "sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('9', '0', '', '13030300001170000008', '8E085C3RAJE156F', 'Dahua', 'DH-3H3205-ADW', '2.810.0000027.0.R,2022-08-26', 'UDP', 'UDP', '', TO_DATE('2023-02-27 12:07:35', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-02-26 23:36:45', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '177.7.0.1', '35332', '177.7.0.1:35332', '0', '', NULL, '', NULL, NULL);
INSERT INTO "sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('12', '0', '', '11010100001320000001', '海康威视摄像头', 'Hikvision', 'iDS-2DE2402IX-D3/W/XM', 'V5.7.4', 'UDP', 'UDP', '', TO_DATE('2024-01-09 23:29:52', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-01-09 23:35:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '192.168.2.119', '5065', '192.168.2.119:5065', '0', '', NULL, '', NULL, NULL);
INSERT INTO "sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('13', '0', '', '11010200001320000017', '', '', '', '', 'UDP', 'UDP', '', TO_DATE('2023-03-16 21:41:45', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-03-16 21:52:50', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '192.168.2.119', '5060', '192.168.2.119:5060', '0', '', NULL, '', NULL, NULL);
INSERT INTO "sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('16', '0', '', '12010100001320000003', 'IP DOME', 'Hikvision', 'iDS-2DE2402IX-D3/W/XM', 'V5.7.4', 'UDP', 'UDP', '', TO_DATE('2023-04-11 21:08:07', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-04-11 21:13:16', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '192.168.2.119', '5060', '192.168.2.119:5060', '0', '', NULL, '', NULL, NULL);
INSERT INTO "sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('18', '0', '', '13030100001320000001', '', 'ABCD', 'TEST001', 'V1.0', 'UDP', 'UDP', '', TO_DATE('2023-03-28 16:06:45', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-03-28 16:09:52', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '192.168.205.250', '5063', '192.168.205.250:5063', '0', '', NULL, '', NULL, NULL);
INSERT INTO "sip_device" ("device_id", "product_id", "product_name", "device_sip_id", "device_name", "manufacturer", "model", "firmware", "transport", "stream_mode", "online", "register_time", "last_connect_time", "active_time", "ip", "port", "host_address", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('19', '0', '', '11010200001320000001', '海康威视摄像头', 'Hikvision', 'iDS-2DE2402IX-D3/W/XM', 'V5.7.4', 'UDP', 'UDP', '', TO_DATE('2024-01-08 22:08:27', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-01-08 22:16:32', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '192.168.2.119', '5065', '192.168.2.119:5065', '0', '', NULL, '', NULL, NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sip_device_channel
-- ----------------------------
DROP TABLE "sip_device_channel";
CREATE TABLE "sip_device_channel" (
  "id" NUMBER(20) NOT NULL,
  "tenant_id" NUMBER(20) NOT NULL,
  "tenant_name" NVARCHAR2(30) NOT NULL,
  "product_id" NUMBER(20) NOT NULL,
  "product_name" NVARCHAR2(64) NOT NULL,
  "user_id" NUMBER(20) NOT NULL,
  "user_name" NVARCHAR2(64) NOT NULL,
  "device_sip_id" NVARCHAR2(64) NOT NULL,
  "channel_sip_id" NVARCHAR2(64) NOT NULL,
  "channel_name" NVARCHAR2(64) NOT NULL,
  "register_time" DATE,
  "device_type" NVARCHAR2(64),
  "channel_type" NVARCHAR2(64),
  "cityCode" NVARCHAR2(64) NOT NULL,
  "civilCode" NVARCHAR2(64) NOT NULL,
  "manufacture" NVARCHAR2(64) NOT NULL,
  "model" NVARCHAR2(64) NOT NULL,
  "owner" NVARCHAR2(64) NOT NULL,
  "block" NVARCHAR2(64) NOT NULL,
  "address" NVARCHAR2(64) NOT NULL,
  "parentId" NVARCHAR2(64) NOT NULL,
  "ipAddress" NVARCHAR2(32),
  "port" NUMBER(20),
  "password" NVARCHAR2(64) NOT NULL,
  "PTZType" NUMBER(20) NOT NULL,
  "PTZTypeText" NVARCHAR2(64) NOT NULL,
  "status" NUMBER(4) NOT NULL,
  "longitude" NUMBER(11,6),
  "latitude" NUMBER(11,6),
  "streamId" NVARCHAR2(64) NOT NULL,
  "subCount" NUMBER(20) NOT NULL,
  "parental" NUMBER(4) NOT NULL,
  "hasAudio" NUMBER(4) NOT NULL,
  "del_flag" NCHAR(1) NOT NULL,
  "create_by" NVARCHAR2(64) NOT NULL,
  "create_time" DATE NOT NULL,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sip_device_channel"."id" IS '主键';
COMMENT ON COLUMN "sip_device_channel"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "sip_device_channel"."tenant_name" IS '租户名称';
COMMENT ON COLUMN "sip_device_channel"."product_id" IS '产品ID';
COMMENT ON COLUMN "sip_device_channel"."product_name" IS '产品名称';
COMMENT ON COLUMN "sip_device_channel"."user_id" IS '产品ID';
COMMENT ON COLUMN "sip_device_channel"."user_name" IS '产品名称';
COMMENT ON COLUMN "sip_device_channel"."device_sip_id" IS '设备SipID';
COMMENT ON COLUMN "sip_device_channel"."channel_sip_id" IS '通道SipID';
COMMENT ON COLUMN "sip_device_channel"."channel_name" IS '通道名称';
COMMENT ON COLUMN "sip_device_channel"."register_time" IS '注册时间';
COMMENT ON COLUMN "sip_device_channel"."device_type" IS '设备类型';
COMMENT ON COLUMN "sip_device_channel"."channel_type" IS '通道类型';
COMMENT ON COLUMN "sip_device_channel"."cityCode" IS '城市编码';
COMMENT ON COLUMN "sip_device_channel"."civilCode" IS '行政区域';
COMMENT ON COLUMN "sip_device_channel"."manufacture" IS '厂商名称';
COMMENT ON COLUMN "sip_device_channel"."model" IS '产品型号';
COMMENT ON COLUMN "sip_device_channel"."owner" IS '设备归属';
COMMENT ON COLUMN "sip_device_channel"."block" IS '警区';
COMMENT ON COLUMN "sip_device_channel"."address" IS '安装地址';
COMMENT ON COLUMN "sip_device_channel"."parentId" IS '父级id';
COMMENT ON COLUMN "sip_device_channel"."ipAddress" IS '设备入网IP';
COMMENT ON COLUMN "sip_device_channel"."port" IS '设备接入端口号';
COMMENT ON COLUMN "sip_device_channel"."password" IS '密码';
COMMENT ON COLUMN "sip_device_channel"."PTZType" IS 'PTZ类型';
COMMENT ON COLUMN "sip_device_channel"."PTZTypeText" IS 'PTZ类型描述字符串';
COMMENT ON COLUMN "sip_device_channel"."status" IS '设备状态（1-未激活，2-禁用，3-在线，4-离线）';
COMMENT ON COLUMN "sip_device_channel"."longitude" IS '设备经度';
COMMENT ON COLUMN "sip_device_channel"."latitude" IS '设备纬度';
COMMENT ON COLUMN "sip_device_channel"."streamId" IS '流媒体ID';
COMMENT ON COLUMN "sip_device_channel"."subCount" IS '子设备数';
COMMENT ON COLUMN "sip_device_channel"."parental" IS '是否有子设备（1-有, 0-没有）';
COMMENT ON COLUMN "sip_device_channel"."hasAudio" IS '是否含有音频（1-有, 0-没有）';
COMMENT ON COLUMN "sip_device_channel"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "sip_device_channel"."create_by" IS '创建者';
COMMENT ON COLUMN "sip_device_channel"."create_time" IS '创建时间';
COMMENT ON COLUMN "sip_device_channel"."update_by" IS '更新者';
COMMENT ON COLUMN "sip_device_channel"."update_time" IS '更新时间';
COMMENT ON COLUMN "sip_device_channel"."remark" IS '备注';
COMMENT ON TABLE "sip_device_channel" IS '监控设备通道信息';

-- ----------------------------
-- Records of sip_device_channel
-- ----------------------------
INSERT INTO "sip_device_channel" ("id", "tenant_id", "tenant_name", "product_id", "product_name", "user_id", "user_name", "device_sip_id", "channel_sip_id", "channel_name", "register_time", "device_type", "channel_type", "cityCode", "civilCode", "manufacture", "model", "owner", "block", "address", "parentId", "ipAddress", "port", "password", "PTZType", "PTZTypeText", "status", "longitude", "latitude", "streamId", "subCount", "parental", "hasAudio", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('84', '1', 'admin', '118', '监控设备', '1', 'admin', '11010200001320000001', '11010200001320000001', 'IPdome', TO_DATE('2024-01-08 22:16:32', 'SYYYY-MM-DD HH24:MI:SS'), '132', '132', '北京市/市辖区/西城区', '3402000000', 'Hikvision', 'IP Camera', 'Owner', '', 'Address', '34020000002000000001', '', '0', '', '0', '', '3', '0.000000', '0.000000', 'gb_play_11010200001320000001_11010200001320000001', '0', '0', '0', '0', '', TO_DATE('2023-04-11 21:12:33', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sip_device_channel" ("id", "tenant_id", "tenant_name", "product_id", "product_name", "user_id", "user_name", "device_sip_id", "channel_sip_id", "channel_name", "register_time", "device_type", "channel_type", "cityCode", "civilCode", "manufacture", "model", "owner", "block", "address", "parentId", "ipAddress", "port", "password", "PTZType", "PTZTypeText", "status", "longitude", "latitude", "streamId", "subCount", "parental", "hasAudio", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('102', '1', 'admin', '135', '视频监控', '0', '', '11010100001320000001', '11010100001320000001', 'IPdome', TO_DATE('2024-01-09 23:35:00', 'SYYYY-MM-DD HH24:MI:SS'), '132', '132', '北京市/市辖区/东城区', '3402000000', 'Hikvision', 'IP Camera', 'Owner', '', 'Address', '34020000002000000001', '', '0', '', '0', '', '3', '0.000000', '0.000000', '', '0', '0', '0', '0', '', TO_DATE('2024-01-08 22:15:57', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_auth_user
-- ----------------------------
DROP TABLE "sys_auth_user";
CREATE TABLE "sys_auth_user" (
  "auth_id" NUMBER(20) NOT NULL,
  "uuid" NVARCHAR2(500) NOT NULL,
  "user_id" NUMBER(20) NOT NULL,
  "login_name" NVARCHAR2(30) NOT NULL,
  "user_name" NVARCHAR2(30),
  "avatar" NVARCHAR2(500),
  "email" NVARCHAR2(255),
  "source" NVARCHAR2(255),
  "create_time" DATE
)
;
COMMENT ON COLUMN "sys_auth_user"."auth_id" IS '授权ID';
COMMENT ON COLUMN "sys_auth_user"."uuid" IS '第三方平台用户唯一ID';
COMMENT ON COLUMN "sys_auth_user"."user_id" IS '系统用户ID';
COMMENT ON COLUMN "sys_auth_user"."login_name" IS '登录账号';
COMMENT ON COLUMN "sys_auth_user"."user_name" IS '用户昵称';
COMMENT ON COLUMN "sys_auth_user"."avatar" IS '头像地址';
COMMENT ON COLUMN "sys_auth_user"."email" IS '用户邮箱';
COMMENT ON COLUMN "sys_auth_user"."source" IS '用户来源';
COMMENT ON COLUMN "sys_auth_user"."create_time" IS '创建时间';
COMMENT ON TABLE "sys_auth_user" IS '第三方授权表';

-- ----------------------------
-- Records of sys_auth_user
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE "sys_config";
CREATE TABLE "sys_config" (
  "config_id" NUMBER(11) NOT NULL,
  "config_name" NVARCHAR2(100),
  "config_key" NVARCHAR2(100),
  "config_value" NVARCHAR2(500),
  "config_type" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sys_config"."config_id" IS '参数主键';
COMMENT ON COLUMN "sys_config"."config_name" IS '参数名称';
COMMENT ON COLUMN "sys_config"."config_key" IS '参数键名';
COMMENT ON COLUMN "sys_config"."config_value" IS '参数键值';
COMMENT ON COLUMN "sys_config"."config_type" IS '系统内置（Y是 N否）';
COMMENT ON COLUMN "sys_config"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_config"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "sys_config"."remark" IS '备注';
COMMENT ON TABLE "sys_config" IS '参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO "sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO "sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '初始化密码 123456');
INSERT INTO "sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO "sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('5', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-24 22:43:33', 'SYYYY-MM-DD HH24:MI:SS'), '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO "sys_config" ("config_id", "config_name", "config_key", "config_value", "config_type", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('6', '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', TO_DATE('2023-03-10 23:29:21', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '是否开启验证码功能（true开启，false关闭）');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE "sys_dept";
CREATE TABLE "sys_dept" (
  "dept_id" NUMBER(20) NOT NULL,
  "parent_id" NUMBER(20),
  "ancestors" NVARCHAR2(50),
  "dept_name" NVARCHAR2(30),
  "order_num" NUMBER(11),
  "leader" NVARCHAR2(20),
  "phone" NVARCHAR2(11),
  "email" NVARCHAR2(50),
  "status" NCHAR(1),
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE
)
;
COMMENT ON COLUMN "sys_dept"."dept_id" IS '部门id';
COMMENT ON COLUMN "sys_dept"."parent_id" IS '父部门id';
COMMENT ON COLUMN "sys_dept"."ancestors" IS '祖级列表';
COMMENT ON COLUMN "sys_dept"."dept_name" IS '部门名称';
COMMENT ON COLUMN "sys_dept"."order_num" IS '显示顺序';
COMMENT ON COLUMN "sys_dept"."leader" IS '负责人';
COMMENT ON COLUMN "sys_dept"."phone" IS '联系电话';
COMMENT ON COLUMN "sys_dept"."email" IS '邮箱';
COMMENT ON COLUMN "sys_dept"."status" IS '部门状态（0正常 1停用）';
COMMENT ON COLUMN "sys_dept"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "sys_dept"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_dept"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_dept"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_dept"."update_time" IS '更新时间';
COMMENT ON TABLE "sys_dept" IS '部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('100', '0', '0', '蜂信物联', '0', 'FastBee', '15888888888', '164770707@qq.com', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-26 23:06:24', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('101', '100', '0,100', '北京总公司', '1', '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-03-09 16:49:53', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('102', '100', '0,100', '深圳分公司', '2', '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-26 23:06:07', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('103', '101', '0,100,101', '研发部门', '1', '物美', '15888888888', '164770707@qq.com', '1', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-02-01 23:12:40', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('104', '101', '0,100,101', '市场部门', '2', '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL);
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('105', '101', '0,100,101', '测试部门', '3', '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL);
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('106', '101', '0,100,101', '财务部门', '4', '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL);
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('107', '101', '0,100,101', '运维部门', '5', '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL);
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('108', '102', '0,100,102', '市场部门', '1', '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL);
INSERT INTO "sys_dept" ("dept_id", "parent_id", "ancestors", "dept_name", "order_num", "leader", "phone", "email", "status", "del_flag", "create_by", "create_time", "update_by", "update_time") VALUES ('109', '102', '0,100,102', '财务部门', '2', '物美', '15888888888', '164770707@qq.com', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE "sys_dict_data";
CREATE TABLE "sys_dict_data" (
  "dict_code" NUMBER(20) NOT NULL,
  "dict_sort" NUMBER(11),
  "dict_label" NVARCHAR2(100),
  "dict_value" NVARCHAR2(100),
  "dict_type" NVARCHAR2(100),
  "css_class" NVARCHAR2(100),
  "list_class" NVARCHAR2(100),
  "is_default" NCHAR(1),
  "status" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sys_dict_data"."dict_code" IS '字典编码';
COMMENT ON COLUMN "sys_dict_data"."dict_sort" IS '字典排序';
COMMENT ON COLUMN "sys_dict_data"."dict_label" IS '字典标签';
COMMENT ON COLUMN "sys_dict_data"."dict_value" IS '字典键值';
COMMENT ON COLUMN "sys_dict_data"."dict_type" IS '字典类型';
COMMENT ON COLUMN "sys_dict_data"."css_class" IS '样式属性（其他样式扩展）';
COMMENT ON COLUMN "sys_dict_data"."list_class" IS '表格回显样式';
COMMENT ON COLUMN "sys_dict_data"."is_default" IS '是否默认（Y是 N否）';
COMMENT ON COLUMN "sys_dict_data"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "sys_dict_data"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_dict_data"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_dict_data"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_dict_data"."update_time" IS '更新时间';
COMMENT ON COLUMN "sys_dict_data"."remark" IS '备注';
COMMENT ON TABLE "sys_dict_data" IS '字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '性别男');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '2', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '性别女');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '性别未知');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('4', '1', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '显示菜单');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('5', '2', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '隐藏菜单');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('6', '1', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '正常状态');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('7', '2', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '停用状态');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('8', '1', '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '正常状态');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('9', '2', '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '停用状态');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('10', '1', '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '默认分组');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('11', '2', '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '系统分组');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('12', '1', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '系统默认是');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('13', '2', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '系统默认否');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('14', '1', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '通知');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('15', '2', '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '公告');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('16', '1', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '正常状态');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('17', '2', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '关闭状态');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('18', '1', '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '新增操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('19', '2', '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '修改操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('20', '3', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '删除操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('21', '4', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '授权操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('22', '5', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '导出操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('23', '6', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '导入操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('24', '7', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '强退操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('25', '8', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '生成操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('26', '9', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '清空操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('27', '1', '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '正常状态');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('28', '2', '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '停用状态');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('100', '1', '属性', '1', 'iot_things_type', '', 'primary', 'Y', '0', 'admin', TO_DATE('2021-12-12 16:41:15', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-15 22:49:37', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('101', '2', '功能', '2', 'iot_things_type', '', 'success', 'Y', '0', 'admin', TO_DATE('2021-12-12 16:43:33', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-14 16:33:11', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('102', '3', '事件', '3', 'iot_things_type', NULL, 'warning', 'Y', '0', 'admin', TO_DATE('2021-12-12 16:46:04', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('103', '1', '整数', 'integer', 'iot_data_type', '', '', 'Y', '0', 'admin', TO_DATE('2021-12-12 20:20:46', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-14 16:09:56', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('104', '2', '小数', 'decimal', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', TO_DATE('2021-12-12 20:21:21', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-15 22:51:07', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('105', '3', '布尔', 'bool', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', TO_DATE('2021-12-12 20:22:12', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-15 22:51:02', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('106', '4', '枚举', 'enum', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', TO_DATE('2021-12-12 20:22:37', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-15 22:50:57', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('107', '5', '字符串', 'string', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', TO_DATE('2021-12-12 20:22:54', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-15 22:50:52', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('108', '1', '是', '1', 'iot_yes_no', '', 'default', 'Y', '0', 'admin', TO_DATE('2021-12-12 20:25:14', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-02 13:39:09', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('109', '2', '否', '0', 'iot_yes_no', '', 'default', 'Y', '0', 'admin', TO_DATE('2021-12-12 20:25:25', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-02 13:39:15', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('110', '6', '数组', 'array', 'iot_data_type', NULL, 'default', 'Y', '0', 'admin', TO_DATE('2021-12-13 18:18:04', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-15 22:50:42', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('111', '1', '未发布', '1', 'iot_product_status', NULL, 'info', 'N', '0', 'admin', TO_DATE('2021-12-19 15:01:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-19 15:01:55', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('112', '2', '已发布', '2', 'iot_product_status', NULL, 'success', 'N', '0', 'admin', TO_DATE('2021-12-19 15:01:43', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('113', '1', '直连设备', '1', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-19 15:03:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-19 15:10:13', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('114', '2', '网关设备', '2', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-19 15:04:28', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-09 16:25:46', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('116', '1', 'WIFI', '1', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-19 15:07:35', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-22 00:11:19', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('117', '2', '蜂窝(2G/3G/4G/5G)', '2', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-19 15:08:30', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-14 02:12:27', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('118', '3', '以太网', '3', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-19 15:09:08', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-14 02:12:39', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('119', '1', '简单认证', '1', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-19 15:13:16', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-05 00:14:48', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('120', '2', '加密认证', '2', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-19 15:13:26', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-05 00:14:57', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('122', '1', 'ESP8266/Arduino', '1', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-24 15:54:52', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-24 16:07:31', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('123', '3', 'ESP32/Arduino', '2', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-24 15:55:04', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-24 16:07:26', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('124', '2', 'ESP8266/RTOS', '3', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-24 15:56:08', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-24 16:07:17', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('127', '4', 'ESP32/ESP-IDF', '4', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-24 16:07:54', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('128', '5', '树莓派/Python', '5', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', TO_DATE('2021-12-24 16:08:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('129', '0', '未激活', '1', 'iot_device_status', NULL, 'warning', 'N', '0', 'admin', TO_DATE('2021-12-27 22:21:04', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-27 22:22:09', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('130', '0', '禁用', '2', 'iot_device_status', NULL, 'danger', 'N', '0', 'admin', TO_DATE('2021-12-27 22:21:22', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('131', '0', '在线', '3', 'iot_device_status', NULL, 'success', 'N', '0', 'admin', TO_DATE('2021-12-27 22:21:42', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('132', '0', '离线', '4', 'iot_device_status', NULL, 'info', 'N', '0', 'admin', TO_DATE('2021-12-27 22:22:01', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('133', '0', '启用', '1', 'iot_is_enable', NULL, 'success', 'N', '0', 'admin', TO_DATE('2022-01-12 23:25:08', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-12 23:25:30', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('134', '0', '禁用', '0', 'iot_is_enable', NULL, 'info', 'N', '0', 'admin', TO_DATE('2022-01-12 23:25:19', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-12 23:25:38', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('135', '0', '提醒通知', '1', 'iot_alert_level', NULL, 'success', 'N', '0', 'admin', TO_DATE('2022-01-13 14:58:10', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-13 14:58:31', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('136', '0', '轻微问题', '2', 'iot_alert_level', NULL, 'warning', 'N', '0', 'admin', TO_DATE('2022-01-13 14:59:00', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('137', '0', '严重警告', '3', 'iot_alert_level', NULL, 'danger', 'N', '0', 'admin', TO_DATE('2022-01-13 14:59:16', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('138', '0', '不需要处理', '1', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-01-13 15:06:03', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('139', '0', '未处理', '2', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-01-13 15:06:14', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('140', '0', '已处理', '3', 'iot_process_status', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-01-13 15:06:24', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('141', '1', '属性上报', '1', 'iot_device_log_type', NULL, 'primary', 'N', '0', 'admin', TO_DATE('2022-01-13 15:10:32', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-03-13 00:20:25', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('142', '3', '事件上报', '3', 'iot_device_log_type', NULL, 'danger', 'N', '0', 'admin', TO_DATE('2022-01-13 15:10:43', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-03-13 00:21:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('143', '2', '功能调用', '2', 'iot_device_log_type', NULL, 'warning', 'N', '0', 'admin', TO_DATE('2022-01-13 15:10:55', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-03-13 00:20:32', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('144', '4', '设备升级', '4', 'iot_device_log_type', NULL, 'success', 'N', '0', 'admin', TO_DATE('2022-01-13 15:11:08', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-03-13 00:21:06', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('145', '5', '设备上线', '5', 'iot_device_log_type', NULL, 'success', 'N', '0', 'admin', TO_DATE('2022-01-13 15:11:23', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-03-13 00:21:26', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('146', '6', '设备离线', '6', 'iot_device_log_type', NULL, 'info', 'N', '0', 'admin', TO_DATE('2022-01-13 15:11:32', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-03-13 00:21:13', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('147', '4', '其他', '4', 'iot_network_method', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-01-14 02:12:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-14 02:13:03', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('148', '6', '安卓/Android', '6', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-01-16 12:39:27', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('149', '7', '其他', '7', 'iot_device_chip', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-01-16 12:39:55', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-16 12:40:13', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('150', '1', '小度平台', '1', 'oauth_platform', NULL, 'primary', 'N', '0', 'admin', TO_DATE('2022-02-07 20:29:23', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-02-07 22:24:28', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('151', '2', '天猫精灵', '2', 'oauth_platform', NULL, 'danger', 'N', '0', 'admin', TO_DATE('2022-02-07 20:29:41', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-02-07 22:23:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('152', '3', '小米小爱', '3', 'oauth_platform', NULL, 'success', 'N', '0', 'admin', TO_DATE('2022-02-07 20:30:07', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-02-07 22:23:24', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('153', '4', '其他平台', '4', 'oauth_platform', NULL, 'warning', 'N', '0', 'admin', TO_DATE('2022-02-07 22:23:52', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-02-07 22:24:02', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('154', '1', '微信登录', 'WECHAT', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-04-20 16:41:33', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-22 10:27:54', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('155', '2', 'QQ登录', 'QQ', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-04-20 16:42:46', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-22 10:28:03', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('156', '0', '启用', '0', 'iot_social_platform_status', NULL, 'success', 'N', '0', 'admin', TO_DATE('2022-04-20 17:02:48', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-12 17:39:40', 'SYYYY-MM-DD HH24:MI:SS'), '启用');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('157', '1', '未启用', '1', 'iot_social_platform_status', NULL, 'info', 'N', '0', 'admin', TO_DATE('2022-04-20 17:03:15', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-21 13:44:13', 'SYYYY-MM-DD HH24:MI:SS'), '禁用');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('158', '3', '支付宝', 'ALIPAY', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-05-12 17:49:24', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-12 17:50:21', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('159', '1', '自动定位', '1', 'iot_location_way', NULL, 'success', 'N', '0', 'admin', TO_DATE('2022-05-21 13:46:51', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-21 13:53:23', 'SYYYY-MM-DD HH24:MI:SS'), 'IP定位，精确到城市');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('160', '2', '设备定位', '2', 'iot_location_way', NULL, 'warning', 'N', '0', 'admin', TO_DATE('2022-05-21 13:46:51', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-21 13:49:21', 'SYYYY-MM-DD HH24:MI:SS'), '最精确定位');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('161', '3', '自定义位置', '3', 'iot_location_way', NULL, 'primary', 'N', '0', 'admin', TO_DATE('2022-05-21 13:48:50', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-21 13:55:45', 'SYYYY-MM-DD HH24:MI:SS'), '位置自定义');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('162', '3', '简单+加密', '3', 'iot_vertificate_method', NULL, 'default', 'N', '0', 'admin', TO_DATE('2022-06-05 00:15:46', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('163', '1', '未使用', '1', 'iot_auth_status', NULL, 'info', 'N', '0', 'admin', TO_DATE('2022-06-07 17:39:22', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-07 17:40:10', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('164', '2', '已使用', '2', 'iot_auth_status', NULL, 'success', 'N', '0', 'admin', TO_DATE('2022-06-07 17:40:01', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-07 23:21:49', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('165', '7', '对象', 'object', 'iot_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-09 16:20:57', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-09 16:21:08', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('166', '3', '监控设备', '3', 'iot_device_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-09 16:26:00', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('169', '0', 'DVR', '111', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:07:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('170', '1', 'NVR', '118', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:07:59', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('171', '2', '报警控制器', '117', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:08:13', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-22 01:08:35', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('172', '4', '摄像机', '131', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:08:52', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('173', '5', 'IPC', '132', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:09:11', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('174', '6', '显示器', '133', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:09:30', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('175', '7', '报警输入设备', '134', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:09:49', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('176', '8', '报警输出设备', '135', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:10:08', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('177', '9', '语音输入设备', '136', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:10:29', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('178', '10', '语音输出设备', '137', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:10:46', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-22 01:10:51', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('179', '11', '移动传输设备', '138', 'video_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:11:09', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('180', '0', '报警控制器', '117', 'channel_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:12:09', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('181', '1', '摄像机', '131', 'channel_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:12:24', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('182', '2', 'IPC', '132', 'channel_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:12:39', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('183', '3', '显示器', '133', 'channel_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:12:57', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('184', '5', '报警输入设备', '134', 'channel_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:13:14', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('185', '6', '报警输出设备', '135', 'channel_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:13:29', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-22 01:13:49', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('186', '7', '语音输入设备', '136', 'channel_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:14:14', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-22 01:14:24', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('187', '8', '语音输出设备', '137', 'channel_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:14:50', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('188', '9', '移动传输设备', '138', 'channel_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-02-22 01:15:11', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('198', '0', 'MQTT', 'MQTT', 'iot_transport_type', NULL, 'primary', 'N', '0', 'admin', TO_DATE('2023-02-28 16:35:40', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-19 16:23:48', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('230', '99', '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', TO_DATE('2023-03-10 23:28:32', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '其他操作');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('231', '0', '事件上报', '3', 'iot_event_type', NULL, 'danger', 'N', '0', 'admin', TO_DATE('2023-03-29 00:25:28', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('232', '0', '设备上线', '5', 'iot_event_type', NULL, 'success', 'N', '0', 'admin', TO_DATE('2023-03-29 00:25:52', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('233', '0', '设备离线', '6', 'iot_event_type', NULL, 'info', 'N', '0', 'admin', TO_DATE('2023-03-29 00:26:09', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('234', '0', '服务下发', '1', 'iot_function_type', NULL, 'primary', 'N', '0', 'admin', TO_DATE('2023-03-29 00:38:26', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('235', '0', '属性获取', '2', 'iot_function_type', NULL, 'success', 'N', '0', 'admin', TO_DATE('2023-03-29 00:38:44', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('237', '0', '读写', '0', 'iot_data_read_write', NULL, 'primary', 'N', '0', 'admin', TO_DATE('2023-04-09 02:12:05', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('238', '0', '只读', '1', 'iot_data_read_write', NULL, 'info', 'N', '0', 'admin', TO_DATE('2023-04-09 02:12:19', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('239', '0', '全部设备', '1', 'oat_update_limit', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-04-09 23:57:06', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-11 11:53:57', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('240', '1', '指定设备', '2', 'oat_update_limit', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-04-11 11:53:28', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-11 11:53:52', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('241', '4', 'GB28181', 'GB28181', 'iot_transport_type', NULL, 'success', 'N', '0', 'admin', TO_DATE('2023-05-12 14:25:39', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-19 16:24:12', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('242', '1', '02(读离散量输入)', '2', 'iot_modbus_status_code', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-07-03 10:16:48', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-07-03 10:17:35', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('243', '3', '04(读输入寄存器)', '4', 'iot_modbus_status_code', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-07-03 10:17:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-07-03 10:17:58', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('247', '4', '微信开放平台网站应用', 'wechat_open_web', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('248', '5', '微信开放平台移动应用', 'wechat_open_mobile', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:29:14', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('249', '6', '微信开放平台小程序', 'wechat_open_mini_program', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:38:12', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('250', '0', '16位 无符号', 'ushort', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-04 14:11:54', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('251', '1', '16位 有符号', 'short', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-04 14:12:26', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('252', '2', '32位 有符号(ABCD)', 'long-ABCD', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-04 14:12:53', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('253', '3', '32位 有符号(CDAB)', 'long-CDAB', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-04 14:13:21', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('254', '4', '32位 无符号(ABCD)', 'ulong-ABCD', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-04 14:13:42', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('255', '5', '32位 无符号(CDAB)', 'ulong-CDAB', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-04 14:14:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('256', '6', '32位 浮点数(ABCD)', 'float-ABCD', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-04 14:14:28', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('257', '7', '32位 浮点数(CDAB)', 'float-CDAB', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-04 14:14:50', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('258', '8', '位', 'bit', 'iot_modbus_data_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-04 14:15:13', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('259', '0', '电灯', 'LIGHT', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('260', '0', '空调', 'AIR_CONDITION', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('261', '0', '窗帘', 'CURTAIN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('262', '0', '窗纱', 'CURT_SIMP', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('263', '0', '插座', 'SOCKET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('264', '0', '开关', 'SWITCH', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('265', '0', '冰箱', 'FRIDGE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('266', '0', '净水器', 'WATER_PURIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('267', '0', '加湿器', 'HUMIDIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('268', '0', '除湿器', 'DEHUMIDIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('269', '0', '电磁炉', 'INDUCTION_COOKER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('270', '0', '空气净化器', 'AIR_PURIFIER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('271', '0', '洗衣机', 'WASHING_MACHINE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('272', '0', '热水器', 'WATER_HEATER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('273', '0', '燃气灶', 'GAS_STOVE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('274', '0', '电视机', 'TV_SET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('275', '0', '网络盒子', 'OTT_BOX', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('276', '0', '油烟机', 'RANGE_HOOD', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('277', '0', '电风扇', 'FAN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('278', '0', '投影仪', 'PROJECTOR', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('279', '0', '扫地机器人', 'SWEEPING_ROBOT', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('280', '0', '热水壶', 'KETTLE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('281', '0', '微波炉', 'MICROWAVE_OVEN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('282', '0', '压力锅', 'PRESSURE_COOKER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('283', '0', '电饭煲', 'RICE_COOKER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('284', '0', '破壁机', 'HIGH_SPEED_BLENDER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('285', '0', '新风机', 'AIR_FRESHER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('286', '0', '晾衣架', 'CLOTHES_RACK', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('287', '0', '烤箱设备', 'OVEN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('288', '0', '蒸烤箱', 'STEAM_OVEN', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('289', '0', '蒸箱', 'STEAM_BOX', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('290', '0', '电暖器', 'HEATER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('291', '0', '开窗器', 'WINDOW_OPENER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('292', '0', '摄像头', 'WEBCAM', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('293', '0', '相机', 'CAMERA', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('294', '0', '机器人', 'ROBOT', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('295', '0', '打印机', 'PRINTER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('296', '0', '饮水机', 'WATER_COOLER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('297', '0', '鱼缸', 'FISH_TANK', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('298', '0', '浇花器', 'WATERING_DEVICE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('299', '0', '机顶盒', 'SET_TOP_BOX', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('300', '0', '香薰机', 'AROMATHERAPY_MACHINE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('301', '0', 'DVD', 'DVD', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('302', '0', '鞋柜', 'SHOE_CABINET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('303', '0', '走步机', 'WALKING_MACHINE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('304', '0', '跑步机', 'TREADMILL', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('305', '0', '床', 'BED', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('306', '0', '浴霸', 'YUBA', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('307', '0', '花洒', 'SHOWER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('308', '0', '浴缸', 'BATHTUB', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('309', '0', '消毒柜', 'DISINFECTION_CABINET', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('310', '0', '洗碗机', 'DISHWASHER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('311', '0', '沙发品类', 'SOFA', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('312', '0', '门铃', 'DOOR_BELL', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('313', '0', '电梯', 'ELEVATOR', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('314', '0', '体重秤', 'WEIGHT_SCALE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('315', '0', '体脂秤', 'BODY_FAT_SCALE', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('316', '0', '壁挂炉', 'WALL_HUNG_GAS_BOILER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('317', '0', '特定设备的组合场景', 'SCENE_TRIGGER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '描述特定设备的组合场景，设备之间没有相互关联，无特定操作顺序。 例如“打开睡眠模式”包括关灯和锁上房门，但是关灯和锁上房门之间没有必然联系，可以先关灯然后锁上房门，也可以先锁上房门后关灯');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('318', '0', '特定设备的组合场景', 'ACTIVITY_TRIGGER', 'dueros_related_device', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-08-23 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '描述特定设备的组合场景。场景中的设备必须以指定顺序操作。如“观看优酷视频”场景中必须先打开电视机，然后打开HDMI1');
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('319', '0', '打开', 'turnOn', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('320', '0', '关闭', 'turnOff', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('321', '0', '定时打开', 'timingTurnOn', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('322', '0', '定时关闭', 'timingTurnOff', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('323', '0', '暂停', 'pause', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('324', '0', '继续', 'continue', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('325', '0', '设置颜色', 'setColor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('326', '0', '设置灯光色温', 'setColorTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('327', '0', '增高灯光色温', 'incrementColorTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('328', '0', '降低灯光色温', 'decrementColorTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('329', '0', '设置灯光亮度', 'setBrightnessPercentage', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('330', '0', '调亮灯光', 'incrementBrightnessPercentage', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('331', '0', '调暗灯光', 'decrementBrightnessPercentage', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('332', '0', '设置功率', 'setPower', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('333', '0', '增大功率', 'incrementPower', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('334', '0', '减小功率', 'decrementPower', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('335', '0', '升高温度', 'incrementTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('336', '0', '降低温度', 'decrementTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('337', '0', '设置温度', 'setTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('338', '0', '增加风速', 'incrementFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('339', '0', '减小风速', 'decrementFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('340', '0', '设置风速', 'setFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('341', '0', '设置档位', 'setGear', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('342', '0', '设置模式', 'setMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('343', '0', '取消设置的模式', 'unSetMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('344', '0', '定时设置模式', 'timingSetMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('345', '0', '定时取消设置的模式', 'timingUnsetMode', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('346', '0', '调高音量', 'incrementVolume', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('347', '0', '调低音量', 'decrementVolume', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('348', '0', '设置音量', 'setVolume', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('349', '0', '设置静音状态', 'setVolumeMute', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('350', '0', '上一个频道', 'decrementTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('351', '0', '下一个频道', 'incrementTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('352', '0', '设置频道', 'setTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('353', '0', '返回上个频道', 'returnTVChannel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('354', '0', '开始充电', 'chargeTurnOn', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('355', '0', '停止充电', 'chargeTurnOff', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('356', '0', '查询开关状态', 'getTurnOnState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('357', '0', '查询油量', 'getOilCapacity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('358', '0', '查询电量', 'getElectricityCapacity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('359', '0', '上锁/解锁', 'setLockState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('360', '0', '查询锁状态', 'getLockState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('361', '0', '设置吸力', 'setSuction', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('362', '0', '设置水量', 'setWaterLevel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('363', '0', '设置清扫位置', 'setCleaningLocation', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('364', '0', '执行自定义复杂动作', 'setComplexActions', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('365', '0', '设置移动方向', 'setDirection', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('366', '0', '打印', 'submitPrint', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('367', '0', '查询PM2.5', 'getAirPM25', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('368', '0', '查询PM10', 'getAirPM10', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('369', '0', '查询二氧化碳含量', 'getCO2Quantity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('370', '0', '查询空气质量', 'getAirQualityIndex', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('371', '0', '查询温度（当前温度和目标温度）', 'getTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('372', '0', '查询当前温度', 'getTemperatureReading', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('373', '0', '查询目标温度', 'getTargetTemperature', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('374', '0', '查询湿度', 'getHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('375', '0', '查询目标湿度', 'getTargetHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('376', '0', '查询水质', 'getWaterQuality', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('377', '0', '查询设备所有状态', 'getState', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('378', '0', '查询剩余时间', 'getTimeLeft', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('379', '0', '查询运行状态', 'getRunningStatus', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('380', '0', '查询运行时间', 'getRunningTime', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('381', '0', '查询设备所在位置', 'getLocation', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('382', '0', '设备定时', 'setTimer', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('383', '0', '取消设备定时', 'timingCancel', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('384', '0', '设备复位', 'reset', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('385', '0', '升高高度', 'incrementHeight', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('386', '0', '降低高度', 'decrementHeight', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('387', '0', '设置摆风角度', 'setSwingAngle', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('388', '0', '查询风速', 'getFanSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('389', '0', '设置湿度模式', 'setHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('390', '0', '增大湿度', 'incrementHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('391', '0', '降低湿度', 'decrementHumidity', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('392', '0', '增大雾量', 'incrementMist', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('393', '0', '见效雾量', 'decrementMist', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('394', '0', '设置雾量', 'setMist', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('395', '0', '设备启动', 'startUp', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('396', '0', '设置电梯楼层', 'setFloor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('397', '0', '电梯按下', 'decrementFloor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('398', '0', '电梯按上', 'incrementFloor', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('399', '0', '增加速度', 'incrementSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('400', '0', '降低速度', 'decrementSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('401', '0', '设置速度', 'setSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('402', '0', '获取速度', 'getSpeed', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('403', '0', '获取跑步信息', 'getMotionInfo', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('404', '0', '打开灶眼', 'turnOnBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('405', '0', '关闭灶眼', 'turnOffBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('406', '0', '定时打开灶眼', 'timingTurnOnBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('407', '0', '定时关闭灶眼', 'timingTurnOffBurner', 'dueros_operate_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-09-22 10:35:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('408', '7', '微信开放平台网站应用个人中心绑定', 'wechat_open_web_bind', 'iot_social_platform', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-10-09 11:28:15', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('749', '1', 'Java脚本引擎', 'java', 'rule_script_language', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-11-04 01:51:09', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-11-04 01:51:42', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('750', '2', 'JavaScript脚本引擎', 'js', 'rule_script_language', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-11-04 01:51:36', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-11-05 10:28:30', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('751', '1', '普通脚本节点', 'script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-11-04 01:53:11', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('752', '2', '选择脚本节点 (switch)', 'switch_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-11-04 01:53:32', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-11-04 01:56:44', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('753', '3', '条件脚本节点 (if)', 'if_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-11-04 01:53:48', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-11-04 01:56:55', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('754', '4', '数量循环节点 (for)', 'for_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-11-04 01:54:11', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-11-04 01:57:07', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('755', '5', '条件循环节点 (while)', 'while_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-11-04 01:54:30', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-11-04 01:57:16', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('756', '6', '退出循环节点 (break)', 'break_script', 'rule_script_type', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-11-04 01:54:50', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-11-04 01:57:29', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('757', '3', 'groovy脚本引擎', 'groovy', 'rule_script_language', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-11-05 10:29:14', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('767', '1', '设备上报', '1', 'rule_script_event', NULL, 'primary', 'N', '0', 'admin', TO_DATE('2023-12-19 11:40:34', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-12-20 02:23:43', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('768', '2', '平台下发', '2', 'rule_script_event', NULL, 'warning', 'N', '0', 'admin', TO_DATE('2023-12-19 11:40:46', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-12-20 02:23:51', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('769', '3', '设备上线', '3', 'rule_script_event', NULL, 'success', 'N', '0', 'admin', TO_DATE('2023-12-19 11:40:58', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-12-20 02:24:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('770', '4', '设备离线', '4', 'rule_script_event', NULL, 'info', 'N', '0', 'admin', TO_DATE('2023-12-19 11:41:09', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-12-20 02:24:08', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('771', '1', '数据流', '1', 'rule_script_purpose', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-12-19 11:41:39', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('772', '2', '触发器', '2', 'rule_script_purpose', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-12-19 11:41:48', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('773', '3', '执行动作', '3', 'rule_script_purpose', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-12-19 11:41:59', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('774', '1', '消息重发', '1', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-12-19 11:42:26', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('775', '2', '消息通知', '2', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-12-19 11:43:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-12-19 11:43:38', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('776', '3', 'Http推送', '3', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-12-19 11:43:33', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_data" ("dict_code", "dict_sort", "dict_label", "dict_value", "dict_type", "css_class", "list_class", "is_default", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('777', '4', 'Mqtt桥接', '4', 'rule_script_action', NULL, 'default', 'N', '0', 'admin', TO_DATE('2023-12-19 11:43:54', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE "sys_dict_type";
CREATE TABLE "sys_dict_type" (
  "dict_id" NUMBER(20) NOT NULL,
  "dict_name" NVARCHAR2(100),
  "dict_type" NVARCHAR2(100),
  "status" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sys_dict_type"."dict_id" IS '字典主键';
COMMENT ON COLUMN "sys_dict_type"."dict_name" IS '字典名称';
COMMENT ON COLUMN "sys_dict_type"."dict_type" IS '字典类型';
COMMENT ON COLUMN "sys_dict_type"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "sys_dict_type"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_dict_type"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_dict_type"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_dict_type"."update_time" IS '更新时间';
COMMENT ON COLUMN "sys_dict_type"."remark" IS '备注';
COMMENT ON TABLE "sys_dict_type" IS '字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '用户性别列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '菜单状态列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '系统开关列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '任务状态列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '任务分组列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '系统是否列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '通知类型列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '通知状态列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '操作类型列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '登录状态列表');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('100', '物模型类别', 'iot_things_type', '0', 'admin', TO_DATE('2021-12-12 16:39:47', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-15 22:49:19', 'SYYYY-MM-DD HH24:MI:SS'), '属性、动作、事件');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('101', '数据类型', 'iot_data_type', '0', 'admin', TO_DATE('2021-12-12 20:16:48', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-12 20:17:54', 'SYYYY-MM-DD HH24:MI:SS'), 'integer、decimal、bool、string、enum');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('102', '是否', 'iot_yes_no', '0', 'admin', TO_DATE('2021-12-12 20:24:51', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-19 15:12:35', 'SYYYY-MM-DD HH24:MI:SS'), '是、否');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('103', '产品状态', 'iot_product_status', '0', 'admin', TO_DATE('2021-12-19 15:00:13', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '未发布、已发布（不能修改）');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('104', '设备类型', 'iot_device_type', '0', 'admin', TO_DATE('2021-12-19 15:03:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '直连设备、网关子设备、网关设备');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('105', '联网方式', 'iot_network_method', '0', 'admin', TO_DATE('2021-12-19 15:07:12', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-14 02:11:58', 'SYYYY-MM-DD HH24:MI:SS'), 'wifi、蜂窝(2G/3G/4G/5G)、以太网、其他');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('106', '认证方式', 'iot_vertificate_method', '0', 'admin', TO_DATE('2021-12-19 15:11:48', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-05 12:57:02', 'SYYYY-MM-DD HH24:MI:SS'), '1=简单认证、2=加密认证、3=简单+加密');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('107', '设备芯片', 'iot_device_chip', '0', 'admin', TO_DATE('2021-12-24 15:53:27', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-22 00:14:23', 'SYYYY-MM-DD HH24:MI:SS'), 'ESP8266、ESP32、树莓派');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('109', '设备状态', 'iot_device_status', '0', 'admin', TO_DATE('2021-12-27 22:19:55', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-27 22:20:13', 'SYYYY-MM-DD HH24:MI:SS'), '未激活、禁用、在线、离线');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('110', '是否启用', 'iot_is_enable', '0', 'admin', TO_DATE('2022-01-12 23:24:01', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-12 23:24:15', 'SYYYY-MM-DD HH24:MI:SS'), '启用、禁用');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('111', '告警类型', 'iot_alert_level', '0', 'admin', TO_DATE('2022-01-13 14:56:44', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-13 15:04:46', 'SYYYY-MM-DD HH24:MI:SS'), '1=提醒通知，2=轻微问题，3=严重警告');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('112', '处理状态', 'iot_process_status', '0', 'admin', TO_DATE('2022-01-13 15:04:06', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-13 15:06:39', 'SYYYY-MM-DD HH24:MI:SS'), '1=不需要处理,2=未处理,3=已处理');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('113', '设备日志类型', 'iot_device_log_type', '0', 'admin', TO_DATE('2022-01-13 15:09:49', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-03-13 00:22:43', 'SYYYY-MM-DD HH24:MI:SS'), '1=属性上报，2=调用功能,3=事件上报，4=设备升级，5=设备上线，6=设备离线');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('114', 'Oauth开放平台', 'oauth_platform', '0', 'admin', TO_DATE('2022-02-07 20:27:48', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-21 13:44:50', 'SYYYY-MM-DD HH24:MI:SS'), '1=小度，2=天猫精灵，3=小爱，4=其他');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('115', '第三方登录平台', 'iot_social_platform', '0', 'admin', TO_DATE('2022-04-12 15:28:13', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-04-12 15:37:48', 'SYYYY-MM-DD HH24:MI:SS'), 'Wechat、QQ、');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('116', '第三方登录平台状态', 'iot_social_platform_status', '0', 'admin', TO_DATE('2022-04-20 17:02:13', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-04-20 17:02:23', 'SYYYY-MM-DD HH24:MI:SS'), '第三方登录平台状态');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('117', '设备定位方式', 'iot_location_way', '0', 'admin', TO_DATE('2022-05-21 13:45:16', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-21 13:46:06', 'SYYYY-MM-DD HH24:MI:SS'), '1=IP自动定位，2=设备定位，3=自定义');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('118', '授权码状态', 'iot_auth_status', '0', 'admin', TO_DATE('2022-06-07 17:38:56', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '1=未分配，2=使用中');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('119', 'SipID状态', 'sip_gen_status', '0', 'admin', TO_DATE('2023-02-19 15:43:36', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-19 15:45:54', 'SYYYY-MM-DD HH24:MI:SS'), '1=未使用，2=使用中');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('120', '监控设备类型', 'video_type', '0', 'admin', TO_DATE('2023-02-22 01:06:38', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('121', '通道类型', 'channel_type', '0', 'admin', TO_DATE('2023-02-22 01:11:51', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('122', '轮询方式', 'data_collect_type', '0', 'admin', TO_DATE('2023-02-28 13:55:45', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('123', '批量采集时间', 'iot_modbus_poll_time', '0', 'admin', TO_DATE('2023-02-28 14:38:21', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('124', '寄存器功能码', 'iot_modbus_status_code', '0', 'admin', TO_DATE('2023-02-28 15:19:02', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('125', '传输协议类型', 'iot_transport_type', '0', 'admin', TO_DATE('2023-02-28 16:35:20', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('126', '设备事件类型', 'iot_event_type', '0', 'admin', TO_DATE('2023-03-29 00:24:51', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('127', '指令下发类型', 'iot_function_type', '0', 'admin', TO_DATE('2023-03-29 00:37:51', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('128', '读写类型', 'iot_data_read_write', '0', 'admin', TO_DATE('2023-04-09 02:11:14', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('129', '升级范围', 'oat_update_limit', '0', 'admin', TO_DATE('2023-04-09 23:51:45', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('130', '云存储平台类型', 'oss_platform_type', '0', 'admin', TO_DATE('2023-04-12 00:26:09', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('131', 'modbus数据类型', 'iot_modbus_data_type', '0', 'admin', TO_DATE('2023-09-04 13:54:17', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('132', '小度音箱关联设备', 'dueros_related_device', '0', 'admin', TO_DATE('2023-09-22 09:45:15', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-22 09:45:15', 'SYYYY-MM-DD HH24:MI:SS'), '小度音箱支持的设备、场景类型，在设备下配置关联');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('133', '小度音箱操作类型', 'dueros_operate_type', '0', 'admin', TO_DATE('2023-09-22 09:45:15', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-22 09:45:15', 'SYYYY-MM-DD HH24:MI:SS'), '小度音箱智能家居设备操作类型，在产品物模型下配置');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('198', '规则脚本类型', 'rule_script_type', '0', 'admin', TO_DATE('2023-11-04 01:48:50', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-11-04 01:50:16', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('199', '规则脚本语言', 'rule_script_language', '0', 'admin', TO_DATE('2023-11-04 01:50:06', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, NULL);
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('204', '规则脚本事件', 'rule_script_event', '0', 'admin', TO_DATE('2023-12-19 11:33:48', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '1=设备上报，2=平台下发，3=设备上线，4=设备离线');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('205', '规则脚本用途', 'rule_script_purpose', '0', 'admin', TO_DATE('2023-12-19 11:38:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '1=数据流，2=触发器，3=执行动作');
INSERT INTO "sys_dict_type" ("dict_id", "dict_name", "dict_type", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('206', '规则脚本动作', 'rule_script_action', '0', 'admin', TO_DATE('2023-12-19 11:39:58', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE "sys_job";
CREATE TABLE "sys_job" (
  "job_id" NUMBER(20) NOT NULL,
  "job_name" NVARCHAR2(64) NOT NULL,
  "job_group" NVARCHAR2(64) NOT NULL,
  "invoke_target" NVARCHAR2(500) NOT NULL,
  "cron_expression" NVARCHAR2(255),
  "misfire_policy" NVARCHAR2(20),
  "concurrent" NCHAR(1),
  "status" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sys_job"."job_id" IS '任务ID';
COMMENT ON COLUMN "sys_job"."job_name" IS '任务名称';
COMMENT ON COLUMN "sys_job"."job_group" IS '任务组名';
COMMENT ON COLUMN "sys_job"."invoke_target" IS '调用目标字符串';
COMMENT ON COLUMN "sys_job"."cron_expression" IS 'cron执行表达式';
COMMENT ON COLUMN "sys_job"."misfire_policy" IS '计划执行错误策略（1立即执行 2执行一次 3放弃执行）';
COMMENT ON COLUMN "sys_job"."concurrent" IS '是否并发执行（0允许 1禁止）';
COMMENT ON COLUMN "sys_job"."status" IS '状态（0正常 1暂停）';
COMMENT ON COLUMN "sys_job"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_job"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_job"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_job"."update_time" IS '更新时间';
COMMENT ON COLUMN "sys_job"."remark" IS '备注信息';
COMMENT ON TABLE "sys_job" IS '定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO "sys_job" ("job_id", "job_name", "job_group", "invoke_target", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(''ry'')', '0/15 * * * * ?', '3', '1', '1', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_job" ("job_id", "job_name", "job_group", "invoke_target", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('5', '监控在线状态更新', 'SYSTEM', 'deviceJob.updateSipDeviceOnlineStatus(90)', '0 0/2 * * * ?', '1', '0', '0', 'admin', TO_DATE('2023-03-24 10:57:48', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-26 15:50:06', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_job" ("job_id", "job_name", "job_group", "invoke_target", "cron_expression", "misfire_policy", "concurrent", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('6', '设备定时同步', 'SYSTEM', 'deviceJob.syncDeviceStatus', '0 0/1 * * * ? ', '1', '0', '0', 'admin', TO_DATE('2025-03-26 17:44:26', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-26 17:45:08', 'SYYYY-MM-DD HH24:MI:SS'), '');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE "sys_job_log";
CREATE TABLE "sys_job_log" (
  "job_log_id" NUMBER(20) NOT NULL,
  "job_name" NVARCHAR2(64) NOT NULL,
  "job_group" NVARCHAR2(64) NOT NULL,
  "invoke_target" NVARCHAR2(500) NOT NULL,
  "job_message" NVARCHAR2(500),
  "status" NCHAR(1),
  "exception_info" NCLOB,
  "create_time" DATE
)
;
COMMENT ON COLUMN "sys_job_log"."job_log_id" IS '任务日志ID';
COMMENT ON COLUMN "sys_job_log"."job_name" IS '任务名称';
COMMENT ON COLUMN "sys_job_log"."job_group" IS '任务组名';
COMMENT ON COLUMN "sys_job_log"."invoke_target" IS '调用目标字符串';
COMMENT ON COLUMN "sys_job_log"."job_message" IS '日志信息';
COMMENT ON COLUMN "sys_job_log"."status" IS '执行状态（0正常 1失败）';
COMMENT ON COLUMN "sys_job_log"."exception_info" IS '异常信息';
COMMENT ON COLUMN "sys_job_log"."create_time" IS '创建时间';
COMMENT ON TABLE "sys_job_log" IS '定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO "sys_job_log" ("job_log_id", "job_name", "job_group", "invoke_target", "job_message", "status", "exception_info", "create_time") VALUES ('1', '设备定时同步', 'SYSTEM', 'deviceJob.syncDeviceStatus', '设备定时同步 总共耗时：35毫秒', '0', '', TO_DATE('2025-03-26 17:52:59', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "sys_job_log" ("job_log_id", "job_name", "job_group", "invoke_target", "job_message", "status", "exception_info", "create_time") VALUES ('2', '设备定时任务', 'SYSTEM', 'deviceJob.timingUpdateDeviceStatusStatus', '设备定时任务 总共耗时：0毫秒', '1', 'java.lang.NoSuchMethodException: com.fastbee.data.service.impl.DeviceJob.timingUpdateDeviceStatusStatus()
	at java.lang.Class.getMethod(Class.java:1786)
	at com.fastbee.quartz.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:60)
	at com.fastbee.quartz.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:33)
	at com.fastbee.quartz.util.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)
	at com.fastbee.quartz.util.AbstractQuartzJob.execute(AbstractQuartzJob.java:43)
	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)
	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)
', TO_DATE('2025-03-26 17:53:00', 'SYYYY-MM-DD HH24:MI:SS'));
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE "sys_logininfor";
CREATE TABLE "sys_logininfor" (
  "info_id" NUMBER(20) NOT NULL,
  "user_name" NVARCHAR2(50),
  "ipaddr" NVARCHAR2(128),
  "login_location" NVARCHAR2(255),
  "browser" NVARCHAR2(50),
  "os" NVARCHAR2(50),
  "status" NCHAR(1),
  "msg" NVARCHAR2(255),
  "login_time" DATE
)
;
COMMENT ON COLUMN "sys_logininfor"."info_id" IS '访问ID';
COMMENT ON COLUMN "sys_logininfor"."user_name" IS '用户账号';
COMMENT ON COLUMN "sys_logininfor"."ipaddr" IS '登录IP地址';
COMMENT ON COLUMN "sys_logininfor"."login_location" IS '登录地点';
COMMENT ON COLUMN "sys_logininfor"."browser" IS '浏览器类型';
COMMENT ON COLUMN "sys_logininfor"."os" IS '操作系统';
COMMENT ON COLUMN "sys_logininfor"."status" IS '登录状态（0成功 1失败）';
COMMENT ON COLUMN "sys_logininfor"."msg" IS '提示消息';
COMMENT ON COLUMN "sys_logininfor"."login_time" IS '访问时间';
COMMENT ON TABLE "sys_logininfor" IS '系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE "sys_menu";
CREATE TABLE "sys_menu" (
  "menu_id" NUMBER(20) NOT NULL,
  "menu_name" NVARCHAR2(50) NOT NULL,
  "parent_id" NUMBER(20),
  "order_num" NUMBER(11),
  "path" NVARCHAR2(200),
  "component" NVARCHAR2(255),
  "query" NVARCHAR2(255),
  "is_frame" NUMBER(11),
  "is_cache" NUMBER(11),
  "menu_type" NCHAR(1),
  "visible" NCHAR(1),
  "status" NCHAR(1),
  "perms" NVARCHAR2(100),
  "icon" NVARCHAR2(100),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sys_menu"."menu_id" IS '菜单ID';
COMMENT ON COLUMN "sys_menu"."menu_name" IS '菜单名称';
COMMENT ON COLUMN "sys_menu"."parent_id" IS '父菜单ID';
COMMENT ON COLUMN "sys_menu"."order_num" IS '显示顺序';
COMMENT ON COLUMN "sys_menu"."path" IS '路由地址';
COMMENT ON COLUMN "sys_menu"."component" IS '组件路径';
COMMENT ON COLUMN "sys_menu"."query" IS '路由参数';
COMMENT ON COLUMN "sys_menu"."is_frame" IS '是否为外链（0是 1否）';
COMMENT ON COLUMN "sys_menu"."is_cache" IS '是否缓存（0缓存 1不缓存）';
COMMENT ON COLUMN "sys_menu"."menu_type" IS '菜单类型（M目录 C菜单 F按钮）';
COMMENT ON COLUMN "sys_menu"."visible" IS '菜单状态（0显示 1隐藏）';
COMMENT ON COLUMN "sys_menu"."status" IS '菜单状态（0正常 1停用）';
COMMENT ON COLUMN "sys_menu"."perms" IS '权限标识';
COMMENT ON COLUMN "sys_menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "sys_menu"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_menu"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_menu"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_menu"."update_time" IS '更新时间';
COMMENT ON COLUMN "sys_menu"."remark" IS '备注';
COMMENT ON TABLE "sys_menu" IS '菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', '系统管理', '0', '4', 'system', NULL, '', '1', '0', 'M', '0', '0', '', 'system', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-16 16:42:52', 'SYYYY-MM-DD HH24:MI:SS'), '系统管理目录');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '系统监控', '0', '5', 'monitor', NULL, '', '1', '0', 'M', '0', '0', '', 'monitor', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-08-24 17:21:20', 'SYYYY-MM-DD HH24:MI:SS'), '系统监控目录');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', '系统工具', '0', '6', 'tool', NULL, '', '1', '0', 'M', '0', '0', '', 'tool', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-08-24 17:21:28', 'SYYYY-MM-DD HH24:MI:SS'), '系统工具目录');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('4', '蜂信物联', '0', '10', 'http://fastbee.cn', NULL, '', '0', '0', 'M', '0', '0', '', 'guide', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-19 15:14:02', 'SYYYY-MM-DD HH24:MI:SS'), '若依官网地址');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('100', '用户管理', '1', '1', 'user', 'system/user/index', '', '1', '0', 'C', '0', '0', 'system:user:list', 'user', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '用户管理菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('101', '角色管理', '1', '2', 'role', 'system/role/index', '', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '角色管理菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('102', '菜单管理', '1', '3', 'menu', 'system/menu/index', '', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '菜单管理菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('103', '部门管理', '1', '4', 'dept', 'system/dept/index', '', '1', '0', 'C', '0', '0', 'system:dept:list', 'tree', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '部门管理菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('104', '岗位管理', '1', '5', 'post', 'system/post/index', '', '1', '0', 'C', '0', '0', 'system:post:list', 'post', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '岗位管理菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('105', '字典管理', '1', '6', 'dict', 'system/dict/index', '', '1', '0', 'C', '0', '0', 'system:dict:list', 'dict', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '字典管理菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('106', '参数设置', '1', '7', 'config', 'system/config/index', '', '1', '0', 'C', '0', '0', 'system:config:list', 'edit', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '参数设置菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('107', '通知公告', '1', '8', 'notice', 'system/notice/index', '', '1', '0', 'C', '0', '0', 'system:notice:list', 'message', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '通知公告菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('108', '日志管理', '1', '9', 'log', '', '', '1', '0', 'M', '0', '0', '', 'log', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '日志管理菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('109', '在线用户', '2', '1', 'online', 'monitor/online/index', '', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '在线用户菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('110', '定时任务', '2', '2', 'job', 'monitor/job/index', '', '1', '0', 'C', '0', '0', 'monitor:job:list', 'job', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '定时任务菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('111', '数据监控', '2', '3', 'druid', 'monitor/druid/index', '', '1', '0', 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '数据监控菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('112', '服务监控', '2', '4', 'server', 'monitor/server/index', '', '1', '0', 'C', '0', '0', 'monitor:server:list', 'server', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '服务监控菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('113', '缓存监控', '2', '5', 'cache', 'monitor/cache/index', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '缓存监控菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('114', '表单构建', '3', '1', 'build', 'tool/build/index', '', '1', '0', 'C', '0', '0', 'tool:build:list', 'build', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '表单构建菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('115', '代码生成', '3', '2', 'gen', 'tool/gen/index', '', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '代码生成菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('116', '系统接口', '3', '3', 'swagger', 'tool/swagger/index', '', '1', '0', 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '系统接口菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('124', '缓存列表', '2', '6', 'cacheList', 'monitor/cache/list', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', TO_DATE('2023-03-10 23:22:42', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '缓存列表菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('500', '操作日志', '108', '1', 'operlog', 'monitor/operlog/index', '', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '操作日志菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('501', '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '登录日志菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1001', '用户查询', '100', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1002', '用户新增', '100', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1003', '用户修改', '100', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1004', '用户删除', '100', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1005', '用户导出', '100', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1006', '用户导入', '100', '6', '', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1007', '重置密码', '100', '7', '', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1008', '角色查询', '101', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1009', '角色新增', '101', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1010', '角色修改', '101', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1011', '角色删除', '101', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1012', '角色导出', '101', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1013', '菜单查询', '102', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1014', '菜单新增', '102', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1015', '菜单修改', '102', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1016', '菜单删除', '102', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1017', '部门查询', '103', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1018', '部门新增', '103', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1019', '部门修改', '103', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1020', '部门删除', '103', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1021', '岗位查询', '104', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1022', '岗位新增', '104', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1023', '岗位修改', '104', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1024', '岗位删除', '104', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1025', '岗位导出', '104', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1026', '字典查询', '105', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1027', '字典新增', '105', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1028', '字典修改', '105', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1029', '字典删除', '105', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1030', '字典导出', '105', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1031', '参数查询', '106', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1032', '参数新增', '106', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1033', '参数修改', '106', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1034', '参数删除', '106', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1035', '参数导出', '106', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1036', '公告查询', '107', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1037', '公告新增', '107', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1038', '公告修改', '107', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1039', '公告删除', '107', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1040', '操作查询', '500', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1041', '操作删除', '500', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1042', '日志导出', '500', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1043', '登录查询', '501', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1044', '登录删除', '501', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1045', '日志导出', '501', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1046', '在线查询', '109', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1047', '批量强退', '109', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1048', '单条强退', '109', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1049', '任务查询', '110', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1050', '任务新增', '110', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:add', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1051', '任务修改', '110', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1052', '任务删除', '110', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1053', '状态修改', '110', '5', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1054', '任务导出', '110', '7', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:export', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1055', '生成查询', '115', '1', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1056', '生成修改', '115', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1057', '生成删除', '115', '3', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1058', '导入代码', '115', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1059', '预览代码', '115', '4', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1060', '生成代码', '115', '5', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1065', '账户解锁', '501', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', TO_DATE('2023-03-10 23:23:04', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2000', '设备管理', '0', '0', 'iot', NULL, NULL, '1', '0', 'M', '0', '0', '', 'iot', 'admin', TO_DATE('2021-12-15 23:57:06', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-26 23:55:54', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2001', '产品分类', '2000', '2', 'category', 'iot/category/index', NULL, '1', '0', 'C', '0', '0', 'iot:category:list', 'category', 'admin', TO_DATE('2021-12-16 00:40:02', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-26 23:56:20', 'SYYYY-MM-DD HH24:MI:SS'), '产品分类菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2002', '产品分类查询', '2001', '1', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:category:query', '#', 'admin', TO_DATE('2021-12-16 00:40:02', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2003', '产品分类新增', '2001', '2', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:category:add', '#', 'admin', TO_DATE('2021-12-16 00:40:02', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2004', '产品分类修改', '2001', '3', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:category:edit', '#', 'admin', TO_DATE('2021-12-16 00:40:02', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2005', '产品分类删除', '2001', '4', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:category:remove', '#', 'admin', TO_DATE('2021-12-16 00:40:02', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2006', '产品分类导出', '2001', '5', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:category:export', '#', 'admin', TO_DATE('2021-12-16 00:40:02', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2007', '设备管理', '2000', '5', 'device', 'iot/device/index', NULL, '1', '0', 'C', '0', '0', 'iot:device:list', 'device', 'admin', TO_DATE('2021-12-16 00:40:12', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-01-08 15:47:14', 'SYYYY-MM-DD HH24:MI:SS'), '设备菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2008', '设备查询', '2007', '1', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:device:query', '#', 'admin', TO_DATE('2021-12-16 00:40:12', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2009', '设备新增', '2007', '2', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:device:add', '#', 'admin', TO_DATE('2021-12-16 00:40:12', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2010', '设备修改', '2007', '3', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:device:edit', '#', 'admin', TO_DATE('2021-12-16 00:40:12', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2011', '设备删除', '2007', '4', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:device:remove', '#', 'admin', TO_DATE('2021-12-16 00:40:12', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2012', '设备导出', '2007', '5', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:device:export', '#', 'admin', TO_DATE('2021-12-16 00:40:12', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2019', '设备分组', '2000', '4', 'group', 'iot/group/index', NULL, '1', '0', 'C', '0', '0', 'iot:group:list', 'group', 'admin', TO_DATE('2021-12-16 00:40:31', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-26 23:56:54', 'SYYYY-MM-DD HH24:MI:SS'), '设备分组菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2020', '设备分组查询', '2019', '1', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:group:query', '#', 'admin', TO_DATE('2021-12-16 00:40:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2021', '设备分组新增', '2019', '2', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:group:add', '#', 'admin', TO_DATE('2021-12-16 00:40:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2022', '设备分组修改', '2019', '3', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:group:edit', '#', 'admin', TO_DATE('2021-12-16 00:40:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2023', '设备分组删除', '2019', '4', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:group:remove', '#', 'admin', TO_DATE('2021-12-16 00:40:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2024', '设备分组导出', '2019', '5', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:group:export', '#', 'admin', TO_DATE('2021-12-16 00:40:31', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2043', '产品管理', '2000', '3', 'product', 'iot/product/index', NULL, '1', '0', 'C', '0', '0', 'iot:product:list', 'product', 'admin', TO_DATE('2021-12-16 00:41:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-26 23:58:44', 'SYYYY-MM-DD HH24:MI:SS'), '产品菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2044', '产品查询', '2043', '1', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:product:query', '#', 'admin', TO_DATE('2021-12-16 00:41:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2045', '产品新增', '2043', '2', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:product:add', '#', 'admin', TO_DATE('2021-12-16 00:41:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2046', '产品修改', '2043', '3', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:product:edit', '#', 'admin', TO_DATE('2021-12-16 00:41:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2047', '产品删除', '2043', '4', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:product:remove', '#', 'admin', TO_DATE('2021-12-16 00:41:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2048', '产品导出', '2043', '5', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:product:export', '#', 'admin', TO_DATE('2021-12-16 00:41:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2049', '通用物模型', '2000', '1', 'template', 'iot/template/index', NULL, '1', '0', 'C', '0', '0', 'iot:template:list', 'model', 'admin', TO_DATE('2021-12-16 00:41:28', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-26 23:56:09', 'SYYYY-MM-DD HH24:MI:SS'), '通用物模型菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2050', '通用物模型查询', '2049', '1', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:template:query', '#', 'admin', TO_DATE('2021-12-16 00:41:28', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2051', '通用物模型新增', '2049', '2', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:template:add', '#', 'admin', TO_DATE('2021-12-16 00:41:28', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2052', '通用物模型修改', '2049', '3', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:template:edit', '#', 'admin', TO_DATE('2021-12-16 00:41:28', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2053', '通用物模型删除', '2049', '4', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:template:remove', '#', 'admin', TO_DATE('2021-12-16 00:41:28', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2054', '通用物模型导出', '2049', '5', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:template:export', '#', 'admin', TO_DATE('2021-12-16 00:41:28', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2123', '新闻分类', '1', '10', 'newsCategory', 'iot/newsCategory/index', NULL, '1', '0', 'C', '0', '0', 'iot:newsCategory:list', 'category', 'admin', TO_DATE('2022-04-11 16:47:27', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-12 17:20:51', 'SYYYY-MM-DD HH24:MI:SS'), '新闻分类菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2124', '新闻分类查询', '2123', '1', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:newsCategory:query', '#', 'admin', TO_DATE('2022-04-11 16:47:27', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2125', '新闻分类新增', '2123', '2', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:newsCategory:add', '#', 'admin', TO_DATE('2022-04-11 16:47:27', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2126', '新闻分类修改', '2123', '3', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:newsCategory:edit', '#', 'admin', TO_DATE('2022-04-11 16:47:27', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2127', '新闻分类删除', '2123', '4', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:newsCategory:remove', '#', 'admin', TO_DATE('2022-04-11 16:47:27', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2128', '新闻分类导出', '2123', '5', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:newsCategory:export', '#', 'admin', TO_DATE('2022-04-11 16:47:27', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2129', '新闻资讯', '1', '11', 'news', 'iot/news/index', NULL, '1', '0', 'C', '0', '0', 'iot:news:list', 'documentation', 'admin', TO_DATE('2022-04-11 16:47:46', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-05-12 17:20:58', 'SYYYY-MM-DD HH24:MI:SS'), '新闻资讯菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2130', '新闻资讯查询', '2129', '1', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:news:query', '#', 'admin', TO_DATE('2022-04-11 16:47:46', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2131', '新闻资讯新增', '2129', '2', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:news:add', '#', 'admin', TO_DATE('2022-04-11 16:47:46', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2132', '新闻资讯修改', '2129', '3', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:news:edit', '#', 'admin', TO_DATE('2022-04-11 16:47:46', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2133', '新闻资讯删除', '2129', '4', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:news:remove', '#', 'admin', TO_DATE('2022-04-11 16:47:46', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2134', '新闻资讯导出', '2129', '5', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:news:export', '#', 'admin', TO_DATE('2022-04-11 16:47:46', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2136', '产品授权码查询', '2043', '6', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:authorize:query', '#', 'admin', TO_DATE('2022-04-11 17:17:53', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-04 21:21:40', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2137', '产品授权码新增', '2043', '7', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:authorize:add', '#', 'admin', TO_DATE('2022-04-11 17:17:53', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-04 21:21:59', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2138', '产品授权码修改', '2043', '8', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:authorize:edit', '#', 'admin', TO_DATE('2022-04-11 17:17:53', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-04 21:22:08', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2139', '产品授权码删除', '2043', '9', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:authorize:remove', '#', 'admin', TO_DATE('2022-04-11 17:17:53', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-04 21:22:26', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2140', '产品授权码导出', '2043', '5', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:authorize:export', '#', 'admin', TO_DATE('2022-04-11 17:17:53', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2142', '平台查询', '2142', '1', '', NULL, NULL, '1', '0', 'F', '0', '0', 'iot:platform:query', '#', 'admin', TO_DATE('2022-04-11 19:10:28', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2147', '设备分享', '2007', '6', '', NULL, NULL, '1', '0', 'F', '0', '0', 'iot:device:share', '#', 'admin', TO_DATE('2022-06-10 01:08:40', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-10 01:10:46', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2148', '设备定时', '2007', '7', '', NULL, NULL, '1', '0', 'F', '0', '0', 'iot:device:timer', '#', 'admin', TO_DATE('2022-06-10 01:10:30', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3031', 'Netty管理', '0', '3', 'netty', NULL, NULL, '1', '0', 'M', '0', '0', '', 'mq', 'admin', TO_DATE('2022-02-26 00:42:12', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-26 00:11:57', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3032', '客户端', '3031', '1', 'client', 'iot/netty/clients', NULL, '1', '0', 'C', '0', '0', 'monitor:server:list', 'client', 'admin', TO_DATE('2022-02-26 00:45:39', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-08-23 23:38:08', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3033', '事件日志', '2000', '1', 'log', 'iot/log/index', NULL, '1', '0', 'F', '0', '0', 'iot:event:list', '#', 'admin', TO_DATE('2023-03-28 14:23:52', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '事件日志菜单');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3034', '事件日志查询', '3033', '1', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:event:query', '#', 'admin', TO_DATE('2023-03-28 14:23:52', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3035', '事件日志新增', '3033', '2', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:event:add', '#', 'admin', TO_DATE('2023-03-28 14:23:52', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3036', '事件日志修改', '3033', '3', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:event:edit', '#', 'admin', TO_DATE('2023-03-28 14:23:52', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3037', '事件日志删除', '3033', '4', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:event:remove', '#', 'admin', TO_DATE('2023-03-28 14:23:52', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3038', '事件日志导出', '3033', '5', '#', '', NULL, '1', '0', 'F', '0', '0', 'iot:event:export', '#', 'admin', TO_DATE('2023-03-28 14:23:52', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3048', 'Mqtt统计', '3031', '2', 'mqtt', 'iot/netty/mqtt', NULL, '1', '0', 'C', '0', '0', 'monitor:server:list', 'monitor', 'admin', TO_DATE('2023-08-23 23:40:28', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-08-23 23:40:38', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3050', '规则引擎', '0', '2', 'ruleengine', NULL, NULL, '1', '0', 'M', '0', '0', '', 'channel', 'admin', TO_DATE('2024-04-22 16:28:15', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-19 15:13:50', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3051', '规则脚本', '3050', '2', 'script', 'iot/scene/script', NULL, '1', '0', 'C', '0', '0', 'iot:script:list', 'code', 'admin', TO_DATE('2024-04-22 16:30:00', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3052', '规则脚本查询', '3051', '1', '', NULL, NULL, '1', '0', 'F', '0', '0', 'iot:script:query', '#', 'admin', TO_DATE('2024-04-22 16:30:53', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3053', '规则脚本新增', '3051', '2', '', NULL, NULL, '1', '0', 'F', '0', '0', 'iot:script:add', '#', 'admin', TO_DATE('2024-04-22 16:31:28', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3054', '规则脚本修改', '3051', '3', '', NULL, NULL, '1', '0', 'F', '0', '0', 'iot:script:edit', '#', 'admin', TO_DATE('2024-04-22 16:32:04', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3056', '规则脚本导出', '3051', '5', '', NULL, NULL, '1', '0', 'F', '0', '0', 'iot:script:export', '#', 'admin', TO_DATE('2024-04-22 16:33:25', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2024-04-22 16:33:49', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3057', '规则脚本删除', '3051', '4', '', NULL, NULL, '1', '0', 'F', '0', '0', 'iot:script:remove', '#', 'admin', TO_DATE('2024-04-22 16:35:01', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3058', '视频中心', '0', '1', 'video', NULL, NULL, '1', '0', 'M', '0', '0', '', 'live', 'admin', TO_DATE('2024-07-15 14:42:13', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-19 15:13:43', 'SYYYY-MM-DD HH24:MI:SS'), '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3059', '通道管理', '3058', '1', 'sip', 'iot/sip/index', NULL, '1', '0', 'C', '0', '0', 'iot:video:list', 'swagger', 'admin', TO_DATE('2024-07-15 14:43:22', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3060', '视频配置', '3058', '2', 'mediaServer', 'iot/sip/mediaServer', NULL, '1', '0', 'C', '0', '0', NULL, 'edit', 'admin', TO_DATE('2024-07-15 14:48:52', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_menu" ("menu_id", "menu_name", "parent_id", "order_num", "path", "component", "query", "is_frame", "is_cache", "menu_type", "visible", "status", "perms", "icon", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3062', '大屏展示', '2000', '6', 'http://localhost/bigScreen', NULL, NULL, '0', '0', 'M', '0', '0', '', 'monitor-a', 'admin', TO_DATE('2025-03-19 15:07:39', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-20 22:18:42', 'SYYYY-MM-DD HH24:MI:SS'), '');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE "sys_notice";
CREATE TABLE "sys_notice" (
  "notice_id" NUMBER(11) NOT NULL,
  "notice_title" NVARCHAR2(50) NOT NULL,
  "notice_type" NCHAR(1) NOT NULL,
  "notice_content" BLOB,
  "status" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(255)
)
;
COMMENT ON COLUMN "sys_notice"."notice_id" IS '公告ID';
COMMENT ON COLUMN "sys_notice"."notice_title" IS '公告标题';
COMMENT ON COLUMN "sys_notice"."notice_type" IS '公告类型（1通知 2公告）';
COMMENT ON COLUMN "sys_notice"."notice_content" IS '公告内容';
COMMENT ON COLUMN "sys_notice"."status" IS '公告状态（0正常 1关闭）';
COMMENT ON COLUMN "sys_notice"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_notice"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_notice"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_notice"."update_time" IS '更新时间';
COMMENT ON COLUMN "sys_notice"."remark" IS '备注';
COMMENT ON TABLE "sys_notice" IS '通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO "sys_notice" ("notice_id", "notice_title", "notice_type", "notice_content", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', 'FastBeeV1.2版本发布', '2', HEXTORAW('3C703EE8BF99E698AFE6B58BE8AF95E58685E5AEB9EFBC8CE696B0E78988E69CACE58A9FE883BDEFBC9A3C2F703E3C6F6C3E3C6C693EE694AFE68C81E5A49AE7A79FE688B73C2F6C693E3C6C693EE694AFE68C81E8AEBEE5A487E58886E4BAAB3C2F6C693E3C6C693EE694AFE68C81E697B6E5BA8FE695B0E68DAEE5BA933C2F6C693E3C6C693EE7AE80E58D95E8AEA4E8AF81E5928CE58AA0E5AF86E8AEA4E8AF81E7BB9FE4B8803C2F6C693E3C2F6F6C3E'), '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-26 21:21:30', 'SYYYY-MM-DD HH24:MI:SS'), '管理员');
INSERT INTO "sys_notice" ("notice_id", "notice_title", "notice_type", "notice_content", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', 'FastBee sdk支持树莓派', '1', HEXTORAW('3C703EE8BF99E698AFE6B58BE8AF95E58685E5AEB9EFBC8CE79BAEE5898D73646BE694AFE68C81E79A84E78988E69CAC3A3C2F703E3C703E3C62723E3C2F703E3C703E3C62723E3C2F703E3C6F6C3E3C6C693E41726475696E6F20657370383236363C2F6C693E3C6C693E41726475696E6F2065737033323C2F6C693E3C6C693E6573702D6964663C2F6C693E3C6C693E72617370626572727920E6A091E88E93E6B4BE3C2F6C693E3C2F6F6C3E'), '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-26 21:21:41', 'SYYYY-MM-DD HH24:MI:SS'), '管理员');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE "sys_oper_log";
CREATE TABLE "sys_oper_log" (
  "oper_id" NUMBER(20) NOT NULL,
  "title" NVARCHAR2(50),
  "business_type" NUMBER(11),
  "method" NVARCHAR2(100),
  "request_method" NVARCHAR2(10),
  "operator_type" NUMBER(11),
  "oper_name" NVARCHAR2(50),
  "dept_name" NVARCHAR2(50),
  "oper_url" NVARCHAR2(255),
  "oper_ip" NVARCHAR2(128),
  "oper_location" NVARCHAR2(255),
  "oper_param" NCLOB,
  "json_result" NCLOB,
  "status" NUMBER(11),
  "error_msg" NCLOB,
  "oper_time" DATE
)
;
COMMENT ON COLUMN "sys_oper_log"."oper_id" IS '操作日志ID';
COMMENT ON COLUMN "sys_oper_log"."title" IS '模块标题';
COMMENT ON COLUMN "sys_oper_log"."business_type" IS '业务类型（0其它 1新增 2修改 3删除）';
COMMENT ON COLUMN "sys_oper_log"."method" IS '方法名称';
COMMENT ON COLUMN "sys_oper_log"."request_method" IS '请求方式';
COMMENT ON COLUMN "sys_oper_log"."operator_type" IS '操作类别（0其它 1后台用户 2手机端用户）';
COMMENT ON COLUMN "sys_oper_log"."oper_name" IS '操作人员';
COMMENT ON COLUMN "sys_oper_log"."dept_name" IS '部门名称';
COMMENT ON COLUMN "sys_oper_log"."oper_url" IS '请求URL';
COMMENT ON COLUMN "sys_oper_log"."oper_ip" IS '主机地址';
COMMENT ON COLUMN "sys_oper_log"."oper_location" IS '操作地点';
COMMENT ON COLUMN "sys_oper_log"."oper_param" IS '请求参数';
COMMENT ON COLUMN "sys_oper_log"."json_result" IS '返回参数';
COMMENT ON COLUMN "sys_oper_log"."status" IS '操作状态（0正常 1异常）';
COMMENT ON COLUMN "sys_oper_log"."error_msg" IS '错误消息';
COMMENT ON COLUMN "sys_oper_log"."oper_time" IS '操作时间';
COMMENT ON TABLE "sys_oper_log" IS '操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE "sys_post";
CREATE TABLE "sys_post" (
  "post_id" NUMBER(20) NOT NULL,
  "post_code" NVARCHAR2(64) NOT NULL,
  "post_name" NVARCHAR2(50) NOT NULL,
  "post_sort" NUMBER(11) NOT NULL,
  "status" NCHAR(1) NOT NULL,
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sys_post"."post_id" IS '岗位ID';
COMMENT ON COLUMN "sys_post"."post_code" IS '岗位编码';
COMMENT ON COLUMN "sys_post"."post_name" IS '岗位名称';
COMMENT ON COLUMN "sys_post"."post_sort" IS '显示顺序';
COMMENT ON COLUMN "sys_post"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "sys_post"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_post"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_post"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_post"."update_time" IS '更新时间';
COMMENT ON COLUMN "sys_post"."remark" IS '备注';
COMMENT ON TABLE "sys_post" IS '岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO "sys_post" ("post_id", "post_code", "post_name", "post_sort", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', 'ceo', '董事长', '1', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_post" ("post_id", "post_code", "post_name", "post_sort", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', 'se', '项目经理', '2', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_post" ("post_id", "post_code", "post_name", "post_sort", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', 'hr', '人力资源', '3', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
INSERT INTO "sys_post" ("post_id", "post_code", "post_name", "post_sort", "status", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('4', 'user', '普通员工', '4', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE "sys_role";
CREATE TABLE "sys_role" (
  "role_id" NUMBER(20) NOT NULL,
  "role_name" NVARCHAR2(30) NOT NULL,
  "role_key" NVARCHAR2(100) NOT NULL,
  "role_sort" NUMBER(11) NOT NULL,
  "data_scope" NCHAR(1),
  "menu_check_strictly" NUMBER(4),
  "dept_check_strictly" NUMBER(4),
  "status" NCHAR(1) NOT NULL,
  "del_flag" NCHAR(1),
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sys_role"."role_id" IS '角色ID';
COMMENT ON COLUMN "sys_role"."role_name" IS '角色名称';
COMMENT ON COLUMN "sys_role"."role_key" IS '角色权限字符串';
COMMENT ON COLUMN "sys_role"."role_sort" IS '显示顺序';
COMMENT ON COLUMN "sys_role"."data_scope" IS '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）';
COMMENT ON COLUMN "sys_role"."menu_check_strictly" IS '菜单树选择项是否关联显示';
COMMENT ON COLUMN "sys_role"."dept_check_strictly" IS '部门树选择项是否关联显示';
COMMENT ON COLUMN "sys_role"."status" IS '角色状态（0正常 1停用）';
COMMENT ON COLUMN "sys_role"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "sys_role"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_role"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_role"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_role"."update_time" IS '更新时间';
COMMENT ON COLUMN "sys_role"."remark" IS '备注';
COMMENT ON TABLE "sys_role" IS '角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO "sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', '超级管理员', 'admin', '1', '1', '1', '1', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', NULL, '超级管理员');
INSERT INTO "sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '设备租户', 'tenant', '2', '5', '1', '1', '0', '0', 'admin', TO_DATE('2021-12-16 16:41:30', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-12 19:53:34', 'SYYYY-MM-DD HH24:MI:SS'), '管理产品和设备');
INSERT INTO "sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', '普通用户', 'general', '3', '5', '1', '1', '0', '0', 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-02-22 08:17:37', 'SYYYY-MM-DD HH24:MI:SS'), '设备的最终用户，只能管理设备和分组');
INSERT INTO "sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('4', '游客', 'visitor', '4', '1', '1', '1', '0', '0', 'admin', TO_DATE('2021-12-16 16:44:30', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-19 15:06:10', 'SYYYY-MM-DD HH24:MI:SS'), '只能查询和新增系统数据');
INSERT INTO "sys_role" ("role_id", "role_name", "role_key", "role_sort", "data_scope", "menu_check_strictly", "dept_check_strictly", "status", "del_flag", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('5', '管理员', 'manager', '5', '1', '1', '1', '0', '0', 'admin', TO_DATE('2022-06-10 13:54:29', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2025-03-19 15:10:17', 'SYYYY-MM-DD HH24:MI:SS'), '普通管理员');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE "sys_role_dept";
CREATE TABLE "sys_role_dept" (
  "role_id" NUMBER(20) NOT NULL,
  "dept_id" NUMBER(20) NOT NULL
)
;
COMMENT ON COLUMN "sys_role_dept"."role_id" IS '角色ID';
COMMENT ON COLUMN "sys_role_dept"."dept_id" IS '部门ID';
COMMENT ON TABLE "sys_role_dept" IS '角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE "sys_role_menu";
CREATE TABLE "sys_role_menu" (
  "role_id" NUMBER(20) NOT NULL,
  "menu_id" NUMBER(20) NOT NULL
)
;
COMMENT ON COLUMN "sys_role_menu"."role_id" IS '角色ID';
COMMENT ON COLUMN "sys_role_menu"."menu_id" IS '菜单ID';
COMMENT ON TABLE "sys_role_menu" IS '角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '1');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '4');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '107');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '1036');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2000');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2001');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2002');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2003');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2004');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2005');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2006');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2007');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2008');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2009');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2010');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2011');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2012');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2019');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2020');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2021');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2022');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2023');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2024');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2043');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2044');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2045');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2046');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2047');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2048');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2049');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2050');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2051');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2052');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2053');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2054');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2129');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2130');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2136');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2137');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2138');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2139');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2140');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2147');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('2', '2148');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '1');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '4');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '107');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '1036');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2000');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2007');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2008');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2009');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2010');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2011');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2012');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2019');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2020');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2021');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2022');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2023');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2024');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2067');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2068');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2085');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2086');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2087');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2088');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2089');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2090');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2129');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2130');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2147');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2148');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2168');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2169');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2170');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2171');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('3', '2172');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '3');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '4');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '100');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '101');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '102');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '103');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '104');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '105');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '106');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '107');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '108');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '109');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '110');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '111');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '112');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '113');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '114');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '115');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '116');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '500');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '501');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1001');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1008');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1013');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1017');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1021');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1026');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1031');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1036');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1040');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1043');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1046');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1049');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '1055');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2000');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2001');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2002');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2003');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2007');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2008');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2009');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2019');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2020');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2021');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2043');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2044');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2045');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2049');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2050');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2051');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2123');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2124');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2125');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2129');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2130');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2131');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2136');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2137');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2147');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '2148');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '3031');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '3032');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '3033');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '3034');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('4', '3035');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '3');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '4');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '100');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '101');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '102');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '103');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '104');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '105');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '106');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '107');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '108');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '109');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '110');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '111');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '112');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '113');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '114');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '115');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '116');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '124');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '500');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '501');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1001');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1002');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1003');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1004');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1005');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1006');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1007');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1008');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1009');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1010');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1011');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1012');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1013');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1014');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1015');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1016');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1017');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1018');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1019');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1020');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1021');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1022');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1023');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1024');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1025');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1026');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1027');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1028');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1029');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1030');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1031');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1032');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1033');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1034');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1035');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1036');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1037');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1038');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1039');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1040');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1041');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1042');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1043');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1044');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1045');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1046');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1047');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1048');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1049');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1050');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1051');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1052');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1053');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1054');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1055');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1056');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1057');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1058');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1059');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1060');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '1065');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2000');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2001');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2002');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2003');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2004');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2005');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2006');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2007');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2008');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2009');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2010');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2011');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2012');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2019');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2020');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2021');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2022');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2023');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2024');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2043');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2044');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2045');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2046');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2047');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2048');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2049');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2050');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2051');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2052');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2053');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2054');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2123');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2124');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2125');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2126');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2127');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2128');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2129');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2130');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2131');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2132');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2133');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2134');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2136');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2137');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2138');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2139');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2140');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2147');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '2148');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '3031');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '3032');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '3033');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '3034');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '3035');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '3036');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '3037');
INSERT INTO "sys_role_menu" ("role_id", "menu_id") VALUES ('5', '3038');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE "sys_user";
CREATE TABLE "sys_user" (
  "user_id" NUMBER(20) NOT NULL,
  "dept_id" NUMBER(20),
  "user_name" NVARCHAR2(30) NOT NULL,
  "nick_name" NVARCHAR2(30) NOT NULL,
  "user_type" NVARCHAR2(2),
  "email" NVARCHAR2(50),
  "phonenumber" NVARCHAR2(11),
  "sex" NCHAR(1),
  "avatar" NVARCHAR2(100),
  "password" NVARCHAR2(100),
  "status" NCHAR(1),
  "del_flag" NCHAR(1),
  "login_ip" NVARCHAR2(128),
  "login_date" DATE,
  "create_by" NVARCHAR2(64),
  "create_time" DATE,
  "update_by" NVARCHAR2(64),
  "update_time" DATE,
  "remark" NVARCHAR2(500)
)
;
COMMENT ON COLUMN "sys_user"."user_id" IS '用户ID';
COMMENT ON COLUMN "sys_user"."dept_id" IS '部门ID';
COMMENT ON COLUMN "sys_user"."user_name" IS '用户账号';
COMMENT ON COLUMN "sys_user"."nick_name" IS '用户昵称';
COMMENT ON COLUMN "sys_user"."user_type" IS '用户类型（00系统用户）';
COMMENT ON COLUMN "sys_user"."email" IS '用户邮箱';
COMMENT ON COLUMN "sys_user"."phonenumber" IS '手机号码';
COMMENT ON COLUMN "sys_user"."sex" IS '用户性别（0男 1女 2未知）';
COMMENT ON COLUMN "sys_user"."avatar" IS '头像地址';
COMMENT ON COLUMN "sys_user"."password" IS '密码';
COMMENT ON COLUMN "sys_user"."status" IS '帐号状态（0正常 1停用）';
COMMENT ON COLUMN "sys_user"."del_flag" IS '删除标志（0代表存在 2代表删除）';
COMMENT ON COLUMN "sys_user"."login_ip" IS '最后登录IP';
COMMENT ON COLUMN "sys_user"."login_date" IS '最后登录时间';
COMMENT ON COLUMN "sys_user"."create_by" IS '创建者';
COMMENT ON COLUMN "sys_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "sys_user"."update_by" IS '更新者';
COMMENT ON COLUMN "sys_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "sys_user"."remark" IS '备注';
COMMENT ON TABLE "sys_user" IS '用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('1', '103', 'admin', '蜂信管理员', '00', '164770707@qq.com', '15888888888', '0', '', '$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUu', '0', '0', '183.225.40.49', TO_DATE('2025-03-26 11:18:01', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2021-12-15 21:36:18', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2025-03-26 11:18:01', 'SYYYY-MM-DD HH24:MI:SS'), '管理员');
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('2', '100', 'fastbee-t1', '蜂信租户壹', '00', '', '15888888880', '0', '', '$2a$10$BAWId9C2Nrcwklzl1Ikoau4iqL8XRGvfRjq6Wl.PXWpzwAw0sXMdK', '0', '0', '61.145.97.26', TO_DATE('2023-08-29 14:52:27', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-04-15 16:21:25', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-08-29 14:52:26', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('3', '100', 'fastbee-t2', '蜂信租户贰', '00', '', '15888888881', '0', '', '$2a$10$1zMlbW7hGpzA59gpzWGO/ObeASziQ296evjMjHrYdZnxKBLU4WUum', '0', '0', '127.0.0.1', TO_DATE('2022-06-12 00:54:28', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-04-15 16:22:08', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-12 00:54:30', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('4', '100', 'fastbee-u1', '蜂信用户壹', '00', '', '15888888882', '0', '', '$2a$10$691RJMXZ9HM4sgNTExLPfO5Nw6J6cWgCvcoF9V.jKMnPk5o/8c9VS', '0', '0', '127.0.0.1', TO_DATE('2023-04-12 22:26:39', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-04-15 16:22:37', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-04-12 22:26:39', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('5', '100', 'fastbee-u2', '蜂信用户贰', '00', '', '15888888883', '0', '', '$2a$10$x3rM39rewwbi7ayvriGMEOKUHoPCqcL2CYXPLTJRCWYPVvykFIYJq', '0', '0', '127.0.0.1', TO_DATE('2022-06-12 00:55:45', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-04-15 16:23:13', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-06-12 00:55:46', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('6', '100', 'fastbee', '游客账号', '00', '', '15888888884', '0', '', '$2a$10$kKeZptrTnSlm0fencX4U2eq.QiaukDs.DckiUsMCwVTxh0IS2LRQ.', '0', '0', '127.0.0.1', TO_DATE('2023-09-21 18:39:29', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2022-03-09 16:49:19', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-09-21 18:39:28', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('7', NULL, 'shenzehui', 'shenzehui', '00', '', '18257292958', '0', '', '$2a$10$UYKWiQF.VWfVvuksS/DMiO234Mwtz.niU7cM/noFgwLVRl7Jjt5pa', '0', '2', '39.189.61.11', TO_DATE('2023-04-16 14:18:09', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-04-16 14:17:59', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-04-16 14:18:08', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('8', NULL, 'shadow', 'shadow', '00', '165456465465@qq.com', '15752221201', '0', '', '$2a$10$FXSw4fufDjecEhMxYjji3.7PkrpwkliCBoQO.h8nW0Nhk0bPpxS6u', '0', '2', '39.130.41.108', TO_DATE('2023-09-15 17:21:33', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-23 11:34:23', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-15 17:21:32', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('9', NULL, 'guanshubiao', 'guanshubiao', '00', '', '15217628961', '0', '', '$2a$10$J9kJeP/dzc/SYq8Ev1rFXOigPdN50Kq8MkCX9j56/fQwDXAUkAPYi', '0', '2', '61.145.97.26', TO_DATE('2023-08-29 17:33:16', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-29 14:56:19', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-29 17:33:16', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('10', NULL, 'jamon', 'jamon', '00', '', '13717112711', '0', '', '$2a$10$LMASUfB9IngDi47fQ9Eh7u003VNNh4DcjdPHMyvAQ4mdLXhQgvnpu', '0', '2', '61.145.97.26', TO_DATE('2023-09-01 09:06:23', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-29 15:06:39', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-01 09:06:23', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('11', '101', 'fastbee123', 'fastbee123', '00', '', '18231210622', '0', '', '$2a$10$qpLuw5yAIDLV/.UCIaWRROxhtI2nYpJe/.tbIKwSmy2Pxm.vc26Ri', '0', '2', '27.187.242.251', TO_DATE('2023-08-31 16:22:40', 'SYYYY-MM-DD HH24:MI:SS'), 'admin', TO_DATE('2023-08-31 16:22:21', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-08-31 16:22:40', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "sys_user" ("user_id", "dept_id", "user_name", "nick_name", "user_type", "email", "phonenumber", "sex", "avatar", "password", "status", "del_flag", "login_ip", "login_date", "create_by", "create_time", "update_by", "update_time", "remark") VALUES ('12', NULL, 'shadow', 'shadow', '00', '', '15752221201', '0', '', '$2a$10$QEYxDoFO6e3wuksc2d7XIOJe0UBzY0EkYR3fKfp8pYfM5bWI4.VO6', '0', '2', '39.130.41.179', TO_DATE('2023-09-19 10:11:00', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-19 10:10:49', 'SYYYY-MM-DD HH24:MI:SS'), '', TO_DATE('2023-09-19 10:11:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE "sys_user_post";
CREATE TABLE "sys_user_post" (
  "user_id" NUMBER(20) NOT NULL,
  "post_id" NUMBER(20) NOT NULL
)
;
COMMENT ON COLUMN "sys_user_post"."user_id" IS '用户ID';
COMMENT ON COLUMN "sys_user_post"."post_id" IS '岗位ID';
COMMENT ON TABLE "sys_user_post" IS '用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO "sys_user_post" ("user_id", "post_id") VALUES ('1', '1');
INSERT INTO "sys_user_post" ("user_id", "post_id") VALUES ('6', '4');
COMMIT;
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE "sys_user_role";
CREATE TABLE "sys_user_role" (
  "user_id" NUMBER(20) NOT NULL,
  "role_id" NUMBER(20) NOT NULL
)
;
COMMENT ON COLUMN "sys_user_role"."user_id" IS '用户ID';
COMMENT ON COLUMN "sys_user_role"."role_id" IS '角色ID';
COMMENT ON TABLE "sys_user_role" IS '用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO "sys_user_role" ("user_id", "role_id") VALUES ('1', '1');
INSERT INTO "sys_user_role" ("user_id", "role_id") VALUES ('2', '2');
INSERT INTO "sys_user_role" ("user_id", "role_id") VALUES ('3', '2');
INSERT INTO "sys_user_role" ("user_id", "role_id") VALUES ('4', '3');
INSERT INTO "sys_user_role" ("user_id", "role_id") VALUES ('5', '3');
INSERT INTO "sys_user_role" ("user_id", "role_id") VALUES ('6', '4');
COMMIT;
COMMIT;

-- ----------------------------
-- Primary Key structure for table gen_table
-- ----------------------------
ALTER TABLE "gen_table" ADD PRIMARY KEY ("table_id");

-- ----------------------------
-- Primary Key structure for table gen_table_column
-- ----------------------------
ALTER TABLE "gen_table_column" ADD PRIMARY KEY ("column_id");

-- ----------------------------
-- Primary Key structure for table iot_category
-- ----------------------------
ALTER TABLE "iot_category" ADD PRIMARY KEY ("category_id");

-- ----------------------------
-- Indexes structure for table iot_category
-- ----------------------------
CREATE INDEX "iot_category_index_tenant_id"
  ON "iot_category" ("tenant_id" ASC);
CREATE INDEX "iot_category_index_parent_id"
  ON "iot_category" ("parent_id" ASC);

-- ----------------------------
-- Primary Key structure for table iot_device
-- ----------------------------
ALTER TABLE "iot_device" ADD PRIMARY KEY ("device_id");

-- ----------------------------
-- Indexes structure for table iot_device
-- ----------------------------
CREATE UNIQUE INDEX "iot_device_index_serial_number"
  ON "iot_device" ("serial_number" ASC);
CREATE INDEX "iot_device_index_product_id"
  ON "iot_device" ("product_id" ASC);
CREATE INDEX "iot_device_index_tanant_id"
  ON "iot_device" ("tenant_id" ASC);
CREATE INDEX "iot_device_index_user_id"
  ON "iot_device" ("user_id" ASC);
CREATE INDEX "iot_device_index_create_time"
  ON "iot_device" ("create_time" ASC);

-- ----------------------------
-- Primary Key structure for table iot_device_group
-- ----------------------------
ALTER TABLE "iot_device_group" ADD PRIMARY KEY ("device_id", "group_id");

-- ----------------------------
-- Primary Key structure for table iot_device_job
-- ----------------------------
ALTER TABLE "iot_device_job" ADD PRIMARY KEY ("job_id", "job_name", "job_group");

-- ----------------------------
-- Indexes structure for table iot_device_job
-- ----------------------------
CREATE INDEX "iot_device_job_index_device_id"
  ON "iot_device_job" ("device_id" ASC);
CREATE INDEX "iot_device_job_index_product_id"
  ON "iot_device_job" ("product_id" ASC);
CREATE INDEX "iot_device_job_index_scene_id"
  ON "iot_device_job" ("scene_id" ASC);
CREATE INDEX "iot_device_job_index_alert_id"
  ON "iot_device_job" ("alert_id" ASC);
CREATE INDEX "iot_device_job_index_serial_number"
  ON "iot_device_job" ("serial_number" ASC);

-- ----------------------------
-- Primary Key structure for table iot_device_log
-- ----------------------------
ALTER TABLE "iot_device_log" ADD PRIMARY KEY ("log_id");

-- ----------------------------
-- Indexes structure for table iot_device_log
-- ----------------------------
CREATE INDEX "iot_device_log_index_serial_number"
  ON "iot_device_log" ("serial_number" ASC);
CREATE INDEX "iot_device_log_index_tenant_id"
  ON "iot_device_log" ("tenant_id" ASC);
CREATE INDEX "iot_device_log_index_user_id"
  ON "iot_device_log" ("user_id" ASC);
CREATE INDEX "iot_device_log_index_device_id"
  ON "iot_device_log" ("device_id" ASC);
CREATE INDEX "index_serialNumber_createTime"
  ON "iot_device_log" ("serial_number" ASC, "create_time" ASC);
CREATE INDEX "index_isMonitor_serialNumber_createTime"
  ON "iot_device_log" ("serial_number" ASC, "is_monitor" ASC, "create_time" ASC);

-- ----------------------------
-- Primary Key structure for table iot_device_template
-- ----------------------------
ALTER TABLE "iot_device_template" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table iot_device_user
-- ----------------------------
ALTER TABLE "iot_device_user" ADD PRIMARY KEY ("device_id", "user_id");

-- ----------------------------
-- Indexes structure for table iot_device_user
-- ----------------------------
CREATE INDEX "iot_device_user_index_user_id"
  ON "iot_device_user" ("user_id" ASC);
CREATE INDEX "iot_device_user_index_tenant_id"
  ON "iot_device_user" ("tenant_id" ASC);

-- ----------------------------
-- Primary Key structure for table iot_event_log
-- ----------------------------
ALTER TABLE "iot_event_log" ADD PRIMARY KEY ("log_id");

-- ----------------------------
-- Primary Key structure for table iot_function_log
-- ----------------------------
ALTER TABLE "iot_function_log" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table iot_function_log
-- ----------------------------
CREATE UNIQUE INDEX "iot_function_log_id_uindex"
  ON "iot_function_log" ("id" ASC);

-- ----------------------------
-- Primary Key structure for table iot_group
-- ----------------------------
ALTER TABLE "iot_group" ADD PRIMARY KEY ("group_id");

-- ----------------------------
-- Indexes structure for table iot_group
-- ----------------------------
CREATE INDEX "iot_group_index_user_id"
  ON "iot_group" ("user_id" ASC);

-- ----------------------------
-- Primary Key structure for table iot_product
-- ----------------------------
ALTER TABLE "iot_product" ADD PRIMARY KEY ("product_id");

-- ----------------------------
-- Indexes structure for table iot_product
-- ----------------------------
CREATE INDEX "iot_product_index_category_id"
  ON "iot_product" ("category_id" ASC);
CREATE INDEX "iot_product_index_tenant_id"
  ON "iot_product" ("tenant_id" ASC);

-- ----------------------------
-- Primary Key structure for table iot_product_authorize
-- ----------------------------
ALTER TABLE "iot_product_authorize" ADD PRIMARY KEY ("authorize_id");

-- ----------------------------
-- Indexes structure for table iot_product_authorize
-- ----------------------------
CREATE INDEX "iot_product_authorize_index_product_id"
  ON "iot_product_authorize" ("product_id" ASC);
CREATE INDEX "iot_product_authorize_index_device_id"
  ON "iot_product_authorize" ("device_id" ASC);
CREATE INDEX "iot_product_authorize_index_serial_number"
  ON "iot_product_authorize" ("serial_number" ASC);
CREATE INDEX "iot_product_authorize_index_user_id"
  ON "iot_product_authorize" ("user_id" ASC);

-- ----------------------------
-- Primary Key structure for table iot_protocol
-- ----------------------------
ALTER TABLE "iot_protocol" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table iot_protocol
-- ----------------------------
CREATE UNIQUE INDEX "UNIQUE_CODE"
  ON "iot_protocol" ("protocol_code" ASC);

-- ----------------------------
-- Primary Key structure for table iot_scene
-- ----------------------------
ALTER TABLE "iot_scene" ADD PRIMARY KEY ("scene_id");

-- ----------------------------
-- Indexes structure for table iot_scene
-- ----------------------------
CREATE INDEX "iot_scene_index_user_id"
  ON "iot_scene" ("user_id" ASC);

-- ----------------------------
-- Primary Key structure for table iot_scene_script
-- ----------------------------
ALTER TABLE "iot_scene_script" ADD PRIMARY KEY ("script_id");

-- ----------------------------
-- Primary Key structure for table iot_script
-- ----------------------------
ALTER TABLE "iot_script" ADD PRIMARY KEY ("script_id");

-- ----------------------------
-- Primary Key structure for table iot_social_platform
-- ----------------------------
ALTER TABLE "iot_social_platform" ADD PRIMARY KEY ("social_platform_id");

-- ----------------------------
-- Indexes structure for table iot_social_platform
-- ----------------------------
CREATE UNIQUE INDEX "iot_social_platform_platform_uindex"
  ON "iot_social_platform" ("platform" ASC);

-- ----------------------------
-- Primary Key structure for table iot_social_user
-- ----------------------------
ALTER TABLE "iot_social_user" ADD PRIMARY KEY ("social_user_id");

-- ----------------------------
-- Indexes structure for table iot_social_user
-- ----------------------------
CREATE UNIQUE INDEX "iot_social_user_pk"
  ON "iot_social_user" ("social_user_id" ASC);
CREATE UNIQUE INDEX "iot_social_user_unique_key"
  ON "iot_social_user" ("uuid" ASC, "source" ASC);

-- ----------------------------
-- Primary Key structure for table iot_things_model
-- ----------------------------
ALTER TABLE "iot_things_model" ADD PRIMARY KEY ("model_id");

-- ----------------------------
-- Indexes structure for table iot_things_model
-- ----------------------------
CREATE INDEX "iot_things_model_index_product_id"
  ON "iot_things_model" ("product_id" ASC);
CREATE INDEX "iot_things_model_index_tenant_id"
  ON "iot_things_model" ("tenant_id" ASC);
CREATE INDEX "iot_things_model_index_model_order"
  ON "iot_things_model" ("model_order" ASC);

-- ----------------------------
-- Primary Key structure for table iot_things_model_template
-- ----------------------------
ALTER TABLE "iot_things_model_template" ADD PRIMARY KEY ("template_id");

-- ----------------------------
-- Indexes structure for table iot_things_model_template
-- ----------------------------
CREATE INDEX "iot_things_model_template_index_tenant_id"
  ON "iot_things_model_template" ("tenant_id" ASC);
CREATE INDEX "iot_things_model_template_index_model_order"
  ON "iot_things_model_template" ("model_order" ASC);

-- ----------------------------
-- Primary Key structure for table media_server
-- ----------------------------
ALTER TABLE "media_server" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table news
-- ----------------------------
ALTER TABLE "news" ADD PRIMARY KEY ("news_id");

-- ----------------------------
-- Indexes structure for table news
-- ----------------------------
CREATE INDEX "news_index_category_id"
  ON "news" ("category_id" ASC);

-- ----------------------------
-- Primary Key structure for table news_category
-- ----------------------------
ALTER TABLE "news_category" ADD PRIMARY KEY ("category_id");

-- ----------------------------
-- Primary Key structure for table oauth_client_details
-- ----------------------------
ALTER TABLE "oauth_client_details" ADD PRIMARY KEY ("client_id");

-- ----------------------------
-- Primary Key structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE "qrtz_blob_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_calendars
-- ----------------------------
ALTER TABLE "qrtz_calendars" ADD PRIMARY KEY ("sched_name", "calendar_name");

-- ----------------------------
-- Primary Key structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE "qrtz_cron_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_fired_triggers
-- ----------------------------
ALTER TABLE "qrtz_fired_triggers" ADD PRIMARY KEY ("sched_name", "entry_id");

-- ----------------------------
-- Primary Key structure for table qrtz_job_details
-- ----------------------------
ALTER TABLE "qrtz_job_details" ADD PRIMARY KEY ("sched_name", "job_name", "job_group");

-- ----------------------------
-- Primary Key structure for table qrtz_locks
-- ----------------------------
ALTER TABLE "qrtz_locks" ADD PRIMARY KEY ("sched_name", "lock_name");

-- ----------------------------
-- Primary Key structure for table qrtz_paused_trigger_grps
-- ----------------------------
ALTER TABLE "qrtz_paused_trigger_grps" ADD PRIMARY KEY ("sched_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_scheduler_state
-- ----------------------------
ALTER TABLE "qrtz_scheduler_state" ADD PRIMARY KEY ("sched_name", "instance_name");

-- ----------------------------
-- Primary Key structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE "qrtz_simple_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE "qrtz_simprop_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Primary Key structure for table qrtz_triggers
-- ----------------------------
ALTER TABLE "qrtz_triggers" ADD PRIMARY KEY ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Indexes structure for table qrtz_triggers
-- ----------------------------
CREATE INDEX "sched_name"
  ON "qrtz_triggers" ("sched_name" ASC, "job_name" ASC, "job_group" ASC);

-- ----------------------------
-- Primary Key structure for table sip_config
-- ----------------------------
ALTER TABLE "sip_config" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sip_device
-- ----------------------------
ALTER TABLE "sip_device" ADD PRIMARY KEY ("device_id");

-- ----------------------------
-- Primary Key structure for table sip_device_channel
-- ----------------------------
ALTER TABLE "sip_device_channel" ADD PRIMARY KEY ("id", "device_sip_id");

-- ----------------------------
-- Primary Key structure for table sys_auth_user
-- ----------------------------
ALTER TABLE "sys_auth_user" ADD PRIMARY KEY ("auth_id");

-- ----------------------------
-- Primary Key structure for table sys_config
-- ----------------------------
ALTER TABLE "sys_config" ADD PRIMARY KEY ("config_id");

-- ----------------------------
-- Primary Key structure for table sys_dept
-- ----------------------------
ALTER TABLE "sys_dept" ADD PRIMARY KEY ("dept_id");

-- ----------------------------
-- Primary Key structure for table sys_dict_data
-- ----------------------------
ALTER TABLE "sys_dict_data" ADD PRIMARY KEY ("dict_code");

-- ----------------------------
-- Primary Key structure for table sys_dict_type
-- ----------------------------
ALTER TABLE "sys_dict_type" ADD PRIMARY KEY ("dict_id");

-- ----------------------------
-- Indexes structure for table sys_dict_type
-- ----------------------------
CREATE UNIQUE INDEX "dict_type"
  ON "sys_dict_type" ("dict_type" ASC);

-- ----------------------------
-- Primary Key structure for table sys_job
-- ----------------------------
ALTER TABLE "sys_job" ADD PRIMARY KEY ("job_id", "job_name", "job_group");

-- ----------------------------
-- Primary Key structure for table sys_job_log
-- ----------------------------
ALTER TABLE "sys_job_log" ADD PRIMARY KEY ("job_log_id");

-- ----------------------------
-- Primary Key structure for table sys_logininfor
-- ----------------------------
ALTER TABLE "sys_logininfor" ADD PRIMARY KEY ("info_id");

-- ----------------------------
-- Primary Key structure for table sys_menu
-- ----------------------------
ALTER TABLE "sys_menu" ADD PRIMARY KEY ("menu_id");

-- ----------------------------
-- Primary Key structure for table sys_notice
-- ----------------------------
ALTER TABLE "sys_notice" ADD PRIMARY KEY ("notice_id");

-- ----------------------------
-- Primary Key structure for table sys_oper_log
-- ----------------------------
ALTER TABLE "sys_oper_log" ADD PRIMARY KEY ("oper_id");

-- ----------------------------
-- Primary Key structure for table sys_post
-- ----------------------------
ALTER TABLE "sys_post" ADD PRIMARY KEY ("post_id");

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "sys_role" ADD PRIMARY KEY ("role_id");

-- ----------------------------
-- Primary Key structure for table sys_role_dept
-- ----------------------------
ALTER TABLE "sys_role_dept" ADD PRIMARY KEY ("role_id", "dept_id");

-- ----------------------------
-- Primary Key structure for table sys_role_menu
-- ----------------------------
ALTER TABLE "sys_role_menu" ADD PRIMARY KEY ("role_id", "menu_id");

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "sys_user" ADD PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table sys_user_post
-- ----------------------------
ALTER TABLE "sys_user_post" ADD PRIMARY KEY ("user_id", "post_id");

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "sys_user_role" ADD PRIMARY KEY ("user_id", "role_id");

-- ----------------------------
-- Foreign Keys structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE "qrtz_blob_triggers" ADD CONSTRAINT "QRTZ_BLOB_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "qrtz_triggers" ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Foreign Keys structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE "qrtz_cron_triggers" ADD CONSTRAINT "QRTZ_CRON_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "qrtz_triggers" ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Foreign Keys structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE "qrtz_simple_triggers" ADD CONSTRAINT "QRTZ_SIMPLE_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "qrtz_triggers" ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Foreign Keys structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE "qrtz_simprop_triggers" ADD CONSTRAINT "QRTZ_SIMPROP_TRIGGERS_ibfk_1" FOREIGN KEY ("sched_name", "trigger_name", "trigger_group") REFERENCES "qrtz_triggers" ("sched_name", "trigger_name", "trigger_group");

-- ----------------------------
-- Foreign Keys structure for table qrtz_triggers
-- ----------------------------
