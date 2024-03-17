package com.fastbee.iot.mapper;

import java.util.List;
import com.fastbee.iot.domain.ProductAuthorize;
import org.springframework.stereotype.Repository;

/**
 * 产品授权码Mapper接口
 *
 * @author kami
 * @date 2022-04-11
 */
@Repository
public interface ProductAuthorizeMapper
{
    /**
     * 查询产品授权码
     *
     * @param authorizeId 产品授权码主键
     * @return 产品授权码
     */
    public ProductAuthorize selectProductAuthorizeByAuthorizeId(Long authorizeId);

    /**
     * 查询产品授权码列表
     *
     * @param productAuthorize 产品授权码
     * @return 产品授权码集合
     */
    public List<ProductAuthorize> selectProductAuthorizeList(ProductAuthorize productAuthorize);

    /**
     * 新增产品授权码
     *
     * @param productAuthorize 产品授权码
     * @return 结果
     */
    public int insertProductAuthorize(ProductAuthorize productAuthorize);

    /**
     * 修改产品授权码
     *
     * @param productAuthorize 产品授权码
     * @return 结果
     */
    public int updateProductAuthorize(ProductAuthorize productAuthorize);

    /**
     * 删除产品授权码
     *
     * @param authorizeId 产品授权码主键
     * @return 结果
     */
    public int deleteProductAuthorizeByAuthorizeId(Long authorizeId);

    /**
     * 批量删除产品授权码
     *
     * @param authorizeIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteProductAuthorizeByAuthorizeIds(Long[] authorizeIds);

    /**
     * 通过产品ID批量删除产品授权码
     *
     * @param productIds 产品ID数组
     * @return 结果
     */
    public int deleteProductAuthorizeByProductIds(Long[] productIds);

    /**
     * 批量新增产品授权码
     * @param list
     * @return
     */
    public int insertBatchAuthorize(List<ProductAuthorize> list);

    /**
     * 根据授权码查询一条未绑定的授权码
     * @param authorize
     * @return
     */
    ProductAuthorize selectFirstAuthorizeByAuthorizeCode(ProductAuthorize authorize);

    /**
     * 根据产品id查询产品授权码
     * @param productId 产品id
     * @return
     */
    List<ProductAuthorize> selectProductAuthorizeListByProductId(Long productId);
}
