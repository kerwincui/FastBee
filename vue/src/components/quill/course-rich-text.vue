<template>
  <div>
    <div style="margin-bottom: 50px;">
      <quill-editor
        :content="content"
        ref="myQuillEditor"
        :options="editorOption"
        @focus="onEditorFocus($event)"
        @blur="onEditorBlur($event)"
        @change="onEditorChange($event)"
        class="editor"
      ></quill-editor>

      <!--自定义图片上传,写一个form表单,然后form表单中隐藏一个input标签,type为file属性.当我们的自定义图片处理函数被点击时,进行触发打开文件选择框,选择文件后触发uploadImg方法,
      最后调用图片上传的接口,返回图片在服务器的地址之后,回显于当前富文本中 -->
      <form action method="post" enctype="multipart/form-data" id="uploadFormMulti">
        <input
          style="display: none"
          :id="uniqueId"
          type="file"
          name="file"
          multiple
          accept="image/jpg, image/jpeg, image/png, image/gif"
          @change="uploadImg('uploadFormMulti')"
        />
      </form>
    </div>
  </div>
</template>

<script>
//引入quill样式
import "quill/dist/quill.core.css";
import "quill/dist/quill.snow.css";
import "quill/dist/quill.bubble.css";
//引入quillEditor编辑器模块,引入Quill模块
import {quillEditor, Quill} from "vue-quill-editor";
//引入图片缩放插件,需要依赖Quill模块
import ImageResize from 'quill-image-resize-module'
//引入图片拖拽插件,需要依赖Quill模块
import {ImageDrop} from "quill-image-drop-module"
//注册插件
Quill.register('modules/imageResize', ImageResize)
Quill.register('modules/imageDrop', ImageDrop)
//按钮多为图标显示，用户使用起来不能清楚明白功能按钮的作用,给工具栏按钮添加鼠标停留提示的交互
import {addQuillTitle} from './quill-title.js'
// //自定义上传图片api
import { uploadBasketPic } from "@/api/news/news";

// 工具栏配置
const toolbarOptions = [
  ["bold", "italic", "underline", "strike"], // 加粗 斜体 下划线 删除线 -----['bold', 'italic', 'underline', 'strike']
  ["blockquote", "code-block"], // 引用  代码块-----['blockquote', 'code-block']
  [{header: 1}, {header: 2}], // 1、2 级标题-----[{ header: 1 }, { header: 2 }]
  [{list: "ordered"}, {list: "bullet"}], // 有序、无序列表-----[{ list: 'ordered' }, { list: 'bullet' }]
  [{script: "sub"}, {script: "super"}], // 上标/下标-----[{ script: 'sub' }, { script: 'super' }]
  [{indent: "-1"}, {indent: "+1"}], // 缩进-----[{ indent: '-1' }, { indent: '+1' }]
  [{direction: "rtl"}], // 文本方向-----[{'direction': 'rtl'}]
  [{size: ["small", false, "large", "huge"]}], // 字体大小-----[{ size: ['small', false, 'large', 'huge'] }]
  [{header: [1, 2, 3, 4, 5, 6, false]}], // 标题-----[{ header: [1, 2, 3, 4, 5, 6, false] }]
  [{color: []}, {background: []}], // 字体颜色、字体背景颜色-----[{ color: [] }, { background: [] }]
  [{font: []}], // 字体种类-----[{ font: [] }]
  [{align: []}], // 对齐方式-----[{ align: [] }]
  ["clean"], // 清除文本格式-----['clean']
  ["image", "video", 'link'] // 链接、图片、视频-----['link', 'image', 'video']
];

export default {
  components: {
    quillEditor
  },
  props: {
    //接收父组件的参数
    value: null,
  },
  mixins: [],
  computed: {
    //当前富文本实例
    editor() {
      return this.$refs.myQuillEditor.quill;
    }
  },

  watch: {
    value(val = '') {
      //监听父组件参数变化,回显到富文本框
      this.content = val;
    },
  },

  data() {
    return {
      // uploadUrl: process.env.VUE_APP_BASE_API + "/common/upload", // 上传的图片服务器地址
      content: this.value || '',
      uniqueId: "uniqueId",
      editorOption: {          //  富文本编辑器配置
        modules: {  //模块配置
          toolbar: toolbarOptions, //设置工具栏
          imageResize: {            //图片缩放配置
            displayStyles: {
              backgroundColor: "black",
              border: "none",
              color: "white"
            },
            modules: ["Resize", "DisplaySize", "Toolbar"]
          },
          imageDrop: false,       //图片拖拽配置,false为开启拖拽,true关闭拖拽1
        },
        theme: "snow",  //主题配置
        placeholder: "请输入正文"
      }
    }
  },
  methods: {
    // 准备富文本编辑器
    onEditorReady(quill) {

    },
    // 富文本编辑器 失去焦点事件
    onEditorBlur(quill) {

    },
    // 富文本编辑器 获得焦点事件
    onEditorFocus(quill) {

    },
    // 富文本编辑器 内容改变事件
    onEditorChange({quill, html, text}) {
      //将内容提交给父组件的change事件
      this.$emit('change', html)
    },


    //自定义上传图片方法
    uploadImg: async function () {
      let _this = this;
      //构造formData对象
      let formData = new FormData();
      formData.append("file", document.getElementById(_this.uniqueId).files[0]);

      try {
        //调用上传文件接口
        uploadBasketPic(formData).then(res => {
          debugger;
          //返回上传文件的地址
          let url = res.url;
          if (url != null && url.length > 0) {
            let Range = _this.editor.getSelection();
            url = url.indexOf("http") !== -1 ? url : "http:" + url;
            //上传文件成功之后在富文本中回显(显示)
            _this.editor.insertEmbed(
              Range != null ? Range.index : 0,
              "image",
              url
            );
          } else {
            _this.$message.warning("图片上传失败");
          }
          //成功之后,将文件的文本框的value置空
          document.getElementById(_this.uniqueId).value = "";
        });
      } catch ({message: msg}) {
        document.getElementById(_this.uniqueId).value = "";
        _this.$message.warning(msg);
      }
    }

  },
  created() {
  },
  mounted() {
    let _this = this;

    //构造一个工具栏图片按钮被点击时的处理函数
    let imgHandler = async function (image) {
      if (image) {
        let fileInput = document.getElementById(_this.uniqueId); //获取隐藏的file文本ID对应document对象
        fileInput.click(); //触发document对象的点击事件
      }
    };
    //将处理函数绑定到工具栏的image图标上
    _this.editor.getModule("toolbar").addHandler("image", imgHandler);
    this.$nextTick(() => {
      //为工具栏的所有图标按钮添加鼠标悬停时的文字提示
      addQuillTitle();
    });
  }
}


</script>

<style>
/*.editor 自定义的样式,可以自己控制富文本窗体大小*/
.editor {
  line-height: normal !important;
  height: 200px;
}

/*以下样式是为了给工具栏汉化处理*/
.ql-snow .ql-tooltip[data-mode="link"]::before {
  content: "请输入链接地址:";
}

.ql-snow .ql-tooltip.ql-editing a.ql-action::after {
  border-right: 0px;
  content: "保存";
  padding-right: 0px;
}
.ql-snow .ql-tooltip[data-mode="video"]::before {
  content: "请输入视频地址:";
}

.ql-snow .ql-picker.ql-size .ql-picker-label::before,
.ql-snow .ql-picker.ql-size .ql-picker-item::before {
  content: "14px";
}

.ql-snow .ql-picker.ql-size .ql-picker-label[data-value="small"]::before,
.ql-snow .ql-picker.ql-size .ql-picker-item[data-value="small"]::before {
  content: "10px";
}

.ql-snow .ql-picker.ql-size .ql-picker-label[data-value="large"]::before,
.ql-snow .ql-picker.ql-size .ql-picker-item[data-value="large"]::before {
  content: "18px";
}

.ql-snow .ql-picker.ql-size .ql-picker-label[data-value="huge"]::before,
.ql-snow .ql-picker.ql-size .ql-picker-item[data-value="huge"]::before {
  content: "32px";
}

.ql-snow .ql-picker.ql-header .ql-picker-label::before,
.ql-snow .ql-picker.ql-header .ql-picker-item::before {
  content: "文本";
}

.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="1"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="1"]::before {
  content: "标题1";
}

.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="2"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="2"]::before {
  content: "标题2";
}

.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="3"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="3"]::before {
  content: "标题3";
}

.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="4"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="4"]::before {
  content: "标题4";
}

.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="5"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="5"]::before {
  content: "标题5";
}

.ql-snow .ql-picker.ql-header .ql-picker-label[data-value="6"]::before,
.ql-snow .ql-picker.ql-header .ql-picker-item[data-value="6"]::before {
  content: "标题6";
}

.ql-snow .ql-picker.ql-font .ql-picker-label::before,
.ql-snow .ql-picker.ql-font .ql-picker-item::before {
  content: "标准字体";
}

.ql-snow .ql-picker.ql-font .ql-picker-label[data-value="serif"]::before,
.ql-snow .ql-picker.ql-font .ql-picker-item[data-value="serif"]::before {
  content: "衬线字体";
}

.ql-snow .ql-picker.ql-font .ql-picker-label[data-value="monospace"]::before,
.ql-snow .ql-picker.ql-font .ql-picker-item[data-value="monospace"]::before {
  content: "等宽字体";
}

/*.ql-snow .ql-picker.ql-font .ql-picker-label[data-value="Microsoft YaHei"]::before,*/
/*.ql-snow .ql-picker.ql-font .ql-picker-item[data-value="Microsoft YaHei"]::before {*/
/*  content: '微软雅黑';*/
/*}*/
/*.ql-snow .ql-picker.ql-font .ql-picker-label[data-value="SimSun"]::before,*/
/*.ql-snow .ql-picker.ql-font .ql-picker-item[data-value="SimSun"]::before {*/
/*  content: "宋体";*/
/*}*/
/*.ql-snow .ql-picker.ql-font .ql-picker-label[data-value="SimHei"]::before,*/
/*.ql-snow .ql-picker.ql-font .ql-picker-item[data-value="SimHei"]::before {*/
/*  content: "黑体";*/
/*}*/
/*.ql-snow .ql-picker.ql-font .ql-picker-label[data-value="KaiTi"]::before,*/
/*.ql-snow .ql-picker.ql-font .ql-picker-item[data-value="KaiTi"]::before {*/
/*  content: "楷体";*/
/*}*/
</style>