<template>
    <el-card style="margin:6px;padding-bottom:100px;">
        <el-tabs v-model="activeName" tab-position="left" style="padding:10px;min-height:400px;" @tab-click="tabChange">
            <el-tab-pane name="basic">
                <span slot="label"><span style="color:red;">* </span>基本信息</span>
                <el-form ref="form" :model="form" :rules="rules" label-width="100px">
                    <el-row :gutter="100">
                        <el-col :xs="24" :sm="24" :md="24" :lg="12" :xl="8">
                            <el-form-item label="产品名称" prop="productName">
                                <el-input v-model="form.productName" placeholder="请输入产品名称" :readonly="form.status == 2" />
                            </el-form-item>
                            <el-form-item label="产品分类" prop="categoryId">
                                <el-select v-model="form.categoryId" placeholder="请选择分类" @change="selectCategory"
                                    style="width:100%" :disabled="form.status == 2">
                                    <el-option v-for="category in categoryShortList" :key="category.id"
                                        :label="category.name" :value="category.id"></el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="设备类型" prop="deviceType">
                                <el-select v-model="form.deviceType" placeholder="请选择设备类型" :disabled="form.status == 2"
                                    style="width:100%">
                                    <el-option v-for="dict in dict.type.iot_device_type" :key="dict.value"
                                        :label="dict.label" :value="parseInt(dict.value)"></el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="传输协议" prop="transport">
                                <el-select v-model="form.transport" placeholder="请选择传输协议" style="width: 100%"
                                    :disabled="form.status == 2">
                                    <el-option v-for="dict in dict.type.iot_transport_type" :key="dict.value"
                                        :label="dict.label" :value="dict.value" />
                                </el-select>
                            </el-form-item>
                            <el-form-item v-if="form.deviceType !== 3" label="编码协议" prop="protocolCode">
                              <el-select v-model="form.protocolCode" placeholder="请选择编码协议" style="width: 100%"
                                         :disabled="form.status == 2" @change="changeProductCode">
                                <el-option v-for="p in protocolList" :key="p.protocolCode" :label="p.protocolName"
                                           :value="p.protocolCode" />
                              </el-select>
                            </el-form-item>
                            <el-form-item label="联网方式" prop="networkMethod">
                                <el-select v-model="form.networkMethod" placeholder="请选择联网方式" style="width:100%;"
                                    :disabled="form.status == 2">
                                    <el-option v-for="dict in dict.type.iot_network_method" :key="dict.value"
                                        :label="dict.label" :value="parseInt(dict.value)"></el-option>
                                </el-select>
                            </el-form-item>

                            <el-form-item label="备注信息" prop="remark">
                                <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" rows="3"
                                    :readonly="form.status == 2" />
                            </el-form-item>
                        </el-col>
                        <el-col :xs="24" :sm="24" :md="24" :lg="12" :xl="8">
                            <el-form-item label="启用授权" prop="networkMethod">
                                <el-switch v-model="form.isAuthorize" @change="changeIsAuthorize(form.isAuthorize)"
                                    :active-value="1" :inactive-value="0"
                                    :disabled="form.status == 2 || form.deviceType == 3" />
                            </el-form-item>
                            <el-form-item label="认证方式" prop="vertificateMethod">
                                <el-select v-model="form.vertificateMethod" placeholder="请选择认证方式" style="width:100%"
                                    :disabled="form.status == 2 || form.deviceType == 3">
                                    <el-option v-for="dict in dict.type.iot_vertificate_method" :key="dict.value"
                                        :label="dict.label" :value="parseInt(dict.value)"></el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="产品编号" prop="productId">
                                <el-input v-model="form.productId" placeholder="自动生成"
                                    :disabled="!form.mqttAccount || form.deviceType == 3" readonly />
                            </el-form-item>
                            <el-form-item label="Mqtt账号" prop="mqttAccount">
                                <el-input v-model="form.mqttAccount" placeholder="不填自动生成" :disabled="form.deviceType == 3"
                                    :readonly="accountInputType == 'password'" :type="accountInputType">
                                    <el-button slot="append" icon="el-icon-view" style="font-size:18px;"
                                        @click="changeInputType('account')"></el-button>
                                </el-input>
                            </el-form-item>
                            <el-form-item label="Mqtt密码" prop="mqttPassword">
                                <el-input v-model="form.mqttPassword" placeholder="不填则自动生成" :disabled="form.deviceType == 3"
                                    :readonly="passwordInputType == 'password'" :type="passwordInputType">
                                    <el-button slot="append" icon="el-icon-view" style="font-size:18px;"
                                        @click="changeInputType('password')"></el-button>
                                </el-input>
                            </el-form-item>
                            <el-form-item label="产品秘钥" prop="mqttSecret">
                                <el-input v-model="form.mqttSecret" placeholder="自动生成"
                                    :disabled="!form.mqttAccount || form.deviceType == 3" readonly :type="keyInputType">
                                    <el-button slot="append" icon="el-icon-view" style="font-size:18px;"
                                        @click="changeInputType('key')"></el-button>
                                </el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :xs="24" :sm="24" :md="24" :lg="12" :xl="8">
                            <el-form-item label="产品图片">
                                <div v-if="form.status == 2 && form.imgUrl == null">
                                    <el-image style="height:145px;height:145px;border-radius:10px;"
                                        :preview-src-list="[require('@/assets/images/gateway.png')]"
                                        :src="require('@/assets/images/gateway.png')" fit="cover"
                                        v-if="form.deviceType == 2"></el-image>
                                    <el-image style="height:145px;height:145px;border-radius:10px;"
                                        :preview-src-list="[require('@/assets/images/video.png')]"
                                        :src="require('@/assets/images/video.png')" fit="cover"
                                        v-else-if="form.deviceType == 3"></el-image>
                                    <el-image style="height:145px;height:145px;border-radius:10px;"
                                        :preview-src-list="[require('@/assets/images/product.png')]"
                                        :src="require('@/assets/images/product.png')" fit="cover" v-else></el-image>
                                </div>
                                <div v-else>
                                    <imageUpload ref="image-upload" :disabled="true" :value="form.imgUrl"
                                        :limit="form.status == 2 ? 0 : 1" :fileSize="1" @input="getImagePath($event)">
                                    </imageUpload>
                                </div>
                                <div class="el-upload__tip" style="color:#f56c6c"
                                    v-if="form.productId == null || form.productId == 0">提示：上传后需要提交保存</div>
                            </el-form-item>
                        </el-col>
                    </el-row>

                    <el-col :span="20">
                        <el-form-item style="text-align: center;margin:40px 0px;">
                            <el-button type="primary" @click="submitForm" v-hasPermi="['iot:product:edit']"
                                v-show="form.productId != 0 && form.status != 2">修 改</el-button>
                            <el-button type="primary" @click="submitForm" v-hasPermi="['iot:product:add']"
                                v-show="form.productId == 0 && form.status != 2">新 增</el-button>
                        </el-form-item>
                    </el-col>
                </el-form>
            </el-tab-pane>

            <el-tab-pane label="" name="things" :disabled="form.productId == 0">
                <span slot="label"><span style="color:red;">* </span>产品模型</span>
                <product-things-model ref="productThingsModel" :product="form" />
            </el-tab-pane>

            <el-tab-pane label="" name="productAuthorize" :disabled="form.productId == 0" v-if="form.deviceType !== 3">
                <span slot="label">设备授权</span>
                <product-authorize ref="productAuthorize" :product="form" />
            </el-tab-pane>

            <el-tab-pane label="" name="alert" :disabled="form.productId == 0" v-if="form.deviceType !== 3">
                <span slot="label"><span style="color:red;">￥ </span>告警配置</span>
                <business ref="business"/>
            </el-tab-pane>


            <div style="margin-top:200px;"></div>

            <!-- 用于设置间距 -->
            <el-tab-pane>
                <span slot="label">
                    <div style="margin-top:200px;"></div>
                </span>
            </el-tab-pane>

            <el-tab-pane v-if="form.status == 1" name="product04" disabled>
                <span slot="label">
                    <el-button type="success" size="mini" @click="changeProductStatus(2)"
                        v-hasPermi="['iot:product:add']">发布产品</el-button>
                </span>
            </el-tab-pane>
            <el-tab-pane v-if="form.status == 2" name="product05" disabled>
                <span slot="label">
                    <el-button type="danger" size="mini" @click="changeProductStatus(1)"
                        v-hasPermi="['iot:product:edit']">取消发布</el-button>
                </span>
            </el-tab-pane>
            <el-tab-pane name="product06" disabled>
                <span slot="label">
                    <el-button type="info" size="mini" @click="goBack()">返回列表</el-button>
                </span>
            </el-tab-pane>
        </el-tabs>

    </el-card>
</template>

<script>
import productThingsModel from "./product-things-model";
import productApp from "./product-app"
import productAuthorize from "./product-authorize"
import imageUpload from "../../../components/ImageUpload/index"
import business from "../business/index"
import {
    listProtocol
} from "@/api/iot/protocol";

import {
    listShortCategory,
} from "@/api/iot/category";
import {
    getProduct,
    addProduct,
    updateProduct,
    changeProductStatus,
    deviceCount,
} from "@/api/iot/product";

import {
    getAllPoints
} from "@/api/iot/template";

export default {
    name: "ProductEdit",
    dicts: ['iot_device_type', 'iot_network_method', 'iot_vertificate_method', 'iot_transport_type', 'data_collect_type'],
    components: {
        productThingsModel,
        productApp,
        productAuthorize,
        imageUpload,
        business,
    },
    data() {
        return {
            // 输入框类型
            keyInputType: "password",
            accountInputType: "password",
            passwordInputType: "password",
            // 选中选项卡
            activeName: 'basic',
            // 分类短列表
            categoryShortList: [],
            //协议列表
            protocolList: [],
            // 表单参数
            form: {
                networkMethod: 1,
                deviceType: 1,
                vertificateMethod: 3,
                transport: 'MQTT',
                imgUrl: "",
            },
            // 表单校验
            rules: {
                productName: [{
                    required: true,
                    message: "产品名称不能为空",
                    trigger: "blur",
                    
                },
                {
                    min: 1,
                    max: 64,
                    message: '产品名称不能少于1个字符和超过64字符',
                    trigger: 'blur',    
                },
               ],
                categoryId: [{
                    required: true,
                    message: "产品分类ID不能为空",
                    trigger: "blur"
                }],
                deviceType: [{
                    required: true,
                    message: "请选择设备类型",
                    trigger: "blur"
                }],
                protocolCode: [{
                    required: true,
                    message: "设备协议不能为空",
                    trigger: "blur"
                }],
                transport: [{
                    required: true,
                    message: "传输协议不能为空",
                    trigger: 'blur'
                }]
            },
            // 查询参数
            queryParams: {
                tenantName: null,
            },
            pointList: [],
            open: false,
            // 弹出层标题
            title: "",
            loading: true,
            tempList: [],
            // 总条数
            total: 0,
            tempTotal: 0,
            // 查询参数
            pointsParams: {
                pageNum: 1,
                pageSize: 8,
                templateId: 0,
            },
            tempParams: {
                pageNum: 1,
                pageSize: 10,
            },
            currentRow: {},
            selectRowData: {},
            isModbus: false,

        };
    },
    created() {
        // 获取产品信息
        const productId = this.$route.query && this.$route.query.productId;
        this.form.productId = productId;
        if (this.form.productId != 0 && this.form.productId != null) {
            this.getProduct();
        }
        // 切换选项卡
        const tabPanelName = this.$route.query && this.$route.query.tabPanelName;
        if (tabPanelName != null && tabPanelName != '') {
            this.activeName = tabPanelName;
        }
        // 获取分类信息
        this.getShortCategory();
        // 设置账号密码输入框类型,新增时为text，查看时为password
        if (!this.form.productId || this.form.productId == 0) {
            this.accountInputType = "text";
            this.passwordInputType = "text";
        }
        this.getProtocol();
    },
    activated() {
        const time = this.$route.query.t;
        if (time != null && time != this.uniqueId) {
            this.uniqueId = time;  
        }
        // 获取产品信息
        let productId = this.$route.query.productId
        if (productId != null && productId != 0) {
            this.form.productId = Number(productId);
            this.getProduct();
            this.getShortCategory();
        }
        // 切换选项卡
        const tabPanelName = this.$route.query && this.$route.query.tabPanelName;
        if (tabPanelName != null && tabPanelName != '') {
            this.activeName = tabPanelName;
        }

    },
    methods: {
        // 获取简短分类列表
        getShortCategory() {
            listShortCategory().then(response => {
                this.categoryShortList = response.data;
            })
        },
        /** 返回按钮 */
        goBack() {
            const obj = {
                path: "/iot/product",
                query: {
                    t: Date.now(),
                    pageNum: this.$route.query.pageNum
                }
            };
            this.$tab.closeOpenPage(obj);
            this.reset();
        },
        /** 获取产品信息 */
        getProduct() {
            getProduct(this.form.productId).then(response => {
                this.form = response.data;
                this.changeProductCode(this.form.protocolCode);
            });
        },
        // 表单重置
        reset() {
            this.form = {
                productId: 0,
                productName: null,
                categoryId: null,
                categoryName: null,
                status: 0,
                tslJson: null,
                isAuthorize: 0,
                deviceType: 1,
                networkMethod: 1,
                vertificateMethod: 3,
                mqttAccount: null,
                mqttPassword: null,
                mqttSecret: null,
                remark: null,
                imgUrl: "",
            };
            this.resetForm("form");
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.productId != null && this.form.productId != 0) {
                        updateProduct(this.form).then(response => {
                            this.changeProductCode(this.form.protocolCode);
                            this.$modal.alertSuccess("修改成功");
                        });
                    } else {
                        addProduct(this.form).then(response => {
                            if (!this.form.isModbus) {
                                this.$modal.alertSuccess("添加成功,可以开始定义物模型或配置");
                            } else {
                                this.$modal.alertSuccess("物模型已经从采集点模板同步至产品")
                            }
                            this.form = response.data;
                            this.changeProductCode(this.form.protocolCode);
                        });
                    }
                }
            });
        },
        /**同步获取产品下的设备数量**/
        getDeviceCountByProductId(productId) {
            return new Promise((resolve, reject) => {
                deviceCount(productId).then(res => {
                    resolve(res);
                }).catch(error => {
                    reject(error);
                })
            })
        },
        /** 更新产品状态 */
        async changeProductStatus(status) {
            let message = "确定取消发布？";
            if (status == 2) {
                message = "产品发布后，可以创建对应的设备";
            } else if (status == 1) {
                let result = await this.getDeviceCountByProductId(this.form.productId);
                if (result.data > 0) {
                    message = "重要提示：产品下已有 " + result.data + " 个设备，取消发布可以修改产品信息和模型，重新发布后对应设备状态将会被重置！"
                }
            }
            this.$confirm(message, '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                let data = {};
                data.productId = this.form.productId;
                data.status = status;
                data.deviceType = this.form.deviceType;
                changeProductStatus(data).then(response => {
                    this.$modal.alertSuccess(response.msg);
                    this.activeName = "basic";
                    this.getProduct();
                }).catch(() => {
                    if (status == 2) {
                        this.activeName = "basic";
                    } else {
                        this.goBack();
                    }
                });
            }).catch(() => {
                this.activeName = "basic";
            });
        },
        /** 选择分类 */
        selectCategory(val) {
            for (var i = 0; i < this.categoryShortList.length; i++) {
                if (this.categoryShortList[i].id == val) {
                    this.form.categoryName = this.categoryShortList[i].name;
                    return;
                }
            }
        },
        /**获取上传图片的路径 */
        getImagePath(data) {
            this.form.imgUrl = data;
        },
        /**改变输入框类型**/
        changeInputType(name) {
            if (name == "key") {
                this.keyInputType = this.keyInputType == "password" ? "text" : "password";
            } else if (name == "account") {
                this.accountInputType = this.accountInputType == "password" ? "text" : "password";
            } else if (name == "password") {
                this.passwordInputType = this.passwordInputType == "password" ? "text" : "password";
            }
        },
        // 授权码状态修改
        changeIsAuthorize() {
            let text = this.form.isAuthorize == "1" ? "启用" : "停用";
            this.$modal.confirm('确认要' + text + '授权码吗？').then(() => {
                if (this.form.productId != null && this.form.productId != 0) {
                    updateProduct(this.form).then(response => {
                        this.$modal.alertSuccess("授权码已" + text);
                    });
                }
            }).catch(() => {
                this.form.isAuthorize = 0;
            });
        },
        //获取设备协议
        getProtocol() {
            const data = {
                protocolStatus: 1
            };
            listProtocol(data).then(res => {
                this.protocolList = res.rows;
            })
        },
        // 取消按钮
        cancel() {
            this.open = false;
            // this.reset();
        },
        getList() {
            getAllPoints(this.pointsParams).then(response => {
                this.pointList = response.rows;
                this.total = response.total;
            });
        },
        changeProductCode(val) {
            if (val && val.startsWith("MODBUS")) {
                this.form.deviceType = 2;
                this.form.isModbus = true;
                if (this.form.productId != 0 && this.form.productId != null) {
                    //this.getTempDetail()
                }
            } else {
                this.form.isModbus = false;
            }
        },
        /**选项卡切换事件**/
        tabChange(tabItem) {
            // 切换到告警配置，获取物模型
            if (tabItem.paneName == "alert") {
                //this.$refs.productAlert.getCacheThingsModel(this.form.productId);
            }
        },

        /*按照模板名查询*/
        queryTemp() {
            this.getTempList();
        },

        /** 搜索按钮操作 */
        handleQuery() {
            this.tempParams.pageNum = 1
            this.getTempList()
        },

        /** 重置按钮操作 */
        resetQuery() {
            this.resetForm('tempParams')
            this.handleQuery()
        },
    }
};
</script>

<style>
.el-aside {
    margin: 0;
    padding: 0;
    background-color: #fff;
    color: #333;
}

.el-main {
    margin: 0;
    padding: 0 10px;
    background-color: #fff;
    color: #333;
}
</style>
