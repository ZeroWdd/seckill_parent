package com.seckill.order.dao;

import com.seckill.order.pojo.Order;
import com.seckill.order.pojo.OrderDetail;
import com.seckill.order.vo.OrderVo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

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

    @Select("select d.sku_id, m.order_id, d.price " +
            "from tb_order m inner join tb_order_detail d on m.order_id = d.order_id " +
            "where m.order_id = #{order_id}")
    List<OrderVo> getOrder(String order_id);

    @Update("update tb_order set status = 2 where order_id = #{order_id}")
    int updateOrderStatus(String order_id);
}
