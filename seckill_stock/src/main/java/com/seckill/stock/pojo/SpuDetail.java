package com.seckill.stock.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * @Auther: wdd
 * @Date: 2019/9/8 20:44
 * @Description:
 */

public class SpuDetail implements Serializable {

    private Integer spu_id;
    private String description;
    private String generic_spec;
    private String special_spec;
    private String packing_list;
    private String after_service;
    private Date create_time;
    private Date update_time;

    public Integer getSpu_id() {
        return spu_id;
    }

    public void setSpu_id(Integer spu_id) {
        this.spu_id = spu_id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getGeneric_spec() {
        return generic_spec;
    }

    public void setGeneric_spec(String generic_spec) {
        this.generic_spec = generic_spec;
    }

    public String getSpecial_spec() {
        return special_spec;
    }

    public void setSpecial_spec(String special_spec) {
        this.special_spec = special_spec;
    }

    public String getPacking_list() {
        return packing_list;
    }

    public void setPacking_list(String packing_list) {
        this.packing_list = packing_list;
    }

    public String getAfter_service() {
        return after_service;
    }

    public void setAfter_service(String after_service) {
        this.after_service = after_service;
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
