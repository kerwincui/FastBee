<template>
<div style="padding-left:20px;">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
        <el-form-item label="设备编号" prop="serialNumber">
            <el-input v-model="queryParams.serialNumber" placeholder="请输入设备编号" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item label="授权码" prop="authorizeCode">
            <el-input v-model="queryParams.authorizeCode" placeholder="请输入授权码" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
            <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small">
                <el-option v-for="dict in dict.type.iot_auth_status" :key="dict.value" :label="dict.label" :value="dict.value" />
            </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
            <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:authorize:add']">生成授权码</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['iot:authorize:remove']">批量删除</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['iot:authorize:export']">导出</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-link type="info" style="padding-top:5px" :underline="false">Tips：双击可以复制授权码。</el-link>
        </el-col>
    </el-row>

    <el-table v-loading="loading" :data="authorizeList" @selection-change="handleSelectionChange" @cell-dblclick="celldblclick" size="small">
        <el-table-column type="selection" :selectable="selectable" width="55" align="center" />
        <el-table-column label="授权码" width="320" align="center" prop="authorizeCode" />
        <el-table-column label="状态" align="center" prop="active" width="100">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_auth_status" :value="scope.row.status" />
            </template>
        </el-table-column>
        <el-table-column label="设备编号" width="150" align="center" prop="serialNumber">
            <template slot-scope="scope">
                <el-link type="primary" @click="getDeviceBySerialNumber(scope.row.serialNumber)" :underline="false">{{scope.row.serialNumber}}</el-link>
            </template>
        </el-table-column>
        <el-table-column label="授权时间" align="center" prop="updateTime" width="180">
            <template slot-scope="scope">
                <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d} {h}:{m}:{s}') }}</span>
            </template>
        </el-table-column>
        <el-table-column label="备注" align="center" prop="remark" />
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
                <el-button size="mini" type="text" icon="el-icon-s-check" @click="handleUpdate(scope.row,'auth')" v-hasPermi="['iot:authorize:edit']" v-if="scope.row.status==1 && !scope.row.deviceId">设备授权</el-button>
                <el-button size="mini" type="text" icon="el-icon-notebook-1" @click="handleUpdate(scope.row,'remark')" v-hasPermi="['iot:authorize:edit']">备注</el-button>
                <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:authorize:remove']" v-if="!scope.row.deviceId">删除</el-button>
            </template>
        </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 设备授权和授权备注对话框 -->
    <el-dialog :title="title" :visible.sync="open" :width="editWidth" append-to-body>
        <div v-if="editType=='auth'">
            <div class="el-divider el-divider--horizontal" style="margin-top: -25px;"></div>
            <el-form :model="deviceParams" ref="queryDeviceForm" :inline="true" label-width="68px">
                <el-form-item label="设备名称" prop="deviceName">
                    <el-input v-model="deviceParams.deviceName" placeholder="请输入设备名称" clearable size="small" @keyup.enter.native="handleQuery" style="width:150px;" />
                </el-form-item>
                <el-form-item label="设备编号" prop="serialNumber" style="margin:0 30px;">
                    <el-input v-model="deviceParams.serialNumber" placeholder="请输入设备编号" clearable size="small" @keyup.enter.native="handleQuery" style="width:150px;" />
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="mini" @click="handleDeviceQuery">搜索</el-button>
                    <el-button icon="el-icon-refresh" size="mini" @click="resetDeviceQuery">重置</el-button>
                </el-form-item>
            </el-form>
            <el-table v-loading="deviceLoading" :data="deviceList" ref="singleTable" size="mini" @row-click="rowClick" highlight-current-row>
                <el-table-column label="选择" width="50" align="center">
                    <template slot-scope="scope">
                        <input type="radio" :checked="scope.row.isSelect" name="device" />
                    </template>
                </el-table-column>
                <el-table-column label="设备名称" align="center" prop="deviceName" />
                <el-table-column label="设备ID" align="center" prop="deviceId" />
                <el-table-column label="设备编号" align="center" prop="serialNumber" />
                <el-table-column label="用户名称" align="center" prop="userName" />
                <el-table-column label="设备状态" align="center" prop="status">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_device_status" :value="scope.row.status" />
                    </template>
                </el-table-column>
            </el-table>
            <pagination v-show="deviceTotal>0" :total="deviceTotal" :page.sync="deviceParams.pageNum" :limit.sync="deviceParams.pageSize" @pagination="getDeviceList" />
        </div>
        <div v-if="editType=='remark'">
            <el-input v-model="form.remark" type="textarea" rows="4" placeholder="请输入内容" />
        </div>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitForm">确 定</el-button>
            <el-button @click="cancel">取 消</el-button>
        </div>
    </el-dialog>

    <!-- 设备详情对话框 -->
    <el-dialog title="设备详情" :visible.sync="openDevice" width="600px" append-to-body>
        <div v-if="device==null" style="text-align:center;"><i class="el-icon-warning" style="color:#E6A23C;"></i>  提示：查找不到设备，可能已经被删除</div>
        <el-descriptions border :column="2" size="medium" v-if="device!=null">
            <el-descriptions-item label="设备ID">{{device.deviceId}}</el-descriptions-item>
            <el-descriptions-item label="设备名称">{{device.deviceName}}</el-descriptions-item>
            <el-descriptions-item label="设备编号">{{device.serialNumber}}</el-descriptions-item>
            <el-descriptions-item label="设备状态">
                <!-- （1-未激活，2-禁用，3-在线，4-离线） -->
                <el-tag v-if="device.status==1" type="warning">未激活</el-tag>
                <el-tag v-else-if="device.status==2" type="danger">禁用</el-tag>
                <el-tag v-else-if="device.status==3" type="success">在线</el-tag>
                <el-tag v-else-if="device.status==4" type="info">离线</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="设备影子">
                <el-tag v-if="device.isShadow==1" type="success">启用</el-tag>
                <el-tag v-else type="info">未启用</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="定位方式">
                <!-- (1=ip自动定位，2=设备定位，3=自定义) -->
                <el-tag v-if="device.locationWay==1" type="success">自动定位</el-tag>
                <el-tag v-else-if="device.locationWay==2" type="warning">设备定位</el-tag>
                <el-tag v-else-if="device.locationWay==3" type="primary">自定义位置</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="产品名称">{{device.productName}}</el-descriptions-item>
            <el-descriptions-item label="租户名称">{{device.userName}}</el-descriptions-item>
            <el-descriptions-item label="固件版本">Version {{device.firmwareVersion}}</el-descriptions-item>
            <el-descriptions-item label="所在地址">{{device.networkAddress}}</el-descriptions-item>
            <el-descriptions-item label="设备经度">{{device.longitude}}</el-descriptions-item>
            <el-descriptions-item label="设备纬度">{{device.latitude}}</el-descriptions-item>
            <el-descriptions-item label="入网IP">{{device.networkIp}}</el-descriptions-item>
            <el-descriptions-item label="设备信号">{{device.rssi}}</el-descriptions-item>
            <el-descriptions-item label="创建时间">{{device.createTime}}</el-descriptions-item>
            <el-descriptions-item label="激活时间">{{device.activeTime}}</el-descriptions-item>
            <el-descriptions-item label="备注信息">{{device.remark}}</el-descriptions-item>
        </el-descriptions>
        <div slot="footer" class="dialog-footer">
            <el-button @click="goToEditDevice(device.deviceId)" type="primary">查看设备</el-button>
            <el-button @click="closeDevice">关 闭</el-button>
        </div>
    </el-dialog>
</div>
</template>

<style>
.createNum {
    width: 300px;
}

.createNum input {
    width: 260px;
}
</style>

<script>
import {
    getDeviceBySerialNumber,
} from "@/api/iot/device";
import {
    listUnAuthDevice,
} from "@/api/iot/device";
import {
    listAuthorize,
    getAuthorize,
    delAuthorize,
    addProductAuthorizeByNum,
    updateAuthorize
} from "@/api/iot/authorize";
export default {
    name: "product-authorize",
    dicts: ['iot_auth_status', 'iot_device_status'],
    props: {
        product: {
            type: Object,
            default: null
        }
    },
    watch: {
        // 获取到父组件传递的productId后，刷新列表
        product: function (newVal, oldVal) {
            this.productInfo = newVal;
            if (this.productInfo && this.productInfo.productId != 0) {
                this.queryParams.productId = this.productInfo.productId;
                this.deviceParams.productId = this.productInfo.productId;
                this.getList();
                this.getDeviceList();
            }
        }
    },
    data() {
        return {
            // 设备信息
            device: {},
            // 设备信息对话框
            openDevice: false,
            // 设备遮罩层
            deviceLoading: true,
            // 总条数
            deviceTotal: 0,
            // 设备表格数据
            deviceList: [],
            // 查询参数
            deviceParams: {
                pageNum: 1,
                pageSize: 10,
                userId: null,
                deviceName: null,
                productId: 0,
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
            // 编辑类型，remark=备注、auth=设备授权
            editType: '',
            // 编辑界面宽度
            editWidth: '500px',
            // 遮罩层
            loading: true,
            // 选中数组
            ids: [],
            // 非多个禁用
            multiple: true,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 产品授权码表格数据
            authorizeList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 新增授权码个数
            createNum: 10,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                authorizeCode: null,
                productId: null,
                deviceId: null,
                serialNumber: null,
                userId: null,
                userName: null,
                status: null,
            },
            // 表单参数
            form: {},
            // 产品
            productInfo: {},
        };
    },
    created() {

    },
    methods: {
        /**获取设备详情*/
        getDeviceBySerialNumber(serialNumber) {
            this.openDevice = true;
            getDeviceBySerialNumber(serialNumber).then(response => {
                this.device = response.data;
            });
        },
        /** 修改按钮操作 */
        goToEditDevice(deviceId) {
            this.openDevice=false;
            this.$router.push({
                path: '/iot/device-edit',
                query: {
                    deviceId: deviceId,
                }
            });
        },
        /** 查询设备列表 */
        getDeviceList() {
            this.deviceLoading = true;
            this.deviceParams.params = {};
            listUnAuthDevice(this.deviceParams).then(response => {
                this.deviceList = response.rows;
                this.deviceTotal = response.total;
                this.deviceLoading = false;
            });
        },
        /** 搜索按钮操作 */
        handleDeviceQuery() {
            this.deviceParams.pageNum = 1;
            this.getDeviceList();
        },
        /** 重置按钮操作 */
        resetDeviceQuery() {
            this.resetForm("queryDeviceForm");
            this.handleDeviceQuery();
        },
        /** 单选数据 */
        rowClick(device) {
            if (device != null) {
                this.setRadioSelected(device.deviceId);
                // 赋值
                this.form.userId = device.userId;
                this.form.userName = device.userName;
                this.form.deviceId = device.deviceId;
                this.form.serialNumber = device.serialNumber;
            }
        },
        /** 设置单选按钮选中 */
        setRadioSelected(deviceId) {
            for (let i = 0; i < this.deviceList.length; i++) {
                let device = this.deviceList[i];
                if (this.deviceList[i].deviceId == deviceId) {
                    device.isSelect = true;
                    this.$set(this.deviceList, i, device);
                } else {
                    device.isSelect = false;
                    this.$set(this.deviceList, i, device);
                }
            }
        },
        /** 查询产品授权码列表 */
        getList() {
            this.loading = true;
            listAuthorize(this.queryParams).then(response => {
                this.authorizeList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },
        // 关闭设备详情
        closeDevice() {
            this.openDevice = false;
        },
        // 表单重置
        reset() {
            this.form = {
                authorizeId: null,
                authorizeCode: null,
                productId: "",
                userId: "",
                deviceId: null,
                serialNumber: null,
                userName: null,
                delFlag: null,
                createBy: null,
                createTime: null,
                updateBy: null,
                updateTime: null,
                remark: null
            };
            this.device = {};
            this.resetForm("form");
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.queryParams.pageNum = 1;
            this.getList();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.resetForm("queryForm");
            this.handleQuery();
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map(item => item.authorizeId)
            this.multiple = !selection.length
        },
        /** 批量新增按钮操作 */
        handleAdd() {
            this.$prompt('', '输入授权码数量', {
                customClass: 'createNum',
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                inputPattern: /[0-9\-]/,
                inputErrorMessage: '数量内容不正确',
                inputType: 'number',
                inputValue: this.createNum
            }).then(({
                value
            }) => {
                this.createNum = value
                if (this.queryParams.productId != null) {
                    let _addData = {
                        productId: this.queryParams.productId,
                        createNum: this.createNum
                    }
                    addProductAuthorizeByNum(_addData).then(response => {
                        this.$modal.msgSuccess("新增授权码成功");
                        this.getList();
                        this.createNum = 10;
                    });
                }
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '取消新增'
                });
            });
        },
        /** 修改按钮操作 */
        handleUpdate(row, editType) {
            this.reset();
            this.editType = editType;
            const authorizeId = row.authorizeId || this.ids
            getAuthorize(authorizeId).then(response => {
                this.form = response.data;
                this.open = true;
                if (this.editType == 'auth') {
                    this.title = "选择设备";
                    this.editWidth = "800px";
                } else {
                    this.title = "备注信息";
                    this.editWidth = "500px";
                }
                // 取消选中

                for (let i = 0; i < this.deviceList.length; i++) {
                    // this.deviceList[i].isSelect=false;
                    let device = this.deviceList[i];
                    device.isSelect = false;
                    // this.deviceList.splice(i,1,device )
                    this.$set(this.deviceList, i, device);
                }
            });
        },
        /** 提交按钮 */
        submitForm() {
            if (this.editType == 'auth') {
                if (this.form.deviceId != null && this.form.deviceId != 0) {
                    updateAuthorize(this.form).then(response => {
                        this.$modal.msgSuccess("设备授权成功");
                        this.open = false;
                        this.getList();
                    });
                } else {
                    this.$modal.msg("请选择要授权的设备");
                }
            } else if (this.form.authorizeId != null) {
                updateAuthorize(this.form).then(response => {
                    this.$modal.msgSuccess("备注成功");
                    this.open = false;
                    this.getList();
                });
            }
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const authorizeIds = row.authorizeId || this.ids;
            this.$modal.confirm('是否确认删除产品授权码编号为"' + authorizeIds + '"的数据项？').then(function () {
                return delAuthorize(authorizeIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess("删除成功");
            }).catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/authorize/export', {
                ...this.queryParams
            }, `authorize_${new Date().getTime()}.xlsx`)
        },
        //禁用有绑定设备的复选框
        selectable(row) {
            return row.deviceId != null ? false : true;
        },
        //表格增加复制功能
        celldblclick(row, column, cell, event) {
            this.$copyText(row[column.property]).then(e => {
                this.onCopy()
            }, function (e) {
                this.onError()
            })
        },
        onCopy() {
            this.$notify({
                title: '成功',
                message: '复制成功！',
                type: 'success',
                offset: 50,
                duration: 2000
            })
        },
        onError() {
            this.$notify({
                title: '失败',
                message: '复制失败！',
                type: 'error',
                offset: 50,
                duration: 2000
            })
        },
    }
};
</script>
