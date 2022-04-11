<template>
<div style="padding-left:20px;">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="80px">
        <el-form-item label="授权码" prop="authorizeCode">
            <el-input v-model="queryParams.authorizeCode" placeholder="请输入授权码" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item label="设备编号" prop="serialNumber">
            <el-input v-model="queryParams.serialNumber" placeholder="请输入设备编号" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item label="用户名称" prop="userName">
            <el-input v-model="queryParams.userName" placeholder="请输入用户名称" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
            <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:authorize:add']">新增授权码</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['iot:authorize:edit']">修改</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['iot:authorize:remove']">删除</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-link type="danger" style="padding-top:5px" :underline="false">注意：绑定设备之后不可以删除。 Tips：双击可以复制授权码。</el-link>
        </el-col>
        <right-toolbar @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="authorizeList" @selection-change="handleSelectionChange" @cell-dblclick="celldblclick">
        <el-table-column type="selection" :selectable="selectable" width="55" align="center"/>
        <el-table-column label="ID"  width="55" align="center" prop="authorizeId" />
        <el-table-column label="状态" align="center" prop="active" width="80">
            <template slot-scope="scope">
                <el-tag type="success" v-if="scope.row.deviceId">已使用</el-tag>
                <el-tag type="info" v-else>未使用</el-tag>
            </template>
        </el-table-column>
        <el-table-column label="授权码" width="300" align="center" prop="authorizeCode" />
        <el-table-column label="设备ID" width="75" align="center" prop="deviceId" />
        <el-table-column label="设备编号" width="150" align="center" prop="serialNumber" />
        <el-table-column label="用户ID" width="75" align="center" prop="userId" />
        <el-table-column label="用户名称" align="center" prop="userName" />
        <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
            <template slot-scope="scope">
                <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d} {h}:{m}:{s}') }}</span>
            </template>
        </el-table-column>
        <el-table-column label="备注" align="center" prop="remark" />
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
                <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:authorize:edit']">修改</el-button>
                <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:authorize:remove']" v-if="!scope.row.deviceId">删除</el-button>
            </template>
        </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 添加或修改产品授权码对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">
            <el-form-item label="设备ID" prop="deviceId">
                <el-input v-model="form.deviceId" placeholder="请输入设备ID" onkeyup="value=value.replace(/[^\d]/g,'')" />
            </el-form-item>
            <el-form-item label="设备编号" prop="serialNumber">
                <el-input v-model="form.serialNumber" placeholder="请输入设备编号" />
            </el-form-item>
            <el-form-item label="用户ID" prop="userId">
                <el-input v-model="form.userId" placeholder="请输入用户ID" onkeyup="value=value.replace(/[^\d]/g,'')" max="" />
            </el-form-item>
            <el-form-item label="用户名称" prop="userName">
                <el-input v-model="form.userName" placeholder="请输入用户名称" />
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
</div>
</template>

<style>
.createNum{
    width: 300px;
}
.createNum input{
    width: 130px;
}
</style>

<script>
import {
    listAuthorize,
    getAuthorize,
    delAuthorize,
    addProductAuthorizeByNum,
    updateAuthorize
} from "@/api/iot/authorize";
import {
    isNumberStr
} from '@/utils/index'
export default {
    name: "product-authorize",
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
                this.getList();
            }
        }
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
            // 产品授权码表格数据
            authorizeList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 新增个数
            createNum: 1,
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
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {

            }
        };
    },
    created() {

    },
    methods: {
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
        // 表单重置
        reset() {
            this.form = {
                authorizeId: null,
                authorizeCode: null,
                productId: "",
                deviceId: null,
                serialNumber: null,
                userId: "",
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
            this.ids = selection.map(item => item.authorizeId)
            this.single = selection.lengdelAuthorizeth !== 1
            this.multiple = !selection.length
        },
        /** 批量新增按钮操作 */
        handleAdd() {
            this.$prompt('输入新增授权码数量', '提示', {
              customClass: 'createNum',
              confirmButtonText: '确定',
              cancelButtonText: '取消',
              inputPattern: /[0-9\-]/,
              inputErrorMessage: '数量内容不正确',
              inputType: 'number',
              inputValue: this.createNum
            }).then(({ value }) => {
                this.createNum = value
                if (this.queryParams.productId != null) {
                    let _addData = {
                        productId : this.queryParams.productId,
                        createNum : this.createNum
                    }
                    addProductAuthorizeByNum(_addData).then(response => {
                        this.$modal.msgSuccess("新增授权码成功");
                        this.getList();
                        this.createNum = 1;
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
        handleUpdate(row) {
            this.reset();
            const authorizeId = row.authorizeId || this.ids
            getAuthorize(authorizeId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = "编辑授权码";
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.authorizeId != null) {
                        updateAuthorize(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    }
                }
            });
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
        handleChange(e) {
            console.log(currentValue)
            if (!isNumberStr(currentValue)) {
                this.$modal.msgSuccess("只能输入数字");
            }
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
