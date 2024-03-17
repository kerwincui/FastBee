package com.fastbee.iot.service.impl;

import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.domain.entity.SysRole;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Product;
import com.fastbee.iot.domain.ThingsModelTemplate;
import com.fastbee.iot.mapper.DeviceMapper;
import com.fastbee.iot.mapper.ProductAuthorizeMapper;
import com.fastbee.iot.mapper.ProductMapper;
import com.fastbee.iot.model.ChangeProductStatusModel;
import com.fastbee.iot.model.IdAndName;
import com.fastbee.iot.model.ImportThingsModelInput;
import com.fastbee.iot.model.ProductCode;
import com.fastbee.iot.service.IProductService;
import com.fastbee.iot.service.IThingsModelTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.fastbee.common.utils.SecurityUtils.getLoginUser;

/**
 * 产品Service业务层处理
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class ProductServiceImpl implements IProductService
{

    @Autowired
    private ThingsModelServiceImpl thingsModelService;

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private ProductAuthorizeMapper productAuthorizeMapper;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private ToolServiceImpl toolService;

    @Autowired
    private DeviceMapper deviceMapper;

    @Autowired
    private IThingsModelTemplateService modelTemplateService;

    @Autowired
    @Lazy
    private DeviceServiceImpl deviceService;

    /**
     * 查询产品
     *
     * @param productId 产品主键
     * @return 产品
     */
    @Override
    public Product selectProductByProductId(Long productId)
    {
        return productMapper.selectProductByProductId(productId);
    }

    /**
     * 查询产品列表
     *
     * @param product 产品
     * @return 产品
     */
    @Override
    public List<Product> selectProductList(Product product)
    {
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles=user.getRoles();
        // 租户
        if(roles.stream().anyMatch(a->a.getRoleKey().equals("tenant"))){
            product.setTenantId(user.getUserId());
        }
        return productMapper.selectProductList(product);
    }

    /**
     * 查询产品简短列表
     *
     * @return 产品
     */
    @Override
    public List<IdAndName> selectProductShortList()
    {
        Product product =new Product();
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles=user.getRoles();
        // 租户
        if(roles.stream().anyMatch(a->a.getRoleKey().equals("tenant"))){
            product.setTenantId(user.getUserId());
        }
        return productMapper.selectProductShortList(product);
    }

    /**
     * 新增产品
     *
     * @param product 产品
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Product insertProduct(Product product)
    {
        // 判断是否为管理员
        product.setIsSys(1);
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles=user.getRoles();
        for(int i=0;i<roles.size();i++){
            if(roles.get(i).getRoleKey().equals("tenant") || roles.get(i).getRoleKey().equals("general")){
                product.setIsSys(0);
                break;
            }
        }
        // mqtt账号密码
        if(product.getMqttAccount()==null || product.getMqttAccount().equals("")){
            product.setMqttAccount("FastBee");
        }
        if(product.getMqttPassword()==null || product.getMqttPassword().equals("")){
            product.setMqttPassword("P"+toolService.getStringRandom(15));
        }
        if(product.getMqttSecret()==null || product.getMqttSecret().equals("")){
            product.setMqttSecret("K"+toolService.getStringRandom(15));
        }
        product.setStatus(product.getStatus()==null?1:product.getStatus());
        product.setTenantId(user.getUserId());
        product.setTenantName(user.getUserName());
        product.setCreateTime(DateUtils.getNowDate());
        productMapper.insertProduct(product);
        /*如果产品属于modbus协议（云端轮询）需要记录变量模板与产品关系*/
        if (product.getTemplateId()!= null){

            //将模板物模型导入到物模型表
            List<ThingsModelTemplate> thingsModelTemplates = modelTemplateService.selectAllByTemplateId(product.getTemplateId());
            Long[] ids = thingsModelTemplates.stream().map(ThingsModelTemplate::getTemplateId).toArray(Long[]::new);
            ImportThingsModelInput input = new ImportThingsModelInput();
            input.setTemplateIds(ids);
            input.setProductId(product.getProductId());
            input.setProductName(product.getProductName());
            thingsModelService.importByTemplateIds(input);
        }
        return product;
    }

    /**
     * 修改产品
     *
     * @param product 产品
     * @return 结果
     */
    @Override
    public int updateProduct(Product product)
    {
        product.setUpdateTime(DateUtils.getNowDate());
        return productMapper.updateProduct(product);
    }

    /**
     * 获取产品下面的设备数量
     *
     * @param productId 产品ID
     * @return 结果
     */
    @Override
    public int selectDeviceCountByProductId(Long productId)
    {
        return deviceMapper.selectDeviceCountByProductId(productId);
    }

    /**
     * 更新产品状态,1-未发布，2-已发布
     *
     * @param model
     * @return 结果
     */
    @Override
    @Transactional
    public AjaxResult changeProductStatus(ChangeProductStatusModel model)
    {
        if(model.getStatus()!=1 && model.getStatus()!=2){
            return AjaxResult.error("状态更新失败,状态值有误");
        }
        if(model.getStatus()==2){
            // 产品下必须包含物模型
            int thingsCount=productMapper.thingsCountInProduct(model.getProductId());
            if(thingsCount==0 && model.getDeviceType() !=3){
                return AjaxResult.error("发布失败，请先添加产品的物模型");
            } else if (thingsCount > 0){
                // 批量更新产品下所有设备的物模型值
                updateDeviceStatusByProductIdAsync(model.getProductId());
            }
            // TODO 增加modbus之后，产品下子设备的物模型唯一
            //int repeatCount=productMapper.thingsRepeatCountInProduct(model.getProductId());
            //if(repeatCount>1){
            //    return AjaxResult.error("发布失败，产品物模型的标识符必须唯一");
            //}
        }
        if(productMapper.changeProductStatus(model)>0){
            return AjaxResult.success("操作成功");
        }
        return AjaxResult.error("状态更新失败");
    }

    /***
     * 更新产品下所有设备的物模型值
     * @param productId
     */
    @Async
    public void updateDeviceStatusByProductIdAsync(Long productId){
        List<String> deviceNumbers=deviceMapper.selectSerialNumberByProductId(productId);
        deviceNumbers.forEach(x->{
            // 缓存新的物模型值
            deviceService.cacheDeviceStatus(productId,x);
        });
    }

    /**
     * 批量删除产品
     *
     * @param productIds 需要删除的产品主键
     * @return 结果
     */
    @Override
    @Transactional
    public AjaxResult deleteProductByProductIds(Long[] productIds)
    {
        // 删除物模型JSON缓存
        for(int i=0;i<productIds.length;i++){
            String key = RedisKeyBuilder.buildTSLCacheKey(productIds[i]);
            redisCache.deleteObject(key);
        }
        // 产品下不能有设备
        int deviceCount=productMapper.deviceCountInProducts(productIds);
        if(deviceCount>0){
            return AjaxResult.error("删除失败，请先删除对应产品下的设备");
        }
        // 删除产品物模型
        productMapper.deleteProductThingsModelByProductIds(productIds);
        // 删除产品的授权码
        productAuthorizeMapper.deleteProductAuthorizeByProductIds(productIds);
        // 删除产品
        if(productMapper.deleteProductByProductIds(productIds)>0){
            return AjaxResult.success("删除成功");
        }
        return AjaxResult.error("删除失败");
    }


    /**
     * 删除产品信息
     *
     * @param productId 产品主键
     * @return 结果
     */
    @Override
    public int deleteProductByProductId(Long productId)
    {
        // 删除物模型JSON缓存
        redisCache.deleteObject(RedisKeyBuilder.buildTSLCacheKey(productId));
        return productMapper.deleteProductByProductId(productId);
    }

    /**
     * 根据设备编号查询产品信息
     * @param serialNumber 设备编号
     * @return 结果
     */
    @Override
    public Product getProductBySerialNumber(String serialNumber){
        return productMapper.getProductBySerialNumber(serialNumber);
    }

    /**
     * 根据设备编号查询协议编号
     * @param serialNumber 设备编号
     * @return 协议编号
     */
    @Override
    public ProductCode getProtocolBySerialNumber(String serialNumber){
        return productMapper.getProtocolBySerialNumber(serialNumber);
    }

    /**
     * 根据产品id获取协议编号
     * @param productId 产品id
     * @return 协议编号
     */
    @Override
    public String getProtocolByProductId(Long productId){
        return productMapper.getProtocolByProductId(productId);
    }


    /**
     * 根据模板id查询所有使用的产品
     * @param templeId 模板id
     * @return
     */
    @Override
    public List<Product> selectByTempleId(Long templeId){
        return productMapper.selectByTempleId(templeId);
    }
}
