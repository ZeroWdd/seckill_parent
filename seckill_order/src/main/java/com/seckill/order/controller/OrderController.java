package com.seckill.order.controller;

import com.alibaba.fastjson.JSONObject;
import com.seckill.order.pojo.Order;
import com.seckill.order.service.OrderService;
import com.seckill.order.vo.OrderVo;
import com.seckill.stock.pojo.LimitPolicy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

/**
 * @Auther: wdd
 * @Date: 2019/9/12 19:55
 * @Description:
 */
@RestController
public class OrderController {
    @Autowired
    private OrderService orderService;

    @RequestMapping(value = "/createOrder/{sku_id}")
    public Map<String, Object> createOrder(@PathVariable("sku_id") String sku_id,HttpSession session){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String,Object> userMap = (Map<String, Object>) session.getAttribute("user");

        if (userMap==null){
            resultMap.put("result", false);
            resultMap.put("msg", "会员没有登录不能购买！");
            return resultMap;
        }
        Map<String,Object> map = JSONObject.parseObject(sku_id, Map.class);
        sku_id = (String) map.get("sku_id");
        BigInteger user_id = (BigInteger) userMap.get("user_id");
        return orderService.createOrder(sku_id, user_id);
    }

    @RequestMapping(value = "/getOrder/{order_id}")
    public Map<String, Object> getOrder(@PathVariable("order_id") String order_id){
        Map<String, Object> map = orderService.getOrder(order_id);
        OrderVo orderVo = (OrderVo) map.get("order");
        if(!(Boolean) map.get("result")){

        }
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("order_id",orderVo.getOrder_id());
        resultMap.put("price",orderVo.getPrice());
        resultMap.put("sku_id",orderVo.getSku_id());
        return resultMap;
    }

    @RequestMapping(value = "/payOrder/{order_id}/{sku_id}")
    public Map<String, Object> payOrder(@PathVariable("order_id") String order_id, @PathVariable("sku_id") String sku_id){
        //正常情况下在这里会调用支付接口，我们这里模拟支付已经返回正常数据
        boolean isPay = true;
        Map<String, Object> resultMap = new HashMap<String, Object>();
        if (!isPay){
            resultMap.put("result", false);
            resultMap.put("msg", "支付接口调用失败！");
            return resultMap;
        }

        return orderService.payOrder(order_id, sku_id);
    }
}
