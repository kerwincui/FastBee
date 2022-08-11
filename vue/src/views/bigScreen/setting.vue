<template>
    <transition name="yh-setting-fade">
        <div class="setting" :class="{ settingShow: settingShow }" v-show="settingShow">
            <div class="setting_dislog" @click="settingShow = false">

            </div>
            <div class="setting_inner">
                <div class="setting_header">
                    设置
                </div>
                <div class="setting_body">
                    <!-- <div class="left_shu"> 实时监测</div> -->
                    <div class="left_shu"> 全局设置</div> 
                      <div class="setting_item">
                        <span class="setting_label">
                            是否进行自动适配<span class="setting_label_tip">(默认分辨率1920*1080)</span>: 
                        </span>
                        <div class="setting_content">
                            <el-radio-group v-model="isScaleradio" @change="(val) => radiochange(val, 'isScale')">
                                <el-radio :label="true">是</el-radio>
                                <el-radio :label="false">否</el-radio>
                            </el-radio-group>

                        </div>
                    </div>
                    <div class="left_shu"> 实时监测</div>
                    <div class="setting_item">
                        <span class="setting_label">
                            设备提醒自动轮询: <span class="setting_label_tip"></span>
                        </span>
                        <div class="setting_content">
                            <el-radio-group v-model="sbtxradio" @change="(val) => radiochange(val, 'sbtxSwiper')">
                                <el-radio :label="true">是</el-radio>
                                <el-radio :label="false">否</el-radio>
                            </el-radio-group>

                        </div>
                    </div>
                    <div class="setting_item">
                        <span class="setting_label">
                            实时预警轮播:
                        </span>
                        <div class="setting_content">
                            <el-radio-group v-model="ssyjradio" @change="(val) => radiochange(val, 'ssyjSwiper')">
                                <el-radio :label="true">是</el-radio>
                                <el-radio :label="false">否</el-radio>
                            </el-radio-group>
                        </div>
                    </div>
                    <div class="flex justify-center">
                        <!-- <el-button type="primary" round size="mini">确定</el-button> -->
                    </div>
                </div>
            </div>
        </div>
    </transition>
</template>

<script>

export default {
    components: {},
    data() {
        return {
            settingShow: false,
            sbtxradio:true,
            ssyjradio: true,
            isScaleradio:true,
        };
    },
    computed: {},
    methods: {
        init() {
            this.settingShow = true
        },
        radiochange(val, type) {
            this.$store.commit('setting/updateSwiper', { val, type })
            if(type==='isScale'){
                this.$router.go(0)
                // location.reload()
                // window.location.href=window.location.href+"?t="+Date.now()
            }
        },
    },
    created() {
        //this.$store.commit('setting/initSwipers')
        // this.sbtxradio = this.$store.state.settings.sbtxSwiper,
        // this.ssyjradio = this.$store.state.settings.ssyjSwiper,
        // this.isScaleradio = this.$store.state.settings.isScale;
    },
    mounted() {
        document.body.appendChild(this.$el);
    },
    beforeDestroy() {
    },
    destroyed() {
        if (this.$el && this.$el.parentNode) {
            this.$el.parentNode.removeChild(this.$el);
        }
    }
}
</script>

<style lang='scss' scoped>
</style>