package com.fastbee.data.controller.translate;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fastbee.common.core.domain.CommonResult;
import com.fastbee.common.core.domain.model.LoginUser;
import com.fastbee.common.core.page.TableDataInfo;
import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.utils.SecurityUtils;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.framework.web.service.TokenService;
import com.fastbee.system.domain.AppPreferences;
import com.fastbee.system.domain.vo.AppPreferencesVO;
import com.fastbee.system.service.IAppPreferencesService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;


/**
 * APP用户偏好设置Controller

 */
@RestController
@RequestMapping("/app/preferences")
@Api(tags = "APP用户偏好设置")
public class AppPreferencesController extends BaseController
{
    @Resource
    private IAppPreferencesService appPreferencesService;

    @Resource
    private TokenService tokenService;

    /**
     * 查询APP用户偏好设置列表
     */
    @PreAuthorize("@ss.hasPermi('iot:preferences:list')")
    @GetMapping("/list")
    public TableDataInfo list(AppPreferences appPreferences)
    {
        Page<AppPreferencesVO> voPage = appPreferencesService.pageAppPreferencesVO(appPreferences);
        return getDataTable(voPage.getRecords(), voPage.getTotal());
    }

    /**
     * 导出APP用户偏好设置列表
     */
    @PreAuthorize("@ss.hasPermi('iot:preferences:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, AppPreferences appPreferences)
    {
        Page<AppPreferencesVO> voPage = appPreferencesService.pageAppPreferencesVO(appPreferences);
        ExcelUtil<AppPreferencesVO> util = new ExcelUtil<AppPreferencesVO>(AppPreferencesVO.class);
        util.exportExcel(response, voPage.getRecords(), "APP用户偏好设置数据");
    }

    /**
     * 获取APP用户偏好设置详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:preferences:query')")
    @GetMapping(value = "/{userId}")
    public CommonResult getInfo(@PathVariable("userId") Long userId)
    {
        if (userId == null) {
            userId = SecurityUtils.getUserId();
        }
        return CommonResult.success(appPreferencesService.selectAppPreferencesByUserId(userId));
    }

    /**
     * 新增APP用户偏好设置
     */
    //@PreAuthorize("@ss.hasPermi('iot:preferences:add')")
    @PostMapping("/addOrUpdate")
    @ApiOperation("新增或者更新APP用户偏好设置")
    public CommonResult add(@RequestBody AppPreferences appPreferences)
    {
        LoginUser loginUser = getLoginUser();
        loginUser.setLanguage(appPreferences.getLanguage());
        tokenService.setLoginUser(loginUser);
        return CommonResult.success(appPreferencesService.addOrUpdate(appPreferences));
    }

    /**
     * 修改APP用户偏好设置
     */
    @PreAuthorize("@ss.hasPermi('iot:preferences:edit')")
    @PutMapping
    public CommonResult edit(@RequestBody AppPreferences appPreferences)
    {
        return CommonResult.success(appPreferencesService.updateAppPreferences(appPreferences));
    }

    /**
     * 删除APP用户偏好设置
     */
    @PreAuthorize("@ss.hasPermi('iot:preferences:remove')")
	@DeleteMapping("/{userIds}")
    public CommonResult remove(@PathVariable Long[] userIds)
    {
        return CommonResult.success(appPreferencesService.deleteAppPreferencesByUserIds(userIds));
    }
}
