<template>
  <component :is="inline ? 'span' : 'div'" v-html="safeHtml"></component>
</template>

<script>
import { sanitizeDisplayHtml, sanitizeRichText } from '@/utils/security';

export default {
  name: 'SafeHtml',
  props: {
    html: {
      type: [String, Number],
      default: '',
    },
    mode: {
      type: String,
      default: 'display',
    },
    inline: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    safeHtml() {
      return this.mode === 'richText' ? sanitizeRichText(this.html) : sanitizeDisplayHtml(this.html);
    },
  },
};
</script>
