<template>
<div style="padding:6px;">
    <el-card v-show="showSearch" style="margin-bottom:6px;">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item label="分组名称" prop="groupName">
                <el-input v-model="queryParams.groupName" placeholder="请输入分组名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom:100px;">

        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:group:add']">新增</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['iot:group:edit']">修改</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['iot:group:remove']">删除</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['iot:group:export']">导出</el-button>
            </el-col>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>
        <el-table v-loading="loading" :data="groupList" @selection-change="handleSelectionChange" border>
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column label="分组名称" align="center" prop="groupName" width="200" />
            <el-table-column label="分组排序" align="center" prop="groupOrder" width="100" />
            <el-table-column label="创建时间" align="center" prop="createTime" width="180">
                <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                </template>
            </el-table-column>
            <el-table-column label="备注" align="left" prop="remark" />
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="230">
                <template slot-scope="scope">
                    <el-button size="small" type="success" style="padding:5px;" icon="el-icon-edit" @click="selectDevice(scope.row)" v-hasPermi="['iot:group:edit']">添加设备</el-button>
                    <el-button size="small" type="primary" style="padding:5px;" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:group:edit']">修改</el-button>
                    <el-button size="small" type="danger" style="padding:5px;" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:group:remove']">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <el-dialog title="选择设备" :visible.sync="openDeviceList" width="800px" append-to-body>
            <device-list ref="deviceList" :groupId="deviceGroup.groupId" @idsToParentEvent="getChildData($event)"></device-list>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="handleDeviceSelected">确 定</el-button>
                <el-button @click="closeSelectDeviceList">取 消</el-button>
            </div>
        </el-dialog>

        <!-- 添加或修改设备分组对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="分组名称" prop="groupName">
                    <el-input v-model="form.groupName" placeholder="请输入分组名称" />
                </el-form-item>
                <el-form-item label="分组排序" prop="groupOrder">
                    <el-input v-model="form.groupOrder" type="number" placeholder="请输入分组排序" />
                </el-form-item>
                <el-form-item label="备注" prop="remark">
                    <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">确 定</el-button>
                <el-button @click="cancel">取 消</el-button>
            </div>
        </el-dialog>

    </el-card>
</div>
</template>

<script>
import deviceList from "./device-list"
import {
    listGroup,
    getGroup,
    delGroup,
    addGroup,
    updateGroup,
    updateDeviceGroups
} from "@/api/iot/group";

export default {
    name: "Group",
    components: {
        deviceList
    },
    data() {
        return {
            // 遮罩层
            loading: true,
            // 选中数组
            ids: [],
            // 非单个禁用
            single: true,
            // 非多个禁用
            multiple: true,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 设备分组表格数据
            groupList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 是否显示设备列表
            openDeviceList: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                groupName: null,
                userName: null,
            },
            // 设备分组
            deviceGroup: {},
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                groupName: [{
                    required: true,
                    message: "分组名称不能为空",
                    trigger: "blur"
                }],
                groupOrder: [{
                        required: true,
                        message: "分组排序不能为空,最大值为99",
                        trigger: "blur"
                    },
                    {
                        min: 1,
                        max: 2,
                        message: '范围在 0 到 99',
                        trigger: 'blur'
                    }
                ],
            }
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询设备分组列表 */
        getList() {
            this.loading = true;
            listGroup(this.queryParams).then(response => {
                this.groupList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },
        // 关闭选择设备列表
        closeSelectDeviceList() {
            this.openDeviceList = false;
        },
        // 表单重置
        reset() {
            this.form = {
                groupId: null,
                groupName: null,
                groupOrder: null,
                userId: null,
                userName: null,
                delFlag: null,
                createBy: null,
                createTime: null,
                updateBy: null,
                updateTime: null,
                remark: null
            };
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
            this.ids = selection.map(item => item.groupId)
            console.log(this.ids);
            this.single = selection.length !== 1
            this.multiple = !selection.length
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = "添加设备分组";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const groupId = row.groupId || this.ids
            getGroup(groupId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = "修改设备分组";
            });
        },
        /** 选择设备 */
        selectDevice(row) {
            this.deviceGroup.groupId = row.groupId;
            this.openDeviceList = true;
            this.$refs.deviceList.getDeviceIdsByGroupId();
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.groupId != null) {
                        updateGroup(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addGroup(this.form).then(response => {
                            this.$modal.msgSuccess("新增成功");
                            this.open = false;
                            this.getList();
                        });
                    }
                }
            });
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const groupIds = row.groupId || this.ids;
            this.$modal.confirm('是否确认删除设备分组编号为"' + groupIds + '"的数据项？').then(function () {
                return delGroup(groupIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess("删除成功");
            }).catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/group/export', {
                ...this.queryParams
            }, `group_${new Date().getTime()}.xlsx`)
        },
        // 获取子组件选中的ID数组
        getChildData(data) {
            this.deviceGroup.deviceIds = data;
        },
        // 更新分组下的设备
        handleDeviceSelected() {
            updateDeviceGroups(this.deviceGroup).then(response => {
                this.$modal.msgSuccess("更新分组下的设备成功");
                this.openDeviceList = false;
            })
        }
    }
};
</script>
