<template>
    <div style="padding: 6px">
        <el-card v-show="showSearch" style="margin-bottom: 6px">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch"
                label-width="68px" style="margin-bottom: -20px">
                <el-form-item label="脚本标识" prop="scriptId">
                    <el-input v-model="queryParams.scriptId" placeholder="请输入脚本名" clearable
                        @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item label="脚本名" prop="scriptName">
                    <el-input v-model="queryParams.scriptName" placeholder="请输入脚本名" clearable
                        @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                    <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
                </el-form-item>
                <el-form-item style="float: right">
                    <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd"
                        v-hasPermi="['iot:script:add']">新增</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <el-card style="padding-bottom: 100px">
            <el-table v-loading="loading" :data="scriptList" @selection-change="handleSelectionChange">
                <el-table-column label="脚本名称" align="center" prop="scriptName" />
                <el-table-column label="所属产品" align="center" prop="productName" />
                <el-table-column label="脚本标识" align="center" prop="scriptId" width="180" />
                <el-table-column label="脚本事件" align="center" prop="status">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.rule_script_event" :value="scope.row.scriptEvent" size="small" />
                    </template>
                </el-table-column>
                <el-table-column label="脚本动作" align="center" prop="status">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.rule_script_action" :value="scope.row.scriptAction"
                            size="small" />
                    </template>
                </el-table-column>
                <el-table-column label="脚本语言" align="center" prop="scriptLanguage" />
                <el-table-column label="状态" align="center" prop="enable" width="120">
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.enable == 1" type="success" size="small">启动</el-tag>
                        <el-tag v-if="scope.row.enable == 0" type="danger" size="small">暂停</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="执行顺序" align="center" prop="scriptOrder" />
                <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="200">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" icon="el-icon-view" @click="handleUpdate(scope.row)"
                            v-hasPermi="['iot:script:query']">查看</el-button>
                        <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)"
                            v-hasPermi="['iot:script:remove']">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum"
                :limit.sync="queryParams.pageSize" @pagination="getList" />

            <!-- 添加或修改规则引擎脚本对话框 -->
            <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body :close-on-click-modal="false"
                :close-on-press-escape="false">
                <el-form ref="form" :model="form" :rules="rules" label-width="90px">
                    <el-row :gutter="50">
                        <el-col :span="12">
                            <el-form-item label="脚本名称" prop="scriptName">
                                <el-input v-model="form.scriptName" placeholder="请输入脚本名" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="执行顺序" prop="scriptOrder">
                                <el-input-number v-model="form.scriptOrder" placeholder="请输入脚本名" type="number"
                                    controls-position="right" style="width: 100%" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="脚本事件" prop="scriptEvent">
                                <el-select v-model="form.scriptEvent" placeholder="请选择脚本事件" style="width: 100%">
                                    <el-option v-for="dict in dict.type.rule_script_event" :key="dict.label"
                                        :label="dict.label" :value="Number(dict.value)"
                                        :disabled="dict.value !== '1' && dict.value !== '2'"></el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>

                        <el-col :span="12">
                            <el-form-item label="脚本动作" prop="scriptAction">
                                <el-select v-model="form.scriptAction" placeholder="请选择脚本动作" style="width: 100%">
                                    <el-option v-for="dict in dict.type.rule_script_action" :key="dict.label"
                                        :label="dict.label" :value="Number(dict.value)"
                                        :disabled="dict.value !== '1'"></el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="脚本状态" prop="enable">
                                <el-switch v-model="form.enable" :active-value="1" :inactive-value="0" disabled />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="所属产品" prop="productName">
                                <el-input readonly v-model="form.productName" size="small" placeholder="请选择产品"
                                    style="margin-top: 3px">
                                    <el-button slot="append" @click="handleSelectProduct()"
                                        size="small">选择产品</el-button>
                                </el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" style="float: right"></el-col>
                    </el-row>
                </el-form>
                <div style="padding: 0px 10px" @click="editClick">
                    <AceEditor ref="codeEditor" :content.sync="form.scriptData" lang="groovy" codeStyle="chrome"
                        :read-only="false" width="100%" height="450px"></AceEditor>
                </div>
                <div style="padding: 0 10px; margin: 10px 0">
                    <el-alert :title="validateMsg" type="success" show-icon v-if="isValidate && validateMsg"
                        :closable="false"></el-alert>
                    <el-alert :title="validateMsg" type="error" show-icon v-if="!isValidate && validateMsg"
                        :closable="false"></el-alert>
                </div>
                <div slot="footer" class="dialog-footer">
                    <span style="float: left">
                        <el-link style="line-height: 40px; padding-left: 20px" icon="el-icon-question"
                            :underline="false" type="primary" href="https://fastbee.cn/doc/pages/rule_engine/"
                            target="_blank">
                            脚本使用Groovy引擎，查看教程>>>
                        </el-link>
                    </span>
                    <el-button type="success" @click="handleValidate">验 证</el-button>
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:script:edit']"
                        v-show="form.scriptId" :disabled="!isValidate">修
                        改</el-button>
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:script:add']"
                        v-show="!form.scriptId" :disabled="!isValidate">新
                        增</el-button>
                    <el-button @click="cancel">取 消</el-button>
                </div>
            </el-dialog>
        </el-card>
        <!-- 产品列表 -->
        <productList ref="productList" @productEvent="getSelectProduct($event)"></productList>
    </div>
</template>

<script>
import { listScript, getScript, delScript, addScript, updateScript, validateScript } from '@/api/iot/script';
import AceEditor from '@/views/components/editor/editor.vue';
import productList from './product-list';
export default {
    name: 'Script',
    dicts: ['rule_script_type', 'rule_script_language', 'rule_script_event', 'rule_script_action'],
    components: {
        AceEditor,
        productList,
    },
    data() {
        // 自定义验证规则
        var checkScriptId = (rule, value, callback) => {
            const regex = /^[a-zA-Z]+[0-9]*[a-zA-Z]*$/; // 定义只包含字母和数字，且字母开头的正则表达式
            if (!regex.test(value)) {
                return callback(new Error('脚本标识只能输入字母和数字，且字母开头'));
            } else {
                callback();
            }
        };
        return {
            // 脚本数据验证
            isValidate: false,
            // 脚本数据验证结果
            validateMsg: '',
            // 遮罩层
            loading: true,
            // 选中数组
            scriptIds: [],
            // 非单个禁用
            single: true,
            // 非多个禁用
            multiple: true,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 规则引擎脚本表格数据
            scriptList: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                scriptPurpose: 1, // 只展示数据流(1=数据流，2=触发器，3=执行动作)
                scriptId: null,
                scriptName: null,
                scriptData: null,
                scriptType: null,
                scriptLanguage: null,
                enable: null,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                scriptId: [{ required: true, message: '脚本标识不能为空', trigger: 'blur' }],
                productName: [{ required: true, message: '所属产品不能为空', trigger: 'blur' }],
                scriptName: [{ required: true, message: '脚本名不能为空', trigger: 'blur' }],
                scriptType: [{ required: true, message: '脚本类型不能为空', trigger: 'change' }],
                scriptLanguage: [{ required: true, message: '脚本语言不能为空', trigger: 'change' }],
                scriptEvent: [{ required: true, message: '', trigger: 'change' }],
                scriptAction: [{ required: true, message: '', trigger: 'change' }],
                scriptOrder: [{ required: true, message: '', trigger: 'change' }],
                enable: [{ required: true, message: '状态不能为空', trigger: 'blur' }],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询规则引擎脚本列表 */
        getList() {
            this.loading = true;
            listScript(this.queryParams).then((response) => {
                this.scriptList = response.rows;
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
            this.validateMsg = '';
            this.isValidate = false;
            this.form = {
                id: null,
                applicationName: 'fastbee', // 后端配置和规则/脚本需要一致
                scriptId: null,
                productId: null,
                productName: '',
                scriptName: null,
                scriptType: 'script',
                remark: null,
                scriptLanguage: 'groovy',
                enable: 1,
                scriptPurpose: 1, // 脚本用途(1=数据流，2=触发器，3=执行动作)
                scriptOrder: 1, // 脚本执行顺序，数字越大越先执行
                scriptAction: 1, // 脚本动作(1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储)
                scriptEvent: 1, // 脚本事件(1=设备上报，2=平台下发，3=设备上线，4=设备离线)
                sceneId: 0,
                scriptData: `import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.hutool.core.util.NumberUtil;

// 1. 获取主题和内容(必要)
String topic = msgContext.getTopic();
String payload = msgContext.getPayload();


// 2. 数据转换(自己处理)
println ("根据情况转换数据")
String NewTopic = topic;
String NewPayload = payload;


// 3. 返回新的数据（必要）
msgContext.setTopic(NewTopic);
msgContext.setPayload(NewPayload);`,
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
            this.scriptIds = selection.map((item) => item.scriptId);
            this.single = selection.length !== 1;
            this.multiple = !selection.length;
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = '编辑规则脚本';
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const scriptId = row.scriptId || this.scriptIds;
            getScript(scriptId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = '修改规则引擎脚本';
            });
        },
        /**选择产品 */
        handleSelectProduct(data) {
            // 刷新子组建
            this.$refs.productList.queryParams.pageNum = 1;
            this.$refs.productList.open = true;
            this.$refs.productList.selectProductId = this.form.productId;
            this.$refs.productList.getList();
        },
        getSelectProduct(data) {
            this.form.productId = data.productId;
            this.form.productName = data.productName;
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.scriptId != null) {
                        updateScript(this.form).then((response) => {
                            this.$modal.msgSuccess('修改成功');
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addScript(this.form).then((response) => {
                            this.$modal.msgSuccess('新增成功');
                            this.open = false;
                            this.getList();
                        });
                    }
                }
            });
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const scriptIds = row.scriptId || this.scriptIds;
            this.$modal
                .confirm('是否确认删除规则引擎脚本编号为"' + scriptIds + '"的数据项？')
                .then(function () {
                    return delScript(scriptIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess('删除成功');
                })
                .catch(() => { });
        },
        /** 验证按钮操作 */
        handleValidate() {
            this.validateMsg = '';
            this.isValidate = false;
            validateScript(this.form).then((response) => {
                this.isValidate = response.data;
                this.validateMsg = response.msg;
            });
        },
        /** 编辑器单机事件 */
        editClick() {
            this.validateMsg = '';
            this.isValidate = false;
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                'iot/script/export',
                {
                    ...this.queryParams,
                },
                `script_${new Date().getTime()}.xlsx`
            );
        },
    },
};
</script>
