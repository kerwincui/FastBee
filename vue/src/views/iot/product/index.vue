<template>
<div style="padding:6px;">
    <el-card style="margin-bottom:6px;">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item label="产品名称" prop="productName">
                <el-input v-model="queryParams.productName" placeholder="请输入产品名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="分类名称" prop="categoryName">
                <el-input v-model="queryParams.categoryName" placeholder="请输入产品分类名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small">
                    <el-option v-for="dict in dict.type.iot_product_status" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
            <el-form-item style="float:right;">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleEditProduct(0)" v-hasPermi="['iot:product:add']">新增</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom:100px;">
        <el-row :gutter="30" v-loading="loading" >
            <el-col :span="6" v-for="(item,index) in productList" :key="index" style="margin-bottom:30px;text-align:center;">
                <el-card :body-style="{ padding: '20px'}" shadow="always">
                    <el-row type="flex" :gutter="10" justify="space-between">
                        <el-col :span="20" style="text-align:left;">
                            <el-link type="" :underline="false" @click="handleEditProduct(item)" style="font-weight:bold;font-size:16px;line-height:32px;">
                                <svg-icon icon-class="product" /> {{item.productName}}
                                <el-tag type="info" size="mini" style="margin-left:5px;font-weight:200" v-if="item.isSys==1">系统</el-tag>
                            </el-link>
                        </el-col>
                        <el-col :span="4">
                            <el-tooltip class="item" effect="dark" content="取消发布" placement="top-start" v-if="item.status==2">
                                <el-button type="success" size="mini" style="padding:5px;" @click="changeProductStatus(item.productId,1)">已发布</el-button>
                            </el-tooltip>
                            <el-tooltip class="item" effect="dark" content="现在发布" placement="top-start" v-if="item.status==1">
                                <el-button type="info" size="mini" style="padding:5px;" @click="changeProductStatus(item.productId,2)">未发布</el-button>
                            </el-tooltip>
                        </el-col>
                    </el-row>
                    <el-row :gutter="10">
                        <el-col :span="14">
                            <el-descriptions :column="1" size="small" style="margin-top:10px;">
                                <el-descriptions-item label="所属分类">
                                    <el-link type="primary" :underline="false">{{item.categoryName}}</el-link>
                                </el-descriptions-item>
                                <el-descriptions-item label="产品类型">
                                    <dict-tag :options="dict.type.iot_device_type" :value="item.deviceType" />
                                </el-descriptions-item>
                                <el-descriptions-item label="联网方式">
                                    <dict-tag :options="dict.type.iot_network_method" :value="item.networkMethod" />
                                </el-descriptions-item>
                                <el-descriptions-item label="创建时间">
                                    <span>{{ parseTime(item.createTime, '{y}-{m}-{d}') }}</span>
                                </el-descriptions-item>
                            </el-descriptions>
                        </el-col>
                        <el-col :span="10">
                            <div style="margin-top:10px;">
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" lazy :preview-src-list="[baseUrl+item.imgUrl]" :src="baseUrl+item.imgUrl" fit="cover" v-if="item.imgUrl!=null && item.imgUrl!=''"></el-image>
                                <!-- 用于显示本地计算机、手机、树莓派等设备图片-->
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/esp8266.jpg')]" :src="require('@/assets/images/esp8266.jpg')" fit="cover" v-else-if="item.productName.indexOf('ESP8266')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/esp32.jpg')]" :src="require('@/assets/images/esp32.jpg')" fit="cover" v-else-if="item.productName.indexOf('ESP32')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/raspberry.jpg')]" :src="require('@/assets/images/raspberry.jpg')" fit="cover" v-else-if="item.productName.indexOf('Raspberry')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/telphone.jpg')]" :src="require('@/assets/images/telphone.jpg')" fit="cover" v-else-if="item.productName.indexOf('Phone')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/computer.jpg')]" :src="require('@/assets/images/computer.jpg')" fit="cover" v-else-if="item.productName.indexOf('Computer')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/product.jpg')]" :src="require('@/assets/images/product.jpg')" fit="cover" v-else></el-image>
                            </div>
                        </el-col>
                    </el-row>
                    <el-button-group style="margin-top:15px;">
                        <el-button size="mini" type="primary" icon="el-icon-edit" @click="handleEditProduct(item)" v-hasPermi="['iot:product:edit']">详情</el-button>
                        <el-button size="mini" type="danger" icon="el-icon-delete" @click="handleDelete(item)" v-hasPermi="['iot:product:remove']" v-if="item.status==1">删除</el-button>
                        <el-button size="mini" type="info" icon="el-icon-download" @click="handleGeneratorSDK(item)" v-hasPermi="['iot:product:edit']" v-if="item.status==2">下载SDK</el-button>
                        <el-button size="mini" type="warning" icon="el-icon-search" @click="handleViewDevice(item.productId)" v-hasPermi="['tool:gen:edit']">查看设备</el-button>
                    </el-button-group>
                </el-card>
            </el-col>
        </el-row>

        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 下载SDK -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-link type="danger" style="padding-left:10px;" :underline="false">该功能暂未实现，参考教程和项目的SDK示例</el-link>
            <el-form label-width="80px">
                <el-form-item label="选择设备">
                    <el-radio-group v-model="form.datatype">
                        <el-radio v-for="dict in dict.type.iot_device_chip" :key="dict.value" :label="dict.value" style="margin-top:15px;width:160px;">{{dict.label}}</el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="downloadSdk" disabled>下 载</el-button>
                <el-button @click="cancel">取 消</el-button>
            </div>
        </el-dialog>

    </el-card>
</div>
</template>

<script>
import {
    listProduct,
    delProduct,
    changeProductStatus
} from "@/api/iot/product";

export default {
    name: "Product",
    dicts: ['iot_yes_no', 'iot_product_status', 'iot_device_type', 'iot_network_method', 'iot_vertificate_method', 'iot_device_chip'],
    data() {
        return {
            // 遮罩层
            loading: true,
            // 总条数
            total: 0,
            // 产品表格数据
            productList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                productName: null,
                categoryId: null,
                categoryName: null,
                tenantId: null,
                tenantName: null,
                isSys: null,
                status: null,
                deviceType: null,
                networkMethod: null,
            },
            // 表单参数
            form: {},
            baseUrl: process.env.VUE_APP_BASE_API,
        };
    },
    created() {
        this.getList();
    },
    activated() {
        const time = this.$route.query.t;
        if (time != null && time != this.uniqueId) {
            this.uniqueId = time;
            this.queryParams.pageNum = Number(this.$route.query.pageNum);
            this.getList();
        }
    },
    methods: {
        /** 查询产品列表 */
        getList() {
            this.loading = true;
            listProduct(this.queryParams).then(response => {
                this.productList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        /** 更新产品状态 */
        changeProductStatus(productId,status) {
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
                data.productId = productId;
                data.status = status;
                changeProductStatus(data).then(response => {
                    this.getList();
                    this.$modal.alertSuccess(response.msg);
                }).catch(() => {});
            }).catch(() => {});
        },
        /** 修改按钮操作 */
        handleViewDevice(productId) {
            this.$router.push({
                path: '/iot/device',
                query: {
                    t: Date.now(),
                    productId: productId,
                }
            });
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
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
        /** 生成SDK */
        handleGeneratorSDK(row) {
            this.title = "生成SDK"
            this.open = true;
        },
        /** 下载SDK */
        downloadSdk() {
            this.$download.zip("/iot/tool/genSdk?deviceChip=" + 1, "wumeismart-sdk");
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const productIds = row.productId || this.ids;
            let msg = "";
            this.$modal.confirm('是否确认删除产品编号为"' + productIds + '"的数据项？').then(function () {
                return delProduct(productIds).then(response => {
                    msg = response.msg;
                });
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess(msg);
            }).catch(() => {});
        },
        /** 修改按钮操作 */
        handleEditProduct(row) {
            let productId = 0;
            if (row != 0) {
                productId = row.productId || this.ids
            }
            this.$router.push({
                path: '/iot/product-edit',
                query: {
                    productId: productId,
                    pageNum: this.queryParams.pageNum
                }
            });
        },
    }
};
</script>
