<template>
    <div class="iot-platform">
        <el-card v-show="showSearch" class="search-card">
            <el-form @submit.native.prevent :model="queryParams" ref="queryForm" :inline="true" label-width="85px" class="search-form">
                <el-form-item prop="platform">
                    <el-select v-model="queryParams.platform" clearable :placeholder="$t('system.platform.675309-1')">
                        <el-option v-for="dict in dict.type.iot_social_platform" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <el-form-item prop="status">
                    <el-select v-model="queryParams.status" clearable :placeholder="$t('system.platform.675309-2')">
                        <el-option v-for="dict in dict.type.iot_social_platform_status" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <div style="float: right">
                    <el-button type="primary" icon="el-icon-search" @click="handleQuery">{{ $t('device.index.105953-8') }}</el-button>
                    <el-button icon="el-icon-refresh" @click="resetQuery">{{ $t('device.index.105953-9') }}</el-button>
                </div>
            </el-form>
        </el-card>

        <el-card>
            <el-row :gutter="10" style="margin-bottom: 16px">
                <el-col :span="1.5">
                    <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['iot:platform:add']">{{ $t('system.sysclient.652154-4') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button plain icon="el-icon-edit" size="small" :disabled="single" @click="handleUpdate" v-hasPermi="['iot:platform:edit']">{{ $t('system.sysclient.652154-5') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete" v-hasPermi="['iot:platform:remove']">{{ $t('system.sysclient.652154-6') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button plain icon="el-icon-download" size="small" @click="handleExport" v-hasPermi="['iot:platform:export']">{{ $t('system.sysclient.652154-7') }}</el-button>
                </el-col>
                <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            </el-row>

            <el-table v-loading="loading" :data="platformList" :border="false" @selection-change="handleSelectionChange" ref="multipleTable" :row-key="getRowKeys">
                <el-table-column :reserve-selection="true" type="selection" width="55" align="center" />
                <el-table-column align="left" :label="$t('system.platform.675309-3')" prop="platform" min-width="200">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_social_platform" :value="scope.row.platform" />
                    </template>
                </el-table-column>
                <el-table-column align="center" :label="$t('device.device-timer.433369-11')" prop="status" width="80">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_social_platform_status" :value="scope.row.status" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('system.platform.675309-4')" align="center" prop="clientId" min-width="180" />
                <el-table-column :label="$t('system.platform.675309-5')" align="left" prop="redirectUri" min-width="250" :show-overflow-tooltip="true" />
                <el-table-column align="left" :label="$t('system.platform.675309-6')" prop="bindUri" :show-tooltip-when-overflow="true" :render-header="(h, column) => renderHeaderMethods(h, column, columnTips.bindId)" min-width="250" />
                <el-table-column
                    align="left"
                    :label="$t('system.platform.675309-7')"
                    prop="redirectLoginUri"
                    :show-tooltip-when-overflow="true"
                    :render-header="(h, column) => renderHeaderMethods(h, column, columnTips.redirectLogin)"
                    min-width="250"
                />
                <el-table-column
                    align="left"
                    :label="$t('system.platform.675309-8')"
                    prop="errorMsgUri"
                    :show-tooltip-when-overflow="true"
                    :render-header="(h, column) => renderHeaderMethods(h, column, columnTips.errorId)"
                    min-width="250"
                />
                <el-table-column align="center" :label="$t('device.index.105953-33')" prop="createTime" width="100">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                    </template>
                </el-table-column>
                <el-table-column fixed="right" :label="$t('device.index.105953-34')" align="center" width="125">
                    <template slot-scope="scope">
                        <el-button size="small" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:platform:edit']">{{ $t('system.sysclient.652154-5') }}</el-button>
                        <el-button size="small" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:platform:remove']">{{ $t('system.sysclient.652154-6') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <pagination style="margin-bottom: 20px" v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
        </el-card>

        <!-- 添加或修改第三方登录平台控制对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="630px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="130px">
                <el-form-item :label="$t('system.platform.675309-9')" prop="platform">
                    <el-select v-model="form.platform" :placeholder="$t('system.platform.675309-10')" style="width: 400px">
                        <el-option v-for="dict in dict.type.iot_social_platform" :key="dict.value" :label="dict.label" :value="dict.value"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item :label="$t('system.platform.675309-11')" prop="status">
                    <el-select v-model="form.status" :placeholder="$t('system.platform.675309-2')" style="width: 400px">
                        <el-option v-for="dict in dict.type.iot_social_platform_status" :key="dict.value" :label="dict.label" :value="Number(dict.value)"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item :label="$t('system.platform.675309-12')" prop="clientId">
                    <el-input v-model="form.clientId" :placeholder="$t('system.platform.675309-13')" style="width: 400px" />
                </el-form-item>
                <el-form-item :label="$t('system.platform.675309-14')" prop="secretKey">
                    <el-input v-model="form.secretKey" :placeholder="$t('system.platform.675309-15')" style="width: 400px" />
                </el-form-item>
                <el-form-item :label="$t('system.platform.675309-16')" prop="redirectUri">
                    <el-input v-model="form.redirectUri" :placeholder="$t('system.platform.675309-17')" style="width: 400px" />
                </el-form-item>
                <el-form-item :label="$t('system.platform.675309-18')" prop="bindUri">
                    <el-input v-model="form.bindUri" :placeholder="$t('system.platform.675309-19')" style="width: 400px" />
                </el-form-item>
                <el-form-item :label="$t('system.platform.675309-20')" prop="redirectLoginUri">
                    <el-input v-model="form.redirectLoginUri" :placeholder="$t('system.platform.675309-21')" style="width: 400px" />
                </el-form-item>
                <el-form-item :label="$t('system.platform.675309-22')" prop="errorMsgUri">
                    <el-input v-model="form.errorMsgUri" :placeholder="$t('system.platform.675309-23')" style="width: 400px" />
                </el-form-item>
                <el-form-item :label="$t('iot.group.index.637432-9')" prop="remark">
                    <el-input v-model="form.remark" :placeholder="$t('iot.group.index.637432-16')" type="textarea" :autosize="{ minRows: 3, maxRows: 5 }" style="width: 400px" />
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">{{ $t('device.index.105953-56') }}</el-button>
                <el-button @click="cancel">{{ $t('iot.group.index.637432-19') }}</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import { addPlatform, delPlatform, getPlatform, listPlatform, updatePlatform } from '@/api/iot/platform';

export default {
    name: 'Platform',
    dicts: ['iot_social_platform', 'iot_social_platform_status'],
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
            // 第三方登录平台控制表格数据
            platformList: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                platform: null,
                status: null,
            },
            columnTips: {
                bindId: this.$t('system.platform.675309-24'),
                redirectLogin: this.$t('system.platform.675309-25'),
                errorId: this.$t('system.platform.675309-26'),
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                platform: [
                    {
                        required: true,
                        message: this.$t('system.platform.675309-27'),
                        trigger: 'change',
                    },
                ],
                status: [
                    {
                        required: true,
                        message: this.$t('system.platform.675309-28'),
                        trigger: 'change',
                    },
                ],
                clientId: [
                    {
                        required: true,
                        message: this.$t('system.platform.675309-29'),
                        trigger: 'blur',
                    },
                ],
                secretKey: [
                    {
                        required: true,
                        message: this.$t('system.platform.675309-30'),
                        trigger: 'blur',
                    },
                ],
                redirectUri: [
                    {
                        required: true,
                        message: this.$t('system.platform.675309-31'),
                        trigger: 'blur',
                    },
                ],
                bindUri: [
                    {
                        required: true,
                        message: this.$t('system.platform.675309-32'),
                        trigger: 'blur',
                    },
                ],
                redirectLoginUri: [
                    {
                        required: true,
                        message: this.$t('system.platform.675309-33'),
                        trigger: 'blur',
                    },
                ],
                errorMsgUri: [
                    {
                        required: true,
                        message: this.$t('system.platform.675309-34'),
                        trigger: 'blur',
                    },
                ],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        renderHeaderMethods(h, { column }, content) {
            return h('div', [
                h('span', column.label),
                h(
                    'el-tooltip',
                    {
                        props: {
                            effect: 'dark',
                            content: content,
                            placement: 'top',
                        },
                    },
                    [
                        h('i', {
                            class: 'el-icon-question',
                            style: 'color:#486FF2;margin-left:5px;',
                        }),
                    ]
                ),
            ]);
        },
        /** 查询第三方登录平台控制列表 */
        getList() {
            this.loading = true;
            listPlatform(this.queryParams).then((response) => {
                this.platformList = response.rows;
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
                socialPlatformId: null,
                platform: null,
                status: null,
                clientId: null,
                secretKey: null,
                redirectUri: null,
                createBy: null,
                createTime: null,
                updateTime: null,
                updateBy: null,
                remark: null,
                bindUri: null,
                redirectLoginUri: null,
                errorMsgUri: null,
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
            this.ids = selection.map((item) => item.socialPlatformId);
            this.single = selection.length !== 1;
            this.multiple = !selection.length;
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('system.platform.675309-35');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const socialPlatformId = row.socialPlatformId || this.ids;
            getPlatform(socialPlatformId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.platform.675309-36');
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.socialPlatformId != null) {
                        updatePlatform(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('iot.group.index.637432-24'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addPlatform(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('iot.group.index.637432-25'));
                            this.open = false;
                            this.getList();
                        });
                    }
                }
            });
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const socialPlatformIds = row.socialPlatformId || this.ids;
            this.$modal
                .confirm(this.$t('system.platform.675309-37', [socialPlatformIds]))
                .then(function () {
                    return delPlatform(socialPlatformIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('iot.group.index.637432-27'));
                    this.$refs.multipleTable.clearSelection();
                })
                .catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                'iot/platform/export',
                {
                    ...this.queryParams,
                },
                `platform_${new Date().getTime()}.xlsx`
            );
        },
        getRowKeys(row) {
            return row.socialPlatformId;
        },
    },
};
</script>

<style lang="scss" scoped>
.iot-platform {
    padding: 20px;

    .search-card {
        margin-bottom: 15px;
        padding: 3px 0;
    }

    .search-form {
        margin-bottom: -22.5px;
    }
}
</style>
