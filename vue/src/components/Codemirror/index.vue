<template>
  <div class="json-editor">
    <textarea ref="textarea" />
  </div>
</template>

<script>
// import sqlFormatter from "sql-formatter";
import CodeMirror from "codemirror";
import "codemirror/lib/codemirror.css";
import "codemirror/mode/sql/sql.js";
// 替换主题这里需修改名称
import "codemirror/theme/idea.css";
// 支持代码自动补全
import "codemirror/addon/hint/show-hint.css";
import "codemirror/addon/hint/show-hint.js";
import "codemirror/addon/hint/anyword-hint.js";

// JSON代码高亮需要由JavaScript插件支持
import "codemirror/mode/javascript/javascript.js";

// 支持各种代码折叠
import "codemirror/addon/fold/foldgutter.css";
import "codemirror/addon/fold/foldcode.js";
import "codemirror/addon/fold/foldgutter.js";
import "codemirror/addon/fold/brace-fold.js";
import "codemirror/addon/fold/comment-fold.js";

// 支持括号自动匹配
import "codemirror/addon/edit/matchbrackets.js";
import "codemirror/addon/edit/closebrackets.js";

// 行注释
import "codemirror/addon/comment/comment.js";
// JSON错误检查
import "codemirror/addon/lint/lint.css";
import "codemirror/addon/lint/lint.js";

export default {
  props: {
    value: '',
    height: {
      type: String,
      required: true,
    },
    myMode: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      editor: false,
    };
  },
  watch: {
    value(value) {
      const editorValue = this.editor.getValue();
      if (value !== editorValue) {
        if (typeof this.value !== "undefined") {
          this.editor.setValue(this.value);
        } else {
          this.editor.setValue("");
        }
      }
    },
  },
  mounted() {
    this.editor = CodeMirror.fromTextArea(this.$refs.textarea, {
      mode: this.myMode, //语言
      smartIndent: true, // 是否智能缩进
      styleActiveLine: true, // 当前行高亮
      lineNumbers: true, // 是否显示行数
      indentUnit: 2, // 缩进单位，默认2
      gutters: [
        "CodeMirror-linenumbers",
        "CodeMirror-foldgutter",
        "CodeMirror-lint-markers", // CodeMirror-lint-markers是实现语法报错功能
      ],
      lint: true,
      //lineWrapping: true, // 自动换行
      matchBrackets: true, // 括号匹配显示
      autoCloseBrackets: true, // 输入和退格时成对
      readOnly: false, // 只读
      foldGutter: true,
      autoRefresh: true,
    });
    //代码自动提示功能，记住使用cursorActivity事件不要使用change事件，这是一个坑，那样页面直接会卡死
    this.editor.on("inputRead", () => {
      this.editor.showHint();
    });
    this.editor.setSize("auto", this.height);
    if (typeof this.value !== "undefined") {
      this.editor.setValue(this.value);
    } else {
      this.editor.setValue("");
    }
  },
  methods: {
    getValue() {
      return this.editor.getValue();
    },
    // formatSql() {
    //   /*（sql编辑器内容绑定content参数） 将sql内容进行格式后放入编辑器中*/
    //   this.content = sqlFormatter.format(this.content);
    // },
  },
};
</script>

<style scoped>
.json-editor {
  height: 100%;
}

.json-editor >>> .CodeMirror {
  font-size: 14px;
  /* overflow-y:auto; */
  font-weight: normal;
}

.json-editor >>> .CodeMirror-scroll {
}

.json-editor >>> .cm-s-rubyblue span.cm-string {
  color: #f08047;
}
</style>
