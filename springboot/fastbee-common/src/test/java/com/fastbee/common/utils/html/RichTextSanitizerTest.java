package com.fastbee.common.utils.html;

import org.junit.Assert;
import org.junit.Test;

/**
 * 富文本白名单净化测试。
 */
public class RichTextSanitizerTest
{
    @Test
    public void shouldRemoveExecutableContent()
    {
        String input = "<p onclick=\"alert(1)\">正文<script>alert(2)</script>"
                + "<img src=\"/profile/a.png\" onerror=\"alert(3)\"></p>";

        String sanitized = RichTextSanitizer.sanitize(input);

        Assert.assertTrue(sanitized.contains("正文"));
        Assert.assertFalse(sanitized.contains("<script"));
        Assert.assertFalse(sanitized.contains("onclick"));
        Assert.assertFalse(sanitized.contains("onerror"));
    }

    @Test
    public void shouldRemoveDangerousUrlsAndActiveElements()
    {
        String input = "<a href=\"javascript:alert(1)\">危险链接</a>"
                + "<iframe src=\"https://example.com\"></iframe>"
                + "<svg onload=\"alert(2)\"></svg>"
                + "<span style=\"background-image:url(javascript:alert(3))\">危险样式</span>";

        String sanitized = RichTextSanitizer.sanitize(input);

        Assert.assertTrue(sanitized.contains("危险链接"));
        Assert.assertFalse(sanitized.contains("javascript:"));
        Assert.assertFalse(sanitized.contains("<iframe"));
        Assert.assertFalse(sanitized.contains("<svg"));
        Assert.assertFalse(sanitized.contains("background-image"));
    }

    @Test
    public void shouldPreserveCommonQuillFormatting()
    {
        String input = "<h2>标题</h2><p class=\"ql-align-center\"><strong>正文</strong>"
                + "<span style=\"color: rgb(230, 0, 0);\">红色</span></p>"
                + "<ol><li class=\"ql-indent-1\">条目</li></ol>"
                + "<p><a href=\"https://example.com\" target=\"_blank\">链接</a>"
                + "<img src=\"/profile/a.png\" alt=\"图片\"></p>";

        String sanitized = RichTextSanitizer.sanitize(input);

        Assert.assertTrue(sanitized.contains("<h2>标题</h2>"));
        Assert.assertTrue(sanitized.contains("ql-align-center"));
        Assert.assertTrue(sanitized.contains("<strong>正文</strong>"));
        Assert.assertTrue(sanitized.contains("红色"));
        Assert.assertTrue(sanitized.contains("<ol>"));
        Assert.assertTrue(sanitized.contains("ql-indent-1"));
        Assert.assertTrue(sanitized.contains("https://example.com"));
        Assert.assertTrue(sanitized.contains("noopener"));
        Assert.assertTrue(sanitized.contains("noreferrer"));
        Assert.assertTrue(sanitized.contains("/profile/a.png"));
    }

    @Test
    public void shouldBeNullSafeAndIdempotent()
    {
        Assert.assertNull(RichTextSanitizer.sanitize(null));
        Assert.assertEquals("", RichTextSanitizer.sanitize(""));
        Assert.assertEquals("", RichTextSanitizer.sanitize("<script>alert(1)</script>"));

        String sanitized = RichTextSanitizer.sanitize("<p><em>正文</em></p>");
        Assert.assertEquals(sanitized, RichTextSanitizer.sanitize(sanitized));
    }
}
