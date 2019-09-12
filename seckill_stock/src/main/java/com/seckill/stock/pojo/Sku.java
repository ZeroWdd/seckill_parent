package com.seckill.stock.pojo;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;

/**
 * @Auther: wdd
 * @Date: 2019/9/8 12:35
 * @Description:
 */

public class Sku implements Serializable {
    private BigInteger sku_id;
    private BigInteger spu_id;
    private String title;
    private String images;
    private Integer stock;
    private BigInteger price;
    private String indexes;
    private String own_spec;
    private Integer enable;
    private Date create_time;
    private Date update_time;

    public BigInteger getSku_id() {
        return sku_id;
    }

    public void setSku_id(BigInteger sku_id) {
        this.sku_id = sku_id;
    }

    public BigInteger getSpu_id() {
        return spu_id;
    }

    public void setSpu_id(BigInteger spu_id) {
        this.spu_id = spu_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public BigInteger getPrice() {
        return price;
    }

    public void setPrice(BigInteger price) {
        this.price = price;
    }

    public String getIndexes() {
        return indexes;
    }

    public void setIndexes(String indexes) {
        this.indexes = indexes;
    }

    public String getOwn_spec() {
        return own_spec;
    }

    public void setOwn_spec(String own_spec) {
        this.own_spec = own_spec;
    }

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
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
