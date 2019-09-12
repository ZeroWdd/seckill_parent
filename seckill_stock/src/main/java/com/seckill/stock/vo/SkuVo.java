package com.seckill.stock.vo;

import com.seckill.stock.pojo.Sku;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;

/**
 * @Auther: wdd
 * @Date: 2019/9/8 18:59
 * @Description:
 */
public class SkuVo extends Sku implements Serializable {
    private String description;
    private String special_spec;

    private BigInteger limitPrice;
    private BigInteger limitQuanty;
    private Date limitBeginTime;
    private Date limitEndTime;
    private Date nowTime;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSpecial_spec() {
        return special_spec;
    }

    public void setSpecial_spec(String special_spec) {
        this.special_spec = special_spec;
    }

    public BigInteger getLimitPrice() {
        return limitPrice;
    }

    public void setLimitPrice(BigInteger limitPrice) {
        this.limitPrice = limitPrice;
    }

    public BigInteger getLimitQuanty() {
        return limitQuanty;
    }

    public void setLimitQuanty(BigInteger limitQuanty) {
        this.limitQuanty = limitQuanty;
    }

    public Date getLimitBeginTime() {
        return limitBeginTime;
    }

    public void setLimitBeginTime(Date limitBeginTime) {
        this.limitBeginTime = limitBeginTime;
    }

    public Date getLimitEndTime() {
        return limitEndTime;
    }

    public void setLimitEndTime(Date limitEndTime) {
        this.limitEndTime = limitEndTime;
    }

    public Date getNowTime() {
        return nowTime;
    }

    public void setNowTime(Date nowTime) {
        this.nowTime = nowTime;
    }
}
