<template>
<div style="padding-left:20px;">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
        <el-form-item label="日志类型" prop="logType">
            <el-select v-model="queryParams.logType" placeholder="请选择类型" clearable size="small">
                <el-option v-for="dict in dict.type.iot_event_type" :key="dict.value" :label="dict.label" :value="dict.value" />
            </el-select>
        </el-form-item>
        <el-form-item label="标识符" prop="identity">
            <el-input v-model="queryParams.identity" placeholder="请输入标识符" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item label="时间范围">
            <el-date-picker v-model="daterangeTime" size="small" style="width: 240px" value-format="yyyy-MM-dd" type="daterange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="deviceLogList" size="mini">
        <el-table-column label="类型" align="center" prop="logType" width="120">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_event_type" :value="scope.row.logType" />
            </template>
        </el-table-column>
        <el-table-column label="模式" align="center" prop="logType" width="120">
            <template slot-scope="scope">
                <el-tag type="primary" v-if="scope.row.mode==1">影子模式</el-tag>
                <el-tag type="success" v-else-if="scope.row.mode==2">在线模式</el-tag>
                <el-tag type="info" v-else>其他信息</el-tag>
            </template>
        </el-table-column>
        <el-table-column label="时间" align="center" prop="createTime" width="150">
            <template slot-scope="scope">
                <span>{{ scope.row.createTime }}</span>
            </template>
        </el-table-column>
        <el-table-column label="标识符" align="center" prop="identity" />
        <el-table-column label="动作" align="left" header-align="center" prop="logValue">
            <template slot-scope="scope">
                <div v-html="formatValueDisplay(scope.row)"></div>
            </template>
        </el-table-column>

        <el-table-column label="备注" header-align="center" align="left" prop="remark">
            <template slot-scope="scope">
                {{scope.row.remark==null ?"无":scope.row.remark}}
            </template>
        </el-table-column>

    </el-table>
    <div style="height:40px;">
        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
    </div>

</div>
</template>

<script>
import {
    listEventLog
} from "../../../api/iot/eventLog";

export default {
    name: "DeviceLog",
    dicts: ['iot_event_type', "iot_yes_no"],
    props: {
        device: {
            type: Object,
            default: null
        }
    },
    watch: {
        // 获取到父组件传递的device后，刷新列表
        device: function (newVal, oldVal) {
            this.deviceInfo = newVal;
            if (this.deviceInfo && this.deviceInfo.deviceId != 0) {
                this.queryParams.serialNumber = this.deviceInfo.serialNumber;
                this.getList();
                // 解析缓存物模型
                this.thingsModel = this.deviceInfo.cacheThingsModel;
            }
        }
    },
    data() {
        return {
            // 物模型
            thingsModel: {},
            // 遮罩层
            loading: true,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 设备日志表格数据
            deviceLogList: [],
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                logType: null,
                logValue: null,
                deviceId: null,
                serialNumber: null,
                deviceName: null,
                identity: null,
                isMonitor: null,
            },
            // 时间范围
            daterangeTime: [],
        };
    },
    created() {
        this.queryParams.serialNumber = this.device.serialNumber;
        this.getList();
    },
    methods: {
        /** 查询设备日志列表 */
        getList() {
            this.loading = true;
            listEventLog(this.addDateRange(this.queryParams, this.daterangeTime)).then(response => {
                this.deviceLogList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.queryParams.pageNum = 1;
            this.getList();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.resetForm("queryForm");
            this.daterangeTime=[];
            this.handleQuery();
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/event/export', {
                ...this.queryParams
            }, `eventLog_${new Date().getTime()}.xlsx`)
        },
        /** 格式化显示数据定义 */
        formatValueDisplay(row) {
            // 类型（1=属性上报，2=调用功能，3=事件上报，4=设备升级，5=设备上线，6=设备离线）
            if (row.logType == 1) {
                let propertyItem = this.getThingsModelItem(1, row.identity);
                if (propertyItem != "") {
                    return (propertyItem.parentName ? '[' + propertyItem.parentName + (propertyItem.arrayIndex ? propertyItem.arrayIndex : '') + '] ' : '') +
                        propertyItem.name +
                        '： <span style="color:#409EFF;">' + this.getThingsModelItemValue(propertyItem, row.logValue) + ' ' +
                        (propertyItem.datatype.unit != undefined ? propertyItem.datatype.unit : '') + '</span>';
                }
            } else if (row.logType == 2) {
                let functionItem = this.getThingsModelItem(2, row.identity);
                if (functionItem != "") {
                    return (functionItem.parentName ? '[' + functionItem.parentName + (functionItem.arrayIndex ? functionItem.arrayIndex : '') + '] ' : '') +
                        functionItem.name +
                        '： <span style="color:#409EFF">' + this.getThingsModelItemValue(functionItem, row.logValue) + ' ' +
                        (functionItem.datatype.unit != undefined ? functionItem.datatype.unit : '') + '</span>';
                }
            } else if (row.logType == 3) {
                let eventItem = this.getThingsModelItem(3, row.identity);
                if (eventItem != "") {
                    return (eventItem.parentName ? '[' + eventItem.parentName + (eventItem.arrayIndex ? eventItem.arrayIndex : '') + '] ' : '') +
                        eventItem.name +
                        '： <span style="color:#409EFF">' + this.getThingsModelItemValue(eventItem, row.logValue) + ' ' +
                        (eventItem.datatype.unit != undefined ? eventItem.datatype.unit : '') + '</span>';
                }
                else {
                    return row.logValue;
                }
            } else if (row.logType == 4) {
                return '<span style="font-weight:bold">设备升级</span>';
            } else if (row.logType == 5) {
                return '<span style="font-weight:bold">设备上线</span>';
            } else if (row.logType == 6) {
                return '<span style="font-weight:bold">设备离线</span>';
            }
            return "";
        },
        /** 获取物模型项中的值*/
        getThingsModelItemValue(item, oldValue) {
            // 枚举和布尔转换为文字
            if (item.datatype.type == "bool") {
                if (oldValue == "0") {
                    return item.datatype.falseText;
                } else if (oldValue == "1") {
                    return item.datatype.trueText;
                }
            } else if (item.datatype.type == "enum") {
                for (let i = 0; i < item.datatype.enumList.length; i++) {
                    if (oldValue == item.datatype.enumList[i].value) {
                        return item.datatype.enumList[i].text;
                    }
                }
            }
            return oldValue;
        },
        /** 获取物模型中的项*/
        getThingsModelItem(type, identity) {
            if (type == 1 && this.thingsModel.properties) {
                for (let i = 0; i < this.thingsModel.properties.length; i++) {
                    //普通类型 integer/decimal/string/emum//bool
                    if (this.thingsModel.properties[i].id == identity) {
                        return this.thingsModel.properties[i];
                    }
                    // 对象 object
                    if (this.thingsModel.properties[i].datatype.type == "object") {
                        for (let j = 0; j < this.thingsModel.properties[i].datatype.params.length; j++) {
                            if (this.thingsModel.properties[i].datatype.params[j].id == identity) {
                                this.thingsModel.properties[i].datatype.params[j].parentName = this.thingsModel.properties[i].name;
                                return this.thingsModel.properties[i].datatype.params[j];
                            }
                        }
                    }
                    // 数组 array
                    if (this.thingsModel.properties[i].datatype.type == "array" && this.thingsModel.properties[i].datatype.arrayType) {
                        if (this.thingsModel.properties[i].datatype.arrayType == "object") {
                            // 数组元素格式：array_01_parentId_humidity,array_01_前缀终端上报时加上，物模型中没有
                            let realIdentity = identity;
                            let arrayIndex = 0;
                            if (identity.indexOf("array_") > -1) {
                                arrayIndex = identity.substring(6, 8);
                                realIdentity = identity.substring(9);
                            }
                            for (let j = 0; j < this.thingsModel.properties[i].datatype.params.length; j++) {
                                if (this.thingsModel.properties[i].datatype.params[j].id == realIdentity) {
                                    // 标注索引和父级名称
                                    this.thingsModel.properties[i].datatype.params[j].arrayIndex = Number(arrayIndex) + 1;
                                    this.thingsModel.properties[i].datatype.params[j].parentName = this.thingsModel.properties[i].name;
                                    return this.thingsModel.properties[i].datatype.params[j];
                                }
                            }
                        } else {
                            // 普通类型
                            for (let j = 0; j < this.thingsModel.properties[i].datatype.arrayCount.length; j++) {
                                if (this.thingsModel.properties[i].id == realIdentity) {
                                    this.thingsModel.properties[i].arrayIndex = Number(arrayIndex) + 1;
                                    this.thingsModel.properties[i].parentName = "元素";
                                    return this.thingsModel.properties[i];
                                }
                            }
                        }

                    }
                }
            } else if (type == 2 && this.thingsModel.functions) {
                for (let i = 0; i < this.thingsModel.functions.length; i++) {
                    //普通类型 integer/decimal/string/emum/bool
                    if (this.thingsModel.functions[i].id == identity) {
                        return this.thingsModel.functions[i];
                    }
                    // 对象 object
                    if (this.thingsModel.functions[i].datatype.type == "object") {
                        for (let j = 0; j < this.thingsModel.functions[i].datatype.params.length; j++) {
                            if (this.thingsModel.functions[i].datatype.params[j].id == identity) {
                                this.thingsModel.functions[i].datatype.params[j].parentName = this.thingsModel.functions[i].name;
                                return this.thingsModel.functions[i].datatype.params[j];
                            }
                        }
                    }
                    // 数组 array
                    if (this.thingsModel.functions[i].datatype.type == "array" && this.thingsModel.functions[i].datatype.arrayType) {
                        // 数组元素格式：array_01_parentId_humidity,array_01_前缀终端上报时加上，物模型中没有
                        let realIdentity = identity;
                        let arrayIndex = 0;
                        if (identity.indexOf("array_") > -1) {
                            arrayIndex = identity.substring(6, 8);
                            realIdentity = identity.substring(9);
                        }
                        if (this.thingsModel.functions[i].datatype.arrayType == "object") {
                            for (let j = 0; j < this.thingsModel.functions[i].datatype.params.length; j++) {
                                if (this.thingsModel.functions[i].datatype.params[j].id == realIdentity) {
                                    // 标注索引和父级名称
                                    this.thingsModel.functions[i].datatype.params[j].arrayIndex = Number(arrayIndex) + 1;
                                    this.thingsModel.functions[i].datatype.params[j].parentName = this.thingsModel.functions[i].name;
                                    return this.thingsModel.functions[i].datatype.params[j];
                                }
                            }
                        } else {
                            // 普通类型
                            for (let j = 0; j < this.thingsModel.functions[i].datatype.arrayCount.length; j++) {
                                if (this.thingsModel.functions[i].id == realIdentity) {
                                    this.thingsModel.functions[i].arrayIndex = Number(arrayIndex) + 1;
                                    this.thingsModel.functions[i].parentName = "元素";
                                    return this.thingsModel.functions[i];
                                }
                            }
                        }

                    }
                }
            } else if (type == 3 && this.thingsModel.events) {
                for (let i = 0; i < this.thingsModel.events.length; i++) {
                    if (this.thingsModel.events[i].id == identity) {
                        return this.thingsModel.events[i];
                    }
                }
            }
            return "";
        }
    }
};
</script>
