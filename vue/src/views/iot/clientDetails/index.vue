<template>
<div style="padding: 6px">
    <el-card v-show="showSearch" style="margin-bottom: 6px">
        <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item label="客户端ID" prop="clientId">
                <el-input v-model="queryParams.clientId" placeholder="请输入客户端ID" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="授权平台" prop="type">
                <el-select v-model="queryParams.type" placeholder="请选择平台" clearable size="small">
                    <el-option v-for="dict in dict.type.oauth_platform" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
                <el-tag type="danger" style="margin-left:15px;">该功能暂不可用,后面版本发布</el-tag>
            </el-form-item>
            <el-form-item style="float:right;">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:clientDetails:add']">新增</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom: 100px">
        <el-table v-loading="loading" :data="clientDetailsList" @selection-change="handleSelectionChange">
            <el-table-column label="客户端ID" align="center" prop="clientId" />
            <el-table-column label="资源" align="center" prop="resourceIds" />
            <el-table-column label="权限范围" align="center" prop="scope" />
            <el-table-column label="授权平台" align="center" prop="type">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.oauth_platform" :value="scope.row.type" />
                </template>
            </el-table-column>
            <el-table-column label="自动授权" align="center" prop="autoapprove">
                <template slot-scope="scope">
                    <span v-if="scope.row.autoapprove=='true'">自动授权</span>
                    <span v-if="scope.row.autoapprove=='false'">用户验证</span>
                </template>
            </el-table-column>
            <el-table-column label="授权模式" align="center" prop="authorizedGrantTypes">
                <template slot-scope="scope">
                    <div v-html="formatGrantTypesDisplay(scope.row.authorizedGrantTypes)"></div>
                </template>
            </el-table-column>
            <el-table-column label="回调地址" align="center" prop="webServerRedirectUri" min-width="130" />
            <el-table-column label="权限" align="center" prop="authorities" />
            <el-table-column label="Token有效期" align="center" prop="accessTokenValidity" />
            <el-table-column label="Token刷新时间" align="center" prop="refreshTokenValidity" />

            <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:clientDetails:edit']">修改</el-button>
                    <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:clientDetails:remove']" disabled>删除</el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 添加或修改云云对接对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="120px">
                <el-form-item label="授权平台" prop="type">
                    <el-select v-model="form.type" placeholder="请选择授权平台">
                        <el-option v-for="dict in dict.type.oauth_platform" :key="dict.value" :label="dict.label" :value="parseInt(dict.value)"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="客户端ID" prop="clientId">
                    <el-input v-model="form.clientId" placeholder="请输入客户端ID" />
                </el-form-item>
                <el-form-item label="资源集合" prop="resourceIds">
                    <el-input v-model="form.resourceIds" placeholder="请输入资源" />
                </el-form-item>
                <el-form-item label="授权模式" prop="authorizedGrantTypes">
                    <el-input v-model="form.authorizedGrantTypes" type="textarea" placeholder="请输入授权模式" />
                </el-form-item>
                <el-form-item label="秘钥" prop="clientSecret">
                    <el-input v-model="form.clientSecret" placeholder="请输入客户端秘钥" />
                </el-form-item>
                <el-form-item label="回调地址" prop="webServerRedirectUri">
                    <el-input v-model="form.webServerRedirectUri" type="textarea" placeholder="请输入回调地址" />
                </el-form-item>
                <el-form-item label="权限" prop="authorities">
                    <el-input v-model="form.authorities" placeholder="请输入权限" />
                </el-form-item>
                <el-form-item label="Token有效期" prop="accessTokenValidity">
                    <el-input v-model="form.accessTokenValidity" placeholder="请输入Token有效时间" />
                </el-form-item>
                <el-form-item label="Token刷新时间" prop="refreshTokenValidity">
                    <el-input v-model="form.refreshTokenValidity" placeholder="请输入Token刷新有效时间" />
                </el-form-item>
                <el-form-item label="预留信息" prop="additionalInformation">
                    <el-input v-model="form.additionalInformation" type="textarea" placeholder="请输入内容" />
                </el-form-item>

            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm" disabled>确 定</el-button>
                <el-button @click="cancel">取 消</el-button>
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
        /** 查询云云对接列表 */
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
            this.title = "添加云云对接";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const clientId = row.clientId || this.ids;
            getClientDetails(clientId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = "修改云云对接";
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate((valid) => {
                if (valid) {
                    if (this.form.clientId != null) {
                        updateClientDetails(this.form).then((response) => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addClientDetails(this.form).then((response) => {
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
            const clientIds = row.clientId || this.ids;
            this.$modal
                .confirm('是否确认删除云云对接编号为"' + clientIds + '"的数据项？')
                .then(function () {
                    return delClientDetails(clientIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess("删除成功");
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
                return "客户端模式"
            } else if (type == "password") {
                return "密码模式";
            } else if (type == "authorization_code") {
                return "授权码模式";
            } else if (type == "implicit") {
                return "简化模式";
            } else if (type == "refresh_token") {
                return "刷新Token";
            } else {
                return "";
            }
        }

    },
};
</script>
