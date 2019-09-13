package com.seckill.order.queue;

import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @Auther: wdd
 * @Date: 2019/9/13 10:47
 * @Description:
 */
@Configuration
public class MQConfig {
    @Bean
    public Queue queueStorage(){
        return new Queue("order_queue",true);
    }
}
