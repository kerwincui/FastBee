<template>
<div v-if="pageflag" style="overflow:hidden;width: 100%;height:250px;font-size:12px;line-height:24px;">
    <vue-seamless-scroll :data="deviceLogList" :class-option="defaultOption">
        <div style="display:flex;margin-bottom:10px;border-bottom:2px dashed #23cdd8;color:#bbb;" v-for="(item, i) in deviceLogList" :key="i">
            <span style="width:50px;color:#23cdd8;font-size:16px;line-height:48px;font-weight:bolder;">{{ i + 1 }}</span>
            <div style="display:flex;flex-wrap: wrap;">
                <div style="width:200px;">
                    <span>设备编号：</span>
                    <span style="color:#23cdd8">{{ item.serialNumber }}</span>
                </div>
                <div style="width:150px;white-space: nowrap;overflow:hidden;text-overflow:ellipsis;">
                    <span>标识符：</span>
                    <span style="color:#fff;">{{item.identify}}</span>
                </div>
                <div style="width:60px;align-items: flex-end;text-align: right;">
                    <span style="color:#ffdb5c">编码：{{ item.resultCode }}</span>
                </div>
                <div style="width:200px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
                    <span>上报时间：</span>
                    <span style="color:#fff;">{{ item.createTime }}</span>
                </div>
                <div style="margin-bottom:10px;width:210px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
                    <span>上报值：</span>
                    <span style="color:#fff;">{{item.funValue }}</span>
                </div>
            </div>
        </div>
    </vue-seamless-scroll>
</div>

<Reacquire v-else @onclick="getData" style="line-height:200px;color:#23cdd8;margin-left:210px;">
    重新获取
</Reacquire>
</template>

<script>
import vueSeamlessScroll from "vue-seamless-scroll";
import {
    listLog,
    getLog,
    delLog,
    addLog,
    updateLog
} from "@/api/iot/functionLog";
export default {
    components: {
        vueSeamlessScroll,
    },
    data() {
        return {
            deviceLogList: [],
            pageflag: true,
            defaultOption: {
                step: 2,
                limitMoveNum: 4,
                hoverStop: true,
                singleHeight: 280,
                openWatch: true,
                waitTime: 3000,
            },
            queryParams: {
                pageNum: 1,
                pageSize: 5,
            },
        };
    },
    created() {
        this.getData();
    },
    beforeDestroy() {
        this.clearData()
    },
    methods: {
        getData() {
            listLog(this.queryParams).then(response => {
              this.deviceLogList = response.rows;
              // 轮询
              this.switper()
            });
        },
        clearData() {
            if (this.timer) {
                clearInterval(this.timer)
                this.timer = null
            }
        },
        //轮询
        switper() {
            if (this.timer) {
                return
            }
            let looper = (a) => {
                this.getData()
            };
            this.timer = setInterval(looper, 60000);
        },
    },
};
</script>
