package com.seckill.order.vo;

import java.io.Serializable;
import java.math.BigInteger;

/**
 * @Auther: wdd
 * @Date: 2019/9/13 21:28
 * @Description:
 */
public class OrderVo implements Serializable {
    private BigInteger sku_id;
    private BigInteger order_id;
    private BigInteger price;

    public BigInteger getSku_id() {
        return sku_id;
    }

    public void setSku_id(BigInteger sku_id) {
        this.sku_id = sku_id;
    }

    public BigInteger getOrder_id() {
        return order_id;
    }

    public void setOrder_id(BigInteger order_id) {
        this.order_id = order_id;
    }

    public BigInteger getPrice() {
        return price;
    }

    public void setPrice(BigInteger price) {
        this.price = price;
    }
}
