package com.fastbee.iot.service;

import java.util.List;
import com.fastbee.iot.domain.ProductAuthorize;
import com.fastbee.iot.model.ProductAuthorizeVO;

/**
 * 产品授权码Service接口
 *
 * @author kami
 * @date 2022-04-11
 */
public interface IProductAuthorizeService
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
     * 批量删除产品授权码
     *
     * @param authorizeIds 需要删除的产品授权码主键集合
     * @return 结果
     */
    public int deleteProductAuthorizeByAuthorizeIds(Long[] authorizeIds);

    /**
     * 删除产品授权码信息
     *
     * @param authorizeId 产品授权码主键
     * @return 结果
     */
    public int deleteProductAuthorizeByAuthorizeId(Long authorizeId);

    /**
     * 根据数量批量新增产品授权码
     * @param productAuthorizeVO
     * @return
     */
	public int addProductAuthorizeByNum(ProductAuthorizeVO productAuthorizeVO);

    /**
     * 根据产品id查询产品授权码
     * @param productId 产品id
     * @return
     */
    List<ProductAuthorize> listByProductId(Long productId);
}
