<template>
    <div class='reacquire flex justify-center  blocks  cursor-pointer' :style="{ lineHeight: lineHeight }"
        @click="getData">
        <span>
             重新获取
        </span>
       
    </div>
</template>

<script>
export default {
    components: {},
    props: {
        lineHeight: {
            type: String,
            default: '200px'
        }
    },
    data() {
        return {

        };
    },
    computed: {},
    methods: {
        init() {
        },
        getData(e){
            this.$emit("onclick",e)
        }
    },
    created() {

    },
    mounted() {

    },
    beforeDestroy() {
    },
}
</script>

<style lang='scss' scoped>
.reacquire {

    user-select:none;
    color: rgb(168, 168, 168);
    span:hover{
        // color:$primary-color ;
        text-decoration: underline;
    }
}

.blocks {
    width: 100%;
    height: 100%;
}

.cursor-pointer {
    cursor: pointer;
}
</style>