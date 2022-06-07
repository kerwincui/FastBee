package com.ruoyi.iot.mapper;

import com.ruoyi.iot.domain.Product;
import com.ruoyi.iot.model.ChangeProductStatusModel;
import com.ruoyi.iot.model.IdAndName;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 产品Mapper接口
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@Repository
public interface ProductMapper 
{
    /**
     * 查询产品
     * 
     * @param productId 产品主键
     * @return 产品
     */
    public Product selectProductByProductId(Long productId);

    /**
     * 查询产品列表
     * 
     * @param product 产品
     * @return 产品集合
     */
    public List<Product> selectProductList(Product product);

    /**
     * 查询产品简短列表
     *
     * @param product 产品
     * @return 产品集合
     */
    public List<IdAndName> selectProductShortList(Product product);

    /**
     * 新增产品
     * 
     * @param product 产品
     * @return 结果
     */
    public int insertProduct(Product product);

    /**
     * 修改产品
     * 
     * @param product 产品
     * @return 结果
     */
    public int updateProduct(Product product);

    /**
     * 更新产品状态，1-未发布，2-已发布
     *
     * @param model
     * @return 结果
     */
    public int changeProductStatus(ChangeProductStatusModel model);

    /**
     * 修改物模型JSON
     *
     * @param product 产品
     * @return 结果
     */
    public int updateThingsModelJson(Product product);

    /**
     * 删除产品
     * 
     * @param productId 产品主键
     * @return 结果
     */
    public int deleteProductByProductId(Long productId);

    /**
     * 批量删除产品
     * 
     * @param productIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteProductByProductIds(Long[] productIds);

    /**
     * 批量删除产品物模型
     *
     * @param productIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteProductThingsModelByProductIds(Long[] productIds);

    /**
     * 产品下的固件数量
     * @param productIds 需要删除的数据主键集合
     * @return 结果
     */
    public int firmwareCountInProducts(Long[] productIds);

    /**
     * 产品下的设备数量
     * @param productIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deviceCountInProducts(Long[] productIds);

    /**
     * 产品下的物模型数量
     * @param productId 需要删除的数据主键集合
     * @return 结果
     */
    public int thingsCountInProduct(Long productId);

    /**
     * 产品下的物模型标识符重复数
     * @param productId 需要删除的数据主键集合
     * @return 结果
     */
    public int thingsRepeatCountInProduct(Long productId);
}
