<template>
    <div class="templete-wrap">
        <el-card shadow="never" v-show="showSearch" style="margin-bottom: 10px">
            <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom: -20px">
                <el-form-item :label="$t('template.index.891112-22')" prop="templateName">
                    <el-input v-model="queryParams.templateName" :placeholder="$t('template.index.891112-1')" clearable size="small" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('template.index.891112-2')" prop="type">
                    <el-select v-model="queryParams.type" :placeholder="$t('template.index.891112-3')" clearable size="small">
                        <el-option v-for="dict in dict.type.iot_things_type" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <el-form-item style="float: right">
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <el-card shadow="never" style="padding-bottom: 100px">
            <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['iot:template:add']" style="margin-bottom: 10px">{{ $t('add') }}</el-button>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            <el-table v-loading="loading" :data="templateList" @selection-change="handleSelectionChange" :border="false">
                <el-table-column :label="$t('template.index.891112-22')" align="center" prop="templateName" />
                <el-table-column :label="$t('template.index.891112-7')" align="center" prop="identifier" />
                <el-table-column :label="$t('template.index.891112-8')" align="center" prop="isMonitor" width="75">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isChart" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('template.index.891112-10')" align="center" prop="" width="75">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isReadonly" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('template.index.891112-11')" align="center" prop="" width="75">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isHistory" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('template.index.891112-12')" align="center" prop="isSys" width="80">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isSys" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('template.index.891112-13')" align="center" prop="type" width="100">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_things_type" :value="scope.row.type" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('template.index.891112-14')" align="center" prop="datatype" width="80">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_data_type" :value="scope.row.datatype" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('template.index.891112-15')" align="left" header-align="center" prop="specs" min-width="150" class-name="specsColor">
                    <template slot-scope="scope">
                        <div v-html="formatSpecsDisplay(scope.row.specs)"></div>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('template.index.891112-16')" align="center" prop="modelOrder" width="80" />
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width" width="150">
                    <template slot-scope="scope">
                        <el-button size="small" type="text" style="padding: 5px" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:template:query']" v-if="scope.row.isSys == '0' ? true : !isTenant">
                            {{ $t('edit') }}
                        </el-button>
                        <el-button
                            size="small"
                            type="text"
                            style="padding: 5px"
                            icon="el-icon-delete"
                            @click="handleDelete(scope.row)"
                            v-hasPermi="['iot:template:remove']"
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

            <!-- 添加或修改通用物模型对话框 -->
            <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body :close-on-click-modal="false">
                <el-form ref="form" :model="form" :rules="rules" label-width="100px">
                    <el-form-item :label="$t('template.index.891112-22')" prop="templateName">
                        <el-input v-model="form.templateName" :placeholder="$t('template.index.891112-23')" style="width: 385px" />
                    </el-form-item>
                    <el-form-item :label="$t('template.index.891112-24')" prop="identifier">
                        <el-input v-model="form.identifier" :placeholder="$t('template.index.891112-25')" style="width: 385px" />
                    </el-form-item>
                    <el-form-item :label="$t('template.index.891112-26')" prop="modelOrder">
                        <el-input-number controls-position="right" v-model="form.modelOrder" :placeholder="$t('template.index.891112-27')" style="width: 386px" />
                    </el-form-item>
                    <el-form-item :label="$t('template.index.891112-28')" prop="type">
                        <el-radio-group v-model="form.type" @change="typeChange(form.type)">
                            <el-radio-button :label="'1'">{{ $t('template.index.891112-29') }}</el-radio-button>
                            <el-radio-button :label="'2'">{{ $t('template.index.891112-30') }}</el-radio-button>
                            <el-radio-button :label="'3'">{{ $t('template.index.891112-31') }}</el-radio-button>
                        </el-radio-group>
                    </el-form-item>

                    <el-form-item :label="$t('template.index.891112-32')" prop="property">
                        <el-row>
                            <el-col :span="6">
                                <el-tooltip effect="dark" :content="$t('template.index.891112-33')" placement="top">
                                    <el-checkbox
                                        name="isChart"
                                        :label="$t('template.index.891112-8')"
                                        @change="isChartChange"
                                        v-show="form.type == 1"
                                        v-model="form.isChart"
                                        :true-label="1"
                                        :false-label="0"
                                    ></el-checkbox>
                                </el-tooltip>
                            </el-col>
                            <el-col :span="6">
                                <el-tooltip effect="dark" :content="$t('template.index.891112-34')" placement="top">
                                    <el-checkbox
                                        name="isMonitor"
                                        :label="$t('template.index.891112-9')"
                                        @change="isMonitorChange"
                                        v-show="form.type == 1"
                                        v-model="form.isMonitor"
                                        :true-label="1"
                                        :false-label="0"
                                    ></el-checkbox>
                                </el-tooltip>
                            </el-col>
                            <el-col :span="6">
                                <el-tooltip effect="dark" :content="$t('template.index.891112-35')" placement="top">
                                    <el-checkbox
                                        name="isReadonly"
                                        :label="$t('template.index.891112-36')"
                                        @change="isReadonlyChange"
                                        :disabled="form.type == 3"
                                        v-model="form.isReadonly"
                                        :true-label="1"
                                        :false-label="0"
                                    ></el-checkbox>
                                </el-tooltip>
                            </el-col>
                            <el-col :span="6">
                                <el-tooltip effect="dark" :content="$t('template.index.891112-37')" placement="top">
                                    <el-checkbox name="isHistory" :label="$t('template.index.891112-11')" v-model="form.isHistory" :true-label="1" :false-label="0"></el-checkbox>
                                </el-tooltip>
                            </el-col>
                            <el-col :span="6">
                                <el-tooltip effect="dark" :content="$t('template.index.891112-38')" placement="top">
                                    <el-checkbox name="isSharePerm" :label="$t('template.index.891112-39')" v-model="form.isSharePerm" :true-label="1" :false-label="0"></el-checkbox>
                                </el-tooltip>
                            </el-col>
                        </el-row>
                    </el-form-item>

                    <el-divider></el-divider>
                    <el-form-item :label="$t('template.index.891112-14')" prop="datatype">
                        <el-select v-model="form.datatype" :placeholder="$t('template.index.891112-40')" @change="dataTypeChange" style="width: 175px">
                            <el-option key="integer" :label="$t('template.index.891112-41')" value="integer"></el-option>
                            <el-option key="decimal" :label="$t('template.index.891112-42')" value="decimal"></el-option>
                            <el-option key="bool" :label="$t('template.index.891112-43')" value="bool" :disabled="form.isChart == 1"></el-option>
                            <el-option key="enum" :label="$t('template.index.891112-44')" value="enum" :disabled="form.isChart == 1"></el-option>
                            <el-option key="string" :label="$t('template.index.891112-45')" value="string" :disabled="form.isChart == 1"></el-option>
                            <el-option key="array" :label="$t('template.index.891112-46')" value="array" :disabled="form.isChart == 1"></el-option>
                            <el-option key="object" :label="$t('template.index.891112-47')" value="object" :disabled="form.isChart == 1"></el-option>
                        </el-select>
                    </el-form-item>
                    <div>
                        <el-form-item :label="$t('template.index.891112-48')" v-if="form.datatype == 'integer'">
                            <el-row>
                                <el-col :span="9">
                                    <el-input v-model="form.specs.min" :placeholder="$t('template.index.891112-49')" controls-position="right" type="number" style="width: 174px" @input="handleEdit" />
                                </el-col>
                                <el-col :span="2" align="center">{{ $t('template.index.891112-50') }}</el-col>
                                <el-col :span="9">
                                    <el-input v-model="form.specs.max" :placeholder="$t('template.index.891112-51')" type="number" controls-position="right" style="width: 174px" @input="handleEditmax" />
                                </el-col>
                            </el-row>
                        </el-form-item>
                        <el-form-item :label="$t('template.index.891112-48')" v-if="form.datatype == 'decimal'">
                            <el-row>
                                <el-col :span="9">
                                    <el-input v-model="form.specs.min" :placeholder="$t('template.index.891112-49')" controls-position="right" type="number" style="width: 174px" />
                                </el-col>
                                <el-col :span="2" align="center">{{ $t('template.index.891112-50') }}</el-col>
                                <el-col :span="9">
                                    <el-input v-model="form.specs.max" :placeholder="$t('template.index.891112-51')" type="number" controls-position="right" style="width: 174px" />
                                </el-col>
                            </el-row>
                        </el-form-item>
                        <el-form-item :label="$t('template.index.891112-52')" prop="unit" v-if="form.datatype == 'integer' || form.datatype == 'decimal'">
                            <el-input v-model="form.specs.unit" :placeholder="$t('template.index.891112-53')" style="width: 385px" />
                        </el-form-item>
                        <el-form-item :label="$t('template.index.891112-54')" prop="step" v-if="form.datatype == 'integer' || form.datatype == 'decimal'">
                            <el-input controls-position="right" v-model="form.specs.step" :placeholder="$t('template.index.891112-55')" type="number" style="width: 386px" />
                        </el-form-item>
                    </div>
                    <div v-if="form.datatype == 'bool'">
                        <el-form-item :label="$t('template.index.891112-56')" prop="">
                            <el-row style="margin-bottom: 10px">
                                <el-col :span="9">
                                    <el-input v-model="form.specs.falseText" :placeholder="$t('template.index.891112-57')" />
                                </el-col>
                                <el-col :span="10" :offset="1">{{ $t('template.index.891112-58') }}</el-col>
                            </el-row>
                            <el-row>
                                <el-col :span="9">
                                    <el-input v-model="form.specs.trueText" :placeholder="$t('template.index.891112-59')" />
                                </el-col>
                                <el-col :span="10" :offset="1">{{ $t('template.index.891112-60') }}</el-col>
                            </el-row>
                        </el-form-item>
                    </div>
                    <div v-if="form.datatype == 'enum'">
                        <el-form-item :label="$t('template.index.891112-61')">
                            <el-select v-model="form.specs.showWay" :placeholder="$t('template.index.891112-62')" style="width: 175px">
                                <el-option key="select" :label="$t('template.index.891112-63')" value="select"></el-option>
                                <el-option key="button" :label="$t('template.index.891112-64')" value="button"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item :label="$t('template.index.891112-65')" prop="">
                            <el-row v-for="(item, index) in form.specs.enumList" :key="'enum' + index" style="margin-bottom: 10px">
                                <el-col :span="9">
                                    <el-input v-model="item.value" :placeholder="$t('template.index.891112-66')" />
                                </el-col>
                                <el-col :span="11" :offset="1">
                                    <el-input v-model="item.text" :placeholder="$t('template.index.891112-67')" />
                                </el-col>
                                <el-col :span="2" :offset="1" v-if="index != 0">
                                    <a style="color: #f56c6c" @click="removeEnumItem(index)">{{ $t('del') }}</a>
                                </el-col>
                            </el-row>
                            <div>
                                +
                                <a style="color: #409eff" @click="addEnumItem()">{{ $t('template.index.891112-68') }}</a>
                            </div>
                        </el-form-item>
                    </div>
                    <div v-if="form.datatype == 'string'">
                        <el-form-item :label="$t('template.index.891112-69')" prop="">
                            <el-row>
                                <el-col :span="9">
                                    <el-input v-model="form.specs.maxLength" :placeholder="$t('template.index.891112-70')" type="number" />
                                </el-col>
                                <el-col :span="14" :offset="1">{{ $t('template.index.891112-71') }}</el-col>
                            </el-row>
                        </el-form-item>
                    </div>
                    <div v-if="form.datatype == 'array'">
                        <el-form-item :label="$t('template.index.891112-72')" prop="">
                            <el-row>
                                <el-col :span="9">
                                    <el-input v-model="form.specs.arrayCount" :placeholder="$t('template.index.891112-73')" type="number" />
                                </el-col>
                            </el-row>
                        </el-form-item>
                        <el-form-item :label="$t('template.index.891112-74')" prop="">
                            <el-radio-group v-model="form.specs.arrayType">
                                <el-radio label="integer">{{ $t('template.index.891112-41') }}</el-radio>
                                <el-radio label="decimal">{{ $t('template.index.891112-42') }}</el-radio>
                                <el-radio label="string">{{ $t('template.index.891112-45') }}</el-radio>
                                <el-radio label="object">{{ $t('template.index.891112-47') }}</el-radio>
                            </el-radio-group>
                        </el-form-item>
                        <el-form-item :label="$t('template.index.891112-75')" v-if="form.specs.arrayType == 'object'">
                            <div style="background-color: #f8f8f8; border-radius: 5px">
                                <el-row style="padding: 0 10px 5px" v-for="(item, index) in form.specs.params" :key="index">
                                    <div style="margin-top: 5px" v-if="index == 0"></div>
                                    <el-col :span="18">
                                        <el-input readonly v-model="item.name" size="small" :placeholder="$t('template.index.891112-76')" style="margin-top: 3px">
                                            <template slot="prepend">
                                                <el-tag size="small" effect="dark" style="margin-left: -21px; height: 26px; line-height: 26px">{{ item.order }}</el-tag>
                                                {{ form.identifier + '_' + item.id }}
                                            </template>
                                            <el-button slot="append" @click="editParameter(item, index)" size="small">{{ $t('edit') }}</el-button>
                                        </el-input>
                                    </el-col>
                                    <el-col :span="2" :offset="2">
                                        <el-button size="small" plain type="danger" style="padding: 5px" icon="el-icon-delete" @click="removeParameter(index)">{{ $t('del') }}</el-button>
                                    </el-col>
                                </el-row>
                            </div>
                            <div>
                                +
                                <a style="color: #409eff" @click="addParameter()">{{ $t('template.index.891112-78') }}</a>
                            </div>
                        </el-form-item>
                    </div>
                    <div v-if="form.datatype == 'object'">
                        <el-form-item :label="$t('template.index.891112-75')" prop="">
                            <div style="background-color: #f8f8f8; border-radius: 5px">
                                <el-row style="padding: 0 10px 5px" v-for="(item, index) in form.specs.params" :key="index">
                                    <div style="margin-top: 5px" v-if="index == 0"></div>
                                    <el-col :span="18">
                                        <el-input readonly v-model="item.name" size="small" :placeholder="$t('template.index.891112-76')" style="margin-top: 3px">
                                            <template slot="prepend">
                                                <el-tag size="small" effect="dark" style="margin-left: -21px; height: 26px; line-height: 26px">{{ item.order }}</el-tag>
                                                {{ form.identifier + '_' + item.id }}
                                            </template>
                                            <el-button slot="append" @click="editParameter(item, index)">{{ $t('edit') }}</el-button>
                                        </el-input>
                                    </el-col>
                                    <el-col :span="2" :offset="2">
                                        <el-button size="small" plain type="danger" style="padding: 5px" icon="el-icon-delete" @click="removeParameter(index)">{{ $t('del') }}</el-button>
                                    </el-col>
                                </el-row>
                            </div>
                            <div>
                                +
                                <a style="color: #409eff" @click="addParameter()">{{ $t('template.index.891112-78') }}</a>
                            </div>
                        </el-form-item>
                    </div>
                </el-form>

                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:template:edit']" v-show="form.templateId">{{ $t('edit') }}</el-button>
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:template:add']" v-show="!form.templateId">{{ $t('add') }}</el-button>
                    <el-button @click="cancel">{{ $t('cancel') }}</el-button>
                </div>
            </el-dialog>

            <!--物模型参数类型-->
            <things-parameter :data="paramData" @dataEvent="getParamData($event)" />
        </el-card>
    </div>
</template>

<style>
.specsColor {
    background-color: #fcfcfc;
}
</style>

<script>
import { listTemplate, getTemplate, delTemplate, addTemplate, updateTemplate } from '@/api/iot/template';
import thingsParameter from './parameter';
export default {
    name: 'Template',
    dicts: ['iot_things_type', 'iot_data_type', 'iot_yes_no'],
    components: {
        thingsParameter,
    },
    data() {
        return {
            // 是否为租户
            isTenant: false,
            // 遮罩层
            loading: true,
            // 选中数组
            ids: [],
            //是否为小数的判断
            isDecimal: '',
            isDecimalMax: '',
            // 非单个禁用
            single: true,
            // 非多个禁用
            multiple: true,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 通用物模型表格数据
            templateList: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                templateName: null,
                type: null,
            },
            // 表单参数
            form: {},
            // 对象类型参数
            paramData: {
                index: -1,
                parameter: {},
            },
            // 表单校验
            rules: {
                templateName: [
                    {
                        required: true,
                        message: this.$i18n.t('template.index.891112-84'),
                        trigger: 'blur',
                    },
                    {
                        min: 1,
                        max: 64,
                        message: this.$i18n.t('template.index.891112-84'),
                        trigger: 'blur',
                    },
                ],
                identifier: [
                    {
                        required: true,
                        message: this.$i18n.t('template.index.891112-85'),
                        trigger: 'blur',
                    },
                    {
                        min: 1,
                        max: 32,
                        message: this.$i18n.t('template.index.891112-85'),
                        trigger: 'blur',
                    },
                ],
                modelOrder: [
                    {
                        required: true,
                        message: this.$i18n.t('template.index.891112-86'),
                        trigger: 'blur',
                    },
                    {
                        type: 'number',
                        min: -2147483648,
                        max: 2147483647,
                        message: '',
                        trigger: 'blur',
                    },
                ],
                type: [
                    {
                        required: true,
                        message: this.$i18n.t('template.index.891112-87'),
                        trigger: 'change',
                    },
                ],
                datatype: [
                    {
                        required: true,
                        message: this.$i18n.t('template.index.891112-88'),
                        trigger: 'change',
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
        /** 查询通用物模型列表 */
        getList() {
            this.loading = true;
            listTemplate(this.queryParams).then((response) => {
                this.templateList = response.rows;
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
                templateId: null,
                templateName: null,
                userId: null,
                userName: null,
                tenantId: null,
                tenantName: null,
                identifier: null,
                modelOrder: 0,
                type: 1,
                datatype: 'integer',
                isSys: null,
                isChart: 1,
                isHistory: 1,
                isMonitor: 1,
                isReadonly: 1,
                isSharePerm: 1,
                delFlag: null,
                createBy: null,
                createTime: null,
                updateBy: null,
                updateTime: null,
                remark: null,
                specs: {
                    enumList: [
                        {
                            value: '',
                            text: '',
                        },
                    ],
                    arrayType: 'integer',
                    arrayCount: 5,
                    showWay: 'select', // 显示方式select=下拉选择框，button=按钮
                    params: [],
                },
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
            this.ids = selection.map((item) => item.templateId);
            this.single = selection.length !== 1;
            this.multiple = !selection.length;
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$i18n.t('template.index.891112-89');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const templateId = row.templateId || this.ids;
            getTemplate(templateId).then((response) => {
                let tempForm = response.data;
                this.open = true;
                this.title = this.$i18n.t('template.index.891112-90');
                // Json转对象
                tempForm.specs = JSON.parse(tempForm.specs);
                if (!tempForm.specs.enumList) {
                    tempForm.specs.showWay = 'select';
                    tempForm.specs.enumList = [
                        {
                            value: '',
                            text: '',
                        },
                    ];
                }
                if (!tempForm.specs.arrayType) {
                    tempForm.specs.arrayType = 'integer';
                }
                if (!tempForm.specs.arrayCount) {
                    tempForm.specs.arrayCount = 5;
                }
                if (!tempForm.specs.params) {
                    tempForm.specs.params = [];
                }
                // 对象和数组中参数删除前缀
                if ((tempForm.specs.type == 'array' && tempForm.specs.arrayType == 'object') || tempForm.specs.type == 'object') {
                    for (let i = 0; i < tempForm.specs.params.length; i++) {
                        tempForm.specs.params[i].id = String(tempForm.specs.params[i].id).substring(String(tempForm.identifier).length + 1);
                    }
                }
                this.form = tempForm;
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    // 验证对象或对象数组中的参数不能为空
                    if (this.form.datatype == 'object' || (this.form.datatype == 'array' && this.form.specs.arrayType == 'object')) {
                        if (!this.form.specs.params || this.form.specs.params == 0) {
                            this.$modal.msgError(this.$i18n.t('template.index.891112-91'));
                            return;
                        }
                    }
                    //验证输入的取值范围最大值不能小于最小值
                    if (this.form.datatype == 'integer' || this.form.datatype == 'decimal') {
                        if (parseFloat(this.form.specs.min) > parseFloat(this.form.specs.max)) {
                            this.$modal.msgError(this.$i18n.t('template.index.891112-125'));
                            return;
                        }
                    }
                    if (this.form.datatype == 'decimal') {
                        this.hasDecimalPoint();
                        this.hasDecimalPointMax();
                        if (this.isDecimal === false || this.isDecimalMax === false) {
                            this.$modal.msgError(this.$i18n.t('template.index.891112-126'));
                            return;
                        }
                    }
                    // 验证对象参数标识符不能相同
                    if (this.form.specs.params && this.form.specs.params.length > 0) {
                        let arr = this.form.specs.params.map((item) => item.id).sort();
                        for (let i = 0; i < arr.length; i++) {
                            if (arr[i] == arr[i + 1]) {
                                this.$modal.msgError(this.$i18n.t('template.index.891112-127', [arr[i]]));
                                return;
                            }
                        }
                    }
                    //验证模型特性为图表展示时，数据类型是否为整数或者小数
                    if (this.form.isChart == 1 && this.form.datatype != 'integer' && this.form.isChart == 1 && this.form.datatype != 'decimal') {
                        this.$modal.msgError(this.$i18n.t('template.index.891112-95'));
                    } else if (this.form.templateId != null) {
                        // 格式化specs
                        let tempForm = JSON.parse(JSON.stringify(this.form));
                        tempForm.specs = this.formatThingsSpecs();
                        if (this.form.type == 2) {
                            tempForm.isMonitor = 0;
                            tempForm.isChart = 0;
                        } else if (this.form.type == 3) {
                            tempForm.isMonitor = 0;
                            tempForm.isChart = 0;
                        }
                        // 添加通用物模型的修改者
                        tempForm.updateBy = this.$store.state.user.name;
                        updateTemplate(tempForm).then((response) => {
                            this.$modal.msgSuccess(this.$i18n.t('template.index.891112-128'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        // 格式化specs
                        let tempForm = JSON.parse(JSON.stringify(this.form));
                        tempForm.specs = this.formatThingsSpecs();
                        if (this.form.type == 2) {
                            tempForm.isMonitor = 0;
                        } else if (this.form.type == 3) {
                            tempForm.isMonitor = 0;
                            tempForm.isChart = 0;
                        }
                        // 添加通用物模型的创造者
                        tempForm.createBy = this.$store.state.user.name;
                        addTemplate(tempForm).then((response) => {
                            this.$modal.msgSuccess(this.$i18n.t('template.index.891112-129'));
                            this.open = false;
                            this.getList();
                        });
                    }
                }
            });
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const templateIds = row.templateId || this.ids;
            this.$modal
                .confirm(this.$i18n.t('template.index.891112-98', [templateIds]))
                .then(function () {
                    return delTemplate(templateIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$i18n.t('template.index.891112-130'));
                })
                .catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                'iot/template/export',
                {
                    ...this.queryParams,
                },
                `template_${new Date().getTime()}.xlsx`
            );
        },
        // 类型改变
        typeChange(type) {
            if (type == 1) {
                this.form.isChart = 1;
                this.form.isHistory = 1;
                this.form.isMonitor = 1;
                this.form.isReadonly = 1;
                this.form.isSharePerm = 1;
                this.form.datatype = 'integer';
            } else if (type == 2) {
                this.form.isChart = 0;
                this.form.isHistory = 1;
                this.form.isSharePerm = 1;
                this.form.isMonitor = 0;
                this.form.isReadonly = 0;
            } else if (type == 3) {
                this.form.isChart = 0;
                this.form.isHistory = 1;
                this.form.isMonitor = 0;
                this.form.isReadonly = 1;
                this.form.isSharePerm = 0;
            }
        },
        // 是否图表展示改变
        isChartChange() {
            if (this.form.isChart == 1) {
                this.form.isReadonly = 1;
            } else {
                this.form.isMonitor = 0;
            }
        },
        // 是否实时监测改变
        isMonitorChange() {
            if (this.form.isMonitor == 1) {
                this.form.isReadonly = 1;
                this.form.isChart = 1;
            }
        },
        // 是否只读数据改变
        isReadonlyChange() {
            if (this.form.isReadonly == 0) {
                this.form.isMonitor = 0;
                this.form.isChart = 0;
            }
        },
        // 格式化物模型
        formatThingsSpecs() {
            var data = {};
            data.type = this.form.datatype;
            if (this.form.datatype == 'integer' || this.form.datatype == 'decimal') {
                data.min = Number(this.form.specs.min ? this.form.specs.min : 0);
                data.max = Number(this.form.specs.max ? this.form.specs.max : 100);
                data.unit = this.form.specs.unit ? this.form.specs.unit : '';
                data.step = Number(this.form.specs.step ? this.form.specs.step : 1);
            } else if (this.form.datatype == 'string') {
                data.maxLength = Number(this.form.specs.maxLength ? this.form.specs.maxLength : 1024);
            } else if (this.form.datatype == 'bool') {
                data.falseText = this.form.specs.falseText ? this.form.specs.falseText : this.$t('template.paramter.038405-57');
                data.trueText = this.form.specs.trueText ? this.form.specs.trueText : this.$t('template.paramter.038405-58');
            } else if (this.form.datatype == 'enum') {
                data.showWay = this.form.specs.showWay;
                if (this.form.specs.enumList && this.form.specs.enumList[0].text != '') {
                    data.enumList = this.form.specs.enumList;
                } else {
                    data.showWay = 'select';
                    data.enumList = [
                        {
                            value: '0',
                            text: this.$t('template.paramter.038405-59'),
                        },
                        {
                            value: '1',
                            text: this.$t('template.paramter.038405-60'),
                        },
                    ];
                }
            } else if (this.form.datatype == 'array') {
                data.arrayType = this.form.specs.arrayType;
                data.arrayCount = this.form.specs.arrayCount ? this.form.specs.arrayCount : 5;
                if (data.arrayType == 'object') {
                    data.params = this.form.specs.params;
                    // 物模型名称作为参数的标识符前缀
                    for (let i = 0; i < data.params.length; i++) {
                        data.params[i].id = this.form.identifier + '_' + data.params[i].id;
                    }
                }
            } else if (this.form.datatype == 'object') {
                data.params = this.form.specs.params;
                // 物模型名称作为参数的标识符前缀
                for (let i = 0; i < data.params.length; i++) {
                    data.params[i].id = this.form.identifier + '_' + data.params[i].id;
                }
            }
            return JSON.stringify(data);
        },
        /** 数据类型改变 */
        dataTypeChange(val) {
            this.form.specs = {};
        },
        /** 添加枚举项 */
        addEnumItem() {
            this.form.specs.enumList.push({
                value: '',
                text: '',
            });
        },
        /** 删除枚举项 */
        removeEnumItem(index) {
            this.form.specs.enumList.splice(index, 1);
        },
        /** 格式化显示数据定义 */
        formatSpecsDisplay(json) {
            if (json == null || json == undefined) {
                return;
            }
            let specs = JSON.parse(json);
            if (specs.type === 'integer' || specs.type === 'decimal') {
                return (
                    "<span style='width:50%;display:inline-block;\>" +
                    this.$i18n.t('template.index.891112-105') +
                    '<span style="color:#F56C6C">' +
                    specs.max +
                    '</span></span>' +
                    this.$i18n.t('template.index.891112-106') +
                    '<span style="color:#F56C6C">' +
                    specs.min +
                    "</span><br /><span style='width:50%;display:inline-block;\>" +
                    this.$i18n.t('template.index.891112-107') +
                    '<span style="color:#F56C6C">' +
                    specs.step +
                    '</span></span>' +
                    this.$i18n.t('template.index.891112-108') +
                    '<span style="color:#F56C6C">' +
                    specs.unit
                );
            } else if (specs.type === 'string') {
                return this.$i18n.t('template.index.891112-109') + '<span style="color:#F56C6C">' + specs.maxLength + '</span>';
            } else if (specs.type === 'array') {
                return (
                    "<span style='width:50%;display:inline-block;\>" +
                    this.$i18n.t('template.index.891112-110') +
                    '<span style="color:#F56C6C">' +
                    specs.arrayType +
                    '</span></span>' +
                    this.$i18n.t('template.index.891112-111') +
                    '<span style="color:#F56C6C">' +
                    specs.arrayCount
                );
            } else if (specs.type === 'enum') {
                let items = '';
                for (let i = 0; i < specs.enumList.length; i++) {
                    items = items + "<span style='width:50%;display:inline-block;'>" + specs.enumList[i].value + "：<span style='color:#F56C6C'>" + specs.enumList[i].text + '</span></span>';
                    if (i > 0 && i % 2 != 0) {
                        items = items + '<br />';
                    }
                }
                return items;
            } else if (specs.type === 'bool') {
                return '<span style=\'width:50%;display:inline-block;\'>0：<span style="color:#F56C6C">' + specs.falseText + '</span></span>1：<span style="color:#F56C6C">' + specs.trueText;
            } else if (specs.type === 'object') {
                let items = '';
                for (let i = 0; i < specs.params.length; i++) {
                    items = items + "<span style='width:50%;display:inline-block;'>" + specs.params[i].name + "：<span style='color:#F56C6C'>" + specs.params[i].datatype.type + '</span></span>';
                    if (i > 0 && i % 2 != 0) {
                        items = items + '<br />';
                    }
                }
                return items;
            }
        },
        /** 添加参数 */
        addParameter() {
            this.paramData = {
                index: -1,
                parameter: {},
            };
        },
        /** 编辑参数*/
        editParameter(data, index) {
            this.paramData = null;
            this.paramData = {
                index: index,
                parameter: data,
            };
        },
        /** 删除动作 */
        removeParameter(index) {
            this.form.specs.params.splice(index, 1);
        },
        /**获取设置的参数对象*/
        getParamData(data) {
            if (data.index == -1) {
                this.form.specs.params.push(data.parameter);
            } else {
                this.form.specs.params[data.index] = data.parameter;
                // 解决数组在界面中不更新问题
                this.$set(this.form.specs.params, data.index, this.form.specs.params[data.index]);
            }
        },
        // 在输入最小值改变时触发
        handleEdit(e) {
            let value = e.replace(/[^\-\d]/g, ''); // 只能输入-和数字
            value = value.replace(/\-{2,}/g, '-'); // -只能保留一个
            value = value.replace(/(\d)\-/g, '$1'); // 数字后面不能接-，不能出现类似-11-2,12-，11-23
            value = value.replace(/(-)0+/g, '$1'); // 不能出现-0,-001,-0001类似
            value = value.replace(/(-\d{10})\d*/, '$1'); // 最多保留10位整数
            this.form.specs.min = value;
        },
        // 在输入最大值改变时触发
        handleEditmax(e) {
            let value = e.replace(/[^\-\d]/g, ''); // 只能输入-和数字
            value = value.replace(/\-{2,}/g, '-'); // -只能保留一个
            value = value.replace(/(\d)\-/g, '$1'); // 数字后面不能接-，不能出现类似-11-2,12-，11-23
            value = value.replace(/(-)0+/g, '$1'); // 不能出现-0,-001,-0001类似
            value = value.replace(/(-\d{10})\d*/, '$1'); // 最多保留10位整数
            this.form.specs.max = value;
        },
        //数据类型为小数的校验
        hasDecimalPoint() {
            const regex = /^-?\d+\.\d+$/; // 使用正则表达式匹配小数点格式
            this.isDecimal = regex.test(this.form.specs.min);
            return this.isDecimal;
        },
        hasDecimalPointMax() {
            const regex = /^-?\d+\.\d+$/; // 使用正则表达式匹配小数点格式
            this.isDecimalMax = regex.test(this.form.specs.max);
            return this.isDecimalMax;
        },
    },
};
</script>

<style lang="scss" scoped>
.templete-wrap {
    padding: 15px;
    min-height: 100vh;
    background-color: #f5f7fa;
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
</style>
