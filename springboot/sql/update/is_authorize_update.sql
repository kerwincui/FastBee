ALTER TABLE `iot_product` 
ADD COLUMN `is_authorize` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用授权码（0-否，1-是）' AFTER `is_sys`;

CREATE TABLE `iot_product_authorize`  (
  `authorize_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '授权码ID',
  `authorize_code` varchar(32) NOT NULL COMMENT '授权码',
  `product_id` bigint NOT NULL COMMENT '产品ID',
  `device_id` bigint NULL COMMENT '设备ID',
  `serial_number` varchar(64) NULL COMMENT '设备编号',
  `user_id` bigint NULL COMMENT '用户ID',
  `user_name` varchar(30) NULL COMMENT '用户名称',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`authorize_id`)
) COMMENT = '产品授权码表';