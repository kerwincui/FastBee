<template>
    <div class="category_wrap">
        <el-card shadow="never" v-show="showSearch" style="margin-bottom: 10px">
            <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom: -20px">
                <el-form-item :label="$t('product.category.142342-0')" prop="categoryName">
                    <el-input v-model="queryParams.categoryName" :placeholder="$t('product.index.091251-3')" clearable size="small" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item style="float: right">
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <el-card shadow="never" style="padding-bottom: 100px">
            <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['iot:category:add']" style="margin-bottom: 10px">{{ $t('add') }}</el-button>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            <el-table v-loading="loading" :data="categoryList" @selection-change="handleSelectionChange" :border="false" header-cell-class-name="table-header">
                <el-table-column :label="$t('product.category.142342-0')" align="center" prop="categoryName" />
                <el-table-column :label="$t('remark')" align="left" header-align="center" prop="remark" min-width="150" />
                <el-table-column :label="$t('template.index.891112-12')" align="center" prop="isSys">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isSys" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('product.category.142342-1')" align="center" prop="orderNum" />
                <el-table-column :label="$t('creatTime')" align="center" prop="createTime" width="180">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width" width="150">
                    <template slot-scope="scope">
                        <el-button size="small" type="text" style="padding: 5px" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:category:query']" v-if="scope.row.isSys == '0' ? true : !isTenant">
                            {{ $t('update') }}
                        </el-button>
                        <el-button
                            size="small"
                            type="text"
                            style="padding: 5px"
                            icon="el-icon-delete"
                            @click="handleDelete(scope.row)"
                            v-hasPermi="['iot:category:remove']"
                            v-if="scope.row.isSys == '0' ? true : !isTenant"
                        >
                            {{ $t('del') }}
                        </el-button>
                        <span style="font-size: 10px; color: #999" v-if="scope.row.isSys == '1' && isTenant">{{ $t('template.index.891112-21') }}</span>
                    </template>
                </el-table-column>
            </el-table>

            <div class="pagination-container">
                <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
            </div>

            <!-- 添加或修改产品分类对话框 -->
            <el-dialog :title="$t('product.product-edit.473153-3')" :visible.sync="open" width="500px" append-to-body>
                <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                    <el-form-item :label="$t('product.category.142342-0')" prop="categoryName">
                        <el-input v-model="form.categoryName" :placeholder="$t('product.index.091251-3')" />
                    </el-form-item>
                    <el-form-item :label="$t('product.category.142342-1')" prop="orderNum">
                        <el-input-number controls-position="right" v-model="form.orderNum" :placeholder="$t('product.category.142342-2')" style="width: 100%" />
                    </el-form-item>
                    <el-form-item :label="$t('remark')" prop="remark">
                        <el-input v-model="form.remark" type="textarea" :placeholder="$t('product.category.142342-3')" />
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:category:edit']" v-show="form.categoryId">{{ $t('update') }}</el-button>
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:category:add']" v-show="!form.categoryId">{{ $t('add') }}</el-button>
                    <el-button @click="cancel">{{ $t('cancel') }}</el-button>
                </div>
            </el-dialog>
        </el-card>
    </div>
</template>

<script>
import { listCategory, getCategory, delCategory, addCategory, updateCategory } from '@/api/iot/category';

export default {
    name: 'Category',
    dicts: ['iot_yes_no'],
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
            title: '',
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
                categoryName: [
                    {
                        required: true,
                        message: this.$t('product.category.142342-4'),
                        trigger: 'blur',
                    },
                    {
                        min: 1,
                        max: 64,
                        message: this.$t('product.category.142342-12'),
                    },
                ],
                orderNum: [
                    {
                        required: true,
                        message: this.$t('product.category.142342-13'),
                        trigger: 'blur',
                    },
                    {
                        type: 'number',
                        min: -2147483648,
                        max: 2147483647,
                        message: this.$t('product.category.142342-14'),
                        trigger: 'blur',
                    },
                ],
                remark: [
                    {
                        required: false,
                        min: 0,
                        max: 500,
                        message: this.$t('product.category.142342-15'),
                        trigger: 'blur',
                    },
                ],
                isSys: [
                    {
                        required: true,
                        message: this.$t('product.category.142342-5'),
                        trigger: 'blur',
                    },
                ],
            },
        };
    },
    created() {
        this.getList();
        this.init();
    },
    methods: {
        init() {
            if (this.$store.state.user.roles.indexOf('tenant') !== -1) {
                this.isTenant = true;
            }
        },
        /** 查询产品分类列表 */
        getList() {
            this.loading = true;
            listCategory(this.queryParams).then((response) => {
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
                remark: null,
            };
            this.resetForm('form');
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.queryParams.pageNum = 1;
            this.getList();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.resetForm('queryForm');
            this.handleQuery();
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map((item) => item.categoryId);
            this.single = selection.length !== 1;
            this.multiple = !selection.length;
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('product.category.142342-6');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const categoryId = row.categoryId || this.ids;
            getCategory(categoryId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('product.category.142342-7');
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.categoryId != null) {
                        updateCategory(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addCategory(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('addSuccess'));
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
            let msg = '';
            this.$modal
                .confirm(this.$t('product.category.142342-8', [categoryIds]))
                .then(function () {
                    return delCategory(categoryIds).then((response) => {
                        msg = response.msg;
                    });
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(msg);
                })
                .catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                'iot/category/export',
                {
                    ...this.queryParams,
                },
                `category_${new Date().getTime()}.xlsx`
            );
        },
    },
};
</script>

<style lang="scss" scoped>
.table-header {
    background-color: #f5f7fa !important;
    color: #606266;
    font-weight: 600;
    text-align: center;
}

::v-deep .el-table {
    th {
        background-color: #f5f7fa;
        color: #606266;
        font-weight: 600;
        text-align: center;
    }

    td {
        padding: 12px 0;
    }

    .el-table__body tr:hover > td {
        background-color: #f5f7fa !important;
    }
}

.pagination-container {
    line-height: 40px;
    margin-bottom: 30px;
    margin-top: 0;
    padding: 0;
}

::v-deep .el-pagination {
    padding: 0;
    text-align: right;
}

.category_wrap {
    padding: 15px;
    min-height: 100vh;
    background-color: #f5f7fa;
}
</style>
