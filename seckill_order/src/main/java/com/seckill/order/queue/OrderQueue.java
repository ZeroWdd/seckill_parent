package com.seckill.order.queue;

import com.alibaba.fastjson.JSONObject;
import com.seckill.order.pojo.Order;
import com.seckill.order.service.OrderService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * @Auther: wdd
 * @Date: 2019/9/13 10:46
 * @Description:
 */
@Component
public class OrderQueue {
    @Autowired
    private OrderService orderService;

    @RabbitListener(queues = "order_queue")
    public void insertOrder(Map msg){
        //1、接收消息并输出
        System.out.println("order_queue接收消息："+msg);

        //2、调用一个写入订单方法

        Order order = (Order) msg.get("order");
        Map<String, Object> map = orderService.insertOrder(msg);

        //3、如果没写成功输出错误消息
        if (!(Boolean) map.get("result")){
            System.out.println("order_queue处理消息失败：");
        }

        //4、成功输出消息
        System.out.println("order_queue处理消息成功！");
    }
}
