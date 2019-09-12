package com.seckill.order.service;

import com.seckill.order.dao.OrderDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Auther: wdd
 * @Date: 2019/9/12 19:55
 * @Description:
 */
@Service
public class OrderService {
    @Autowired
    private OrderDao orderDao;
}
