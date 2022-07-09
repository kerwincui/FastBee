<template>
<el-dialog title="选择设备" :visible.sync="openDeviceList" width="800px" append-to-body>
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
        <el-form-item label="设备名称" prop="deviceName">
            <el-input v-model="queryParams.deviceName" placeholder="请输入设备名称" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="deviceList" @select="handleSelectionChange" @select-all="handleSelectionAll" ref="multipleTable" size="mini" border>
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="设备名称" align="center" prop="deviceName" />
        <el-table-column label="设备编号" align="center" prop="serialNumber" />
        <el-table-column label="产品名称" align="center" prop="productName" />
        <el-table-column label="设备类型" align="center">
            <template slot-scope="scope">
                <el-tag type="success" v-if="scope.row.isOwner==0">分享</el-tag>
                <el-tag type="primary" v-else>拥有</el-tag>
            </template>
        </el-table-column>
        <el-table-column label="设备状态" align="center" prop="status">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_device_status" :value="scope.row.status" />
            </template>
        </el-table-column>
    </el-table>
    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="handleDeviceSelected">确 定</el-button>
        <el-button @click="closeSelectDeviceList">取 消</el-button>
    </div>
</el-dialog>
</template>

<script>
import {
    getDeviceIds,
    updateDeviceGroups
} from "@/api/iot/group"
import {
    listDeviceByGroup,
} from "@/api/iot/device";

export default {
    name: "device-list",
    dicts: ['iot_device_status'],
    props: {
        group: {
            type: Object,
            default: null
        }
    },
    data() {
        return {
            // 设备分组
            deviceGroup: {},
            // 遮罩层
            loading: true,
            // 选中数组
            ids: [],
            // 是否显示设备列表
            openDeviceList: false,
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
        group: {
            handler(newVal, oldVal) {
                if (newVal.groupId) {
                    this.deviceGroup = newVal;
                    // 获取分组下的设备
                    this.queryParams.userId = this.deviceGroup.userId;
                    this.queryParams.pageNum = 1;
                    this.getDeviceIdsByGroupId(this.deviceGroup.groupId);
                }
            },
            immediate: true
        }
    },
    created() {

    },
    methods: {
        // 获取分组下关联的设备ID数组
        getDeviceIdsByGroupId(groupId) {
            getDeviceIds(groupId).then(response => {
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
            listDeviceByGroup(this.queryParams).then(response => {
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
        handleSelectionChange(selection, row) {
            // 设备ID是否存在于原始设备ID数组中
            let index = this.ids.indexOf(row.deviceId);
            // 是否选中
            let value = selection.indexOf(row);
            if (index == -1 && value != -1) {
                // 不存在且选中
                this.ids.push(row.deviceId);
            } else if (index != -1 && value == -1) {
                // 存在且取消选中
                this.ids.splice(index, 1);
            }
        },
        // 全选事件处理
        handleSelectionAll(selection) {
            for (let i = 0; i < this.deviceList.length; i++) {
                // 设备ID是否存在于原始设备ID数组中
                let index = this.ids.indexOf(this.deviceList[i].deviceId);
                // 是否选中
                let value = selection.indexOf(this.deviceList[i]);
                if (index == -1 && value != -1) {
                    // 不存在且选中
                    this.ids.push(this.deviceList[i].deviceId);
                } else if (index != -1 && value == -1) {
                    // 存在且取消选中
                    this.ids.splice(index, 1);
                }
            }
        },
        // 关闭选择设备列表
        closeSelectDeviceList() {
            this.openDeviceList = false;
        },
        // 更新分组下的设备
        handleDeviceSelected() {
            this.group.deviceIds = this.ids;
            updateDeviceGroups(this.group).then(response => {
                this.$modal.msgSuccess("更新分组下的设备成功");
                this.openDeviceList = false;
            })
        }
    }
};
</script>
