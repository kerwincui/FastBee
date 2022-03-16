<template>
<el-card style="margin:6px;padding-bottom:100px;">
    <el-tabs v-model="activeName" tab-position="left" style="padding:10px;">
        <el-tab-pane name="basic">
            <span slot="label"> * 基本信息</span>
            <el-form ref="form" :model="form" :rules="rules" label-width="100px">
                <el-row :gutter="100">
                    <el-col :span="7">
                        <el-form-item label="产品名称" prop="productName">
                            <el-input v-model="form.productName" placeholder="请输入产品名称" />
                        </el-form-item>
                        <el-form-item label="产品分类" prop="categoryId">
                            <el-select v-model="form.categoryId" placeholder="请选择分类" @change="selectCategory" style="width:100%">
                                <el-option v-for="category in categoryShortList" :key="category.id" :label="category.name" :value="category.id"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="联网方式" prop="networkMethod">
                            <el-select v-model="form.networkMethod" placeholder="请选择联网方式" style="width:100%;">
                                <el-option v-for="dict in dict.type.iot_network_method" :key="dict.value" :label="dict.label" :value="parseInt(dict.value)"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="备注信息" prop="remark">
                            <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" rows="7" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="7">
                        <el-form-item label="设备类型" prop="deviceType">
                            <el-select v-model="form.deviceType" placeholder="请选择设备类型" disabled style="width:100%">
                                <el-option v-for="dict in dict.type.iot_device_type" :key="dict.value" :label="dict.label" :value="parseInt(dict.value)"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="设备认证" prop="vertificateMethod">
                            <el-select v-model="form.vertificateMethod" placeholder="请选择认证方式" disabled style="width:100%">
                                <el-option v-for="dict in dict.type.iot_vertificate_method" :key="dict.value" :label="dict.label" :value="parseInt(dict.value)"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="产品编号" prop="productId">
                            <el-input v-model="form.productId" placeholder="自动生成" :disabled="!form.mqttAccount" readonly />
                        </el-form-item>
                        <el-form-item label="Mqtt账号" prop="mqttAccount">
                            <el-input v-model="form.mqttAccount" placeholder="自动生成" :disabled="!form.mqttAccount" readonly :type="accountInputType">
                                <el-button slot="append" icon="el-icon-view" style="font-size:18px;" @click="changeInputType('account')"></el-button>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="Mqtt密码" prop="mqttPassword">
                            <el-input v-model="form.mqttPassword" placeholder="自动生成" :disabled="!form.mqttAccount" readonly :type="passwordInputType">
                                <el-button slot="append" icon="el-icon-view" style="font-size:18px;" @click="changeInputType('password')"></el-button>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="产品秘钥" prop="mqttSecret">
                            <el-input v-model="form.mqttSecret" placeholder="自动生成" :disabled="!form.mqttAccount" readonly :type="keyInputType">
                                <el-button slot="append" icon="el-icon-view" style="font-size:18px;" @click="changeInputType('key')"></el-button>
                            </el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item label="产品图片">
                            <imageUpload ref="image-upload" :value="form.imgUrl" :limit="1" :fileSize="1" @input="getImagePath($event)"></imageUpload>
                        </el-form-item>
                    </el-col>
                </el-row>

                <el-col :span="20">
                    <el-form-item style="text-align: center;margin:40px 0px;">
                        <el-button type="primary" @click="submitForm()" v-if="form.status!=2">提交</el-button>
                    </el-form-item>
                </el-col>
            </el-form>
        </el-tab-pane>

        <el-tab-pane label="" name="things" :disabled="form.productId==0">
            <span slot="label">* 定义物模型</span>
            <product-things-model ref="productThingsModel" :product="form" />
        </el-tab-pane>

        <el-tab-pane label="" name="alert" disabled>
            <span slot="label"> 告警配置</span>
            <product-alert ref="productAlert" :product="form"></product-alert>
        </el-tab-pane>

        <el-tab-pane label="" name="productApp" disabled>
            <span slot="label">自定义APP</span>
            <product-app ref="productApp" :product="form" />
        </el-tab-pane>

        <el-tab-pane label="" disabled name="product01" />
        <el-tab-pane label="" disabled name="product02" />
        <el-tab-pane label="" disabled name="product03" />
        <el-tab-pane v-if="form.status==1" name="product04">
            <span slot="label">
                <el-button type="success" size="mini" @click="changeProductStatus(2)">发布产品</el-button>
            </span>
        </el-tab-pane>
        <el-tab-pane v-if="form.status==2" name="product05">
            <span slot="label">
                <el-button type="danger" size="mini" @click="changeProductStatus(1)">取消发布</el-button>
            </span>
        </el-tab-pane>
        <el-tab-pane name="product06">
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
import productAlert from "./product-alert"
import imageUpload from "../../../components/ImageUpload/index"
import {
    listShortCategory
} from "@/api/iot/category";
import {
    getProduct,
    addProduct,
    updateProduct,
    changeProductStatus
} from "@/api/iot/product";

export default {
    name: "Product-edit",
    dicts: ['iot_device_type', 'iot_network_method', 'iot_vertificate_method'],
    components: {
        productThingsModel,
        productApp,
        productAlert,
        imageUpload,
    },
    data() {
        return {
            // 输入框类型
            keyInputType: "password",
            accountInputType: "text",
            passwordInputType: "password",
            // 选中选项卡
            activeName: 'basic',
            // 分类短列表
            categoryShortList: [],
            // 表单参数
            form: {
                networkMethod: 1,
                deviceType: 1,
                vertificateMethod: 3,
            },
            // 表单校验
            rules: {
                productName: [{
                    required: true,
                    message: "产品名称不能为空",
                    trigger: "blur"
                }],
                categoryId: [{
                    required: true,
                    message: "产品分类ID不能为空",
                    trigger: "blur"
                }]
            },

        };
    },
    created() {
        // 获取产品信息
        const productId = this.$route.query && this.$route.query.productId;
        this.form.productId = productId;
        if (this.form.productId != 0) {
            this.getProduct();
        }
        // 获取简短分类列表
        listShortCategory().then(response => {
            this.categoryShortList = response.data;
        })
    },
    methods: {
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
                deviceType: 1,
                networkMethod: 1,
                vertificateMethod: 3,
                mqttAccount: null,
                mqttPassword: null,
                mqttSecret: null,
                remark: null
            };
            this.resetForm("form");
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.productId != null && this.form.productId != 0) {
                        updateProduct(this.form).then(response => {
                            this.$modal.alertSuccess("修改成功");
                        });
                    } else {
                        addProduct(this.form).then(response => {
                            this.$modal.alertSuccess("添加成功,可以开始定义物模型了");
                            this.form = response.data;
                            this.activeName = "things";
                        });
                    }
                }
            });
        },
        /** 更新产品状态 */
        changeProductStatus(status) {
            let message="发生错误了";
            if(status==2){
                message="产品发布后不能再更改产品内容和对应物模型 ！";
            }else if(status==1){
                message="产品下不能有已经创建的设备，才能取消发布哦 ！"
            }
            this.$confirm(message, '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                let data = {};
                data.productId = this.form.productId;
                data.status = status;
                changeProductStatus(data).then(response => {
                    this.$modal.alertSuccess(response.msg);
                    this.goBack();
                }).catch(()=>{
                    if(status==2){
                    this.activeName = "things";
                    }else{
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
        }
    }
};
</script>
