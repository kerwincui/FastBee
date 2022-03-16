package com.ruoyi.iot.model;

/**
 * id和name
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class ChangeProductStatusModel
{
    private Long productId;

    private Integer status;

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
