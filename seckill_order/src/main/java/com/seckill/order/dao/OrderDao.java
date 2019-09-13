package com.seckill.order.dao;

import com.seckill.order.pojo.Order;
import com.seckill.order.pojo.OrderDetail;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

/**
 * @Auther: wdd
 * @Date: 2019/9/12 19:56
 * @Description:
 */
@Mapper
public interface OrderDao {
    @Insert("insert into tb_order (order_id, total_fee, actual_fee, post_fee, payment_type, user_id, status, create_time) " +
            "values (#{order_id}, #{total_fee}, #{actual_fee}, #{post_fee}, #{payment_type}, #{user_id}, #{status}, #{create_time})")
    void insertOrder(Order order);

    @Insert("INSERT INTO tb_order_detail (order_id, sku_id, num, title, own_spec, price, image, create_time) " +
            "VALUES (#{order_id}, #{sku_id}, #{num}, #{title}, #{own_spec}, #{price}, #{image}, #{create_time})")
    void insertOrderDetail(OrderDetail orderDetail);
}
