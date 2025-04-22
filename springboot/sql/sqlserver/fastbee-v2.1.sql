/*
 Navicat Premium Data Transfer

 Source Server         : 81.71.97.58_3306
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : 81.71.97.58:3306
 Source Schema         : kaiyuan

 Target Server Type    : SQL Server
 Target Server Version : 14000000
 File Encoding         : 65001

 Date: 21/04/2025 14:32:13
*/


-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_table]') AND type IN ('U'))
	DROP TABLE [dbo].[gen_table]
GO

CREATE TABLE [dbo].[gen_table] (
  [table_id] bigint NOT NULL,
  [table_name] nvarchar(200) NULL,
  [table_comment] nvarchar(500) NULL,
  [sub_table_name] nvarchar(64) NULL,
  [sub_table_fk_name] nvarchar(64) NULL,
  [class_name] nvarchar(100) NULL,
  [tpl_category] nvarchar(200) NULL,
  [package_name] nvarchar(100) NULL,
  [module_name] nvarchar(30) NULL,
  [business_name] nvarchar(30) NULL,
  [function_name] nvarchar(50) NULL,
  [function_author] nvarchar(50) NULL,
  [gen_type] nchar(1) NULL,
  [gen_path] nvarchar(200) NULL,
  [options] nvarchar(1000) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'编号',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'table_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表名称',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'table_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表描述',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'table_comment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'关联子表的表名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'sub_table_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'子表关联的外键名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'sub_table_fk_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实体类名称',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'class_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'使用的模板（crud单表操作 tree树表操作）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'tpl_category'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成包路径',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'package_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成模块名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'module_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成业务名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'business_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成功能名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'function_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成功能作者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'function_author'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成代码方式（0zip压缩包 1自定义路径）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'gen_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'生成路径（不填默认项目路径）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'gen_path'
GO

EXEC sp_addextendedproperty
'MS_Description', N'其它生成选项',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'options'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'gen_table',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'代码生成业务表',
'SCHEMA', N'dbo',
'TABLE', N'gen_table'
GO


-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_table_column]') AND type IN ('U'))
	DROP TABLE [dbo].[gen_table_column]
GO

CREATE TABLE [dbo].[gen_table_column] (
  [column_id] bigint NOT NULL,
  [table_id] nvarchar(64) NULL,
  [column_name] nvarchar(200) NULL,
  [column_comment] nvarchar(500) NULL,
  [column_type] nvarchar(100) NULL,
  [java_type] nvarchar(500) NULL,
  [java_field] nvarchar(200) NULL,
  [is_pk] nchar(1) NULL,
  [is_increment] nchar(1) NULL,
  [is_required] nchar(1) NULL,
  [is_insert] nchar(1) NULL,
  [is_edit] nchar(1) NULL,
  [is_list] nchar(1) NULL,
  [is_query] nchar(1) NULL,
  [query_type] nvarchar(200) NULL,
  [html_type] nvarchar(200) NULL,
  [dict_type] nvarchar(200) NULL,
  [sort] int NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'编号',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'column_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'归属表编号',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'table_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'列名称',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'column_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'列描述',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'column_comment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'列类型',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'column_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'JAVA类型',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'java_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'JAVA字段名',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'java_field'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否主键（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_pk'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否自增（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_increment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否必填（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_required'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否为插入字段（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_insert'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否编辑字段（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_edit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否列表字段（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_list'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否查询字段（1是）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'is_query'
GO

EXEC sp_addextendedproperty
'MS_Description', N'查询方式（等于、不等于、大于、小于、范围）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'query_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'html_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典类型',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'代码生成业务表字段',
'SCHEMA', N'dbo',
'TABLE', N'gen_table_column'
GO


-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_category
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_category]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_category]
GO

CREATE TABLE [dbo].[iot_category] (
  [category_id] bigint NOT NULL,
  [category_name] nvarchar(64) NOT NULL,
  [tenant_id] bigint NOT NULL,
  [tenant_name] nvarchar(30) NOT NULL,
  [is_sys] tinyint NOT NULL,
  [parent_id] bigint NULL,
  [order_num] int NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品分类ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'category_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品分类名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'category_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否系统通用（0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'is_sys'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父级ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'order_num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_category',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品分类',
'SCHEMA', N'dbo',
'TABLE', N'iot_category'
GO


-- ----------------------------
-- Records of iot_category
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_category] ([category_id], [category_name], [tenant_id], [tenant_name], [is_sys], [parent_id], [order_num], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'电工照明', N'1', N'admin', N'1', N'0', N'1', N'0', N'', N'2022-03-01 11:44:37', N'', N'2023-04-10 01:12:48', N'例如：通断器、开关、插座、窗帘、灯'), (N'2', N'家居安防', N'1', N'admin', N'1', N'0', N'2', N'0', N'', N'2021-12-18 14:46:52', N'', N'2021-12-18 14:49:48', N'例如：智能门锁、摄像头、智能窗帘'), (N'3', N'环境电器', N'1', N'admin', N'1', N'0', N'3', N'0', N'', N'2021-12-18 14:50:24', N'', N'2023-04-10 01:12:53', N'例如：加湿器、风扇、扫地机器人'), (N'4', N'大家电', N'1', N'admin', N'1', N'0', N'4', N'0', N'', N'2021-12-18 14:50:58', N'', N'2021-12-18 14:52:30', N'例如：冰箱、热水器、电视'), (N'5', N'厨房电器', N'1', N'admin', N'1', N'0', N'5', N'0', N'', N'2021-12-18 14:51:42', N'', N'2021-12-18 14:52:35', N'例如：油烟机、烤箱、电饭煲'), (N'6', N'个护健康', N'1', N'admin', N'1', N'0', N'6', N'0', N'', N'2021-12-18 14:52:15', N'', N'2021-12-18 14:52:40', N'例如：洗衣机、按摩椅'), (N'7', N'其他', N'1', N'admin', N'1', N'0', N'7', N'0', N'', N'2021-12-18 14:52:54', N'', N'2021-12-20 15:04:33', N'其他')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_device
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_device]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_device]
GO

CREATE TABLE [dbo].[iot_device] (
  [device_id] bigint NOT NULL,
  [device_name] nvarchar(64) NOT NULL,
  [product_id] bigint NOT NULL,
  [product_name] nvarchar(64) NOT NULL,
  [user_id] bigint NOT NULL,
  [user_name] nvarchar(30) NOT NULL,
  [tenant_id] bigint NOT NULL,
  [tenant_name] nvarchar(30) NOT NULL,
  [serial_number] nvarchar(64) NOT NULL,
  [gw_dev_code] nvarchar(64) NULL,
  [firmware_version] real NOT NULL,
  [status] tinyint NOT NULL,
  [rssi] bigint NULL,
  [is_shadow] tinyint NULL,
  [location_way] tinyint NULL,
  [things_model_value] varchar(max) NULL,
  [network_address] nvarchar(255) NULL,
  [network_ip] nvarchar(32) NULL,
  [longitude] float NULL,
  [latitude] float NULL,
  [active_time] datetime2 NULL,
  [summary] varchar(max) NULL,
  [img_url] nvarchar(255) NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL,
  [is_simulate] tinyint NULL,
  [slave_id] int NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'device_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'device_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'product_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备编号',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'serial_number'
GO

EXEC sp_addextendedproperty
'MS_Description', N'子设备网关编号',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'gw_dev_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'固件版本',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'firmware_version'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备状态（1-未激活，2-禁用，3-在线，4-离线）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'信号强度（
信号极好4格[-55— 0]，
信号好3格[-70— -55]，
信号一般2格[-85— -70]，
信号差1格[-100— -85]）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'rssi'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否启用设备影子(0=禁用，1=启用)',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'is_shadow'
GO

EXEC sp_addextendedproperty
'MS_Description', N'定位方式(1=ip自动定位，2=设备定位，3=自定义)',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'location_way'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型值',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'things_model_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备所在地址',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'network_address'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备入网IP',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'network_ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备经度',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'longitude'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备纬度',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'latitude'
GO

EXEC sp_addextendedproperty
'MS_Description', N'激活时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'active_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备摘要，格式[{"name":"device"},{"chip":"esp8266"}]',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'summary'
GO

EXEC sp_addextendedproperty
'MS_Description', N'图片地址',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'img_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否是模拟设备',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'is_simulate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'从机id',
'SCHEMA', N'dbo',
'TABLE', N'iot_device',
'COLUMN', N'slave_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备',
'SCHEMA', N'dbo',
'TABLE', N'iot_device'
GO


-- ----------------------------
-- Records of iot_device
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_device] ([device_id], [device_name], [product_id], [product_name], [user_id], [user_name], [tenant_id], [tenant_name], [serial_number], [gw_dev_code], [firmware_version], [status], [rssi], [is_shadow], [location_way], [things_model_value], [network_address], [network_ip], [longitude], [latitude], [active_time], [summary], [img_url], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark], [is_simulate], [slave_id]) VALUES (N'108', N'温湿度开关', N'41', N'★智能开关产品', N'1', N'admin', N'1', N'admin', N'D1ELV3A5TOJS', NULL, N'1.00', N'4', N'-51', N'1', N'1', N'[{"id": "irc", "name": "射频遥控", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "report_monitor", "name": "上报数据", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "humidity", "name": "空气湿度", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "co2", "name": "二氧化碳", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "value": " , , , ", "shadow": " , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "reset", "name": "设备重启", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "status", "name": "上报状态", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "temperature", "name": "空气温度", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "brightness", "name": "室内亮度", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}]', N' 本机地址', N'127.0.0.1', N'113.128512', N'23.027759', N'2023-02-26 00:00:00', N'{"chip": "esp8266", "name": "wumei-smart", "author": "kerwincui", "create": "2022-06-06", "version": 1.6}', NULL, N'0', N'', N'2025-02-25 23:15:56', N'', N'2024-04-23 15:47:11', NULL, NULL, NULL), (N'109', N'网关设备', N'55', N'★网关产品', N'1', N'admin', N'1', N'admin', N'D1PGLPG58KZ2', NULL, N'1.00', N'4', N'-73', N'1', N'3', N'[{"id": "category_gear", "name": "运行档位", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_switch", "name": "设备开关", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_light", "ts": "2023-09-25 17:56:08.848", "name": "光照", "value": "68", "shadow": "68", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "value": " , , , , , , ", "shadow": " , , , , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "value": " , , , ", "shadow": " , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "temperature", "ts": "2023-09-25 17:56:08.582", "name": "空气温度", "value": "23.69", "shadow": "23.69", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_irc", "name": "射频遥控", "value": " , , , , , , ", "shadow": " , , , , , , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "brightness", "ts": "2023-09-25 17:56:08.671", "name": "室内亮度", "value": "5387", "shadow": "5387", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "report_monitor", "name": "上报监测数据", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "ts": "2023-09-25 17:56:26.188", "name": "设备开关", "value": "1,1,1, ,1,1, ", "shadow": "1,1,1, ,1,1, ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_temperature", "ts": "2023-09-25 17:56:09.203", "name": "空气温度-只读", "value": "95", "shadow": "95", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_co2", "ts": "2023-09-25 17:56:11.229", "name": "二氧化碳", "value": "3780,2612,2145,3988,5697, , ", "shadow": "3780,2612,2145,3988,5697, , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_gear", "ts": "2023-09-25 17:56:28.066", "name": "运行档位", "value": "0,0,0, ,0,0, ", "shadow": "0,0,0, ,0,0, ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_humidity", "ts": "2023-09-25 17:56:09.025", "name": "空气湿度", "value": "90", "shadow": "90", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_report_monitor", "name": "上报监测数据", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "category_irc", "name": "射频遥控", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "reset", "name": "设备重启", "value": "", "shadow": "", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "device_temperature", "ts": "2023-09-25 17:56:11.45", "name": "空气温度-只读", "value": "86,39,4,80,52, , ", "shadow": "86,39,4,80,52, , ", "isChart": 0, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}]', N'云南省曲靖市 移通', N'183.225.206.92', N'104.802435', N'26.496407', N'2023-02-26 00:00:00', N'{"chip": "esp8266", "name": "wumei-smart", "author": "kerwincui", "create": "2022-06-06", "version": 1.6}', NULL, N'0', N'', N'2025-02-25 23:17:31', N'', N'2023-09-25 23:14:52', NULL, NULL, NULL), (N'140', N'视频监控', N'88', N'￥视频监控产品', N'1', N'admin', N'1', N'admin', N'11010200001320000001', NULL, N'1.00', N'4', N'0', N'0', N'1', NULL, N'广东省 移通', N'120.231.214.134', NULL, NULL, N'2023-04-11 21:14:16', N'{"port": 5060, "firmware": "V5.7.4", "transport": "UDP", "streammode": "UDP", "hostaddress": "192.168.2.119:5060", "manufacturer": "Hikvision"}', NULL, N'0', N'', N'2023-04-11 21:12:35', N'', N'2023-04-11 22:11:01', NULL, N'0', NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_device_group
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_device_group]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_device_group]
GO

CREATE TABLE [dbo].[iot_device_group] (
  [device_id] bigint NOT NULL,
  [group_id] bigint NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_group',
'COLUMN', N'device_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分组ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_group',
'COLUMN', N'group_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备分组',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_group'
GO


-- ----------------------------
-- Records of iot_device_group
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_device_job
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_device_job]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_device_job]
GO

CREATE TABLE [dbo].[iot_device_job] (
  [job_id] bigint NOT NULL,
  [job_name] nvarchar(64) NOT NULL,
  [job_group] nvarchar(64) NOT NULL,
  [cron_expression] nvarchar(255) NULL,
  [misfire_policy] nvarchar(20) NULL,
  [concurrent] nchar(1) NULL,
  [status] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL,
  [device_id] bigint NULL,
  [serial_number] nvarchar(64) NULL,
  [device_name] nvarchar(64) NULL,
  [is_advance] tinyint NULL,
  [actions] varchar(max) NULL,
  [job_type] tinyint NULL,
  [product_id] bigint NULL,
  [product_name] nvarchar(64) NULL,
  [scene_id] bigint NULL,
  [alert_id] bigint NULL,
  [alert_trigger] varchar(max) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'job_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'job_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务组名',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'job_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'cron执行表达式',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'cron_expression'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'misfire_policy'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否并发执行（0允许 1禁止）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'concurrent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（0正常 1暂停）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注信息',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'device_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备编号',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'serial_number'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'device_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否详细corn表达式（1=是，0=否）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'is_advance'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行的动作集合',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'actions'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务类型（1=设备定时，2=设备告警，3=场景联动）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'job_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'product_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'场景联动ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'scene_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'告警ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'alert_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'定时告警触发器',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job',
'COLUMN', N'alert_trigger'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备定时',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_job'
GO


-- ----------------------------
-- Records of iot_device_job
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_device_job] ([job_id], [job_name], [job_group], [cron_expression], [misfire_policy], [concurrent], [status], [create_by], [create_time], [update_by], [update_time], [remark], [device_id], [serial_number], [device_name], [is_advance], [actions], [job_type], [product_id], [product_name], [scene_id], [alert_id], [alert_trigger]) VALUES (N'4', N'P', N'DEFAULT', N'0 08 11 ? * 1,2,3,4,5,6,7', N'2', N'1', N'0', N'admin', N'2023-04-15 11:08:37', N'', NULL, N'', N'108', N'D1ELV3A5TOJS', N'★温湿度开关', N'0', N'[{"id": "gear", "name": "运行档位", "type": 2, "value": "2", "deviceId": 108, "deviceName": "★温湿度开关"}]', N'1', N'41', N'★智能开关产品', NULL, NULL, NULL), (N'5', N'告警定时触发', N'DEFAULT', N'0 13 11 ? * 1,2,3,4,5,6,7', N'2', N'1', N'0', N'', N'2023-04-15 11:14:06', N'', NULL, N'', NULL, NULL, N'告警定时触发', N'0', N'[{"id": "gear", "name": "运行档位", "type": 2, "value": "1", "productId": 96, "productName": "★网关产品"}]', N'2', N'96', N'★网关产品', NULL, N'50', N'{"id": "temperature", "name": "空气温度", "type": 1, "jobId": 0, "value": "1", "params": {}, "source": 2, "status": 1, "alertId": 50, "operator": "=", "isAdvance": 0, "productId": 96, "productName": "★网关产品", "cronExpression": "0 13 11 ? * 1,2,3,4,5,6,7"}')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_device_log
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_device_log]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_device_log]
GO

CREATE TABLE [dbo].[iot_device_log] (
  [log_id] bigint NOT NULL,
  [identity] nvarchar(64) NOT NULL,
  [model_name] nvarchar(255) NULL,
  [log_type] tinyint NOT NULL,
  [log_value] nvarchar(64) NOT NULL,
  [device_id] bigint NULL,
  [device_name] nvarchar(64) NULL,
  [serial_number] nvarchar(64) NULL,
  [is_monitor] tinyint NOT NULL,
  [mode] tinyint NOT NULL,
  [user_id] bigint NULL,
  [user_name] nvarchar(30) NULL,
  [tenant_id] bigint NULL,
  [tenant_name] nvarchar(30) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [remark] nvarchar(200) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备监测信息ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'log_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标识符',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'identity'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'model_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'类型（1=属性上报，2=调用功能，3=事件上报，4=设备升级，5=设备上线，6=设备离线）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'log_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日志值',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'log_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'device_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'device_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备编号',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'serial_number'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否监测数据（1=是，0=否）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'is_monitor'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模式(1=影子模式，2=在线模式，3=其他)',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'mode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备日志',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_log'
GO


-- ----------------------------
-- Records of iot_device_log
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_device_template
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_device_template]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_device_template]
GO

CREATE TABLE [dbo].[iot_device_template] (
  [id] bigint NOT NULL,
  [product_id] bigint NULL,
  [template_id] bigint NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自增id',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_template',
'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品id',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_template',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'采集点模板id',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_template',
'COLUMN', N'template_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备采集点模板关联对象',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_template'
GO


-- ----------------------------
-- Records of iot_device_template
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_device_template] ([id], [product_id], [template_id]) VALUES (N'2', N'112', N'1'), (N'3', N'118', N'4'), (N'4', N'120', N'6'), (N'5', N'121', N'1'), (N'7', N'123', N'11'), (N'33', N'119', N'2'), (N'34', N'121', N'3'), (N'35', N'122', N'3'), (N'36', N'125', N'6'), (N'38', N'127', N'7'), (N'39', N'128', N'1')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_device_user
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_device_user]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_device_user]
GO

CREATE TABLE [dbo].[iot_device_user] (
  [device_id] bigint NOT NULL,
  [user_id] bigint NOT NULL,
  [tenant_id] bigint NOT NULL,
  [tenant_name] nvarchar(30) NOT NULL,
  [device_name] nvarchar(64) NOT NULL,
  [phonenumber] nvarchar(11) NULL,
  [user_name] nvarchar(30) NOT NULL,
  [is_owner] tinyint NOT NULL,
  [perms] nvarchar(255) NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'device_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'device_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'手机号码',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'phonenumber'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否为设备所有者（0=否，1=是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'is_owner'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户物模型权限，多个以英文逗号分隔',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'perms'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备用户',
'SCHEMA', N'dbo',
'TABLE', N'iot_device_user'
GO


-- ----------------------------
-- Records of iot_device_user
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_device_user] ([device_id], [user_id], [tenant_id], [tenant_name], [device_name], [phonenumber], [user_name], [is_owner], [perms], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'108', N'1', N'1', N'admin', N'★温湿度开关', N'15888888888', N'admin', N'1', NULL, N'0', N'', N'2023-02-25 23:15:57', N'', NULL, NULL), (N'109', N'1', N'1', N'admin', N'★网关设备', N'15888888888', N'admin', N'1', NULL, N'0', N'', N'2023-02-25 23:17:32', N'', NULL, NULL), (N'109', N'3', N'1', N'admin', N'★网关设备', N'15888888881', N'fastbee-t2', N'0', N'ota,timer,log,monitor,statistic,reset,gear,switch', N'0', N'', N'2023-09-03 01:17:03', N'', N'2023-09-03 11:05:06', NULL), (N'109', N'7', N'1', N'admin', N'★网关设备', N'18257292958', N'shenzehui', N'0', NULL, N'0', N'', N'2023-08-24 08:26:34', N'', NULL, NULL), (N'109', N'8', N'1', N'admin', N'★网关设备', N'15752221201', N'shadow', N'0', NULL, N'0', N'', N'2023-08-24 08:25:44', N'', NULL, NULL), (N'118', N'1', N'1', N'admin', N'￥MODBUS网关设备', N'15888888888', N'admin', N'1', NULL, N'0', N'', N'2023-02-28 16:49:18', N'', NULL, NULL), (N'140', N'1', N'1', N'admin', N'￥视频监控', N'15888888888', N'admin', N'1', NULL, N'0', N'', N'2023-04-11 21:12:37', N'', NULL, NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_event_log
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_event_log]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_event_log]
GO

CREATE TABLE [dbo].[iot_event_log] (
  [log_id] bigint NOT NULL,
  [identity] nvarchar(64) NOT NULL,
  [model_name] nvarchar(255) NULL,
  [log_type] tinyint NOT NULL,
  [log_value] nvarchar(64) NOT NULL,
  [device_id] bigint NULL,
  [device_name] nvarchar(64) NULL,
  [serial_number] nvarchar(64) NULL,
  [is_monitor] tinyint NOT NULL,
  [mode] tinyint NOT NULL,
  [user_id] bigint NULL,
  [user_name] nvarchar(30) NULL,
  [tenant_id] bigint NULL,
  [tenant_name] nvarchar(30) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [remark] nvarchar(200) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备事件日志ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'log_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标识符',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'identity'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'model_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'类型（3=事件上报，5=设备上线，6=设备离线）',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'log_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日志值',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'log_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'device_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'device_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备编号',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'serial_number'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否监测数据（1=是，0=否）',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'is_monitor'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模式(1=影子模式，2=在线模式，3=其他)',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'mode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'事件日志',
'SCHEMA', N'dbo',
'TABLE', N'iot_event_log'
GO


-- ----------------------------
-- Records of iot_event_log
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_function_log
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_function_log]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_function_log]
GO

CREATE TABLE [dbo].[iot_function_log] (
  [id] bigint NOT NULL,
  [identify] nvarchar(64) NOT NULL,
  [fun_type] int NOT NULL,
  [fun_value] nvarchar(64) NOT NULL,
  [message_id] nvarchar(64) NULL,
  [device_name] nvarchar(64) NULL,
  [serial_number] nvarchar(64) NOT NULL,
  [mode] int NULL,
  [user_id] bigint NULL,
  [result_msg] nvarchar(128) NULL,
  [result_code] int NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [remark] nvarchar(128) NULL,
  [show_value] nvarchar(255) NULL,
  [model_name] nvarchar(64) NULL,
  [reply_time] datetime2 NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备功能日志ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标识符',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'identify'
GO

EXEC sp_addextendedproperty
'MS_Description', N'1==服务下发，2=属性获取，3.OTA升级',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'fun_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日志值',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'fun_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'消息id',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'message_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'device_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备编号',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'serial_number'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模式(1=影子模式，2=在线模式，3=其他)',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'mode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户id',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'下发结果描述',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'result_msg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'下发结果代码',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'result_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示值',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'show_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'model_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备回复时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log',
'COLUMN', N'reply_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备服务下发日志',
'SCHEMA', N'dbo',
'TABLE', N'iot_function_log'
GO


-- ----------------------------
-- Records of iot_function_log
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_group
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_group]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_group]
GO

CREATE TABLE [dbo].[iot_group] (
  [group_id] bigint NOT NULL,
  [group_name] nvarchar(64) NOT NULL,
  [group_order] tinyint NOT NULL,
  [user_id] bigint NOT NULL,
  [user_name] nvarchar(30) NOT NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'分组ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'group_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分组名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'group_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分组排序',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'group_order'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_group',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备分组',
'SCHEMA', N'dbo',
'TABLE', N'iot_group'
GO


-- ----------------------------
-- Records of iot_group
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_group] ([group_id], [group_name], [group_order], [user_id], [user_name], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'2', N'卧室', N'2', N'1', N'admin', N'0', N'', N'2021-12-29 13:12:42', N'', N'2023-04-09 22:37:06', N'卧室设备'), (N'3', N'厨房', N'3', N'1', N'admin', N'0', N'', N'2021-12-29 13:12:59', N'', N'2021-12-29 13:13:48', N'厨房设备'), (N'4', N'书房', N'4', N'1', N'admin', N'0', N'', N'2021-12-29 13:13:10', N'', N'2021-12-29 13:13:54', N'书房设备'), (N'5', N'卫生间', N'5', N'1', N'admin', N'0', N'', N'2021-12-29 13:13:18', N'', N'2021-12-29 13:14:03', N'卫生间设备'), (N'6', N'走道', N'6', N'1', N'admin', N'0', N'', N'2021-12-29 13:13:26', N'', N'2021-12-29 13:14:11', N'走道设备')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_product
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_product]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_product]
GO

CREATE TABLE [dbo].[iot_product] (
  [product_id] bigint NOT NULL,
  [product_name] nvarchar(64) NOT NULL,
  [protocol_code] nvarchar(64) NULL,
  [category_id] bigint NOT NULL,
  [category_name] nvarchar(64) NOT NULL,
  [tenant_id] bigint NOT NULL,
  [tenant_name] nvarchar(30) NOT NULL,
  [is_sys] tinyint NOT NULL,
  [is_authorize] tinyint NOT NULL,
  [mqtt_account] nvarchar(64) NULL,
  [mqtt_password] nvarchar(64) NULL,
  [mqtt_secret] nvarchar(64) NULL,
  [status] tinyint NULL,
  [things_models_json] varchar(max) NULL,
  [device_type] tinyint NULL,
  [network_method] tinyint NULL,
  [vertificate_method] tinyint NULL,
  [img_url] nvarchar(255) NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL,
  [transport] nvarchar(64) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'product_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'协议编号',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'protocol_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品分类ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'category_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品分类名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'category_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否系统通用（0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'is_sys'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否启用授权码（0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'is_authorize'
GO

EXEC sp_addextendedproperty
'MS_Description', N'mqtt账号',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'mqtt_account'
GO

EXEC sp_addextendedproperty
'MS_Description', N'mqtt密码',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'mqtt_password'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品秘钥',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'mqtt_secret'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（1-未发布，2-已发布）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型JSON（属性、功能、事件）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'things_models_json'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备类型（1-直连设备、2-网关设备、3-监控设备）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'device_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联网方式（1=wifi、2=蜂窝(2G/3G/4G/5G)、3=以太网、4=其他）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'network_method'
GO

EXEC sp_addextendedproperty
'MS_Description', N'认证方式（1-简单认证、2-加密认证、3-简单+加密）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'vertificate_method'
GO

EXEC sp_addextendedproperty
'MS_Description', N'图片地址',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'img_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品支持的传输协议',
'SCHEMA', N'dbo',
'TABLE', N'iot_product',
'COLUMN', N'transport'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品',
'SCHEMA', N'dbo',
'TABLE', N'iot_product'
GO


-- ----------------------------
-- Records of iot_product
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_product] ([product_id], [product_name], [protocol_code], [category_id], [category_name], [tenant_id], [tenant_name], [is_sys], [is_authorize], [mqtt_account], [mqtt_password], [mqtt_secret], [status], [things_models_json], [device_type], [network_method], [vertificate_method], [img_url], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark], [transport]) VALUES (N'41', N'智能开关产品', N'JSON', N'1', N'电工照明', N'1', N'admin', N'1', N'0', N'FastBee', N'P47T6OD5IPFWHUM6', N'KX3TSH4Q4OS835DO', N'2', N'{"events": [{"id": "exception", "name": "设备发生异常", "type": 3, "order": 0, "regId": "exception", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "height_temperature", "name": "环境温度过高", "type": 3, "order": 0, "regId": "height_temperature", "isChart": 0, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}], "functions": [{"id": "report_monitor", "name": "上报数据", "type": 2, "order": 10, "regId": "report_monitor", "isChart": 0, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "type": 2, "order": 7, "regId": "message", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "type": 2, "order": 5, "regId": "light_color", "isChart": 0, "datatype": {"type": "array", "arrayType": "integer", "arrayCount": "3"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "type": 2, "order": 9, "regId": "switch", "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "reset", "name": "设备重启", "type": 2, "order": 6, "regId": "reset", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "irc", "name": "射频遥控", "type": 2, "order": 11, "regId": "irc", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "type": 2, "order": 8, "regId": "gear", "isChart": 0, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "status", "name": "上报状态", "type": 2, "order": 12, "regId": "status", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "properties": [{"id": "co2", "name": "二氧化碳", "type": 1, "order": 2, "regId": "co2", "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "brightness", "name": "室内亮度", "type": 1, "order": 4, "regId": "brightness", "isChart": 1, "datatype": {"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "temperature", "name": "空气温度", "type": 1, "order": 1, "regId": "temperature", "isChart": 1, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "humidity", "name": "空气湿度", "type": 1, "order": 3, "regId": "humidity", "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}]}', N'1', N'1', N'3', NULL, N'0', N'', N'2025-08-14 00:06:33', N'', N'2023-09-25 22:58:17', NULL, N'MQTT'), (N'55', N'网关产品', N'JSON', N'1', N'电工照明', N'1', N'admin', N'1', N'0', N'FastBee', N'P467433O1MT8MXS2', N'KWF32S3H95LH14LO', N'2', N'{"events": [{"id": "exception", "name": "设备发生异常", "type": 3, "order": 0, "regId": "exception", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "height_temperature", "name": "环境温度过高", "type": 3, "order": 0, "regId": "height_temperature", "isChart": 0, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}], "functions": [{"id": "color", "name": "状态灯色", "type": 2, "order": 0, "regId": "color", "isChart": 0, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "红色", "value": "0"}, {"text": "绿色", "value": "1"}, {"text": "蓝色", "value": "2"}, {"text": "黄色", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "message", "name": "屏显消息", "type": 2, "order": 0, "regId": "message", "isChart": 0, "datatype": {"type": "string", "maxLength": 1024}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "light_color", "name": "灯光色值", "type": 2, "order": 0, "regId": "light_color", "isChart": 0, "datatype": {"type": "array", "arrayType": "integer", "arrayCount": "3"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "switch", "name": "设备开关", "type": 2, "order": 0, "regId": "switch", "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "irc", "name": "射频遥控", "type": 2, "order": 0, "regId": "irc", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "device", "name": "子设备", "type": 2, "order": 0, "regId": "device", "isChart": 0, "datatype": {"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "name": "设备开关", "order": 5, "datatype": {"type": "bool", "enumList": [{"text": "", "value": ""}], "trueText": "打开", "arrayType": "int", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "arrayType": "object", "arrayCount": 5}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "status", "name": "上报状态", "type": 2, "order": 0, "regId": "status", "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group", "name": "功能分组", "type": 2, "order": 0, "regId": "group", "isChart": 0, "datatype": {"type": "object", "params": [{"id": "group_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "group_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isMonitor": 1, "isReadonly": 1}, {"id": "group_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isMonitor": 0, "isReadonly": 1}, {"id": "group_report_monitor", "name": "上报监测数据", "order": 7, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group_gear", "name": "运行档位", "order": 5, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "group_switch", "name": "设备开关", "order": 4, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "group_irc", "name": "红外遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}]}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "gear", "name": "运行档位", "type": 2, "order": 0, "regId": "gear", "isChart": 0, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}], "properties": [{"id": "light_level", "name": "光照强度", "type": 1, "order": 0, "regId": "light_level", "isChart": 1, "datatype": {"max": 89.2, "min": 2.5, "step": 0.1, "type": "integer", "unit": "L/g"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "temperature", "name": "空气温度", "type": 1, "order": 0, "regId": "temperature", "isChart": 1, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "humidity", "name": "空气湿度", "type": 1, "order": 0, "regId": "humidity", "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}]}', N'2', N'2', N'3', NULL, N'0', N'', N'2025-02-25 22:51:39', N'', N'2023-09-16 11:46:43', NULL, N'MQTT'), (N'88', N'视频监控产品', NULL, N'2', N'家居安防', N'1', N'admin', N'1', N'0', N'FastBee', N'P0IB9M8A7J4R056V', N'K69914VL8175ZY21', N'2', N'{}', N'3', N'1', N'3', NULL, N'0', N'', N'2023-04-11 21:11:54', N'', N'2025-03-19 15:30:14', NULL, N'GB28181')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_product_authorize
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_product_authorize]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_product_authorize]
GO

CREATE TABLE [dbo].[iot_product_authorize] (
  [authorize_id] bigint NOT NULL,
  [authorize_code] nvarchar(32) NOT NULL,
  [product_id] bigint NOT NULL,
  [device_id] bigint NULL,
  [serial_number] nvarchar(64) NULL,
  [user_id] bigint NULL,
  [user_name] nvarchar(30) NULL,
  [status] tinyint NULL,
  [del_flag] nchar(1) NOT NULL,
  [create_by] nvarchar(64) NOT NULL,
  [create_time] datetime2 NOT NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'授权码ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'authorize_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'授权码',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'authorize_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'device_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备编号',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'serial_number'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（1-未使用，2-使用中）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品授权码表',
'SCHEMA', N'dbo',
'TABLE', N'iot_product_authorize'
GO


-- ----------------------------
-- Records of iot_product_authorize
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_protocol
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_protocol]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_protocol]
GO

CREATE TABLE [dbo].[iot_protocol] (
  [id] bigint NOT NULL,
  [protocol_code] nvarchar(60) NOT NULL,
  [protocol_name] nvarchar(60) NOT NULL,
  [protocol_file_url] nvarchar(500) NOT NULL,
  [protocol_type] int NOT NULL,
  [jar_sign] nvarchar(100) NOT NULL,
  [create_time] datetime2 NOT NULL,
  [update_time] datetime2 NOT NULL,
  [protocol_status] int NOT NULL,
  [del_flag] int NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自增id',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'协议编码',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'protocol_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'协议名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'protocol_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'协议jar包,js包，c程序上传地址',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'protocol_file_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'协议类型 0:未知 1:jar，2.js,3.c',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'protocol_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'协议文件摘要(文件的md5)',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'jar_sign'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'0:草稿 1:启用 2:停用',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'protocol_status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'0:正常 1:删除',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'协议表',
'SCHEMA', N'dbo',
'TABLE', N'iot_protocol'
GO


-- ----------------------------
-- Records of iot_protocol
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_protocol] ([id], [protocol_code], [protocol_name], [protocol_file_url], [protocol_type], [jar_sign], [create_time], [update_time], [protocol_status], [del_flag]) VALUES (N'1', N'JSON', N'JSON协议', N'/', N'0', N'系统内置JSON编解码协议', N'2023-03-01 05:46:43', N'2023-04-10 14:42:12', N'1', N'0')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_scene
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_scene]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_scene]
GO

CREATE TABLE [dbo].[iot_scene] (
  [scene_id] bigint NOT NULL,
  [scene_name] nvarchar(64) NOT NULL,
  [chain_name] nvarchar(32) NULL,
  [enable] tinyint NULL,
  [user_id] bigint NOT NULL,
  [user_name] nvarchar(64) NOT NULL,
  [silent_period] int NULL,
  [cond] tinyint NULL,
  [execute_mode] tinyint NULL,
  [execute_delay] int NULL,
  [has_alert] tinyint NULL,
  [application_name] nvarchar(32) NOT NULL,
  [el_data] nvarchar(max) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'场景ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'scene_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'场景名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'scene_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'规则名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'chain_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'场景状态（1-启动，2-停止）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'静默周期（分钟）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'silent_period'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行条件（1=或、任意条件，2=且、所有条件，3=非，不满足）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'cond'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行方式（1=串行，顺序执行，2=并行，同时执行）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'execute_mode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'延时执行（秒钟）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'execute_delay'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否包含告警推送（1=包含，2=不包含）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'has_alert'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'application_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'规则数据',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'el_data'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'场景联动',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene'
GO


-- ----------------------------
-- Records of iot_scene
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_scene_script
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_scene_script]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_scene_script]
GO

CREATE TABLE [dbo].[iot_scene_script] (
  [script_id] nvarchar(32) NOT NULL,
  [scene_id] bigint NOT NULL,
  [source] tinyint NOT NULL,
  [script_purpose] tinyint NOT NULL,
  [product_id] bigint NULL,
  [product_name] nvarchar(64) NULL,
  [id] nvarchar(64) NULL,
  [name] nvarchar(64) NULL,
  [value] nvarchar(64) NULL,
  [operator] nvarchar(16) NULL,
  [type] tinyint NULL,
  [device_count] int NULL,
  [job_id] bigint NULL,
  [cron_expression] nvarchar(255) NULL,
  [is_advance] tinyint NULL,
  [parent_id] nvarchar(32) NULL,
  [parent_name] nvarchar(32) NULL,
  [array_index] nvarchar(20) NULL,
  [array_index_name] nvarchar(20) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'script_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'场景ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'scene_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'触发源（1=设备触发，2=定时触发，3=产品触发,4=告警执行）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'source'
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本用途(1=数据流，2=触发器，3=执行动作)',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'script_purpose'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID（用于获取对应物模型）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'product_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型标识符',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型值',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作符',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'operator'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型类别（1=属性，2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备数量',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'device_count'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'job_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'cron执行表达式',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'cron_expression'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否详细corn表达式（1=是，0=否）',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'is_advance'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父物模id',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父物模名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'parent_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数组索引',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'array_index'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数组索引名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'array_index_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'场景脚本',
'SCHEMA', N'dbo',
'TABLE', N'iot_scene_script'
GO


-- ----------------------------
-- Records of iot_scene_script
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_script
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_script]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_script]
GO

CREATE TABLE [dbo].[iot_script] (
  [script_id] nvarchar(32) NOT NULL,
  [user_id] bigint NOT NULL,
  [user_name] nvarchar(30) NOT NULL,
  [scene_id] bigint NOT NULL,
  [product_id] bigint NULL,
  [product_name] nvarchar(64) NULL,
  [script_event] tinyint NOT NULL,
  [script_action] tinyint NOT NULL,
  [script_purpose] tinyint NOT NULL,
  [script_order] tinyint NOT NULL,
  [application_name] nvarchar(32) NOT NULL,
  [script_name] nvarchar(64) NOT NULL,
  [script_data] nvarchar(max) NOT NULL,
  [script_type] nchar(16) NOT NULL,
  [script_language] nvarchar(16) NOT NULL,
  [enable] tinyint NOT NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'script_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'关联场景ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'scene_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'product_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本事件(1=设备上报，2=平台下发，3=设备上线，4=设备离线)',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'script_event'
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本动作(1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储)',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'script_action'
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本用途(1=数据流，2=触发器，3=执行动作)',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'script_purpose'
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本执行顺序，值越大优先级越高',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'script_order'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用名，后端、规则和脚本要统一',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'application_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本名',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'script_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本数据',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'script_data'
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本类型：
script=普通脚本，
switch_script=选择脚本，
if_script=条件脚本，
for_script=数量循环脚本，
while_script=条件循环，
break_script=退出循环脚本',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'script_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'脚本语言（groovy | qlexpress | js | python | lua | aviator | java）',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'script_language'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否生效（0-不生效，1-生效）',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_script',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'规则引擎脚本',
'SCHEMA', N'dbo',
'TABLE', N'iot_script'
GO


-- ----------------------------
-- Records of iot_script
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_script] ([script_id], [user_id], [user_name], [scene_id], [product_id], [product_name], [script_event], [script_action], [script_purpose], [script_order], [application_name], [script_name], [script_data], [script_type], [script_language], [enable], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'D1782337038486474752', N'1', N'admin', N'0', N'41', N'★智能开关产品', N'1', N'1', N'1', N'1', N'fastbee', N'消息转发规则', N'import cn.hutool.json.JSONArray;
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
', N'script', N'groovy', N'1', N'0', N'', N'2024-04-22 17:13:59', N'', N'2024-04-23 15:32:43', NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_social_platform
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_social_platform]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_social_platform]
GO

CREATE TABLE [dbo].[iot_social_platform] (
  [social_platform_id] int NOT NULL,
  [platform] nvarchar(32) NOT NULL,
  [status] nchar(1) NOT NULL,
  [client_id] nvarchar(100) NOT NULL,
  [secret_key] nvarchar(100) NOT NULL,
  [redirect_uri] nvarchar(120) NOT NULL,
  [del_flag] nchar(1) NOT NULL,
  [create_by] nvarchar(64) NOT NULL,
  [create_time] datetime2 NOT NULL,
  [update_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [remark] nvarchar(500) NULL,
  [bind_uri] nvarchar(128) NOT NULL,
  [redirect_login_uri] nvarchar(128) NOT NULL,
  [error_msg_uri] nvarchar(128) NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方登录平台主键',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'social_platform_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方登录平台',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'platform'
GO

EXEC sp_addextendedproperty
'MS_Description', N' 0:启用 ,1:禁用',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方平台申请Id',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方平台密钥',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'secret_key'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户认证后跳转地址',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'redirect_uri'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标记位(0代表存在，1代表删除)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定注册登录uri,http://localhost/login?bindId=',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'bind_uri'
GO

EXEC sp_addextendedproperty
'MS_Description', N'跳转登录uri,http://localhost/login?loginId=',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'redirect_login_uri'
GO

EXEC sp_addextendedproperty
'MS_Description', N'错误提示uri,http://localhost/login?errorId=',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform',
'COLUMN', N'error_msg_uri'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方登录平台控制',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_platform'
GO


-- ----------------------------
-- Records of iot_social_platform
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_social_user
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_social_user]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_social_user]
GO

CREATE TABLE [dbo].[iot_social_user] (
  [social_user_id] int NOT NULL,
  [uuid] nvarchar(64) NOT NULL,
  [source] nvarchar(32) NOT NULL,
  [access_token] nvarchar(255) NULL,
  [expire_in] int NULL,
  [refresh_token] nvarchar(255) NULL,
  [open_id] nvarchar(100) NULL,
  [uid] nvarchar(64) NULL,
  [access_code] nvarchar(64) NULL,
  [union_id] nvarchar(100) NULL,
  [scope] nvarchar(64) NULL,
  [token_type] nvarchar(64) NULL,
  [id_token] nvarchar(64) NULL,
  [mac_algorithm] nvarchar(64) NULL,
  [mac_key] nvarchar(64) NULL,
  [code] nvarchar(64) NULL,
  [oauth_token] nvarchar(64) NULL,
  [oauth_token_secret] nvarchar(64) NULL,
  [create_time] datetime2 NOT NULL,
  [create_by] nvarchar(64) NOT NULL,
  [update_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [del_flag] nchar(1) NOT NULL,
  [status] nchar(1) NOT NULL,
  [sys_user_id] int NULL,
  [username] nvarchar(64) NULL,
  [nickname] nvarchar(64) NULL,
  [avatar] nvarchar(256) NULL,
  [gender] tinyint NULL,
  [source_client] nvarchar(64) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方系统用户表主键',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'social_user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方系统的唯一ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'uuid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方用户来源',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'source'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户的授权令牌',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'access_token'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方用户的授权令牌的有效期（部分平台可能没有）',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'expire_in'
GO

EXEC sp_addextendedproperty
'MS_Description', N'刷新令牌(部分平台可能没有)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'refresh_token'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方用户的 open id（部分平台可能没有）',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'open_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方用户的 ID(部分平台可能没有)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'uid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'个别平台的授权信息（部分平台可能没有）',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'access_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方用户的 union id(部分平台可能没有)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'union_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方用户授予的权限(部分平台可能没有)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'scope'
GO

EXEC sp_addextendedproperty
'MS_Description', N'个别平台的授权信息（部分平台可能没有）',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'token_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'id token（部分平台可能没有）',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'id_token'
GO

EXEC sp_addextendedproperty
'MS_Description', N'小米平台用户的附带属性（部分平台可能没有）',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'mac_algorithm'
GO

EXEC sp_addextendedproperty
'MS_Description', N'小米平台用户的附带属性(部分平台可能没有)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'mac_key'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户的授权code（部分平台可能没有）',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'Twitter平台用户的附带属性(部分平台可能没有)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'oauth_token'
GO

EXEC sp_addextendedproperty
'MS_Description', N'Twitter平台用户的附带属性(部分平台可能没有)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'oauth_token_secret'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标记位(0代表存在,2代表删除)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'绑定状态(0:未绑定,1:绑定)',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'sys_user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户名',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'username'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'nickname'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户头像',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户性别',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'gender'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方用户来源客户端（web、app、小程序）',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user',
'COLUMN', N'source_client'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方登录用户',
'SCHEMA', N'dbo',
'TABLE', N'iot_social_user'
GO


-- ----------------------------
-- Records of iot_social_user
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_social_user] ([social_user_id], [uuid], [source], [access_token], [expire_in], [refresh_token], [open_id], [uid], [access_code], [union_id], [scope], [token_type], [id_token], [mac_algorithm], [mac_key], [code], [oauth_token], [oauth_token_secret], [create_time], [create_by], [update_time], [update_by], [del_flag], [status], [sys_user_id], [username], [nickname], [avatar], [gender], [source_client]) VALUES (N'1', N'ojefY6BdTpoXOLjdpsFQXWixAG_Q', N'WECHAT_OPEN', N'71_7qVQ56lx6qdC7mmArXFwQD8Nl6BTjayw4HJdfHdPoXS0sEHDffiSYa4k8dIK7XG7puk2asZ0s0Rj_Pk8ahqdDQICL4FumjWmXHm3ql2si-M', N'7200', N'71_rh7a79t0eJmC0JyJrQjABF3zZdkNhP7oAUm3Jj6Rk1skL_i4V3ITlM3ViYO0PA_NCKn9ba85pz2vttdloreR0lWmUxK-VOm3XaMt33vZ9a0', N'ojefY6BdTpoXOLjdpsFQXWixAG_Q', NULL, NULL, N'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-08-23 11:48:04', N'System', N'2023-09-15 17:23:12', N'System', N'1', N'1', N'8', N'shadow', N'shadow', N'https://thirdwx.qlogo.cn/mmopen/vi_32/dNibaEkibxjJZSffkH5gQKtCg0pqfz39PGbPcQ8IhADianIaEYqibvD2JhrxYLMeQexBGVR6VOl9MR4gtsYiaxEqPFA/132', NULL, N'wechat_open_web'), (N'2', N'ojefY6Pny526TwBwsyfUhzBB_szg', N'WECHAT_OPEN', N'71_HlBJGUovm8cvZoEljoFkrAbRXtqt3mWNqxEOfMGsse-2Sie51YjkfJQbrSZySyIsf9sYTIwXj7EjbPO5GciN_xqEsSRCzyG6qIvUvkyNIBs', N'7200', N'71_Bc5n4-MS-25vBkt8p8BAxeuAZBawwmx4ryi-KCJxzi0OKY73HinwKYRTPZaw08kXgpD6zToRAjqIoRuyt-mNwEgfeN50hW8Unk5NuK4Bdpo', N'ojefY6Pny526TwBwsyfUhzBB_szg', NULL, NULL, N'oL1Fu589vTytNQy2okIKQnKBUmRU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-08-24 08:22:53', N'System', NULL, NULL, N'0', N'0', NULL, N'🌲', N'🌲', N'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLTLicc0w6SgPWibR5Z92j9AdW9aC4QxuFjQcJXcekbjc13fkHD7iaZc7CwEHtUq9FQalub6vOZ46LZA/132', NULL, N'wechat_open_web'), (N'3', N'ojefY6AZPO1PPy9K4tWd8xdLWUss', N'WECHAT_OPEN', N'71_x8HU8YdqqKMXts7KJ3T0hLOvmlP5YIi0pkTQ9bLA8vRusmEEUQFKyBpbG2UAFRDMEJvpp6cKGh9EGkiRdj7zSA4aHP2r-luXHSkAhP7zyvU', N'7200', N'71_AFMUcIv8tP4PGiHrOwJVN0B8bpCGyKXuG8ZCDiVGF5zaG10MTTLTmTJXNHJHmZzs3h6X9kbLY8sukNk83uj3QI3_J5SGOtihOUNMa9g7Ir0', N'ojefY6AZPO1PPy9K4tWd8xdLWUss', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-08-24 09:41:51', N'System', N'2023-08-24 10:36:16', N'System', N'0', N'0', NULL, N'oh', N'oh', N'https://thirdwx.qlogo.cn/mmopen/vi_32/RNia2ASTn210r40Tb91yfWgmiaWXGPXF7rNnic5lkes9avGbZQ0365uZObT1JicIQpiba7MDuHicScKUxnYWWyTN5VAw/132', NULL, N'wechat_open_web'), (N'4', N'ojefY6JUjFaO7RBRqgcrRGLxPVFA', N'WECHAT_OPEN', N'71_qkQqwgA9RYmL5oQASwBxwwR4loysQQc3YRqGJRJONSxpNrPLlLdNibDk5YINFYjfnCxwnhjVPQqhX7xHaGE_UZMX5e1JaWKCJdrgwP62LxY', N'7200', N'71_oEKp3JLiEtv5668rprSxidUBbcd30cZQ2Bbt_tL5XdWQX52Yb3po5t5ynFwlA4n-7dLt5rGR3E1FKb9Qw8Xso8SfSfF-4CBF9ZCjSxppIvI', N'ojefY6JUjFaO7RBRqgcrRGLxPVFA', NULL, NULL, N'oL1Fu55Rkr9A69wS6buTQz7zdkDc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-08-24 09:58:59', N'System', NULL, NULL, N'0', N'0', NULL, N'shadow 张', N'shadow 张', N'https://thirdwx.qlogo.cn/mmopen/vi_32/EcUsiaR4Y1WkyibJXHDEPAiazbERr1BXAnzZWjh2SiayuawoEaT0icDzL2dZtuu0ia6Z7AJZZbiaxDJb8iaJxTnyk7Xicgw/132', NULL, N'wechat_open_web'), (N'5', N'ojefY6I66aL78LElFNjsA_rY7JIE', N'WECHAT_OPEN', N'71_sanZ8NfbnEANzqUTQQAY6CRoafcBaV1eS4KPtcAv_rkOlunJQyVeJJzFbXSge3QxsCvljt65TTpyiLSifSjADJdaSZGtKzhF7IXlo5km2Po', N'7200', N'71_JbHfJV6zy02mK8ZnCKA3Yyhe2upHOqeah6IeZxzO3CKVAcOqH7CGbsk9GFsK3bqDD1SF8jp05ncC8XfkzR5BS4A3s_QIQjt44bviFckymtE', N'ojefY6I66aL78LElFNjsA_rY7JIE', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-08-24 11:49:31', N'System', N'2023-08-24 14:10:29', N'System', N'0', N'0', NULL, N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/tgaqAZ2oTMAZfF4cHRPib77yOLRSv9ibPibQfkQiclB8kwBuicB3vDcLfTnfU6HWZRNRqjmSXjWYYY5fNdOAR8CSxzg/132', NULL, N'wechat_open_web'), (N'6', N'71420ce6-5300-4495-92da-6d1a4a7e2fdd', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 09:32:12', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'7', N'6ec4d0be-bde5-466b-b3cf-5b3736d15ba7', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 09:40:17', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'8', N'ac2d836d-29fe-4e01-9f3d-bc54d4168855', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 09:45:52', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'9', N'ef2510ab-8fdd-4433-b0ff-1b57ef2f0fa9', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, N'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 09:47:34', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'10', N'b7c2ee2f-d644-46b9-812d-104b1d122fe0', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 09:50:43', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'11', N'214e90ab-5b09-4aec-a6d1-4100c21db1b6', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 09:51:42', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'12', N'a23aec75-40df-4878-b33f-a1aacc6b45f6', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 09:53:12', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'13', N'37de2b33-e690-40f6-a981-fc7182503606', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:00:02', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'14', N'8c1e964e-9bb8-4876-bc92-6a41faaf2097', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:09:12', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'15', N'a7b77ebb-0815-4983-b0ad-b9b2a37593ca', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:09:59', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'16', N'0ee69f21-448a-420f-a092-68418ae96c01', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:10:34', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'17', N'0c928db4-03b5-40c9-9971-3b13d39ba4b8', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:11:41', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'18', N'8f0daa3d-f332-423b-ad37-95e740a109e8', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:12:44', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'19', N'd15e0ae9-f49d-4e55-9965-79e260e8ffd0', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:13:33', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'20', N'b4da93b9-21c7-4e76-937b-2162024a9c6c', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:14:37', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'21', N'a16423aa-99ce-427e-89cf-a9f13955acec', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:15:54', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'22', N'7771c72d-741f-4f66-bec4-414471ebb5db', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:16:34', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'23', N'9def0641-b670-45cc-8297-6c3171f12025', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:17:36', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'24', N'e8f70c8b-bc52-4b38-aaf7-6a8df9ffb8cd', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:18:23', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'25', N'a359a333-4348-4786-973e-f15b9fa6ce94', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:19:15', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'26', N'061154f9-ac4b-4035-a549-cd602422427a', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, N'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:19:55', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'27', N'10003d18-0b00-458d-966e-3a54b218c83b', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:21:18', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'28', N'376f2a15-662d-4820-bb62-683dd555fdbf', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:24:01', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'29', N'd4e4fe18-1f99-4361-b509-e464fdc806a2', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:24:42', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'30', N'7b37261c-b420-45d5-8cd0-7ab6e4787621', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:25:17', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'31', N'7635bed2-0d6e-4924-b9d7-af0235fc2ecc', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:25:26', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'32', N'6aa3715d-b3a6-4b12-8bb4-1fc3af297d99', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:26:09', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'33', N'0222ba55-f5a8-4218-a23d-949ecc78c405', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:26:52', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'34', N'0bb2118c-b365-4dae-943e-84e0f8dca104', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:27:50', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'35', N'5c065548-d171-44b8-a5bb-b93db08b22b3', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:28:12', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'36', N'79429286-c4c7-4db8-9902-6f10ffd26e06', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:28:53', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'37', N'4eb61991-8715-427b-b6a1-6e479f3faafc', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:29:44', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'38', N'cbcf9cfb-109f-4806-9bd0-5e9a4ba0c108', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:30:33', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'39', N'810f0806-21e0-487b-b2fe-c9d037b20c81', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:31:28', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'40', N'7da601d4-765c-40bf-aa2d-96bdef88c9ff', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:32:23', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'41', N'e3e29354-d06b-4d18-b172-a86e563a20f1', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:33:16', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'42', N'c73ece08-7a9e-462f-ad04-e5a5ce05a8b5', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:33:47', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'43', N'7b48faf5-b023-46d7-9332-8ead5d82895e', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:34:27', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'44', N'aa8db705-654d-43d9-8ec2-3b090bb9685d', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:35:18', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'45', N'b3f319a4-a4aa-48bd-9a43-ff03b09e9b0f', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:36:18', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'46', N'297e229a-545e-47a1-8acd-85708430d78d', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:37:10', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'47', N'74d77e94-a9c2-4fca-9b47-e1c7ea0ab419', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:37:45', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'48', N'0a750c6d-2e14-4e12-bd11-5ae390b04451', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:57:10', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'49', N'6b353153-2eb0-4916-ad83-f5465ccd4480', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 10:57:55', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'50', N'10be370a-38e0-4de4-822b-e6b1a07f0ff2', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 11:47:28', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'51', N'8634fc78-e8d0-447f-af90-51fd29536ae4', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 15:40:06', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'52', N'4e49726d-9078-47de-8752-5fac79a5b9b1', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 15:45:31', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'53', N'77e28b94-5f6e-4dda-bc15-a411ce9423e8', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 15:49:07', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'54', N'17b87cd8-6a14-4834-9d9e-e4121d563079', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 15:53:20', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'55', N'b2b7ddc7-6e48-4f24-9d03-8c481b6fc165', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 15:57:00', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'56', N'c394c827-3f3f-42c3-88db-b5e3edc5a3e8', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 15:58:51', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'57', N'16bf6849-9619-4448-9b0f-1ad4a999e33f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 15:59:47', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'58', N'8f19e5f6-e197-4b81-9585-ea3ea655dd2a', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:01:56', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'59', N'647ce6e6-5aa4-4504-80db-fb1df687c0b6', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:03:22', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'60', N'04f69ab8-5a84-495c-8dfa-7f19a1a32c63', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:05:03', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'61', N'520bf6de-19a5-4b06-b905-6c61a37a1809', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:06:05', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'62', N'e70c584c-5d6f-4cdd-9d63-42606b21941f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:07:37', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'63', N'd85b3a8e-4917-470c-8412-9c7ccbdd26e6', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:08:13', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'64', N'21e06b88-33cd-4ddc-9d3e-22a0cc79d8ab', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:09:43', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'65', N'70903b36-f5da-4784-8505-9e0ee7842a7c', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:10:31', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'66', N'4300b8fb-4d5a-4c83-b45f-f46de9070789', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:11:57', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'67', N'a83706e9-c606-4393-b46c-bd589102fa23', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:14:25', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'68', N'03b705d7-cb9b-4176-ba52-82caee369ee5', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:16:11', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'69', N'9c1aa75d-0afe-4d9b-93a4-82ff51476b83', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:18:05', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'70', N'd5153a89-5dca-4ce1-b225-cdf1f06734b3', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:20:23', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'71', N'6f0dc304-3697-4d5e-b6f5-dcae95c6037d', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:23:43', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'72', N'1a8d1436-b1fc-4648-8ef3-8986b200f609', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:25:12', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'73', N'87c74066-e8db-4312-ba9c-8d4a58d65b88', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:26:02', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'74', N'7c36eace-b7c5-405f-a2a1-b1fa95d7b526', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:26:36', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'75', N'9147f792-55be-4ca6-824d-b8c4a42960b3', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:27:48', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'76', N'2183b103-858d-4bb4-9111-83fc8ddf24c1', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:34:12', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'77', N'9594b67d-6651-4237-887d-ebadfabc8ca3', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:35:55', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'78', N'60649e01-d220-4bbc-a21c-211ce67bd9a7', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:36:29', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'79', N'83aa1836-36c5-4e74-aebb-9263843ce8fa', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:36:41', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'80', N'd7dfb927-1f17-41f7-868b-6ee0b8ec2d2f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:40:14', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'81', N'9898d830-f0f3-4dbd-a687-a49709b855de', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:42:14', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'82', N'e7a5b6b0-3e50-4892-b4cc-e628fb803be6', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:43:31', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'83', N'34454957-3dfd-4819-8930-46daf47d2f81', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:45:03', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'84', N'384b5ce9-5bf7-43b0-950d-496737c3a8dd', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:45:37', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'85', N'dd6de292-124f-44e6-a0fd-057cfeed410c', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:46:25', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'86', N'a370f0b0-fb7f-41cf-a4ed-eafb873cd50b', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:48:31', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'87', N'bfb06fff-b0bb-43a4-8cf0-bf4f4b3445f6', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:50:00', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'88', N'53634812-48d2-420a-9e3c-2ac032b5d9cc', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:50:52', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'89', N'994f638f-cf08-4846-9630-94bb509ab7db', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:51:27', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'90', N'76813df6-4bdd-4add-981e-8e782a3b772a', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:52:16', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'91', N'df0c3f75-a865-4621-988d-ec494e9ea407', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:53:22', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'92', N'07f1722d-d9d4-43f7-8f7e-81c6446d7b3f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:57:11', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'93', N'1d91f1b5-a008-446a-ad12-3210e899c55d', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:57:50', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'94', N'9b0f8585-4432-401a-9ae1-f363a158a133', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:58:27', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'95', N'33b73d87-df3c-41b4-8abc-d2c51bf4657e', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 16:59:41', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'96', N'08daa4b5-b5e0-4217-8249-d47928afcf82', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:02:57', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'97', N'a1d11647-2316-4636-85ce-a589084c383a', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:03:27', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'98', N'c8579e89-0858-4ba7-9e00-f1ea2a208be8', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:06:37', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'99', N'd3837059-b25b-4221-9fd0-aed6f958b8a0', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:07:15', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'100', N'a47efa4b-e840-4e07-a710-459fa9f01e5e', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:08:43', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program')
GO

INSERT INTO [dbo].[iot_social_user] ([social_user_id], [uuid], [source], [access_token], [expire_in], [refresh_token], [open_id], [uid], [access_code], [union_id], [scope], [token_type], [id_token], [mac_algorithm], [mac_key], [code], [oauth_token], [oauth_token_secret], [create_time], [create_by], [update_time], [update_by], [del_flag], [status], [sys_user_id], [username], [nickname], [avatar], [gender], [source_client]) VALUES (N'101', N'dca0f5d4-df0f-4d95-830e-2ae8aa60a550', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:15:11', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'102', N'be678468-abc2-48db-b34d-47e81352bf5c', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:16:49', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'103', N'ae4265e7-e192-46f5-8a9e-53d6ba6aee3e', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:20:34', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'104', N'232a0407-b8f0-40b2-bf70-b368aecc3f48', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:22:02', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'105', N'09aa4d6e-471a-4890-98f1-85ec1f41d16d', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:23:05', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'106', N'6dc0c49c-29a6-4292-bb59-d19d3c7dc11f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:23:49', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'107', N'aafb9719-a7e3-4c25-be9f-150fbc4e345d', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:25:22', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'108', N'ce799416-f0a8-4941-9f84-ff3bf5a5ae00', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:26:16', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'109', N'38ad0b87-c569-4831-84ea-f45bfb1b06e6', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:28:00', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'110', N'a0ee9a9f-6f2f-49a2-80e1-f0976cb115d5', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:28:16', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'111', N'42b6c87d-a031-4f7e-8670-09672fd00239', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:29:40', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'112', N'39812b97-1a6d-4255-ba0f-86e8e6150bf7', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:29:55', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'113', N'38df607a-72e4-45c5-9b9a-fda85114e7a8', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:30:43', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'114', N'3d1dbb97-c0d4-4790-9bd1-57d2a26c945e', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:34:02', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'115', N'f9544196-41ca-4f54-926e-2f43bd5482ef', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:34:31', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'116', N'b954f7a1-e544-4ac1-a103-54cfbc9ce982', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:35:13', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'117', N'53484323-65ce-4720-91e6-51f81741df2d', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:36:26', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'118', N'cae0d43e-f1d9-427a-9e2e-a276848a9e6a', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:37:04', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'119', N'3d1dd8c7-2d3d-46c7-aec0-8aeae75bd53c', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:38:24', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'120', N'd206b8cc-4663-4253-919c-eecbf4bdae2d', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:39:14', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'121', N'30f22b8a-39f3-4088-a917-e7b0bb315d96', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:40:18', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'122', N'b58fa0aa-f173-4a25-b245-3eedae47c4bf', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:40:43', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'123', N'6de207b2-2f61-465f-8e2d-7115220cfb0a', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:41:10', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'124', N'a2734f2b-41c2-4b5c-a9e7-0301482c2db1', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:42:30', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'125', N'0142a300-7a9a-4a09-990e-f9d53363168c', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:43:54', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'126', N'a1207e54-0e14-424a-a485-9a560bce8058', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:49:37', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'127', N'cd2425fc-dab4-4f73-bc61-1b9f43920801', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:51:55', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'128', N'ee27889d-4dbb-4ed0-8184-81d0c56cee06', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:53:38', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'129', N'd85434f8-c11b-438c-890e-8e5732f91a22', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:55:11', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'130', N'0cff5da9-3cd4-4363-80be-c3cccb523a95', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:57:34', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'131', N'58cf157e-c55c-4cf4-90ee-6f9546ea60de', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:58:23', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'132', N'3ad40393-bdc1-4cc5-90cb-c40c45737c07', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 17:59:36', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'133', N'268d0dec-0c8c-4017-adf0-c87c7a5705f5', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:03:33', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'134', N'a925f086-1f57-4ffc-bb0b-656e27cac343', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:05:28', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'135', N'0d344981-1748-4b0c-bd5e-38db0d9d4903', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:07:31', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'136', N'545b520c-d306-4ae9-affa-ead01383de6b', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:07:44', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'137', N'2cf65789-0d5a-4a04-a86b-71b4c4632fab', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:08:02', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'138', N'69b4eb4c-89e3-4ff1-ba0a-ec181cfa269e', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:11:22', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'139', N'eae37130-5acb-4a7c-a466-867202b5de22', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:12:07', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'140', N'74471c0e-fb55-4545-b23a-944f56a01d9e', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:13:54', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'141', N'3dc79a1b-6974-4338-a05e-732a08c06d9f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:15:26', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'142', N'1bb4277e-05dc-455a-86f1-a4d7a570a7c9', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:21:19', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'143', N'f6c85ba2-6d99-4509-9fce-e32762a3d9fc', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:25:01', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'144', N'99f90484-cd36-4caf-b874-64cdec51c973', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:26:24', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'145', N'254a881a-36c0-46a8-89c1-47ec0902cc1c', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:28:43', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'146', N'40814010-a24d-448f-9841-ea26f75e3d4f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:29:17', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'147', N'b9d31023-b415-4a05-88be-e8f6077ba1c1', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-12 18:30:22', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'148', N'8d98204f-cc93-4ae7-961a-ffc88f16ad22', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:02:29', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'149', N'cfa57e94-fa7b-4cd7-8b0e-f84c2a32517a', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:03:05', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'150', N'b0742424-3b90-4c92-91b6-da7d0c1042e4', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:04:31', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'151', N'92fb0d86-db06-4bd2-88a6-2c5e5659c2dd', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:10:44', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'152', N'157c9ab2-260f-4fc9-953c-244e66a416dc', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:14:04', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'153', N'58250a3d-9d20-4c06-a161-b89a5cbe2205', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:17:25', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'154', N'503ec9f6-9c51-494c-abe6-d2025b6d5de8', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:23:32', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'155', N'7da9ee7e-00f1-400c-9e82-aa756d33c2f7', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:25:14', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'156', N'576eb582-a62f-4de4-a7c6-5a79d06a317e', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:26:11', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'157', N'35fe81bd-a801-411e-a588-83e2073b53d1', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:36:01', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'158', N'13cc3148-7818-4aae-b404-5aa5b21bcb43', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:37:12', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'159', N'c667755d-08bf-4575-8763-ece99a8d34ff', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:38:20', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'160', N'e9cb8b8f-0f5a-47f0-ac70-04b75341a2cd', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:40:18', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'161', N'128cb9e9-52a8-4ecc-8b4f-14d0377a9bdb', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:41:53', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'162', N'e71e95b5-4d16-45d4-ad99-c719c971ee4f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:46:18', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'163', N'c22e9388-e8e1-4965-8689-67d614efa611', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:47:29', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'164', N'f3232bc6-a8d0-48c0-a08f-0f7ad79dfaa1', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:48:36', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'165', N'0bd9b8c6-bfe6-41f3-80ad-2bad1f56348b', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:51:38', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'166', N'4c04dbef-6f2d-48a7-a549-55089038e197', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:53:04', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'167', N'2c3b82a0-1cdb-4ccf-80ec-41d49f5c1bcf', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:54:21', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'168', N'20d05c1d-c3c2-4f89-8093-44b548165d42', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:55:38', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'169', N'6364f00a-44f9-41c6-a462-1edf968fe4e5', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 09:59:29', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'170', N'6598c9c5-9e50-432c-aaa2-636e0e8d44f9', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:07:53', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'171', N'3909b811-7a5a-46c1-b390-6d21d8857670', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:10:11', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'172', N'd3da6d29-b931-4f25-ba5b-bd091af19ff5', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:21:05', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'173', N'11040fcd-6f8b-470b-aedc-1411b36165c7', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:23:34', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'174', N'c3ac6479-d9c2-4205-a257-abefe814a842', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:26:47', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'175', N'f0cf37ba-eeeb-44ea-a870-8bc74c079d5c', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:39:49', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'176', N'babe0cad-db0c-4f07-b478-89f8d89bc197', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:42:21', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'177', N'df2b5aae-e7da-4793-8f42-d7025855208e', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:46:08', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'178', N'4b6bd295-aa7c-4549-b82f-fd0d8be4a439', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:49:22', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'179', N'2e3ffaa3-d499-46a7-aa1b-b2ae27ef4d32', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:50:20', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'180', N'8670c605-1b89-4448-9de3-e4d15a1b0bad', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:52:38', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'181', N'fc90c9b0-c5d1-41b2-be40-1ea9ee2e52f2', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:53:25', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'182', N'4cb82fc7-e322-439d-bd49-59e22b4ba8de', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:55:25', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'183', N'9d4f9fd7-0564-4128-be27-25030761f141', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 10:58:06', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'184', N'bfe86e54-30e8-4c0c-ae49-497863b73708', N'WECHAT_OPEN_MOBILE', NULL, NULL, NULL, N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 11:00:58', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mobile'), (N'185', N'89953f9b-30af-446c-9682-27358d8f4d76', N'WECHAT_OPEN_MOBILE', N'72_1zj9L8T0iKDEqORM5reOYHBG3nL_5jbvb3TfFjGQqw5jv9-0YmI02SgOto6PZXZ7Y1R0o8nm5EeJc8bR8547MfZMBbICbasV2YDtW0XbfSQ', N'7200', N'72_0Ae6bzB8bTMtnrrfuHkNDN37ko1GEOTLsbqbE3tbQAXNHNd6n_7-HIie0v_zC_clqDr4mOmJBOtkvjCzVHDWW7OS0pAdoDUovfy2n-Y7WD8', N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 11:01:17', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/NEJsVswPcQnxDy3UBXcVGIpMwvn2FmJ6I1k5DoNZk0UcZwQEm7lCewbdneEEfCeVkVNXOIQOXw8evKBea5MBdA/132', N'0', N'wechat_open_mobile'), (N'186', N'09277a77-53a8-4cf9-8396-0442d33166ab', N'WECHAT_OPEN_MOBILE', N'72_StpVhV87sy7cSsbkVoOJyxCdtlD3JxcdxG5vO8vgZ1eR7C2mORJdxYynL9SJR__pD_rdt2IHbfcSIH2Fpw5wh-BVMu3TTKeESp6qD4Nl1go', N'7200', N'72_LbZu1ZoNlOHPoqHVRROZ_eGiaMHwqRE4dy3xa6QxpbvnlV5mfAiyyiI0wfUYcnCyruuudNtMlW50NBZNcAxBPeBu3TYILuhlA3rYzCgaNqo', N'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, N'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 11:03:08', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'oh', N'oh', N'https://thirdwx.qlogo.cn/mmopen/vi_32/5M4DYfvJP2dlsqQVmiclkxeGZrnnMf7hj6ryUR35INtKBicn7Whq0oPCdcJfotYxslSPGH2d8s2exvIicu8FYDXicg/132', N'0', N'wechat_open_mobile'), (N'187', N'79aca6b3-0552-4f19-8720-10efa034834f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-13 14:34:42', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'188', N'e4f08938-b416-4713-8c37-a157d006991f', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-14 12:03:46', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'189', N'2392005b-1079-4e6b-9625-a295f5e482ec', N'WECHAT_OPEN_MOBILE', N'72_Yg_G7_l9nv0ikzJ6Oe7h1q9bz5oU_cJ3TYUMhKxO2ZKudg1bYfhAYygNt95C_qRy_zqiAZVO8jYvxj89iQaRvl5dgKLJl4gAh2GZus6xYfw', N'7200', N'72_NWbKK4ucUpHoMmLTKSGxTKfMOau99ebYJoWHJkWtVndGLVB6SmwVSwOlavfbh1KHDKqh4RNw28FWl4SauyBCoicugrLnH528z3RyIqrYF9M', N'oRrdQt4tGXZURgaPWika1a7yRzOU', NULL, NULL, N'oU5YytwWSaDv2FD83GB_Ax1pbpzk', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-14 15:14:17', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/NEJsVswPcQnxDy3UBXcVGIpMwvn2FmJ6I1k5DoNZk0UcZwQEm7lCewbdneEEfCeVkVNXOIQOXw8evKBea5MBdA/132', N'0', N'wechat_open_mobile'), (N'190', N'13fec398-b9a0-4a3f-b878-bc892a0104b0', N'WECHAT_OPEN_MINI_PROGRAM', NULL, NULL, NULL, N'o02g45SvGqn2RyGeLcv0-OA3SxuU', NULL, NULL, N'oL1Fu5zL-AW5yb0w8naA7tB61vMo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-14 15:15:04', N'System', N'2023-09-22 09:07:14', NULL, N'1', N'1', N'6', NULL, NULL, NULL, NULL, N'wechat_open_mini_program'), (N'191', N'338c3d89-a231-4b57-b5f0-cfe3d1f13850', N'WECHAT_OPEN_MOBILE', N'72_4DWd6gR3GQIiXPpuagGrM5eILwEO4SfHWJIDwLMqp8I_2FJpBwdNL-Or9UhQ7T8BNKoV0GZ2lh9FaCHk_7LyABY3lmABBpee6Ok4W_KBX08', N'7200', N'72_iH1rgWvH35a-0O2aXSFSB9qWyXPF_JcChEpn-WFVeFzI1Scfw_1ZxhD8_tEZY5Wk5OMNCqh9WyOKBtO11pL0bUQIWyzYgoPiJHCA2NCrukw', N'oRrdQt10T_V0r-s6plNgUfVWrzns', NULL, NULL, N'oU5Yyt_J3cry6qhOzJE1qW-tdiVA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-14 15:34:45', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'oh', N'oh', N'https://thirdwx.qlogo.cn/mmopen/vi_32/5M4DYfvJP2dlsqQVmiclkxeGZrnnMf7hj6ryUR35INtKBicn7Whq0oPCdcJfotYxsla7j7Dvh5eWLLNxttY6gyYA/132', N'0', N'wechat_open_mobile'), (N'192', N'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', N'WECHAT_OPEN', N'72_1RLeJ9QnQYJkiMs87FTBBMoK5h9ISBM3XZtPLveA6IetBtyejnDk5c7f-p0mC1RTHLxMkjC-e9KfX8l2y-0XqCPKav_0R20C-Tzbw95wlt0', N'7200', N'72_lcw1_ihZeBiAUFq4YPt3gc10tRBDMMhLKEsV-f7fZrZkd8xK5-tKbRXaCZL-Cbf4QkPbxnCPWb4svWODgBKMjUXc7g4W4qEkqgNg-4zllss', N'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, N'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-14 17:16:47', N'System', N'2023-09-15 17:23:12', NULL, N'1', N'1', N'8', N'shadow', N'shadow', N'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, N'wechat_open_web'), (N'193', N'bd40330e-9ff0-4c2b-ba00-ff2c3a9cf9e3', N'wechat_open_web', N'72_pg1i2Xl9vrW288PCqZybI56qq3-2Yin1o8nvKFAPCRx9OaS8HxJNHUVb6xuG5j_fQdwMecInJYxUpvTTUlJ659DsFOVYrr4RBCTI0sAEqBU', NULL, N'72_v0sNSaJQyj8XUCk1bRPIl0A7TB8n4pN0mC807o7YGbPVXugt7aId7RAyb2hi9gsvd0aX2R4vAW-BnDtCTHPm_Un_AkW-mM8SYc44JuxMhOg', N'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, N'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-14 17:30:40', N'System', N'2023-09-15 17:23:12', N'System', N'1', N'1', N'8', N'shadow', N'shadow', N'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, N'wechat_open_web'), (N'194', N'a8681dc9-f2cc-4316-a6a4-d8d43aa00e19', N'wechat_open_web', N'72_44jRuqhWDZYQwgFJMFzJkNRKd3_w0m9npMlL7gv16EoEW2UZy6CbNfy_oSuhqMz28PnUHOJwAyC-Xv--LvNxSePhPu-K-FOajq-1BE10G2o', NULL, N'72_wF_NsYq04JgoGpNVvq6EvbZjD7BDDz7XHpGfGA4bT61A_wf3ITbXSFhc57MJUwi_o-HhCfBJ9FnSEBu2nySYkDVTbQ457WZ-ZXDTkwo7OMc', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-14 18:13:09', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'195', N'128d79bf-7573-40c6-bbca-ff5fcf2a0a71', N'wechat_open_web', N'72_h2CaZanyW6eeDFw4jybBzdqYKIWBovGeEeB29G6WZEPDtZPiXANNrFRLEMmtd_HGLwv8YwqwBinOVTIxtrjwFcue_x_z9YJlgM5pfJFNHJA', NULL, N'72_hK0QOqLAqq-5-0sbwA4_Kqs-nweY_HC0LTaprTL8n_nbZD8wwhPkil5b2-0Sk855gQ47NGTwczEAt-pCt8ZyZwkTEX0gtO6kcRp8Ajz2kew', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-14 18:13:47', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'196', N'698dbf21-8b29-47fa-9946-19a82d067645', N'wechat_open_web', N'72_smafRNdslVfgLL-x0nBV5JZO3jT_r3LJBwYw2HJQYpcGe7KKBSSYtIrqpsvVFY75Z7knhMefGlOf9r6s1sH9sjdmAq5EQAOCx2B5QexT3_U', NULL, N'72_ongWXQyEHIhXich6claT-7BzZZJbTAb-0dlr245Ee8GO4I9MFplLxa9P5o8qGmgxWhh3h1HvpyYzCyIJ2xxMaS79GhdOhmv6ZJ0dyJN5tsI', N'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, N'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-14 18:49:36', N'System', N'2023-09-15 17:23:12', N'System', N'1', N'1', N'8', N'shadow', N'shadow', N'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, N'wechat_open_web'), (N'197', N'f0fd123d-b82a-4eb9-a67a-fb81db6b739d', N'wechat_open_web', N'72_eexrzOvM96xPvH3Lsl7viBOtnBHFDzFJdIz1d074PJxOhAB9qY0HE-NxnWm67afHT0zphQ4RyVEM1BOohhE32HN_D5yZVcMh24oMrSCPJYg', NULL, N'72_W25_phPvOFAfeASpx050O28_pOfgtW0LsnuWYQZI6LIrMeVJnju7FrLTG5xuYG_awhD7crWRzpd-guJs2gZ3ZBVj7bSRtwIgSvgVRfzG0zs', N'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, N'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-15 11:49:37', N'System', N'2023-09-15 17:23:12', N'System', N'1', N'1', N'8', N'shadow', N'shadow', N'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, N'wechat_open_web'), (N'198', N'702797d1-04ef-4374-a618-aa2c3370135c', N'wechat_open_web', N'72_BqSILWRpNzD35f9vkga9dMSHQp3bftJMa7eBpOXIepLh7zJVdBMUiPghVRz96hvtuCvvY7CryJtM5yuKx0tU4IJer4ZshmLHSw1Fl7jYtlo', NULL, N'72_jJ0WZ-4r18IkeIs0YC6FfCS0QtCk9S5N1cqYeCIsKijORm2I1diDUE4zVLzYL5dUfxoVeUdHpYY8EyFBKQiWOzaGSECPPLw2bzQnigQzr-g', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-15 14:27:11', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'199', N'ebe3c9b0-6d17-4e7a-9d4b-a4d127e5f81e', N'wechat_open_web', N'72_eahdqYL3gU93PJ1IWa6sIKwL4-XvLvCcMnkLYYI3au_8OQ2ZEwe5YHjnRKVzmXDkEfW_IUwCpSyGBLYaOS_ms4RfSI-TAH_s7lUnh_pwOpQ', NULL, N'72_8RcuvSh7R88zZSjHyMfuROguXNJxl28CinaM0DMVnQdlvrLORUkT-ArLdWEY_ukrctsOppiY85xYUtZ8mRKit66-IMJauWckLptvbS6mVtk', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-15 16:14:33', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'200', N'a9865b55-498e-47e5-ab12-bfc028f9401a', N'wechat_open_web', N'72_sDs8oTAz4diS5nsjQyO-y2aO2IXDYL0CkVFkHaA5gJDb1YCUqfmG9ejNR0-lsshtYwOOswE5s5hdIMkBXsUt_zuVK5nyTlJ3oi3sVrUEaP4', NULL, N'72_Z9mP_wckNOwwmrA0eGB8lUB5CY23FvlLciZBegzfnyg10VW0GOe56QF0uM4rgtTha-kO7Uhasm2FIFdDdGKhriu8t1OYs2PEyYT-GOYauvA', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-15 16:16:30', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web')
GO

INSERT INTO [dbo].[iot_social_user] ([social_user_id], [uuid], [source], [access_token], [expire_in], [refresh_token], [open_id], [uid], [access_code], [union_id], [scope], [token_type], [id_token], [mac_algorithm], [mac_key], [code], [oauth_token], [oauth_token_secret], [create_time], [create_by], [update_time], [update_by], [del_flag], [status], [sys_user_id], [username], [nickname], [avatar], [gender], [source_client]) VALUES (N'201', N'45ef2f02-0498-4a91-9b7e-7ec1fbba1f4f', N'wechat_open_web', N'72_pj5qq79ny99dg-nnZztIDdBw6pxQUTOI7GC1-50zdFugMU3JhIUgoWKG_zISSOT63HSkuogl0GTSM7zV-7XaGRZoVvT3ks9e4No7qh4lmcM', NULL, N'72_jJaohqyJXjiOai2Y1X2JGxinYVUpGYQhNrNRqRBEGDzY44zuPuNxJSIAvlXbJoZXwi57WfV2FxbLCfeUPCnBzypTR6MyAgnY7UBPzfnkO8E', N'oyyyv6RrMpgR22_BHD-Ne7TWsVMo', NULL, NULL, N'oL1Fu5x1fapbFrUGWUStT0Vs6f4I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-15 17:22:53', N'System', N'2023-09-15 17:23:12', N'System', N'1', N'1', N'8', N'shadow', N'shadow', N'https://thirdwx.qlogo.cn/mmopen/vi_32/74LllXzhnGtAwmn3AEwrRDYFegYX00yJphUlyk6iaQNYNWnLwSMuZ0JXnXicav8n01D0cgL9ptRrG4GX2NttSNcg/132', NULL, N'wechat_open_web'), (N'202', N'719938db-a623-427c-b0bb-f93ccc66e12e', N'wechat_open_web', N'72_47aVnqUFSV_6B866IIt56eXQ4MCeaON9p6uNXDNd8tM9C1aDLc42MpMvPCh4gUJBr1CPk6W2BjaJdbp53mhvgJQ9mbVTHi3Rgt7S5lYa1uc', NULL, N'72_ES4G1cNwL7SR5zxg7wSUtyh1JAMD3iHksu9PhfriYVa7BviNMKTBXq0XA92tRNDGTLbYyjpzXBsihDooqcYziiJjJNJZ8HV573kvdk5Js6g', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-15 18:01:00', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'203', N'6c128697-f856-4cec-9b22-9c041e546aa9', N'wechat_open_web', N'72_ouu4bb-uHrl6KXeQP_H_nI2cn0GBsiCAq4sJcwK0vEhi4DqPbvInOEpYwX1ljPsrxJ2a6iXf48A8SRDDT0G-jKPhs5qsI7MTUvylc3tIvIA', NULL, N'72_8yFIgg2C-J3jomyS19ZQmPsNu_bwxoVe_pOjDQInuid5WH2SLBL5ul8NIXF4kFbBT5S1xDvQ9Wo0yGLgLg4kAwvGRRk2atyA9u85HLXRrCU', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-21 16:40:55', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'204', N'd78d0dfd-ea6a-419c-a95d-916f75ef8645', N'wechat_open_web', N'72_In2RD2EUmBPN_cKpj_e_6WhSI0BFkOqOSGMAxPg8frEv3EExLiPv7H7p1VJFBoTXDRMUzxX4uBXJUanI3B38y2IO0T_T21WZWToph0Hqrfk', NULL, N'72_ICxLSkfZYijpSu7nJwnOGVjwG0bLkwAlsKxMNYUAJF0O-hkVP44qlnSJjrEXvQ7tpId_-8uygb3EjfSYMBh1h5D-YtjYFTYgj-tQOcponpQ', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-21 16:48:25', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'205', N'3057f429-575b-4116-b6c2-2be2ed0daa6a', N'wechat_open_web', N'72_8RcuvSh7R88zZSjHyMfuRAU8ESiAbG5qYjyInId2yhXEwIsJ--rVPWI-ZuUTkJzBym4oNf7hFJtvwZWqv1S0H-poe26G0sU_ge92uPjC3J8', NULL, N'72_j_d-U4TM9Uc6ZXfG_ckplSQX_umZya-Z-HssZe57QjB0rYvI0LP2nzWusHpAVu352zq7LXTNGd2X239O3wHqlPSJ9dstTukRWWYy3h0nnVQ', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-21 16:50:17', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'206', N'c0013cb3-7862-4477-b178-a1cf885ad278', N'wechat_open_web', N'72_VO1uAiIQgD1l49wDcy5oqfq7Qp-e6qX8FDtdvgbGuib3T2JAZZrBC6wKunFue-O5fai49_Y2-Y_0NUldDAgGjFVGJ53FwA9sQH6W9yovX3Y', NULL, N'72_ldWlbgKsd3GropvbdrgjzZMFOgKS8i8Cre678hFHSWlrGaQVjPR9WgRZftTWcQHA0vgDQM-wKERD7_LGC1qzKnxEeUPOH1cO_VztQ3ZCvM0', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-21 16:53:02', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'207', N'243912df-6515-4821-a2d2-311869eb4b66', N'wechat_open_web', N'72_nrEdUC4X_xkmBsNbtePmd4tyBTDyhAzb35Xp0ul9pUfRsMfG8GIVQrIvM-GIJXyvJ1n5BscRwmOKeZxxqfzKiQdq-WjWy0PVmKEJ7YV2p_8', NULL, N'72_H4I7KKoI2DSFE3dSVXAzyGxz0OqTXT6d8kMvraXgA4nslgsCM6iLB_7d-aHGOhKjKOQbUAJb8-mOerc9YhfM1oPRb_nW4y1lvswt-QwXrRs', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-21 17:22:13', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'208', N'b14bbe72-eddb-4282-a42b-77281f61f27c', N'wechat_open_web', N'72_eahdqYL3gU93PJ1IWa6sIHdTySn-4UB_nLAkQLGDSjY7CTMUE4EOSyKYEFSoZmq9Fs64RdAHCV3PJG4ifk_VlZaFkGopHrytcIScSIfyU6w', NULL, N'72_8RcuvSh7R88zZSjHyMfuRKViN1EJKbd_ZCElj0V8epojZFlgv6LJZd_fBKE2hE3q9iUqj-0vPqndpMCdc-FfPUjbvDh4B5w1UtNv78wz1Ak', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-21 17:39:53', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'209', N'56f25762-2dcc-4be2-a50e-934eac40e328', N'wechat_open_web', N'72_GqYw5ylQK7W9nn_cd8keVairltJ1Fcyp9SsIORxMtkihL1iQecSo5Boclagxl-RXHnmdc7mo82DLkFkSqSTDn0JunfPAtAIyAZl5geONq88', NULL, N'72_2PoE8DZBF2qybpGHXPHagdYdPtt3Un3YjomGW7pGF65KKYF8t-qd4scANEK1QguVv1ig6zEDvL7F7iFgNVGkkRTEicSq21-QyZ7jVul6J1Y', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-21 18:31:11', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web'), (N'210', N'3a8b4ac4-8e24-4b23-b850-8fca2d90794b', N'wechat_open_web', N'72_jJ0WZ-4r18IkeIs0YC6FfDOthAf9UIUNqALqUbYzBMirZuUh48M4AcVlp0Pjy4KbdA_OA1sWvkL1XWAcLa-KtqM-g-gF8Bz9DBfVUwcKGMU', NULL, N'72_qfKdEHN3PH23LcmUsUrXoUmO2EkXUtRStVV_j7RabNi8Kuj8mhZYao9fZYCs_m_djArcug96q0TgX2Nxxnkk8LFOYQ26ODl0fy8ZLW6WW9c', N'oyyyv6arGVpFTY9CsqnSJtorlf-A', NULL, NULL, N'oL1Fu55rzFhAJtwkp2Cyl25PKHu0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'2023-09-22 09:06:39', N'System', N'2023-09-22 09:07:14', N'System', N'1', N'1', N'6', N'🍎', N'🍎', N'https://thirdwx.qlogo.cn/mmopen/vi_32/1MKp7S9bHm212HicjST72CcvmbF1NCcY1SvXskO1vicrlIcuJt6jUBKcSgoOiaGBI2Jr7ic5ZjEpMNMA42joLjFBWA/132', NULL, N'wechat_open_web')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_things_model
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_things_model]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_things_model]
GO

CREATE TABLE [dbo].[iot_things_model] (
  [model_id] bigint NOT NULL,
  [model_name] nvarchar(64) NOT NULL,
  [product_id] bigint NOT NULL,
  [product_name] nvarchar(64) NOT NULL,
  [tenant_id] bigint NOT NULL,
  [tenant_name] nvarchar(30) NOT NULL,
  [identifier] nvarchar(32) NOT NULL,
  [type] tinyint NOT NULL,
  [datatype] nvarchar(64) NOT NULL,
  [specs] varchar(max) NULL,
  [is_chart] tinyint NOT NULL,
  [is_monitor] tinyint NOT NULL,
  [is_history] tinyint NULL,
  [is_readonly] tinyint NULL,
  [is_share_perm] tinyint NULL,
  [model_order] int NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL,
  [temp_slave_id] bigint NULL,
  [formula] nvarchar(255) NULL,
  [reverse_formula] nvarchar(255) NULL,
  [reg_addr] int NULL,
  [bit_option] nvarchar(255) NULL,
  [value_type] nvarchar(64) NULL,
  [is_params] int NULL,
  [quantity] int NULL,
  [code] nvarchar(255) NULL,
  [parse_type] nvarchar(20) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'model_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'model_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'product_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标识符，产品下唯一',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'identifier'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模型类别（1-属性，2-功能，3-事件）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据类型（integer、decimal、string、bool、array、enum）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'datatype'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据定义',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'specs'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否图表展示（0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'is_chart'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否实时监测（0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'is_monitor'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否历史存储（0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'is_history'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否只读数据(0-否，1-是)',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'is_readonly'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否设备分享权限(0-否，1-是)',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'is_share_perm'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序，值越大，排序越靠前',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'model_order'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'从机id',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'temp_slave_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计算公式',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'formula'
GO

EXEC sp_addextendedproperty
'MS_Description', N'控制公式',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'reverse_formula'
GO

EXEC sp_addextendedproperty
'MS_Description', N'寄存器地址值',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'reg_addr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'位定义选项',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'bit_option'
GO

EXEC sp_addextendedproperty
'MS_Description', N'解析类型 1.数值 2.选项',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'value_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否是计算参数',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'is_params'
GO

EXEC sp_addextendedproperty
'MS_Description', N'读取寄存器数量',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'quantity'
GO

EXEC sp_addextendedproperty
'MS_Description', N'modbus功能码',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'modbus解析类型',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model',
'COLUMN', N'parse_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model'
GO


-- ----------------------------
-- Records of iot_things_model
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_things_model] ([model_id], [model_name], [product_id], [product_name], [tenant_id], [tenant_name], [identifier], [type], [datatype], [specs], [is_chart], [is_monitor], [is_history], [is_readonly], [is_share_perm], [model_order], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark], [temp_slave_id], [formula], [reverse_formula], [reg_addr], [bit_option], [value_type], [is_params], [quantity], [code], [parse_type]) VALUES (N'113', N'设备开关', N'41', N'温湿度智能开关', N'1', N'admin', N'switch', N'2', N'bool', N'{"type": "bool", "trueText": "打开", "falseText": "关闭"}', N'0', N'0', N'1', N'0', N'0', N'9', N'0', NULL, N'2022-08-14 00:06:53', N'', N'2023-03-31 23:43:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'125', N'空气温度', N'41', N'温湿度智能开关', N'1', N'admin', N'temperature', N'1', N'decimal', N'{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', N'1', N'1', N'1', N'1', N'0', N'1', N'0', NULL, N'2022-11-05 23:56:21', N'', N'2023-03-31 23:44:21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'126', N'空气湿度', N'41', N'温湿度智能开关', N'1', N'admin', N'humidity', N'1', N'decimal', N'{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}', N'1', N'1', N'1', N'1', N'0', N'3', N'0', NULL, N'2022-11-05 23:56:21', N'', N'2023-03-31 23:44:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'127', N'二氧化碳', N'41', N'温湿度智能开关', N'1', N'admin', N'co2', N'1', N'integer', N'{"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm"}', N'1', N'1', N'1', N'1', N'0', N'2', N'0', NULL, N'2022-11-05 23:56:21', N'', N'2023-03-31 23:44:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'128', N'室内亮度', N'41', N'温湿度智能开关', N'1', N'admin', N'brightness', N'1', N'integer', N'{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}', N'1', N'1', N'1', N'1', N'0', N'4', N'0', NULL, N'2022-11-05 23:56:21', N'', N'2023-03-31 23:44:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'129', N'运行档位', N'41', N'温湿度智能开关', N'1', N'admin', N'gear', N'2', N'enum', N'{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', N'0', N'0', N'1', N'0', N'0', N'8', N'0', NULL, N'2022-11-05 23:56:21', N'', N'2023-03-31 23:43:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'130', N'灯光色值', N'41', N'温湿度智能开关', N'1', N'admin', N'light_color', N'2', N'array', N'{"type": "array", "arrayType": "integer", "arrayCount": "3"}', N'0', N'0', N'1', N'0', N'0', N'5', N'0', NULL, N'2022-11-05 23:56:21', N'', N'2023-09-25 22:57:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'131', N'屏显消息', N'41', N'温湿度智能开关', N'1', N'admin', N'message', N'2', N'string', N'{"type": "string", "maxLength": 1024}', N'0', N'0', N'1', N'0', N'0', N'7', N'0', NULL, N'2022-11-05 23:56:21', N'', N'2023-03-31 23:43:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'132', N'上报数据', N'41', N'温湿度智能开关', N'1', N'admin', N'report_monitor', N'2', N'integer', N'{"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}', N'0', N'0', N'0', N'0', N'0', N'10', N'0', NULL, N'2022-11-05 23:56:21', N'', N'2023-03-31 23:43:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'134', N'环境温度过高', N'41', N'温湿度智能开关', N'1', N'admin', N'height_temperature', N'3', N'decimal', N'{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', NULL, N'2022-11-05 23:56:29', N'', N'2023-03-31 23:44:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'135', N'设备发生异常', N'41', N'温湿度智能开关', N'1', N'admin', N'exception', N'3', N'string', N'{"type": "string", "maxLength": 1024}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', NULL, N'2022-11-05 23:56:29', N'', N'2023-03-31 23:44:29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'161', N'子设备', N'96', N'网关产品', N'1', N'admin', N'device', N'1', N'array', N'{"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1, "isSharePerm": 0}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "isChart": 0, "datatype": {"type": "enum", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "device_switch", "name": "设备开关", "order": 5, "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "isChart": 0, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "device_irc", "name": "射频遥控", "order": 1, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}], "arrayType": "object", "arrayCount": "5"}', N'0', N'0', N'0', N'0', N'1', N'10', N'0', NULL, N'2023-02-25 22:51:53', N'', N'2023-09-25 23:13:21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'162', N'功能分组', N'96', N'网关产品', N'1', N'admin', N'category', N'1', N'object', N'{"type": "object", "params": [{"id": "category_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "category_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isHistory": 0, "isMonitor": 1, "isReadonly": 1}, {"id": "category_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 1}, {"id": "category_report_monitor", "name": "上报监测数据", "order": 7, "isChart": 0, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "category_gear", "name": "运行档位", "order": 5, "isChart": 0, "datatype": {"type": "enum", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "category_switch", "name": "设备开关", "order": 4, "isChart": 0, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}, {"id": "category_irc", "name": "射频遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控配对", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0, "isSharePerm": 1}]}', N'0', N'0', N'0', N'0', N'1', N'9', N'0', NULL, N'2023-02-25 22:51:53', N'', N'2023-09-03 11:03:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'163', N'空气温度', N'96', N'网关产品', N'1', N'admin', N'temperature', N'1', N'decimal', N'{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', N'1', N'1', N'1', N'1', N'0', N'0', N'0', NULL, N'2023-02-25 22:52:16', N'', N'2023-03-31 16:08:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'164', N'设备开关', N'96', N'网关产品', N'1', N'admin', N'switch', N'2', N'bool', N'{"type": "bool", "trueText": "打开", "falseText": "关闭"}', N'0', N'0', N'1', N'0', N'1', N'8', N'0', NULL, N'2023-02-25 22:52:16', N'', N'2023-09-03 11:03:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'165', N'运行档位', N'96', N'网关产品', N'1', N'admin', N'gear', N'2', N'enum', N'{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', N'0', N'0', N'1', N'0', N'1', N'7', N'0', NULL, N'2023-02-25 22:52:16', N'', N'2023-09-03 11:03:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'166', N'灯光色值', N'96', N'网关产品', N'1', N'admin', N'light_color', N'2', N'array', N'{"type": "array", "arrayType": "integer", "arrayCount": "3"}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', NULL, N'2023-02-25 22:52:16', N'', N'2023-03-31 16:08:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'167', N'上报监测数据', N'96', N'网关产品', N'1', N'admin', N'report_monitor', N'2', N'integer', N'{"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}', N'0', N'0', N'1', N'0', N'1', N'11', N'0', NULL, N'2023-02-25 22:52:16', N'', N'2023-09-03 11:03:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'168', N'环境温度过高', N'96', N'网关产品', N'1', N'admin', N'height_temperature', N'3', N'decimal', N'{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', NULL, N'2023-02-25 22:52:16', N'', N'2023-03-31 16:08:15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'169', N'设备发生异常', N'96', N'网关产品', N'1', N'admin', N'exception', N'3', N'string', N'{"type": "string", "maxLength": 1024}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', NULL, N'2023-02-25 22:52:16', N'', N'2023-03-31 16:08:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'170', N'屏显消息', N'96', N'网关产品', N'1', N'admin', N'message', N'2', N'string', N'{"type": "string", "maxLength": 1024}', N'0', N'0', N'1', N'0', N'1', N'0', N'0', NULL, N'2023-02-25 22:52:35', N'', N'2023-09-03 11:03:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'171', N'设备重启', N'96', N'网关产品', N'1', N'admin', N'reset', N'2', N'enum', N'{"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}', N'0', N'0', N'1', N'0', N'1', N'0', N'0', NULL, N'2023-02-25 22:52:35', N'', N'2023-09-03 11:03:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'174', N'室内亮度', N'96', N'网关产品', N'1', N'admin', N'brightness', N'1', N'integer', N'{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}', N'1', N'1', N'1', N'1', N'0', N'0', N'0', NULL, N'2023-02-26 00:56:39', N'', N'2023-09-03 10:40:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'175', N'设备重启', N'41', N'智能开关', N'1', N'admin', N'reset', N'2', N'enum', N'{"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}', N'0', N'0', N'1', N'0', N'0', N'6', N'0', NULL, N'2023-02-26 02:20:40', N'', N'2023-04-01 23:40:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'385', N'射频遥控', N'41', N'★智能开关', N'1', N'admin', N'irc', N'2', N'enum', N'{"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}', N'0', N'0', N'1', N'0', N'0', N'11', N'0', N'admin', N'2023-03-31 23:46:36', N'', N'2023-04-13 01:38:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'439', N'上报状态', N'41', N'★智能开关产品', N'1', N'admin', N'status', N'2', N'enum', N'{"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}', N'0', N'0', N'0', N'0', N'0', N'12', N'0', N'admin', N'2023-04-13 01:39:31', N'', N'2023-04-13 01:39:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'493', N'漏水值', N'112', N'★MODBUS协议产品', N'1', N'admin', N'0', N'1', N'integer', N'{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "度"}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'', N'2023-09-13 23:33:19', N'', NULL, NULL, N'1', NULL, NULL, N'0', NULL, NULL, NULL, N'1', N'3', N'ushort'), (N'494', N'温度', N'112', N'★MODBUS协议产品', N'1', N'admin', N'0', N'1', N'integer', N'{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "°"}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'', N'2023-09-13 23:33:19', N'', NULL, NULL, N'2', NULL, NULL, N'0', NULL, NULL, NULL, N'1', N'3', N'ushort'), (N'495', N'电量', N'112', N'★MODBUS协议产品', N'1', N'admin', N'1', N'1', N'integer', N'{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": ""}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'', N'2023-09-13 23:33:19', N'', NULL, NULL, N'11', NULL, NULL, N'1', NULL, NULL, NULL, N'1', N'3', N'ushort'), (N'496', N'光照强度', N'55', N'网关产品', N'1', N'admin', N'light_level', N'1', N'integer', N'{"max": 89.2, "min": 2.5, "step": 0.1, "type": "integer", "unit": "L/g"}', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:06', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'497', N'状态灯色', N'55', N'网关产品', N'1', N'admin', N'color', N'2', N'enum', N'{"type": "enum", "showWay": "select", "enumList": [{"text": "红色", "value": "0"}, {"text": "绿色", "value": "1"}, {"text": "蓝色", "value": "2"}, {"text": "黄色", "value": "3"}]}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:06', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'498', N'子设备', N'55', N'网关产品', N'1', N'admin', N'device', N'2', N'array', N'{"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "name": "设备开关", "order": 5, "datatype": {"type": "bool", "enumList": [{"text": "", "value": ""}], "trueText": "打开", "arrayType": "int", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "arrayType": "object", "arrayCount": 5}', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:06', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'499', N'功能分组', N'55', N'网关产品', N'1', N'admin', N'group', N'2', N'object', N'{"type": "object", "params": [{"id": "group_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "group_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isMonitor": 1, "isReadonly": 1}, {"id": "group_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isMonitor": 0, "isReadonly": 1}, {"id": "group_report_monitor", "name": "上报监测数据", "order": 7, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group_gear", "name": "运行档位", "order": 5, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "group_switch", "name": "设备开关", "order": 4, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "group_irc", "name": "红外遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}]}', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:06', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'500', N'射频遥控', N'55', N'网关产品', N'1', N'admin', N'irc', N'2', N'enum', N'{"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:06', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'501', N'上报状态', N'55', N'网关产品', N'1', N'admin', N'status', N'2', N'enum', N'{"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}', N'0', N'0', N'0', N'0', N'1', N'0', N'0', N'admin', N'2025-03-19 16:32:06', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'502', N'运行档位', N'55', N'网关产品', N'1', N'admin', N'gear', N'2', N'enum', N'{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:21', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'503', N'灯光色值', N'55', N'网关产品', N'1', N'admin', N'light_color', N'2', N'array', N'{"type": "array", "arrayType": "integer", "arrayCount": "3"}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:21', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'504', N'屏显消息', N'55', N'网关产品', N'1', N'admin', N'message', N'2', N'string', N'{"type": "string", "maxLength": 1024}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:21', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'505', N'环境温度过高', N'55', N'网关产品', N'1', N'admin', N'height_temperature', N'3', N'decimal', N'{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:21', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'506', N'设备发生异常', N'55', N'网关产品', N'1', N'admin', N'exception', N'3', N'string', N'{"type": "string", "maxLength": 1024}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:21', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'507', N'空气温度', N'55', N'网关产品', N'1', N'admin', N'temperature', N'1', N'decimal', N'{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:31', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'508', N'空气湿度', N'55', N'网关产品', N'1', N'admin', N'humidity', N'1', N'decimal', N'{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:31', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'509', N'设备开关', N'55', N'网关产品', N'1', N'admin', N'switch', N'2', N'bool', N'{"type": "bool", "trueText": "打开", "falseText": "关闭"}', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2025-03-19 16:32:31', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for iot_things_model_template
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[iot_things_model_template]') AND type IN ('U'))
	DROP TABLE [dbo].[iot_things_model_template]
GO

CREATE TABLE [dbo].[iot_things_model_template] (
  [template_id] bigint NOT NULL,
  [template_name] nvarchar(64) NOT NULL,
  [tenant_id] bigint NOT NULL,
  [tenant_name] nvarchar(30) NOT NULL,
  [identifier] nvarchar(32) NOT NULL,
  [type] tinyint NOT NULL,
  [datatype] nvarchar(64) NOT NULL,
  [specs] varchar(max) NULL,
  [is_sys] tinyint NOT NULL,
  [is_chart] tinyint NOT NULL,
  [is_monitor] tinyint NOT NULL,
  [is_history] tinyint NOT NULL,
  [is_readonly] tinyint NULL,
  [is_share_perm] tinyint NULL,
  [model_order] int NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL,
  [temp_slave_id] nvarchar(20) NULL,
  [formula] nvarchar(255) NULL,
  [reverse_formula] nvarchar(255) NULL,
  [reg_addr] int NULL,
  [bit_option] nvarchar(255) NULL,
  [value_type] nvarchar(64) NULL,
  [is_params] int NULL,
  [quantity] int NULL,
  [code] nvarchar(255) NULL,
  [old_identifier] nvarchar(10) NULL,
  [old_temp_slave_id] nvarchar(10) NULL,
  [parse_type] nvarchar(20) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'template_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'template_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标识符，产品下唯一',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'identifier'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模型类别（1-属性，2-功能，3-事件）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据类型（integer、decimal、string、bool、array、enum）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'datatype'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据定义',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'specs'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否系统通用（0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'is_sys'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否图表展示（0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'is_chart'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否实时监测（0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'is_monitor'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否历史存储 (0-否，1-是）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'is_history'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否只读数据(0-否，1-是)',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'is_readonly'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否设备分享权限(0-否，1-是)',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'is_share_perm'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序，值越大，排序越靠前',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'model_order'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'从机id',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'temp_slave_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计算公式',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'formula'
GO

EXEC sp_addextendedproperty
'MS_Description', N'控制公式',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'reverse_formula'
GO

EXEC sp_addextendedproperty
'MS_Description', N'寄存器地址值',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'reg_addr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'位定义选项',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'bit_option'
GO

EXEC sp_addextendedproperty
'MS_Description', N'解析类型 1.数值 2.选项',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'value_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否是计算参数,默认否 0=否，1=是',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'is_params'
GO

EXEC sp_addextendedproperty
'MS_Description', N'读取寄存器数量',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'quantity'
GO

EXEC sp_addextendedproperty
'MS_Description', N'modbus功能码',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'旧的标识符',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'old_identifier'
GO

EXEC sp_addextendedproperty
'MS_Description', N'旧的从机id',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'old_temp_slave_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'modbus解析类型',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template',
'COLUMN', N'parse_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'物模型模板',
'SCHEMA', N'dbo',
'TABLE', N'iot_things_model_template'
GO


-- ----------------------------
-- Records of iot_things_model_template
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[iot_things_model_template] ([template_id], [template_name], [tenant_id], [tenant_name], [identifier], [type], [datatype], [specs], [is_sys], [is_chart], [is_monitor], [is_history], [is_readonly], [is_share_perm], [model_order], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark], [temp_slave_id], [formula], [reverse_formula], [reg_addr], [bit_option], [value_type], [is_params], [quantity], [code], [old_identifier], [old_temp_slave_id], [parse_type]) VALUES (N'1', N'空气温度', N'1', N'admin', N'temperature', N'1', N'decimal', N'{"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}', N'1', N'1', N'1', N'1', N'1', N'0', N'4', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:12:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'2', N'空气湿度', N'1', N'admin', N'humidity', N'1', N'decimal', N'{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}', N'1', N'1', N'1', N'1', N'1', N'0', N'3', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:12:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'3', N'二氧化碳', N'1', N'admin', N'co2', N'1', N'integer', N'{"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:11:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'4', N'室内亮度', N'1', N'admin', N'brightness', N'1', N'integer', N'{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": "cd/m2"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:11:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'5', N'设备开关', N'1', N'admin', N'switch', N'2', N'bool', N'{"type": "bool", "trueText": "打开", "falseText": "关闭"}', N'1', N'0', N'0', N'1', N'0', N'0', N'5', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:11:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'6', N'运行档位', N'1', N'admin', N'gear', N'2', N'enum', N'{"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}', N'1', N'0', N'0', N'1', N'0', N'0', N'6', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:11:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'7', N'灯光色值', N'1', N'admin', N'light_color', N'2', N'array', N'{"type": "array", "arrayType": "integer", "arrayCount": "3"}', N'1', N'0', N'0', N'1', N'0', N'0', N'2', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:11:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'8', N'屏显消息', N'1', N'admin', N'message', N'2', N'string', N'{"type": "string", "maxLength": 1024}', N'1', N'0', N'0', N'1', N'0', N'0', N'1', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:11:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'9', N'上报监测数据', N'1', N'admin', N'report_monitor', N'2', N'integer', N'{"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}', N'1', N'0', N'0', N'0', N'0', N'0', N'9', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:11:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'10', N'环境温度过高', N'1', N'admin', N'height_temperature', N'3', N'decimal', N'{"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "℃"}', N'1', N'0', N'0', N'1', N'0', N'0', N'8', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:11:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'11', N'设备发生异常', N'1', N'admin', N'exception', N'3', N'string', N'{"type": "string", "maxLength": 1024}', N'1', N'0', N'0', N'1', N'0', N'0', N'7', N'0', N'admin', N'2022-03-09 17:41:49', N'admin', N'2023-04-10 01:11:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'12', N'光照', N'1', N'admin', N'light', N'1', N'decimal', N'{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', N'0', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'wumei', N'2022-05-07 09:41:17', N'admin', N'2023-04-10 01:11:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'13', N'压力', N'1', N'admin', N'pressure', N'1', N'decimal', N'{"max": 200, "min": 0, "step": 0.1, "type": "decimal", "unit": "帕斯卡"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2023-02-20 22:39:18', N'admin', N'2023-04-10 01:11:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'14', N'设备重启', N'1', N'admin', N'reset', N'2', N'enum', N'{"type": "enum", "showWay": "button", "enumList": [{"text": "重启", "value": "restart"}]}', N'1', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2023-02-20 23:15:25', N'admin', N'2023-04-10 01:11:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'15', N'电池电压', N'1', N'admin', N'voltage', N'1', N'decimal', N'{"max": 5, "min": 0, "step": 0.001, "type": "decimal", "unit": "V"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2023-02-20 23:17:43', N'admin', N'2023-04-10 01:10:56', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'16', N'饮水量', N'1', N'admin', N'shuiliang', N'1', N'integer', N'{"max": 500, "min": 80, "step": 1, "type": "integer", "unit": "ML"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2023-02-20 23:18:39', N'admin', N'2023-04-10 01:10:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'17', N'灯光', N'1', N'admin', N'light', N'1', N'integer', N'{"max": 1000, "min": 0, "step": 1, "type": "integer", "unit": "Lux"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2023-02-20 23:19:23', N'admin', N'2023-04-10 01:10:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'18', N'长度', N'1', N'admin', N'length', N'1', N'integer', N'{"max": 2000, "min": 1, "step": 5, "type": "integer", "unit": "M"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2023-02-20 23:20:03', N'admin', N'2023-04-10 01:10:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'19', N'心率', N'1', N'admin', N'heart_rate', N'1', N'integer', N'{"max": 250, "min": 0, "step": 1, "type": "integer", "unit": "次数"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2023-02-20 23:21:46', N'admin', N'2023-04-10 01:12:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'20', N'光照强度', N'1', N'admin', N'light_level', N'1', N'integer', N'{"max": 89.2, "min": 2.5, "step": 0.1, "type": "integer", "unit": "L/g"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'admin', N'2023-02-20 23:24:36', N'admin', N'2023-04-10 01:10:35', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'21', N'状态灯色', N'1', N'admin', N'color', N'2', N'enum', N'{"type": "enum", "showWay": "select", "enumList": [{"text": "红色", "value": "0"}, {"text": "绿色", "value": "1"}, {"text": "蓝色", "value": "2"}, {"text": "黄色", "value": "3"}]}', N'1', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2023-02-20 23:26:24', N'admin', N'2023-04-10 01:10:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'22', N'子设备', N'1', N'admin', N'device', N'2', N'array', N'{"type": "array", "params": [{"id": "device_co2", "name": "二氧化碳", "order": 0, "isChart": 1, "datatype": {"max": 6000, "min": 100, "step": 1, "type": "integer", "unit": "ppm", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "device_temperature", "name": "空气温度-只读", "order": 4, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isMonitor": 0, "isReadonly": 1}, {"id": "device_gear", "name": "运行档位", "order": 6, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_switch", "name": "设备开关", "order": 5, "datatype": {"type": "bool", "enumList": [{"text": "", "value": ""}], "trueText": "打开", "arrayType": "int", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "device_report_monitor", "name": "上报监测数据", "order": 9, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数", "enumList": [{"text": "", "value": ""}], "arrayType": "int"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}], "arrayType": "object", "arrayCount": 5}', N'1', N'0', N'0', N'0', N'0', N'0', N'10', N'0', N'admin', N'2023-02-24 01:10:43', N'admin', N'2023-04-13 01:33:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'23', N'功能分组', N'1', N'admin', N'group', N'2', N'object', N'{"type": "object", "params": [{"id": "group_light", "name": "光照", "order": 1, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}, "isHistory": 1, "isMonitor": 1, "isReadonly": 1}, {"id": "group_humidity", "name": "空气湿度", "order": 2, "isChart": 1, "datatype": {"max": 100, "min": 0, "step": 0.1, "type": "decimal", "unit": "%"}, "isMonitor": 1, "isReadonly": 1}, {"id": "group_temperature", "name": "空气温度-只读", "order": 3, "isChart": 0, "datatype": {"max": 120, "min": -20, "step": 0.1, "type": "decimal", "unit": "℃"}, "isMonitor": 0, "isReadonly": 1}, {"id": "group_report_monitor", "name": "上报监测数据", "order": 7, "datatype": {"max": 10, "min": 1, "step": 1, "type": "integer", "unit": "次数"}, "isHistory": 0, "isMonitor": 0, "isReadonly": 0}, {"id": "group_gear", "name": "运行档位", "order": 5, "datatype": {"type": "enum", "showWay": "select", "enumList": [{"text": "低速档位", "value": "0"}, {"text": "中速档位", "value": "1"}, {"text": "中高速档位", "value": "2"}, {"text": "高速档位", "value": "3"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}, {"id": "group_switch", "name": "设备开关", "order": 4, "datatype": {"type": "bool", "trueText": "打开", "falseText": "关闭"}, "isMonitor": 0, "isReadonly": 0}, {"id": "group_irc", "name": "红外遥控", "order": 6, "isChart": 0, "datatype": {"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}, "isHistory": 1, "isMonitor": 0, "isReadonly": 0}]}', N'1', N'0', N'0', N'0', N'0', N'0', N'11', N'0', N'admin', N'2023-02-25 22:41:43', N'admin', N'2023-08-30 15:29:34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'201', N'频率 ', N'1', N'admin', N'frequency', N'2', N'integer', N'{"max": 65535, "min": 0, "step": 1, "type": "integer", "unit": "0.001Hz"}', N'1', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'', N'2023-02-28 16:08:06', N'admin', N'2023-04-10 03:37:11', NULL, N'3#3', N'%s*0.001', N'', N'27', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'225', N'校验位', N'1', N'admin', N'check', N'2', N'enum', N'{"type": "enum", "showWay": "select", "enumList": [{"text": "N", "value": "0"}, {"text": "O", "value": "1"}, {"text": "E", "value": "2"}]}', N'1', N'0', N'0', N'1', N'1', N'0', N'0', N'0', N'', N'2023-02-28 16:08:08', N'admin', N'2023-04-10 21:36:01', NULL, N'3#3', N'', N'', N'771', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'226', N'波特率', N'1', N'admin', N'baud', N'2', N'enum', N'{"type": "enum", "showWay": "select", "enumList": [{"text": "1200", "value": "0"}, {"text": "2400", "value": "1"}, {"text": "4800", "value": "2"}, {"text": "9600", "value": "3"}, {"text": "19200", "value": "4"}]}', N'1', N'0', N'0', N'1', N'1', N'0', N'0', N'0', N'', N'2023-02-28 16:08:09', N'admin', N'2023-04-10 03:37:32', NULL, N'3#3', N'', N'', N'772', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'227', N'电压', N'1', N'admin', N'voltage', N'1', N'integer', N'{"max": 6, "min": 0.1, "step": 0.1, "type": "integer", "unit": "v"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'', N'2023-02-28 16:08:09', N'admin', N'2023-04-10 03:37:16', NULL, N'3#3', N'', N'', N'773', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'236', N'射频遥控', N'1', N'admin', N'irc', N'2', N'enum', N'{"type": "enum", "showWay": "button", "enumList": [{"text": "遥控学习", "value": "FFXX01"}, {"text": "遥控清码", "value": "FFXX02"}, {"text": "打开开关", "value": "FFXX03"}, {"text": "关闭开关", "value": "FFXX04"}, {"text": "暂停", "value": "FFXX05"}, {"text": "锁定", "value": "FFXX06"}]}', N'1', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'admin', N'2023-03-31 23:46:20', N'admin', N'2023-04-10 01:09:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'250', N'漏水值', N'1', N'admin', N'0', N'1', N'integer', N'{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "度"}', N'1', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'', N'2023-04-11 22:35:36', N'', N'2023-09-13 23:32:34', NULL, N'1#1', NULL, NULL, N'0', NULL, NULL, NULL, N'1', N'3', NULL, NULL, N'ushort'), (N'251', N'温度', N'1', N'admin', N'0', N'1', N'integer', N'{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": "°"}', N'1', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'', N'2023-04-11 22:36:10', N'', N'2023-09-13 23:32:51', NULL, N'1#2', NULL, NULL, N'0', NULL, NULL, NULL, N'1', N'3', NULL, NULL, N'ushort'), (N'252', N'电量', N'1', N'admin', N'1', N'1', N'integer', N'{"max": 100, "min": 1, "step": 1, "type": "integer", "unit": ""}', N'1', N'0', N'0', N'1', N'0', N'0', N'0', N'0', N'', N'2023-04-11 22:36:27', N'', N'2023-09-13 23:33:11', NULL, N'1#11', NULL, NULL, N'1', NULL, NULL, NULL, N'1', N'3', NULL, NULL, N'ushort'), (N'323', N'上报状态', N'1', N'admin', N'status', N'2', N'enum', N'{"type": "enum", "showWay": "button", "enumList": [{"text": "更新状态", "value": "update_status"}]}', N'1', N'0', N'0', N'0', N'0', N'1', N'0', N'0', N'admin', N'2023-04-13 01:35:42', N'admin', N'2023-09-03 10:50:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'324', N'X位移', N'1', N'admin', N'x-shift', N'1', N'decimal', N'{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-26 19:36:58', N'', NULL, NULL, N'2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'325', N'Y位移', N'1', N'admin', N'y-shift', N'1', N'decimal', N'{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-26 19:37:23', N'', N'2023-08-26 19:37:32', NULL, N'2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'326', N'X位移', N'1', N'admin', N'x-shift', N'1', N'decimal', N'{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-26 19:38:31', N'', NULL, NULL, N'2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'327', N'Y位移', N'1', N'admin', N'y-shift', N'1', N'decimal', N'{"max": 100, "min": 0, "step": 1, "type": "decimal", "unit": "mm"}', N'1', N'1', N'1', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-26 19:38:51', N'', NULL, NULL, N'2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'328', N'计件数量', N'1', N'admin', N'0', N'1', N'integer', N'{"max": 10000, "min": 0, "step": 1, "type": "integer", "unit": ""}', N'1', N'0', N'0', N'0', N'1', N'0', N'0', N'0', N'', N'2023-08-28 15:05:25', N'', NULL, NULL, N'3#1', NULL, NULL, N'0', NULL, NULL, NULL, N'1', N'3', NULL, NULL, NULL), (N'329', N'参数1', N'1', N'admin', N'0', N'1', N'integer', N'{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', N'1', N'0', N'0', N'0', N'1', N'0', N'0', N'0', N'', N'2023-08-28 15:06:55', N'', NULL, NULL, N'3#2', NULL, NULL, N'0', NULL, NULL, NULL, N'1', N'3', NULL, NULL, NULL), (N'330', N'图片', N'1', N'admin', N'image', N'1', N'string', N'{"type": "string", "maxLength": 10240}', N'1', N'0', N'0', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-28 23:19:30', N'', NULL, NULL, N'2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'331', N'回路状态', N'10', N'jamon', N'loop_status', N'1', N'array', N'{"type": "array", "arrayType": "integer"}', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'', N'2023-08-29 18:21:38', N'', NULL, NULL, N'4#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'332', N'回路状态', N'10', N'jamon', N'loop_status', N'1', N'array', N'{"type": "array", "arrayType": "integer"}', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'', N'2023-08-29 18:23:08', N'', NULL, NULL, N'4#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'335', N'湿度', N'1', N'admin', N'0', N'1', N'integer', N'{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', N'1', N'0', N'0', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-30 14:05:38', N'', N'2023-08-30 14:58:28', NULL, N'6#1', N'%s/10', NULL, N'0', NULL, NULL, NULL, N'1', N'3', NULL, NULL, NULL), (N'336', N'温度', N'1', N'admin', N'1', N'1', N'integer', N'{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": "°C"}', N'1', N'0', N'0', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-30 14:06:05', N'', N'2023-08-30 14:58:38', NULL, N'6#1', N'%s/10', NULL, N'1', NULL, NULL, NULL, N'1', N'3', NULL, NULL, NULL), (N'341', N'视频', N'1', N'admin', N'video', N'1', N'integer', N'{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', N'1', N'0', N'0', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-30 23:08:51', N'', N'2023-08-30 23:25:15', NULL, N'2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'342', N'图片', N'1', N'admin', N'image', N'1', N'string', N'{"type": "string", "maxLength": 1024}', N'1', N'0', N'0', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-30 23:21:48', N'', N'2023-08-30 23:25:22', NULL, N'2#2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL), (N'343', N'状态', N'1', N'admin', N'status', N'1', N'integer', N'{"max": 100, "min": 0, "step": 1, "type": "integer", "unit": ""}', N'1', N'0', N'0', N'1', N'1', N'0', N'0', N'0', N'', N'2023-08-30 23:28:00', N'', N'2023-08-30 23:28:17', NULL, N'2#1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for media_server
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[media_server]') AND type IN ('U'))
	DROP TABLE [dbo].[media_server]
GO

CREATE TABLE [dbo].[media_server] (
  [id] bigint NOT NULL,
  [server_id] nvarchar(30) NOT NULL,
  [tenant_id] bigint NOT NULL,
  [tenant_name] nvarchar(30) NOT NULL,
  [enabled] tinyint NULL,
  [protocol] nvarchar(10) NOT NULL,
  [ip] nvarchar(255) NOT NULL,
  [domain] nvarchar(128) NOT NULL,
  [hookurl] nvarchar(255) NOT NULL,
  [secret] nvarchar(255) NOT NULL,
  [port_http] int NOT NULL,
  [port_https] int NOT NULL,
  [port_rtmp] int NOT NULL,
  [port_rtsp] int NOT NULL,
  [rtp_proxy_port] int NOT NULL,
  [rtp_enable] tinyint NOT NULL,
  [rtp_port_range] nvarchar(255) NOT NULL,
  [record_port] int NOT NULL,
  [auto_config] tinyint NOT NULL,
  [status] tinyint NOT NULL,
  [del_flag] nchar(1) NOT NULL,
  [create_by] nvarchar(64) NOT NULL,
  [create_time] datetime2 NOT NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL,
  [port_ws] int NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'流媒体配置ID',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'服务器标识',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'server_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'使能开关',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'enabled'
GO

EXEC sp_addextendedproperty
'MS_Description', N'默认播放协议',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'protocol'
GO

EXEC sp_addextendedproperty
'MS_Description', N'服务器ip',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'服务器域名',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'domain'
GO

EXEC sp_addextendedproperty
'MS_Description', N'回调服务器地址',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'hookurl'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流媒体密钥',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'secret'
GO

EXEC sp_addextendedproperty
'MS_Description', N'http端口',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'port_http'
GO

EXEC sp_addextendedproperty
'MS_Description', N'https端口',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'port_https'
GO

EXEC sp_addextendedproperty
'MS_Description', N'rtmp端口',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'port_rtmp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'rtsp端口',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'port_rtsp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'RTP收流端口',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'rtp_proxy_port'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否使用多端口模式',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'rtp_enable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'rtp端口范围',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'rtp_port_range'
GO

EXEC sp_addextendedproperty
'MS_Description', N'录像服务端口',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'record_port'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否自动同步配置ZLM',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'auto_config'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'ws端口',
'SCHEMA', N'dbo',
'TABLE', N'media_server',
'COLUMN', N'port_ws'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流媒体服务器配置',
'SCHEMA', N'dbo',
'TABLE', N'media_server'
GO


-- ----------------------------
-- Records of media_server
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[media_server] ([id], [server_id], [tenant_id], [tenant_name], [enabled], [protocol], [ip], [domain], [hookurl], [secret], [port_http], [port_https], [port_rtmp], [port_rtsp], [rtp_proxy_port], [rtp_enable], [rtp_port_range], [record_port], [auto_config], [status], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark], [port_ws]) VALUES (N'7', N'fastbee', N'1', N'admin', N'1', N'http', N'192.168.2.120', N'fastbee.com2', N'192.168.2.15:8080', N'035c73f7-bb6b-4889-a715-d9eb2d192xxx', N'8082', N'8443', N'1935', N'554', N'0', N'1', N'30000,30103', N'18081', N'1', N'0', N'0', N'', N'2023-09-26 21:11:43', N'', N'2023-10-26 21:51:25', NULL, NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for news
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[news]') AND type IN ('U'))
	DROP TABLE [dbo].[news]
GO

CREATE TABLE [dbo].[news] (
  [news_id] bigint NOT NULL,
  [title] nvarchar(64) NOT NULL,
  [content] nvarchar(max) NOT NULL,
  [img_url] nvarchar(128) NOT NULL,
  [is_top] tinyint NOT NULL,
  [is_banner] tinyint NOT NULL,
  [category_id] bigint NOT NULL,
  [category_name] nvarchar(32) NOT NULL,
  [status] tinyint NOT NULL,
  [author] nvarchar(50) NOT NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'新闻ID',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'news_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标题',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'内容',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'封面',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'img_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否置顶(0-置顶 1-置顶)',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'is_top'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否banner(0-是banner 1-不是banner)',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'is_banner'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类ID',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'category_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'category_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'新闻状态（0-未发布，1-已发布）',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'作者',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'author'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'news',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'新闻资讯',
'SCHEMA', N'dbo',
'TABLE', N'news'
GO


-- ----------------------------
-- Records of news
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[news] ([news_id], [title], [content], [img_url], [is_top], [is_banner], [category_id], [category_name], [status], [author], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'广告图一', N'<p>请后台添加内容</p>', N'/iot/tool/download?fileName=/profile/iot/118/2022-0424-215805.png', N'0', N'1', N'2', N'相关产品', N'1', N'物美智能', N'0', N'', N'2022-05-12 12:13:40', N'', N'2022-05-12 12:13:40', N'物美智能'), (N'2', N'广告图二', N'<p>请后台添加内容</p>', N'/iot/tool/download?fileName=/profile/iot/118/2022-0424-215852.png', N'0', N'1', N'1', N'新闻资讯', N'1', N'物美智能', N'0', N'', N'2022-05-12 12:13:42', N'', N'2022-05-12 12:13:42', N'物美智能'), (N'3', N'广告图三', N'<p>后台添加内容</p>', N'/iot/tool/download?fileName=/profile/iot/118/2022-0424-224553.png', N'0', N'1', N'2', N'相关产品', N'1', N'物美智能', N'0', N'', N'2022-05-12 12:13:44', N'', N'2022-05-12 12:13:44', N'物美智能'), (N'4', N'物美智能-快速搭建物联网和智能家居平台', N'<p class="ql-align-justify">物美智能 wumei-smart 是一个简单易用的生活物联网平台。可用于搭建物联网平台以及二次开发和学习。设备接入使用EMQX消息服务器，加密认证；后端采用Spring boot；前端采用Vue；移动端采用Uniapp；数据库采用Mysql和Redis；设备端支持ESP32、ESP8266、树莓派等；</p><p class="ql-align-justify"><img src="/prod-api/profile/upload/2022/05/11/5f479f25-b85d-4c9f-b6a7-deadd2cdec76.png"></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>系统功能介绍</strong></p><p class="ql-align-justify"><br></p><p class="ql-align-justify">1.权限管理： 用户管理、部门管理、岗位管理、菜单管理、角色管理、字典和参数管理等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">2.系统监控： 操作日志、登录日志、系统日志、在线用户、服务监控、连接池监控、缓存监控等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">3.产品管理： 产品、产品物模型、产品分类、产品固件、授权码等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">4.设备管理： 控制、分组、定时、日志、统计、定位、OTA升级、影子模式、实时监测、加密认证等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">5.EMQ管理： Mqtt客户端、监听器、消息主题、消息订阅、插件管理、规则引擎、资源</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">6.硬件 SDK： 支持WIFI和MQTT连接、物模型响应、实时监测、定时上报监测数据、AES加密、NTP时间等</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">7.物模型管理： 属性（设备状态和监测数据），功能（执行特定任务），事件（设备主动上报给云端）</p><p class="ql-align-justify"><br></p><p class="ql-align-justify">8.其他（开发中）：第三方登录，设备分享、设备告警、场景联动（进度50%），智能音箱、多租户、APP界面自定义（进度40%），时序数据库、分布式集群部署、Granfa监控（进度30%），视频流处理、桌面端模拟器/监控、安卓端模拟器/监控（进度20%）</p><p class="ql-align-justify"><strong>﻿</strong></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>硬件设备接入流程</strong></p><p><br></p><p>1.设备认证：加密认证、简单认证和emqx支持的多种认证方式。</p><p class="ql-align-justify">2.设备交互：发布和订阅物模型、设备信息、设备升级和时钟同步等mqtt主题</p>', N'/iot/tool/download?fileName=/profile/iot/1/2022-0508-133031.png', N'1', N'0', N'2', N'相关产品', N'1', N'物美智能', N'0', N'', N'2022-05-12 12:13:46', N'', N'2022-05-12 12:13:46', N'物美智能'), (N'5', N'2022年中国物联网全景图产业链上中下游市场及企业剖析', N'<p>后台添加内容</p>', N'/iot/tool/download?fileName=/profile/iot/118/2022-0424-224151.png', N'1', N'0', N'1', N'新闻资讯', N'1', N'物美智能', N'0', N'', N'2022-05-12 12:13:48', N'', N'2022-05-12 12:13:48', N'物美智能'), (N'6', N'Arm打造物联网全面解决方案 携手合作伙伴共探智能未来', N'<p>后台添加内容</p>', N'/iot/tool/download?fileName=/profile/iot/118/2022-0424-224352.png', N'1', N'0', N'1', N'新闻资讯', N'1', N'物美智能', N'0', N'', N'2022-05-12 12:13:50', N'', N'2022-05-12 12:13:50', N'物美智能'), (N'7', N'使用ESP32开发板，快速学习物联网开发', N'<p>请后台添加内容</p>', N'/iot/tool/download?fileName=/profile/iot/118/2022-0428-130824.jpg', N'1', N'0', N'2', N'相关产品', N'1', N'物美智能', N'0', N'', N'2022-05-12 12:13:53', N'', N'2022-05-12 12:13:53', N'物美智能'), (N'8', N'物联网赛道观察之无源物联网', N'<p>无源物联网，即终端无外接能量源，采用获取环境能量的方式进行供能的物联网技术。在当前物联网技术发展条件下，终端覆盖率是一个亟待解决的问题，而无源物联网凭借其极低的部署和维护成本、灵活多变的应用场景成为解决更广范围内终端供能需求问题、实现“千亿级互联”愿景的关键。</p><p><br></p><p>无源物联网技术的发展最终有赖于环境能量采集、低功耗计算与反向散射等低功耗通讯技术的进步。目前无源物联网应用较为成熟的路线主要包括射频识别技术（RFID）与近场通信技术（NFC）两类，覆盖仓储物流、智能制造、智慧零售、资产管理、物业服务等多元应用场景。未来，随着物联网行业的碎片化整合以及以Bluetooth、5G、LoRa等为媒介进行能量采集与信息传输的技术路线的逐渐成熟，当前困扰行业的诸多问题将会逐步得到解决，随之而来的是更包罗多样的无源终端需求与极具潜力的应用场景。</p>', N'/iot/tool/download?fileName=/profile/iot/118/2022-0424-215643.png', N'1', N'0', N'1', N'新闻资讯', N'1', N'物美智能', N'0', N'', N'2022-05-12 12:13:55', N'', N'2022-05-12 12:13:55', N'物美智能')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for news_category
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[news_category]') AND type IN ('U'))
	DROP TABLE [dbo].[news_category]
GO

CREATE TABLE [dbo].[news_category] (
  [category_id] bigint NOT NULL,
  [category_name] nvarchar(64) NOT NULL,
  [order_num] int NOT NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类ID',
'SCHEMA', N'dbo',
'TABLE', N'news_category',
'COLUMN', N'category_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类名称',
'SCHEMA', N'dbo',
'TABLE', N'news_category',
'COLUMN', N'category_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'news_category',
'COLUMN', N'order_num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'news_category',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'news_category',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'news_category',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'news_category',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'news_category',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'news_category',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'新闻分类',
'SCHEMA', N'dbo',
'TABLE', N'news_category'
GO


-- ----------------------------
-- Records of news_category
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[news_category] ([category_id], [category_name], [order_num], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'新闻资讯', N'3', N'0', N'', N'2022-04-11 20:53:55', N'', N'2022-04-13 15:30:22', N'新闻资讯信息'), (N'2', N'相关产品', N'2', N'0', N'', N'2022-04-11 20:54:16', N'', N'2022-04-13 15:30:15', N'相关产品推荐')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for oauth_access_token
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oauth_access_token]') AND type IN ('U'))
	DROP TABLE [dbo].[oauth_access_token]
GO

CREATE TABLE [dbo].[oauth_access_token] (
  [token_id] nvarchar(255) NULL,
  [token] varbinary(max) NULL,
  [authentication_id] nvarchar(255) NULL,
  [user_name] nvarchar(255) NULL,
  [client_id] nvarchar(255) NULL,
  [authentication] varbinary(max) NULL,
  [refresh_token] nvarchar(255) NULL
)
GO


-- ----------------------------
-- Records of oauth_access_token
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[oauth_access_token] ([token_id], [token], [authentication_id], [user_name], [client_id], [authentication], [refresh_token]) VALUES (N'd406d946aac7c24cd01a2df1105ec898', 0xACED0005737200436F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744F4175746832416363657373546F6B656E0CB29E361B24FACE0200064C00156164646974696F6E616C496E666F726D6174696F6E74000F4C6A6176612F7574696C2F4D61703B4C000A65787069726174696F6E7400104C6A6176612F7574696C2F446174653B4C000C72656672657368546F6B656E74003F4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F636F6D6D6F6E2F4F417574683252656672657368546F6B656E3B4C000573636F706574000F4C6A6176612F7574696C2F5365743B4C0009746F6B656E547970657400124C6A6176612F6C616E672F537472696E673B4C000576616C756571007E000578707372001E6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794D6170593614855ADCE7D002000078707372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018AA760D163787372004C6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744578706972696E674F417574683252656672657368546F6B656E2FDF47639DD0C9B70200014C000A65787069726174696F6E71007E0002787200446F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744F417574683252656672657368546F6B656E73E10E0A6354D45E0200014C000576616C756571007E0005787074001B56452D377744386D70414A34497A662D49345F456450316F31626F7371007E000977080000018AA760D12D78737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C0001637400164C6A6176612F7574696C2F436F6C6C656374696F6E3B7870737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000043F400000000000027400047265616474000577726974657874000662656172657274001B70385A5F47384A7349327A33786575674430646A494B305A396B38, N'2c27d3f4516a653753e8337094cf35e1', N'admin', N'admin-dueros', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000009740004636F64657400066E777064716174000A6772616E745F74797065740012617574686F72697A6174696F6E5F636F646574000573636F706574000A7265616420777269746574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F65326566636666663936383964633462366166363764373865313039363934647400057374617465740020346635653763303462313731306262653836376535376431373434613534373874000D636C69656E745F7365637265747400205332456E65487864745E4D48684276384E23245E7479366E71244E5159324E6474000A647565726F735F7569647400203466356537633034623137313062626538363765353764313734346135343738740009636C69656E745F696474000C61646D696E2D647565726F7378737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E002E770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E002E770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E002E770C000000103F4000000000000171007E0020787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00434C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00434C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E004378707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E00470000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E00470000018AA6E3204374000A57696E646F77732031307371007E002E770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00434C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00435B0007726F6C6549647371007E00554C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00434C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00544C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0054787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00434C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00434C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E005670707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E004974000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0048000000017371007E0047000000000000006570707400013171007E00497400103136343737303730374071712E636F6D7371007E005977080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E00555B00076D656E7549647371007E00554C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00434C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00604C000673746174757371007E000F7871007E005670707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E0047000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E00687400013078740001307400013071007E007674000561646D696E71007E0076, N'4cabc0e9bcfa34131342209bdaf275eb')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for oauth_approvals
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oauth_approvals]') AND type IN ('U'))
	DROP TABLE [dbo].[oauth_approvals]
GO

CREATE TABLE [dbo].[oauth_approvals] (
  [userId] nvarchar(255) NULL,
  [clientId] nvarchar(255) NULL,
  [scope] nvarchar(255) NULL,
  [status] nvarchar(10) NULL,
  [expiresAt] datetime2 NOT NULL,
  [lastModifiedAt] datetime2 NULL
)
GO


-- ----------------------------
-- Records of oauth_approvals
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[oauth_approvals] ([userId], [clientId], [scope], [status], [expiresAt], [lastModifiedAt]) VALUES (N'admin', N'admin-dueros', N'read', N'APPROVED', N'2023-10-18 22:12:45', N'2023-09-18 22:12:45'), (N'admin', N'admin-dueros', N'write', N'APPROVED', N'2023-10-18 22:12:45', N'2023-09-18 22:12:45')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oauth_client_details]') AND type IN ('U'))
	DROP TABLE [dbo].[oauth_client_details]
GO

CREATE TABLE [dbo].[oauth_client_details] (
  [client_id] nvarchar(255) NOT NULL,
  [resource_ids] nvarchar(255) NULL,
  [client_secret] nvarchar(255) NULL,
  [scope] nvarchar(255) NULL,
  [authorized_grant_types] nvarchar(255) NULL,
  [web_server_redirect_uri] nvarchar(255) NULL,
  [authorities] nvarchar(255) NULL,
  [access_token_validity] int NULL,
  [refresh_token_validity] int NULL,
  [additional_information] nvarchar(max) NULL,
  [autoapprove] nvarchar(255) NULL,
  [type] tinyint NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户端ID',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'client_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户端所能访问的资源id集合,多个资源时用逗号(,)分隔',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'resource_ids'
GO

EXEC sp_addextendedproperty
'MS_Description', N'客户端秘钥',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'client_secret'
GO

EXEC sp_addextendedproperty
'MS_Description', N'权限范围,可选值包括read,write,trust;若有多个权限范围用逗号(,)分隔',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'scope'
GO

EXEC sp_addextendedproperty
'MS_Description', N'授权模式，可选值包括authorization_code,password,refresh_token,implicit,client_credentials, 若支持多个grant_type用逗号(,)分隔',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'authorized_grant_types'
GO

EXEC sp_addextendedproperty
'MS_Description', N'回调地址',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'web_server_redirect_uri'
GO

EXEC sp_addextendedproperty
'MS_Description', N'权限',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'authorities'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设定客户端的access_token的有效时间值(单位:秒)',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'access_token_validity'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设定客户端的refresh_token的有效时间值(单位:秒)',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'refresh_token_validity'
GO

EXEC sp_addextendedproperty
'MS_Description', N'预留的字段,在Oauth的流程中没有实际的使用,可选,但若设置值,必须是JSON格式的数据',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'additional_information'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设置用户是否自动Approval操作, 默认值为 ''false'', 可选值包括 ''true'',''false'', ''read'',''write''. 
该字段只适用于grant_type="authorization_code"的情况,当用户登录成功后,若该值为''true''或支持的scope值,则会跳过用户Approve的页面, 直接授权. ',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'autoapprove'
GO

EXEC sp_addextendedproperty
'MS_Description', N'1=小度(DuerOS),2=天猫精灵(ALiGenie),3=小米小爱',
'SCHEMA', N'dbo',
'TABLE', N'oauth_client_details',
'COLUMN', N'type'
GO


-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[oauth_client_details] ([client_id], [resource_ids], [client_secret], [scope], [authorized_grant_types], [web_server_redirect_uri], [authorities], [access_token_validity], [refresh_token_validity], [additional_information], [autoapprove], [type]) VALUES (N'admin-dueros', N'speaker-service', N'S2EneHxdt^MHhBv8N#$^ty6nq$NQY2Nd', N'read,write', N'authorization_code,refresh_token', N'https://xiaodu.baidu.com/saiya/auth/e2efcfff9689dc4b6af67d78e109694d', N'ROLE_ADMIN', N'7200', N'7200', NULL, N'false', N'1'), (N'fastbee-dueros', N'speaker-service', N'S2EneHxdt^MHhBv8N#$^ty6nq$NQY2Nc', N'read,write', N'authorization_code,refresh_token', N'https://xiaodu.baidu.com/saiya/auth/35dc8a5b53719ea6bbb7bd818ca8d5b6', N'ROLE_ADMIN', N'7200', N'7200', NULL, N'false', N'1'), (N'speaker', N'speaker-service', N'$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', N'read,write', N'client_credentials,password,authorization_code,implicit,refresh_token', N'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', N'ROLE_ADMIN', N'7200', N'7200', NULL, N'false', N'1'), (N'tianmao', N'speaker-service', N'$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', N'read,write', N'authorization_code,refresh_token', N'
https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', N'ROLE_ADMIN', N'7200', N'7200', NULL, N'true', N'2'), (N'xiaoai', N'speaker-service', N'$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', N'read,write', N'authorization_code,refresh_token', N'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', N'ROLE_ADMIN', N'7200', N'7200', NULL, N'true', N'3'), (N'xiaoyi', N'speaker-service', N'$2a$10$jMEhxWXpc6KsMyFF0JJ3kuoVHOp.tEsTCvaJHnQqfGtYKo4.scv/m', N'read,write', N'authorization_code,refresh_token', N'https://xiaodu.baidu.com/saiya/auth/22c6bd1489c8396f00cc25bf2d9d0206', N'ROLE_ADMIN', N'7200', N'7200', NULL, N'false', N'4')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for oauth_client_token
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oauth_client_token]') AND type IN ('U'))
	DROP TABLE [dbo].[oauth_client_token]
GO

CREATE TABLE [dbo].[oauth_client_token] (
  [token_id] nvarchar(255) NULL,
  [token] varbinary(max) NULL,
  [authentication_id] nvarchar(255) NULL,
  [user_name] nvarchar(255) NULL,
  [client_id] nvarchar(255) NULL
)
GO


-- ----------------------------
-- Records of oauth_client_token
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for oauth_code
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oauth_code]') AND type IN ('U'))
	DROP TABLE [dbo].[oauth_code]
GO

CREATE TABLE [dbo].[oauth_code] (
  [code] nvarchar(255) NULL,
  [authentication] varbinary(max) NULL
)
GO


-- ----------------------------
-- Records of oauth_code
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[oauth_code] ([code], [authentication]) VALUES (N'mLAeh7', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000474000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464740009636C69656E745F696471007E001474000573636F706574000A7265616420777269746578737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E0023770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E0023770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E0023770C000000103F4000000000000171007E001A787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00384C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00384C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E003878707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E003C0000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E003C0000018AA6E3204374000A57696E646F77732031307371007E0023770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00384C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00385B0007726F6C6549647371007E004A4C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00384C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00494C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0049787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00384C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00384C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E004B70707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E003E74000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E003D000000017371007E003C000000000000006570707400013171007E003E7400103136343737303730374071712E636F6D7371007E004E77080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E004A5B00076D656E7549647371007E004A4C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00384C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00554C000673746174757371007E000F7871007E004B70707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E003C000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E005D7400013078740001307400013071007E006B74000561646D696E71007E006B), (N'1YESo2', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000474000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464740009636C69656E745F696471007E001474000573636F706574000A7265616420777269746578737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E0023770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E0023770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E0023770C000000103F4000000000000171007E001A787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00384C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00384C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E003878707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E003C0000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E003C0000018AA6E3204374000A57696E646F77732031307371007E0023770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00384C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00385B0007726F6C6549647371007E004A4C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00384C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00494C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0049787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00384C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00384C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E004B70707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E003E74000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E003D000000017371007E003C000000000000006570707400013171007E003E7400103136343737303730374071712E636F6D7371007E004E77080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E004A5B00076D656E7549647371007E004A4C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00384C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00554C000673746174757371007E000F7871007E004B70707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E003C000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E005D7400013078740001307400013071007E006B74000561646D696E71007E006B), (N'DhdDPY', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000674000573636F706574000A7265616420777269746574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F65326566636666663936383964633462366166363764373865313039363934647400057374617465740020346635653763303462313731306262653836376535376431373434613534373874000A647565726F735F7569647400203466356537633034623137313062626538363765353764313734346135343738740009636C69656E745F696471007E001478737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E0027770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E0027770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E0027770C000000103F4000000000000171007E001C787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E003C4C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E003C4C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E003C78707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E00400000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E00400000018AA6E3204374000A57696E646F77732031307371007E0027770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E003C4C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E003C5B0007726F6C6549647371007E004E4C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E003C4C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E004D4C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E004D787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E003C4C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E003C4C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E004F70707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E004274000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0041000000017371007E0040000000000000006570707400013171007E00427400103136343737303730374071712E636F6D7371007E005277080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E004E5B00076D656E7549647371007E004E4C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E003C4C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00594C000673746174757371007E000F7871007E004F70707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E0040000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E00617400013078740001307400013071007E006F74000561646D696E71007E006F)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for oauth_refresh_token
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[oauth_refresh_token]') AND type IN ('U'))
	DROP TABLE [dbo].[oauth_refresh_token]
GO

CREATE TABLE [dbo].[oauth_refresh_token] (
  [token_id] nvarchar(255) NULL,
  [token] varbinary(max) NULL,
  [authentication] varbinary(max) NULL
)
GO


-- ----------------------------
-- Records of oauth_refresh_token
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[oauth_refresh_token] ([token_id], [token], [authentication]) VALUES (N'4cabc0e9bcfa34131342209bdaf275eb', 0xACED00057372004C6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744578706972696E674F417574683252656672657368546F6B656E2FDF47639DD0C9B70200014C000A65787069726174696F6E7400104C6A6176612F7574696C2F446174653B787200446F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E636F6D6D6F6E2E44656661756C744F417574683252656672657368546F6B656E73E10E0A6354D45E0200014C000576616C75657400124C6A6176612F6C616E672F537472696E673B787074001B56452D377744386D70414A34497A662D49345F456450316F31626F7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018AA760D12D78, 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000007704000000007871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B72656469726563745572697400124C6A6176612F6C616E672F537472696E673B4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0011787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000F4C001172657175657374506172616D657465727371007E000E4C000573636F706571007E0011787074000C61646D696E2D647565726F73737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E000E7870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000009740004636F6465740006536C4B4F684C74000A6772616E745F74797065740012617574686F72697A6174696F6E5F636F646574000573636F706574000A7265616420777269746574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F65326566636666663936383964633462366166363764373865313039363934647400057374617465740020346635653763303462313731306262653836376535376431373434613534373874000D636C69656E745F7365637265747400225332456E65487864745E4D48684276384E253233245E7479366E71244E5159324E6474000A647565726F735F7569647400203466356537633034623137313062626538363765353764313734346135343738740009636C69656E745F696474000C61646D696E2D647565726F7378737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000274000472656164740005777269746578017371007E002E770C000000103F40000000000001737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002260200014C0004726F6C6571007E000F787074000A524F4C455F41444D494E787371007E00173F40000000000000770800000010000000007874004468747470733A2F2F7869616F64752E62616964752E636F6D2F73616979612F617574682F6532656663666666393638396463346236616636376437386531303936393464707371007E002E770C000000103F4000000000000174000F737065616B65722D73657276696365787371007E002E770C000000103F4000000000000171007E0020787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002260200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017372001F6A6176612E7574696C2E436F6C6C656374696F6E7324456D7074794C6973747AB817B43CA79EDE0200007870737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002260200024C000D72656D6F74654164647265737371007E000F4C000973657373696F6E496471007E000F787074000F303A303A303A303A303A303A303A3170707372002E636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E6D6F64656C2E4C6F67696E55736572000000000000000102000B4C000762726F7773657271007E000F4C00066465707449647400104C6A6176612F6C616E672F4C6F6E673B4C000A65787069726554696D6571007E00434C000669706164647271007E000F4C000D6C6F67696E4C6F636174696F6E71007E000F4C00096C6F67696E54696D6571007E00434C00026F7371007E000F4C000B7065726D697373696F6E7371007E00114C0005746F6B656E71007E000F4C00047573657274002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973557365723B4C000675736572496471007E004378707400094368726F6D652031317372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000677371007E00470000018AAC097C437400093132372E302E302E31740008E58685E7BD9149507371007E00470000018AA6E3204374000A57696E646F77732031307371007E002E770C000000023F400000000000017400052A3A2A3A2A7874002439326462396566652D656438662D343965392D613839392D3664393431633333393237637372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E5379735573657200000000000000010200124C000661766174617271007E000F4C000764656C466C616771007E000F4C00046465707474002F4C636F6D2F666173746265652F636F6D6D6F6E2F636F72652F646F6D61696E2F656E746974792F537973446570743B4C000664657074496471007E00434C0005656D61696C71007E000F4C00096C6F67696E446174657400104C6A6176612F7574696C2F446174653B4C00076C6F67696E497071007E000F4C00086E69636B4E616D6571007E000F4C000870617373776F726471007E000F4C000B70686F6E656E756D62657271007E000F5B0007706F73744964737400115B4C6A6176612F6C616E672F4C6F6E673B4C0006726F6C65496471007E00435B0007726F6C6549647371007E00554C0005726F6C657371007E00084C000373657871007E000F4C000673746174757371007E000F4C000675736572496471007E00434C0008757365724E616D6571007E000F78720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E000F4C000A63726561746554696D6571007E00544C0006706172616D7371007E000E4C000672656D61726B71007E000F4C000B73656172636856616C756571007E000F4C0008757064617465427971007E000F4C000A75706461746554696D6571007E0054787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED850787371007E00173F400000000000007708000000100000000078740009E7AEA1E79086E59198707070740000740001307372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E53797344657074000000000000000102000C4C0009616E636573746F727371007E000F4C00086368696C6472656E71007E00084C000764656C466C616771007E000F4C000664657074496471007E00434C0008646570744E616D6571007E000F4C0005656D61696C71007E000F4C00066C656164657271007E000F4C00086F726465724E756D7400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00434C000A706172656E744E616D6571007E000F4C000570686F6E6571007E000F4C000673746174757371007E000F7871007E005670707371007E00173F40000000000000770800000010000000007870707070740009302C3130302C3130317371007E000B00000000770400000000787071007E004974000CE7A094E58F91E983A8E997A870740006E789A9E7BE8E737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0048000000017371007E0047000000000000006570707400013171007E00497400103136343737303730374071712E636F6D7371007E005977080000018AA651C3B8787400093132372E302E302E3174000FE89C82E4BFA1E7AEA1E79086E5919874003C2432612431302451416F77377962733734666B53574A444A6B56544E656F6746376D686E69684637535445727437385078446848694E6E6F3449557574000B31353838383838383838387070707371007E000B000000017704000000017372002D636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E656E746974792E537973526F6C65000000000000000102000D5A001164657074436865636B5374726963746C795A0004666C61675A00116D656E75436865636B5374726963746C794C00096461746153636F706571007E000F4C000764656C466C616771007E000F5B00076465707449647371007E00555B00076D656E7549647371007E00554C000B7065726D697373696F6E7371007E00114C0006726F6C65496471007E00434C0007726F6C654B657971007E000F4C0008726F6C654E616D6571007E000F4C0008726F6C65536F727471007E00604C000673746174757371007E000F7871007E005670707371007E00173F4000000000000077080000001000000000787070707000000074000131707070707371007E0047000000000000000174000561646D696E74000FE8B685E7BAA7E7AEA1E79086E5919871007E00687400013078740001307400013071007E007674000561646D696E71007E0076)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_blob_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_blob_triggers]
GO

CREATE TABLE [dbo].[qrtz_blob_triggers] (
  [sched_name] nvarchar(120) NOT NULL,
  [trigger_name] nvarchar(200) NOT NULL,
  [trigger_group] nvarchar(200) NOT NULL,
  [blob_data] varbinary(max) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_blob_triggers',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_name的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_blob_triggers',
'COLUMN', N'trigger_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_group的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_blob_triggers',
'COLUMN', N'trigger_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'存放持久化Trigger对象',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_blob_triggers',
'COLUMN', N'blob_data'
GO

EXEC sp_addextendedproperty
'MS_Description', N'Blob类型的触发器表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_blob_triggers'
GO


-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_calendars]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_calendars]
GO

CREATE TABLE [dbo].[qrtz_calendars] (
  [sched_name] nvarchar(120) NOT NULL,
  [calendar_name] nvarchar(200) NOT NULL,
  [calendar] varbinary(max) NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_calendars',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日历名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_calendars',
'COLUMN', N'calendar_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'存放持久化calendar对象',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_calendars',
'COLUMN', N'calendar'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日历信息表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_calendars'
GO


-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_cron_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_cron_triggers]
GO

CREATE TABLE [dbo].[qrtz_cron_triggers] (
  [sched_name] nvarchar(120) NOT NULL,
  [trigger_name] nvarchar(200) NOT NULL,
  [trigger_group] nvarchar(200) NOT NULL,
  [cron_expression] nvarchar(200) NOT NULL,
  [time_zone_id] nvarchar(80) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_cron_triggers',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_name的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_cron_triggers',
'COLUMN', N'trigger_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_group的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_cron_triggers',
'COLUMN', N'trigger_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'cron表达式',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_cron_triggers',
'COLUMN', N'cron_expression'
GO

EXEC sp_addextendedproperty
'MS_Description', N'时区',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_cron_triggers',
'COLUMN', N'time_zone_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'Cron类型的触发器表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_cron_triggers'
GO


-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[qrtz_cron_triggers] ([sched_name], [trigger_name], [trigger_group], [cron_expression], [time_zone_id]) VALUES (N'RuoyiScheduler', N'TASK_CLASS_NAME1', N'DEFAULT', N'0/10 * * * * ?', N'Asia/Shanghai'), (N'RuoyiScheduler', N'TASK_CLASS_NAME2', N'DEFAULT', N'0/15 * * * * ?', N'Asia/Shanghai'), (N'RuoyiScheduler', N'TASK_CLASS_NAME3', N'DEFAULT', N'0/20 * * * * ?', N'Asia/Shanghai'), (N'RuoyiScheduler', N'TASK_CLASS_NAME4', N'SYSTEM', N'0 0/4 * * * ? ', N'Asia/Shanghai'), (N'RuoyiScheduler', N'TASK_CLASS_NAME5', N'SYSTEM', N'0 0/1 * * * ? ', N'Asia/Shanghai')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_fired_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_fired_triggers]
GO

CREATE TABLE [dbo].[qrtz_fired_triggers] (
  [sched_name] nvarchar(120) NOT NULL,
  [entry_id] nvarchar(95) NOT NULL,
  [trigger_name] nvarchar(200) NOT NULL,
  [trigger_group] nvarchar(200) NOT NULL,
  [instance_name] nvarchar(200) NOT NULL,
  [fired_time] bigint NOT NULL,
  [sched_time] bigint NOT NULL,
  [priority] int NOT NULL,
  [state] nvarchar(16) NOT NULL,
  [job_name] nvarchar(200) NULL,
  [job_group] nvarchar(200) NULL,
  [is_nonconcurrent] nvarchar(1) NULL,
  [requests_recovery] nvarchar(1) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度器实例id',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'entry_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_name的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'trigger_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_group的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'trigger_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度器实例名',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'instance_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'触发的时间',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'fired_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'定时器制定的时间',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'sched_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'优先级',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'priority'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'state'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'job_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务组名',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'job_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否并发',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'is_nonconcurrent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否接受恢复执行',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers',
'COLUMN', N'requests_recovery'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已触发的触发器表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_fired_triggers'
GO


-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_job_details]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_job_details]
GO

CREATE TABLE [dbo].[qrtz_job_details] (
  [sched_name] nvarchar(120) NOT NULL,
  [job_name] nvarchar(200) NOT NULL,
  [job_group] nvarchar(200) NOT NULL,
  [description] nvarchar(250) NULL,
  [job_class_name] nvarchar(250) NOT NULL,
  [is_durable] nvarchar(1) NOT NULL,
  [is_nonconcurrent] nvarchar(1) NOT NULL,
  [is_update_data] nvarchar(1) NOT NULL,
  [requests_recovery] nvarchar(1) NOT NULL,
  [job_data] varbinary(max) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'job_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务组名',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'job_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'相关介绍',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行任务类名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'job_class_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否持久化',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'is_durable'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否并发',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'is_nonconcurrent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否更新数据',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'is_update_data'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否接受恢复执行',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'requests_recovery'
GO

EXEC sp_addextendedproperty
'MS_Description', N'存放持久化job对象',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details',
'COLUMN', N'job_data'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务详细信息表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_job_details'
GO


-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[qrtz_job_details] ([sched_name], [job_name], [job_group], [description], [job_class_name], [is_durable], [is_nonconcurrent], [is_update_data], [requests_recovery], [job_data]) VALUES (N'RuoyiScheduler', N'TASK_CLASS_NAME1', N'DEFAULT', NULL, N'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', N'0', N'1', N'0', N'0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED85078707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001307800), (N'RuoyiScheduler', N'TASK_CLASS_NAME2', N'DEFAULT', NULL, N'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', N'0', N'1', N'0', N'0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED85078707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800), (N'RuoyiScheduler', N'TASK_CLASS_NAME3', N'DEFAULT', NULL, N'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', N'0', N'1', N'0', N'0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017DBE4ED85078707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800), (N'RuoyiScheduler', N'TASK_CLASS_NAME4', N'SYSTEM', NULL, N'com.fastbee.quartz.util.QuartzJobExecution', N'0', N'0', N'0', N'0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001869759B0B878707400007070707400013074000E3020302F34202A202A202A203F2074002070726F7047657453657276696365496D706C2E666574636850726F706572747974000653595354454D7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000047400126D6F64627573E4BA91E7ABAFE8BDAEE8AFA274000131740001307800), (N'RuoyiScheduler', N'TASK_CLASS_NAME5', N'SYSTEM', NULL, N'com.fastbee.quartz.util.QuartzDisallowConcurrentExecution', N'0', N'1', N'0', N'0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720020636F6D2E666173746265652E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720029636F6D2E666173746265652E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000187118D07E078707400007070707400013174000E3020302F31202A202A202A203F207400286465766963654A6F622E74696D696E6755706461746544657669636553746174757353746174757374000653595354454D7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000005740012E8AEBEE5A487E5AE9AE697B6E4BBBBE58AA174000131740001307800)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_locks]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_locks]
GO

CREATE TABLE [dbo].[qrtz_locks] (
  [sched_name] nvarchar(120) NOT NULL,
  [lock_name] nvarchar(40) NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_locks',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'悲观锁名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_locks',
'COLUMN', N'lock_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'存储的悲观锁信息表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_locks'
GO


-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[qrtz_locks] ([sched_name], [lock_name]) VALUES (N'RuoyiScheduler', N'STATE_ACCESS'), (N'RuoyiScheduler', N'TRIGGER_ACCESS')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_paused_trigger_grps]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_paused_trigger_grps]
GO

CREATE TABLE [dbo].[qrtz_paused_trigger_grps] (
  [sched_name] nvarchar(120) NOT NULL,
  [trigger_group] nvarchar(200) NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_paused_trigger_grps',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_group的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_paused_trigger_grps',
'COLUMN', N'trigger_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'暂停的触发器表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_paused_trigger_grps'
GO


-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_scheduler_state]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_scheduler_state]
GO

CREATE TABLE [dbo].[qrtz_scheduler_state] (
  [sched_name] nvarchar(120) NOT NULL,
  [instance_name] nvarchar(200) NOT NULL,
  [last_checkin_time] bigint NOT NULL,
  [checkin_interval] bigint NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_scheduler_state',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'实例名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_scheduler_state',
'COLUMN', N'instance_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上次检查时间',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_scheduler_state',
'COLUMN', N'last_checkin_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'检查间隔时间',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_scheduler_state',
'COLUMN', N'checkin_interval'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度器状态表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_scheduler_state'
GO


-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[qrtz_scheduler_state] ([sched_name], [instance_name], [last_checkin_time], [checkin_interval]) VALUES (N'RuoyiScheduler', N'beecue1680023933011', N'1680023961720', N'15000')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_simple_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_simple_triggers]
GO

CREATE TABLE [dbo].[qrtz_simple_triggers] (
  [sched_name] nvarchar(120) NOT NULL,
  [trigger_name] nvarchar(200) NOT NULL,
  [trigger_group] nvarchar(200) NOT NULL,
  [repeat_count] bigint NOT NULL,
  [repeat_interval] bigint NOT NULL,
  [times_triggered] bigint NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simple_triggers',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_name的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simple_triggers',
'COLUMN', N'trigger_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_group的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simple_triggers',
'COLUMN', N'trigger_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'重复的次数统计',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simple_triggers',
'COLUMN', N'repeat_count'
GO

EXEC sp_addextendedproperty
'MS_Description', N'重复的间隔时间',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simple_triggers',
'COLUMN', N'repeat_interval'
GO

EXEC sp_addextendedproperty
'MS_Description', N'已经触发的次数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simple_triggers',
'COLUMN', N'times_triggered'
GO

EXEC sp_addextendedproperty
'MS_Description', N'简单触发器的信息表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simple_triggers'
GO


-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_simprop_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_simprop_triggers]
GO

CREATE TABLE [dbo].[qrtz_simprop_triggers] (
  [sched_name] nvarchar(120) NOT NULL,
  [trigger_name] nvarchar(200) NOT NULL,
  [trigger_group] nvarchar(200) NOT NULL,
  [str_prop_1] nvarchar(512) NULL,
  [str_prop_2] nvarchar(512) NULL,
  [str_prop_3] nvarchar(512) NULL,
  [int_prop_1] int NULL,
  [int_prop_2] int NULL,
  [long_prop_1] bigint NULL,
  [long_prop_2] bigint NULL,
  [dec_prop_1] decimal(13,4) NULL,
  [dec_prop_2] decimal(13,4) NULL,
  [bool_prop_1] nvarchar(1) NULL,
  [bool_prop_2] nvarchar(1) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_name的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'trigger_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_triggers表trigger_group的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'trigger_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'String类型的trigger的第一个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'str_prop_1'
GO

EXEC sp_addextendedproperty
'MS_Description', N'String类型的trigger的第二个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'str_prop_2'
GO

EXEC sp_addextendedproperty
'MS_Description', N'String类型的trigger的第三个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'str_prop_3'
GO

EXEC sp_addextendedproperty
'MS_Description', N'int类型的trigger的第一个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'int_prop_1'
GO

EXEC sp_addextendedproperty
'MS_Description', N'int类型的trigger的第二个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'int_prop_2'
GO

EXEC sp_addextendedproperty
'MS_Description', N'long类型的trigger的第一个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'long_prop_1'
GO

EXEC sp_addextendedproperty
'MS_Description', N'long类型的trigger的第二个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'long_prop_2'
GO

EXEC sp_addextendedproperty
'MS_Description', N'decimal类型的trigger的第一个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'dec_prop_1'
GO

EXEC sp_addextendedproperty
'MS_Description', N'decimal类型的trigger的第二个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'dec_prop_2'
GO

EXEC sp_addextendedproperty
'MS_Description', N'Boolean类型的trigger的第一个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'bool_prop_1'
GO

EXEC sp_addextendedproperty
'MS_Description', N'Boolean类型的trigger的第二个参数',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers',
'COLUMN', N'bool_prop_2'
GO

EXEC sp_addextendedproperty
'MS_Description', N'同步机制的行锁表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_simprop_triggers'
GO


-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[qrtz_triggers]') AND type IN ('U'))
	DROP TABLE [dbo].[qrtz_triggers]
GO

CREATE TABLE [dbo].[qrtz_triggers] (
  [sched_name] nvarchar(120) NOT NULL,
  [trigger_name] nvarchar(200) NOT NULL,
  [trigger_group] nvarchar(200) NOT NULL,
  [job_name] nvarchar(200) NOT NULL,
  [job_group] nvarchar(200) NOT NULL,
  [description] nvarchar(250) NULL,
  [next_fire_time] bigint NULL,
  [prev_fire_time] bigint NULL,
  [priority] int NULL,
  [trigger_state] nvarchar(16) NOT NULL,
  [trigger_type] nvarchar(8) NOT NULL,
  [start_time] bigint NOT NULL,
  [end_time] bigint NULL,
  [calendar_name] nvarchar(200) NULL,
  [misfire_instr] smallint NULL,
  [job_data] varbinary(max) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'调度名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'sched_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'触发器的名字',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'trigger_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'触发器所属组的名字',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'trigger_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_job_details表job_name的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'job_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'qrtz_job_details表job_group的外键',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'job_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'相关介绍',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'上一次触发时间（毫秒）',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'next_fire_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'下一次触发时间（默认为-1表示不触发）',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'prev_fire_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'优先级',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'priority'
GO

EXEC sp_addextendedproperty
'MS_Description', N'触发器状态',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'trigger_state'
GO

EXEC sp_addextendedproperty
'MS_Description', N'触发器的类型',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'trigger_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'开始时间',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'start_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'结束时间',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'end_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日程表名称',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'calendar_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'补偿执行的策略',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'misfire_instr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'存放持久化job对象',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers',
'COLUMN', N'job_data'
GO

EXEC sp_addextendedproperty
'MS_Description', N'触发器详细信息表',
'SCHEMA', N'dbo',
'TABLE', N'qrtz_triggers'
GO


-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[qrtz_triggers] ([sched_name], [trigger_name], [trigger_group], [job_name], [job_group], [description], [next_fire_time], [prev_fire_time], [priority], [trigger_state], [trigger_type], [start_time], [end_time], [calendar_name], [misfire_instr], [job_data]) VALUES (N'RuoyiScheduler', N'TASK_CLASS_NAME1', N'DEFAULT', N'TASK_CLASS_NAME1', N'DEFAULT', NULL, N'1680023970000', N'1680023960000', N'5', N'WAITING', N'CRON', N'1680023946000', N'0', NULL, N'2', 0x), (N'RuoyiScheduler', N'TASK_CLASS_NAME2', N'DEFAULT', N'TASK_CLASS_NAME2', N'DEFAULT', NULL, N'1680023955000', N'-1', N'5', N'PAUSED', N'CRON', N'1680023947000', N'0', NULL, N'2', 0x), (N'RuoyiScheduler', N'TASK_CLASS_NAME3', N'DEFAULT', N'TASK_CLASS_NAME3', N'DEFAULT', NULL, N'1680023960000', N'-1', N'5', N'PAUSED', N'CRON', N'1680023948000', N'0', NULL, N'2', 0x), (N'RuoyiScheduler', N'TASK_CLASS_NAME4', N'SYSTEM', N'TASK_CLASS_NAME4', N'SYSTEM', NULL, N'1680024000000', N'-1', N'5', N'WAITING', N'CRON', N'1680023950000', N'0', NULL, N'-1', 0x), (N'RuoyiScheduler', N'TASK_CLASS_NAME5', N'SYSTEM', N'TASK_CLASS_NAME5', N'SYSTEM', NULL, N'1680024000000', N'-1', N'5', N'WAITING', N'CRON', N'1680023951000', N'0', NULL, N'-1', 0x)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sip_config
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sip_config]') AND type IN ('U'))
	DROP TABLE [dbo].[sip_config]
GO

CREATE TABLE [dbo].[sip_config] (
  [id] bigint NOT NULL,
  [product_id] bigint NOT NULL,
  [product_name] nvarchar(64) NOT NULL,
  [enabled] tinyint NULL,
  [isdefault] tinyint NULL,
  [seniorSdp] tinyint NULL,
  [domain] nvarchar(10) NOT NULL,
  [server_sipid] nvarchar(20) NOT NULL,
  [password] nvarchar(20) NOT NULL,
  [ip] nvarchar(32) NULL,
  [port] bigint NULL,
  [del_flag] nchar(1) NOT NULL,
  [create_by] nvarchar(64) NOT NULL,
  [create_time] datetime2 NOT NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'product_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'使能开关',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'enabled'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统默认配置',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'isdefault'
GO

EXEC sp_addextendedproperty
'MS_Description', N'拓展sdp',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'seniorSdp'
GO

EXEC sp_addextendedproperty
'MS_Description', N'服务器域',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'domain'
GO

EXEC sp_addextendedproperty
'MS_Description', N'服务器sipid',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'server_sipid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'sip认证密码',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
'MS_Description', N'sip接入IP',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'sip接入端口号',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'port'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sip_config',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'sip系统配置',
'SCHEMA', N'dbo',
'TABLE', N'sip_config'
GO


-- ----------------------------
-- Records of sip_config
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sip_config] ([id], [product_id], [product_name], [enabled], [isdefault], [seniorSdp], [domain], [server_sipid], [password], [ip], [port], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'38', N'117', N'', N'1', N'1', NULL, N'3402000000', N'34020000002000000001', N'12345678', N'177.7.0.13', N'5061', N'0', N'', N'2023-03-16 21:26:18', N'', N'2023-03-16 21:26:24', NULL), (N'39', N'118', N'', N'1', N'1', NULL, N'3402000000', N'34020000002000000001', N'12345678', N'177.7.0.13', N'5061', N'0', N'', N'2023-04-11 21:11:54', N'', NULL, NULL), (N'41', N'135', N'', N'1', N'1', NULL, N'3402000000', N'34020000002000000001', N'12345678', N'177.7.0.13', N'5061', N'0', N'', N'2024-01-08 22:14:35', N'', NULL, NULL), (N'42', N'131', N'', N'0', N'0', NULL, N'3402000000', N'34020000002000000001', N'12345678', N'192.168.5.27', N'5061', N'0', N'', N'2025-03-19 16:26:04', N'', NULL, NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sip_device
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sip_device]') AND type IN ('U'))
	DROP TABLE [dbo].[sip_device]
GO

CREATE TABLE [dbo].[sip_device] (
  [device_id] bigint NOT NULL,
  [product_id] bigint NOT NULL,
  [product_name] nvarchar(64) NOT NULL,
  [device_sip_id] nvarchar(64) NOT NULL,
  [device_name] nvarchar(64) NOT NULL,
  [manufacturer] nvarchar(64) NOT NULL,
  [model] nvarchar(64) NOT NULL,
  [firmware] nvarchar(64) NOT NULL,
  [transport] nvarchar(64) NOT NULL,
  [streamMode] nvarchar(64) NOT NULL,
  [online] nvarchar(64) NOT NULL,
  [registerTime] datetime2 NOT NULL,
  [lastConnectTime] datetime2 NULL,
  [active_time] datetime2 NULL,
  [ip] nvarchar(32) NULL,
  [port] bigint NULL,
  [hostAddress] nvarchar(32) NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备ID',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'device_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'product_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备SipID',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'device_sip_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备名称',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'device_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'厂商名称',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'manufacturer'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品型号',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'model'
GO

EXEC sp_addextendedproperty
'MS_Description', N'固件版本',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'firmware'
GO

EXEC sp_addextendedproperty
'MS_Description', N'传输模式',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'transport'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流模式',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'streamMode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'在线状态',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'online'
GO

EXEC sp_addextendedproperty
'MS_Description', N'注册时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'registerTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后上线时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'lastConnectTime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'激活时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'active_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备入网IP',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备接入端口号',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'port'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备地址',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'hostAddress'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sip_device',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'监控设备',
'SCHEMA', N'dbo',
'TABLE', N'sip_device'
GO


-- ----------------------------
-- Records of sip_device
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sip_device] ([device_id], [product_id], [product_name], [device_sip_id], [device_name], [manufacturer], [model], [firmware], [transport], [streamMode], [online], [registerTime], [lastConnectTime], [active_time], [ip], [port], [hostAddress], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'9', N'0', N'', N'13030300001170000008', N'8E085C3RAJE156F', N'Dahua', N'DH-3H3205-ADW', N'2.810.0000027.0.R,2022-08-26', N'UDP', N'UDP', N'', N'2023-02-27 12:07:35', N'2023-02-26 23:36:45', NULL, N'177.7.0.1', N'35332', N'177.7.0.1:35332', N'0', N'', NULL, N'', NULL, NULL), (N'12', N'0', N'', N'11010100001320000001', N'海康威视摄像头', N'Hikvision', N'iDS-2DE2402IX-D3/W/XM', N'V5.7.4', N'UDP', N'UDP', N'', N'2024-01-09 23:29:52', N'2024-01-09 23:35:00', NULL, N'192.168.2.119', N'5065', N'192.168.2.119:5065', N'0', N'', NULL, N'', NULL, NULL), (N'13', N'0', N'', N'11010200001320000017', N'', N'', N'', N'', N'UDP', N'UDP', N'', N'2023-03-16 21:41:45', N'2023-03-16 21:52:50', NULL, N'192.168.2.119', N'5060', N'192.168.2.119:5060', N'0', N'', NULL, N'', NULL, NULL), (N'16', N'0', N'', N'12010100001320000003', N'IP DOME', N'Hikvision', N'iDS-2DE2402IX-D3/W/XM', N'V5.7.4', N'UDP', N'UDP', N'', N'2023-04-11 21:08:07', N'2023-04-11 21:13:16', NULL, N'192.168.2.119', N'5060', N'192.168.2.119:5060', N'0', N'', NULL, N'', NULL, NULL), (N'18', N'0', N'', N'13030100001320000001', N'', N'ABCD', N'TEST001', N'V1.0', N'UDP', N'UDP', N'', N'2023-03-28 16:06:45', N'2023-03-28 16:09:52', NULL, N'192.168.205.250', N'5063', N'192.168.205.250:5063', N'0', N'', NULL, N'', NULL, NULL), (N'19', N'0', N'', N'11010200001320000001', N'海康威视摄像头', N'Hikvision', N'iDS-2DE2402IX-D3/W/XM', N'V5.7.4', N'UDP', N'UDP', N'', N'2024-01-08 22:08:27', N'2024-01-08 22:16:32', NULL, N'192.168.2.119', N'5065', N'192.168.2.119:5065', N'0', N'', NULL, N'', NULL, NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sip_device_channel
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sip_device_channel]') AND type IN ('U'))
	DROP TABLE [dbo].[sip_device_channel]
GO

CREATE TABLE [dbo].[sip_device_channel] (
  [id] bigint NOT NULL,
  [tenant_id] bigint NOT NULL,
  [tenant_name] nvarchar(30) NOT NULL,
  [product_id] bigint NOT NULL,
  [product_name] nvarchar(64) NOT NULL,
  [user_id] bigint NOT NULL,
  [user_name] nvarchar(64) NOT NULL,
  [device_sip_id] nvarchar(64) NOT NULL,
  [channel_sip_id] nvarchar(64) NOT NULL,
  [channel_name] nvarchar(64) NOT NULL,
  [register_time] datetime2 NULL,
  [device_type] nvarchar(64) NULL,
  [channel_type] nvarchar(64) NULL,
  [cityCode] nvarchar(64) NOT NULL,
  [civilCode] nvarchar(64) NOT NULL,
  [manufacture] nvarchar(64) NOT NULL,
  [model] nvarchar(64) NOT NULL,
  [owner] nvarchar(64) NOT NULL,
  [block] nvarchar(64) NOT NULL,
  [address] nvarchar(64) NOT NULL,
  [parentId] nvarchar(64) NOT NULL,
  [ipAddress] nvarchar(32) NULL,
  [port] bigint NULL,
  [password] nvarchar(64) NOT NULL,
  [PTZType] bigint NOT NULL,
  [PTZTypeText] nvarchar(64) NOT NULL,
  [status] tinyint NOT NULL,
  [longitude] float NULL,
  [latitude] float NULL,
  [streamId] nvarchar(64) NOT NULL,
  [subCount] bigint NOT NULL,
  [parental] tinyint NOT NULL,
  [hasAudio] tinyint NOT NULL,
  [del_flag] nchar(1) NOT NULL,
  [create_by] nvarchar(64) NOT NULL,
  [create_time] datetime2 NOT NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'主键',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户ID',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'tenant_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'租户名称',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'tenant_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'product_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'product_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品ID',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品名称',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备SipID',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'device_sip_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'通道SipID',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'channel_sip_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'通道名称',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'channel_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'注册时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'register_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备类型',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'device_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'通道类型',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'channel_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'城市编码',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'cityCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'行政区域',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'civilCode'
GO

EXEC sp_addextendedproperty
'MS_Description', N'厂商名称',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'manufacture'
GO

EXEC sp_addextendedproperty
'MS_Description', N'产品型号',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'model'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备归属',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'owner'
GO

EXEC sp_addextendedproperty
'MS_Description', N'警区',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'block'
GO

EXEC sp_addextendedproperty
'MS_Description', N'安装地址',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'address'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父级id',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'parentId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备入网IP',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'ipAddress'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备接入端口号',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'port'
GO

EXEC sp_addextendedproperty
'MS_Description', N'密码',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
'MS_Description', N'PTZ类型',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'PTZType'
GO

EXEC sp_addextendedproperty
'MS_Description', N'PTZ类型描述字符串',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'PTZTypeText'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备状态（1-未激活，2-禁用，3-在线，4-离线）',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备经度',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'longitude'
GO

EXEC sp_addextendedproperty
'MS_Description', N'设备纬度',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'latitude'
GO

EXEC sp_addextendedproperty
'MS_Description', N'流媒体ID',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'streamId'
GO

EXEC sp_addextendedproperty
'MS_Description', N'子设备数',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'subCount'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否有子设备（1-有, 0-没有）',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'parental'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否含有音频（1-有, 0-没有）',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'hasAudio'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'监控设备通道信息',
'SCHEMA', N'dbo',
'TABLE', N'sip_device_channel'
GO


-- ----------------------------
-- Records of sip_device_channel
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sip_device_channel] ([id], [tenant_id], [tenant_name], [product_id], [product_name], [user_id], [user_name], [device_sip_id], [channel_sip_id], [channel_name], [register_time], [device_type], [channel_type], [cityCode], [civilCode], [manufacture], [model], [owner], [block], [address], [parentId], [ipAddress], [port], [password], [PTZType], [PTZTypeText], [status], [longitude], [latitude], [streamId], [subCount], [parental], [hasAudio], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'84', N'1', N'admin', N'118', N'监控设备', N'1', N'admin', N'11010200001320000001', N'11010200001320000001', N'IPdome', N'2024-01-08 22:16:32', N'132', N'132', N'北京市/市辖区/西城区', N'3402000000', N'Hikvision', N'IP Camera', N'Owner', N'', N'Address', N'34020000002000000001', N'', N'0', N'', N'0', N'', N'3', N'0.000000', N'0.000000', N'gb_play_11010200001320000001_11010200001320000001', N'0', N'0', N'0', N'0', N'', N'2023-04-11 21:12:33', N'', NULL, NULL), (N'102', N'1', N'admin', N'135', N'视频监控', N'0', N'', N'11010100001320000001', N'11010100001320000001', N'IPdome', N'2024-01-09 23:35:00', N'132', N'132', N'北京市/市辖区/东城区', N'3402000000', N'Hikvision', N'IP Camera', N'Owner', N'', N'Address', N'34020000002000000001', N'', N'0', N'', N'0', N'', N'3', N'0.000000', N'0.000000', N'', N'0', N'0', N'0', N'0', N'', N'2024-01-08 22:15:57', N'', NULL, NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_auth_user
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_auth_user]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_auth_user]
GO

CREATE TABLE [dbo].[sys_auth_user] (
  [auth_id] bigint NOT NULL,
  [uuid] nvarchar(500) NOT NULL,
  [user_id] bigint NOT NULL,
  [login_name] nvarchar(30) NOT NULL,
  [user_name] nvarchar(30) NULL,
  [avatar] nvarchar(500) NULL,
  [email] nvarchar(255) NULL,
  [source] nvarchar(255) NULL,
  [create_time] datetime2 NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'授权ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user',
'COLUMN', N'auth_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方平台用户唯一ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user',
'COLUMN', N'uuid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统用户ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录账号',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user',
'COLUMN', N'login_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'头像地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user',
'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户邮箱',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user',
'COLUMN', N'email'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户来源',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user',
'COLUMN', N'source'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'第三方授权表',
'SCHEMA', N'dbo',
'TABLE', N'sys_auth_user'
GO


-- ----------------------------
-- Records of sys_auth_user
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_config]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_config]
GO

CREATE TABLE [dbo].[sys_config] (
  [config_id] int NOT NULL,
  [config_name] nvarchar(100) NULL,
  [config_key] nvarchar(100) NULL,
  [config_value] nvarchar(500) NULL,
  [config_type] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数主键',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数键名',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_key'
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数键值',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统内置（Y是 N否）',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'config_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_config',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'参数配置表',
'SCHEMA', N'dbo',
'TABLE', N'sys_config'
GO


-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_config] ([config_id], [config_name], [config_key], [config_value], [config_type], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'主框架页-默认皮肤样式名称', N'sys.index.skinName', N'skin-blue', N'Y', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'), (N'2', N'用户管理-账号初始密码', N'sys.user.initPassword', N'123456', N'Y', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'初始化密码 123456'), (N'3', N'主框架页-侧边栏主题', N'sys.index.sideTheme', N'theme-dark', N'Y', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'深色主题theme-dark，浅色主题theme-light'), (N'5', N'账号自助-是否开启用户注册功能', N'sys.account.registerUser', N'true', N'Y', N'admin', N'2021-12-15 21:36:18', N'admin', N'2021-12-24 22:43:33', N'是否开启注册用户功能（true开启，false关闭）'), (N'6', N'账号自助-验证码开关', N'sys.account.captchaEnabled', N'true', N'Y', N'admin', N'2023-03-10 23:29:21', N'', NULL, N'是否开启验证码功能（true开启，false关闭）')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_dept]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_dept]
GO

CREATE TABLE [dbo].[sys_dept] (
  [dept_id] bigint NOT NULL,
  [parent_id] bigint NULL,
  [ancestors] nvarchar(50) NULL,
  [dept_name] nvarchar(30) NULL,
  [order_num] int NULL,
  [leader] nvarchar(20) NULL,
  [phone] nvarchar(11) NULL,
  [email] nvarchar(50) NULL,
  [status] nchar(1) NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门id',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'dept_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父部门id',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'祖级列表',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'ancestors'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'dept_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'order_num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'负责人',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'leader'
GO

EXEC sp_addextendedproperty
'MS_Description', N'联系电话',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'phone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'邮箱',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'email'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门表',
'SCHEMA', N'dbo',
'TABLE', N'sys_dept'
GO


-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_dept] ([dept_id], [parent_id], [ancestors], [dept_name], [order_num], [leader], [phone], [email], [status], [del_flag], [create_by], [create_time], [update_by], [update_time]) VALUES (N'100', N'0', N'0', N'蜂信物联', N'0', N'FastBee', N'15888888888', N'164770707@qq.com', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'admin', N'2023-02-26 23:06:24'), (N'101', N'100', N'0,100', N'北京总公司', N'1', N'物美', N'15888888888', N'164770707@qq.com', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'admin', N'2022-03-09 16:49:53'), (N'102', N'100', N'0,100', N'深圳分公司', N'2', N'物美', N'15888888888', N'164770707@qq.com', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'admin', N'2023-02-26 23:06:07'), (N'103', N'101', N'0,100,101', N'研发部门', N'1', N'物美', N'15888888888', N'164770707@qq.com', N'1', N'0', N'admin', N'2021-12-15 21:36:18', N'admin', N'2022-02-01 23:12:40'), (N'104', N'101', N'0,100,101', N'市场部门', N'2', N'物美', N'15888888888', N'164770707@qq.com', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL), (N'105', N'101', N'0,100,101', N'测试部门', N'3', N'物美', N'15888888888', N'164770707@qq.com', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL), (N'106', N'101', N'0,100,101', N'财务部门', N'4', N'物美', N'15888888888', N'164770707@qq.com', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL), (N'107', N'101', N'0,100,101', N'运维部门', N'5', N'物美', N'15888888888', N'164770707@qq.com', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL), (N'108', N'102', N'0,100,102', N'市场部门', N'1', N'物美', N'15888888888', N'164770707@qq.com', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL), (N'109', N'102', N'0,100,102', N'财务部门', N'2', N'物美', N'15888888888', N'164770707@qq.com', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_dict_data]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_dict_data]
GO

CREATE TABLE [dbo].[sys_dict_data] (
  [dict_code] bigint NOT NULL,
  [dict_sort] int NULL,
  [dict_label] nvarchar(100) NULL,
  [dict_value] nvarchar(100) NULL,
  [dict_type] nvarchar(100) NULL,
  [css_class] nvarchar(100) NULL,
  [list_class] nvarchar(100) NULL,
  [is_default] nchar(1) NULL,
  [status] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典编码',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典排序',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典标签',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_label'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典键值',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典类型',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'样式属性（其他样式扩展）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'css_class'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表格回显样式',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'list_class'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否默认（Y是 N否）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'is_default'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典数据表',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_data'
GO


-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'1', N'男', N'0', N'sys_user_sex', N'', N'', N'Y', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'性别男'), (N'2', N'2', N'女', N'1', N'sys_user_sex', N'', N'', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'性别女'), (N'3', N'3', N'未知', N'2', N'sys_user_sex', N'', N'', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'性别未知'), (N'4', N'1', N'显示', N'0', N'sys_show_hide', N'', N'primary', N'Y', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'显示菜单'), (N'5', N'2', N'隐藏', N'1', N'sys_show_hide', N'', N'danger', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'隐藏菜单'), (N'6', N'1', N'正常', N'0', N'sys_normal_disable', N'', N'primary', N'Y', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'正常状态'), (N'7', N'2', N'停用', N'1', N'sys_normal_disable', N'', N'danger', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'停用状态'), (N'8', N'1', N'正常', N'0', N'sys_job_status', N'', N'primary', N'Y', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'正常状态'), (N'9', N'2', N'暂停', N'1', N'sys_job_status', N'', N'danger', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'停用状态'), (N'10', N'1', N'默认', N'DEFAULT', N'sys_job_group', N'', N'', N'Y', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'默认分组'), (N'11', N'2', N'系统', N'SYSTEM', N'sys_job_group', N'', N'', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'系统分组'), (N'12', N'1', N'是', N'Y', N'sys_yes_no', N'', N'primary', N'Y', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'系统默认是'), (N'13', N'2', N'否', N'N', N'sys_yes_no', N'', N'danger', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'系统默认否'), (N'14', N'1', N'通知', N'1', N'sys_notice_type', N'', N'warning', N'Y', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'通知'), (N'15', N'2', N'公告', N'2', N'sys_notice_type', N'', N'success', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'公告'), (N'16', N'1', N'正常', N'0', N'sys_notice_status', N'', N'primary', N'Y', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'正常状态'), (N'17', N'2', N'关闭', N'1', N'sys_notice_status', N'', N'danger', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'关闭状态'), (N'18', N'1', N'新增', N'1', N'sys_oper_type', N'', N'info', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'新增操作'), (N'19', N'2', N'修改', N'2', N'sys_oper_type', N'', N'info', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'修改操作'), (N'20', N'3', N'删除', N'3', N'sys_oper_type', N'', N'danger', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'删除操作'), (N'21', N'4', N'授权', N'4', N'sys_oper_type', N'', N'primary', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'授权操作'), (N'22', N'5', N'导出', N'5', N'sys_oper_type', N'', N'warning', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'导出操作'), (N'23', N'6', N'导入', N'6', N'sys_oper_type', N'', N'warning', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'导入操作'), (N'24', N'7', N'强退', N'7', N'sys_oper_type', N'', N'danger', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'强退操作'), (N'25', N'8', N'生成代码', N'8', N'sys_oper_type', N'', N'warning', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'生成操作'), (N'26', N'9', N'清空数据', N'9', N'sys_oper_type', N'', N'danger', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'清空操作'), (N'27', N'1', N'成功', N'0', N'sys_common_status', N'', N'primary', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'正常状态'), (N'28', N'2', N'失败', N'1', N'sys_common_status', N'', N'danger', N'N', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'停用状态'), (N'100', N'1', N'属性', N'1', N'iot_things_type', N'', N'primary', N'Y', N'0', N'admin', N'2021-12-12 16:41:15', N'admin', N'2021-12-15 22:49:37', N''), (N'101', N'2', N'功能', N'2', N'iot_things_type', N'', N'success', N'Y', N'0', N'admin', N'2021-12-12 16:43:33', N'admin', N'2021-12-14 16:33:11', N''), (N'102', N'3', N'事件', N'3', N'iot_things_type', NULL, N'warning', N'Y', N'0', N'admin', N'2021-12-12 16:46:04', N'', NULL, NULL), (N'103', N'1', N'整数', N'integer', N'iot_data_type', N'', N'', N'Y', N'0', N'admin', N'2021-12-12 20:20:46', N'admin', N'2021-12-14 16:09:56', N''), (N'104', N'2', N'小数', N'decimal', N'iot_data_type', NULL, N'default', N'Y', N'0', N'admin', N'2021-12-12 20:21:21', N'admin', N'2021-12-15 22:51:07', NULL), (N'105', N'3', N'布尔', N'bool', N'iot_data_type', NULL, N'default', N'Y', N'0', N'admin', N'2021-12-12 20:22:12', N'admin', N'2021-12-15 22:51:02', NULL), (N'106', N'4', N'枚举', N'enum', N'iot_data_type', NULL, N'default', N'Y', N'0', N'admin', N'2021-12-12 20:22:37', N'admin', N'2021-12-15 22:50:57', NULL), (N'107', N'5', N'字符串', N'string', N'iot_data_type', NULL, N'default', N'Y', N'0', N'admin', N'2021-12-12 20:22:54', N'admin', N'2021-12-15 22:50:52', NULL), (N'108', N'1', N'是', N'1', N'iot_yes_no', N'', N'default', N'Y', N'0', N'admin', N'2021-12-12 20:25:14', N'admin', N'2022-01-02 13:39:09', N''), (N'109', N'2', N'否', N'0', N'iot_yes_no', N'', N'default', N'Y', N'0', N'admin', N'2021-12-12 20:25:25', N'admin', N'2022-01-02 13:39:15', N''), (N'110', N'6', N'数组', N'array', N'iot_data_type', NULL, N'default', N'Y', N'0', N'admin', N'2021-12-13 18:18:04', N'admin', N'2021-12-15 22:50:42', NULL), (N'111', N'1', N'未发布', N'1', N'iot_product_status', NULL, N'info', N'N', N'0', N'admin', N'2021-12-19 15:01:18', N'admin', N'2021-12-19 15:01:55', NULL), (N'112', N'2', N'已发布', N'2', N'iot_product_status', NULL, N'success', N'N', N'0', N'admin', N'2021-12-19 15:01:43', N'', NULL, NULL), (N'113', N'1', N'直连设备', N'1', N'iot_device_type', NULL, N'default', N'N', N'0', N'admin', N'2021-12-19 15:03:49', N'admin', N'2021-12-19 15:10:13', NULL), (N'114', N'2', N'网关设备', N'2', N'iot_device_type', NULL, N'default', N'N', N'0', N'admin', N'2021-12-19 15:04:28', N'admin', N'2023-02-09 16:25:46', NULL), (N'116', N'1', N'WIFI', N'1', N'iot_network_method', NULL, N'default', N'N', N'0', N'admin', N'2021-12-19 15:07:35', N'admin', N'2021-12-22 00:11:19', NULL), (N'117', N'2', N'蜂窝(2G/3G/4G/5G)', N'2', N'iot_network_method', NULL, N'default', N'N', N'0', N'admin', N'2021-12-19 15:08:30', N'admin', N'2022-01-14 02:12:27', NULL), (N'118', N'3', N'以太网', N'3', N'iot_network_method', NULL, N'default', N'N', N'0', N'admin', N'2021-12-19 15:09:08', N'admin', N'2022-01-14 02:12:39', NULL), (N'119', N'1', N'简单认证', N'1', N'iot_vertificate_method', NULL, N'default', N'N', N'0', N'admin', N'2021-12-19 15:13:16', N'admin', N'2022-06-05 00:14:48', NULL), (N'120', N'2', N'加密认证', N'2', N'iot_vertificate_method', NULL, N'default', N'N', N'0', N'admin', N'2021-12-19 15:13:26', N'admin', N'2022-06-05 00:14:57', NULL), (N'122', N'1', N'ESP8266/Arduino', N'1', N'iot_device_chip', NULL, N'default', N'N', N'0', N'admin', N'2021-12-24 15:54:52', N'admin', N'2021-12-24 16:07:31', NULL), (N'123', N'3', N'ESP32/Arduino', N'2', N'iot_device_chip', NULL, N'default', N'N', N'0', N'admin', N'2021-12-24 15:55:04', N'admin', N'2021-12-24 16:07:26', NULL), (N'124', N'2', N'ESP8266/RTOS', N'3', N'iot_device_chip', NULL, N'default', N'N', N'0', N'admin', N'2021-12-24 15:56:08', N'admin', N'2021-12-24 16:07:17', NULL), (N'127', N'4', N'ESP32/ESP-IDF', N'4', N'iot_device_chip', NULL, N'default', N'N', N'0', N'admin', N'2021-12-24 16:07:54', N'', NULL, NULL), (N'128', N'5', N'树莓派/Python', N'5', N'iot_device_chip', NULL, N'default', N'N', N'0', N'admin', N'2021-12-24 16:08:31', N'', NULL, NULL), (N'129', N'0', N'未激活', N'1', N'iot_device_status', NULL, N'warning', N'N', N'0', N'admin', N'2021-12-27 22:21:04', N'admin', N'2021-12-27 22:22:09', NULL), (N'130', N'0', N'禁用', N'2', N'iot_device_status', NULL, N'danger', N'N', N'0', N'admin', N'2021-12-27 22:21:22', N'', NULL, NULL), (N'131', N'0', N'在线', N'3', N'iot_device_status', NULL, N'success', N'N', N'0', N'admin', N'2021-12-27 22:21:42', N'', NULL, NULL), (N'132', N'0', N'离线', N'4', N'iot_device_status', NULL, N'info', N'N', N'0', N'admin', N'2021-12-27 22:22:01', N'', NULL, NULL), (N'133', N'0', N'启用', N'1', N'iot_is_enable', NULL, N'success', N'N', N'0', N'admin', N'2022-01-12 23:25:08', N'admin', N'2022-01-12 23:25:30', NULL), (N'134', N'0', N'禁用', N'0', N'iot_is_enable', NULL, N'info', N'N', N'0', N'admin', N'2022-01-12 23:25:19', N'admin', N'2022-01-12 23:25:38', NULL), (N'135', N'0', N'提醒通知', N'1', N'iot_alert_level', NULL, N'success', N'N', N'0', N'admin', N'2022-01-13 14:58:10', N'admin', N'2022-01-13 14:58:31', NULL), (N'136', N'0', N'轻微问题', N'2', N'iot_alert_level', NULL, N'warning', N'N', N'0', N'admin', N'2022-01-13 14:59:00', N'', NULL, NULL), (N'137', N'0', N'严重警告', N'3', N'iot_alert_level', NULL, N'danger', N'N', N'0', N'admin', N'2022-01-13 14:59:16', N'', NULL, NULL), (N'138', N'0', N'不需要处理', N'1', N'iot_process_status', NULL, N'default', N'N', N'0', N'admin', N'2022-01-13 15:06:03', N'', NULL, NULL), (N'139', N'0', N'未处理', N'2', N'iot_process_status', NULL, N'default', N'N', N'0', N'admin', N'2022-01-13 15:06:14', N'', NULL, NULL), (N'140', N'0', N'已处理', N'3', N'iot_process_status', NULL, N'default', N'N', N'0', N'admin', N'2022-01-13 15:06:24', N'', NULL, NULL), (N'141', N'1', N'属性上报', N'1', N'iot_device_log_type', NULL, N'primary', N'N', N'0', N'admin', N'2022-01-13 15:10:32', N'admin', N'2022-03-13 00:20:25', NULL), (N'142', N'3', N'事件上报', N'3', N'iot_device_log_type', NULL, N'danger', N'N', N'0', N'admin', N'2022-01-13 15:10:43', N'admin', N'2022-03-13 00:21:00', NULL), (N'143', N'2', N'功能调用', N'2', N'iot_device_log_type', NULL, N'warning', N'N', N'0', N'admin', N'2022-01-13 15:10:55', N'admin', N'2022-03-13 00:20:32', NULL), (N'144', N'4', N'设备升级', N'4', N'iot_device_log_type', NULL, N'success', N'N', N'0', N'admin', N'2022-01-13 15:11:08', N'admin', N'2022-03-13 00:21:06', NULL), (N'145', N'5', N'设备上线', N'5', N'iot_device_log_type', NULL, N'success', N'N', N'0', N'admin', N'2022-01-13 15:11:23', N'admin', N'2022-03-13 00:21:26', NULL), (N'146', N'6', N'设备离线', N'6', N'iot_device_log_type', NULL, N'info', N'N', N'0', N'admin', N'2022-01-13 15:11:32', N'admin', N'2022-03-13 00:21:13', NULL), (N'147', N'4', N'其他', N'4', N'iot_network_method', NULL, N'default', N'N', N'0', N'admin', N'2022-01-14 02:12:49', N'admin', N'2022-01-14 02:13:03', NULL), (N'148', N'6', N'安卓/Android', N'6', N'iot_device_chip', NULL, N'default', N'N', N'0', N'admin', N'2022-01-16 12:39:27', N'', NULL, NULL), (N'149', N'7', N'其他', N'7', N'iot_device_chip', NULL, N'default', N'N', N'0', N'admin', N'2022-01-16 12:39:55', N'admin', N'2022-01-16 12:40:13', NULL), (N'150', N'1', N'小度平台', N'1', N'oauth_platform', NULL, N'primary', N'N', N'0', N'admin', N'2022-02-07 20:29:23', N'admin', N'2022-02-07 22:24:28', NULL), (N'151', N'2', N'天猫精灵', N'2', N'oauth_platform', NULL, N'danger', N'N', N'0', N'admin', N'2022-02-07 20:29:41', N'admin', N'2022-02-07 22:23:14', NULL), (N'152', N'3', N'小米小爱', N'3', N'oauth_platform', NULL, N'success', N'N', N'0', N'admin', N'2022-02-07 20:30:07', N'admin', N'2022-02-07 22:23:24', NULL), (N'153', N'4', N'其他平台', N'4', N'oauth_platform', NULL, N'warning', N'N', N'0', N'admin', N'2022-02-07 22:23:52', N'admin', N'2022-02-07 22:24:02', NULL), (N'154', N'1', N'微信登录', N'WECHAT', N'iot_social_platform', NULL, N'default', N'N', N'0', N'admin', N'2022-04-20 16:41:33', N'admin', N'2023-09-22 10:27:54', NULL), (N'155', N'2', N'QQ登录', N'QQ', N'iot_social_platform', NULL, N'default', N'N', N'0', N'admin', N'2022-04-20 16:42:46', N'admin', N'2023-09-22 10:28:03', NULL), (N'156', N'0', N'启用', N'0', N'iot_social_platform_status', NULL, N'success', N'N', N'0', N'admin', N'2022-04-20 17:02:48', N'admin', N'2022-05-12 17:39:40', N'启用'), (N'157', N'1', N'未启用', N'1', N'iot_social_platform_status', NULL, N'info', N'N', N'0', N'admin', N'2022-04-20 17:03:15', N'admin', N'2022-05-21 13:44:13', N'禁用'), (N'158', N'3', N'支付宝', N'ALIPAY', N'iot_social_platform', NULL, N'default', N'N', N'0', N'admin', N'2022-05-12 17:49:24', N'admin', N'2022-05-12 17:50:21', NULL), (N'159', N'1', N'自动定位', N'1', N'iot_location_way', NULL, N'success', N'N', N'0', N'admin', N'2022-05-21 13:46:51', N'admin', N'2022-05-21 13:53:23', N'IP定位，精确到城市'), (N'160', N'2', N'设备定位', N'2', N'iot_location_way', NULL, N'warning', N'N', N'0', N'admin', N'2022-05-21 13:46:51', N'admin', N'2022-05-21 13:49:21', N'最精确定位'), (N'161', N'3', N'自定义位置', N'3', N'iot_location_way', NULL, N'primary', N'N', N'0', N'admin', N'2022-05-21 13:48:50', N'admin', N'2022-05-21 13:55:45', N'位置自定义'), (N'162', N'3', N'简单+加密', N'3', N'iot_vertificate_method', NULL, N'default', N'N', N'0', N'admin', N'2022-06-05 00:15:46', N'', NULL, NULL), (N'163', N'1', N'未使用', N'1', N'iot_auth_status', NULL, N'info', N'N', N'0', N'admin', N'2022-06-07 17:39:22', N'admin', N'2022-06-07 17:40:10', NULL), (N'164', N'2', N'已使用', N'2', N'iot_auth_status', NULL, N'success', N'N', N'0', N'admin', N'2022-06-07 17:40:01', N'admin', N'2022-06-07 23:21:49', NULL), (N'165', N'7', N'对象', N'object', N'iot_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-09 16:20:57', N'admin', N'2023-02-09 16:21:08', NULL), (N'166', N'3', N'监控设备', N'3', N'iot_device_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-09 16:26:00', N'', NULL, NULL), (N'169', N'0', N'DVR', N'111', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:07:06', N'', NULL, NULL), (N'170', N'1', N'NVR', N'118', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:07:59', N'', NULL, NULL), (N'171', N'2', N'报警控制器', N'117', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:08:13', N'admin', N'2023-02-22 01:08:35', NULL), (N'172', N'4', N'摄像机', N'131', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:08:52', N'', NULL, NULL), (N'173', N'5', N'IPC', N'132', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:09:11', N'', NULL, NULL), (N'174', N'6', N'显示器', N'133', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:09:30', N'', NULL, NULL), (N'175', N'7', N'报警输入设备', N'134', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:09:49', N'', NULL, NULL), (N'176', N'8', N'报警输出设备', N'135', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:10:08', N'', NULL, NULL), (N'177', N'9', N'语音输入设备', N'136', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:10:29', N'', NULL, NULL)
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'178', N'10', N'语音输出设备', N'137', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:10:46', N'admin', N'2023-02-22 01:10:51', NULL), (N'179', N'11', N'移动传输设备', N'138', N'video_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:11:09', N'', NULL, NULL), (N'180', N'0', N'报警控制器', N'117', N'channel_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:12:09', N'', NULL, NULL), (N'181', N'1', N'摄像机', N'131', N'channel_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:12:24', N'', NULL, NULL), (N'182', N'2', N'IPC', N'132', N'channel_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:12:39', N'', NULL, NULL), (N'183', N'3', N'显示器', N'133', N'channel_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:12:57', N'', NULL, NULL), (N'184', N'5', N'报警输入设备', N'134', N'channel_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:13:14', N'', NULL, NULL), (N'185', N'6', N'报警输出设备', N'135', N'channel_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:13:29', N'admin', N'2023-02-22 01:13:49', NULL), (N'186', N'7', N'语音输入设备', N'136', N'channel_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:14:14', N'admin', N'2023-02-22 01:14:24', NULL), (N'187', N'8', N'语音输出设备', N'137', N'channel_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:14:50', N'', NULL, NULL), (N'188', N'9', N'移动传输设备', N'138', N'channel_type', NULL, N'default', N'N', N'0', N'admin', N'2023-02-22 01:15:11', N'', NULL, NULL), (N'198', N'0', N'MQTT', N'MQTT', N'iot_transport_type', NULL, N'primary', N'N', N'0', N'admin', N'2023-02-28 16:35:40', N'admin', N'2025-03-19 16:23:48', NULL), (N'230', N'99', N'其他', N'0', N'sys_oper_type', N'', N'info', N'N', N'0', N'admin', N'2023-03-10 23:28:32', N'', NULL, N'其他操作'), (N'231', N'0', N'事件上报', N'3', N'iot_event_type', NULL, N'danger', N'N', N'0', N'admin', N'2023-03-29 00:25:28', N'', NULL, NULL), (N'232', N'0', N'设备上线', N'5', N'iot_event_type', NULL, N'success', N'N', N'0', N'admin', N'2023-03-29 00:25:52', N'', NULL, NULL), (N'233', N'0', N'设备离线', N'6', N'iot_event_type', NULL, N'info', N'N', N'0', N'admin', N'2023-03-29 00:26:09', N'', NULL, NULL), (N'234', N'0', N'服务下发', N'1', N'iot_function_type', NULL, N'primary', N'N', N'0', N'admin', N'2023-03-29 00:38:26', N'', NULL, NULL), (N'235', N'0', N'属性获取', N'2', N'iot_function_type', NULL, N'success', N'N', N'0', N'admin', N'2023-03-29 00:38:44', N'', NULL, NULL), (N'237', N'0', N'读写', N'0', N'iot_data_read_write', NULL, N'primary', N'N', N'0', N'admin', N'2023-04-09 02:12:05', N'', NULL, NULL), (N'238', N'0', N'只读', N'1', N'iot_data_read_write', NULL, N'info', N'N', N'0', N'admin', N'2023-04-09 02:12:19', N'', NULL, NULL), (N'239', N'0', N'全部设备', N'1', N'oat_update_limit', NULL, N'default', N'N', N'0', N'admin', N'2023-04-09 23:57:06', N'admin', N'2023-04-11 11:53:57', NULL), (N'240', N'1', N'指定设备', N'2', N'oat_update_limit', NULL, N'default', N'N', N'0', N'admin', N'2023-04-11 11:53:28', N'admin', N'2023-04-11 11:53:52', NULL), (N'241', N'4', N'GB28181', N'GB28181', N'iot_transport_type', NULL, N'success', N'N', N'0', N'admin', N'2023-05-12 14:25:39', N'admin', N'2025-03-19 16:24:12', NULL), (N'242', N'1', N'02(读离散量输入)', N'2', N'iot_modbus_status_code', NULL, N'default', N'N', N'0', N'admin', N'2023-07-03 10:16:48', N'admin', N'2023-07-03 10:17:35', NULL), (N'243', N'3', N'04(读输入寄存器)', N'4', N'iot_modbus_status_code', NULL, N'default', N'N', N'0', N'admin', N'2023-07-03 10:17:18', N'admin', N'2023-07-03 10:17:58', NULL), (N'247', N'4', N'微信开放平台网站应用', N'wechat_open_web', N'iot_social_platform', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'248', N'5', N'微信开放平台移动应用', N'wechat_open_mobile', N'iot_social_platform', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:29:14', N'', NULL, NULL), (N'249', N'6', N'微信开放平台小程序', N'wechat_open_mini_program', N'iot_social_platform', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:38:12', N'', NULL, NULL), (N'250', N'0', N'16位 无符号', N'ushort', N'iot_modbus_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-04 14:11:54', N'', NULL, NULL), (N'251', N'1', N'16位 有符号', N'short', N'iot_modbus_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-04 14:12:26', N'', NULL, NULL), (N'252', N'2', N'32位 有符号(ABCD)', N'long-ABCD', N'iot_modbus_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-04 14:12:53', N'', NULL, NULL), (N'253', N'3', N'32位 有符号(CDAB)', N'long-CDAB', N'iot_modbus_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-04 14:13:21', N'', NULL, NULL), (N'254', N'4', N'32位 无符号(ABCD)', N'ulong-ABCD', N'iot_modbus_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-04 14:13:42', N'', NULL, NULL), (N'255', N'5', N'32位 无符号(CDAB)', N'ulong-CDAB', N'iot_modbus_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-04 14:14:06', N'', NULL, NULL), (N'256', N'6', N'32位 浮点数(ABCD)', N'float-ABCD', N'iot_modbus_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-04 14:14:28', N'', NULL, NULL), (N'257', N'7', N'32位 浮点数(CDAB)', N'float-CDAB', N'iot_modbus_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-04 14:14:50', N'', NULL, NULL), (N'258', N'8', N'位', N'bit', N'iot_modbus_data_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-04 14:15:13', N'', NULL, NULL), (N'259', N'0', N'电灯', N'LIGHT', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'260', N'0', N'空调', N'AIR_CONDITION', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'261', N'0', N'窗帘', N'CURTAIN', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'262', N'0', N'窗纱', N'CURT_SIMP', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'263', N'0', N'插座', N'SOCKET', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'264', N'0', N'开关', N'SWITCH', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'265', N'0', N'冰箱', N'FRIDGE', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'266', N'0', N'净水器', N'WATER_PURIFIER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'267', N'0', N'加湿器', N'HUMIDIFIER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'268', N'0', N'除湿器', N'DEHUMIDIFIER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'269', N'0', N'电磁炉', N'INDUCTION_COOKER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'270', N'0', N'空气净化器', N'AIR_PURIFIER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'271', N'0', N'洗衣机', N'WASHING_MACHINE', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'272', N'0', N'热水器', N'WATER_HEATER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'273', N'0', N'燃气灶', N'GAS_STOVE', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'274', N'0', N'电视机', N'TV_SET', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'275', N'0', N'网络盒子', N'OTT_BOX', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'276', N'0', N'油烟机', N'RANGE_HOOD', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'277', N'0', N'电风扇', N'FAN', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'278', N'0', N'投影仪', N'PROJECTOR', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'279', N'0', N'扫地机器人', N'SWEEPING_ROBOT', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'280', N'0', N'热水壶', N'KETTLE', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'281', N'0', N'微波炉', N'MICROWAVE_OVEN', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'282', N'0', N'压力锅', N'PRESSURE_COOKER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'283', N'0', N'电饭煲', N'RICE_COOKER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'284', N'0', N'破壁机', N'HIGH_SPEED_BLENDER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'285', N'0', N'新风机', N'AIR_FRESHER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'286', N'0', N'晾衣架', N'CLOTHES_RACK', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'287', N'0', N'烤箱设备', N'OVEN', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'288', N'0', N'蒸烤箱', N'STEAM_OVEN', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'289', N'0', N'蒸箱', N'STEAM_BOX', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'290', N'0', N'电暖器', N'HEATER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'291', N'0', N'开窗器', N'WINDOW_OPENER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'292', N'0', N'摄像头', N'WEBCAM', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'293', N'0', N'相机', N'CAMERA', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'294', N'0', N'机器人', N'ROBOT', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'295', N'0', N'打印机', N'PRINTER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'296', N'0', N'饮水机', N'WATER_COOLER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'297', N'0', N'鱼缸', N'FISH_TANK', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'298', N'0', N'浇花器', N'WATERING_DEVICE', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'299', N'0', N'机顶盒', N'SET_TOP_BOX', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'300', N'0', N'香薰机', N'AROMATHERAPY_MACHINE', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'301', N'0', N'DVD', N'DVD', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'302', N'0', N'鞋柜', N'SHOE_CABINET', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'303', N'0', N'走步机', N'WALKING_MACHINE', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'304', N'0', N'跑步机', N'TREADMILL', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'305', N'0', N'床', N'BED', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'306', N'0', N'浴霸', N'YUBA', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'307', N'0', N'花洒', N'SHOWER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'308', N'0', N'浴缸', N'BATHTUB', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'309', N'0', N'消毒柜', N'DISINFECTION_CABINET', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'310', N'0', N'洗碗机', N'DISHWASHER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'311', N'0', N'沙发品类', N'SOFA', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'312', N'0', N'门铃', N'DOOR_BELL', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'313', N'0', N'电梯', N'ELEVATOR', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'314', N'0', N'体重秤', N'WEIGHT_SCALE', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'315', N'0', N'体脂秤', N'BODY_FAT_SCALE', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'316', N'0', N'壁挂炉', N'WALL_HUNG_GAS_BOILER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, NULL), (N'317', N'0', N'特定设备的组合场景', N'SCENE_TRIGGER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, N'描述特定设备的组合场景，设备之间没有相互关联，无特定操作顺序。 例如“打开睡眠模式”包括关灯和锁上房门，但是关灯和锁上房门之间没有必然联系，可以先关灯然后锁上房门，也可以先锁上房门后关灯'), (N'318', N'0', N'特定设备的组合场景', N'ACTIVITY_TRIGGER', N'dueros_related_device', NULL, N'default', N'N', N'0', N'admin', N'2023-08-23 11:28:15', N'', NULL, N'描述特定设备的组合场景。场景中的设备必须以指定顺序操作。如“观看优酷视频”场景中必须先打开电视机，然后打开HDMI1'), (N'319', N'0', N'打开', N'turnOn', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'320', N'0', N'关闭', N'turnOff', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'321', N'0', N'定时打开', N'timingTurnOn', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL)
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'322', N'0', N'定时关闭', N'timingTurnOff', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'323', N'0', N'暂停', N'pause', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'324', N'0', N'继续', N'continue', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'325', N'0', N'设置颜色', N'setColor', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'326', N'0', N'设置灯光色温', N'setColorTemperature', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'327', N'0', N'增高灯光色温', N'incrementColorTemperature', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'328', N'0', N'降低灯光色温', N'decrementColorTemperature', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'329', N'0', N'设置灯光亮度', N'setBrightnessPercentage', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'330', N'0', N'调亮灯光', N'incrementBrightnessPercentage', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'331', N'0', N'调暗灯光', N'decrementBrightnessPercentage', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'332', N'0', N'设置功率', N'setPower', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'333', N'0', N'增大功率', N'incrementPower', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'334', N'0', N'减小功率', N'decrementPower', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'335', N'0', N'升高温度', N'incrementTemperature', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'336', N'0', N'降低温度', N'decrementTemperature', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'337', N'0', N'设置温度', N'setTemperature', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'338', N'0', N'增加风速', N'incrementFanSpeed', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'339', N'0', N'减小风速', N'decrementFanSpeed', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'340', N'0', N'设置风速', N'setFanSpeed', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'341', N'0', N'设置档位', N'setGear', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'342', N'0', N'设置模式', N'setMode', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'343', N'0', N'取消设置的模式', N'unSetMode', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'344', N'0', N'定时设置模式', N'timingSetMode', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'345', N'0', N'定时取消设置的模式', N'timingUnsetMode', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'346', N'0', N'调高音量', N'incrementVolume', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'347', N'0', N'调低音量', N'decrementVolume', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'348', N'0', N'设置音量', N'setVolume', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'349', N'0', N'设置静音状态', N'setVolumeMute', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'350', N'0', N'上一个频道', N'decrementTVChannel', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'351', N'0', N'下一个频道', N'incrementTVChannel', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'352', N'0', N'设置频道', N'setTVChannel', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'353', N'0', N'返回上个频道', N'returnTVChannel', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'354', N'0', N'开始充电', N'chargeTurnOn', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'355', N'0', N'停止充电', N'chargeTurnOff', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'356', N'0', N'查询开关状态', N'getTurnOnState', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'357', N'0', N'查询油量', N'getOilCapacity', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'358', N'0', N'查询电量', N'getElectricityCapacity', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'359', N'0', N'上锁/解锁', N'setLockState', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'360', N'0', N'查询锁状态', N'getLockState', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'361', N'0', N'设置吸力', N'setSuction', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'362', N'0', N'设置水量', N'setWaterLevel', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'363', N'0', N'设置清扫位置', N'setCleaningLocation', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'364', N'0', N'执行自定义复杂动作', N'setComplexActions', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'365', N'0', N'设置移动方向', N'setDirection', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'366', N'0', N'打印', N'submitPrint', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'367', N'0', N'查询PM2.5', N'getAirPM25', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'368', N'0', N'查询PM10', N'getAirPM10', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'369', N'0', N'查询二氧化碳含量', N'getCO2Quantity', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'370', N'0', N'查询空气质量', N'getAirQualityIndex', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'371', N'0', N'查询温度（当前温度和目标温度）', N'getTemperature', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'372', N'0', N'查询当前温度', N'getTemperatureReading', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'373', N'0', N'查询目标温度', N'getTargetTemperature', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'374', N'0', N'查询湿度', N'getHumidity', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'375', N'0', N'查询目标湿度', N'getTargetHumidity', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'376', N'0', N'查询水质', N'getWaterQuality', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'377', N'0', N'查询设备所有状态', N'getState', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'378', N'0', N'查询剩余时间', N'getTimeLeft', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'379', N'0', N'查询运行状态', N'getRunningStatus', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'380', N'0', N'查询运行时间', N'getRunningTime', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'381', N'0', N'查询设备所在位置', N'getLocation', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'382', N'0', N'设备定时', N'setTimer', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'383', N'0', N'取消设备定时', N'timingCancel', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'384', N'0', N'设备复位', N'reset', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'385', N'0', N'升高高度', N'incrementHeight', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'386', N'0', N'降低高度', N'decrementHeight', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'387', N'0', N'设置摆风角度', N'setSwingAngle', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'388', N'0', N'查询风速', N'getFanSpeed', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'389', N'0', N'设置湿度模式', N'setHumidity', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'390', N'0', N'增大湿度', N'incrementHumidity', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'391', N'0', N'降低湿度', N'decrementHumidity', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'392', N'0', N'增大雾量', N'incrementMist', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'393', N'0', N'见效雾量', N'decrementMist', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'394', N'0', N'设置雾量', N'setMist', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'395', N'0', N'设备启动', N'startUp', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'396', N'0', N'设置电梯楼层', N'setFloor', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'397', N'0', N'电梯按下', N'decrementFloor', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'398', N'0', N'电梯按上', N'incrementFloor', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'399', N'0', N'增加速度', N'incrementSpeed', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'400', N'0', N'降低速度', N'decrementSpeed', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'401', N'0', N'设置速度', N'setSpeed', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'402', N'0', N'获取速度', N'getSpeed', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'403', N'0', N'获取跑步信息', N'getMotionInfo', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'404', N'0', N'打开灶眼', N'turnOnBurner', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'405', N'0', N'关闭灶眼', N'turnOffBurner', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'406', N'0', N'定时打开灶眼', N'timingTurnOnBurner', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'407', N'0', N'定时关闭灶眼', N'timingTurnOffBurner', N'dueros_operate_type', NULL, N'default', N'N', N'0', N'admin', N'2023-09-22 10:35:15', N'', NULL, NULL), (N'408', N'7', N'微信开放平台网站应用个人中心绑定', N'wechat_open_web_bind', N'iot_social_platform', NULL, N'default', N'N', N'0', N'admin', N'2023-10-09 11:28:15', N'', NULL, NULL), (N'749', N'1', N'Java脚本引擎', N'java', N'rule_script_language', NULL, N'default', N'N', N'0', N'admin', N'2023-11-04 01:51:09', N'admin', N'2023-11-04 01:51:42', NULL), (N'750', N'2', N'JavaScript脚本引擎', N'js', N'rule_script_language', NULL, N'default', N'N', N'0', N'admin', N'2023-11-04 01:51:36', N'admin', N'2023-11-05 10:28:30', NULL), (N'751', N'1', N'普通脚本节点', N'script', N'rule_script_type', NULL, N'default', N'N', N'0', N'admin', N'2023-11-04 01:53:11', N'', NULL, NULL), (N'752', N'2', N'选择脚本节点 (switch)', N'switch_script', N'rule_script_type', NULL, N'default', N'N', N'0', N'admin', N'2023-11-04 01:53:32', N'admin', N'2023-11-04 01:56:44', NULL), (N'753', N'3', N'条件脚本节点 (if)', N'if_script', N'rule_script_type', NULL, N'default', N'N', N'0', N'admin', N'2023-11-04 01:53:48', N'admin', N'2023-11-04 01:56:55', NULL), (N'754', N'4', N'数量循环节点 (for)', N'for_script', N'rule_script_type', NULL, N'default', N'N', N'0', N'admin', N'2023-11-04 01:54:11', N'admin', N'2023-11-04 01:57:07', NULL), (N'755', N'5', N'条件循环节点 (while)', N'while_script', N'rule_script_type', NULL, N'default', N'N', N'0', N'admin', N'2023-11-04 01:54:30', N'admin', N'2023-11-04 01:57:16', NULL), (N'756', N'6', N'退出循环节点 (break)', N'break_script', N'rule_script_type', NULL, N'default', N'N', N'0', N'admin', N'2023-11-04 01:54:50', N'admin', N'2023-11-04 01:57:29', NULL), (N'757', N'3', N'groovy脚本引擎', N'groovy', N'rule_script_language', NULL, N'default', N'N', N'0', N'admin', N'2023-11-05 10:29:14', N'', NULL, NULL), (N'767', N'1', N'设备上报', N'1', N'rule_script_event', NULL, N'primary', N'N', N'0', N'admin', N'2023-12-19 11:40:34', N'admin', N'2023-12-20 02:23:43', NULL), (N'768', N'2', N'平台下发', N'2', N'rule_script_event', NULL, N'warning', N'N', N'0', N'admin', N'2023-12-19 11:40:46', N'admin', N'2023-12-20 02:23:51', NULL), (N'769', N'3', N'设备上线', N'3', N'rule_script_event', NULL, N'success', N'N', N'0', N'admin', N'2023-12-19 11:40:58', N'admin', N'2023-12-20 02:24:00', NULL), (N'770', N'4', N'设备离线', N'4', N'rule_script_event', NULL, N'info', N'N', N'0', N'admin', N'2023-12-19 11:41:09', N'admin', N'2023-12-20 02:24:08', NULL)
GO

INSERT INTO [dbo].[sys_dict_data] ([dict_code], [dict_sort], [dict_label], [dict_value], [dict_type], [css_class], [list_class], [is_default], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'771', N'1', N'数据流', N'1', N'rule_script_purpose', NULL, N'default', N'N', N'0', N'admin', N'2023-12-19 11:41:39', N'', NULL, NULL), (N'772', N'2', N'触发器', N'2', N'rule_script_purpose', NULL, N'default', N'N', N'0', N'admin', N'2023-12-19 11:41:48', N'', NULL, NULL), (N'773', N'3', N'执行动作', N'3', N'rule_script_purpose', NULL, N'default', N'N', N'0', N'admin', N'2023-12-19 11:41:59', N'', NULL, NULL), (N'774', N'1', N'消息重发', N'1', N'rule_script_action', NULL, N'default', N'N', N'0', N'admin', N'2023-12-19 11:42:26', N'', NULL, NULL), (N'775', N'2', N'消息通知', N'2', N'rule_script_action', NULL, N'default', N'N', N'0', N'admin', N'2023-12-19 11:43:18', N'admin', N'2023-12-19 11:43:38', NULL), (N'776', N'3', N'Http推送', N'3', N'rule_script_action', NULL, N'default', N'N', N'0', N'admin', N'2023-12-19 11:43:33', N'', NULL, NULL), (N'777', N'4', N'Mqtt桥接', N'4', N'rule_script_action', NULL, N'default', N'N', N'0', N'admin', N'2023-12-19 11:43:54', N'', NULL, NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_dict_type]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_dict_type]
GO

CREATE TABLE [dbo].[sys_dict_type] (
  [dict_id] bigint NOT NULL,
  [dict_name] nvarchar(100) NULL,
  [dict_type] nvarchar(100) NULL,
  [status] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典主键',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'dict_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'dict_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典类型',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典类型表',
'SCHEMA', N'dbo',
'TABLE', N'sys_dict_type'
GO


-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_dict_type] ([dict_id], [dict_name], [dict_type], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'用户性别', N'sys_user_sex', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'用户性别列表'), (N'2', N'菜单状态', N'sys_show_hide', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'菜单状态列表'), (N'3', N'系统开关', N'sys_normal_disable', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'系统开关列表'), (N'4', N'任务状态', N'sys_job_status', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'任务状态列表'), (N'5', N'任务分组', N'sys_job_group', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'任务分组列表'), (N'6', N'系统是否', N'sys_yes_no', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'系统是否列表'), (N'7', N'通知类型', N'sys_notice_type', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'通知类型列表'), (N'8', N'通知状态', N'sys_notice_status', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'通知状态列表'), (N'9', N'操作类型', N'sys_oper_type', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'操作类型列表'), (N'10', N'系统状态', N'sys_common_status', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'登录状态列表'), (N'100', N'物模型类别', N'iot_things_type', N'0', N'admin', N'2021-12-12 16:39:47', N'admin', N'2021-12-15 22:49:19', N'属性、动作、事件'), (N'101', N'数据类型', N'iot_data_type', N'0', N'admin', N'2021-12-12 20:16:48', N'admin', N'2021-12-12 20:17:54', N'integer、decimal、bool、string、enum'), (N'102', N'是否', N'iot_yes_no', N'0', N'admin', N'2021-12-12 20:24:51', N'admin', N'2021-12-19 15:12:35', N'是、否'), (N'103', N'产品状态', N'iot_product_status', N'0', N'admin', N'2021-12-19 15:00:13', N'', NULL, N'未发布、已发布（不能修改）'), (N'104', N'设备类型', N'iot_device_type', N'0', N'admin', N'2021-12-19 15:03:06', N'', NULL, N'直连设备、网关子设备、网关设备'), (N'105', N'联网方式', N'iot_network_method', N'0', N'admin', N'2021-12-19 15:07:12', N'admin', N'2022-01-14 02:11:58', N'wifi、蜂窝(2G/3G/4G/5G)、以太网、其他'), (N'106', N'认证方式', N'iot_vertificate_method', N'0', N'admin', N'2021-12-19 15:11:48', N'admin', N'2022-06-05 12:57:02', N'1=简单认证、2=加密认证、3=简单+加密'), (N'107', N'设备芯片', N'iot_device_chip', N'0', N'admin', N'2021-12-24 15:53:27', N'admin', N'2022-01-22 00:14:23', N'ESP8266、ESP32、树莓派'), (N'109', N'设备状态', N'iot_device_status', N'0', N'admin', N'2021-12-27 22:19:55', N'admin', N'2021-12-27 22:20:13', N'未激活、禁用、在线、离线'), (N'110', N'是否启用', N'iot_is_enable', N'0', N'admin', N'2022-01-12 23:24:01', N'admin', N'2022-01-12 23:24:15', N'启用、禁用'), (N'111', N'告警类型', N'iot_alert_level', N'0', N'admin', N'2022-01-13 14:56:44', N'admin', N'2022-01-13 15:04:46', N'1=提醒通知，2=轻微问题，3=严重警告'), (N'112', N'处理状态', N'iot_process_status', N'0', N'admin', N'2022-01-13 15:04:06', N'admin', N'2022-01-13 15:06:39', N'1=不需要处理,2=未处理,3=已处理'), (N'113', N'设备日志类型', N'iot_device_log_type', N'0', N'admin', N'2022-01-13 15:09:49', N'admin', N'2022-03-13 00:22:43', N'1=属性上报，2=调用功能,3=事件上报，4=设备升级，5=设备上线，6=设备离线'), (N'114', N'Oauth开放平台', N'oauth_platform', N'0', N'admin', N'2022-02-07 20:27:48', N'admin', N'2022-05-21 13:44:50', N'1=小度，2=天猫精灵，3=小爱，4=其他'), (N'115', N'第三方登录平台', N'iot_social_platform', N'0', N'admin', N'2022-04-12 15:28:13', N'admin', N'2022-04-12 15:37:48', N'Wechat、QQ、'), (N'116', N'第三方登录平台状态', N'iot_social_platform_status', N'0', N'admin', N'2022-04-20 17:02:13', N'admin', N'2022-04-20 17:02:23', N'第三方登录平台状态'), (N'117', N'设备定位方式', N'iot_location_way', N'0', N'admin', N'2022-05-21 13:45:16', N'admin', N'2022-05-21 13:46:06', N'1=IP自动定位，2=设备定位，3=自定义'), (N'118', N'授权码状态', N'iot_auth_status', N'0', N'admin', N'2022-06-07 17:38:56', N'', NULL, N'1=未分配，2=使用中'), (N'119', N'SipID状态', N'sip_gen_status', N'0', N'admin', N'2023-02-19 15:43:36', N'admin', N'2023-02-19 15:45:54', N'1=未使用，2=使用中'), (N'120', N'监控设备类型', N'video_type', N'0', N'admin', N'2023-02-22 01:06:38', N'', NULL, NULL), (N'121', N'通道类型', N'channel_type', N'0', N'admin', N'2023-02-22 01:11:51', N'', NULL, NULL), (N'122', N'轮询方式', N'data_collect_type', N'0', N'admin', N'2023-02-28 13:55:45', N'', NULL, NULL), (N'123', N'批量采集时间', N'iot_modbus_poll_time', N'0', N'admin', N'2023-02-28 14:38:21', N'', NULL, NULL), (N'124', N'寄存器功能码', N'iot_modbus_status_code', N'0', N'admin', N'2023-02-28 15:19:02', N'', NULL, NULL), (N'125', N'传输协议类型', N'iot_transport_type', N'0', N'admin', N'2023-02-28 16:35:20', N'', NULL, NULL), (N'126', N'设备事件类型', N'iot_event_type', N'0', N'admin', N'2023-03-29 00:24:51', N'', NULL, NULL), (N'127', N'指令下发类型', N'iot_function_type', N'0', N'admin', N'2023-03-29 00:37:51', N'', NULL, NULL), (N'128', N'读写类型', N'iot_data_read_write', N'0', N'admin', N'2023-04-09 02:11:14', N'', NULL, NULL), (N'129', N'升级范围', N'oat_update_limit', N'0', N'admin', N'2023-04-09 23:51:45', N'', NULL, NULL), (N'130', N'云存储平台类型', N'oss_platform_type', N'0', N'admin', N'2023-04-12 00:26:09', N'', NULL, NULL), (N'131', N'modbus数据类型', N'iot_modbus_data_type', N'0', N'admin', N'2023-09-04 13:54:17', N'', NULL, NULL), (N'132', N'小度音箱关联设备', N'dueros_related_device', N'0', N'admin', N'2023-09-22 09:45:15', N'admin', N'2023-09-22 09:45:15', N'小度音箱支持的设备、场景类型，在设备下配置关联'), (N'133', N'小度音箱操作类型', N'dueros_operate_type', N'0', N'admin', N'2023-09-22 09:45:15', N'admin', N'2023-09-22 09:45:15', N'小度音箱智能家居设备操作类型，在产品物模型下配置'), (N'198', N'规则脚本类型', N'rule_script_type', N'0', N'admin', N'2023-11-04 01:48:50', N'admin', N'2023-11-04 01:50:16', NULL), (N'199', N'规则脚本语言', N'rule_script_language', N'0', N'admin', N'2023-11-04 01:50:06', N'', NULL, NULL), (N'204', N'规则脚本事件', N'rule_script_event', N'0', N'admin', N'2023-12-19 11:33:48', N'', NULL, N'1=设备上报，2=平台下发，3=设备上线，4=设备离线'), (N'205', N'规则脚本用途', N'rule_script_purpose', N'0', N'admin', N'2023-12-19 11:38:18', N'', NULL, N'1=数据流，2=触发器，3=执行动作'), (N'206', N'规则脚本动作', N'rule_script_action', N'0', N'admin', N'2023-12-19 11:39:58', N'', NULL, N'1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_job]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_job]
GO

CREATE TABLE [dbo].[sys_job] (
  [job_id] bigint NOT NULL,
  [job_name] nvarchar(64) NOT NULL,
  [job_group] nvarchar(64) NOT NULL,
  [invoke_target] nvarchar(500) NOT NULL,
  [cron_expression] nvarchar(255) NULL,
  [misfire_policy] nvarchar(20) NULL,
  [concurrent] nchar(1) NULL,
  [status] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'job_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'job_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务组名',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'job_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调用目标字符串',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'invoke_target'
GO

EXEC sp_addextendedproperty
'MS_Description', N'cron执行表达式',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'cron_expression'
GO

EXEC sp_addextendedproperty
'MS_Description', N'计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'misfire_policy'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否并发执行（0允许 1禁止）',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'concurrent'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（0正常 1暂停）',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注信息',
'SCHEMA', N'dbo',
'TABLE', N'sys_job',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'定时任务调度表',
'SCHEMA', N'dbo',
'TABLE', N'sys_job'
GO


-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_job] ([job_id], [job_name], [job_group], [invoke_target], [cron_expression], [misfire_policy], [concurrent], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'2', N'系统默认（有参）', N'DEFAULT', N'ryTask.ryParams(''ry'')', N'0/15 * * * * ?', N'3', N'1', N'1', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'5', N'监控在线状态更新', N'SYSTEM', N'deviceJob.updateSipDeviceOnlineStatus(90)', N'0 0/2 * * * ?', N'1', N'0', N'0', N'admin', N'2023-03-24 10:57:48', N'admin', N'2025-03-26 15:50:06', N''), (N'6', N'设备定时同步', N'SYSTEM', N'deviceJob.syncDeviceStatus', N'0 0/1 * * * ? ', N'1', N'0', N'0', N'admin', N'2025-03-26 17:44:26', N'admin', N'2025-03-26 17:45:08', N'')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_job_log]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_job_log]
GO

CREATE TABLE [dbo].[sys_job_log] (
  [job_log_id] bigint NOT NULL,
  [job_name] nvarchar(64) NOT NULL,
  [job_group] nvarchar(64) NOT NULL,
  [invoke_target] nvarchar(500) NOT NULL,
  [job_message] nvarchar(500) NULL,
  [status] nchar(1) NULL,
  [exception_info] nvarchar(2000) NULL,
  [create_time] datetime2 NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务日志ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'job_log_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'job_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'任务组名',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'job_group'
GO

EXEC sp_addextendedproperty
'MS_Description', N'调用目标字符串',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'invoke_target'
GO

EXEC sp_addextendedproperty
'MS_Description', N'日志信息',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'job_message'
GO

EXEC sp_addextendedproperty
'MS_Description', N'执行状态（0正常 1失败）',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'异常信息',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'exception_info'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'定时任务调度日志表',
'SCHEMA', N'dbo',
'TABLE', N'sys_job_log'
GO


-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_job_log] ([job_log_id], [job_name], [job_group], [invoke_target], [job_message], [status], [exception_info], [create_time]) VALUES (N'1', N'设备定时同步', N'SYSTEM', N'deviceJob.syncDeviceStatus', N'设备定时同步 总共耗时：35毫秒', N'0', N'', N'2025-03-26 17:52:59'), (N'2', N'设备定时任务', N'SYSTEM', N'deviceJob.timingUpdateDeviceStatusStatus', N'设备定时任务 总共耗时：0毫秒', N'1', N'java.lang.NoSuchMethodException: com.fastbee.data.service.impl.DeviceJob.timingUpdateDeviceStatusStatus()
	at java.lang.Class.getMethod(Class.java:1786)
	at com.fastbee.quartz.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:60)
	at com.fastbee.quartz.util.JobInvokeUtil.invokeMethod(JobInvokeUtil.java:33)
	at com.fastbee.quartz.util.QuartzDisallowConcurrentExecution.doExecute(QuartzDisallowConcurrentExecution.java:19)
	at com.fastbee.quartz.util.AbstractQuartzJob.execute(AbstractQuartzJob.java:43)
	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)
	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)
', N'2025-03-26 17:53:00')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_logininfor]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_logininfor]
GO

CREATE TABLE [dbo].[sys_logininfor] (
  [info_id] bigint NOT NULL,
  [user_name] nvarchar(50) NULL,
  [ipaddr] nvarchar(128) NULL,
  [login_location] nvarchar(255) NULL,
  [browser] nvarchar(50) NULL,
  [os] nvarchar(50) NULL,
  [status] nchar(1) NULL,
  [msg] nvarchar(255) NULL,
  [login_time] datetime2 NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'访问ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'info_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户账号',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录IP地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'ipaddr'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录地点',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'login_location'
GO

EXEC sp_addextendedproperty
'MS_Description', N'浏览器类型',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'browser'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作系统',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'os'
GO

EXEC sp_addextendedproperty
'MS_Description', N'登录状态（0成功 1失败）',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'提示消息',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'msg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'访问时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor',
'COLUMN', N'login_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'系统访问记录',
'SCHEMA', N'dbo',
'TABLE', N'sys_logininfor'
GO


-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_menu]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_menu]
GO

CREATE TABLE [dbo].[sys_menu] (
  [menu_id] bigint NOT NULL,
  [menu_name] nvarchar(50) NOT NULL,
  [parent_id] bigint NULL,
  [order_num] int NULL,
  [path] nvarchar(200) NULL,
  [component] nvarchar(255) NULL,
  [query] nvarchar(255) NULL,
  [is_frame] int NULL,
  [is_cache] int NULL,
  [menu_type] nchar(1) NULL,
  [visible] nchar(1) NULL,
  [status] nchar(1) NULL,
  [perms] nvarchar(100) NULL,
  [icon] nvarchar(100) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'menu_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'menu_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父菜单ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'parent_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'order_num'
GO

EXEC sp_addextendedproperty
'MS_Description', N'路由地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'path'
GO

EXEC sp_addextendedproperty
'MS_Description', N'组件路径',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'component'
GO

EXEC sp_addextendedproperty
'MS_Description', N'路由参数',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'query'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否为外链（0是 1否）',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'is_frame'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否缓存（0缓存 1不缓存）',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'is_cache'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单类型（M目录 C菜单 F按钮）',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'menu_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单状态（0显示 1隐藏）',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'visible'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'权限标识',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'perms'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单图标',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'icon'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单权限表',
'SCHEMA', N'dbo',
'TABLE', N'sys_menu'
GO


-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [path], [component], [query], [is_frame], [is_cache], [menu_type], [visible], [status], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'系统管理', N'0', N'4', N'system', NULL, N'', N'1', N'0', N'M', N'0', N'0', N'', N'system', N'admin', N'2021-12-15 21:36:18', N'admin', N'2023-09-16 16:42:52', N'系统管理目录'), (N'2', N'系统监控', N'0', N'5', N'monitor', NULL, N'', N'1', N'0', N'M', N'0', N'0', N'', N'monitor', N'admin', N'2021-12-15 21:36:18', N'admin', N'2023-08-24 17:21:20', N'系统监控目录'), (N'3', N'系统工具', N'0', N'6', N'tool', NULL, N'', N'1', N'0', N'M', N'0', N'0', N'', N'tool', N'admin', N'2021-12-15 21:36:18', N'admin', N'2023-08-24 17:21:28', N'系统工具目录'), (N'4', N'蜂信物联', N'0', N'10', N'http://fastbee.cn', NULL, N'', N'0', N'0', N'M', N'0', N'0', N'', N'guide', N'admin', N'2021-12-15 21:36:18', N'admin', N'2025-03-19 15:14:02', N'若依官网地址'), (N'100', N'用户管理', N'1', N'1', N'user', N'system/user/index', N'', N'1', N'0', N'C', N'0', N'0', N'system:user:list', N'user', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'用户管理菜单'), (N'101', N'角色管理', N'1', N'2', N'role', N'system/role/index', N'', N'1', N'0', N'C', N'0', N'0', N'system:role:list', N'peoples', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'角色管理菜单'), (N'102', N'菜单管理', N'1', N'3', N'menu', N'system/menu/index', N'', N'1', N'0', N'C', N'0', N'0', N'system:menu:list', N'tree-table', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'菜单管理菜单'), (N'103', N'部门管理', N'1', N'4', N'dept', N'system/dept/index', N'', N'1', N'0', N'C', N'0', N'0', N'system:dept:list', N'tree', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'部门管理菜单'), (N'104', N'岗位管理', N'1', N'5', N'post', N'system/post/index', N'', N'1', N'0', N'C', N'0', N'0', N'system:post:list', N'post', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'岗位管理菜单'), (N'105', N'字典管理', N'1', N'6', N'dict', N'system/dict/index', N'', N'1', N'0', N'C', N'0', N'0', N'system:dict:list', N'dict', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'字典管理菜单'), (N'106', N'参数设置', N'1', N'7', N'config', N'system/config/index', N'', N'1', N'0', N'C', N'0', N'0', N'system:config:list', N'edit', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'参数设置菜单'), (N'107', N'通知公告', N'1', N'8', N'notice', N'system/notice/index', N'', N'1', N'0', N'C', N'0', N'0', N'system:notice:list', N'message', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'通知公告菜单'), (N'108', N'日志管理', N'1', N'9', N'log', N'', N'', N'1', N'0', N'M', N'0', N'0', N'', N'log', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'日志管理菜单'), (N'109', N'在线用户', N'2', N'1', N'online', N'monitor/online/index', N'', N'1', N'0', N'C', N'0', N'0', N'monitor:online:list', N'online', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'在线用户菜单'), (N'110', N'定时任务', N'2', N'2', N'job', N'monitor/job/index', N'', N'1', N'0', N'C', N'0', N'0', N'monitor:job:list', N'job', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'定时任务菜单'), (N'111', N'数据监控', N'2', N'3', N'druid', N'monitor/druid/index', N'', N'1', N'0', N'C', N'0', N'0', N'monitor:druid:list', N'druid', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'数据监控菜单'), (N'112', N'服务监控', N'2', N'4', N'server', N'monitor/server/index', N'', N'1', N'0', N'C', N'0', N'0', N'monitor:server:list', N'server', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'服务监控菜单'), (N'113', N'缓存监控', N'2', N'5', N'cache', N'monitor/cache/index', N'', N'1', N'0', N'C', N'0', N'0', N'monitor:cache:list', N'redis', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'缓存监控菜单'), (N'114', N'表单构建', N'3', N'1', N'build', N'tool/build/index', N'', N'1', N'0', N'C', N'0', N'0', N'tool:build:list', N'build', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'表单构建菜单'), (N'115', N'代码生成', N'3', N'2', N'gen', N'tool/gen/index', N'', N'1', N'0', N'C', N'0', N'0', N'tool:gen:list', N'code', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'代码生成菜单'), (N'116', N'系统接口', N'3', N'3', N'swagger', N'tool/swagger/index', N'', N'1', N'0', N'C', N'0', N'0', N'tool:swagger:list', N'swagger', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'系统接口菜单'), (N'124', N'缓存列表', N'2', N'6', N'cacheList', N'monitor/cache/list', N'', N'1', N'0', N'C', N'0', N'0', N'monitor:cache:list', N'redis-list', N'admin', N'2023-03-10 23:22:42', N'', NULL, N'缓存列表菜单'), (N'500', N'操作日志', N'108', N'1', N'operlog', N'monitor/operlog/index', N'', N'1', N'0', N'C', N'0', N'0', N'monitor:operlog:list', N'form', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'操作日志菜单'), (N'501', N'登录日志', N'108', N'2', N'logininfor', N'monitor/logininfor/index', N'', N'1', N'0', N'C', N'0', N'0', N'monitor:logininfor:list', N'logininfor', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'登录日志菜单'), (N'1001', N'用户查询', N'100', N'1', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:user:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1002', N'用户新增', N'100', N'2', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:user:add', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1003', N'用户修改', N'100', N'3', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:user:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1004', N'用户删除', N'100', N'4', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:user:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1005', N'用户导出', N'100', N'5', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:user:export', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1006', N'用户导入', N'100', N'6', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:user:import', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1007', N'重置密码', N'100', N'7', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:user:resetPwd', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1008', N'角色查询', N'101', N'1', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:role:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1009', N'角色新增', N'101', N'2', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:role:add', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1010', N'角色修改', N'101', N'3', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:role:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1011', N'角色删除', N'101', N'4', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:role:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1012', N'角色导出', N'101', N'5', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:role:export', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1013', N'菜单查询', N'102', N'1', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:menu:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1014', N'菜单新增', N'102', N'2', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:menu:add', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1015', N'菜单修改', N'102', N'3', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:menu:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1016', N'菜单删除', N'102', N'4', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:menu:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1017', N'部门查询', N'103', N'1', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:dept:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1018', N'部门新增', N'103', N'2', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:dept:add', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1019', N'部门修改', N'103', N'3', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:dept:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1020', N'部门删除', N'103', N'4', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:dept:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1021', N'岗位查询', N'104', N'1', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:post:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1022', N'岗位新增', N'104', N'2', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:post:add', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1023', N'岗位修改', N'104', N'3', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:post:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1024', N'岗位删除', N'104', N'4', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:post:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1025', N'岗位导出', N'104', N'5', N'', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:post:export', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1026', N'字典查询', N'105', N'1', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:dict:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1027', N'字典新增', N'105', N'2', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:dict:add', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1028', N'字典修改', N'105', N'3', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:dict:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1029', N'字典删除', N'105', N'4', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:dict:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1030', N'字典导出', N'105', N'5', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:dict:export', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1031', N'参数查询', N'106', N'1', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:config:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1032', N'参数新增', N'106', N'2', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:config:add', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1033', N'参数修改', N'106', N'3', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:config:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1034', N'参数删除', N'106', N'4', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:config:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1035', N'参数导出', N'106', N'5', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:config:export', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1036', N'公告查询', N'107', N'1', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:notice:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1037', N'公告新增', N'107', N'2', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:notice:add', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1038', N'公告修改', N'107', N'3', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:notice:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1039', N'公告删除', N'107', N'4', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'system:notice:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1040', N'操作查询', N'500', N'1', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:operlog:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1041', N'操作删除', N'500', N'2', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:operlog:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1042', N'日志导出', N'500', N'4', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:operlog:export', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1043', N'登录查询', N'501', N'1', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:logininfor:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1044', N'登录删除', N'501', N'2', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:logininfor:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1045', N'日志导出', N'501', N'3', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:logininfor:export', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1046', N'在线查询', N'109', N'1', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:online:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1047', N'批量强退', N'109', N'2', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:online:batchLogout', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1048', N'单条强退', N'109', N'3', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:online:forceLogout', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1049', N'任务查询', N'110', N'1', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:job:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1050', N'任务新增', N'110', N'2', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:job:add', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1051', N'任务修改', N'110', N'3', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:job:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1052', N'任务删除', N'110', N'4', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:job:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1053', N'状态修改', N'110', N'5', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:job:changeStatus', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1054', N'任务导出', N'110', N'7', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:job:export', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1055', N'生成查询', N'115', N'1', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'tool:gen:query', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1056', N'生成修改', N'115', N'2', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'tool:gen:edit', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1057', N'生成删除', N'115', N'3', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'tool:gen:remove', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1058', N'导入代码', N'115', N'2', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'tool:gen:import', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1059', N'预览代码', N'115', N'4', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'tool:gen:preview', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1060', N'生成代码', N'115', N'5', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'tool:gen:code', N'#', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'1065', N'账户解锁', N'501', N'4', N'#', N'', N'', N'1', N'0', N'F', N'0', N'0', N'monitor:logininfor:unlock', N'#', N'admin', N'2023-03-10 23:23:04', N'', NULL, N''), (N'2000', N'设备管理', N'0', N'0', N'iot', NULL, NULL, N'1', N'0', N'M', N'0', N'0', N'', N'iot', N'admin', N'2021-12-15 23:57:06', N'admin', N'2021-12-26 23:55:54', N''), (N'2001', N'产品分类', N'2000', N'2', N'category', N'iot/category/index', NULL, N'1', N'0', N'C', N'0', N'0', N'iot:category:list', N'category', N'admin', N'2021-12-16 00:40:02', N'admin', N'2021-12-26 23:56:20', N'产品分类菜单'), (N'2002', N'产品分类查询', N'2001', N'1', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:category:query', N'#', N'admin', N'2021-12-16 00:40:02', N'', NULL, N''), (N'2003', N'产品分类新增', N'2001', N'2', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:category:add', N'#', N'admin', N'2021-12-16 00:40:02', N'', NULL, N''), (N'2004', N'产品分类修改', N'2001', N'3', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:category:edit', N'#', N'admin', N'2021-12-16 00:40:02', N'', NULL, N''), (N'2005', N'产品分类删除', N'2001', N'4', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:category:remove', N'#', N'admin', N'2021-12-16 00:40:02', N'', NULL, N''), (N'2006', N'产品分类导出', N'2001', N'5', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:category:export', N'#', N'admin', N'2021-12-16 00:40:02', N'', NULL, N''), (N'2007', N'设备管理', N'2000', N'5', N'device', N'iot/device/index', NULL, N'1', N'0', N'C', N'0', N'0', N'iot:device:list', N'device', N'admin', N'2021-12-16 00:40:12', N'admin', N'2022-01-08 15:47:14', N'设备菜单'), (N'2008', N'设备查询', N'2007', N'1', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:device:query', N'#', N'admin', N'2021-12-16 00:40:12', N'', NULL, N''), (N'2009', N'设备新增', N'2007', N'2', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:device:add', N'#', N'admin', N'2021-12-16 00:40:12', N'', NULL, N''), (N'2010', N'设备修改', N'2007', N'3', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:device:edit', N'#', N'admin', N'2021-12-16 00:40:12', N'', NULL, N''), (N'2011', N'设备删除', N'2007', N'4', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:device:remove', N'#', N'admin', N'2021-12-16 00:40:12', N'', NULL, N''), (N'2012', N'设备导出', N'2007', N'5', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:device:export', N'#', N'admin', N'2021-12-16 00:40:12', N'', NULL, N''), (N'2019', N'设备分组', N'2000', N'4', N'group', N'iot/group/index', NULL, N'1', N'0', N'C', N'0', N'0', N'iot:group:list', N'group', N'admin', N'2021-12-16 00:40:31', N'admin', N'2021-12-26 23:56:54', N'设备分组菜单'), (N'2020', N'设备分组查询', N'2019', N'1', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:group:query', N'#', N'admin', N'2021-12-16 00:40:31', N'', NULL, N'')
GO

INSERT INTO [dbo].[sys_menu] ([menu_id], [menu_name], [parent_id], [order_num], [path], [component], [query], [is_frame], [is_cache], [menu_type], [visible], [status], [perms], [icon], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'2021', N'设备分组新增', N'2019', N'2', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:group:add', N'#', N'admin', N'2021-12-16 00:40:31', N'', NULL, N''), (N'2022', N'设备分组修改', N'2019', N'3', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:group:edit', N'#', N'admin', N'2021-12-16 00:40:31', N'', NULL, N''), (N'2023', N'设备分组删除', N'2019', N'4', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:group:remove', N'#', N'admin', N'2021-12-16 00:40:31', N'', NULL, N''), (N'2024', N'设备分组导出', N'2019', N'5', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:group:export', N'#', N'admin', N'2021-12-16 00:40:31', N'', NULL, N''), (N'2043', N'产品管理', N'2000', N'3', N'product', N'iot/product/index', NULL, N'1', N'0', N'C', N'0', N'0', N'iot:product:list', N'product', N'admin', N'2021-12-16 00:41:18', N'admin', N'2021-12-26 23:58:44', N'产品菜单'), (N'2044', N'产品查询', N'2043', N'1', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:product:query', N'#', N'admin', N'2021-12-16 00:41:18', N'', NULL, N''), (N'2045', N'产品新增', N'2043', N'2', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:product:add', N'#', N'admin', N'2021-12-16 00:41:18', N'', NULL, N''), (N'2046', N'产品修改', N'2043', N'3', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:product:edit', N'#', N'admin', N'2021-12-16 00:41:18', N'', NULL, N''), (N'2047', N'产品删除', N'2043', N'4', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:product:remove', N'#', N'admin', N'2021-12-16 00:41:18', N'', NULL, N''), (N'2048', N'产品导出', N'2043', N'5', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:product:export', N'#', N'admin', N'2021-12-16 00:41:18', N'', NULL, N''), (N'2049', N'通用物模型', N'2000', N'1', N'template', N'iot/template/index', NULL, N'1', N'0', N'C', N'0', N'0', N'iot:template:list', N'model', N'admin', N'2021-12-16 00:41:28', N'admin', N'2021-12-26 23:56:09', N'通用物模型菜单'), (N'2050', N'通用物模型查询', N'2049', N'1', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:template:query', N'#', N'admin', N'2021-12-16 00:41:28', N'', NULL, N''), (N'2051', N'通用物模型新增', N'2049', N'2', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:template:add', N'#', N'admin', N'2021-12-16 00:41:28', N'', NULL, N''), (N'2052', N'通用物模型修改', N'2049', N'3', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:template:edit', N'#', N'admin', N'2021-12-16 00:41:28', N'', NULL, N''), (N'2053', N'通用物模型删除', N'2049', N'4', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:template:remove', N'#', N'admin', N'2021-12-16 00:41:28', N'', NULL, N''), (N'2054', N'通用物模型导出', N'2049', N'5', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:template:export', N'#', N'admin', N'2021-12-16 00:41:28', N'', NULL, N''), (N'2123', N'新闻分类', N'1', N'10', N'newsCategory', N'iot/newsCategory/index', NULL, N'1', N'0', N'C', N'0', N'0', N'iot:newsCategory:list', N'category', N'admin', N'2022-04-11 16:47:27', N'admin', N'2022-05-12 17:20:51', N'新闻分类菜单'), (N'2124', N'新闻分类查询', N'2123', N'1', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:newsCategory:query', N'#', N'admin', N'2022-04-11 16:47:27', N'', NULL, N''), (N'2125', N'新闻分类新增', N'2123', N'2', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:newsCategory:add', N'#', N'admin', N'2022-04-11 16:47:27', N'', NULL, N''), (N'2126', N'新闻分类修改', N'2123', N'3', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:newsCategory:edit', N'#', N'admin', N'2022-04-11 16:47:27', N'', NULL, N''), (N'2127', N'新闻分类删除', N'2123', N'4', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:newsCategory:remove', N'#', N'admin', N'2022-04-11 16:47:27', N'', NULL, N''), (N'2128', N'新闻分类导出', N'2123', N'5', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:newsCategory:export', N'#', N'admin', N'2022-04-11 16:47:27', N'', NULL, N''), (N'2129', N'新闻资讯', N'1', N'11', N'news', N'iot/news/index', NULL, N'1', N'0', N'C', N'0', N'0', N'iot:news:list', N'documentation', N'admin', N'2022-04-11 16:47:46', N'admin', N'2022-05-12 17:20:58', N'新闻资讯菜单'), (N'2130', N'新闻资讯查询', N'2129', N'1', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:news:query', N'#', N'admin', N'2022-04-11 16:47:46', N'', NULL, N''), (N'2131', N'新闻资讯新增', N'2129', N'2', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:news:add', N'#', N'admin', N'2022-04-11 16:47:46', N'', NULL, N''), (N'2132', N'新闻资讯修改', N'2129', N'3', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:news:edit', N'#', N'admin', N'2022-04-11 16:47:46', N'', NULL, N''), (N'2133', N'新闻资讯删除', N'2129', N'4', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:news:remove', N'#', N'admin', N'2022-04-11 16:47:46', N'', NULL, N''), (N'2134', N'新闻资讯导出', N'2129', N'5', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:news:export', N'#', N'admin', N'2022-04-11 16:47:46', N'', NULL, N''), (N'2136', N'产品授权码查询', N'2043', N'6', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:authorize:query', N'#', N'admin', N'2022-04-11 17:17:53', N'admin', N'2022-06-04 21:21:40', N''), (N'2137', N'产品授权码新增', N'2043', N'7', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:authorize:add', N'#', N'admin', N'2022-04-11 17:17:53', N'admin', N'2022-06-04 21:21:59', N''), (N'2138', N'产品授权码修改', N'2043', N'8', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:authorize:edit', N'#', N'admin', N'2022-04-11 17:17:53', N'admin', N'2022-06-04 21:22:08', N''), (N'2139', N'产品授权码删除', N'2043', N'9', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:authorize:remove', N'#', N'admin', N'2022-04-11 17:17:53', N'admin', N'2022-06-04 21:22:26', N''), (N'2140', N'产品授权码导出', N'2043', N'5', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:authorize:export', N'#', N'admin', N'2022-04-11 17:17:53', N'', NULL, N''), (N'2142', N'平台查询', N'2142', N'1', N'', NULL, NULL, N'1', N'0', N'F', N'0', N'0', N'iot:platform:query', N'#', N'admin', N'2022-04-11 19:10:28', N'', NULL, N''), (N'2147', N'设备分享', N'2007', N'6', N'', NULL, NULL, N'1', N'0', N'F', N'0', N'0', N'iot:device:share', N'#', N'admin', N'2022-06-10 01:08:40', N'admin', N'2022-06-10 01:10:46', N''), (N'2148', N'设备定时', N'2007', N'7', N'', NULL, NULL, N'1', N'0', N'F', N'0', N'0', N'iot:device:timer', N'#', N'admin', N'2022-06-10 01:10:30', N'', NULL, N''), (N'3031', N'Netty管理', N'0', N'3', N'netty', NULL, NULL, N'1', N'0', N'M', N'0', N'0', N'', N'mq', N'admin', N'2022-02-26 00:42:12', N'admin', N'2023-09-26 00:11:57', N''), (N'3032', N'客户端', N'3031', N'1', N'client', N'iot/netty/clients', NULL, N'1', N'0', N'C', N'0', N'0', N'monitor:server:list', N'client', N'admin', N'2022-02-26 00:45:39', N'admin', N'2023-08-23 23:38:08', N''), (N'3033', N'事件日志', N'2000', N'1', N'log', N'iot/log/index', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:event:list', N'#', N'admin', N'2023-03-28 14:23:52', N'', NULL, N'事件日志菜单'), (N'3034', N'事件日志查询', N'3033', N'1', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:event:query', N'#', N'admin', N'2023-03-28 14:23:52', N'', NULL, N''), (N'3035', N'事件日志新增', N'3033', N'2', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:event:add', N'#', N'admin', N'2023-03-28 14:23:52', N'', NULL, N''), (N'3036', N'事件日志修改', N'3033', N'3', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:event:edit', N'#', N'admin', N'2023-03-28 14:23:52', N'', NULL, N''), (N'3037', N'事件日志删除', N'3033', N'4', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:event:remove', N'#', N'admin', N'2023-03-28 14:23:52', N'', NULL, N''), (N'3038', N'事件日志导出', N'3033', N'5', N'#', N'', NULL, N'1', N'0', N'F', N'0', N'0', N'iot:event:export', N'#', N'admin', N'2023-03-28 14:23:52', N'', NULL, N''), (N'3048', N'Mqtt统计', N'3031', N'2', N'mqtt', N'iot/netty/mqtt', NULL, N'1', N'0', N'C', N'0', N'0', N'monitor:server:list', N'monitor', N'admin', N'2023-08-23 23:40:28', N'admin', N'2023-08-23 23:40:38', N''), (N'3050', N'规则引擎', N'0', N'2', N'ruleengine', NULL, NULL, N'1', N'0', N'M', N'0', N'0', N'', N'channel', N'admin', N'2024-04-22 16:28:15', N'admin', N'2025-03-19 15:13:50', N''), (N'3051', N'规则脚本', N'3050', N'2', N'script', N'iot/scene/script', NULL, N'1', N'0', N'C', N'0', N'0', N'iot:script:list', N'code', N'admin', N'2024-04-22 16:30:00', N'', NULL, N''), (N'3052', N'规则脚本查询', N'3051', N'1', N'', NULL, NULL, N'1', N'0', N'F', N'0', N'0', N'iot:script:query', N'#', N'admin', N'2024-04-22 16:30:53', N'', NULL, N''), (N'3053', N'规则脚本新增', N'3051', N'2', N'', NULL, NULL, N'1', N'0', N'F', N'0', N'0', N'iot:script:add', N'#', N'admin', N'2024-04-22 16:31:28', N'', NULL, N''), (N'3054', N'规则脚本修改', N'3051', N'3', N'', NULL, NULL, N'1', N'0', N'F', N'0', N'0', N'iot:script:edit', N'#', N'admin', N'2024-04-22 16:32:04', N'', NULL, N''), (N'3056', N'规则脚本导出', N'3051', N'5', N'', NULL, NULL, N'1', N'0', N'F', N'0', N'0', N'iot:script:export', N'#', N'admin', N'2024-04-22 16:33:25', N'admin', N'2024-04-22 16:33:49', N''), (N'3057', N'规则脚本删除', N'3051', N'4', N'', NULL, NULL, N'1', N'0', N'F', N'0', N'0', N'iot:script:remove', N'#', N'admin', N'2024-04-22 16:35:01', N'', NULL, N''), (N'3058', N'视频中心', N'0', N'1', N'video', NULL, NULL, N'1', N'0', N'M', N'0', N'0', N'', N'live', N'admin', N'2024-07-15 14:42:13', N'admin', N'2025-03-19 15:13:43', N''), (N'3059', N'通道管理', N'3058', N'1', N'sip', N'iot/sip/index', NULL, N'1', N'0', N'C', N'0', N'0', N'iot:video:list', N'swagger', N'admin', N'2024-07-15 14:43:22', N'', NULL, N''), (N'3060', N'视频配置', N'3058', N'2', N'mediaServer', N'iot/sip/mediaServer', NULL, N'1', N'0', N'C', N'0', N'0', NULL, N'edit', N'admin', N'2024-07-15 14:48:52', N'', NULL, N''), (N'3062', N'大屏展示', N'2000', N'6', N'http://localhost/bigScreen', NULL, NULL, N'0', N'0', N'M', N'0', N'0', N'', N'monitor-a', N'admin', N'2025-03-19 15:07:39', N'admin', N'2025-03-20 22:18:42', N'')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_notice]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_notice]
GO

CREATE TABLE [dbo].[sys_notice] (
  [notice_id] int NOT NULL,
  [notice_title] nvarchar(50) NOT NULL,
  [notice_type] nchar(1) NOT NULL,
  [notice_content] varbinary(max) NULL,
  [status] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(255) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'notice_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告标题',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'notice_title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告类型（1通知 2公告）',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'notice_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告内容',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'notice_content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'公告状态（0正常 1关闭）',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'通知公告表',
'SCHEMA', N'dbo',
'TABLE', N'sys_notice'
GO


-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_notice] ([notice_id], [notice_title], [notice_type], [notice_content], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'FastBeeV1.2版本发布', N'2', 0x3C703EE8BF99E698AFE6B58BE8AF95E58685E5AEB9EFBC8CE696B0E78988E69CACE58A9FE883BDEFBC9A3C2F703E3C6F6C3E3C6C693EE694AFE68C81E5A49AE7A79FE688B73C2F6C693E3C6C693EE694AFE68C81E8AEBEE5A487E58886E4BAAB3C2F6C693E3C6C693EE694AFE68C81E697B6E5BA8FE695B0E68DAEE5BA933C2F6C693E3C6C693EE7AE80E58D95E8AEA4E8AF81E5928CE58AA0E5AF86E8AEA4E8AF81E7BB9FE4B8803C2F6C693E3C2F6F6C3E, N'0', N'admin', N'2021-12-15 21:36:18', N'admin', N'2023-09-26 21:21:30', N'管理员'), (N'2', N'FastBee sdk支持树莓派', N'1', 0x3C703EE8BF99E698AFE6B58BE8AF95E58685E5AEB9EFBC8CE79BAEE5898D73646BE694AFE68C81E79A84E78988E69CAC3A3C2F703E3C703E3C62723E3C2F703E3C703E3C62723E3C2F703E3C6F6C3E3C6C693E41726475696E6F20657370383236363C2F6C693E3C6C693E41726475696E6F2065737033323C2F6C693E3C6C693E6573702D6964663C2F6C693E3C6C693E72617370626572727920E6A091E88E93E6B4BE3C2F6C693E3C2F6F6C3E, N'0', N'admin', N'2021-12-15 21:36:18', N'admin', N'2023-09-26 21:21:41', N'管理员')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_oper_log]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_oper_log]
GO

CREATE TABLE [dbo].[sys_oper_log] (
  [oper_id] bigint NOT NULL,
  [title] nvarchar(50) NULL,
  [business_type] int NULL,
  [method] nvarchar(100) NULL,
  [request_method] nvarchar(10) NULL,
  [operator_type] int NULL,
  [oper_name] nvarchar(50) NULL,
  [dept_name] nvarchar(50) NULL,
  [oper_url] nvarchar(255) NULL,
  [oper_ip] nvarchar(128) NULL,
  [oper_location] nvarchar(255) NULL,
  [oper_param] nvarchar(2000) NULL,
  [json_result] nvarchar(2000) NULL,
  [status] int NULL,
  [error_msg] nvarchar(2000) NULL,
  [oper_time] datetime2 NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作日志ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块标题',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'业务类型（0其它 1新增 2修改 3删除）',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'business_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'方法名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'method'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请求方式',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'request_method'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作类别（0其它 1后台用户 2手机端用户）',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'operator_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作人员',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'dept_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请求URL',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'主机地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作地点',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_location'
GO

EXEC sp_addextendedproperty
'MS_Description', N'请求参数',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_param'
GO

EXEC sp_addextendedproperty
'MS_Description', N'返回参数',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'json_result'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作状态（0正常 1异常）',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'错误消息',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'error_msg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log',
'COLUMN', N'oper_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'操作日志记录',
'SCHEMA', N'dbo',
'TABLE', N'sys_oper_log'
GO


-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_post]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_post]
GO

CREATE TABLE [dbo].[sys_post] (
  [post_id] bigint NOT NULL,
  [post_code] nvarchar(64) NOT NULL,
  [post_name] nvarchar(50) NOT NULL,
  [post_sort] int NOT NULL,
  [status] nchar(1) NOT NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'post_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位编码',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'post_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'post_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'post_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_post',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位信息表',
'SCHEMA', N'dbo',
'TABLE', N'sys_post'
GO


-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_post] ([post_id], [post_code], [post_name], [post_sort], [status], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'ceo', N'董事长', N'1', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'2', N'se', N'项目经理', N'2', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'3', N'hr', N'人力资源', N'3', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N''), (N'4', N'user', N'普通员工', N'4', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_role]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_role]
GO

CREATE TABLE [dbo].[sys_role] (
  [role_id] bigint NOT NULL,
  [role_name] nvarchar(30) NOT NULL,
  [role_key] nvarchar(100) NOT NULL,
  [role_sort] int NOT NULL,
  [data_scope] nchar(1) NULL,
  [menu_check_strictly] tinyint NULL,
  [dept_check_strictly] tinyint NULL,
  [status] nchar(1) NOT NULL,
  [del_flag] nchar(1) NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色名称',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'role_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色权限字符串',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'role_key'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'role_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'data_scope'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单树选择项是否关联显示',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'menu_check_strictly'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门树选择项是否关联显示',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'dept_check_strictly'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_role',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色信息表',
'SCHEMA', N'dbo',
'TABLE', N'sys_role'
GO


-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_role] ([role_id], [role_name], [role_key], [role_sort], [data_scope], [menu_check_strictly], [dept_check_strictly], [status], [del_flag], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'超级管理员', N'admin', N'1', N'1', N'1', N'1', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'', NULL, N'超级管理员'), (N'2', N'设备租户', N'tenant', N'2', N'5', N'1', N'1', N'0', N'0', N'admin', N'2021-12-16 16:41:30', N'admin', N'2023-04-12 19:53:34', N'管理产品和设备'), (N'3', N'普通用户', N'general', N'3', N'5', N'1', N'1', N'0', N'0', N'admin', N'2021-12-15 21:36:18', N'admin', N'2023-02-22 08:17:37', N'设备的最终用户，只能管理设备和分组'), (N'4', N'游客', N'visitor', N'4', N'1', N'1', N'1', N'0', N'0', N'admin', N'2021-12-16 16:44:30', N'admin', N'2025-03-19 15:06:10', N'只能查询和新增系统数据'), (N'5', N'管理员', N'manager', N'5', N'1', N'1', N'1', N'0', N'0', N'admin', N'2022-06-10 13:54:29', N'admin', N'2025-03-19 15:10:17', N'普通管理员')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_role_dept]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_role_dept]
GO

CREATE TABLE [dbo].[sys_role_dept] (
  [role_id] bigint NOT NULL,
  [dept_id] bigint NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_dept',
'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_dept',
'COLUMN', N'dept_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色和部门关联表',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_dept'
GO


-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN TRANSACTION
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_role_menu]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_role_menu]
GO

CREATE TABLE [dbo].[sys_role_menu] (
  [role_id] bigint NOT NULL,
  [menu_id] bigint NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_menu',
'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'菜单ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_menu',
'COLUMN', N'menu_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色和菜单关联表',
'SCHEMA', N'dbo',
'TABLE', N'sys_role_menu'
GO


-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_role_menu] ([role_id], [menu_id]) VALUES (N'2', N'1'), (N'2', N'4'), (N'2', N'107'), (N'2', N'1036'), (N'2', N'2000'), (N'2', N'2001'), (N'2', N'2002'), (N'2', N'2003'), (N'2', N'2004'), (N'2', N'2005'), (N'2', N'2006'), (N'2', N'2007'), (N'2', N'2008'), (N'2', N'2009'), (N'2', N'2010'), (N'2', N'2011'), (N'2', N'2012'), (N'2', N'2019'), (N'2', N'2020'), (N'2', N'2021'), (N'2', N'2022'), (N'2', N'2023'), (N'2', N'2024'), (N'2', N'2043'), (N'2', N'2044'), (N'2', N'2045'), (N'2', N'2046'), (N'2', N'2047'), (N'2', N'2048'), (N'2', N'2049'), (N'2', N'2050'), (N'2', N'2051'), (N'2', N'2052'), (N'2', N'2053'), (N'2', N'2054'), (N'2', N'2129'), (N'2', N'2130'), (N'2', N'2136'), (N'2', N'2137'), (N'2', N'2138'), (N'2', N'2139'), (N'2', N'2140'), (N'2', N'2147'), (N'2', N'2148'), (N'3', N'1'), (N'3', N'4'), (N'3', N'107'), (N'3', N'1036'), (N'3', N'2000'), (N'3', N'2007'), (N'3', N'2008'), (N'3', N'2009'), (N'3', N'2010'), (N'3', N'2011'), (N'3', N'2012'), (N'3', N'2019'), (N'3', N'2020'), (N'3', N'2021'), (N'3', N'2022'), (N'3', N'2023'), (N'3', N'2024'), (N'3', N'2067'), (N'3', N'2068'), (N'3', N'2085'), (N'3', N'2086'), (N'3', N'2087'), (N'3', N'2088'), (N'3', N'2089'), (N'3', N'2090'), (N'3', N'2129'), (N'3', N'2130'), (N'3', N'2147'), (N'3', N'2148'), (N'3', N'2168'), (N'3', N'2169'), (N'3', N'2170'), (N'3', N'2171'), (N'3', N'2172'), (N'4', N'1'), (N'4', N'2'), (N'4', N'3'), (N'4', N'4'), (N'4', N'100'), (N'4', N'101'), (N'4', N'102'), (N'4', N'103'), (N'4', N'104'), (N'4', N'105'), (N'4', N'106'), (N'4', N'107'), (N'4', N'108'), (N'4', N'109'), (N'4', N'110'), (N'4', N'111'), (N'4', N'112'), (N'4', N'113'), (N'4', N'114'), (N'4', N'115'), (N'4', N'116'), (N'4', N'500')
GO

INSERT INTO [dbo].[sys_role_menu] ([role_id], [menu_id]) VALUES (N'4', N'501'), (N'4', N'1001'), (N'4', N'1008'), (N'4', N'1013'), (N'4', N'1017'), (N'4', N'1021'), (N'4', N'1026'), (N'4', N'1031'), (N'4', N'1036'), (N'4', N'1040'), (N'4', N'1043'), (N'4', N'1046'), (N'4', N'1049'), (N'4', N'1055'), (N'4', N'2000'), (N'4', N'2001'), (N'4', N'2002'), (N'4', N'2003'), (N'4', N'2007'), (N'4', N'2008'), (N'4', N'2009'), (N'4', N'2019'), (N'4', N'2020'), (N'4', N'2021'), (N'4', N'2043'), (N'4', N'2044'), (N'4', N'2045'), (N'4', N'2049'), (N'4', N'2050'), (N'4', N'2051'), (N'4', N'2123'), (N'4', N'2124'), (N'4', N'2125'), (N'4', N'2129'), (N'4', N'2130'), (N'4', N'2131'), (N'4', N'2136'), (N'4', N'2137'), (N'4', N'2147'), (N'4', N'2148'), (N'4', N'3031'), (N'4', N'3032'), (N'4', N'3033'), (N'4', N'3034'), (N'4', N'3035'), (N'5', N'1'), (N'5', N'2'), (N'5', N'3'), (N'5', N'4'), (N'5', N'100'), (N'5', N'101'), (N'5', N'102'), (N'5', N'103'), (N'5', N'104'), (N'5', N'105'), (N'5', N'106'), (N'5', N'107'), (N'5', N'108'), (N'5', N'109'), (N'5', N'110'), (N'5', N'111'), (N'5', N'112'), (N'5', N'113'), (N'5', N'114'), (N'5', N'115'), (N'5', N'116'), (N'5', N'124'), (N'5', N'500'), (N'5', N'501'), (N'5', N'1001'), (N'5', N'1002'), (N'5', N'1003'), (N'5', N'1004'), (N'5', N'1005'), (N'5', N'1006'), (N'5', N'1007'), (N'5', N'1008'), (N'5', N'1009'), (N'5', N'1010'), (N'5', N'1011'), (N'5', N'1012'), (N'5', N'1013'), (N'5', N'1014'), (N'5', N'1015'), (N'5', N'1016'), (N'5', N'1017'), (N'5', N'1018'), (N'5', N'1019'), (N'5', N'1020'), (N'5', N'1021'), (N'5', N'1022'), (N'5', N'1023'), (N'5', N'1024'), (N'5', N'1025'), (N'5', N'1026'), (N'5', N'1027'), (N'5', N'1028'), (N'5', N'1029'), (N'5', N'1030'), (N'5', N'1031')
GO

INSERT INTO [dbo].[sys_role_menu] ([role_id], [menu_id]) VALUES (N'5', N'1032'), (N'5', N'1033'), (N'5', N'1034'), (N'5', N'1035'), (N'5', N'1036'), (N'5', N'1037'), (N'5', N'1038'), (N'5', N'1039'), (N'5', N'1040'), (N'5', N'1041'), (N'5', N'1042'), (N'5', N'1043'), (N'5', N'1044'), (N'5', N'1045'), (N'5', N'1046'), (N'5', N'1047'), (N'5', N'1048'), (N'5', N'1049'), (N'5', N'1050'), (N'5', N'1051'), (N'5', N'1052'), (N'5', N'1053'), (N'5', N'1054'), (N'5', N'1055'), (N'5', N'1056'), (N'5', N'1057'), (N'5', N'1058'), (N'5', N'1059'), (N'5', N'1060'), (N'5', N'1065'), (N'5', N'2000'), (N'5', N'2001'), (N'5', N'2002'), (N'5', N'2003'), (N'5', N'2004'), (N'5', N'2005'), (N'5', N'2006'), (N'5', N'2007'), (N'5', N'2008'), (N'5', N'2009'), (N'5', N'2010'), (N'5', N'2011'), (N'5', N'2012'), (N'5', N'2019'), (N'5', N'2020'), (N'5', N'2021'), (N'5', N'2022'), (N'5', N'2023'), (N'5', N'2024'), (N'5', N'2043'), (N'5', N'2044'), (N'5', N'2045'), (N'5', N'2046'), (N'5', N'2047'), (N'5', N'2048'), (N'5', N'2049'), (N'5', N'2050'), (N'5', N'2051'), (N'5', N'2052'), (N'5', N'2053'), (N'5', N'2054'), (N'5', N'2123'), (N'5', N'2124'), (N'5', N'2125'), (N'5', N'2126'), (N'5', N'2127'), (N'5', N'2128'), (N'5', N'2129'), (N'5', N'2130'), (N'5', N'2131'), (N'5', N'2132'), (N'5', N'2133'), (N'5', N'2134'), (N'5', N'2136'), (N'5', N'2137'), (N'5', N'2138'), (N'5', N'2139'), (N'5', N'2140'), (N'5', N'2147'), (N'5', N'2148'), (N'5', N'3031'), (N'5', N'3032'), (N'5', N'3033'), (N'5', N'3034'), (N'5', N'3035'), (N'5', N'3036'), (N'5', N'3037'), (N'5', N'3038')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_user]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_user]
GO

CREATE TABLE [dbo].[sys_user] (
  [user_id] bigint NOT NULL,
  [dept_id] bigint NULL,
  [user_name] nvarchar(30) NOT NULL,
  [nick_name] nvarchar(30) NOT NULL,
  [user_type] nvarchar(2) NULL,
  [email] nvarchar(50) NULL,
  [phonenumber] nvarchar(11) NULL,
  [sex] nchar(1) NULL,
  [avatar] nvarchar(100) NULL,
  [password] nvarchar(100) NULL,
  [status] nchar(1) NULL,
  [del_flag] nchar(1) NULL,
  [login_ip] nvarchar(128) NULL,
  [login_date] datetime2 NULL,
  [create_by] nvarchar(64) NULL,
  [create_time] datetime2 NULL,
  [update_by] nvarchar(64) NULL,
  [update_time] datetime2 NULL,
  [remark] nvarchar(500) NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'部门ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'dept_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户账号',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'user_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'nick_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户类型（00系统用户）',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'user_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户邮箱',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'email'
GO

EXEC sp_addextendedproperty
'MS_Description', N'手机号码',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'phonenumber'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户性别（0男 1女 2未知）',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'sex'
GO

EXEC sp_addextendedproperty
'MS_Description', N'头像地址',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'avatar'
GO

EXEC sp_addextendedproperty
'MS_Description', N'密码',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'password'
GO

EXEC sp_addextendedproperty
'MS_Description', N'帐号状态（0正常 1停用）',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'status'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标志（0代表存在 2代表删除）',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'del_flag'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后登录IP',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'login_ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最后登录时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'login_date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'create_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'update_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注',
'SCHEMA', N'dbo',
'TABLE', N'sys_user',
'COLUMN', N'remark'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户信息表',
'SCHEMA', N'dbo',
'TABLE', N'sys_user'
GO


-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_user] ([user_id], [dept_id], [user_name], [nick_name], [user_type], [email], [phonenumber], [sex], [avatar], [password], [status], [del_flag], [login_ip], [login_date], [create_by], [create_time], [update_by], [update_time], [remark]) VALUES (N'1', N'103', N'admin', N'蜂信管理员', N'00', N'164770707@qq.com', N'15888888888', N'0', N'', N'$2a$10$QAow7ybs74fkSWJDJkVTNeogF7mhnihF7STErt78PxDhHiNno4IUu', N'0', N'0', N'183.225.40.49', N'2025-03-26 11:18:01', N'admin', N'2021-12-15 21:36:18', N'', N'2025-03-26 11:18:01', N'管理员'), (N'2', N'100', N'fastbee-t1', N'蜂信租户壹', N'00', N'', N'15888888880', N'0', N'', N'$2a$10$BAWId9C2Nrcwklzl1Ikoau4iqL8XRGvfRjq6Wl.PXWpzwAw0sXMdK', N'0', N'0', N'61.145.97.26', N'2023-08-29 14:52:27', N'admin', N'2022-04-15 16:21:25', N'admin', N'2023-08-29 14:52:26', NULL), (N'3', N'100', N'fastbee-t2', N'蜂信租户贰', N'00', N'', N'15888888881', N'0', N'', N'$2a$10$1zMlbW7hGpzA59gpzWGO/ObeASziQ296evjMjHrYdZnxKBLU4WUum', N'0', N'0', N'127.0.0.1', N'2022-06-12 00:54:28', N'admin', N'2022-04-15 16:22:08', N'admin', N'2022-06-12 00:54:30', NULL), (N'4', N'100', N'fastbee-u1', N'蜂信用户壹', N'00', N'', N'15888888882', N'0', N'', N'$2a$10$691RJMXZ9HM4sgNTExLPfO5Nw6J6cWgCvcoF9V.jKMnPk5o/8c9VS', N'0', N'0', N'127.0.0.1', N'2023-04-12 22:26:39', N'admin', N'2022-04-15 16:22:37', N'admin', N'2023-04-12 22:26:39', NULL), (N'5', N'100', N'fastbee-u2', N'蜂信用户贰', N'00', N'', N'15888888883', N'0', N'', N'$2a$10$x3rM39rewwbi7ayvriGMEOKUHoPCqcL2CYXPLTJRCWYPVvykFIYJq', N'0', N'0', N'127.0.0.1', N'2022-06-12 00:55:45', N'admin', N'2022-04-15 16:23:13', N'admin', N'2022-06-12 00:55:46', NULL), (N'6', N'100', N'fastbee', N'游客账号', N'00', N'', N'15888888884', N'0', N'', N'$2a$10$kKeZptrTnSlm0fencX4U2eq.QiaukDs.DckiUsMCwVTxh0IS2LRQ.', N'0', N'0', N'127.0.0.1', N'2023-09-21 18:39:29', N'admin', N'2022-03-09 16:49:19', N'admin', N'2023-09-21 18:39:28', NULL), (N'7', NULL, N'shenzehui', N'shenzehui', N'00', N'', N'18257292958', N'0', N'', N'$2a$10$UYKWiQF.VWfVvuksS/DMiO234Mwtz.niU7cM/noFgwLVRl7Jjt5pa', N'0', N'2', N'39.189.61.11', N'2023-04-16 14:18:09', N'', N'2023-04-16 14:17:59', N'', N'2023-04-16 14:18:08', NULL), (N'8', NULL, N'shadow', N'shadow', N'00', N'165456465465@qq.com', N'15752221201', N'0', N'', N'$2a$10$FXSw4fufDjecEhMxYjji3.7PkrpwkliCBoQO.h8nW0Nhk0bPpxS6u', N'0', N'2', N'39.130.41.108', N'2023-09-15 17:21:33', N'', N'2023-08-23 11:34:23', N'', N'2023-09-15 17:21:32', NULL), (N'9', NULL, N'guanshubiao', N'guanshubiao', N'00', N'', N'15217628961', N'0', N'', N'$2a$10$J9kJeP/dzc/SYq8Ev1rFXOigPdN50Kq8MkCX9j56/fQwDXAUkAPYi', N'0', N'2', N'61.145.97.26', N'2023-08-29 17:33:16', N'', N'2023-08-29 14:56:19', N'', N'2023-08-29 17:33:16', NULL), (N'10', NULL, N'jamon', N'jamon', N'00', N'', N'13717112711', N'0', N'', N'$2a$10$LMASUfB9IngDi47fQ9Eh7u003VNNh4DcjdPHMyvAQ4mdLXhQgvnpu', N'0', N'2', N'61.145.97.26', N'2023-09-01 09:06:23', N'', N'2023-08-29 15:06:39', N'', N'2023-09-01 09:06:23', NULL), (N'11', N'101', N'fastbee123', N'fastbee123', N'00', N'', N'18231210622', N'0', N'', N'$2a$10$qpLuw5yAIDLV/.UCIaWRROxhtI2nYpJe/.tbIKwSmy2Pxm.vc26Ri', N'0', N'2', N'27.187.242.251', N'2023-08-31 16:22:40', N'admin', N'2023-08-31 16:22:21', N'', N'2023-08-31 16:22:40', NULL), (N'12', NULL, N'shadow', N'shadow', N'00', N'', N'15752221201', N'0', N'', N'$2a$10$QEYxDoFO6e3wuksc2d7XIOJe0UBzY0EkYR3fKfp8pYfM5bWI4.VO6', N'0', N'2', N'39.130.41.179', N'2023-09-19 10:11:00', N'', N'2023-09-19 10:10:49', N'', N'2023-09-19 10:11:00', NULL)
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_user_post]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_user_post]
GO

CREATE TABLE [dbo].[sys_user_post] (
  [user_id] bigint NOT NULL,
  [post_id] bigint NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_post',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'岗位ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_post',
'COLUMN', N'post_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户与岗位关联表',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_post'
GO


-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_user_post] ([user_id], [post_id]) VALUES (N'1', N'1'), (N'6', N'4')
GO

COMMIT
GO


-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[sys_user_role]') AND type IN ('U'))
	DROP TABLE [dbo].[sys_user_role]
GO

CREATE TABLE [dbo].[sys_user_role] (
  [user_id] bigint NOT NULL,
  [role_id] bigint NOT NULL
)
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_role',
'COLUMN', N'user_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色ID',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_role',
'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户和角色关联表',
'SCHEMA', N'dbo',
'TABLE', N'sys_user_role'
GO


-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN TRANSACTION
GO

INSERT INTO [dbo].[sys_user_role] ([user_id], [role_id]) VALUES (N'1', N'1'), (N'2', N'2'), (N'3', N'2'), (N'4', N'3'), (N'5', N'3'), (N'6', N'4')
GO

COMMIT
GO


-- ----------------------------
-- Primary Key structure for table gen_table
-- ----------------------------
ALTER TABLE [dbo].[gen_table] ADD PRIMARY KEY CLUSTERED ([table_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table gen_table_column
-- ----------------------------
ALTER TABLE [dbo].[gen_table_column] ADD PRIMARY KEY CLUSTERED ([column_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_category
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_category_index_tenant_id]
ON [dbo].[iot_category] (
  [tenant_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_category_index_parent_id]
ON [dbo].[iot_category] (
  [parent_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_category
-- ----------------------------
ALTER TABLE [dbo].[iot_category] ADD PRIMARY KEY CLUSTERED ([category_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_device
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [iot_device_index_serial_number]
ON [dbo].[iot_device] (
  [serial_number] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_index_product_id]
ON [dbo].[iot_device] (
  [product_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_index_tanant_id]
ON [dbo].[iot_device] (
  [tenant_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_index_user_id]
ON [dbo].[iot_device] (
  [user_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_index_create_time]
ON [dbo].[iot_device] (
  [create_time] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_device
-- ----------------------------
ALTER TABLE [dbo].[iot_device] ADD PRIMARY KEY CLUSTERED ([device_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table iot_device_group
-- ----------------------------
ALTER TABLE [dbo].[iot_device_group] ADD PRIMARY KEY CLUSTERED ([device_id], [group_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_device_job
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_device_job_index_device_id]
ON [dbo].[iot_device_job] (
  [device_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_job_index_product_id]
ON [dbo].[iot_device_job] (
  [product_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_job_index_scene_id]
ON [dbo].[iot_device_job] (
  [scene_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_job_index_alert_id]
ON [dbo].[iot_device_job] (
  [alert_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_job_index_serial_number]
ON [dbo].[iot_device_job] (
  [serial_number] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_device_job
-- ----------------------------
ALTER TABLE [dbo].[iot_device_job] ADD PRIMARY KEY CLUSTERED ([job_id], [job_name], [job_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_device_log
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_device_log_index_serial_number]
ON [dbo].[iot_device_log] (
  [serial_number] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_log_index_tenant_id]
ON [dbo].[iot_device_log] (
  [tenant_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_log_index_user_id]
ON [dbo].[iot_device_log] (
  [user_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_log_index_device_id]
ON [dbo].[iot_device_log] (
  [device_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [index_serialNumber_createTime]
ON [dbo].[iot_device_log] (
  [serial_number] ASC,
  [create_time] ASC
)
GO

CREATE NONCLUSTERED INDEX [index_isMonitor_serialNumber_createTime]
ON [dbo].[iot_device_log] (
  [serial_number] ASC,
  [is_monitor] ASC,
  [create_time] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_device_log
-- ----------------------------
ALTER TABLE [dbo].[iot_device_log] ADD PRIMARY KEY CLUSTERED ([log_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table iot_device_template
-- ----------------------------
ALTER TABLE [dbo].[iot_device_template] ADD PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_device_user
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_device_user_index_user_id]
ON [dbo].[iot_device_user] (
  [user_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_device_user_index_tenant_id]
ON [dbo].[iot_device_user] (
  [tenant_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_device_user
-- ----------------------------
ALTER TABLE [dbo].[iot_device_user] ADD PRIMARY KEY CLUSTERED ([device_id], [user_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table iot_event_log
-- ----------------------------
ALTER TABLE [dbo].[iot_event_log] ADD PRIMARY KEY CLUSTERED ([log_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_function_log
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [iot_function_log_id_uindex]
ON [dbo].[iot_function_log] (
  [id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_function_log
-- ----------------------------
ALTER TABLE [dbo].[iot_function_log] ADD PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_group
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_group_index_user_id]
ON [dbo].[iot_group] (
  [user_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_group
-- ----------------------------
ALTER TABLE [dbo].[iot_group] ADD PRIMARY KEY CLUSTERED ([group_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_product
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_product_index_category_id]
ON [dbo].[iot_product] (
  [category_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_product_index_tenant_id]
ON [dbo].[iot_product] (
  [tenant_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_product
-- ----------------------------
ALTER TABLE [dbo].[iot_product] ADD PRIMARY KEY CLUSTERED ([product_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_product_authorize
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_product_authorize_index_product_id]
ON [dbo].[iot_product_authorize] (
  [product_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_product_authorize_index_device_id]
ON [dbo].[iot_product_authorize] (
  [device_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_product_authorize_index_serial_number]
ON [dbo].[iot_product_authorize] (
  [serial_number] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_product_authorize_index_user_id]
ON [dbo].[iot_product_authorize] (
  [user_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_product_authorize
-- ----------------------------
ALTER TABLE [dbo].[iot_product_authorize] ADD PRIMARY KEY CLUSTERED ([authorize_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_protocol
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [UNIQUE_CODE]
ON [dbo].[iot_protocol] (
  [protocol_code] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_protocol
-- ----------------------------
ALTER TABLE [dbo].[iot_protocol] ADD PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_scene
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_scene_index_user_id]
ON [dbo].[iot_scene] (
  [user_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_scene
-- ----------------------------
ALTER TABLE [dbo].[iot_scene] ADD PRIMARY KEY CLUSTERED ([scene_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table iot_scene_script
-- ----------------------------
ALTER TABLE [dbo].[iot_scene_script] ADD PRIMARY KEY CLUSTERED ([script_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table iot_script
-- ----------------------------
ALTER TABLE [dbo].[iot_script] ADD PRIMARY KEY CLUSTERED ([script_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_social_platform
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [iot_social_platform_platform_uindex]
ON [dbo].[iot_social_platform] (
  [platform] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_social_platform
-- ----------------------------
ALTER TABLE [dbo].[iot_social_platform] ADD PRIMARY KEY CLUSTERED ([social_platform_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_social_user
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [iot_social_user_pk]
ON [dbo].[iot_social_user] (
  [social_user_id] ASC
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [iot_social_user_unique_key]
ON [dbo].[iot_social_user] (
  [uuid] ASC,
  [source] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_social_user
-- ----------------------------
ALTER TABLE [dbo].[iot_social_user] ADD PRIMARY KEY CLUSTERED ([social_user_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_things_model
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_things_model_index_product_id]
ON [dbo].[iot_things_model] (
  [product_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_things_model_index_tenant_id]
ON [dbo].[iot_things_model] (
  [tenant_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_things_model_index_model_order]
ON [dbo].[iot_things_model] (
  [model_order] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_things_model
-- ----------------------------
ALTER TABLE [dbo].[iot_things_model] ADD PRIMARY KEY CLUSTERED ([model_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table iot_things_model_template
-- ----------------------------
CREATE NONCLUSTERED INDEX [iot_things_model_template_index_tenant_id]
ON [dbo].[iot_things_model_template] (
  [tenant_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [iot_things_model_template_index_model_order]
ON [dbo].[iot_things_model_template] (
  [model_order] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table iot_things_model_template
-- ----------------------------
ALTER TABLE [dbo].[iot_things_model_template] ADD PRIMARY KEY CLUSTERED ([template_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table media_server
-- ----------------------------
ALTER TABLE [dbo].[media_server] ADD PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table news
-- ----------------------------
CREATE NONCLUSTERED INDEX [news_index_category_id]
ON [dbo].[news] (
  [category_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table news
-- ----------------------------
ALTER TABLE [dbo].[news] ADD PRIMARY KEY CLUSTERED ([news_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table news_category
-- ----------------------------
ALTER TABLE [dbo].[news_category] ADD PRIMARY KEY CLUSTERED ([category_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table oauth_client_details
-- ----------------------------
ALTER TABLE [dbo].[oauth_client_details] ADD PRIMARY KEY CLUSTERED ([client_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_blob_triggers] ADD PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_calendars
-- ----------------------------
ALTER TABLE [dbo].[qrtz_calendars] ADD PRIMARY KEY CLUSTERED ([sched_name], [calendar_name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_cron_triggers] ADD PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_fired_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_fired_triggers] ADD PRIMARY KEY CLUSTERED ([sched_name], [entry_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_job_details
-- ----------------------------
ALTER TABLE [dbo].[qrtz_job_details] ADD PRIMARY KEY CLUSTERED ([sched_name], [job_name], [job_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_locks
-- ----------------------------
ALTER TABLE [dbo].[qrtz_locks] ADD PRIMARY KEY CLUSTERED ([sched_name], [lock_name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_paused_trigger_grps
-- ----------------------------
ALTER TABLE [dbo].[qrtz_paused_trigger_grps] ADD PRIMARY KEY CLUSTERED ([sched_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_scheduler_state
-- ----------------------------
ALTER TABLE [dbo].[qrtz_scheduler_state] ADD PRIMARY KEY CLUSTERED ([sched_name], [instance_name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_simple_triggers] ADD PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_simprop_triggers] ADD PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table qrtz_triggers
-- ----------------------------
CREATE NONCLUSTERED INDEX [sched_name]
ON [dbo].[qrtz_triggers] (
  [sched_name] ASC,
  [job_name] ASC,
  [job_group] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table qrtz_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_triggers] ADD PRIMARY KEY CLUSTERED ([sched_name], [trigger_name], [trigger_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sip_config
-- ----------------------------
ALTER TABLE [dbo].[sip_config] ADD PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sip_device
-- ----------------------------
ALTER TABLE [dbo].[sip_device] ADD PRIMARY KEY CLUSTERED ([device_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sip_device_channel
-- ----------------------------
ALTER TABLE [dbo].[sip_device_channel] ADD PRIMARY KEY CLUSTERED ([id], [device_sip_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_auth_user
-- ----------------------------
ALTER TABLE [dbo].[sys_auth_user] ADD PRIMARY KEY CLUSTERED ([auth_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_config
-- ----------------------------
ALTER TABLE [dbo].[sys_config] ADD PRIMARY KEY CLUSTERED ([config_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_dept
-- ----------------------------
ALTER TABLE [dbo].[sys_dept] ADD PRIMARY KEY CLUSTERED ([dept_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_dict_data
-- ----------------------------
ALTER TABLE [dbo].[sys_dict_data] ADD PRIMARY KEY CLUSTERED ([dict_code])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Indexes structure for table sys_dict_type
-- ----------------------------
CREATE UNIQUE NONCLUSTERED INDEX [dict_type]
ON [dbo].[sys_dict_type] (
  [dict_type] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table sys_dict_type
-- ----------------------------
ALTER TABLE [dbo].[sys_dict_type] ADD PRIMARY KEY CLUSTERED ([dict_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_job
-- ----------------------------
ALTER TABLE [dbo].[sys_job] ADD PRIMARY KEY CLUSTERED ([job_id], [job_name], [job_group])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_job_log
-- ----------------------------
ALTER TABLE [dbo].[sys_job_log] ADD PRIMARY KEY CLUSTERED ([job_log_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_logininfor
-- ----------------------------
ALTER TABLE [dbo].[sys_logininfor] ADD PRIMARY KEY CLUSTERED ([info_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_menu
-- ----------------------------
ALTER TABLE [dbo].[sys_menu] ADD PRIMARY KEY CLUSTERED ([menu_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_notice
-- ----------------------------
ALTER TABLE [dbo].[sys_notice] ADD PRIMARY KEY CLUSTERED ([notice_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_oper_log
-- ----------------------------
ALTER TABLE [dbo].[sys_oper_log] ADD PRIMARY KEY CLUSTERED ([oper_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_post
-- ----------------------------
ALTER TABLE [dbo].[sys_post] ADD PRIMARY KEY CLUSTERED ([post_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE [dbo].[sys_role] ADD PRIMARY KEY CLUSTERED ([role_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_role_dept
-- ----------------------------
ALTER TABLE [dbo].[sys_role_dept] ADD PRIMARY KEY CLUSTERED ([role_id], [dept_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_role_menu
-- ----------------------------
ALTER TABLE [dbo].[sys_role_menu] ADD PRIMARY KEY CLUSTERED ([role_id], [menu_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE [dbo].[sys_user] ADD PRIMARY KEY CLUSTERED ([user_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_user_post
-- ----------------------------
ALTER TABLE [dbo].[sys_user_post] ADD PRIMARY KEY CLUSTERED ([user_id], [post_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE [dbo].[sys_user_role] ADD PRIMARY KEY CLUSTERED ([user_id], [role_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_blob_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_blob_triggers] ADD CONSTRAINT [QRTZ_BLOB_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [trigger_name], [trigger_group]) REFERENCES [dbo].[qrtz_triggers] ([sched_name], [trigger_name], [trigger_group])
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_cron_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_cron_triggers] ADD CONSTRAINT [QRTZ_CRON_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [trigger_name], [trigger_group]) REFERENCES [dbo].[qrtz_triggers] ([sched_name], [trigger_name], [trigger_group])
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_simple_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_simple_triggers] ADD CONSTRAINT [QRTZ_SIMPLE_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [trigger_name], [trigger_group]) REFERENCES [dbo].[qrtz_triggers] ([sched_name], [trigger_name], [trigger_group])
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_simprop_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_simprop_triggers] ADD CONSTRAINT [QRTZ_SIMPROP_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [trigger_name], [trigger_group]) REFERENCES [dbo].[qrtz_triggers] ([sched_name], [trigger_name], [trigger_group])
GO


-- ----------------------------
-- Foreign Keys structure for table qrtz_triggers
-- ----------------------------
ALTER TABLE [dbo].[qrtz_triggers] ADD CONSTRAINT [QRTZ_TRIGGERS_ibfk_1] FOREIGN KEY ([sched_name], [job_name], [job_group]) REFERENCES [dbo].[qrtz_job_details] ([sched_name], [job_name], [job_group])
GO

