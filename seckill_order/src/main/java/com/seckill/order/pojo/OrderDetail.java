package com.seckill.order.pojo;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;

/**
 * @Auther: wdd
 * @Date: 2019/9/13 09:07
 * @Description:
 */
public class OrderDetail implements Serializable {
    private BigInteger id;
    private BigInteger order_id;
    private BigInteger sku_id;
    private Integer num;
    private String title;
    private String own_spec;
    private BigInteger price;
    private String image;
    private Date create_time;
    private Date update_time;

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public BigInteger getOrder_id() {
        return order_id;
    }

    public void setOrder_id(BigInteger order_id) {
        this.order_id = order_id;
    }

    public BigInteger getSku_id() {
        return sku_id;
    }

    public void setSku_id(BigInteger sku_id) {
        this.sku_id = sku_id;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getOwn_spec() {
        return own_spec;
    }

    public void setOwn_spec(String own_spec) {
        this.own_spec = own_spec;
    }

    public BigInteger getPrice() {
        return price;
    }

    public void setPrice(BigInteger price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }

    public Date getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Date update_time) {
        this.update_time = update_time;
    }
}
