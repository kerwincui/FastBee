<template>
<div style="padding:6px;">
    <el-card style="padding-bottom:100px;">
        <el-table v-loading="loading" :data="pluginList">
            <el-table-column label="插件名称" align="center" prop="name" width="300" />
            <el-table-column label="版本" align="center" prop="version" width="100" />
            <el-table-column label="类型" align="center" prop="type" width="120" />
            <el-table-column label="状态" align="center" prop="active" width="150">
                <template slot-scope="scope">
                    <el-tag type="success" v-if="scope.row.active">运行中</el-tag>
                    <el-tag type="info" v-else>已停止</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="描述" align="left" prop="description" />
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
                <template slot-scope="scope">
                    <el-button size="small" type="success" style="padding:5px;" @click="loadMqttPlugin(scope.row.name)" v-if="!scope.row.active" v-hasPermi="['iot:emqx:edit']">
                        <svg-icon icon-class="start" /> 启动
                    </el-button>
                    <el-button size="small" type="danger" style="padding:5px;" 
                        @click="unloadMqttPlugin(scope.row.name)" 
                        v-hasPermi="['iot:emqx:edit']" 
                        v-if="scope.row.active" 
                        :disabled="scope.row.name=='emqx_auth_http' || scope.row.name=='emqx_web_hook'  || scope.row.name=='emqx_rule_engine' || scope.row.name=='emqx_management'">
                        <svg-icon icon-class="stop" /> 停止
                    </el-button>
                </template>
            </el-table-column>
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
import {
    listMqttPlugin,
    loadMqttPlugin,
    unloadMqttPlugin
} from "@/api/iot/emqx"

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
            pluginList: [],
            // 节点名称
            node: "",
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
            listMqttPlugin().then(response => {
                this.pluginList = response.data.data[0].plugins;
                this.node = response.data.data[0].node;
                this.loading = false;
            });
        },
        /** 启用插件*/
        loadMqttPlugin(plugin) {
            this.$confirm('是否启用插件：' + plugin + ' ?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                loadMqttPlugin(this.node, plugin).then(response => {
                    if (response.data.code == 0) {
                        this.getList();
                        this.$message({
                            type: 'success',
                            message: '成功启用插件!'
                        });
                    }
                })
            }).catch(() => {});
        },
        /** 卸载插件*/
        unloadMqttPlugin(plugin) {
            this.$confirm('是否停止插件：' + plugin + ' ?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                unloadMqttPlugin(this.node, plugin).then(response => {
                    if (response.data.code == 0) {
                        this.getList();
                        this.$message({
                            type: 'success',
                            message: '成功停止插件!'
                        });
                    }
                })
            }).catch(() => {});
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },
    }
};
</script>
