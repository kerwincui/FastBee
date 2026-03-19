<template>
<div style="padding: 6px">
    <el-card v-show="showSearch" style="margin-bottom: 6px">
        <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item :label="$t('speaker.clientDetails.index.893021-0')" prop="clientId">
                <el-input v-model="queryParams.clientId" :placeholder="$t('speaker.clientDetails.index.893021-1')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('speaker.clientDetails.index.893021-2')" prop="type">
                <el-select v-model="queryParams.type" :placeholder="$t('speaker.clientDetails.index.893021-3')" clearable size="small">
                    <el-option v-for="dict in dict.type.oauth_platform" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">{{ $t('search') }}</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">{{ $t('reset') }}</el-button>
                <el-tag type="danger" style="margin-left:15px;">{{ $t('system.clientDetails.293742-0') }}</el-tag>
            </el-form-item>
            <el-form-item style="float:right;">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:clientDetails:add']">{{ $t('add') }}</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom: 100px">
        <el-table v-loading="loading" :data="clientDetailsList" @selection-change="handleSelectionChange">
            <el-table-column :label="$t('speaker.clientDetails.index.893021-0')" align="center" prop="clientId" />
            <el-table-column :label="$t('system.clientDetails.293742-1')" align="center" prop="resourceIds" />
            <el-table-column :label="$t('speaker.clientDetails.index.893021-12')" align="center" prop="scope" />
            <el-table-column :label="$t('speaker.clientDetails.index.893021-2')" align="center" prop="type">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.oauth_platform" :value="scope.row.type" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('system.clientDetails.293742-2')" align="center" prop="autoapprove">
                <template slot-scope="scope">
                    <span v-if="scope.row.autoapprove=='true'">{{ $t('system.clientDetails.293742-3') }}</span>
                    <span v-if="scope.row.autoapprove=='false'">{{ $t('system.clientDetails.293742-4') }}</span>
                </template>
            </el-table-column>
            <el-table-column :label="$t('speaker.clientDetails.index.893021-14')" align="center" prop="authorizedGrantTypes">
                <template slot-scope="scope">
                    <div v-html="formatGrantTypesDisplay(scope.row.authorizedGrantTypes)"></div>
                </template>
            </el-table-column>
            <el-table-column :label="$t('speaker.clientDetails.index.893021-15')" align="center" prop="webServerRedirectUri" min-width="130" />
            <el-table-column :label="$t('system.clientDetails.293742-5')" align="center" prop="authorities" />
            <el-table-column :label="$t('speaker.clientDetails.index.893021-16')" align="center" prop="accessTokenValidity" />
            <el-table-column :label="$t('system.clientDetails.293742-6')" align="center" prop="refreshTokenValidity" />

            <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:clientDetails:edit']">{{ $t('update') }}</el-button>
                    <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:clientDetails:remove']" disabled>{{ $t('del') }}</el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 添加或修改对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="120px">
                <el-form-item :label="$t('speaker.clientDetails.index.893021-2')" prop="type">
                    <el-select v-model="form.type" :placeholder="$t('speaker.clientDetails.detail-dialog.455323-5')">
                        <el-option v-for="dict in dict.type.oauth_platform" :key="dict.value" :label="dict.label" :value="parseInt(dict.value)"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item :label="$t('speaker.clientDetails.index.893021-0')" prop="clientId">
                    <el-input v-model="form.clientId" :placeholder="$t('speaker.clientDetails.index.893021-1')" />
                </el-form-item>
                <el-form-item :label="$t('system.clientDetails.293742-7')" prop="resourceIds">
                    <el-input v-model="form.resourceIds" :placeholder="$t('system.clientDetails.293742-8')" />
                </el-form-item>
                <el-form-item :label="$t('speaker.clientDetails.index.893021-14')" prop="authorizedGrantTypes">
                    <el-input v-model="form.authorizedGrantTypes" type="textarea" :placeholder="$t('system.clientDetails.293742-9')" />
                </el-form-item>
                <el-form-item :label="$t('speaker.clientDetails.detail-dialog.455323-15')" prop="clientSecret">
                    <el-input v-model="form.clientSecret" :placeholder="$t('system.clientDetails.293742-10')" />
                </el-form-item>
                <el-form-item :label="$t('speaker.clientDetails.index.893021-15')" prop="webServerRedirectUri">
                    <el-input v-model="form.webServerRedirectUri" type="textarea" :placeholder="$t('speaker.clientDetails.detail-dialog.455323-24')" />
                </el-form-item>
                <el-form-item :label="$t('system.clientDetails.293742-5')" prop="authorities">
                    <el-input v-model="form.authorities" :placeholder="$t('system.clientDetails.293742-11')" />
                </el-form-item>
                <el-form-item :label="$t('speaker.clientDetails.index.893021-16')" prop="accessTokenValidity">
                    <el-input v-model="form.accessTokenValidity" :placeholder="$t('system.clientDetails.293742-12')" />
                </el-form-item>
                <el-form-item :label="$t('system.clientDetails.293742-6')" prop="refreshTokenValidity">
                    <el-input v-model="form.refreshTokenValidity" :placeholder="$t('system.clientDetails.293742-13')" />
                </el-form-item>
                <el-form-item :label="$t('speaker.clientDetails.detail-dialog.455323-25')" prop="additionalInformation">
                    <el-input v-model="form.additionalInformation" type="textarea" :placeholder="$t('product.category.142342-3')" />
                </el-form-item>

            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm" disabled>{{ $t('confirm') }}</el-button>
                <el-button @click="cancel">{{ $t('cancel') }}</el-button>
            </div>
        </el-dialog>
    </el-card>
</div>
</template>

<script>
import {
    listClientDetails,
    getClientDetails,
    delClientDetails,
    addClientDetails,
    updateClientDetails,
} from "@/api/iot/clientDetails";

export default {
    name: "ClientDetails",
    dicts: ["oauth_platform"],
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
            // 云云对接表格数据
            clientDetailsList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                clientId: null,
                authorizedGrantTypes: null,
                autoapprove: null,
                type: null,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {},
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询列表 */
        getList() {
            this.loading = true;
            listClientDetails(this.queryParams).then((response) => {
                this.clientDetailsList = response.rows;
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
                clientId: null,
                resourceIds: null,
                clientSecret: null,
                scope: null,
                authorizedGrantTypes: null,
                webServerRedirectUri: null,
                authorities: null,
                accessTokenValidity: null,
                refreshTokenValidity: null,
                additionalInformation: null,
                autoapprove: null,
                type: null,
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
            this.ids = selection.map((item) => item.clientId);
            this.single = selection.length !== 1;
            this.multiple = !selection.length;
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('system.clientDetails.293742-14');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const clientId = row.clientId || this.ids;
            getClientDetails(clientId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.clientDetails.293742-15');
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate((valid) => {
                if (valid) {
                    if (this.form.clientId != null) {
                        updateClientDetails(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addClientDetails(this.form).then((response) => {
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
            const clientIds = row.clientId || this.ids;
            this.$modal
                .confirm(this.$t('speaker.clientDetails.index.893021-21', [clientIds]))
                .then(function () {
                    return delClientDetails(clientIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('delSuccess'));
                })
                .catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                "iot/clientDetails/export", {
                    ...this.queryParams,
                },
                `clientDetails_${new Date().getTime()}.xlsx`
            );
        },
        /** 格式化显示授权模式 */
        formatGrantTypesDisplay(data) {
            let dataArray = data.split(",");
            let displayHtml = ""
            for (let i = 0; i < dataArray.length; i++) {
                displayHtml = displayHtml + "<div style='background-color:#eee;margin:0 auto;margin-bottom:5px;width:86px;border-radius:5px;padding:3px;'>" + this.convertGrantType(dataArray[i]) + "</div>"
            }
            return displayHtml;
        },
        /** 授权模式转换 */
        convertGrantType(type) {
            if (type == "client_credentials") {
                return this.$t('system.clientDetails.293742-16')
            } else if (type == "password") {
                return this.$t('system.clientDetails.293742-17');
            } else if (type == "authorization_code") {
                return this.$t('system.clientDetails.293742-18');
            } else if (type == "implicit") {
                return this.$t('system.clientDetails.293742-19');
            } else if (type == "refresh_token") {
                return this.$t('system.clientDetails.293742-20');
            } else {
                return "";
            }
        }

    },
};
</script>
