<template>
<div style="padding:6px;">
    <el-card v-show="showSearch" style="margin-bottom:6px;">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item label="主题" prop="categoryName">
                <el-input v-model="queryParams.categoryName" placeholder="请输入主题" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom:100px;">
        <el-table v-loading="loading" :data="topicList">
            <el-table-column label="节点" align="center" prop="node" width="300"/>
            <el-table-column label="主题" align="left" prop="topic" />
        </el-table>

        <pagination v-show="total>0" :total="total" :page.sync="queryParams._page" :limit.sync="queryParams._limit" @pagination="getList" />

        <!-- 添加或修改产品分类对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-form ref="form" :model="form" label-width="80px">
                <el-form-item label="分类名称" prop="categoryName">
                    <el-input v-model="form.categoryName" placeholder="请输入产品分类名称" />
                </el-form-item>
                <el-form-item label="显示顺序" prop="orderNum">
                    <el-input v-model="form.orderNum" placeholder="请输入显示顺序" />
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="cancel">确 定</el-button>
                <el-button @click="cancel">取 消</el-button>
            </div>
        </el-dialog>

    </el-card>
</div>
</template>

<script>
import{listMqttTopic} from "@/api/iot/emqx"


export default {
    name: "Category",
    data() {
        return {
            // 遮罩层
            loading: true,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 列表
            topicList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                _limit: 10,
                _page: 1,
            },
            // 表单参数
            form: {},
        };
    },
    created() {
        this.getList();
        
    },
    methods: {
        /** 查询客户端列表 */
        getList() {
            this.loading = true;
            listMqttTopic(this.queryParams).then(response => {
                this.topicList=response.data.data;
                this.total=response.data.meta.count;
                this.loading = false;
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
    }
};
</script>
