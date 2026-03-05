package com.fastbee.iot.tsdb.service.impl;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.*;
import com.fastbee.iot.tsdb.config.InfluxConfig;
import com.fastbee.iot.tsdb.service.ILogService;
import com.fastbee.iot.tsdb.model.TdLogDto;
import com.fastbee.iot.util.SnowflakeIdWorker;
import com.influxdb.client.InfluxDBClient;
import com.influxdb.client.QueryApi;
import com.influxdb.client.WriteApiBlocking;
import com.influxdb.client.domain.WritePrecision;
import com.influxdb.client.write.Point;
import com.influxdb.query.FluxRecord;
import com.influxdb.query.FluxTable;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @Author gx_ma
 * @Date: 2025/03/04/ 11:16
 * @description
 */
@Slf4j
@Primary
@ConditionalOnProperty(name = "spring.datasource.dynamic.datasource.influx.enabled", havingValue = "true")
@DS("influx")
@Service("Influx")
public class InfluxLogService implements ILogService {

    @Resource
    private InfluxConfig influxConfig;

    @Resource
    private InfluxDBClient influxDBClient;

    @Resource
    private WriteApiBlocking writeApi;

    private SnowflakeIdWorker snowflakeIdWorker = new SnowflakeIdWorker(1);

    @Override
    public int createSTable(String database) {
        return 0;
    }

    @Override
    public int saveDeviceLog(DeviceLog deviceLog) {
        long logId = snowflakeIdWorker.nextId();
        deviceLog.setLogId(logId);
        Point point = Point.measurement(influxConfig.getMeasurement())
                .addTag("serialNumber", deviceLog.getSerialNumber())
                .addField("logId", deviceLog.getLogId())
                .addField("logType", deviceLog.getLogType())
                .addField("logValue", deviceLog.getLogValue())
                .addField("deviceId", deviceLog.getDeviceId())
                .addField("deviceName", deviceLog.getDeviceName())
                .addField("identify", deviceLog.getIdentify())
                .addField("createBy", deviceLog.getCreateBy())
                .addField("isMonitor", deviceLog.getIsMonitor())
                .addField("mode", deviceLog.getMode())
                .addField("remark", deviceLog.getRemark())
                .addField("userId", deviceLog.getUserId())
                .addField("userName", deviceLog.getUserName())
                .addField("tenantId", deviceLog.getTenantId())
                .addField("tenantName", deviceLog.getTenantName())
                .addField("modelName", deviceLog.getModelName())
                .time(deviceLog.getCreateTime().toInstant(), WritePrecision.NS);
        writeApi.writePoint(influxConfig.getBucket(), influxConfig.getOrg(), point);
        return 1;
    }

    @Override
    public int saveBatch(TdLogDto dto) {
        int ret = 0;
        for (DeviceLog deviceLog : dto.getList()) {
            ret += this.saveDeviceLog(deviceLog);
        }
        return ret;
    }

    @Override
    public int deleteDeviceLogByDeviceNumber(String deviceNumber) {
        QueryApi queryApi = influxDBClient.getQueryApi();

        // 查询待删除的日志数量
        String countQuery = String.format(
                "from(bucket: \"%s\")\n" +
                        "  |> range(start: 0)\n" +
                        "  |> filter(fn: (r) => r._measurement == \"%s\")\n" +
                        "  |> filter(fn: (r) => r.serialNumber == \"%s\")\n" +
                        "  |> limit(n: 1)\n" +
                        "  |> count()",
                influxConfig.getBucket(),
                influxConfig.getMeasurement(),
                deviceNumber
        );

        long count = queryApi.queryRaw(countQuery, influxConfig.getOrg()).length();

        if (count > 0) {
            // 构建删除语句
            String deleteQuery = String.format(
                    "import \"influxdata/influxdb/schema\"\n" +
                            "schema.delete(\n" +
                            "  bucket: \"%s\",\n" +
                            "  predicate: (r) => r.serialNumber == \"%s\" and r._measurement == \"%s\",\n" +
                            "  start: 0,\n" +
                            "  stop: now()\n" +
                            ")",
                    influxConfig.getBucket(),
                    deviceNumber,
                    influxConfig.getMeasurement()
            );

            try {
                queryApi.queryRaw(deleteQuery, influxConfig.getOrg());
            } catch (Exception e) {
                log.error("Failed to delete logs for device: {}", deviceNumber, e);
                return 0;
            }
        }

        return (int) count;
    }

    @Override
    public DeviceStatistic selectCategoryLogCount(Device device) {
        DeviceStatistic statistic = new DeviceStatistic();
        Long property = this.selectPropertyLogCount(device);
        Long event = this.selectEventLogCount(device);
        Long monitor = this.selectMonitorLogCount(device);
        statistic.setPropertyCount(property == null ? 0 : property);
        statistic.setEventCount(event == null ? 0 : event);
        statistic.setMonitorCount(monitor == null ? 0 : monitor);
        return statistic;
    }

    private Long selectMonitorLogCount(Device device) {
        QueryApi queryApi = influxDBClient.getQueryApi();
        // 构建 Flux 查询语句
        StringBuilder fluxQuery = new StringBuilder();
        fluxQuery.append("from(bucket: \"").append(influxConfig.getBucket()).append("\")\n")
                .append("  |> range(start: 0)\n")
                .append("  |> filter(fn: (r) => r[\"_measurement\"] == \"").append(influxConfig.getMeasurement()).append("\")\n")
                .append("  |> pivot(rowKey: [\"_time\"], columnKey: [\"_field\"], valueColumn: \"_value\") ")
                .append("  |> filter(fn: (r) => r[\"logType\"] == 1 and r[\"isMonitor\"] == 1)");
        if (device.getTenantId() != null) {
            fluxQuery.append("  |> filter(fn: (r) => r[\"tenantId\"] == ").append(device.getTenantId()).append(")");
        }
        if (!Objects.isNull(device.getCreateBy())) {
            fluxQuery.append("  |> filter(fn: (r) => r[\"createBy\"] == \"").append(device.getCreateBy()).append("\")");
        }
        fluxQuery.append("  |> group()").append("  |> count(column: \"mode\")");

        // 执行查询
        System.out.println("Monitor查询条件Flux Query: " + fluxQuery);
        List<FluxTable> tables = queryApi.query(fluxQuery.toString());
        // 处理查询结果
            if (!tables.isEmpty() && !tables.get(0).getRecords().isEmpty()) {
                FluxRecord record = tables.get(0).getRecords().get(0);
                return record.getValueByKey("mode") != null ? ((Long) record.getValueByKey("mode")) : 0L;
            }
        return 0L;
    }

    private Long selectEventLogCount(Device device) {
        QueryApi queryApi = influxDBClient.getQueryApi();
        StringBuilder fluxQuery = new StringBuilder();
        fluxQuery.append("from(bucket: \"").append(influxConfig.getBucket()).append("\")\n")
                .append("  |> range(start: 0)\n")
                .append("  |> filter(fn: (r) => r[\"_measurement\"] == \"").append(influxConfig.getMeasurement()).append("\")\n")
                .append("  |> pivot(rowKey: [\"_time\"], columnKey: [\"_field\"], valueColumn: \"_value\") ")
                .append("  |> filter(fn: (r) => r[\"logType\"] == 3)");

        if (device.getTenantId() != null) {
            fluxQuery.append("  |> filter(fn: (r) => r[\"tenantId\"] == ").append(device.getTenantId()).append(")");
        }
        if (!Objects.isNull(device.getCreateBy())) {
            fluxQuery.append("  |> filter(fn: (r) => r[\"createBy\"] == \"").append(device.getCreateBy()).append("\")");
        }

        fluxQuery.append("|> group()").append("|> count(column: \"mode\")\n");

        List<FluxTable> tables = queryApi.query(fluxQuery.toString());
        System.out.println("Event查询条件Flux Query: " + fluxQuery);
        if (!tables.isEmpty() && !tables.get(0).getRecords().isEmpty()) {
            FluxRecord record = tables.get(0).getRecords().get(0);
            return record.getValueByKey("mode") != null ? ((Long) record.getValueByKey("mode")) : 0L;
        }
        return 0L;
    }

    private Long selectPropertyLogCount(Device device) {
        QueryApi queryApi = influxDBClient.getQueryApi();
        StringBuilder fluxQuery = new StringBuilder();
        fluxQuery.append("from(bucket: \"").append(influxConfig.getBucket()).append("\")\n")
                .append("  |> range(start: 0)\n")
                .append("  |> filter(fn: (r) => r[\"_measurement\"] == \"").append(influxConfig.getMeasurement()).append("\")\n")
                .append("  |> pivot(rowKey: [\"_time\"], columnKey: [\"_field\"], valueColumn: \"_value\") ")
                .append("  |> filter(fn: (r) => r[\"logType\"] == 1)\n");

        if (device.getTenantId() != null) {
            fluxQuery.append("  |> filter(fn: (r) => r[\"tenantId\"] == ").append(device.getTenantId()).append(")");
        }
        if (!Objects.isNull(device.getCreateBy())) {
            fluxQuery.append("  |> filter(fn: (r) => r[\"createBy\"] == \"").append(device.getCreateBy()).append("\")");
        }
        fluxQuery.append("|> group()").append("  |> count(column: \"mode\")\n");

        List<FluxTable> tables = queryApi.query(fluxQuery.toString());
        System.out.println("Property查询条件 Flux Query: " + fluxQuery);
        if (!tables.isEmpty() && !tables.get(0).getRecords().isEmpty()) {
            FluxRecord record = tables.get(0).getRecords().get(0);
            return record.getValueByKey("mode") != null ? ((Long) record.getValueByKey("mode")) : 0L;
        }
        return 0L;
    }

    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog) {
        QueryApi queryApi = influxDBClient.getQueryApi();

        StringBuilder fluxQuery = new StringBuilder();
        fluxQuery.append("from(bucket: \"").append(influxConfig.getBucket()).append("\") ")
                .append("|> range(start: 0) ")
                .append("|> filter(fn: (r) => r._measurement == \"").append(influxConfig.getMeasurement()).append("\") ");

        fluxQuery.append("|> pivot(\n" +
                "            rowKey:[\"_time\"], \n" +
                "            columnKey: [\"_field\"], \n" +
                "            valueColumn: \"_value\"\n" +
                "        )");
        fluxQuery.append("|> sort(columns: [\"_time\"], desc: true)")
                .append("|> group()");

        List<String> filterConditions = new ArrayList<>();
        if (deviceLog.getIsMonitor() != null) {
            filterConditions.add("r.isMonitor == " + deviceLog.getIsMonitor());
        }
        if (deviceLog.getSerialNumber() != null && !deviceLog.getSerialNumber().isEmpty()) {
            filterConditions.add("r.serialNumber == \"" + deviceLog.getSerialNumber() + "\"");
        }
        if (deviceLog.getLogType() != null) {
            filterConditions.add("r.logType == " + deviceLog.getLogType());
        } else {
            filterConditions.add("r.logType != 7");
        }
        if (deviceLog.getIdentify() != null && !deviceLog.getIdentify().isEmpty()) {
            filterConditions.add("r.identify =~ /.*" + deviceLog.getIdentify() + ".*/");
        }

        fluxQuery.append("|> filter(fn: (r) => ");
        for (int i = 0; i < filterConditions.size(); i++) {
            if (i > 0) {
                fluxQuery.append(" and ");
            }
            fluxQuery.append(filterConditions.get(i));
        }
        fluxQuery.append(") ");

        // 计算偏移量
        int pageNum = deviceLog.getPageNum();
        int pageSize = deviceLog.getPageSize();
        int offset = (pageNum - 1) * pageSize;
        // 添加分页查询
        StringBuilder originalQuery = new StringBuilder(fluxQuery);
        originalQuery.append("|> limit(n: ").append(pageSize).append(", offset: ").append(offset).append(")");

        List<FluxTable> tables = queryApi.query(originalQuery.toString());

        List<DeviceLog> deviceLogList = new ArrayList<>();
        for (FluxTable table : tables) {
            for (FluxRecord record : table.getRecords()) {
                DeviceLog log = new DeviceLog();
                setDeviceLog(deviceLogList, record, log);
            }
        }
        return deviceLogList;

        // 注意：由于使用了 limit 和 offset，这里无法直接获取总记录数，需要额外查询
//        List<FluxTable> countTables = queryApi.query(fluxQuery.toString());
//        long total = 0;
//        if (!countTables.isEmpty() && !countTables.get(0).getRecords().isEmpty()) {
//            total = countTables.get(0).getRecords().size();
//        }
//        // 创建 MyBatis-Plus 的 Page 对象
//        Page<DeviceLog> page = new Page<>(deviceLog.getPageNum(), deviceLog.getPageSize());
//        page.setRecords(deviceLogList);
//        page.setTotal(total);
//        return page;
    }

    private void setDeviceLog(List<DeviceLog> deviceLogList, FluxRecord record, DeviceLog log) {
        log.setLogId((Long) record.getValueByKey("logId"));
        log.setLogType(((Number) Objects.requireNonNull(record.getValueByKey("logType"))).intValue());
        log.setLogValue((String) record.getValueByKey("logValue"));
        log.setDeviceId((Long) record.getValueByKey("deviceId"));
        log.setDeviceName((String) record.getValueByKey("deviceName"));
        log.setSerialNumber((String) record.getValueByKey("serialNumber"));
        log.setIdentify((String) record.getValueByKey("identify"));
        log.setCreateBy((String) record.getValueByKey("createBy"));
        log.setIsMonitor(((Number) Objects.requireNonNull(record.getValueByKey("isMonitor"))).intValue());
        log.setMode(((Number) Objects.requireNonNull(record.getValueByKey("mode"))).intValue());
        log.setCreateTime(Date.from(Objects.requireNonNull(record.getTime())));
        log.setRemark((String) record.getValueByKey("remark"));
        log.setUserId((Long) record.getValueByKey("userId"));
        log.setUserName((String) record.getValueByKey("userName"));
        log.setTenantId((Long) record.getValueByKey("tenantId"));
        log.setTenantName((String) record.getValueByKey("tenantName"));
        log.setModelName((String) record.getValueByKey("modelName"));
        deviceLogList.add(log);
    }


//    @Override
//    public Page<DeviceLog> selectEventLogList(DeviceLog deviceLog) {
//        //事件日志的时间筛选，时间范围放在param参数中格式：yyyy-MM-dd，需要自行封装 HH:mm:ss
//        if (deviceLog.getParams().get("beginTime") != null && deviceLog.getParams().get("beginTime") != "" && deviceLog.getParams().get("endTime") != null && deviceLog.getParams().get("endTime") != "") {
//            String beginTime = deviceLog.getParams().get("beginTime").toString();
//            String endTime = deviceLog.getParams().get("endTime").toString();
//            beginTime = beginTime + " 00:00:00";
//            endTime = endTime + " 23:59:59";
//            deviceLog.setBeginTime(beginTime);
//            deviceLog.setEndTime(endTime);
//        }
//        QueryApi queryApi = influxDBClient.getQueryApi();
//
//        StringBuilder fluxQuery = new StringBuilder();
//        fluxQuery.append("from(bucket: \"").append(influxConfig.getBucket()).append("\") ");
//
//        // 处理时间范围
//        if (deviceLog.getBeginTime() != null && !deviceLog.getBeginTime().isEmpty()
//                && deviceLog.getEndTime() != null && !deviceLog.getEndTime().isEmpty()) {
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            try {
//                Date beginDate = sdf.parse(deviceLog.getBeginTime());
//                Date endDate = sdf.parse(deviceLog.getEndTime());
//                // 转换为RFC3339格式时间字符串
//                String startRFC3339 = beginDate.toInstant().toString();
//                String stopRFC3339 = endDate.toInstant().toString();
//
//                fluxQuery.append("|> range(start: ")
//                        .append(startRFC3339)
//                        .append(", stop: ")
//                        .append(stopRFC3339)
//                        .append(") ");
//            } catch (ParseException e) {
//                e.printStackTrace();
//                // 若解析失败，可使用默认时间范围
//                fluxQuery.append("|> range(start: 0) ");
//            }
//        } else {
//            fluxQuery.append("|> range(start: 0) ");
//        }
//
//        fluxQuery.append("|> filter(fn: (r) => r._measurement == \"").append(influxConfig.getMeasurement()).append("\") ");
//
//        // 原始查询添加 pivot 和分页操作
//        fluxQuery.append("|> pivot(\n" +
//                "            rowKey:[\"_time\"], \n" +
//                "            columnKey: [\"_field\"], \n" +
//                "            valueColumn: \"_value\"\n" +
//                "        )");
//
//        List<String> filterConditions = new ArrayList<>();
//        if (deviceLog.getIsMonitor() != null) {
//            filterConditions.add("r.isMonitor == " + deviceLog.getIsMonitor());
//        }
//        if (deviceLog.getLogType() != null) {
//            filterConditions.add("r.logType == " + deviceLog.getLogType());
//        } else {
//            filterConditions.add("r.logType != 1 and r.logType != 2 and r.logType != 4 and r.logType != 7");
//        }
//        if (deviceLog.getSerialNumber() != null && !deviceLog.getSerialNumber().isEmpty()) {
//            filterConditions.add("r.serialNumber == \"" + deviceLog.getSerialNumber() + "\"");
//        }
//        if (deviceLog.getIdentify() != null && !deviceLog.getIdentify().isEmpty()) {
//            filterConditions.add("r.identify =~ /.*" + deviceLog.getIdentify() + ".*/");
//        }
//
//        fluxQuery.append("|> filter(fn: (r) => ");
//        for (int i = 0; i < filterConditions.size(); i++) {
//            if (i > 0) {
//                fluxQuery.append(" and ");
//            }
//            fluxQuery.append(filterConditions.get(i));
//        }
//        fluxQuery.append(") ");
//        fluxQuery.append("|> sort(columns: [\"_time\"], desc: true)")
//                .append("|> group()");
//
//        // 计算偏移量
//        int pageNum = deviceLog.getPageNum();
//        int pageSize = deviceLog.getPageSize();
//        int offset = (pageNum - 1) * pageSize;
//        // 添加分页查询
//        StringBuilder originalQuery = new StringBuilder(fluxQuery);
//        originalQuery.append("|> limit(n: ").append(pageSize).append(", offset: ").append(offset).append(")");
//
//        List<FluxTable> tables = queryApi.query(originalQuery.toString());
//        System.out.println("EventList查询Flux语句：" + originalQuery);
//
//        List<DeviceLog> deviceLogList = new ArrayList<>();
//        for (FluxTable table : tables) {
//            for (FluxRecord record : table.getRecords()) {
//                DeviceLog log = new DeviceLog();
//                setDeviceLog(deviceLogList, record, log);
//            }
//        }
//
//        // 注意：由于使用了 limit 和 offset，这里无法直接获取总记录数，需要额外查询
//        List<FluxTable> countTables = queryApi.query(fluxQuery.toString());
//        System.out.println("分页查询Flux语句：" + fluxQuery);
//        long total = 0;
//        if (!countTables.isEmpty() && !countTables.get(0).getRecords().isEmpty()) {
//            total = (long) countTables.get(0).getRecords().size();
//        }
//
//        Page<DeviceLog> page = new Page<>(deviceLog.getPageNum(), deviceLog.getPageSize());
//        page.setRecords(deviceLogList);
//        page.setTotal(total);
//        return page;
//    }

    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog) {
        QueryApi queryApi = influxDBClient.getQueryApi();
        StringBuilder fluxQuery = new StringBuilder();
        fluxQuery.append("from(bucket: \"").append(influxConfig.getBucket()).append("\") ");

        // 处理时间范围
        if (deviceLog.getBeginTime() != null && !deviceLog.getBeginTime().isEmpty()
                && deviceLog.getEndTime() != null && !deviceLog.getEndTime().isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                Date beginDate = sdf.parse(deviceLog.getBeginTime());
                Date endDate = sdf.parse(deviceLog.getEndTime());
                // 转换为RFC3339格式时间字符串
                String startRFC3339 = beginDate.toInstant().toString();
                String stopRFC3339 = endDate.toInstant().toString();

                fluxQuery.append("|> range(start: ")
                        .append(startRFC3339)
                        .append(", stop: ")
                        .append(stopRFC3339)
                        .append(") ");
            } catch (ParseException e) {
                e.printStackTrace();
                // 若解析失败，可使用默认时间范围
                fluxQuery.append("|> range(start: 0) ");
            }
        } else {
            fluxQuery.append("|> range(start: 0) ");
        }

        fluxQuery.append("|> filter(fn: (r) => r._measurement == \"").append(influxConfig.getMeasurement()).append("\") ");
        fluxQuery.append("|> pivot(\n" +
                "            rowKey:[\"_time\"], \n" +
                "            columnKey: [\"_field\"], \n" +
                "            valueColumn: \"_value\"\n" +
                "        )");
        fluxQuery.append("|> filter(fn: (r) => r.isMonitor == 1) ");

        List<String> filterConditions = new ArrayList<>();
        if (deviceLog.getSerialNumber() != null && !deviceLog.getSerialNumber().isEmpty()) {
            filterConditions.add("r.serialNumber == \"" + deviceLog.getSerialNumber() + "\"");
        }
        if (deviceLog.getIdentify() != null && !deviceLog.getIdentify().isEmpty()) {
            filterConditions.add("r.identify =~ /.*" + deviceLog.getIdentify() + ".*/");
        }

        if (!filterConditions.isEmpty()) {
            fluxQuery.append("|> filter(fn: (r) => ");
            for (int i = 0; i < filterConditions.size(); i++) {
                if (i > 0) {
                    fluxQuery.append(" and ");
                }
                fluxQuery.append(filterConditions.get(i));
            }
            fluxQuery.append(") ");
        }

        fluxQuery.append("|> sort(columns: [\"_time\"], desc: true) ");
        fluxQuery.append("|> keep(columns: [\"_value\", \"_time\"]) ");

        List<FluxTable> tables = queryApi.query(fluxQuery.toString());

        List<MonitorModel> monitorList = new ArrayList<>();
        for (FluxTable table : tables) {
            for (FluxRecord record : table.getRecords()) {
                MonitorModel model = new MonitorModel();
                model.setValue((String) record.getValue());
                model.setTime(new Date(record.getTime().getEpochSecond() * 1000));
                monitorList.add(model);
            }
        }
        return monitorList;
    }

    @Override
    public List<HistoryModel> listHistory(DeviceLog deviceLog) {
        QueryApi queryApi = influxDBClient.getQueryApi();

        StringBuilder fluxQuery = new StringBuilder();
        fluxQuery.append("from(bucket: \"").append(influxConfig.getBucket()).append("\") ");

        // 处理时间范围
        if (deviceLog.getBeginTime() != null && !deviceLog.getBeginTime().isEmpty()
                && deviceLog.getEndTime() != null && !deviceLog.getEndTime().isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                Date beginDate = sdf.parse(deviceLog.getBeginTime());
                Date endDate = sdf.parse(deviceLog.getEndTime());
                // 转换为RFC3339格式时间字符串
                String startRFC3339 = beginDate.toInstant().toString();
                String stopRFC3339 = endDate.toInstant().toString();

                fluxQuery.append("|> range(start: ")
                        .append(startRFC3339)
                        .append(", stop: ")
                        .append(stopRFC3339)
                        .append(") ");
            } catch (ParseException e) {
                e.printStackTrace();
                // 若解析失败，可使用默认时间范围
                fluxQuery.append("|> range(start: 0) ");
            }
        } else {
            fluxQuery.append("|> range(start: 0) ");
        }

        fluxQuery.append("|> filter(fn: (r) => r._measurement == \"").append(influxConfig.getMeasurement()).append("\") ");
        fluxQuery.append("|> pivot(\n" +
                "            rowKey:[\"_time\"], \n" +
                "            columnKey: [\"_field\"], \n" +
                "            valueColumn: \"_value\"\n" +
                "        )");

        List<String> filterConditions = new ArrayList<>();
        if (deviceLog.getSerialNumber() != null && !deviceLog.getSerialNumber().isEmpty()) {
            filterConditions.add("r.serialNumber == \"" + deviceLog.getSerialNumber() + "\"");
        }
        if (deviceLog.getIdentityList() != null && !deviceLog.getIdentityList().isEmpty()) {
            StringBuilder identityFilter = new StringBuilder("r.identify =~ /^(");
            for (int i = 0; i < deviceLog.getIdentityList().size(); i++) {
                if (i > 0) {
                    identityFilter.append("|");
                }
                identityFilter.append(deviceLog.getIdentityList().get(i));
            }
            identityFilter.append(")$/");
            filterConditions.add(identityFilter.toString());
        }
        if (deviceLog.getLogType() != null) {
            filterConditions.add("r.logType == " + deviceLog.getLogType());
        }

        if (!filterConditions.isEmpty()) {
            fluxQuery.append("|> filter(fn: (r) => ");
            for (int i = 0; i < filterConditions.size(); i++) {
                if (i > 0) {
                    fluxQuery.append(" and ");
                }
                fluxQuery.append(filterConditions.get(i));
            }
            fluxQuery.append(") ");
        }

        fluxQuery.append("|> sort(columns: [\"_time\"], desc: true) ");

        // 分页处理
        int offset = (deviceLog.getPageNum() - 1) * deviceLog.getPageSize();
        fluxQuery.append("|> limit(n: ").append(deviceLog.getPageSize()).append(", offset: ").append(offset).append(") ");

        fluxQuery.append("|> keep(columns: [\"logValue\", \"_time\", \"identify\"]) ");

        List<FluxTable> tables = queryApi.query(fluxQuery.toString());

        List<HistoryModel> historyList = new ArrayList<>();
        for (FluxTable table : tables) {
            for (FluxRecord record : table.getRecords()) {
                HistoryModel historyModel = new HistoryModel();
                historyModel.setValue((String) record.getValueByKey("logValue"));
                historyModel.setTime(new Date(record.getTime().getEpochSecond() * 1000));
                historyModel.setIdentify((String) record.getValueByKey("identify"));
                historyList.add(historyModel);
            }
        }
        return historyList;
    }

    @Override
    public List<ThingsModelLogCountVO> countThingsModelInvoke(DataCenterParam dataCenterParam) {
        QueryApi queryApi = influxDBClient.getQueryApi();

        StringBuilder fluxQuery = new StringBuilder();
        fluxQuery.append("from(bucket: \"").append(influxConfig.getBucket()).append("\") ");

        // 处理时间范围
        if (dataCenterParam.getBeginTime() != null && !dataCenterParam.getBeginTime().isEmpty()
                && dataCenterParam.getEndTime() != null && !dataCenterParam.getEndTime().isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                Date beginDate = sdf.parse(dataCenterParam.getBeginTime());
                Date endDate = sdf.parse(dataCenterParam.getEndTime());
                // 转换为RFC3339格式时间字符串
                String startRFC3339 = beginDate.toInstant().toString();
                String stopRFC3339 = endDate.toInstant().toString();

                fluxQuery.append("|> range(start: ")
                        .append(startRFC3339)
                        .append(", stop: ")
                        .append(stopRFC3339)
                        .append(") ");
            } catch (ParseException e) {
                e.printStackTrace();
                // 若解析失败，可使用默认时间范围
                fluxQuery.append("|> range(start: 0) ");
            }
        } else {
            fluxQuery.append("|> range(start: 0) ");
        }

        fluxQuery.append("|> filter(fn: (r) => r._measurement == \"").append(influxConfig.getMeasurement()).append("\") ");
        fluxQuery.append("|> pivot(\n" +
                "            rowKey:[\"_time\"], \n" +
                "            columnKey: [\"_field\"], \n" +
                "            valueColumn: \"_value\"\n" +
                "        )");
        fluxQuery.append("|> filter(fn: (r) => r.log_type == 2) ");

        List<String> filterConditions = new ArrayList<>();
        if (dataCenterParam.getSerialNumber() != null && !dataCenterParam.getSerialNumber().isEmpty()) {
            filterConditions.add("r.serial_number == \"" + dataCenterParam.getSerialNumber() + "\"");
        }

        if (!filterConditions.isEmpty()) {
            fluxQuery.append("|> filter(fn: (r) => ");
            for (int i = 0; i < filterConditions.size(); i++) {
                if (i > 0) {
                    fluxQuery.append(" and ");
                }
                fluxQuery.append(filterConditions.get(i));
            }
            fluxQuery.append(") ");
        }
        fluxQuery.append("|> group() ");
        int counts = 0;
        List<FluxTable> tables = queryApi.query(fluxQuery.toString());
        if (!tables.isEmpty() && !tables.get(0).getRecords().isEmpty()) {
            counts = tables.get(0).getRecords().size();
        }
        List<ThingsModelLogCountVO> resultList = new ArrayList<>();
        for (FluxTable table : tables) {
            for (FluxRecord record : table.getRecords()) {
                ThingsModelLogCountVO vo = new ThingsModelLogCountVO();
                vo.setIdentifier((String) record.getValueByKey("identify"));
                vo.setCounts(counts);
                resultList.add(vo);
            }
        }
        return resultList;
    }

}
