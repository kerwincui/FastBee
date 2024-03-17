<template>
    <div style="padding:6px;">
        <el-card v-show="showSearch" style="margin-bottom:5px;">
            <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom:-20px;">
                <el-form-item label="分类名称" prop="categoryName">
                    <el-input v-model="queryParams.categoryName" placeholder="请输入产品分类名称" clearable size="small"
                        @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                    <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
                </el-form-item>
                <el-form-item style="float:right;">
                    <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd"
                        v-hasPermi="['iot:category:add']">新增</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <el-card style="padding-bottom:100px;">
            <el-table v-loading="loading" :data="categoryList" @selection-change="handleSelectionChange" border>
                <el-table-column label="产品分类名称" align="center" prop="categoryName" />
                <el-table-column label="备注" align="left" header-align="center" prop="remark" min-width="150" />
                <el-table-column label="系统定义" align="center" prop="isSys">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isSys" />
                    </template>
                </el-table-column>
                <el-table-column label="显示顺序" align="center" prop="orderNum" />
                <el-table-column label="创建时间" align="center" prop="createTime" width="180">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                    </template>
                </el-table-column>
                <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
                    <template slot-scope="scope">
                        <el-button size="small" type="primary" style="padding:5px;" icon="el-icon-edit"
                            @click="handleUpdate(scope.row)" v-hasPermi="['iot:category:query']"
                            v-if="scope.row.isSys == '0' ? true : !isTenant">修改</el-button>
                        <el-button size="small" type="danger" style="padding:5px;" icon="el-icon-delete"
                            @click="handleDelete(scope.row)" v-hasPermi="['iot:category:remove']"
                            v-if="scope.row.isSys == '0' ? true : !isTenant">删除</el-button>
                        <span style="font-size:10px;color:#999;" v-if="scope.row.isSys == '1' && isTenant">系统定义，不能修改</span>
                    </template>
                </el-table-column>
            </el-table>

            <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum"
                :limit.sync="queryParams.pageSize" @pagination="getList" />

            <!-- 添加或修改产品分类对话框 -->
            <el-dialog title="产品分类" :visible.sync="open" width="500px" append-to-body>
                <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                    <el-form-item label="分类名称" prop="categoryName">
                        <el-input v-model="form.categoryName" placeholder="请输入产品分类名称" />
                    </el-form-item>
                    <el-form-item label="显示顺序" prop="orderNum">
                        <el-input-number controls-position="right" v-model="form.orderNum" 
                            placeholder="请输入显示顺序" style="width:100%" />
                    </el-form-item>
                    <el-form-item label="备注" prop="remark">
                        <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:category:edit']"
                        v-show="form.categoryId">修 改</el-button>
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:category:add']"
                        v-show="!form.categoryId">新 增</el-button>
                    <el-button @click="cancel">取 消</el-button>
                </div>
            </el-dialog>

        </el-card>
    </div>
</template>

<script>
import {
    listCategory,
    getCategory,
    delCategory,
    addCategory,
    updateCategory
} from "@/api/iot/category";

export default {
    name: "Category",
    dicts: ["iot_yes_no"],
    data() {
        return {
            // 是否为租户
            isTenant: false,
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
            // 产品分类表格数据
            categoryList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 20,
                categoryName: null,
                isSys: null,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                categoryName: [{
                    required: true,
                    message: "产品分类名称不能为空",
                    trigger: "blur"
                }, {
                    min: 1,
                    max: 64,
                    message: '产品分类不能少于1个字符和超过64字符',
                },
                ],
                orderNum: [{
                    required: true,
                    message: '分类顺序不能为空',
                    trigger: 'blur',
                }, {
                    type: 'number',
                    min: -2147483648,
                    max: 2147483647,
                    message: '顺序值不能超过int型的取值范围(-2^31——2^31-1)',
                    trigger: 'blur',
                }],
                remark: [{
                    required: false,
                    min: 0,
                    max: 500,
                    message: '备注不能输入超过500个字符',
                    trigger: 'blur',
                }],
                isSys: [{
                    required: true,
                    message: "是否系统通用不能为空",
                    trigger: "blur"
                }],
            }
        };
    },
    created() {
        this.getList();
        this.init();
    },
    methods: {
        init() {
            if (this.$store.state.user.roles.indexOf("tenant") !== -1) {
                this.isTenant = true
            }
        },
        /** 查询产品分类列表 */
        getList() {
            this.loading = true;
            listCategory(this.queryParams).then(response => {
                this.categoryList = response.rows;
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
                categoryId: null,
                categoryName: null,
                tenantId: null,
                tenantName: null,
                isSys: null,
                parentId: null,
                orderNum: 0,
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
            this.ids = selection.map(item => item.categoryId)
            this.single = selection.length !== 1
            this.multiple = !selection.length
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = "添加产品分类";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const categoryId = row.categoryId || this.ids
            getCategory(categoryId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = "修改产品分类";
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.categoryId != null) {
                        updateCategory(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addCategory(this.form).then(response => {
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
            const categoryIds = row.categoryId || this.ids;
            let msg = "";
            this.$modal.confirm('是否确认删除产品分类编号为"' + categoryIds + '"的数据项？').then(function () {
                return delCategory(categoryIds).then(response => {
                    msg = response.msg;
                });
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess(msg);
            }).catch(() => { });
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/category/export', {
                ...this.queryParams
            }, `category_${new Date().getTime()}.xlsx`)
        }
    }
};
</script>
