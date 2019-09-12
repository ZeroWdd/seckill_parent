package com.seckill.storage.pojo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;

/**
 * @Auther: wdd
 * @Date: 2019/9/10 10:51
 * @Description:
 */
public class Storage implements Serializable {
    private BigInteger id;
    private BigInteger warehouse_id;
    private BigInteger sku_id;
    private Double quanty;

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getWarehouse_id() {
        return warehouse_id;
    }

    public void setWarehouse_id(BigInteger warehouse_id) {
        this.warehouse_id = warehouse_id;
    }

    public BigInteger getSku_id() {
        return sku_id;
    }

    public void setSku_id(BigInteger sku_id) {
        this.sku_id = sku_id;
    }

    public Double getQuanty() {
        return quanty;
    }

    public void setQuanty(Double quanty) {
        this.quanty = quanty;
    }
}
