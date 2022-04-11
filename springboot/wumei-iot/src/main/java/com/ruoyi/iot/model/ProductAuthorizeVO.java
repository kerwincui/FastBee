package com.ruoyi.iot.model;

/**
 * 批量新增产品授权码VO
 *
 * @author Venus Zhang
 * @create 2022-04-11 15:04
 */

public class ProductAuthorizeVO {

	private Long productId;
	private int createNum;

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public int getCreateNum() {
		return createNum;
	}

	public void setCreateNum(int createNum) {
		this.createNum = createNum;
	}
}
