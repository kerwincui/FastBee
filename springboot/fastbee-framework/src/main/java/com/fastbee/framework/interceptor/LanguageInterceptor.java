package com.fastbee.framework.interceptor;

import com.fastbee.common.enums.Language;
import com.fastbee.common.utils.SecurityUtils;
import com.fastbee.common.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;

import static com.fastbee.common.constant.Constants.LANGUAGE;


/**
 * 国际化语言拦截器
 */
@Component
@Slf4j
public class LanguageInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String language = request.getHeader(LANGUAGE);
        if (StringUtils.isEmpty(language) || language.equals("undefined")
                || language.equals("")|| language.equals("null")){
            //针对有些接口没有增加语言字段，先去token获取
            language = SecurityUtils.getLanguage();
        }else if (!language.contains("-")){
           language = Language.matches(language);
        }
        // 前端传递的language必须是zh-CN格式的，中间的-必须要完整，不能只传递zh或en
        Locale locale = new Locale(language.split("-")[0],language.split("-")[1]);
        // 这样赋值以后，MessageUtils.message方法就不用修改了
        LocaleContextHolder.setLocale(locale);
        return true;
    }

    /**
     * 请求处理之后进行调用，但是在视图被渲染之前（Controller方法调用之后）
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
    }

    /**
     * 在整个请求结束之后被调用，也就是在DispatcherServlet 渲染了对应的视图之后执行（主要是用于进行资源清理工作）
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
    }


}
