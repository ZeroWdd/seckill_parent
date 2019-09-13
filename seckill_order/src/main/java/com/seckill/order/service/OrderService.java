package com.seckill.order.service;

import com.fasterxml.jackson.annotation.JacksonAnnotationsInside;
import com.seckill.order.dao.OrderDao;
import com.seckill.stock.pojo.LimitPolicy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * @Auther: wdd
 * @Date: 2019/9/12 19:55
 * @Description:
 */
@Service
public class OrderService {
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private RestTemplate restTemplate;

    public Map<String, Object> createOrder(String sku_id, BigInteger user_id) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        //1、判断sku_id
        if (sku_id==null||sku_id.equals("")){
            resultMap.put("result", false);
            resultMap.put("msg", "前端又传错了！");
            return resultMap;
        }
        //2、取redis政策
        LimitPolicy limitPolicy = (LimitPolicy) redisTemplate.opsForValue().get("LIMIT_POLICY_"+sku_id);
        if(!StringUtils.isEmpty(limitPolicy)){
            //3、开始时间小于等于当前时间，当前时间小于等于结束
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String now = restTemplate.getForObject("http://seckill-time:8000/getTime", String.class);
        }
        return null;
    }
}
