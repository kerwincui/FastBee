<template>
    <div class="product_wrap">
        <el-card shadow="never" style="margin-bottom: 10px; border-radius: 5px">
            <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom: -20px">
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
                <el-form-item style="float: right">
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>
        <el-card shadow="never" style="border-radius: 5px">
            <el-button type="primary" plain icon="el-icon-plus" style="margin-bottom: 10px" size="small" @click="handleEditProduct(0)" v-hasPermi="['iot:product:add']">{{ $t('add') }}</el-button>
            <el-row :gutter="20" v-loading="loading">
                <el-col :xs="24" :sm="12" :md="12" :lg="8" :xl="6" v-for="(item, index) in productList" :key="index" style="margin-bottom: 20px">
                    <el-card shadow="hover" class="product-card">
                        <div class="card-header">
                            <div class="product-name" @click="handleEditProduct(item)">
                                <span>{{ item.productName }}</span>
                                <el-tag type="info" size="mini" style="margin-left: 8px; font-weight: normal" v-if="item.isSys == 1">{{ $t('product.index.091251-47') }}</el-tag>
                            </div>
                            <div class="header-status">
                                <dict-tag :options="dict.type.iot_product_status" :value="item.status" size="mini" />
                            </div>
                        </div>

                        <div class="card-time">
                            {{ parseTime(item.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}
                        </div>

                        <div class="card-info">
                            <div class="info-row">
                                <span class="info-value">{{ $t('product.index.091251-16') }}：{{ item.categoryName }}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-value" style="display: flex">
                                    {{ $t('product.index.091251-17') }}：
                                    <dict-tag :options="dict.type.iot_device_type" :value="item.deviceType" size="mini" />
                                </span>
                            </div>
                            <div class="info-row" style="width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis">
                                <span class="info-value" style="display: flex">
                                    {{ $t('product.index.091251-18') }}：
                                    <el-tooltip :content="item.networkMethod" placement="top">
                                        <dict-tag :options="dict.type.iot_network_method" :value="item.networkMethod" size="mini" />
                                    </el-tooltip>
                                </span>
                            </div>
                            <div class="info-row">
                                <span class="info-value">
                                    {{ $t('product.index.091251-19') }}：
                                    <el-tag type="success" size="mini" v-if="item.isAuthorize == 1">{{ $t('product.index.091251-20') }}</el-tag>
                                    <el-tag type="info" size="mini" v-else>{{ $t('product.index.091251-21') }}</el-tag>
                                </span>
                            </div>
                        </div>

                        <div class="card-footer">
                            <div class="footer-left"></div>
                            <div class="footer-actions">
                                <i class="el-icon-edit-outline" @click="handleEditProduct(item)" :title="$t('product.index.091251-48')"></i>
                                <i class="el-icon-view" @click="handleViewDevice(item.productId)" :title="$t('product.index.091251-24')"></i>
                                <i class="el-icon-delete" @click="handleDelete(item)" v-if="item.status == 1" :title="$t('product.index.091251-23')"></i>
                                <i class="el-icon-s-check" @click="handleDeviceAuthorize(item)" v-if="item.status == 2" :title="$t('product.index.091251-19')"></i>
                            </div>
                        </div>
                    </el-card>
                </el-col>
            </el-row>

            <el-empty :description="$t('product.index.091251-25')" v-if="total == 0"></el-empty>
            <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" :pageSizes="[12, 24, 36, 60]" @pagination="getList" />

            <!-- 下载SDK -->
            <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
                <el-link type="danger" style="padding-left: 10px" :underline="false">{{ $t('product.index.091251-26') }}</el-link>
                <el-form label-width="80px">
                    <el-form-item :label="$t('product.index.091251-27')">
                        <el-radio-group v-model="form.datatype">
                            <el-radio v-for="dict in dict.type.iot_device_chip" :key="dict.value" :label="dict.value" style="margin-top: 15px; width: 160px">{{ dict.label }}</el-radio>
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
import { listProduct, delProduct, changeProductStatus, deviceCount } from '@/api/iot/product';

import { checkPermi } from '@/utils/permission';
import RightToolbar from '@/components/RightToolbar';

export default {
    name: 'Product',
    components: {
        RightToolbar,
    },
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
            title: '',
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
            // 显示搜索条件
            showSearch: true,
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
            listProduct(this.queryParams).then((response) => {
                this.productList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        /**同步获取产品下的设备数量**/
        getDeviceCountByProductId(productId) {
            return new Promise((resolve, reject) => {
                deviceCount(productId)
                    .then((res) => {
                        resolve(res);
                    })
                    .catch((error) => {
                        reject(error);
                    });
            });
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
                type: 'warning',
            })
                .then(() => {
                    let data = {};
                    data.productId = productId;
                    data.status = status;
                    data.deviceType = deviceType;
                    changeProductStatus(data)
                        .then((response) => {
                            this.getList();
                            this.$modal.alertSuccess(response.msg);
                        })
                        .catch(() => {});
                })
                .catch(() => {});
        },
        /** 查看设备按钮操作 */
        handleViewDevice(productId) {
            this.$router.push({
                path: '/iot/device',
                query: {
                    t: Date.now(),
                    productId: productId,
                },
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
            this.resetForm('queryForm');
            this.handleQuery();
        },
        /** 生成SDK */
        handleGeneratorSDK(row) {
            this.title = this.$t('product.index.091251-38');
            this.open = true;
        },
        /** 下载SDK */
        downloadSdk() {
            this.$download.zip('/iot/tool/genSdk?deviceChip=' + 1, 'fastbee-sdk');
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const productIds = row.productId || this.ids;
            let msg = '';
            this.$modal
                .confirm(this.$i18n.t('product.index.091251-39', [productIds]))
                .then(function () {
                    // // 删除SIP配置
                    // delSipconfigByProductId(productIds).then(response => {});
                    return delProduct(productIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(msg);
                })
                .catch(() => {});
        },
        /** 修改按钮操作 */
        handleEditProduct(row) {
            let productId = 0;
            if (row != 0) {
                productId = row.productId || this.ids;
            }
            this.$router.push({
                path: '/iot/product-edit',
                query: {
                    productId: productId,
                    pageNum: this.queryParams.pageNum,
                },
            });
        },
        /** 设备授权操作 */
        handleDeviceAuthorize(row) {
            let productId = row.productId;
            this.$router.push({
                path: '/iot/product-edit',
                query: {
                    productId: productId,
                    tabPanelName: 'productAuthorize',
                    pageNum: this.queryParams.pageNum,
                },
            });
        },
    },
};
</script>

<style lang="scss" scoped>
.product_wrap {
    padding: 15px;
    min-height: 100vh;
    background-color: #f5f7fa !important;

    .toolbar {
        margin-bottom: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
}

.product-card {
    border-radius: 8px;
    // transition: all 0.3s;

    &:hover {
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
        border-color: #409eff;
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 12px;

        .product-name {
            cursor: pointer;
            font-weight: 600;
            font-size: 15px;
            color: #303133;
            display: flex;
            align-items: center;

            &:hover {
                color: #409eff;
            }
        }

        .header-status {
            flex-shrink: 0;
        }
    }

    .card-time {
        font-size: 12px;
        color: #909399;
        margin-bottom: 16px;
    }

    .card-info {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 12px;
        margin-bottom: 16px;

        .info-row {
            display: flex;
            flex-direction: column;

            .info-label {
                font-size: 12px;
                color: #909399;
                margin-bottom: 4px;
            }

            .info-value {
                font-size: 13px;
                color: #606266;
            }
        }
    }

    .card-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-top: 1px solid #f0f0f0;
        padding-top: 12px;

        .footer-left {
            i {
                font-size: 18px;
                color: #606266;
                cursor: pointer;
                transition: all 0.3s;

                &:hover {
                    color: #409eff;
                }
            }
        }

        .footer-actions {
            display: flex;
            align-items: center;
            gap: 12px;

            i {
                font-size: 18px;
                color: #606266;
                cursor: pointer;
                transition: all 0.3s;

                &:hover {
                    color: #409eff;
                }

                &.el-icon-delete:hover {
                    color: #f56c6c;
                }
            }
        }
    }
}
</style>
