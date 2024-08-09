<template>
    <div style="border: 0px solid #ebebeb; overflow: hidden; border-radius: 6px; background-color: #ebebeb; padding: 8px 5px 8px 0">
        <editor ref="codeEditor" v-model="currentContent" @init="editorInit" :options="options" :lang="lang" :theme="codeStyle" :width="width" :height="height" />
    </div>
</template>

<script>
// import { mapState } from 'vuex';

export default {
    name: 'AceEditor',
    components: {
        editor: require('vue2-ace-editor'),
    },
    props: {
        width: {
            type: String,
            default: '100%',
        },
        height: {
            type: String,
            default: '500px',
        },
        content: {
            type: String,
            required: true,
            default: () => null,
        },
        lang: {
            type: String,
            default: 'groovy',
        },
        readOnly: {
            type: Boolean,
            default: false,
        },
        codeStyle: {
            type: String,
            default: 'chrome',
        },
    },
    data() {
        return {
            options: {
                autoScrollEditorIntoView: true,
                // enableBasicAutocompletion: true,
                enableLiveAutocompletion: true,
                enableSnippets: true,
                // 只读
                readOnly: this.readOnly,
                // 显示打印边距线
                showPrintMargin: false,
                // 字体大小
                fontSize: 13,
            },
        };
    },
    computed: {
        // ...mapState({
        //   codeStyle: (state) => state.settings.codeStyle,
        //   codeSize: (state) => state.settings.codeSize,
        // }),
        currentContent: {
            get() {
                return this.content;
            },
            set(val) {
                this.$emit('update:content', val);
            },
        },
    },
    watch: {
        codeSize: {
            handler: function (value) {
                this.$refs.codeEditor.editor.setOptions({
                    fontSize: value,
                });
            },
            deep: true,
        },
    },
    created() {},
    mounted() {},
    methods: {
        editorInit(editor) {
            require('brace/ext/language_tools');
            require('brace/mode/groovy');
            require('brace/mode/mysql');
            require('brace/mode/json');
            require('brace/theme/chrome');
            require('brace/snippets/groovy');
            require('brace/snippets/json');
            require('brace/ext/beautify');
        },
        format() {
            const ace = require('brace');
            const editor = this.$refs.codeEditor.editor;
            const beautify = ace.acequire('ace/ext/beautify');
            beautify.beautify(editor.session);
        },
    },
};
</script>
