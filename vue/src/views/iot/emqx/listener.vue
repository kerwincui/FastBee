<template>
<div style="padding:6px;">
    <el-card style="padding-bottom:100px;">
        <el-table v-loading="loading" :data="listenerList">
            <el-table-column label="协议" align="center" prop="protocol" />
            <el-table-column label="监听地址" align="center" prop="listen_on"  />
            <el-table-column label="最大连接数" align="center" prop="max_conns" />
            <el-table-column label="当前连接数" align="center" prop="current_conns"/>            
            <el-table-column label="连接成功数" align="center" prop="acceptors" />
            <el-table-column label="账号错误数" align="center" prop="shutdown_count.bad_username_or_password" />
            <el-table-column label="功能错误数" align="center" prop="shutdown_count.function_clause" />
            <el-table-column label="SSL关闭数" align="center" prop="shutdown_count.ssl_closed" />
        </el-table>

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
import{listMqttListener} from "@/api/iot/emqx"


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
            listenerList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
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
            listMqttListener().then(response => {
                this.listenerList=response.data.data[0].listeners;
                console.log(response);
                this.loading = false;
            });
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },    
    }
};
</script>
