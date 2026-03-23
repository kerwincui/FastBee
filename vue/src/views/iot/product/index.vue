<template>
<div style="padding:6px;">
    <el-card style="margin-bottom:5px;">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item :label="$t('product.index.091251-0')" prop="productName">
                <el-input v-model="queryParams.productName" :placeholder="$t('product.index.091251-1')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('product.index.091251-2')" prop="categoryName">
                <el-input v-model="queryParams.categoryName" :placeholder="$t('product.index.091251-3')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('product.index.091251-4')" prop="status">
                <el-select v-model="queryParams.status" :placeholder="$t('product.index.091251-5')" clearable size="small">
                    <el-option v-for="dict in dict.type.iot_product_status" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
            </el-form-item>
            <el-form-item style="float:right;">
                <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleEditProduct(0)" v-hasPermi="['iot:product:add']">{{ $t('add') }}</el-button>
            </el-form-item>
        </el-form>
    </el-card>
    <el-card style="padding-bottom:100px;">
        <el-row :gutter="30" v-loading="loading">
            <el-col :xs="24" :sm="12" :md="12" :lg="8" :xl="6" v-for="(item,index) in productList" :key="index" style="margin-bottom:30px;text-align:center;">
                <el-card :body-style="{ padding: '20px'}" shadow="always" class="card-item">
                    <el-row type="flex" :gutter="10" justify="space-between">
                        <el-col :span="20" style="text-align:left;">
                            <el-link type="" :underline="false" @click="handleEditProduct(item)" style="font-weight:bold;font-size:16px;line-height:32px;white-space:nowrap;">
                                <svg-icon icon-class="product" /> {{item.productName}}
                                <el-tag type="info" size="small" style="margin-left:5px;font-weight:200" v-if="item.isSys==1">{{ $t('product.index.091251-47') }}</el-tag>
                            </el-link>
                        </el-col>
                        <el-col :span="4">
                            <el-tooltip class="item" effect="dark" :content="$t('product.index.091251-12')" placement="top-start" v-if="item.status==2">
                                <el-button type="success" size="small" style="padding:5px;" @click="changeProductStatus(item.productId,1,item.deviceType)">{{ $t('product.index.091251-13') }}</el-button>
                            </el-tooltip>
                            <el-tooltip class="item" effect="dark" :content="$t('product.index.091251-14')" placement="top-start" v-if="item.status==1">
                                <el-button type="info" size="small" style="padding:5px;" @click="changeProductStatus(item.productId,2,item.deviceType)">{{ $t('product.index.091251-15') }}</el-button>
                            </el-tooltip>
                        </el-col>
                    </el-row>
                    <el-row :gutter="10">
                        <el-col :span="14">
                            <el-descriptions :column="1" size="small" style="margin-top:10px;white-space:nowrap;">
                                <el-descriptions-item :label="$t('product.index.091251-16')">
                                    <el-link type="primary" :underline="false">{{item.categoryName}}</el-link>
                                </el-descriptions-item>
                                <el-descriptions-item :label="$t('product.index.091251-17')">
                                    <dict-tag :options="dict.type.iot_device_type" :value="item.deviceType" />
                                </el-descriptions-item>
                                <el-descriptions-item :label="$t('product.index.091251-18')">
                                    <dict-tag :options="dict.type.iot_network_method" :value="item.networkMethod" />
                                </el-descriptions-item>
                                <el-descriptions-item :label="$t('product.index.091251-19')">
                                    <el-tag type="success" size="small" v-if="item.isAuthorize==1">{{ $t('product.index.091251-20') }}</el-tag>
                                    <el-tag type="info" size="small" v-else>{{ $t('product.index.091251-21') }}</el-tag>
                                </el-descriptions-item>
                            </el-descriptions>
                        </el-col>
                        <el-col :span="10">
                            <div style="margin-top:10px;">
                                <el-image style="width:100%;height:100px;border-radius:10px;" lazy :preview-src-list="[baseUrl+item.imgUrl]" :src="baseUrl+item.imgUrl" fit="cover" v-if="item.imgUrl!=null && item.imgUrl!=''"></el-image>
                                <el-image style="width:100%;height:100px;border-radius:10px;" :preview-src-list="[require('@/assets/images/gateway.png')]" :src="require('@/assets/images/gateway.png')" fit="cover" v-else-if="item.deviceType==2"></el-image>
                                <el-image style="width:100%;height:100px;border-radius:10px;" :preview-src-list="[require('@/assets/images/video.png')]" :src="require('@/assets/images/video.png')" fit="cover" v-else-if="item.deviceType==3"></el-image>
                                <el-image style="width:100%;height:100px;border-radius:10px;" :preview-src-list="[require('@/assets/images/product.png')]" :src="require('@/assets/images/product.png')" fit="cover" v-else></el-image>
                            </div>
                        </el-col>
                    </el-row>
                    <el-button-group style="margin-top:15px;height:28px;">
                        <el-button size="small" type="primary" icon="el-icon-view" @click="handleEditProduct(item)" v-hasPermi="['iot:product:query']">{{ $t('product.index.091251-48') }}</el-button>
                        <el-button size="small" type="danger" icon="el-icon-delete" @click="handleDelete(item)" v-hasPermi="['iot:product:remove']" v-if="item.status==1">{{ $t('product.index.091251-23') }}</el-button>
                        <el-button size="small" type="success" icon="el-icon-s-check" @click="handleDeviceAuthorize(item)" v-hasPermi="['iot:product:edit']" v-if="item.status==2" :disabled="item.isAuthorize!=1">{{ $t('product.index.091251-19') }}</el-button>
                        <el-button size="small" type="warning" icon="el-icon-search" @click="handleViewDevice(item.productId)" v-hasPermi="['iot:device:query']">{{ $t('product.index.091251-24') }}</el-button>
                    </el-button-group>
                </el-card>
            </el-col>
        </el-row>

        <el-empty :description="$t('product.index.091251-25')" v-if="total==0"></el-empty>
        <div class="pagination-container">
        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" :pageSizes="[12, 24, 36, 60]" @pagination="getList" />
        </div>

        <!-- 下载SDK -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-link type="danger" style="padding-left:10px;" :underline="false">{{ $t('product.index.091251-26') }}</el-link>
            <el-form label-width="80px">
                <el-form-item :label="$t('product.index.091251-27')">
                    <el-radio-group v-model="form.datatype">
                        <el-radio v-for="dict in dict.type.iot_device_chip" :key="dict.value" :label="dict.value" style="margin-top:15px;width:160px;">{{dict.label}}</el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="downloadSdk" disabled>{{ $t('product.index.091251-28') }}</el-button>
                <el-button @click="cancel">{{ $t('product.index.091251-29') }}</el-button>
            </div>
        </el-dialog>

    </el-card>
</div>
</template>

<script>
import {
    listProduct,
    delProduct,
    changeProductStatus,
    deviceCount,
} from "@/api/iot/product";

import {
    checkPermi
} from "@/utils/permission"

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
                pageSize: 12,
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
        async changeProductStatus(productId, status, deviceType) {
            let message = this.$t('product.index.091251-30');
            if (status == 2) {
                // 发布
                let hasPermission = checkPermi(['iot:product:add']);
                if (!hasPermission) {
                    this.$modal.alertError(this.$t('product.index.091251-31'));
                    return;
                }
                message = this.$t('product.index.091251-32');
            } else if (status == 1) {
                // 取消发布
                let hasPermission = checkPermi(['iot:product:edit']);
                if (!hasPermission) {
                    this.$modal.alertError(this.$t('product.index.091251-31'));
                    return;
                }
                let result = await this.getDeviceCountByProductId(productId);
                if (result.data > 0) {
                    message = this.$i18n.t('product.index.091251-33', [result.data]);
                }
            }
            this.$confirm(message, this.$t('product.index.091251-34'), {
                confirmButtonText: this.$t('product.index.091251-35'),
                cancelButtonText: this.$t('cancel'),
                type: 'warning'
            }).then(() => {
                let data = {};
                data.productId = productId;
                data.status = status;
                data.deviceType = deviceType;
                changeProductStatus(data).then(response => {
                    this.getList();
                    this.$modal.alertSuccess(response.msg);
                }).catch(() => {});
            }).catch(() => {});
        },
        /** 查看设备按钮操作 */
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
            this.title = this.$t('product.index.091251-38')
            this.open = true;
        },
        /** 下载SDK */
        downloadSdk() {
            this.$download.zip("/iot/tool/genSdk?deviceChip=" + 1, "fastbee-sdk");
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const productIds = row.productId || this.ids;
            let msg = "";
            this.$modal.confirm(this.$i18n.t('product.index.091251-39', [productIds])).then(function () {
                // // 删除SIP配置
                // delSipconfigByProductId(productIds).then(response => {});
                return delProduct(productIds);
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
        /** 设备授权操作 */
        handleDeviceAuthorize(row) {
            let productId = row.productId
            this.$router.push({
                path: '/iot/product-edit',
                query: {
                    productId: productId,
                    tabPanelName: 'productAuthorize',
                    pageNum: this.queryParams.pageNum
                }
            });
        },
    }
};
</script>

<style scoped>
.card-item {
    border-radius: 15px;
}
</style>
