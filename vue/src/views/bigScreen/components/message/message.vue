<template>
  <div class="messages" v-if="visible">
    <svg fill="none" viewBox="0 0 16 16" width="1em" height="1em" class="message-icon">
      <path fill="currentColor" d="M15 8A7 7 0 101 8a7 7 0 0014 0zM8.5 4v5.5h-1V4h1zm-1.1 7h1.2v1.2H7.4V11z"
        fill-opacity="0.9" v-if="'warning'==type"></path>
    </svg>
    {{ text }}
  </div>
</template>

<script>
export default {
  data() {
    return {
      visible: false,
      text: "",
      type:'warning'
    };
  },
  props: {},
  created() { },

  mounted() { },
  methods: {
    init(param) {
      clearTimeout(this.timer);
      this.visible = true;
      this.text = param.text || "";
      this.type = param.type || "success";
      this.timer = setTimeout(() => {
        this.visible = false;
        clearTimeout(this.timer);
      }, 2000);
    },
  },
};
</script>
<style lang='scss' scoped>
.messages {
  position: fixed;
  min-width: 200px;
  top: 160px;
  left: 50%;
  transform: translate(-50%, 0);
  border: solid 1px #4b4b4b;
  //   box-shadow: 0 16px 24px rgba(0, 0, 0, 0.14), 0 6px 30px rgba(0, 0, 0, 12%),
  //     0 8px 10px rgba(0, 0, 0, 20%), inset 0 0.5px 0 #5e5e5e,
  //     inset 0.5px 0 0 #5e5e5e, inset 0 -0.5px 0 #5e5e5e, inset -0.5px 0 0 #5e5e5e;
  width: fit-content;
  border-radius: 6px;
  display: flex;
  align-items: center;
  z-index: 999;
  color: rgba(255, 255, 255, 0.9);
  background-color: #242424;
  line-height: 22px;
  font-size: 14px;
  padding: 13px 16px;

  .message-icon {
    color: #cf6e2d;
    font-size: 20px;
    margin-right: 8px;
    fill: currentColor;
  }
}
</style>