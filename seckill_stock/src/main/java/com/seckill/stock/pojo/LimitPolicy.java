package com.seckill.stock.pojo;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;

/**
 * @Auther: wdd
 * @Date: 2019/9/9 17:36
 * @Description:
 */
public class LimitPolicy implements Serializable {
    private BigInteger id;
    private BigInteger sku_id;
    private BigInteger quanty;
    private BigInteger price;
    private Date begin_time;
    private Date end_time;

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getSku_id() {
        return sku_id;
    }

    public void setSku_id(BigInteger sku_id) {
        this.sku_id = sku_id;
    }

    public BigInteger getQuanty() {
        return quanty;
    }

    public void setQuanty(BigInteger quanty) {
        this.quanty = quanty;
    }

    public BigInteger getPrice() {
        return price;
    }

    public void setPrice(BigInteger price) {
        this.price = price;
    }

    public Date getBegin_time() {
        return begin_time;
    }

    public void setBegin_time(Date begin_time) {
        this.begin_time = begin_time;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }
}
