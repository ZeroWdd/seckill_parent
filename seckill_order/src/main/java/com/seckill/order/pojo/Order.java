package com.seckill.order.pojo;

import java.util.Date;

/**
 * @Auther: wdd
 * @Date: 2019/9/12 19:58
 * @Description:
 */
public class Order {
    private Integer order_id;
    private Integer total_fee;
    private Integer actual_fee;
    private String promotion_ids;
    private Integer payment_type;
    private Integer post_fee;
    private Integer user_id;
    private Integer invoice_type;
    private Integer source_type;
    private Integer status;
    private Date create_time;

    public Integer getOrder_id() {
        return order_id;
    }

    public void setOrder_id(Integer order_id) {
        this.order_id = order_id;
    }

    public Integer getTotal_fee() {
        return total_fee;
    }

    public void setTotal_fee(Integer total_fee) {
        this.total_fee = total_fee;
    }

    public Integer getActual_fee() {
        return actual_fee;
    }

    public void setActual_fee(Integer actual_fee) {
        this.actual_fee = actual_fee;
    }

    public String getPromotion_ids() {
        return promotion_ids;
    }

    public void setPromotion_ids(String promotion_ids) {
        this.promotion_ids = promotion_ids;
    }

    public Integer getPayment_type() {
        return payment_type;
    }

    public void setPayment_type(Integer payment_type) {
        this.payment_type = payment_type;
    }

    public Integer getPost_fee() {
        return post_fee;
    }

    public void setPost_fee(Integer post_fee) {
        this.post_fee = post_fee;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Integer getInvoice_type() {
        return invoice_type;
    }

    public void setInvoice_type(Integer invoice_type) {
        this.invoice_type = invoice_type;
    }

    public Integer getSource_type() {
        return source_type;
    }

    public void setSource_type(Integer source_type) {
        this.source_type = source_type;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }
}
