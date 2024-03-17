-- ----------------------------
-- 清空日志表中数据
-- ----------------------------
delete from `iot_alert_log`;
delete from `iot_device_log`;
delete from `iot_event_log`;
delete from `iot_function_log`;
delete from `iot_simulate_log`;
delete from `sys_job_log`;
delete from `sys_logininfor`;
delete from `sys_oper_log`;

-- ----------------------------
-- 设置清空的表主键取消自增
-- ----------------------------
ALTER TABLE `iot_alert_log` MODIFY COLUMN `alert_log_id` bigint(20) NOT NULL COMMENT '告警日志ID';
ALTER TABLE `iot_device_log` MODIFY COLUMN `log_id` bigint(20) NOT NULL COMMENT '设备监测信息ID';
ALTER TABLE `iot_event_log` MODIFY COLUMN `log_id` bigint(20) NOT NULL COMMENT '设备事件日志ID';
ALTER TABLE `iot_function_log` MODIFY COLUMN `id` bigint(20) NOT NULL COMMENT '设备功能日志ID';
ALTER TABLE `iot_simulate_log` MODIFY COLUMN `log_id` bigint(20) NOT NULL COMMENT '设备模拟日志ID';
ALTER TABLE `sys_job_log` MODIFY COLUMN `job_log_id` bigint(20) NOT NULL COMMENT '任务日志ID';
ALTER TABLE `sys_logininfor` MODIFY COLUMN `info_id` bigint(20) NOT NULL COMMENT '访问ID';
ALTER TABLE `sys_oper_log` MODIFY COLUMN `oper_id` bigint(20) NOT NULL COMMENT '操作日志ID';

-- ----------------------------
-- 设置清空的表主键ID自增
-- ----------------------------
ALTER TABLE `iot_alert_log` MODIFY COLUMN `alert_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '告警日志ID';
ALTER TABLE `iot_device_log` MODIFY COLUMN `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备监测信息ID';
ALTER TABLE `iot_event_log` MODIFY COLUMN `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备事件日志ID';
ALTER TABLE `iot_function_log` MODIFY COLUMN `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备功能日志ID';
ALTER TABLE `iot_simulate_log` MODIFY COLUMN `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备模拟日志ID';
ALTER TABLE `sys_job_log` MODIFY COLUMN `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID';
ALTER TABLE `sys_logininfor` MODIFY COLUMN `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID';
ALTER TABLE `sys_oper_log` MODIFY COLUMN `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '操作日志ID';


-- ----------------------------
-- 重置其他表的自增ID
-- ----------------------------
ALTER TABLE `iot_device` MODIFY COLUMN `device_id` bigint(20) NOT NULL COMMENT '设备ID';
ALTER TABLE `iot_device` MODIFY COLUMN `device_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备ID';

ALTER TABLE `iot_device_job` MODIFY COLUMN `job_id` bigint(20) NOT NULL COMMENT '任务ID';
ALTER TABLE `iot_device_job` MODIFY COLUMN `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID';

ALTER TABLE `iot_group` MODIFY COLUMN `group_id` bigint(20) NOT NULL COMMENT '分组ID';
ALTER TABLE `iot_group` MODIFY COLUMN `group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分组ID';

ALTER TABLE `iot_product` MODIFY COLUMN `product_id` bigint(20) NOT NULL COMMENT '产品ID';
ALTER TABLE `iot_product` MODIFY COLUMN `product_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '产品ID';

ALTER TABLE `iot_product_authorize` MODIFY COLUMN `authorize_id` bigint(20) NOT NULL COMMENT '授权码ID';
ALTER TABLE `iot_product_authorize` MODIFY COLUMN `authorize_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '授权码ID';

ALTER TABLE `iot_protocol` MODIFY COLUMN `id` bigint(20) NOT NULL COMMENT '自增id';
ALTER TABLE `iot_protocol` MODIFY COLUMN `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id';

ALTER TABLE `iot_scene` MODIFY COLUMN `scene_id` bigint(20) NOT NULL COMMENT '场景ID';
ALTER TABLE `iot_scene` MODIFY COLUMN `scene_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '场景ID';

ALTER TABLE `iot_scene_trigger` MODIFY COLUMN `scene_trigger_id` bigint(20) NOT NULL COMMENT '场景触发器ID';
ALTER TABLE `iot_scene_trigger` MODIFY COLUMN `scene_trigger_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '场景触发器ID';

ALTER TABLE `iot_things_model` MODIFY COLUMN `model_id` bigint(20) NOT NULL COMMENT '物模型ID';
ALTER TABLE `iot_things_model` MODIFY COLUMN `model_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物模型ID';

ALTER TABLE `iot_things_model_template` MODIFY COLUMN `template_id` bigint(20) NOT NULL COMMENT '物模型ID';
ALTER TABLE `iot_things_model_template` MODIFY COLUMN `template_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '物模型ID';

ALTER TABLE `iot_var_temp` MODIFY COLUMN `template_id` bigint(20) NOT NULL COMMENT '主键id';
ALTER TABLE `iot_var_temp` MODIFY COLUMN `template_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id';

ALTER TABLE `iot_firmware` MODIFY COLUMN `firmware_id` bigint(20) NOT NULL COMMENT '固件ID';
ALTER TABLE `iot_firmware` MODIFY COLUMN `firmware_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '固件ID';

ALTER TABLE `iot_firmware_task` MODIFY COLUMN `id` bigint(20) NOT NULL COMMENT '主键';
ALTER TABLE `iot_firmware_task` MODIFY COLUMN `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER TABLE `iot_firmware_task_detail` MODIFY COLUMN `id` bigint(20) NOT NULL COMMENT '主键';
ALTER TABLE `iot_firmware_task_detail` MODIFY COLUMN `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER TABLE `sys_user` MODIFY COLUMN `user_id` bigint(20) NOT NULL COMMENT '用户ID';
ALTER TABLE `sys_user` MODIFY COLUMN `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID';

ALTER TABLE `sys_menu` MODIFY COLUMN `menu_id` bigint(20) NOT NULL COMMENT '菜单ID';
ALTER TABLE `sys_menu` MODIFY COLUMN `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID';

ALTER TABLE `sys_dict_type` MODIFY COLUMN `dict_id` bigint(20) NOT NULL COMMENT '字典主键';
ALTER TABLE `sys_dict_type` MODIFY COLUMN `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键';

ALTER TABLE `sys_dict_data` MODIFY COLUMN `dict_code` bigint(20) NOT NULL COMMENT '字典编码';
ALTER TABLE `sys_dict_data` MODIFY COLUMN `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码';

ALTER TABLE `sip_config` MODIFY COLUMN `id` bigint(20) NOT NULL COMMENT '主键';
ALTER TABLE `sip_config` MODIFY COLUMN `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER TABLE `sip_device` MODIFY COLUMN `device_id` bigint(20) NOT NULL COMMENT '设备ID';
ALTER TABLE `sip_device` MODIFY COLUMN `device_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备ID';

ALTER TABLE `sip_device_channel` MODIFY COLUMN `id` bigint(20) NOT NULL COMMENT '主键';
ALTER TABLE `sip_device_channel` MODIFY COLUMN `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';

ALTER TABLE `news` MODIFY COLUMN `news_id` bigint(20) NOT NULL COMMENT '新闻ID';
ALTER TABLE `news` MODIFY COLUMN `news_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '新闻ID';

ALTER TABLE `news_category` MODIFY COLUMN `category_id` bigint(20) NOT NULL COMMENT '分类ID';
ALTER TABLE `news_category` MODIFY COLUMN `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类ID';


