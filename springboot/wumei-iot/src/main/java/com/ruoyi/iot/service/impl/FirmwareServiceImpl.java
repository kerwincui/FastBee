package com.ruoyi.iot.service.impl;

import java.util.List;

import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.iot.mapper.FirmwareMapper;
import com.ruoyi.iot.domain.Firmware;
import com.ruoyi.iot.service.IFirmwareService;

import static com.ruoyi.common.utils.SecurityUtils.getLoginUser;

/**
 * 产品固件Service业务层处理
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class FirmwareServiceImpl implements IFirmwareService 
{
    @Autowired
    private FirmwareMapper firmwareMapper;

    /**
     * 查询产品固件
     * 
     * @param firmwareId 产品固件主键
     * @return 产品固件
     */
    @Override
    public Firmware selectFirmwareByFirmwareId(Long firmwareId)
    {
        return firmwareMapper.selectFirmwareByFirmwareId(firmwareId);
    }

    /**
     * 查询设备最新固件
     *
     * @param deviceId 产品固件主键
     * @return 产品固件
     */
    @Override
    public Firmware selectLatestFirmware(Long deviceId)
    {
        return firmwareMapper.selectLatestFirmware(deviceId);
    }

    /**
     * 查询产品固件列表
     * 
     * @param firmware 产品固件
     * @return 产品固件
     */
    @Override
    public List<Firmware> selectFirmwareList(Firmware firmware)
    {
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles=user.getRoles();
        // 租户
        if(roles.stream().anyMatch(a->a.getRoleKey().equals("tenant"))){
            firmware.setTenantId(user.getUserId());
        }
        return firmwareMapper.selectFirmwareList(firmware);
    }

    /**
     * 新增产品固件
     * 
     * @param firmware 产品固件
     * @return 结果
     */
    @Override
    public int insertFirmware(Firmware firmware)
    {
        // 判断是否为管理员
        firmware.setIsSys(1);
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles=user.getRoles();
        for(int i=0;i<roles.size();i++){
            if(roles.get(i).getRoleKey().equals("tenant") || roles.get(i).getRoleKey().equals("general")){
                firmware.setIsSys(0);
                break;
            }
        }
        firmware.setTenantId(user.getUserId());
        firmware.setTenantName(user.getUserName());
        firmware.setCreateTime(DateUtils.getNowDate());
        return firmwareMapper.insertFirmware(firmware);
    }

    /**
     * 修改产品固件
     * 
     * @param firmware 产品固件
     * @return 结果
     */
    @Override
    public int updateFirmware(Firmware firmware)
    {
        firmware.setUpdateTime(DateUtils.getNowDate());
        return firmwareMapper.updateFirmware(firmware);
    }

    /**
     * 批量删除产品固件
     * 
     * @param firmwareIds 需要删除的产品固件主键
     * @return 结果
     */
    @Override
    public int deleteFirmwareByFirmwareIds(Long[] firmwareIds)
    {
        return firmwareMapper.deleteFirmwareByFirmwareIds(firmwareIds);
    }

    /**
     * 删除产品固件信息
     * 
     * @param firmwareId 产品固件主键
     * @return 结果
     */
    @Override
    public int deleteFirmwareByFirmwareId(Long firmwareId)
    {
        return firmwareMapper.deleteFirmwareByFirmwareId(firmwareId);
    }
}
