<template>
    <transition name="yh-setting-fade">
        <div class="setting" :class="{ settingShow: settingShow }" v-show="settingShow">
            <div class="setting_dislog" @click="settingShow = false">

            </div>
            <div class="setting_inner">
                <div class="setting_header">
                    {{ $t('bigScreen.setting.settings') }}
                </div>
                <div class="setting_body">
                    <!-- <div class="left_shu"> 实时监测</div> -->
                    <div class="left_shu"> {{ $t('bigScreen.setting.globalSettings') }}</div>
                      <div class="setting_item">
                        <span class="setting_label">
                            {{ $t('bigScreen.setting.autoAdapt') }}<span class="setting_label_tip">({{ $t('bigScreen.setting.defaultResolution') }}1920*1080)</span>:
                        </span>
                        <div class="setting_content">
                            <el-radio-group v-model="isScaleradio" @change="(val) => radiochange(val, 'isScale')">
                                <el-radio :label="true">{{ $t('bigScreen.setting.yes') }}</el-radio>
                                <el-radio :label="false">{{ $t('bigScreen.setting.no') }}</el-radio>
                            </el-radio-group>

                        </div>
                    </div>
                    <div class="left_shu"> {{ $t('bigScreen.setting.realTimeMonitor') }}</div>
                    <div class="setting_item">
                        <span class="setting_label">
                            {{ $t('bigScreen.setting.deviceAlertAutoPoll') }}: <span class="setting_label_tip"></span>
                        </span>
                        <div class="setting_content">
                            <el-radio-group v-model="sbtxradio" @change="(val) => radiochange(val, 'sbtxSwiper')">
                                <el-radio :label="true">{{ $t('bigScreen.setting.yes') }}</el-radio>
                                <el-radio :label="false">{{ $t('bigScreen.setting.no') }}</el-radio>
                            </el-radio-group>

                        </div>
                    </div>
                    <div class="setting_item">
                        <span class="setting_label">
                            {{ $t('bigScreen.setting.realTimeWarning') }}:
                        </span>
                        <div class="setting_content">
                            <el-radio-group v-model="ssyjradio" @change="(val) => radiochange(val, 'ssyjSwiper')">
                                <el-radio :label="true">{{ $t('bigScreen.setting.yes') }}</el-radio>
                                <el-radio :label="false">{{ $t('bigScreen.setting.no') }}</el-radio>
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