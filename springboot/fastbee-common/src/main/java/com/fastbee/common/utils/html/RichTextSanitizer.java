package com.fastbee.common.utils.html;

import java.util.regex.Pattern;
import org.owasp.html.HtmlPolicyBuilder;
import org.owasp.html.PolicyFactory;

/**
 * 富文本白名单净化工具。
 *
 * <p>保留 Quill 编辑器常用的安全格式，删除脚本、事件属性、危险协议和未授权标签。</p>
 */
public final class RichTextSanitizer
{
    private static final Pattern IMAGE_DIMENSION_PATTERN = Pattern.compile("[0-9]{1,5}");
    private static final Pattern LINK_TARGET_PATTERN = Pattern.compile("(?i)_(?:blank|self)");

    /** Quill 输出的安全样式类，禁止通过任意 class 扩大前端样式能力。 */
    private static final Pattern QUIL_CLASS_PATTERN = Pattern.compile(
            "(?i)(?:ql-(?:align-(?:center|right|justify)|indent-[1-8]|size-(?:small|large|huge)|"
                    + "direction-rtl|font-(?:serif|monospace)|syntax))"
                    + "(?:\\s+ql-(?:align-(?:center|right|justify)|indent-[1-8]|size-(?:small|large|huge)|"
                    + "direction-rtl|font-(?:serif|monospace)|syntax))*");

    /**
     * 策略对象创建成本较高且本身不可变，所有请求复用同一实例。
     * 不允许 iframe、video、object、embed、svg 等主动内容。
     */
    private static final PolicyFactory POLICY = new HtmlPolicyBuilder()
            .allowCommonInlineFormattingElements()
            .allowCommonBlockElements()
            .allowStyling()
            .allowUrlProtocols("http", "https")
            .allowElements("a", "img", "br", "pre", "div", "span")
            .allowWithoutAttributes("a", "br", "span")
            .allowAttributes("href").onElements("a")
            .allowAttributes("target").matching(LINK_TARGET_PATTERN).onElements("a")
            .allowAttributes("alt", "src").onElements("img")
            .allowAttributes("height", "width").matching(IMAGE_DIMENSION_PATTERN).onElements("img")
            .allowAttributes("class")
            .matching(QUIL_CLASS_PATTERN)
            .onElements("p", "div", "pre", "ol", "ul", "li", "span")
            .requireRelNofollowOnLinks()
            .toFactory();

    private RichTextSanitizer()
    {
    }

    /**
     * 净化不可信富文本。
     *
     * @param html 待净化的富文本
     * @return 可安全嵌入 HTML 正文上下文的富文本
     */
    public static String sanitize(String html)
    {
        if (html == null || html.isEmpty())
        {
            return html;
        }
        return POLICY.sanitize(html);
    }
}
