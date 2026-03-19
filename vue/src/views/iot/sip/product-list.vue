<template>
    <el-dialog :title="$t('sip.product-list.998536-0')" :visible.sync="open" width="600px" append-to-body>
        <div style="margin-top: -55px">
            <el-divider style="margin-top: -30px"></el-divider>
            <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
                <el-form-item :label="$t('product.index.671004-0')" prop="productName">
                    <el-input v-model="queryParams.productName" :placeholder="$t('product.index.671004-1')" clearable size="small" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>

            <el-table v-loading="loading" ref="singleTable" :data="productList" @row-click="rowClick" highlight-current-row size="mini">
                <el-table-column :label="$t('sip.index.998533-18')" width="50" align="center">
                    <template slot-scope="scope">
                        <input type="radio" :checked="scope.row.isSelect" name="product" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('product.index.671004-0')" align="center" prop="productName" />
                <el-table-column :label="$t('product.index.671004-6')" align="center" prop="categoryName" />
                <el-table-column :label="$t('sip.product-list.998536-1')" align="center" prop="tenantName" />
                <el-table-column :label="$t('sip.product-list.998536-2')" align="center" prop="networkMethod">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.iot_network_method" :value="scope.row.networkMethod" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('creatTime')" align="center" prop="createTime" width="100">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                    </template>
                </el-table-column>
            </el-table>

            <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
        </div>
        <div slot="footer" class="dialog-footer">
            <el-button @click="confirmSelectProduct" type="primary">{{ $t('confirm') }}</el-button>
            <el-button @click="closeDialog" type="info">{{ $t('close') }}</el-button>
        </div>
    </el-dialog>
</template>

<script>
import { listProduct } from '@/api/iot/product';

export default {
    name: 'SipProductList',
    dicts: ['iot_vertificate_method', 'iot_network_method'],
    props: {
        productId: {
            type: Number,
            default: 0,
        },
    },
    data() {
        return {
            // 遮罩层
            loading: true,
            // 总条数
            total: 0,
            // 打开选择产品对话框
            open: false,
            // 产品列表
            productList: [],
            // 选中的产品
            product: null,
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
                status: 2, //已发布
                deviceType: 3, // 监控设备
                networkMethod: null,
            },
        };
    },
    created() {},
    methods: {
        /** 查询产品列表 */
        getList() {
            this.loading = true;
            listProduct(this.queryParams).then((response) => {
                //产品列表初始化isSelect值，用于单选
                for (let i = 0; i < response.rows.length; i++) {
                    response.rows[i].isSelect = false;
                }
                this.productList = response.rows;
                this.total = response.total;
                if (this.productId != 0) {
                    this.setRadioSelected(this.productId);
                }
                this.loading = false;
            });
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
        /** 单选数据 */
        rowClick(product) {
            if (product != null) {
                this.setRadioSelected(product.productId);
                this.product = product;
            }
        },
        /** 设置单选按钮选中 */
        setRadioSelected(productId) {
            for (let i = 0; i < this.productList.length; i++) {
                if (this.productList[i].productId == productId) {
                    this.productList[i].isSelect = true;
                } else {
                    this.productList[i].isSelect = false;
                }
            }
        },
        /**确定选择产品，产品传递给父组件 */
        confirmSelectProduct() {
            if (this.product == null) {
                this.$message.error(this.$t('sip.index.998533-17'));
                return;
            }
            this.$emit('productEvent', this.product);
            this.open = false;
            this.product = null;
        },
        /**关闭对话框 */
        closeDialog() {
            this.open = false;
        },
    },
};
</script>
