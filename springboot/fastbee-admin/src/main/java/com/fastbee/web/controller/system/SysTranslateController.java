package com.fastbee.web.controller.system;

import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.common.utils.MessageUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.system.domain.SysTranslate;
import com.fastbee.system.service.ISysTranslateService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 翻译表管理
 *
 * @author ruoyi
 */
@Api(tags = "翻译表管理")
@RestController
@RequestMapping("/system/translate")
public class SysTranslateController extends BaseController
{
    @Autowired
    private ISysTranslateService sysTranslateService;

    /**
     * 导入翻译列表
     */
    @ApiOperation("导入翻译列表")
    @PreAuthorize("@ss.hasPermi('system:translate:import')")
    @PostMapping("/import")
    public AjaxResult importSysTranslate(MultipartFile file, String type, Long productId) throws Exception {
        if (null == file) {
            return error(MessageUtils.message("import.failed.file.null"));
        }
        if (StringUtils.isEmpty(type)) {
            return error();
        }
        ExcelUtil<SysTranslate> util = new ExcelUtil<>(SysTranslate.class);
        List<SysTranslate> list = util.importExcel(file.getInputStream());
        if (CollectionUtils.isEmpty(list)) {
            return error(MessageUtils.message("import.failed.data.null"));
        }
        sysTranslateService.importSysTranslate(list, type, productId);
        return success(MessageUtils.message("import.success"));
    }

    /**
     * 导出翻译列表
     */
    @ApiOperation("导出翻译列表")
    @PreAuthorize("@ss.hasPermi('system:translate:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysTranslate sysTranslate, String type, @RequestParam(name = "isSource", required = false, defaultValue = "0") Boolean isSource)
    {
        if (StringUtils.isEmpty(type)) {
            return;
        }
        List<SysTranslate> list;
        if (isSource) {
            list = sysTranslateService.selectSourceList(type, sysTranslate.getProductId());
        } else {
            list = sysTranslateService.selectSysTranslateList(sysTranslate, type);
        }
        ExcelUtil<SysTranslate> util = new ExcelUtil<>(SysTranslate.class);
        util.exportExcel(response, list, "翻译列表");
    }

}
