package com.seckill.order.pojo;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;

/**
 * @Auther: wdd
 * @Date: 2019/9/12 19:58
 * @Description:
 */
public class Order implements Serializable {
    private BigInteger order_id;
    private BigInteger total_fee;
    private BigInteger actual_fee;
    private String promotion_ids;
    private Integer payment_type;
    private BigInteger post_fee;
    private BigInteger user_id;
    private Integer invoice_type;
    private Integer source_type;
    private Integer status;
    private Date create_time;

    public BigInteger getOrder_id() {
        return order_id;
    }

    public void setOrder_id(BigInteger order_id) {
        this.order_id = order_id;
    }

    public BigInteger getTotal_fee() {
        return total_fee;
    }

    public void setTotal_fee(BigInteger total_fee) {
        this.total_fee = total_fee;
    }

    public BigInteger getActual_fee() {
        return actual_fee;
    }

    public void setActual_fee(BigInteger actual_fee) {
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

    public BigInteger getPost_fee() {
        return post_fee;
    }

    public void setPost_fee(BigInteger post_fee) {
        this.post_fee = post_fee;
    }

    public BigInteger getUser_id() {
        return user_id;
    }

    public void setUser_id(BigInteger user_id) {
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
