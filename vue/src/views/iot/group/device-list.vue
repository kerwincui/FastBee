<template>
<div style="padding:6px;">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
        <el-form-item label="设备名称" prop="deviceName">
            <el-input v-model="queryParams.deviceName" placeholder="请输入设备名称" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="deviceList" @select="handleSelectionChange" ref="multipleTable" size="mini" border>
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="设备名称" align="center" prop="deviceName" />
        <el-table-column label="设备编号" align="center" prop="serialNumber" />
        <el-table-column label="产品名称" align="center" prop="productName" />
        <el-table-column label="设备状态" align="center" prop="status">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_device_status" :value="scope.row.status" />
            </template>
        </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

</div>
</template>

<script>
import {
    getDeviceIds
} from "@/api/iot/group"
import {
    listDeviceShort,
} from "@/api/iot/device";

export default {
    name: "device-list",
    dicts: ['iot_device_status'],
    props: {
        groupId: {
            type: Number,
            default: null
        }
    },
    data() {
        return {
            // 遮罩层
            loading: true,
            // 分组信息
            parentGroupId:0,
            // 选中数组
            ids: [],
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 设备表格数据
            deviceList: [],
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                deviceName: null,
                productId: null,
                productName: null,
                userId: null,
                userName: null,
                tenantId: null,
                tenantName: null,
                serialNumber: null,
                status: null,
                networkAddress: null,
                activeTime: null,
            },
        };
    },
    watch: {
        // 获取到父组件传递的group后，刷新列表
        groupId: {
            handler(newVal, oldVal) {
                this.parentGroupId = newVal;
                // 获取分组下的设备
                this.queryParams.pageNum=1;
                this.getDeviceIdsByGroupId();
            },
            immediate: true
        }
    },
    created() {  

    },
    methods: {
        // 获取分组下关联的设备ID数组
        getDeviceIdsByGroupId() {
            getDeviceIds(this.parentGroupId).then(response => {
                this.ids = response.data;
                this.getList();
            });
        },
        /** 查询设备列表 */
        getList() {
            this.loading = true;
            this.queryParams.params = {};            
            if (null != this.daterangeActiveTime && '' != this.daterangeActiveTime) {
                this.queryParams.params["beginActiveTime"] = this.daterangeActiveTime[0];
                this.queryParams.params["endActiveTime"] = this.daterangeActiveTime[1];
            }
            listDeviceShort(this.queryParams).then(response => {
                this.deviceList = response.rows;
                this.total = response.total;
                this.loading = false;
                // 设置分组关联的设备选中
                this.deviceList.forEach(row => {
                    this.$nextTick(() => {
                        if (this.ids.some(x => x === row.deviceId)) {
                            this.$refs.multipleTable.toggleRowSelection(row, true);
                        }
                    })
                });
            });
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.queryParams.pageNum = 1;
            this.getList();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.daterangeActiveTime = [];
            this.resetForm("queryForm");
            this.handleQuery();
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map(item => item.deviceId)
            console.log("选择赋值");
            console.log(this.ids);
            this.single = selection.length !== 1
            this.multiple = !selection.length
            // Id数组传递到父组件
            this.$emit('idsToParentEvent', this.ids)
        },
    }
};
</script>
