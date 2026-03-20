<template>
    <div style="padding: 6px">
        <el-card v-show="showSearch" style="margin-bottom: 6px">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px" style="margin-bottom: -20px">
                <el-form-item :label="$t('script.349087-0')" prop="scriptId">
                    <el-input v-model="queryParams.scriptId" :placeholder="$t('script.349087-1')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('script.349087-2')" prop="scriptName">
                    <el-input v-model="queryParams.scriptName" :placeholder="$t('script.349087-3')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
                <el-form-item style="float: right">
                    <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:script:add']">{{ $t('add') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <el-card style="padding-bottom: 100px">
            <el-table v-loading="loading" :data="scriptList" @selection-change="handleSelectionChange">
                <el-table-column :label="$t('script.index.470901-0')" align="center" prop="scriptName" />
                <el-table-column :label="$t('script.index.470901-2')" align="center" prop="productName" />
                <el-table-column :label="$t('script.349087-0')" align="center" prop="scriptId" width="180" />
                <el-table-column :label="$t('script.349087-6')" align="center" prop="status">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.rule_script_event" :value="scope.row.scriptEvent" size="small" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('script.index.470901-5')" align="center" prop="status">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.rule_script_action" :value="scope.row.scriptAction" size="small" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('script.index.470901-7')" align="center" prop="scriptLanguage" />
                <el-table-column :label="$t('script.index.470901-8')" align="center" prop="enable" width="120">
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.enable == 1" type="success" size="small">{{ $t('script.index.470901-11') }}</el-tag>
                        <el-tag v-if="scope.row.enable == 0" type="danger" size="small">{{ $t('script.index.470901-12') }}</el-tag>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('script.index.470901-9')" align="center" prop="scriptOrder" />
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width" width="200">
                    <template slot-scope="scope">
                        <el-button size="small" type="text" icon="el-icon-date" @click="handleLog(scope.row.scriptId)" v-hasPermi="['iot:script:query']">{{ $t('script.index.470901-23') }}</el-button>
                        <el-button size="mini" type="text" icon="el-icon-view" @click="handleUpdate(scope.row)" v-hasPermi="['iot:script:query']">{{ $t('script.index.470901-24') }}</el-button>
                        <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:script:remove']">{{ $t('del') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

            <!-- 添加或修改规则引擎脚本对话框 -->
            <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body :close-on-click-modal="false" :close-on-press-escape="false">
                <el-form ref="form" :model="form" :rules="rules" label-width="90px">
                    <el-row :gutter="50">
                        <el-col :span="12">
                            <el-form-item :label="$t('script.index.470901-0')" prop="scriptName">
                                <el-input v-model="form.scriptName" :placeholder="$t('script.349087-3')" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('script.index.470901-9')" prop="scriptOrder">
                                <el-input-number v-model="form.scriptOrder" :placeholder="$t('script.index.470901-10')" type="number" controls-position="right" style="width: 100%" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('script.349087-6')" prop="scriptEvent">
                                <el-select v-model="form.scriptEvent" :placeholder="$t('script.349087-11')" style="width: 100%">
                                    <el-option
                                        v-for="dict in dict.type.rule_script_event"
                                        :key="dict.label"
                                        :label="dict.label"
                                        :value="Number(dict.value)"
                                        :disabled="dict.value !== '1' && dict.value !== '2'"
                                    ></el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>

                        <el-col :span="12">
                            <el-form-item :label="$t('script.index.470901-5')" prop="scriptAction">
                                <el-select v-model="form.scriptAction" :placeholder="$t('script.index.470901-6')" style="width: 100%">
                                    <el-option v-for="dict in dict.type.rule_script_action" :key="dict.label" :label="dict.label" :value="Number(dict.value)" :disabled="dict.value !== '1'"></el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('script.349087-13')" prop="enable">
                                <el-switch v-model="form.enable" :active-value="1" :inactive-value="0" disabled />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('script.index.470901-2')" prop="productName">
                                <el-input readonly v-model="form.productName" size="small" :placeholder="$t('script.index.470901-3')" style="margin-top: 3px">
                                    <el-button slot="append" @click="handleSelectProduct()" size="small">{{ $t('script.index.470901-4') }}</el-button>
                                </el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" style="float: right"></el-col>
                    </el-row>
                </el-form>
                <div style="padding: 0px 10px" @click="editClick">
                    <AceEditor ref="codeEditor" :content.sync="form.scriptData" lang="groovy" codeStyle="chrome" :read-only="false" width="100%" height="450px"></AceEditor>
                </div>
                <div style="padding: 0 10px; margin: 10px 0">
                    <el-alert :title="validateMsg" type="success" show-icon v-if="isValidate && validateMsg" :closable="false"></el-alert>
                    <el-alert :title="validateMsg" type="error" show-icon v-if="!isValidate && validateMsg" :closable="false"></el-alert>
                </div>
                <div slot="footer" class="dialog-footer">
                    <span style="float: left">
                        <el-link style="line-height: 40px; padding-left: 20px" icon="el-icon-question" :underline="false" type="primary" href="https://fastbee.cn/doc/pages/rule_engine/" target="_blank">
                            {{ $t('script.index.470901-17') }}
                        </el-link>
                    </span>
                    <el-button type="success" @click="handleValidate">{{ $t('script.index.470901-18') }}</el-button>
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:script:edit']" v-show="form.scriptId" :disabled="!isValidate">{{ $t('script.index.470901-19') }}</el-button>
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:script:add']" v-show="!form.scriptId" :disabled="!isValidate">{{ $t('add') }}</el-button>
                    <el-button @click="cancel">{{ $t('script.index.470901-20') }}</el-button>
                </div>
            </el-dialog>
        </el-card>

        <el-dialog :title="title" :visible.sync="openLog" width="700px" append-to-body :close-on-click-modal="false" :close-on-press-escape="false">
            <div
                ref="logContainer"
                v-loading="logLoading"
                :element-loading-text="$t('script.index.470901-13')"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(0, 0, 0, 0.8)"
                style="border: 1px solid #ccc; border-radius: 4px; height: 450px; background-color: #181818; color: #fff; padding: 10px; line-height: 20px; overflow: auto"
            >
                <pre>
                    {{ logs }}
                    </pre
                >
            </div>
            <div slot="footer" class="dialog-footer">
                <el-button @click="cancelLog">{{ $t('script.index.470901-21') }}</el-button>
            </div>
        </el-dialog>

        <!-- 产品列表 -->
        <productList ref="productList" @productEvent="getSelectProduct($event)"></productList>
    </div>
</template>

<script>
import { listScript, getScript, getScriptLog, delScript, addScript, updateScript, validateScript } from '@/api/iot/script';
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
                return callback(new Error(this.$i18n.t('script.index.470901-22')));
            } else {
                callback();
            }
        };
        return {
            // 日志
            logs: '',
            // 日志遮罩层
            logLoading: true,
            // 是否显示日志弹窗
            openLog: false,
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
                scriptId: [{ required: true, message: this.$i18n.t('script.index.470901-29'), trigger: 'blur' }],
                productName: [{ required: true, message: this.$i18n.t('script.index.470901-30'), trigger: 'blur' }],
                scriptName: [{ required: true, message: this.$i18n.t('script.index.470901-31'), trigger: 'blur' }],
                scriptType: [{ required: true, message: '', trigger: 'change' }],
                scriptLanguage: [{ required: true, message: '', trigger: 'change' }],
                scriptEvent: [{ required: true, message: '', trigger: 'change' }],
                scriptAction: [{ required: true, message: '', trigger: 'change' }],
                scriptOrder: [{ required: true, message: '', trigger: 'change' }],
                enable: [{ required: true, message: '', trigger: 'blur' }],
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
        // 取消日志按钮
        cancelLog() {
            this.logs = '';
            this.openLog = false;
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
msgContext.logger.debug("数据转换处理")
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
            this.title = this.$i18n.t('script.index.470901-14');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const scriptId = row.scriptId || this.scriptIds;
            getScript(scriptId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$i18n.t('script.index.470901-15');
            });
        },
        /** 日志按钮操作 */
        handleLog(scriptId) {
            this.logLoading = true;
            getScriptLog(scriptId).then((response) => {
                this.logs = response.msg;
                this.form.scriptId = scriptId;
                this.openLog = true;
                this.title = this.$i18n.t('script.index.470901-16');
                this.logLoading = false;
                // 滑动到底部
                this.$nextTick(function () {
                    let messageContent = this.$refs.logContainer;
                    messageContent.scroll({
                        top: messageContent.scrollHeight,
                    });
                });
            });
        },
        /** 日志刷新操作 */
        refreshLog() {
            this.handleLog(this.form.scriptId);
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
                            this.$modal.msgSuccess(this.$i18n.t('script.index.470901-26'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addScript(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$i18n.t('script.index.470901-25'));
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
                .confirm(this.$i18n.t('script.index.470901-28', [scriptIds]))
                .then(function () {
                    return delScript(scriptIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$i18n.t('script.index.470901-27'));
                })
                .catch(() => {});
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
