
create database root.ln
DELETE database root.ln

count databases root.ln
// 创建测点
CREATE timeseries root.ln.device_log.log_type WITH DATATYPE=INT32, ENCODING=RLE;
CREATE timeseries root.ln.device_log.log_value WITH DATATYPE=TEXT, ENCODING=PLAIN;
CREATE timeseries root.ln.device_log.device_id WITH DATATYPE=INT64, ENCODING=RLE;
CREATE timeseries root.ln.device_log.device_name WITH DATATYPE=TEXT, ENCODING=PLAIN;
CREATE timeseries root.ln.device_log.serial_number WITH DATATYPE=TEXT, ENCODING=PLAIN;
CREATE timeseries root.ln.device_log.identify WITH DATATYPE=TEXT, ENCODING=PLAIN;
CREATE timeseries root.ln.device_log.create_by WITH DATATYPE=TEXT, ENCODING=PLAIN;
CREATE timeseries root.ln.device_log.is_monitor WITH DATATYPE=INT32, ENCODING=RLE;
CREATE timeseries root.ln.device_log.mode WITH DATATYPE=INT32, ENCODING=RLE;
CREATE timeseries root.ln.device_log.tenant_id WITH DATATYPE=INT32, ENCODING=RLE;
CREATE timeseries root.ln.device_log.remark WITH DATATYPE=TEXT, ENCODING=PLAIN;

-- // 删除测点
-- delete timeseries root.ln.device_log.**
-- drop timeseries root.ln.device_log.**
--
-- // 设置ttl
-- set ttl to root.ln 360000
-- unset ttl from root.ln
--
-- // 创建设备模板
-- create device template t1 (temperature FLOAT encoding=RLE, status BOOLEAN encoding=PLAIN compression=SNAPPY)
-- create device template t2 aligned (lat FLOAT encoding=Gorilla, lon FLOAT encoding=Gorilla)

-- set device template t1 to root.device_log.sn1
-- set device template t2 to root.device_log.sn2

-- create timeseries using device template on root.device_log.sn1
-- create timeseries using device template on root.device_log.sn2

-- // 解绑设备模板
-- delete timeseries of device template t1 from root.device_log.sn1
-- deactivate device template t1 from root.device_log.sn1
-- unset device template t1 from root.device_log.sn1

-- // 删除设备模板
-- drop device template t1

-- // 查看设备模板
-- show device templates
-- show nodes in device template t1
-- show nodes in device template t2
-- show paths set device template t1
-- show paths using device template t1

-- // 插入数据
-- insert into root.device_log.sn3(tenant_id,device_id,device_name,log_type,log_value,identify,is_monitor,mode,model_name,remark,create_by)
--        values(1,1,'设备1',1,'100','1',1,1,'设备1','备注','admin')
--
-- insert into root.device_log.sn4(tenant_id,device_id,device_name,log_type,log_value,identify,is_monitor,mode,model_name,remark,create_by)
--        values(1,1,'设备2',1,'100','1',1,1,'设备2','备注','admin');
-- insert into root.device_log.sn4(tenant_id,device_id,device_name,log_type,log_value,identify,is_monitor,mode,model_name,remark,create_by)
--        values(1,1,'设备2',1,'101','1',1,1,'设备2','备注','admin')

-- // 查询插入数据
-- select * from root.device_log.sn3
-- select * from root.device_log.sn4
-- select * from root.device_log.D1ELV3A5TOJS
