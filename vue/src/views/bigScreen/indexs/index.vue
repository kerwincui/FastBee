<template>
<div class="contents">
    <div class="contetn_left">
        <div class="pagetab">
            <dv-decoration-12 style="width:30px;height:30px;" />
            <div class="item">实时监测数据</div>
        </div>
        <ItemWrap class="contetn_left-top contetn_lr-item" title="设备总览">
            <LeftTop />

        </ItemWrap>
        <ItemWrap class="contetn_left-center contetn_lr-item" title="Mqtt统计">
            <LeftCenter />
        </ItemWrap>
        <ItemWrap class="contetn_left-bottom contetn_lr-item" title="监测数据" style="padding: 0 10px 16px 10px">
            <LeftBottom />
        </ItemWrap>
    </div>
    <div class="contetn_center">
        <CenterMap class="contetn_center_top" />
        <ItemWrap class="contetn_center-bottom" title="服务器信息">
            <CenterBottom />
        </ItemWrap>
    </div>
    <div class="contetn_right">
        <ItemWrap class="contetn_left-bottom contetn_lr-item" title="Mqtt状态">
            <RightTop />
        </ItemWrap>
        <ItemWrap class="contetn_left-bottom contetn_lr-item" title="Mqtt消息" style="padding: 0 10px 16px 10px">
            <RightCenter />
        </ItemWrap>
        <ItemWrap class="contetn_left-bottom contetn_lr-item" title="设备提醒 ">
            <RightBottom />
        </ItemWrap>
    </div>
</div>
</template>

<script>
import LeftTop from './left-top.vue'
import LeftCenter from "./left-center.vue";
import LeftBottom from "./left-bottom.vue";
import CenterMap from "./center-map.vue";
import CenterBottom from "./center-bottom.vue";
import RightTop from "./right-top.vue";
import RightCenter from "./right-center.vue";
import RightBottom from "./right-bottom.vue";

export default {
    components: {
        LeftTop,
        LeftCenter,
        LeftBottom,
        CenterMap,
        RightTop,
        RightCenter,
        RightBottom,
        CenterBottom,
    },
    data() {
        return {

        };
    },
    filters: {
        numsFilter(msg) {
            return msg || 0;
        },
    },
    created() {},

    mounted() {},
    methods: {

    },
};
</script>

<style lang="scss" scoped>
// 内容
.contents {

    .contetn_left,
    .contetn_right {
        width: 500px;
        box-sizing: border-box;
        // padding: 16px 0;
    }

    .contetn_center {
        width: 800px;
    }

    //左右两侧 三个块
    .contetn_lr-item {
        height: 310px;
    }

    .contetn_center_top {
        width: 100%;
    }

    // 中间
    .contetn_center {
        display: flex;
        flex-direction: column;
        justify-content: space-around;
    }

    .contetn_center-bottom {
        height: 255px;
    }

    //左边 右边 结构一样
    .contetn_left,
    .contetn_right {
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        position: relative;

    }
}

@keyframes rotating {
    0% {
        -webkit-transform: rotate(0) scale(1);
        transform: rotate(0) scale(1);
    }

    50% {
        -webkit-transform: rotate(180deg) scale(1.1);
        transform: rotate(180deg) scale(1.1);
    }

    100% {
        -webkit-transform: rotate(360deg) scale(1);
        transform: rotate(360deg) scale(1);
    }
}
</style>
