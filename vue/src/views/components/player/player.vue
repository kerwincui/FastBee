<template>
    <div class="root">
        <div class="container-shell">
            <div id="container" ref="container"></div>
        </div>
    </div>
</template>

<script>
let jessibucaPlayer = {};
import { ptzdirection, ptzscale } from '@/api/iot/sipdevice';

export default {
    name: 'player',
    props: {
        playerinfo: {
            type: Object,
            default: null,
        },
    },
    mounted() {
        console.log(this._uid);
    },
    watch: {
        playerinfo: function (newVal, oldVal) {
            console.log('playerinfo 发生变化');
            this.playinfo = newVal;
            if (this.playinfo && this.playinfo.playtype !== '') {
                this.playtype = this.playinfo.playtype;
            }
        },
    },
    jessibuca: null,
    data() {
        return {
            isPlaybackPause: false,
            useWebGPU: false,
            isInit: false,
            playinfo: {},
            playtype: 'play',
            operateBtns: {
                fullscreen: true,
                zoom: true,
                play: true,
                audio: true,
            },
        };
    },
    beforeDestroy() {},
    created() {
        this.playinfo = this.playerinfo;
        if (this.playinfo && this.playinfo.playtype !== '') {
            this.playtype = this.playinfo.playtype;
        }
        this.init();
    },
    methods: {
        init() {
            var isSupportWebgpu = 'gpu' in navigator;
            if (isSupportWebgpu) {
                console.log('支持webGPU');
                this.useWebGPU = true;
            } else {
                console.log('暂不支持webGPU，降级到webgl渲染');
                this.useWebGPU = false;
            }

            const useVconsole = this.isMobile() || this.isPad();
            if (useVconsole && window.VConsole) {
                new window.VConsole();
            }
            this.$nextTick(() => {
                this.initplayer();
            });
        },
        initplayer() {
            this.isPlaybackPause = false;
            this.initconf();
            jessibucaPlayer[this._uid] = new window.JessibucaPro({
                container: this.$refs.container,
                decoder: '/js/jessibuca-pro/decoder-pro.js',
                videoBuffer: Number(0.2), // 缓存时长
                isResize: false,
                useWCS: false,
                useMSE: false,
                useSIMD: true,
                wcsUseVideoRender: false,
                loadingText: '加载中',
                debug: false,
                debugLevel: 'debug',
                showBandwidth: true, // 显示网速
                showPlaybackOperate: true,
                operateBtns: this.operateBtns,
                forceNoOffscreen: true,
                isNotMute: true, // 默认关闭声音
                showPerformance: false,
                // playFailedAndReplay: true,
                // networkDelayTimeoutReplay: true,
                playbackForwardMaxRateDecodeIFrame: 4,
                useWebGPU: this.useWebGPU, // 使用WebGPU
            });
            let jessibuca = jessibucaPlayer[this._uid];
            this.initcallback(jessibuca);
            this.isInit = true;
        },
        initconf() {
            if (this.playtype === 'play') {
                //直播按钮配置
                this.operateBtns.ptz = true;
            } else {
                //录像回放按钮配置
                this.operateBtns.ptz = false;
            }
        },
        initcallback(jessibuca) {
            const _this = this;
            jessibuca.on('error', function (error) {
                console.log('jessibuca error');
                console.log(error);
                //_this.destroy();
            });
            jessibuca.on('playFailedAndPaused', function (reason, lastFrameInfo, msg) {
                console.log('playFailedAndPaused', reason, msg);
                // lastFrameInfo 是最后一帧的画面，可以用来重播的时候，显示最后一帧画面。
                // msg 具体的错误信息。
            });
            jessibuca.on('visibilityChange', (value) => {
                if (value === true) {
                    // 窗口显示
                    console.log('visibilityChange true');
                } else {
                    // 窗口隐藏
                    console.log('visibilityChange false');
                }
            });
            jessibuca.on('pause', function (pause) {
                console.log('pause success!');
                console.log(pause);
            });
            jessibuca.on('play', function (flag) {
                console.log('play!');
                console.log(flag);
            });
            jessibuca.on('loading', function (load) {
                console.log('loading success!');
                console.log(load);
            });
            jessibuca.on('stats', function (s) {
                console.log('stats is', s);
            });
            jessibuca.on('timeout', function (error) {
                console.log('timeout:', error);
            });
            jessibuca.on('playbackPreRateChange', (rate) => {
                jessibuca.forward(rate);
            });

            let pre = 0;
            let cur = 0;
            jessibuca.on('timeUpdate', function (ts) {
                cur = parseInt(ts / 60000);
                if (pre !== cur) {
                    pre++;
                }
            });
            jessibuca.on(JessibucaPro.EVENTS.ptz, (arrow) => {
                console.log('ptz arrow', arrow);
                _this.handlePtz(arrow);
            });
            jessibuca.on('crashLog', (data) => {
                console.log('crashLog is', data);
            });
        },
        registercallback(events, func) {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].on(events, func);
            }
        },
        isMobile() {
            return /iphone|ipad|android.*mobile|windows.*phone|blackberry.*mobile/i.test(window.navigator.userAgent.toLowerCase());
        },
        isPad() {
            return /ipad|android(?!.*mobile)|tablet|kindle|silk/i.test(window.navigator.userAgent.toLowerCase());
        },
        play(url) {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].play(url);
            }
        },
        pause() {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].pause();
            }
        },
        replay(url) {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].destroy().then(() => {
                    this.initplayer();
                    this.play(url);
                });
            } else {
                this.initplayer();
                this.play(url);
            }
        },
        handlePtz(arrow) {
            let leftRight = 0;
            let upDown = 0;
            if (arrow === 'left') {
                leftRight = 2;
            } else if (arrow === 'right') {
                leftRight = 1;
            } else if (arrow === 'up') {
                upDown = 1;
            } else if (arrow === 'down') {
                upDown = 2;
            }
            var data = {
                leftRight: leftRight,
                upDown: upDown,
                moveSpeed: 125,
            };
            if (this.playinfo && this.playinfo.playtype !== '') {
                ptzdirection(this.playinfo.deviceId, this.playinfo.channelId, data).then(async (response) => {
                    //console.log("云台方向控制：" + JSON.stringify(response));
                });
            }
        },
        playback(url, playTimes) {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].playback(url, {
                    playList: playTimes,
                    fps: 25, //FPS（定频(本地设置)生效）
                    showControl: true,
                    isUseFpsRender: true, // 是否使用固定的fps渲染，如果设置的fps小于流推过来的，会造成内存堆积甚至溢出
                    isCacheBeforeDecodeForFpsRender: false, // rfs渲染时，是否在解码前缓存数据
                    supportWheel: true, // 是否支持滚动轴切换精度。
                });
                this.isPlaybackPause = false;
            }
        },
        playbackPause() {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].playbackPause();
                this.isPlaybackPause = true;
            }
        },
        replayback(url, playTimes) {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].destroy().then(() => {
                    this.initplayer();
                    this.playback(url, playTimes);
                });
            } else {
                this.initplayer();
                this.playback(url, playTimes);
            }
        },
        setPlaybackStartTime(curTime) {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].setPlaybackStartTime(curTime);
            }
        },
        destroy() {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].destroy().then(() => {
                    this.initplayer();
                });
            }
        },
        close() {
            if (jessibucaPlayer[this._uid]) {
                jessibucaPlayer[this._uid].close();
            }
        },
    },
};
</script>

<style scoped lang="scss">
.root {
    display: flex;
    margin-right: 3rem;
}

.container-shell {
    backdrop-filter: blur(5px);
    // background: hsla(0, 0%, 50%, 0.5);
    //background: #fff;
    //padding: 10px 4px 10px 4px;
    /* border: 2px solid black; */
    // width: auto;
    position: relative;
    border-radius: 10px;
    // box-shadow: 0 5px 5px;
}

.container-shell:before {
    //content: "设备播放器";
    position: absolute;
    color: darkgray;
    //top: 4px;
    left: 10px;
    //text-shadow: 1px 1px black;
}

#container {
    background: rgba(13, 14, 27, 0.7);
    width: 1000px;
    height: 630px;
    border-radius: 5px;
}

.err {
    position: absolute;
    top: 40px;
    left: 10px;
    color: red;
}

.option {
    position: absolute;
    top: 4px;
    right: 10px;
    display: flex;
    place-content: center;
    font-size: 12px;
}

.option span {
    color: white;
}

@media (max-width: 720px) {
    #container {
        width: 90vw;
        height: 52.7vw;
    }
}
</style>
