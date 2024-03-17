<template>
<div style="padding:6px;">
    <el-card v-show="showSearch" style="margin-bottom:6px;">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item label="协议名称" prop="protocolName">
                <el-input v-model="queryParams.protocolName" placeholder="请输入协议名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="协议编码" prop="protocolCode">
                <el-input v-model="queryParams.protocolCode" placeholder="请输入协议编码" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom:100px;">
        <el-table v-loading="loading" :data="protocolList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column label="协议名称" align="center" prop="protocolName" />
            <el-table-column label="协议编码" align="center" prop="protocolCode" />
            <el-table-column label="上传地址" align="center" prop="protocolFileUrl" />
            <el-table-column label="协议类型" align="center" prop="protocolType" />
            <el-table-column label="协议摘要" align="center" prop="jarSign" />
        </el-table>

        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 添加或修改协议对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="100px">
                <el-form-item label="协议名称" prop="protocolName">
                    <el-input v-model="form.protocolName" placeholder="请输入协议名称" />
                </el-form-item>
                <el-form-item label="协议编码" prop="protocolCode">
                    <el-input v-model="form.protocolCode" placeholder="请输入协议编码" />
                </el-form-item>
                <el-form-item label="上传地址" prop="protocolFileUrl">
                    <el-input v-model="form.protocolFileUrl" type="textarea" placeholder="请输入内容" />
                </el-form-item>
                <el-form-item label="协议摘要" prop="jarSign">
                    <el-input v-model="form.jarSign" placeholder="请输入协议文件摘要(文件的md5)" />
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
import {
    listProtocol,
    getProtocol,
    delProtocol,
    addProtocol,
    updateProtocol
} from "@/api/iot/protocol";

export default {
    name: "Protocol",
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
            // 协议表格数据
            protocolList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                protocolCode: null,
                protocolName: null,
                protocolFileUrl: null,
                protocolType: null,
                jarSign: null,
                protocolStatus: null,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                protocolCode: [{
                    required: true,
                    message: "协议编码不能为空",
                    trigger: "blur"
                }],
                protocolName: [{
                    required: true,
                    message: "协议名称不能为空",
                    trigger: "blur"
                }],
                protocolFileUrl: [{
                    required: true,
                    message: "协议上传地址不能为空",
                    trigger: "blur"
                }],
                protocolType: [{
                    required: true,
                    message: "协议类型不能为空",
                    trigger: "change"
                }],
                jarSign: [{
                    required: true,
                    message: "协议摘要不能为空",
                    trigger: "blur"
                }]
            }
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询协议列表 */
        getList() {
            this.loading = true;
            listProtocol(this.queryParams).then(response => {
                this.protocolList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },
        // 表单重置
        reset() {
            this.form = {
                id: null,
                protocolCode: null,
                protocolName: null,
                protocolFileUrl: null,
                protocolType: null,
                jarSign: null,
                createTime: null,
                updateTime: null,
                protocolStatus: 0,
                delFlag: null
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
            this.ids = selection.map(item => item.id)
            this.single = selection.length !== 1
            this.multiple = !selection.length
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = "添加协议";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const id = row.id || this.ids
            getProtocol(id).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = "修改协议";
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.id != null) {
                        updateProtocol(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addProtocol(this.form).then(response => {
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
            const ids = row.id || this.ids;
            this.$modal.confirm('是否确认删除协议编号为"' + ids + '"的数据项？').then(function () {
                return delProtocol(ids);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess("删除成功");
            }).catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/protocol/export', {
                ...this.queryParams
            }, `protocol_${new Date().getTime()}.xlsx`)
        }
    }
};
</script>
