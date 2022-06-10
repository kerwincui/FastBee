<template>
<el-dialog title="选择用户" :visible.sync="openSelectUser" width="800px">
    <div style="margin-top:-50px;">
        <el-divider></el-divider>
    </div>
    <!--用户数据-->
    <el-form :model="queryParams" ref="queryForm" :rules="rules" :inline="true" label-width="80px">
        <el-form-item label="手机号码" prop="phonenumber">
            <el-input type="text" placeholder="请输入用户手机号码" v-model="queryParams.phonenumber" minlength="10" clearable size="small" show-word-limit style="width: 240px" @keyup.enter.native="handleQuery"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">查询</el-button>
        </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="userList" highlight-current-row size="mini" @current-change="handleCurrentChange" border>
        <el-table-column label="选择" width="50" align="center">
            <template slot-scope="scope">
                <input type="radio" :checked="scope.row.isSelect" name="user" />
            </template>
        </el-table-column>
        <el-table-column label="用户编号" align="center" key="userId" prop="userId" width="120" />
        <el-table-column label="用户名称" align="center" key="userName" prop="userName"  />
        <el-table-column label="用户昵称" align="center" key="nickName" prop="nickName" />
        <el-table-column label="手机号码" align="center" key="phonenumber" prop="phonenumber" width="120" />
        <el-table-column label="创建时间" align="center" prop="createTime" width="160">
            <template slot-scope="scope">
                <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
        </el-table-column>

    </el-table>
    <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="addDeviceUser">分享</el-button>
        <el-button @click="closeSelectUser">关 闭</el-button>
    </div>
</el-dialog>
</template>

<script>
import {
    listUser
} from "@/api/iot/tool";
import {
    addDeviceUser,
    addDeviceUsers,
} from "@/api/iot/deviceuser";

export default {
    name: "user-list",
    props: {
        device: {
            type: Array,
            default: null
        }
    },
    watch: {
        // 获取到父组件传递的device
        device: function (newVal, oldVal) {
            this.deviceInfo = newVal;
        }
    },
    data() {
        return {
            // 遮罩层
            loading: false,
            // 选中数组
            ids: [],
            // 弹出层标题
            title: "",
            // 用户列表
            userList: [],
            // 选中的用户
            user: {},
            // 设备信息
            deviceInfo: {},
            // 是否显示选择用户弹出层
            openSelectUser: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                userName: undefined,
                phonenumber: undefined,
                status: 0,
                deptId: undefined
            },
            // 表单校验
            rules: {
                phonenumber: [{
                    required: true,
                    message: "手机号码不能为空",
                    trigger: "blur"
                }, {
                    min: 11,
                    max: 11,
                    message: '手机号码长度为11位',
                    trigger: 'blur'
                }],
            },
        };
    },
    created() {},
    methods: {
        /** 查询用户列表 */
        getList() {
            this.loading = true;
            listUser(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
                this.userList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.$refs["queryForm"].validate(valid => {
                if (valid) {
                    this.queryParams.pageNum = 1;
                    this.getList();
                }
            });

        },
        // 重置查询
        resetQuery() {
            this.$refs["queryForm"].resetFields();
            this.userList = [];
        },
        //设置单选按钮选中
        setRadioSelected(userId) {
            for (let i = 0; i < this.userList.length; i++) {
                if (this.userList[i].userId == userId) {
                    this.userList[i].isSelect = true;
                    this.user = this.userList[i];
                } else {
                    this.userList[i].isSelect = false;
                }
            }
        },
        // 单选数据
        handleCurrentChange(user) {
            if (user != null) {
                this.setRadioSelected(user.userId);
                this.user = user;
            }
        },
        // 关闭选择用户
        closeSelectUser() {
            this.openSelectUser = false;
            this.resetQuery();
        },
        // 添加设备用户
        addDeviceUser() {
            if (this.deviceInfo != null && this.deviceInfo.length > 0 && this.user != null) {
                if (this.deviceInfo.length == 1) {
                    var form = {};
                    form.deviceId = this.deviceInfo[0].deviceId;
                    form.deviceName = this.deviceInfo[0].deviceName;
                    form.userId = this.user.userId;
                    form.userName = this.user.userName;
                    form.phonenumber=this.user.phonenumber;
                    addDeviceUser(form).then(response => {
                        this.$modal.msgSuccess("新增成功");
                        this.resetQuery();
                        this.openSelectUser = false;
                        this.$parent.getList();
                    });
                } else {
                    var form = [];
                    this.deviceInfo.forEach(device => {
                        let data = {};
                        data.deviceId = device.deviceId;
                        data.deviceName = device.deviceName
                        data.userId = this.user.userId;
                        data.userName = this.user.userName;
                        data.phonenumber=this.user.phonenumber;
                        form.push(data);
                    });

                    addDeviceUsers(form).then(response => {
                        this.$modal.msgSuccess("新增成功");
                        this.resetQuery();
                        this.openSelectUser = false;
                        this.$parent.getList();
                    });

                }
            } else {
                this.openSelectUser = false;
            }
        },
    }
};
</script>
