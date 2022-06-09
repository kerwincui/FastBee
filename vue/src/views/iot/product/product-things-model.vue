<template>
<div style="padding-left:20px;">
    <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
            <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-if="productInfo.status==1">新增</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="success" plain icon="el-icon-upload2" size="mini" @click="handleSelect" v-if="productInfo.status==1">导入通用物模型</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="warning" plain icon="el-icon-refresh" size="mini" @click="getList">刷新</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="info" plain icon="el-icon-view" size="mini" @click="handleOpenThingsModel">查看物模型</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-link type="danger" style="padding-top:5px" :underline="false"> 注意：标识符不能重复</el-link>
        </el-col>
    </el-row>

    <el-table v-loading="loading" :data="modelList" size="mini">
        <el-table-column label="名称" align="center" prop="modelName" />
        <el-table-column label="标识符" align="center" prop="identifier" />
        <el-table-column label="首页显示" align="center" prop="isTop" width="100">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isTop" />
            </template>
        </el-table-column>
        <el-table-column label="实时监测" align="center" prop="isMonitor" width="100">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isMonitor" />
            </template>
        </el-table-column>
        <el-table-column label="物模型类别" align="center" prop="type">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_things_type" :value="scope.row.type" />
            </template>
        </el-table-column>
        <el-table-column label="数据类型" align="center" prop="datatype">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_data_type" :value="scope.row.datatype" />
            </template>
        </el-table-column>
        <el-table-column label="数据定义" align="left" header-align="center" prop="specs" min-width="150" class-name="specsColor">
            <template slot-scope="scope">
                <div v-html="formatSpecsDisplay(scope.row.specs)"></div>
            </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
                <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-if="productInfo.status!=2">修改</el-button>
                <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-if="productInfo.status!=2">删除</el-button>
            </template>
        </el-table-column>
    </el-table>

    <!-- 添加或修改物模型对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
        <el-form ref="form" :model="form" :rules="rules" label-width="100px">
            <el-form-item label="模型名称" prop="modelName">
                <el-input v-model="form.modelName" placeholder="请输入物模型名称，例如：温度" style="width:385px;" />
            </el-form-item>
            <el-form-item label="标识符" prop="identifier">
                <el-input v-model="form.identifier" placeholder="请输入标识符，例如：temperature" style="width:385px;" />
            </el-form-item>
            <el-form-item label="模型类别" prop="type">
                <el-radio-group v-model="form.type" @change="typeChange(form.type)">
                    <el-radio-button label="1">属性</el-radio-button>
                    <el-radio-button label="2">功能</el-radio-button>
                    <el-radio-button label="3">事件</el-radio-button>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="首页显示" prop="isTop" v-show="form.type != 3">
                <el-switch v-model="form.isTop" active-text="" inactive-text="" :active-value="1" :inactive-value="0" active-color="#13ce66">
                </el-switch>
            </el-form-item>
            <el-form-item label="实时监测" prop="isMonitor" v-show="form.type == 1">
                <el-switch v-model="form.isMonitor" active-text="" inactive-text="" :active-value="1" :inactive-value="0" active-color="#13ce66" @change="changeMonitor(form.isMonitor)">
                </el-switch>
            </el-form-item>
            <el-divider></el-divider>
            <el-form-item label="数据类型" prop="datatype">
                <el-select v-model="form.datatype" placeholder="请选择数据类型" @change="dataTypeChange" style="width:175px;">
                    <el-option key="integer" label="整数" value="integer"></el-option>
                    <el-option key="decimal" label="小数" value="decimal"></el-option>
                    <el-option key="bool" label="布尔" value="bool" :disabled="form.isMonitor==1"></el-option>
                    <el-option key="enum" label="枚举" value="enum" :disabled="form.isMonitor==1"></el-option>
                    <el-option key="string" label="字符串" value="string" :disabled="form.isMonitor==1"></el-option>
                    <el-option key="array" label="数组" value="array" :disabled="form.isMonitor==1"></el-option>
                </el-select>
            </el-form-item>

            <div v-if="form.datatype == 'integer' || form.datatype == 'decimal'">
                <el-form-item label="取值范围">
                    <el-row>
                        <el-col :span="9">
                            <el-input v-model="form.specs.min" placeholder="最小值" type="number" />
                        </el-col>
                        <el-col :span="2" align="center">到</el-col>
                        <el-col :span="9">
                            <el-input v-model="form.specs.max" placeholder="最大值" type="number" />
                        </el-col>
                    </el-row>
                </el-form-item>
                <el-form-item label="单位">
                    <el-input v-model="form.specs.unit" placeholder="请输入单位，例如：℃" style="width:385px;" />
                </el-form-item>
                <el-form-item label="步长">
                    <el-input v-model="form.specs.step" placeholder="请输入步长，例如：1" type="number" style="width:385px;" />
                </el-form-item>
            </div>

            <div v-if="form.datatype == 'bool'">
                <el-form-item label="布尔值" prop="">
                    <el-row style="margin-bottom:10px;">
                        <el-col :span="9">
                            <el-input v-model="form.specs.falseText" placeholder="例如：关闭" />
                        </el-col>
                        <el-col :span="10" :offset="1"> （0 值对应文本）</el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="9">
                            <el-input v-model="form.specs.trueText" placeholder="例如：打开" />
                        </el-col>
                        <el-col :span="10" :offset="1"> （1 值对应文本）</el-col>
                    </el-row>
                </el-form-item>
            </div>

            <div v-if="form.datatype == 'enum'">
                <el-form-item label="枚举项" prop="">
                    <el-row v-for="(item,index) in form.specs.enumList" :key="'enum'+index" style="margin-bottom:10px;">
                        <el-col :span="9">
                            <el-input v-model="item.value" placeholder="参数值，例如：0" type="number" />
                        </el-col>
                        <el-col :span="11" :offset="1">
                            <el-input v-model="item.text" placeholder="参数描述，例如：中速档位" />
                        </el-col>
                        <el-col :span="2" :offset="1" v-if="index!=0"><a style="color:#F56C6C" @click="removeEnumItem(index)">删除</a></el-col>
                    </el-row>
                    <div>+ <a style="color:#409EFF" @click="addEnumItem()">添加枚举项</a></div>
                </el-form-item>
            </div>

            <div v-if="form.datatype == 'string'">
                <el-form-item label="最大长度" prop="">
                    <el-row>
                        <el-col :span="9">
                            <el-input v-model="form.specs.maxLength" placeholder="例如：1024" type="number" />
                        </el-col>
                        <el-col :span="14" :offset="1">（字符串的最大长度）</el-col>
                    </el-row>
                </el-form-item>
            </div>

            <div v-if="form.datatype == 'array'">
                <el-form-item label="数组类型" prop="">
                    <el-radio-group v-model="form.specs.arrayType">
                        <el-radio label="int">int（整数）</el-radio>
                        <el-radio label="double">double（小数）</el-radio>
                        <el-radio label="string">string（字符串）</el-radio>
                    </el-radio-group>
                </el-form-item>
            </div>
        </el-form>

        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitForm">确 定</el-button>
            <el-button @click="cancel">取 消</el-button>
        </div>
    </el-dialog>

    <!-- 导入通用物模型对话框 -->
    <el-dialog :title="title" :visible.sync="openSelect" width="800px" append-to-body>
        <product-select-template ref="productSelectTemplate" @idsToParentEvent="getChildData($event)" />
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="importSelect">导 入</el-button>
            <el-button @click="cancelSelect">取 消</el-button>
        </div>
    </el-dialog>

    <!-- 物模型JSON -->
    <el-dialog :title="title" :visible.sync="openThingsModel" width="600px" append-to-body>
        <div style="border:1px solid #ccc;margin-top:-15px;height:600px; overflow:scroll;">
            <json-viewer :value="thingsModel" :expand-depth=10 copyable>
                <template v-slot:copy>
                    复制
                </template>
            </json-viewer>
        </div>
        <div slot="footer" class="dialog-footer">
            <el-button type="info" @click="handleCloseThingsModel">关 闭</el-button>
        </div>
    </el-dialog>
</div>
</template>

<style>
.specsColor {
    background-color: #fcfcfc;
}
</style>

<script>
import productSelectTemplate from "./product-select-template";
import JsonViewer from 'vue-json-viewer'
import 'vue-json-viewer/style.css'
import {
    listModel,
    getModel,
    delModel,
    addModel,
    updateModel,
    importModel
} from "@/api/iot/model";
export default {
    name: "product-things-model",
    dicts: ["iot_things_type", "iot_data_type", "iot_yes_no"],
    components: {
        productSelectTemplate,
        JsonViewer
    },
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
            // 物模型
            thingsModel: {},
            // 父组件接收的产品信息
            productInfo: {},
            // 子组件选中的id数组
            templateIds: [],
            // 遮罩层
            loading: false,
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
            // 产品物模型表格数据
            modelList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            openSelect: false,
            openThingsModel: false,
            // 查询参数
            queryParams: {
                productId: 0,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                modelName: [{
                    required: true,
                    message: "物模型名称不能为空",
                    trigger: "blur"
                }],
                identifier: [{
                    required: true,
                    message: "标识符，产品下唯一不能为空",
                    trigger: "blur",
                }, ],
                type: [{
                    required: true,
                    message: "模型类别不能为空",
                    trigger: "change"
                }, ],
                datatype: [{
                    required: true,
                    message: "数据类型不能为空",
                    trigger: "change"
                }, ],
                specs: [{
                    required: true,
                    message: "数据定义不能为空",
                    trigger: "blur"
                }, ],
            },
        };
    },
    created() {

    },
    methods: {
        /** 查询产品物模型列表 */
        getList() {
            this.loading = true;
            listModel(this.queryParams).then((response) => {
                this.modelList = response.rows;
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
                type: 1,
                datatype: "integer",
                isSys: null,
                isTop: null,
                isMonitor: null,
                delFlag: null,
                createBy: null,
                createTime: null,
                updateBy: null,
                updateTime: null,
                remark: null,
                specs: {
                    enumList: [{
                        value: "",
                        text: ""
                    }],
                    arrayType: "int"
                },
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
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = "添加物模型";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const modelId = row.modelId;;
            getModel(modelId).then((response) => {
                let tempForm = response.data;
                this.open = true;
                this.title = "修改物模型";
                // Json转对象
                tempForm.specs = JSON.parse(tempForm.specs);
                if (!tempForm.specs.enumList) {
                    tempForm.specs.enumList = [{
                        value: "",
                        text: ""
                    }];
                }
                if (!tempForm.specs.arrayType) {
                    tempForm.specs.arrayType = "int";
                }
                this.form = tempForm;
            });
        },
        /**查看物模型 */
        handleOpenThingsModel() {
            this.title = "物模型";
            // 生成物模型
            this.thingsModel = {
                properties: [],
                functions: [],
                events: []
            }
            for (var i = 0; i < this.modelList.length; i++) {
                let thingsItem = {};
                thingsItem.id = this.modelList[i].identifier;
                thingsItem.name = this.modelList[i].modelName;
                if (this.modelList[i].type == 1) {
                    //属性
                    thingsItem.isTop = this.modelList[i].isTop;
                    thingsItem.isMonitor = this.modelList[i].isMonitor;
                    thingsItem.datatype = JSON.parse(this.modelList[i].specs);
                    this.thingsModel.properties.push(thingsItem);
                } else if (this.modelList[i].type == 2) {
                    // 功能
                    thingsItem.isTop = this.modelList[i].isTop;
                    thingsItem.datatype = JSON.parse(this.modelList[i].specs);
                    this.thingsModel.functions.push(thingsItem);
                } else if (this.modelList[i].type == 3) {
                    // 事件
                    thingsItem.datatype = JSON.parse(this.modelList[i].specs);
                    this.thingsModel.events.push(thingsItem);
                }
            }

            this.openThingsModel = true;
        },
        /**关闭物模型 */
        handleCloseThingsModel() {
            this.openThingsModel = false;
        },
        /** 选择物模型 */
        handleSelect() {
            this.openSelect = true;
            this.title = "导入通用物模型";
            this.form.type = 1;
            this.form.datatype = "integer"
            this.form.specs = {
                enumList: [],
            };
        },
        // 取消导入通用物模型按钮
        cancelSelect() {
            this.openSelect = false;
            this.$refs.productSelectTemplate.$refs.selectTemplateTable.clearSelection();
        },
        // 获取子组件的值
        getChildData(data) {
            this.templateIds = data;
        },
        // 导入通用物模型按钮
        importSelect() {
            if (this.templateIds != null && this.templateIds.length > 0) {
                var importData = {
                    productId: this.productInfo.productId,
                    productName: this.productInfo.productName,
                    templateIds: this.templateIds
                }
                importModel(importData).then(response => {
                    this.$modal.msgSuccess(response.msg);
                    this.openSelect = false;
                    this.$refs.productSelectTemplate.$refs.selectTemplateTable.clearSelection();
                    this.getList();
                });
            }

        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate((valid) => {
                if (valid) {
                    if (this.form.modelId != null) {
                        // 格式化specs
                        this.form.specs = this.formatThingsSpecs();
                        if (this.form.type == 2) {
                            this.form.isMonitor = 0;
                        } else if (this.form.type == 3) {
                            this.form.isMonitor = 0;
                            this.form.isTop = 0;
                        }
                        updateModel(this.form).then((response) => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        // 格式化specs
                        this.form.specs = this.formatThingsSpecs();
                        this.form.productId = this.productInfo.productId;
                        this.form.productName = this.productInfo.productName;
                        if (this.form.type == 2) {
                            this.form.isMonitor = 0;
                        } else if (this.form.type == 3) {
                            this.form.isMonitor = 0;
                            this.form.isTop = 0;
                        }
                        addModel(this.form).then((response) => {
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
            const modelIds = row.modelId;
            this.$modal
                .confirm('是否确认删除物模型编号为"' + modelIds + '"的数据项？')
                .then(function () {
                    return delModel(modelIds);
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
                "iot/model/export", {
                    ...this.queryParams,
                },
                `model_${new Date().getTime()}.xlsx`
            );
        },
        // 类型改变
        typeChange(label) {
            if (label == 2 || label == 3) {
                this.form.isMonitor = 0;
            }
        },
        // 实时监测改变
        changeMonitor(isMonitor) {
            if (isMonitor == 1 && this.form.datatype != "integer" && this.form.datatype != "decimal") {
                this.form.datatype = "integer";
            }
        },
        // 格式化物模型
        formatThingsSpecs() {
            var data = {};
            data.type = this.form.datatype;
            if (this.form.datatype == "integer" || this.form.datatype == "decimal") {
                data.min = Number(this.form.specs.min);
                data.max = Number(this.form.specs.max);
                data.unit = this.form.specs.unit;
                data.step = Number(this.form.specs.step);
            } else if (this.form.datatype == "string") {
                data.maxLength = Number(this.form.specs.maxLength);
            } else if (this.form.datatype == "bool") {
                data.falseText = this.form.specs.falseText;
                data.trueText = this.form.specs.trueText;
            } else if (this.form.datatype == "array") {
                data.arrayType = this.form.specs.arrayType;
            } else if (this.form.datatype == "enum") {
                data.enumList = this.form.specs.enumList;
            }
            return JSON.stringify(data);
        },
        /** 切换为枚举项 */
        dataTypeChange(val) {
            // if (val == "enum") {
            //     this.form.specs.enumList = [{
            //         value: "",
            //         text: ""
            //     }];
            // }
        },
        /** 添加枚举项 */
        addEnumItem() {
            this.form.specs.enumList.push({
                value: "",
                text: ""
            });
        },
        /** 删除枚举项 */
        removeEnumItem(index) {
            this.form.specs.enumList.splice(index, 1);
        },
        /** 格式化显示数据定义 */
        formatSpecsDisplay(json) {
            let specs = JSON.parse(json);
            if (specs.type === "integer" || specs.type === "decimal") {
                return "<span style='width:50%;display:inline-block;'>最大值：<span style=\"color:#F56C6C\">" + specs.max +
                    "</span></span>最小值：<span style=\"color:#F56C6C\">" + specs.min +
                    "</span><br /><span style='width:50%;display:inline-block;'>步长：<span style=\"color:#F56C6C\">" + specs.step +
                    "</span></span>单位：<span style=\"color:#F56C6C\">" + specs.unit;
            } else if (specs.type === "string") {
                return "最大长度：<span style=\"color:#F56C6C\">" + specs.maxLength + "</span>";
            } else if (specs.type === "array") {
                return "数组类型：<span style=\"color:#F56C6C\">" + specs.arrayType + "</span>";
            } else if (specs.type === "enum") {
                let items = "";
                for (let i = 0; i < specs.enumList.length; i++) {
                    items = items + "<span style='width:50%;display:inline-block;'>" + specs.enumList[i].value + "：<span style='color:#F56C6C'>" + specs.enumList[i].text + "</span></span>"
                    if (i > 0 && i % 2 != 0) {
                        items = items + "<br />"
                    }
                }
                return items;
            } else if (specs.type === "bool") {
                return "<span style='width:50%;display:inline-block;'>0：<span style=\"color:#F56C6C\">" + specs.falseText +
                    "</span></span>1：<span style=\"color:#F56C6C\">" + specs.trueText
            }
        },

    },
};
</script>
