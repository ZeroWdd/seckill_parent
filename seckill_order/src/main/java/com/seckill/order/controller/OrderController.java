package com.seckill.order.controller;

import com.alibaba.fastjson.JSONObject;
import com.seckill.order.service.OrderService;
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
        BigInteger user_id = (BigInteger) userMap.get("user_id");
        return orderService.createOrder(sku_id, user_id);
    }
}
