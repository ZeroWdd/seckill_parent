package com.seckill.order.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.fasterxml.jackson.annotation.JacksonAnnotationsInside;
import com.seckill.order.dao.OrderDao;
import com.seckill.order.pojo.Order;
import com.seckill.order.pojo.OrderDetail;
import com.seckill.order.vo.OrderVo;
import com.seckill.stock.pojo.LimitPolicy;
import com.seckill.stock.vo.SkuVo;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import util.IdWorker;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.*;

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
    @Autowired
    private IdWorker idWorker;
    @Autowired
    private RabbitTemplate rabbitTemplate;

    public Map<String, Object> createOrder(String sku_id, BigInteger user_id) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        //1、判断sku_id
        if (sku_id==null||sku_id.equals("")){
            resultMap.put("result", false);
            resultMap.put("msg", "前端又传错了！");
            return resultMap;
        }
        //2、取redis政策
        //long nextId = idWorker.nextId();
        //BigInteger order_id = BigInteger.valueOf(nextId);
        long l = System.currentTimeMillis();
        BigInteger order_id = BigInteger.valueOf(l);
        LimitPolicy limitPolicy = (LimitPolicy) redisTemplate.opsForValue().get("LIMIT_POLICY_"+sku_id);
        if(!StringUtils.isEmpty(limitPolicy)){
            //3、开始时间小于等于当前时间，当前时间小于等于结束
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String now = restTemplate.getForObject("http://localhost:8000/getTime", String.class);
            try{
                Date begin_time = limitPolicy.getBegin_time();
                Date end_time = limitPolicy.getEnd_time();
                Date now_time = simpleDateFormat.parse(now);
                if (begin_time.getTime()<=now_time.getTime()&&now_time.getTime()<=end_time.getTime()){
                    int quanty = limitPolicy.getQuanty().intValue();
                    //4、redis计数器
                    if(redisTemplate.opsForValue().increment("SKU_QUANTY_"+sku_id,1)<=quanty){
                        //5、写入队列
                        //写入订单
                        SkuVo skuVo = (SkuVo) redisTemplate.opsForValue().get("SKU_" + sku_id);
                        Order order = new Order();
                        order.setOrder_id(order_id);
                        order.setTotal_fee(skuVo.getPrice());
                        order.setActual_fee(limitPolicy.getPrice());
                        order.setPost_fee(BigInteger.valueOf(0));
                        order.setPayment_type(0);
                        order.setUser_id(user_id);
                        order.setStatus(1);
                        order.setCreate_time(now_time);
                        //写入订单详情
                        OrderDetail orderDetail = new OrderDetail();
                        orderDetail.setOrder_id(order_id);
                        orderDetail.setSku_id(new BigInteger(sku_id));
                        orderDetail.setNum(1);
                        orderDetail.setTitle(skuVo.getTitle());
                        orderDetail.setOwn_spec(skuVo.getOwn_spec());
                        orderDetail.setPrice(limitPolicy.getPrice());
                        orderDetail.setImage(skuVo.getImages());
                        orderDetail.setCreate_time(now_time);
                        //放入map中
                        Map<String,Object> map = new HashMap<>();
                        map.put("order",order);
                        map.put("orderDetail",orderDetail);
                        try {
                            rabbitTemplate.convertAndSend("order_queue", map);
                        }catch (Exception e){
                            resultMap.put("result", false);
                            resultMap.put("msg", "写入队列异常！");
                            return resultMap;
                        }
                    }else{
                        //如果超出了计数器，返回商品已经售完了
                        resultMap.put("result", false);
                        resultMap.put("msg", "3亿9被踢回去了！");
                        return resultMap;
                    }
                }else {
                    //如果结束时间大于当前时间，返回活动已经过期
                    resultMap.put("result", false);
                    resultMap.put("msg", "活动已经过期！");
                    return resultMap;
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }else {
            //政策没有取出数，返回活动已经过期
            resultMap.put("result", false);
            resultMap.put("msg", "活动已经过期！");
            return resultMap;
        }
        //6、返回正常数据，带着订单号
        resultMap.put("result", true);
        resultMap.put("msg", "");
        resultMap.put("order_id", order_id);
        return resultMap;
    }

    @Transactional
    public Map<String, Object> insertOrder(Map<String, Object> orderInfo){
        Map<String, Object> map = new HashMap<String, Object>();
        if (orderInfo==null||orderInfo.isEmpty()){
            map.put("result", false);
            map.put("msg", "传入参数有误！");
            return map;
        }

        Order order = (Order) orderInfo.get("order");
        OrderDetail orderDetail = (OrderDetail) orderInfo.get("orderDetail");
        try {
            orderDao.insertOrder(order);
            orderDao.insertOrderDetail(orderDetail);
        }catch (Exception e){
            e.printStackTrace();
            map.put("result", false);
            map.put("msg", "订单写入失败！");
            return map;
        }

        map.put("result", true);
        map.put("msg", "");
        return map;
    }

    public Map<String, Object> getOrder(String order_id){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        if (order_id==null||order_id.equals("")){
            resultMap.put("result", false);
            resultMap.put("msg", "参数传入有误！");
            return resultMap;
        }

        List<OrderVo> list = orderDao.getOrder(order_id);
        resultMap.put("order", list.get(0));
        resultMap.put("result", true);
        resultMap.put("msg", "");
        return resultMap;
    }

    public Map<String, Object> payOrder(String order_id, String sku_id){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        if (order_id==null||order_id.equals("")){
            resultMap.put("result", false);
            resultMap.put("msg", "订单有误！");
            return resultMap;
        }

        int flag = orderDao.updateOrderStatus(order_id);

        if (flag != 1){
            resultMap.put("result", false);
            resultMap.put("msg", "订单状态更新失败！");
            return resultMap;
        }

        rabbitTemplate.convertAndSend("storage_queue", sku_id);

        resultMap.put("result", true);
        resultMap.put("msg", "");
        return resultMap;
    }

}
